// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// A stand-in for the subset of `dart:ffi` that dartcv uses, backed by the memory of the
// Emscripten module (wasm32: pointers, `int`, `long` and `size_t` are 32 bit).
// lib/src/ffi.dart exports this library instead of dart:ffi when compiling for the web, so the
// hand-written bindings compile unchanged. Struct layouts come from the generated
// lib/src/g_web/*.g.dart files, which register themselves in initDartcv().
// ignore_for_file: public_member_api_docs, camel_case_types, non_constant_identifier_names

import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'runtime.dart' as rt;

abstract class NativeType {
  const NativeType();
}

abstract interface class SizedNativeType implements NativeType {}

abstract base class _Primitive extends NativeType implements SizedNativeType {
  const _Primitive();
}

final class Void extends NativeType {
  const Void();
}

final class Bool extends _Primitive {
  const Bool();
}

final class Int8 extends _Primitive {
  const Int8();
}

final class Int16 extends _Primitive {
  const Int16();
}

final class Int32 extends _Primitive {
  const Int32();
}

final class Int64 extends _Primitive {
  const Int64();
}

final class Uint8 extends _Primitive {
  const Uint8();
}

final class Uint16 extends _Primitive {
  const Uint16();
}

final class Uint32 extends _Primitive {
  const Uint32();
}

final class Uint64 extends _Primitive {
  const Uint64();
}

final class Float extends _Primitive {
  const Float();
}

final class Double extends _Primitive {
  const Double();
}

final class Char extends _Primitive {
  const Char();
}

final class SignedChar extends _Primitive {
  const SignedChar();
}

final class UnsignedChar extends _Primitive {
  const UnsignedChar();
}

final class Short extends _Primitive {
  const Short();
}

final class UnsignedShort extends _Primitive {
  const UnsignedShort();
}

final class Int extends _Primitive {
  const Int();
}

final class UnsignedInt extends _Primitive {
  const UnsignedInt();
}

final class Long extends _Primitive {
  const Long();
}

final class UnsignedLong extends _Primitive {
  const UnsignedLong();
}

final class LongLong extends _Primitive {
  const LongLong();
}

final class UnsignedLongLong extends _Primitive {
  const UnsignedLongLong();
}

final class Size extends _Primitive {
  const Size();
}

final class IntPtr extends _Primitive {
  const IntPtr();
}

final class UintPtr extends _Primitive {
  const UintPtr();
}

final class WChar extends _Primitive {
  const WChar();
}

abstract base class Opaque extends NativeType {}

final class NativeFunction<T extends Function> extends NativeType {}

abstract interface class Finalizable {}

final class Pointer<T extends NativeType> extends NativeType implements SizedNativeType {
  const Pointer.fromAddress(this.address);

  final int address;

  Pointer<U> cast<U extends NativeType>() => Pointer<U>.fromAddress(address);

  @override
  bool operator ==(Object other) => other is Pointer && other.address == address;

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() => 'Pointer: address=0x${address.toRadixString(16)}';
}

const Pointer<Never> nullptr = Pointer<Never>.fromAddress(0);

// ---- sizes ----

final _structs = <Type, (int, int, _Compound Function(ByteData? bytes, int offset))>{};

/// Called by the generated web bindings for every struct/union type.
void $registerStruct<T extends _Compound>(int size, int align, T Function(ByteData? bytes, int offset) f) =>
    _structs[T] = (size, align, (b, o) => f(b, o));

bool _isPointer<T>() => <T>[] is List<Pointer>;

int _primitiveSize(Type t) => switch (t) {
  const (Bool) ||
  const (Int8) ||
  const (Uint8) ||
  const (Char) ||
  const (SignedChar) ||
  const (UnsignedChar) => 1,
  const (Int16) || const (Uint16) || const (Short) || const (UnsignedShort) => 2,
  const (Int64) || const (Uint64) || const (LongLong) || const (UnsignedLongLong) || const (Double) => 8,
  const (Int32) ||
  const (Uint32) ||
  const (Int) ||
  const (UnsignedInt) ||
  const (Long) ||
  const (UnsignedLong) ||
  const (Size) ||
  const (IntPtr) ||
  const (UintPtr) ||
  const (Float) ||
  const (WChar) => 4,
  _ => -1,
};

int sizeOf<T extends SizedNativeType>() {
  if (_isPointer<T>()) return 4;
  final p = _primitiveSize(T);
  if (p > 0) return p;
  final s = _structs[T];
  if (s == null) throw UnsupportedError('dartcv web: unknown native type $T (was initDartcv() awaited?)');
  return s.$1;
}

// ---- allocation ----

abstract class Allocator {
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment});

  void free(Pointer pointer);
}

extension AllocatorAlloc on Allocator {
  Pointer<T> call<T extends SizedNativeType>([int count = 1]) => allocate<T>(sizeOf<T>() * count);
}

// ---- compounds ----

/// Base of the generated structs. Backed either by wasm memory (`$bytes == null`, `$offset` is
/// the address) or by Dart memory (struct values returned by value from C).
abstract base class _Compound extends NativeType {
  _Compound.$view(this.$bytes, this.$offset);

  final ByteData? $bytes;
  final int $offset;

  ByteData get _d => $bytes ?? rt.view;

  int $address() {
    if ($bytes != null) throw StateError('dartcv web: struct value has no address');
    return $offset;
  }

  int $i8(int o) => _d.getInt8($offset + o);
  int $u8(int o) => _d.getUint8($offset + o);
  int $i16(int o) => _d.getInt16($offset + o, Endian.little);
  int $u16(int o) => _d.getUint16($offset + o, Endian.little);
  int $i32(int o) => _d.getInt32($offset + o, Endian.little);
  int $u32(int o) => _d.getUint32($offset + o, Endian.little);
  int $i64(int o) => _d.getInt64($offset + o, Endian.little);
  double $f32(int o) => _d.getFloat32($offset + o, Endian.little);
  double $f64(int o) => _d.getFloat64($offset + o, Endian.little);
  void $si8(int o, int v) => _d.setInt8($offset + o, v);
  void $su8(int o, int v) => _d.setUint8($offset + o, v);
  void $si16(int o, int v) => _d.setInt16($offset + o, v, Endian.little);
  void $su16(int o, int v) => _d.setUint16($offset + o, v, Endian.little);
  void $si32(int o, int v) => _d.setInt32($offset + o, v, Endian.little);
  void $su32(int o, int v) => _d.setUint32($offset + o, v, Endian.little);
  void $si64(int o, int v) => _d.setInt64($offset + o, v, Endian.little);
  void $sf32(int o, double v) => _d.setFloat32($offset + o, v, Endian.little);
  void $sf64(int o, double v) => _d.setFloat64($offset + o, v, Endian.little);

  /// Copies [size] bytes of [src] to offset [o] of this compound.
  void $copyFrom(int o, _Compound src, int size) {
    final s = src._d, d = _d;
    for (var k = 0; k < size; k++) {
      d.setUint8($offset + o + k, s.getUint8(src.$offset + k));
    }
  }
}

abstract base class Struct extends _Compound implements SizedNativeType {
  Struct.$view(super.$bytes, super.$offset) : super.$view();
}

abstract base class Union extends _Compound implements SizedNativeType {
  Union.$view(super.$bytes, super.$offset) : super.$view();
}

/// Copies struct [s] (which may live in Dart memory) into a fresh wasm allocation of [size] bytes.
int $copyToWasm(_Compound s, int size) {
  final p = rt.malloc(size);
  final d = rt.view, src = s._d;
  for (var k = 0; k < size; k++) {
    d.setUint8(p + k, src.getUint8(s.$offset + k));
  }
  return p;
}

/// Copies [size] bytes at wasm [address] into Dart memory, for struct values returned by value.
ByteData $copyFromWasm(int address, int size) =>
    ByteData.sublistView(Uint8List.fromList(Uint8List.sublistView(rt.bytes, address, address + size)));

final class Array<T extends NativeType> extends NativeType {
  Array.$view(this._bytes, this._offset, this.length);

  final ByteData? _bytes;
  final int _offset;
  final int length;

  ByteData get _d => _bytes ?? rt.view;
}

extension SizeArray on Array<Size> {
  int operator [](int i) => _d.getUint32(_offset + i * 4, Endian.little);
  void operator []=(int i, int v) => _d.setUint32(_offset + i * 4, v, Endian.little);
}

extension IntArray on Array<Int> {
  int operator [](int i) => _d.getInt32(_offset + i * 4, Endian.little);
  void operator []=(int i, int v) => _d.setInt32(_offset + i * 4, v, Endian.little);
}

extension DoubleArray on Array<Double> {
  double operator [](int i) => _d.getFloat64(_offset + i * 8, Endian.little);
  void operator []=(int i, double v) => _d.setFloat64(_offset + i * 8, v, Endian.little);
}

extension StructPointer<T extends Struct> on Pointer<T> {
  T get ref {
    final s = _structs[T];
    if (s == null) throw UnsupportedError('dartcv web: unknown struct $T (was initDartcv() awaited?)');
    return s.$3(null, address) as T;
  }

  set ref(T value) => ref.$copyFrom(0, value, _structs[T]!.$1);

  T operator [](int index) {
    final s = _structs[T]!;
    return s.$3(null, address + index * s.$1) as T;
  }

  void operator []=(int index, T value) => this[index].$copyFrom(0, value, _structs[T]!.$1);

  Pointer<T> operator +(int offset) => Pointer<T>.fromAddress(address + offset * _structs[T]!.$1);
}

extension UnionPointer<T extends Union> on Pointer<T> {
  T get ref => _unionFactory<T>()(null, address);
}

T Function(ByteData?, int) _unionFactory<T>() {
  final s = _structs[T];
  if (s == null) throw UnsupportedError('dartcv web: unknown union $T');
  return (b, o) => s.$3(b, o) as T;
}

extension PointerPointer<T extends NativeType> on Pointer<Pointer<T>> {
  Pointer<T> get value => Pointer<T>.fromAddress(rt.view.getUint32(address, Endian.little));
  set value(Pointer<T> v) => rt.view.setUint32(address, v.address, Endian.little);
  Pointer<T> operator [](int i) => Pointer<T>.fromAddress(rt.view.getUint32(address + i * 4, Endian.little));
  void operator []=(int i, Pointer<T> v) => rt.view.setUint32(address + i * 4, v.address, Endian.little);
  Pointer<Pointer<T>> operator +(int offset) => Pointer.fromAddress(address + offset * 4);
}

// Primitive pointers. Each mirrors the dart:ffi extension of the same name.

ByteBuffer get _buf => rt.buffer;

extension BoolPointer on Pointer<Bool> {
  bool get value => rt.view.getUint8(address) != 0;
  set value(bool v) => rt.view.setUint8(address, v ? 1 : 0);
  bool operator [](int i) => rt.view.getUint8(address + i) != 0;
  void operator []=(int i, bool v) => rt.view.setUint8(address + i, v ? 1 : 0);
}

extension Int8Pointer on Pointer<Int8> {
  Pointer<Int8> operator +(int offset) => Pointer.fromAddress(address + offset * 1);
  int get value => rt.view.getInt8(address);
  set value(int v) => rt.view.setInt8(address, v);
  int operator [](int i) => rt.view.getInt8(address + i);
  void operator []=(int i, int v) => rt.view.setInt8(address + i, v);
  Int8List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asInt8List(address, length);
}

extension CharPointer on Pointer<Char> {
  int get value => rt.view.getInt8(address);
  set value(int v) => rt.view.setInt8(address, v);
  int operator [](int i) => rt.view.getInt8(address + i);
  void operator []=(int i, int v) => rt.view.setInt8(address + i, v);
  Pointer<Char> operator +(int offset) => Pointer.fromAddress(address + offset);
}

extension UnsignedCharPointer on Pointer<UnsignedChar> {
  int get value => rt.view.getUint8(address);
  set value(int v) => rt.view.setUint8(address, v);
  int operator [](int i) => rt.view.getUint8(address + i);
  void operator []=(int i, int v) => rt.view.setUint8(address + i, v);
}

extension Uint8Pointer on Pointer<Uint8> {
  int get value => rt.view.getUint8(address);
  set value(int v) => rt.view.setUint8(address, v);
  int operator [](int i) => rt.view.getUint8(address + i);
  void operator []=(int i, int v) => rt.view.setUint8(address + i, v);
  Pointer<Uint8> operator +(int offset) => Pointer.fromAddress(address + offset);
  Uint8List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asUint8List(address, length);
}

extension Int16Pointer on Pointer<Int16> {
  Pointer<Int16> operator +(int offset) => Pointer.fromAddress(address + offset * 2);
  int get value => rt.view.getInt16(address, Endian.little);
  set value(int v) => rt.view.setInt16(address, v, Endian.little);
  int operator [](int i) => rt.view.getInt16(address + i * 2, Endian.little);
  void operator []=(int i, int v) => rt.view.setInt16(address + i * 2, v, Endian.little);
  Int16List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asInt16List(address, length);
}

extension ShortPointer on Pointer<Short> {
  int get value => rt.view.getInt16(address, Endian.little);
  set value(int v) => rt.view.setInt16(address, v, Endian.little);
  int operator [](int i) => rt.view.getInt16(address + i * 2, Endian.little);
  void operator []=(int i, int v) => rt.view.setInt16(address + i * 2, v, Endian.little);
}

extension Uint16Pointer on Pointer<Uint16> {
  Pointer<Uint16> operator +(int offset) => Pointer.fromAddress(address + offset * 2);
  int get value => rt.view.getUint16(address, Endian.little);
  set value(int v) => rt.view.setUint16(address, v, Endian.little);
  int operator [](int i) => rt.view.getUint16(address + i * 2, Endian.little);
  void operator []=(int i, int v) => rt.view.setUint16(address + i * 2, v, Endian.little);
  Uint16List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asUint16List(address, length);
}

extension UnsignedShortPointer on Pointer<UnsignedShort> {
  int get value => rt.view.getUint16(address, Endian.little);
  set value(int v) => rt.view.setUint16(address, v, Endian.little);
  int operator [](int i) => rt.view.getUint16(address + i * 2, Endian.little);
  void operator []=(int i, int v) => rt.view.setUint16(address + i * 2, v, Endian.little);
}

extension Int32Pointer on Pointer<Int32> {
  int get value => rt.view.getInt32(address, Endian.little);
  set value(int v) => rt.view.setInt32(address, v, Endian.little);
  int operator [](int i) => rt.view.getInt32(address + i * 4, Endian.little);
  void operator []=(int i, int v) => rt.view.setInt32(address + i * 4, v, Endian.little);
  Pointer<Int32> operator +(int offset) => Pointer.fromAddress(address + offset * 4);
  Int32List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asInt32List(address, length);
}

extension IntPointer on Pointer<Int> {
  int get value => rt.view.getInt32(address, Endian.little);
  set value(int v) => rt.view.setInt32(address, v, Endian.little);
  int operator [](int i) => rt.view.getInt32(address + i * 4, Endian.little);
  void operator []=(int i, int v) => rt.view.setInt32(address + i * 4, v, Endian.little);
  Pointer<Int> operator +(int offset) => Pointer.fromAddress(address + offset * 4);
}

extension LongPointer on Pointer<Long> {
  int get value => rt.view.getInt32(address, Endian.little);
  set value(int v) => rt.view.setInt32(address, v, Endian.little);
  int operator [](int i) => rt.view.getInt32(address + i * 4, Endian.little);
  void operator []=(int i, int v) => rt.view.setInt32(address + i * 4, v, Endian.little);
}

extension Uint32Pointer on Pointer<Uint32> {
  int get value => rt.view.getUint32(address, Endian.little);
  set value(int v) => rt.view.setUint32(address, v, Endian.little);
  int operator [](int i) => rt.view.getUint32(address + i * 4, Endian.little);
  void operator []=(int i, int v) => rt.view.setUint32(address + i * 4, v, Endian.little);
  Uint32List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asUint32List(address, length);
}

extension UnsignedIntPointer on Pointer<UnsignedInt> {
  int get value => rt.view.getUint32(address, Endian.little);
  set value(int v) => rt.view.setUint32(address, v, Endian.little);
  int operator [](int i) => rt.view.getUint32(address + i * 4, Endian.little);
  void operator []=(int i, int v) => rt.view.setUint32(address + i * 4, v, Endian.little);
}

extension SizePointer on Pointer<Size> {
  int get value => rt.view.getUint32(address, Endian.little);
  set value(int v) => rt.view.setUint32(address, v, Endian.little);
  int operator [](int i) => rt.view.getUint32(address + i * 4, Endian.little);
  void operator []=(int i, int v) => rt.view.setUint32(address + i * 4, v, Endian.little);
}

extension Int64Pointer on Pointer<Int64> {
  int get value => rt.view.getInt64(address, Endian.little);
  set value(int v) => rt.view.setInt64(address, v, Endian.little);
  int operator [](int i) => rt.view.getInt64(address + i * 8, Endian.little);
  void operator []=(int i, int v) => rt.view.setInt64(address + i * 8, v, Endian.little);
}

extension Uint64Pointer on Pointer<Uint64> {
  int get value => rt.view.getUint64(address, Endian.little);
  set value(int v) => rt.view.setUint64(address, v, Endian.little);
  int operator [](int i) => rt.view.getUint64(address + i * 8, Endian.little);
  void operator []=(int i, int v) => rt.view.setUint64(address + i * 8, v, Endian.little);
}

extension FloatPointer on Pointer<Float> {
  double get value => rt.view.getFloat32(address, Endian.little);
  set value(double v) => rt.view.setFloat32(address, v, Endian.little);
  double operator [](int i) => rt.view.getFloat32(address + i * 4, Endian.little);
  void operator []=(int i, double v) => rt.view.setFloat32(address + i * 4, v, Endian.little);
  Pointer<Float> operator +(int offset) => Pointer.fromAddress(address + offset * 4);
  Float32List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asFloat32List(address, length);
}

extension DoublePointer on Pointer<Double> {
  double get value => rt.view.getFloat64(address, Endian.little);
  set value(double v) => rt.view.setFloat64(address, v, Endian.little);
  double operator [](int i) => rt.view.getFloat64(address + i * 8, Endian.little);
  void operator []=(int i, double v) => rt.view.setFloat64(address + i * 8, v, Endian.little);
  Pointer<Double> operator +(int offset) => Pointer.fromAddress(address + offset * 8);
  Float64List asTypedList(int length, {Object? finalizer, Pointer<Void>? token}) =>
      _buf.asFloat64List(address, length);
}

// ---- finalizers ----

typedef NativeFinalizerFunction = NativeFunction<Void Function(Pointer<Void> token)>;

/// Runs a C free function (by its wasm table index) when the attached Dart object is collected.
/// Best effort: browsers' GC does not see wasm heap pressure, so dispose() eagerly on the web.
final class NativeFinalizer {
  NativeFinalizer(Pointer<NativeFinalizerFunction> callback)
    : _finalizer = Finalizer<int>((token) => rt.callPointer1(callback.address, token));

  final Finalizer<int> _finalizer;

  void attach(Finalizable value, Pointer token, {Object? detach, int? externalSize}) =>
      _finalizer.attach(value as Object, token.address, detach: detach);

  void detach(Object detach) => _finalizer.detach(detach);
}

// ---- callbacks ----

/// Exposes a Dart function as a C function pointer (a wasm table entry made with addFunction).
/// `listener` callbacks run later in a microtask, like dart:ffi's listener; `isolateLocal` ones
/// run synchronously inside the C call.
final class NativeCallable<T extends Function> {
  NativeCallable.listener(Function callback) : this._(callback, true);

  // exceptionalReturn mirrors dart:ffi's signature; a Dart exception here propagates into the C call.
  // ignore: avoid_unused_constructor_parameters
  NativeCallable.isolateLocal(Function callback, {Object? exceptionalReturn}) : this._(callback, false);

  NativeCallable._(Function callback, bool async) {
    final sig = rt.callbackSignatures[T];
    if (sig == null) throw UnsupportedError('dartcv web: no wasm signature registered for $T');
    final (wasmSig, kinds) = sig;
    JSAny? invoke(List<JSAny?> raw) {
      final args = [for (var k = 0; k < kinds.length; k++) _fromJs(kinds[k], raw[k])];
      if (async) {
        scheduleMicrotask(() => Function.apply(callback, args));
        return null;
      }
      final r = Function.apply(callback, args);
      return switch (wasmSig[0]) {
        'i' => (r is bool ? (r ? 1 : 0) : (r is Pointer ? r.address : r as int)).toJS,
        'f' || 'd' => (r as double).toJS,
        _ => null,
      };
    }

    _index = rt.addFunction(_jsFunction(kinds.length, invoke), wasmSig);
  }

  late final int _index;
  bool _closed = false;
  bool keepIsolateAlive = true;

  Pointer<NativeFunction<T>> get nativeFunction => Pointer.fromAddress(_index);

  void close() {
    if (_closed) return;
    _closed = true;
    rt.removeFunction(_index);
  }
}

Object? _fromJs(String kind, JSAny? v) => switch (kind) {
  'p' => Pointer<Void>.fromAddress((v! as JSNumber).toDartInt & 0xFFFFFFFF),
  'i' => (v! as JSNumber).toDartInt,
  'u' => (v! as JSNumber).toDartInt & 0xFFFFFFFF,
  'b' => (v! as JSNumber).toDartInt != 0,
  'd' => (v! as JSNumber).toDartDouble,
  'j' => rt.rj(v),
  _ => throw UnsupportedError('dartcv web: callback argument kind $kind'),
};

JSFunction _jsFunction(int n, JSAny? Function(List<JSAny?>) f) => switch (n) {
  0 => (() => f(const [])).toJS,
  1 => ((JSAny? a) => f([a])).toJS,
  2 => ((JSAny? a, JSAny? b) => f([a, b])).toJS,
  3 => ((JSAny? a, JSAny? b, JSAny? c) => f([a, b, c])).toJS,
  4 => ((JSAny? a, JSAny? b, JSAny? c, JSAny? d) => f([a, b, c, d])).toJS,
  5 => ((JSAny? a, JSAny? b, JSAny? c, JSAny? d, JSAny? e) => f([a, b, c, d, e])).toJS,
  6 => ((JSAny? a, JSAny? b, JSAny? c, JSAny? d, JSAny? e, JSAny? g) => f([a, b, c, d, e, g])).toJS,
  7 => ((JSAny? a, JSAny? b, JSAny? c, JSAny? d, JSAny? e, JSAny? g, JSAny? h) => f([
    a,
    b,
    c,
    d,
    e,
    g,
    h,
  ])).toJS,
  8 => ((JSAny? a, JSAny? b, JSAny? c, JSAny? d, JSAny? e, JSAny? g, JSAny? h, JSAny? k) => f([
    a,
    b,
    c,
    d,
    e,
    g,
    h,
    k,
  ])).toJS,
  _ => throw UnsupportedError('dartcv web: callbacks with $n arguments'),
};
