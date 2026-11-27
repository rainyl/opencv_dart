// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Web runtime: owns the Emscripten module instance and gives the generated bindings
// (lib/src/web/g) and the dart:ffi stand-in (ffi.dart) access to its exports and memory.
// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

JSObject? _module;
final _fns = <String, JSFunction?>{};

JSObject get module =>
    _module ?? (throw StateError('dartcv is not initialised on the web: await initDartcv() before using it'));

bool get isInitialized => _module != null;

void setModule(JSObject m) {
  _module = m;
  _fns.clear();
  _buffer = null;
}

/// Argument arrays for `Reflect.apply`, reused per arity: most OpenCV calls take five or more
/// arguments, and `callAsFunction` stops at four.
final _applyArgs = <int, JSArray<JSAny?>>{};

/// `Reflect.apply(target, thisArgument, argumentsList)`.
///
/// Not `target.apply(...)`: an Emscripten-exported function is a wasm function object, and in the
/// browser `Function.prototype.apply` on it runs the function with *no* arguments (verified on
/// Chrome 142 with dart2js; `fn.apply(null, [addr])` left the out-parameter untouched while
/// `Reflect.apply(fn, null, [addr])` wrote it). `Reflect.apply` goes through `[[Call]]` directly.
final _reflectApply = (globalContext['Reflect']! as JSObject)['apply']! as JSFunction;

/// Calls the exported C function [name] with already converted arguments.
JSAny? call(String name, List<JSAny?> args) {
  final fn = _fns.putIfAbsent(name, () {
    final f = module['_$name'];
    return f.isA<JSFunction>() ? f! as JSFunction : null;
  });
  if (fn == null) {
    throw UnsupportedError('$name is not available in this web build of dartcv (module not compiled in)');
  }
  return switch (args.length) {
    0 => fn.callAsFunction(),
    1 => fn.callAsFunction(null, args[0]),
    2 => fn.callAsFunction(null, args[0], args[1]),
    3 => fn.callAsFunction(null, args[0], args[1], args[2]),
    4 => fn.callAsFunction(null, args[0], args[1], args[2], args[3]),
    // `Reflect.apply` copies the arguments into the call when it dispatches, so sharing one array
    // per arity is safe even if the callee calls back into Dart (a listener callback, ...).
    _ => _apply(fn, args),
  };
}

JSAny? _apply(JSFunction fn, List<JSAny?> args) {
  final arr = _applyArgs.putIfAbsent(args.length, () => List<JSAny?>.filled(args.length, null).toJS);
  for (var k = 0; k < args.length; k++) {
    arr[k] = args[k];
  }
  return _reflectApply.callAsFunction(null, fn, null, arr);
}

bool hasSymbol(String name) => module.has('_$name');

// ---- argument / result conversion used by the generated bindings ----

JSNumber i(int v) => v.toJS;
JSNumber b(bool v) => (v ? 1 : 0).toJS;
JSNumber d(double v) => v.toJS;
JSBigInt j(int v) => _bigInt(v.toString());
int ri(JSAny? r) => (r! as JSNumber).toDartInt;
int ru(JSAny? r) => (r! as JSNumber).toDartInt & 0xFFFFFFFF;
bool rb(JSAny? r) => (r! as JSNumber).toDartInt != 0;
double rd(JSAny? r) => (r! as JSNumber).toDartDouble;
int rj(JSAny? r) => int.parse((r! as JSObject).callMethod<JSString>('toString'.toJS).toDart);

@JS('BigInt')
external JSBigInt _bigInt(String v);

// ---- memory ----

ByteBuffer? _buffer;
ByteData? _view;
Uint8List? _bytes;

void _refresh() {
  final buf = ((module['wasmMemory']! as JSObject)['buffer']! as JSArrayBuffer).toDart;
  _buffer = buf;
  _view = buf.asByteData();
  _bytes = buf.asUint8List();
}

/// The whole wasm heap. Views detach when memory grows, so never cache the result.
ByteBuffer get buffer {
  final b = _buffer;
  if (b == null || b.lengthInBytes == 0) _refresh();
  return _buffer!;
}

ByteData get view {
  final b = _buffer;
  if (b == null || b.lengthInBytes == 0) _refresh();
  return _view!;
}

Uint8List get bytes {
  final b = _buffer;
  if (b == null || b.lengthInBytes == 0) _refresh();
  return _bytes!;
}

int malloc(int size) {
  final p = ru(call('malloc', [(size == 0 ? 1 : size).toJS]));
  if (p == 0) throw StateError('dartcv web: out of memory allocating $size bytes');
  return p;
}

void free(int address) {
  if (address != 0) call('free', [address.toJS]);
}

// ---- scratch buffers ----

/// The generated bindings copy a by-value struct into wasm memory for the duration of one call.
/// Those buffers are short-lived and small, so recycle a few per size instead of paying a
/// malloc/free pair per call. Kept separate from [free]: that one is also called with memory C
/// allocated (`strdup`, ...), which must never enter this pool.
const _scratchMaxSize = 64;
const _scratchPerSize = 8;
final _scratchFree = <int, List<int>>{};

/// A buffer of [size] bytes, valid until the matching [releaseScratch].
int scratch(int size) {
  if (size > _scratchMaxSize) return malloc(size);
  final pool = _scratchFree[size];
  if (pool != null && pool.isNotEmpty) return pool.removeLast();
  return malloc(size);
}

void releaseScratch(int address, int size) {
  if (size > _scratchMaxSize) {
    free(address);
    return;
  }
  final pool = _scratchFree.putIfAbsent(size, () => <int>[]);
  if (pool.length < _scratchPerSize) {
    pool.add(address);
  } else {
    free(address);
  }
}

int cStringLength(int address) {
  final m = bytes;
  var end = address;
  while (m[end] != 0) {
    end++;
  }
  return end - address;
}

String readCString(int address, [int? length]) {
  final len = length ?? cStringLength(address);
  return utf8.decode(Uint8List.sublistView(bytes, address, address + len), allowMalformed: true);
}

// ---- function pointers ----

/// Table index -> JS function, for exported functions whose address Dart asked for.
final _tableFns = <int, JSFunction>{};
final _exportAddresses = <String, int>{};

/// The address (wasm table index) of the exported function [name], with wasm signature [sig].
int addressOf(String name, String sig) => _exportAddresses.putIfAbsent(name, () {
  final fn = module['_$name'];
  if (!fn.isA<JSFunction>()) {
    throw UnsupportedError('$name is not available in this web build of dartcv (module not compiled in)');
  }
  final idx = module.callMethod<JSNumber>('addFunction'.toJS, fn, sig.toJS).toDartInt;
  _tableFns[idx] = fn! as JSFunction;
  return idx;
});

/// Calls a one-argument function pointer previously obtained from [addressOf].
void callPointer1(int fnAddress, int arg) {
  final fn = _tableFns[fnAddress];
  if (fn == null) throw StateError('dartcv web: unknown function pointer $fnAddress');
  fn.callAsFunction(null, arg.toJS);
}

int addFunction(JSFunction fn, String sig) =>
    module.callMethod<JSNumber>('addFunction'.toJS, fn, sig.toJS).toDartInt;

void removeFunction(int index) => module.callMethod('removeFunction'.toJS, index.toJS);

/// Native function typedef -> (wasm signature, argument kinds, pointer builders), registered by the
/// generated bindings.
///
/// The third entry rebuilds a `Pointer` argument with the pointee type the callback declares: a
/// callback parameter is reified (`ffi.Pointer<CvStatus>`), and dart2js checks it on entry to the
/// closure, so handing it the shim's generic `Pointer<Void>` throws. Entries are null where the
/// declared pointee already is `ffi.Void`.
final callbackSignatures = <Type, (String, String, List<Object? Function(int)?>?)>{};

void registerCallback(
  Type nativeFunction,
  String wasmSig,
  String kinds, [
  List<Object? Function(int)?>? pointerArgs,
]) => callbackSignatures[nativeFunction] = (wasmSig, kinds, pointerArgs);
