import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';

abstract class Vec<N extends ffi.Struct, T>
    with IterableMixin<T>, ComparableMixin
    implements ffi.Finalizable {
  Vec.fromPointer(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      // finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>, detach: this);
    }
  }

  ffi.Pointer<N> ptr;
  N get ref;
  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  int get length;

  void dispose() {
    finalizer.detach(this);
    // calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  // TODO: compare with full elements may be unnecessary?
  List<T> get props => toList();
}

abstract class VecIterator<T> implements Iterator<T> {
  int currentIndex = -1;
  int get length;
  T operator [](int idx);

  @override
  T get current {
    if (currentIndex >= 0 && currentIndex < length) {
      return this[currentIndex];
    }
    throw IndexError.withLength(currentIndex, length);
  }

  @override
  bool moveNext() {
    if (currentIndex < length - 1) {
      currentIndex++;
      return true;
    }
    return false;
  }
}

class VecInt extends Vec<cvg.VecInt, int> {
  VecInt.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecInt([int length = 0, int value = 0]) => VecInt.generate(length, (i) => value);
  factory VecInt.fromList(List<int> pts) => VecInt.generate(pts.length, (i) => pts[i]);

  factory VecInt.generate(int length, int Function(int i) generator) {
    final intPtr = calloc<ffi.Int>(length);
    for (var i = 0; i < length; i++) {
      intPtr[i] = generator(i);
    }
    final p = calloc<cvg.VecInt>()
      ..ref.ptr = intPtr
      ..ref.length = length;
    return VecInt.fromPointer(p);
  }

  factory VecInt.fromVec(cvg.VecInt vec) {
    final p = calloc<cvg.VecInt>()..ref = vec;
    return VecInt.fromPointer(p);
  }

  @override
  int get length => ref.length;

  Int32List get data => ref.ptr.cast<ffi.Int32>().asTypedList(length);

  @override
  Iterator<int> get iterator => VecIntIterator(ref);

  @override
  cvg.VecInt get ref => ptr.ref;
}

class VecIntIterator extends VecIterator<int> {
  VecIntIterator(this.ref);
  cvg.VecInt ref;

  @override
  int get length => ref.length;

  @override
  int operator [](int idx) => ref.ptr[idx];
}

class VecUChar extends Vec<cvg.VecUChar, int> {
  VecUChar.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecUChar([int length = 0, int value = 0]) => VecUChar.generate(length, (i) => value);
  factory VecUChar.fromList(List<int> pts) => VecUChar.generate(pts.length, (i) => pts[i]);

  factory VecUChar.generate(int length, int Function(int i) generator) {
    final intPtr = calloc<ffi.UnsignedChar>(length);
    for (var i = 0; i < length; i++) {
      intPtr[i] = generator(i);
    }
    final p = calloc<cvg.VecUChar>()
      ..ref.ptr = intPtr
      ..ref.length = length;
    return VecUChar.fromPointer(p);
  }

  factory VecUChar.fromVec(cvg.VecUChar vec) {
    final p = calloc<cvg.VecUChar>()..ref = vec;
    return VecUChar.fromPointer(p);
  }

  @override
  int get length => ref.length;

  /// Returns a view of native pointer
  Uint8List get data => ref.ptr.cast<ffi.Uint8>().asTypedList(length);

  /// ~~alias of data~~
  ///
  /// This method will return a full copy of [data]
  ///
  /// https://github.com/rainyl/opencv_dart/issues/85
  Uint8List toU8List() => Uint8List.fromList(data);
  @override
  Iterator<int> get iterator => VecUCharIterator(ref);

  @override
  cvg.VecUChar get ref => ptr.ref;
}

class VecUCharIterator extends VecIterator<int> {
  VecUCharIterator(this.ref);
  cvg.VecUChar ref;

  @override
  int get length => ref.length;

  @override
  int operator [](int idx) => ref.ptr[idx];
}

class VecChar extends Vec<cvg.VecChar, int> {
  VecChar.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecChar([int length = 0, int value = 0]) => VecChar.generate(length, (i) => value);
  factory VecChar.fromList(List<int> pts) => VecChar.generate(pts.length, (i) => pts[i]);

  factory VecChar.generate(int length, int Function(int i) generator) {
    final intPtr = calloc<ffi.Char>(length);
    for (var i = 0; i < length; i++) {
      intPtr[i] = generator(i);
    }
    final p = calloc<cvg.VecChar>()
      ..ref.ptr = intPtr
      ..ref.length = length;
    return VecChar.fromPointer(p);
  }

  factory VecChar.fromVec(cvg.VecChar vec) {
    final p = calloc<cvg.VecChar>()..ref = vec;
    return VecChar.fromPointer(p);
  }

  @override
  int get length => ref.length;

  Uint8List get data => ref.ptr.cast<ffi.Uint8>().asTypedList(length);

  String asString() => utf8.decode(data);

  @override
  Iterator<int> get iterator => VecCharIterator(ref);

  @override
  cvg.VecChar get ref => ptr.ref;
}

class VecCharIterator extends VecIterator<int> {
  VecCharIterator(this.ref);
  cvg.VecChar ref;

  @override
  int get length => ref.length;

  @override
  int operator [](int idx) => ref.ptr[idx];
}

class VecVecChar extends Vec<cvg.VecVecChar, VecChar> {
  VecVecChar.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecVecChar.fromList(List<List<int>> pts) => VecVecChar.generate(pts.length, (i) => pts[i].i8);

  factory VecVecChar.fromVec(cvg.VecVecChar vec) {
    final p = calloc<cvg.VecVecChar>()..ref = vec;
    return VecVecChar.fromPointer(p);
  }

  factory VecVecChar.generate(int length, VecChar Function(int i) generator) {
    final p = calloc<cvg.VecChar>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecVecChar>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecVecChar.fromPointer(pp);
    // final p = calloc<cvg.VecChar>(pts.length);
    // for (var i = 0; i < pts.length; i++) {
    //   final pp = calloc<ffi.Char>(pts[i].length);
    //   for (var j = 0; j < pts[i].length; j++) {
    //     pp[j] = pts[i][j];
    //   }
    //   p[i].ptr = pp;
    //   p[i].length = pts[i].length;
    // }
    // final ptr = calloc<cvg.VecVecChar>()
    //   ..ref.ptr = p
    //   ..ref.length = pts.length;
    // return VecVecChar._(ptr);
  }

  List<String> asStringList() {
    return map(String.fromCharCodes).toList();
  }

  @override
  Iterator<VecChar> get iterator => VecVecCharIterator(ref);
  @override
  cvg.VecVecChar get ref => ptr.ref;
}

class VecVecCharIterator extends VecIterator<VecChar> {
  VecVecCharIterator(this.ref);
  cvg.VecVecChar ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecChar operator [](int idx) => VecChar.fromVec(ref.ptr[idx]);
}

class VecFloat extends Vec<cvg.VecFloat, double> implements CvStruct<cvg.VecFloat> {
  VecFloat.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecFloat([int length = 0, double value = 0.0]) => VecFloat.generate(length, (i) => value);
  factory VecFloat.fromList(List<double> pts) => VecFloat.generate(pts.length, (i) => pts[i]);

  factory VecFloat.generate(int length, double Function(int i) generator) {
    final intPtr = calloc<ffi.Float>(length);
    for (var i = 0; i < length; i++) {
      intPtr[i] = generator(i);
    }
    final p = calloc<cvg.VecFloat>()
      ..ref.ptr = intPtr
      ..ref.length = length;
    return VecFloat.fromPointer(p);
  }

  factory VecFloat.fromVec(cvg.VecFloat vec) {
    final p = calloc<cvg.VecFloat>()..ref = vec;
    return VecFloat.fromPointer(p);
  }

  @override
  int get length => ref.length;

  Float32List get data => ref.ptr.cast<ffi.Float>().asTypedList(length);
  @override
  Iterator<double> get iterator => VecFloatIterator(ref);
  @override
  cvg.VecFloat get ref => ptr.ref;
}

class VecFloatIterator extends VecIterator<double> {
  VecFloatIterator(this.ref);
  cvg.VecFloat ref;

  @override
  int get length => ref.length;

  @override
  double operator [](int idx) => ref.ptr[idx];
}

class VecDouble extends Vec<cvg.VecDouble, double> implements CvStruct<cvg.VecDouble> {
  VecDouble.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecDouble([int length = 0, double value = 0.0]) => VecDouble.generate(length, (i) => value);
  factory VecDouble.fromList(List<double> pts) => VecDouble.generate(pts.length, (i) => pts[i]);

  factory VecDouble.generate(int length, double Function(int i) generator) {
    final intPtr = calloc<ffi.Double>(length);
    for (var i = 0; i < length; i++) {
      intPtr[i] = generator(i);
    }
    final p = calloc<cvg.VecDouble>()
      ..ref.ptr = intPtr
      ..ref.length = length;
    return VecDouble.fromPointer(p);
  }

  factory VecDouble.fromVec(cvg.VecDouble vec) {
    final p = calloc<cvg.VecDouble>()..ref = vec;
    return VecDouble.fromPointer(p);
  }

  @override
  int get length => ref.length;

  Float64List get data => ref.ptr.cast<ffi.Double>().asTypedList(length);

  @override
  Iterator<double> get iterator => VecDoubleIterator(ref);

  @override
  cvg.VecDouble get ref => ptr.ref;
}

class VecDoubleIterator extends VecIterator<double> {
  VecDoubleIterator(this.ref);
  cvg.VecDouble ref;

  @override
  int get length => ref.length;

  @override
  double operator [](int idx) => ref.ptr[idx];
}

extension StringVecExtension on String {
  VecUChar get u8 {
    return cvRunArena<VecUChar>((arena) {
      final p = toNativeUtf8(allocator: arena);
      final pp = p.cast<ffi.UnsignedChar>();
      final v = VecUChar.fromList(List.generate(p.length, (idx) => pp[idx]));
      return v;
    });
  }

  VecChar get i8 {
    final p = toNativeUtf8();
    final v = VecChar.fromList(p.cast<ffi.Int8>().asTypedList(p.length));
    return v;
  }
}

extension ListIntExtension on List<int> {
  VecInt get i32 => VecInt.fromList(this);
}

extension ListUCharExtension on List<int> {
  VecUChar get u8 => VecUChar.fromList(this);
}

extension ListCharExtension on List<int> {
  VecChar get i8 => VecChar.fromList(this);
}

extension ListListCharExtension on List<List<int>> {
  VecVecChar get i8 => VecVecChar.fromList(this);
}

extension ListFloatExtension on List<double> {
  VecFloat get f32 => VecFloat.fromList(this);
}

extension ListDoubleExtension on List<double> {
  VecDouble get f64 => VecDouble.fromList(this);
}

extension ListStringExtension on List<String> {
  VecVecChar get i8 => VecVecChar.fromList(map((e) => e.i8.toList()).toList());
}

// async completers
void vecIntCompleter(Completer<VecInt> completer, VoidPtr p) =>
    completer.complete(VecInt.fromPointer(p.cast<cvg.VecInt>()));

void vecFloatCompleter(Completer<VecFloat> completer, VoidPtr p) =>
    completer.complete(VecFloat.fromPointer(p.cast<cvg.VecFloat>()));

void vecDoubleCompleter(Completer<VecDouble> completer, VoidPtr p) =>
    completer.complete(VecDouble.fromPointer(p.cast<cvg.VecDouble>()));
