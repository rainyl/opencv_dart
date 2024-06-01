import 'dart:collection';
import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

abstract class Vec<T> with IterableMixin<T>, EquatableMixin implements ffi.Finalizable {
  @override
  int get length;

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

class VecInt extends Vec<int> implements CvStruct<cvg.VecInt> {
  VecInt._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VecInt([int length = 0, int value = 0]) =>
      VecInt.fromList(List.generate(length, (i) => value));
  factory VecInt.fromPointer(cvg.VecIntPtr ptr, [bool attach = true]) => VecInt._(ptr, attach);
  factory VecInt.fromVec(cvg.VecInt ptr) {
    final p = calloc<cvg.VecInt>();
    cvRun(() => cvg.VecInt_NewFromVec(ptr, p));
    return VecInt._(p);
  }
  factory VecInt.fromList(List<int> pts) {
    final ptr = calloc<cvg.VecInt>();
    final intPtr = calloc<ffi.Int>(pts.length);
    for (var i = 0; i < pts.length; i++) {
      intPtr[i] = pts[i];
    }
    cvRun(() => cvg.VecInt_NewFromPointer(intPtr, pts.length, ptr));
    calloc.free(intPtr);
    return VecInt._(ptr);
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => cvg.VecInt_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  static final finalizer = OcvFinalizer<cvg.VecIntPtr>(ffi.Native.addressOf(cvg.VecInt_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.VecInt_Close(ptr);
  }

  @override
  cvg.VecIntPtr ptr;
  @override
  Iterator<int> get iterator => VecIntIterator(ref);

  @override
  cvg.VecInt get ref => ptr.ref;
}

class VecIntIterator extends VecIterator<int> {
  VecIntIterator(this.ptr);
  cvg.VecInt ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.VecInt_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  int operator [](int idx) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.VecInt_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecUChar extends Vec<int> implements CvStruct<cvg.VecUChar> {
  VecUChar._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecUChar([int length = 0, int value = 0]) =>
      VecUChar.fromList(List.generate(length, (i) => value));
  factory VecUChar.fromPointer(cvg.VecUCharPtr ptr, [bool attach = true]) =>
      VecUChar._(ptr, attach);
  factory VecUChar.fromVec(cvg.VecUChar ptr) {
    final p = calloc<cvg.VecUChar>();
    cvRun(() => cvg.VecUChar_NewFromVec(ptr, p));
    final vec = VecUChar._(p);
    return vec;
  }
  factory VecUChar.fromList(List<int> pts) {
    final ptr = calloc<cvg.VecUChar>();
    final intPtr = calloc<ffi.UnsignedChar>(pts.length);
    for (var i = 0; i < pts.length; i++) {
      intPtr[i] = pts[i];
    }
    cvRun(() => cvg.VecUChar_NewFromPointer(intPtr, pts.length, ptr));
    calloc.free(intPtr);
    return VecUChar._(ptr);
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => cvg.VecUChar_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  Uint8List toU8List() => Uint8List.fromList(toList());
  static final finalizer = OcvFinalizer<cvg.VecUCharPtr>(ffi.Native.addressOf(cvg.VecUChar_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.VecUChar_Close(ptr);
  }

  @override
  cvg.VecUCharPtr ptr;
  @override
  Iterator<int> get iterator => VecUCharIterator(ref);

  @override
  cvg.VecUChar get ref => ptr.ref;
}

class VecUCharIterator extends VecIterator<int> {
  VecUCharIterator(this.ptr);
  cvg.VecUChar ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.VecUChar_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  int operator [](int idx) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.UnsignedChar>();
      cvRun(() => cvg.VecUChar_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecChar extends Vec<int> implements CvStruct<cvg.VecChar> {
  VecChar._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecChar([int length = 0, int value = 0]) =>
      VecChar.fromList(List.generate(length, (i) => value));
  factory VecChar.fromPointer(cvg.VecCharPtr ptr, [bool attach = true]) => VecChar._(ptr, attach);
  factory VecChar.fromVec(cvg.VecChar ptr) {
    final p = calloc<cvg.VecChar>();
    cvRun(() => cvg.VecChar_NewFromVec(ptr, p));
    final vec = VecChar._(p);
    return vec;
  }
  factory VecChar.fromList(List<int> pts) {
    final ptr = calloc<cvg.VecChar>();
    final intPtr = calloc<ffi.Char>(pts.length);
    for (var i = 0; i < pts.length; i++) {
      intPtr[i] = pts[i];
    }
    cvRun(() => cvg.VecChar_NewFromPointer(intPtr, pts.length, ptr));
    calloc.free(intPtr);
    return VecChar._(ptr);
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => cvg.VecChar_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  String asString() => String.fromCharCodes(this);

  @override
  cvg.VecCharPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecCharPtr>(ffi.Native.addressOf(cvg.VecChar_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.VecChar_Close(ptr);
  }

  @override
  Iterator<int> get iterator => VecCharIterator(ref);

  @override
  cvg.VecChar get ref => ptr.ref;
}

class VecCharIterator extends VecIterator<int> {
  VecCharIterator(this.ptr);
  cvg.VecChar ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.VecChar_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  int operator [](int idx) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Char>();
      cvRun(() => cvg.VecChar_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecVecChar extends Vec<VecChar> implements CvStruct<cvg.VecVecChar> {
  VecVecChar._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecVecChar.fromPointer(cvg.VecVecCharPtr ptr, [bool attach = true]) =>
      VecVecChar._(ptr, attach);
  factory VecVecChar.fromVec(cvg.VecVecChar ptr) {
    final p = calloc<cvg.VecVecChar>();
    cvRun(() => cvg.VecVecChar_NewFromVec(ptr, p));
    final vec = VecVecChar._(p);
    return vec;
  }
  factory VecVecChar.fromList(List<List<int>> pts) {
    final ptr = calloc<cvg.VecVecChar>();
    cvRun(() => cvg.VecVecChar_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].i8;
      cvRun(() => cvg.VecVecChar_Append(ptr.ref, point.ref));
    }
    final vec = VecVecChar._(ptr);
    return vec;
  }

  List<String> asStringList() {
    return map((e) => String.fromCharCodes(e)).toList();
  }

  static final finalizer =
      OcvFinalizer<cvg.VecVecCharPtr>(ffi.Native.addressOf(cvg.VecVecChar_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.VecVecChar_Close(ptr);
  }

  @override
  cvg.VecVecCharPtr ptr;
  @override
  Iterator<VecChar> get iterator => VecVecCharIterator(ref);
  @override
  cvg.VecVecChar get ref => ptr.ref;
}

class VecVecCharIterator extends VecIterator<VecChar> {
  VecVecCharIterator(this.ptr);
  cvg.VecVecChar ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.VecVecChar_Size(ptr, p));
        final len = p.value;
        return len;
      });

  /// return the reference
  @override
  VecChar operator [](int idx) {
    return cvRunArena<VecChar>((arena) {
      final p = calloc<cvg.VecChar>();
      cvRun(() => cvg.VecVecChar_At(ptr, idx, p));
      final vec = VecChar.fromPointer(p);
      return vec;
    });
  }
}

class VecFloat extends Vec<double> implements CvStruct<cvg.VecFloat> {
  VecFloat._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecFloat([int length = 0, double value = 0]) =>
      VecFloat.fromList(List.generate(length, (i) => value));
  factory VecFloat.fromPointer(cvg.VecFloatPtr ptr, [bool attach = true]) =>
      VecFloat._(ptr, attach);
  factory VecFloat.fromVec(cvg.VecFloat ptr) {
    final p = calloc<cvg.VecFloat>();
    cvRun(() => cvg.VecFloat_NewFromVec(ptr, p));
    final vec = VecFloat._(p);
    return vec;
  }
  factory VecFloat.fromList(List<double> pts) {
    final ptr = calloc<cvg.VecFloat>();
    final intPtr = calloc<ffi.Float>(pts.length);
    for (var i = 0; i < pts.length; i++) {
      intPtr[i] = pts[i];
    }
    cvRun(() => cvg.VecFloat_NewFromPointer(intPtr, pts.length, ptr));
    calloc.free(intPtr);
    return VecFloat._(ptr);
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => cvg.VecFloat_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  static final finalizer = OcvFinalizer<cvg.VecFloatPtr>(ffi.Native.addressOf(cvg.VecFloat_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.VecFloat_Close(ptr);
  }

  @override
  cvg.VecFloatPtr ptr;
  @override
  Iterator<double> get iterator => VecFloatIterator(ref);
  @override
  cvg.VecFloat get ref => ptr.ref;
}

class VecFloatIterator extends VecIterator<double> {
  VecFloatIterator(this.ptr);
  cvg.VecFloat ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.VecFloat_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  double operator [](int idx) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cvg.VecFloat_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecDouble extends Vec<double> implements CvStruct<cvg.VecDouble> {
  VecDouble._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecDouble([int length = 0, double value = 0]) =>
      VecDouble.fromList(List.generate(length, (i) => value));
  factory VecDouble.fromPointer(cvg.VecDoublePtr ptr, [bool attach = true]) =>
      VecDouble._(ptr, attach);
  factory VecDouble.fromVec(cvg.VecDouble ptr) {
    final p = calloc<cvg.VecDouble>();
    cvRun(() => cvg.VecDouble_NewFromVec(ptr, p));
    final vec = VecDouble._(p);
    return vec;
  }
  factory VecDouble.fromList(List<double> pts) {
    final ptr = calloc<cvg.VecDouble>();
    final intPtr = calloc<ffi.Double>(pts.length);
    for (var i = 0; i < pts.length; i++) {
      intPtr[i] = pts[i];
    }
    cvRun(() => cvg.VecDouble_NewFromPointer(intPtr, pts.length, ptr));
    calloc.free(intPtr);
    return VecDouble._(ptr);
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => cvg.VecDouble_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  @override
  cvg.VecDoublePtr ptr;
  static final finalizer =
      OcvFinalizer<cvg.VecDoublePtr>(ffi.Native.addressOf(cvg.VecDouble_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.VecDouble_Close(ptr);
  }

  @override
  Iterator<double> get iterator => VecDoubleIterator(ref);

  @override
  cvg.VecDouble get ref => ptr.ref;
}

class VecDoubleIterator extends VecIterator<double> {
  VecDoubleIterator(this.ptr);
  cvg.VecDouble ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.VecDouble_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  double operator [](int idx) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.VecDouble_At(ptr, idx, p));
      return p.value;
    });
  }
}

extension ListIntExtension on List<int> {
  VecInt get i32 => VecInt.fromList(this);
}

extension ListUCharExtension on List<int> {
  VecUChar get u8 => VecUChar.fromList(this);
}

extension StringVecExtension on String {
  VecUChar get u8 {
    return cvRunArena<VecUChar>((arena) {
      final p = toNativeUtf8(allocator: arena);
      final v = VecUChar.fromList(List.generate(
        p.length,
        (idx) => p.cast<ffi.UnsignedChar>()[idx],
      ));
      return v;
    });
  }

  VecChar get i8 {
    return cvRunArena<VecChar>((arena) {
      final p = toNativeUtf8(allocator: arena);
      final v = VecChar.fromList(List.generate(
        p.length,
        (idx) => p.cast<ffi.Char>()[idx],
      ));
      return v;
    });
  }
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
