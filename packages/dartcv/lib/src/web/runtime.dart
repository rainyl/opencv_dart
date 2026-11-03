// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Web runtime: owns the Emscripten module instance and gives the generated bindings
// (lib/src/g_web) and the dart:ffi stand-in (ffi.dart) access to its exports and memory.
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
    _ => fn.callMethodVarArgs('call'.toJS, [null, ...args]),
  };
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

/// Native function typedef -> (wasm signature, argument kinds), registered by the generated bindings.
final callbackSignatures = <Type, (String, String)>{};

void registerCallback(Type nativeFunction, String wasmSig, String kinds) =>
    callbackSignatures[nativeFunction] = (wasmSig, kinds);
