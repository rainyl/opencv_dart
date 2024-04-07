import 'dart:ffi' as ffi;

import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

// Dart does not support multiple upper bounds for T now, if they implement it, this can be simplified.
// https://github.com/dart-lang/language/issues/2709
abstract class NativeArray<T extends ffi.NativeType, P extends num>
    with EquatableMixin
    implements ffi.Finalizable, INativeArray<P> {
  NativeArray([this.length = 0]);

  int length;

  late final ffi.Pointer<T> ptr;
  ffi.Pointer<ffi.Void> asVoid() => ptr.cast<ffi.Void>();
  @override
  List<int> get props => [ptr.address];
}

abstract class INativeArray<T> {
  void operator []=(int idx, T value);
  T operator [](int idx);
  List<T> toList();
}

class U8Array extends NativeArray<ffi.Uint8, int> {
  U8Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Uint8>(length);
    finalizer.attach(this, ptr);
  }

  factory U8Array.fromList(List<int> data) {
    final array = U8Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  U8Array.fromPointer(ffi.Pointer<ffi.Uint8> ptr, int length) : super(length) {
    this.ptr = ptr;
    finalizer.attach(this, ptr);
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Uint8>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, int value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length, "idx=$idx out of range(0, ${length - 1})");
    ptr[idx] = value;
  }

  @override
  int operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<int> toList() => List.generate(length, (i) => this[i]);
}

class I8Array extends NativeArray<ffi.Int8, int> {
  I8Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Int8>(length);
    finalizer.attach(this, ptr);
  }

  factory I8Array.fromList(List<int> data) {
    final array = I8Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Int8>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, int value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length);
    ptr[idx] = value;
  }

  @override
  int operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<int> toList() => List.generate(length, (i) => this[i]);
}

class U16Array extends NativeArray<ffi.Uint16, int> {
  U16Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Uint16>(length);
    finalizer.attach(this, ptr);
  }

  factory U16Array.fromList(List<int> data) {
    final array = U16Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Uint16>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, int value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length, "idx=$idx out of range(0, ${length - 1})");
    ptr[idx] = value;
  }

  @override
  int operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<int> toList() => List.generate(length, (i) => this[i]);
}

class I16Array extends NativeArray<ffi.Int16, int> {
  I16Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Int16>(length);
    finalizer.attach(this, ptr);
  }

  factory I16Array.fromList(List<int> data) {
    final array = I16Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Int16>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, int value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length);
    ptr[idx] = value;
  }

  @override
  int operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<int> toList() => List.generate(length, (i) => this[i]);
}

class I32Array extends NativeArray<ffi.Int, int> {
  I32Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Int>(length);
    finalizer.attach(this, ptr);
  }

  factory I32Array.fromList(List<int> data) {
    final array = I32Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Int>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, int value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length);
    ptr[idx] = value;
  }

  @override
  int operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<int> toList() => List.generate(length, (i) => this[i]);
}

class F32Array extends NativeArray<ffi.Float, double> {
  F32Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Float>(length);
    finalizer.attach(this, ptr);
  }

  factory F32Array.fromList(List<double> data) {
    final array = F32Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Float>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, double value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length);
    ptr[idx] = value;
  }

  @override
  double operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<double> toList() => List.generate(length, (i) => this[i]);
}

class F64Array extends NativeArray<ffi.Double, double> {
  F64Array([int length = 0]) : super(length) {
    ptr = calloc<ffi.Double>(length);
    finalizer.attach(this, ptr);
  }

  factory F64Array.fromList(List<double> data) {
    final array = F64Array(data.length);
    for (var i = 0; i < data.length; i++) {
      array[i] = data[i];
    }
    return array;
  }

  static final finalizer = Finalizer<ffi.Pointer<ffi.Double>>((p) => calloc.free(p));

  @override
  void operator []=(int idx, double value) {
    // TODO: support negative index
    assert(idx >= 0 && idx < length);
    ptr[idx] = value;
  }

  @override
  double operator [](int idx) {
    assert(idx >= 0 && idx < length);
    return ptr[idx];
  }

  @override
  List<double> toList() => List.generate(length, (i) => this[i]);
}
