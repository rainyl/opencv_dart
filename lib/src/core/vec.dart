import 'dart:collection';
import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

abstract class Vec<T> with IterableMixin<T> implements ffi.Finalizable {
  @override
  int get length;
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

class VecInt extends Vec<int> {
  VecInt._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecInt.fromPointer(cvg.VecInt ptr) {
    final p = calloc<cvg.VecInt>();
    try {
      cvRun(() => CFFI.VecInt_NewFromVec(ptr, p));
      final vec = VecInt._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecInt.fromList(List<int> pts) {
    final ptr = calloc<cvg.VecInt>();
    cvRun(() => CFFI.VecInt_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecInt_Append(ptr.value, pts[i]));
    }
    final vec = VecInt._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecInt_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecInt ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecInt_Close);
  @override
  Iterator<int> get iterator => VecIntIterator(ptr);
}

class VecIntIterator extends VecIterator<int> {
  VecIntIterator(this.ptr);
  cvg.VecInt ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecInt_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  int operator [](int idx) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VecInt_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecUChar extends Vec<int> {
  VecUChar._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecUChar.fromPointer(cvg.VecUChar ptr) {
    final p = calloc<cvg.VecUChar>();
    try {
      cvRun(() => CFFI.VecUChar_NewFromVec(ptr, p));
      final vec = VecUChar._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecUChar.fromList(List<int> pts) {
    final ptr = calloc<cvg.VecUChar>();
    cvRun(() => CFFI.VecUChar_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecUChar_Append(ptr.value, pts[i]));
    }
    final vec = VecUChar._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecUChar_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  Uint8List toU8List() => Uint8List.fromList(toList());

  cvg.VecUChar ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecUChar_Close);
  @override
  Iterator<int> get iterator => VecUCharIterator(ptr);
}

class VecUCharIterator extends VecIterator<int> {
  VecUCharIterator(this.ptr);
  cvg.VecUChar ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecUChar_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  int operator [](int idx) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.UnsignedChar>();
      cvRun(() => CFFI.VecUChar_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecChar extends Vec<int> {
  VecChar._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecChar.fromPointer(cvg.VecChar ptr) {
    final p = calloc<cvg.VecChar>();
    try {
      cvRun(() => CFFI.VecChar_NewFromVec(ptr, p));
      final vec = VecChar._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecChar.fromList(List<int> pts) {
    final ptr = calloc<cvg.VecChar>();
    cvRun(() => CFFI.VecChar_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecChar_Append(ptr.value, pts[i]));
    }
    final vec = VecChar._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecChar_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecChar ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecChar_Close);
  @override
  Iterator<int> get iterator => VecCharIterator(ptr);
}

class VecCharIterator extends VecIterator<int> {
  VecCharIterator(this.ptr);
  cvg.VecChar ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecChar_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  int operator [](int idx) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Char>();
      cvRun(() => CFFI.VecChar_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecVecChar extends Vec<Vec<int>> {
  VecVecChar._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecVecChar.fromPointer(cvg.VecVecChar ptr) {
    final p = calloc<cvg.VecVecChar>();
    try {
      cvRun(() => CFFI.VecVecChar_NewFromVec(ptr, p));
      final vec = VecVecChar._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecVecChar.fromList(List<List<int>> pts) {
    final ptr = calloc<cvg.VecVecChar>();
    cvRun(() => CFFI.VecVecChar_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].i8;
      cvRun(() => CFFI.VecVecChar_Append(ptr.value, point.ptr));
    }
    final vec = VecVecChar._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  cvg.VecVecChar ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecVecChar_Close);
  @override
  Iterator<VecChar> get iterator => VecVecCharIterator(ptr);
}

class VecVecCharIterator extends VecIterator<VecChar> {
  VecVecCharIterator(this.ptr);
  cvg.VecVecChar ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecVecChar_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  VecChar operator [](int idx) {
    return cvRunArena<VecChar>((arena) {
      final p = arena<cvg.VecChar>();
      cvRun(() => CFFI.VecVecChar_At(ptr, idx, p));
      final vec = VecChar.fromPointer(p.value);
      return vec;
    });
  }
}

class VecFloat extends Vec<double> {
  VecFloat._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecFloat.fromPointer(cvg.VecFloat ptr) {
    final p = calloc<cvg.VecFloat>();
    try {
      cvRun(() => CFFI.VecFloat_NewFromVec(ptr, p));
      final vec = VecFloat._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecFloat.fromList(List<double> pts) {
    final ptr = calloc<cvg.VecFloat>();
    cvRun(() => CFFI.VecFloat_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecFloat_Append(ptr.value, pts[i]));
    }
    final vec = VecFloat._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecFloat_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecFloat ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecFloat_Close);
  @override
  Iterator<double> get iterator => VecFloatIterator(ptr);
}

class VecFloatIterator extends VecIterator<double> {
  VecFloatIterator(this.ptr);
  cvg.VecFloat ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecFloat_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  double operator [](int idx) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.VecFloat_At(ptr, idx, p));
      return p.value;
    });
  }
}

class VecDouble extends Vec<double> {
  VecDouble._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecDouble.fromPointer(cvg.VecDouble ptr) {
    final p = calloc<cvg.VecDouble>();
    try {
      cvRun(() => CFFI.VecDouble_NewFromVec(ptr, p));
      final vec = VecDouble._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecDouble.fromList(List<double> pts) {
    final ptr = calloc<cvg.VecDouble>();
    cvRun(() => CFFI.VecDouble_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecDouble_Append(ptr.value, pts[i]));
    }
    final vec = VecDouble._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecDouble_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecDouble ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecDouble_Close);
  @override
  Iterator<double> get iterator => VecDoubleIterator(ptr);
}

class VecDoubleIterator extends VecIterator<double> {
  VecDoubleIterator(this.ptr);
  cvg.VecDouble ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecDouble_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  double operator [](int idx) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.VecDouble_At(ptr, idx, p));
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
