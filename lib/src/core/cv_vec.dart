import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

abstract class CvVec<T extends ffi.Struct> extends CvStruct<T> {
  CvVec.fromPointer(super.ptr) : super.fromPointer();
  List<num> get val;
}

/// uchar
class Vec2b extends CvVec<cvg.Vec2b> {
  Vec2b._(ffi.Pointer<cvg.Vec2b> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec2b(int v1, int v2) {
    final p = calloc<cvg.Vec2b>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2b._(p);
  }

  factory Vec2b.fromPointer(ffi.Pointer<cvg.Vec2b> ptr) => Vec2b._(ptr);
  factory Vec2b.fromNative(cvg.Vec2b v) {
    final p = calloc<cvg.Vec2b>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2b._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec2b get ref => ptr.ref;
  @override
  String toString() => "Vec2b($val1, $val2)";
}

/// uchar
class Vec3b extends CvVec<cvg.Vec3b> {
  Vec3b._(ffi.Pointer<cvg.Vec3b> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec3b(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3b>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3b._(p);
  }

  factory Vec3b.fromPointer(ffi.Pointer<cvg.Vec3b> ptr) => Vec3b._(ptr);
  factory Vec3b.fromNative(cvg.Vec3b v) {
    final p = calloc<cvg.Vec3b>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3b._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec3b get ref => ptr.ref;
  @override
  String toString() => "Vec3b($val1, $val2, $val3)";
}

/// uchar
class Vec4b extends CvVec<cvg.Vec4b> {
  Vec4b._(ffi.Pointer<cvg.Vec4b> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec4b(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4b>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4b._(p);
  }

  factory Vec4b.fromPointer(ffi.Pointer<cvg.Vec4b> ptr) => Vec4b._(ptr);
  factory Vec4b.fromNative(cvg.Vec4b v) {
    final p = calloc<cvg.Vec4b>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4b._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  int get val4 => ref.val4;
  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec4b get ref => ptr.ref;
  @override
  String toString() => "Vec4b($val1, $val2, $val3, $val4)";
}

/// ushort
class Vec2w extends CvVec<cvg.Vec2w> {
  Vec2w._(ffi.Pointer<cvg.Vec2w> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec2w(int v1, int v2) {
    final p = calloc<cvg.Vec2w>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2w._(p);
  }

  factory Vec2w.fromPointer(ffi.Pointer<cvg.Vec2w> ptr) => Vec2w._(ptr);
  factory Vec2w.fromNative(cvg.Vec2w v) {
    final p = calloc<cvg.Vec2w>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2w._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec2w get ref => ptr.ref;
  @override
  String toString() => "Vec2w($val1, $val2)";
}

/// ushort
class Vec3w extends CvVec<cvg.Vec3w> {
  Vec3w._(ffi.Pointer<cvg.Vec3w> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec3w(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3w>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3w._(p);
  }

  factory Vec3w.fromPointer(ffi.Pointer<cvg.Vec3w> ptr) => Vec3w._(ptr);
  factory Vec3w.fromNative(cvg.Vec3w v) {
    final p = calloc<cvg.Vec3w>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3w._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec3w get ref => ptr.ref;
  @override
  String toString() => "Vec3w($val1, $val2, $val3)";
}

/// ushort
class Vec4w extends CvVec<cvg.Vec4w> {
  Vec4w._(ffi.Pointer<cvg.Vec4w> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec4w(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4w>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4w._(p);
  }

  factory Vec4w.fromPointer(ffi.Pointer<cvg.Vec4w> ptr) => Vec4w._(ptr);
  factory Vec4w.fromNative(cvg.Vec4w v) {
    final p = calloc<cvg.Vec4w>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4w._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  int get val4 => ref.val4;
  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec4w get ref => ptr.ref;
  @override
  String toString() => "Vec4w($val1, $val2, $val3, $val4)";
}

/// short
class Vec2s extends CvVec<cvg.Vec2s> {
  Vec2s._(ffi.Pointer<cvg.Vec2s> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec2s(int v1, int v2) {
    final p = calloc<cvg.Vec2s>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2s._(p);
  }

  factory Vec2s.fromPointer(ffi.Pointer<cvg.Vec2s> ptr) => Vec2s._(ptr);
  factory Vec2s.fromNative(cvg.Vec2s v) {
    final p = calloc<cvg.Vec2s>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2s._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec2s get ref => ptr.ref;
  @override
  String toString() => "Vec2s($val1, $val2)";
}

/// short
class Vec3s extends CvVec<cvg.Vec3s> {
  Vec3s._(ffi.Pointer<cvg.Vec3s> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec3s(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3s>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3s._(p);
  }

  factory Vec3s.fromPointer(ffi.Pointer<cvg.Vec3s> ptr) => Vec3s._(ptr);
  factory Vec3s.fromNative(cvg.Vec3s v) {
    final p = calloc<cvg.Vec3s>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3s._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec3s get ref => ptr.ref;
  @override
  String toString() => "Vec3s($val1, $val2, $val3)";
}

/// short
class Vec4s extends CvVec<cvg.Vec4s> {
  Vec4s._(ffi.Pointer<cvg.Vec4s> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec4s(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4s>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4s._(p);
  }

  factory Vec4s.fromPointer(ffi.Pointer<cvg.Vec4s> ptr) => Vec4s._(ptr);
  factory Vec4s.fromNative(cvg.Vec4s v) {
    final p = calloc<cvg.Vec4s>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4s._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  int get val4 => ref.val4;
  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec4s get ref => ptr.ref;
  @override
  String toString() => "Vec4s($val1, $val2, $val3, $val4)";
}

/// int
class Vec2i extends CvVec<cvg.Vec2i> {
  Vec2i._(ffi.Pointer<cvg.Vec2i> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec2i(int v1, int v2) {
    final p = calloc<cvg.Vec2i>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2i._(p);
  }

  factory Vec2i.fromPointer(ffi.Pointer<cvg.Vec2i> ptr) => Vec2i._(ptr);
  factory Vec2i.fromNative(cvg.Vec2i v) {
    final p = calloc<cvg.Vec2i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2i._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec2i get ref => ptr.ref;
  @override
  String toString() => "Vec2i($val1, $val2)";
}

/// int
class Vec3i extends CvVec<cvg.Vec3i> {
  Vec3i._(ffi.Pointer<cvg.Vec3i> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec3i(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3i>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3i._(p);
  }

  factory Vec3i.fromPointer(ffi.Pointer<cvg.Vec3i> ptr) => Vec3i._(ptr);
  factory Vec3i.fromNative(cvg.Vec3i v) {
    final p = calloc<cvg.Vec3i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3i._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec3i get ref => ptr.ref;
  @override
  String toString() => "Vec3i($val1, $val2, $val3)";
}

/// int
class Vec4i extends CvVec<cvg.Vec4i> {
  Vec4i._(ffi.Pointer<cvg.Vec4i> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec4i(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4i>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4i._(p);
  }

  factory Vec4i.fromPointer(ffi.Pointer<cvg.Vec4i> ptr) => Vec4i._(ptr);
  factory Vec4i.fromNative(cvg.Vec4i v) {
    final p = calloc<cvg.Vec4i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4i._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  int get val4 => ref.val4;
  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec4i get ref => ptr.ref;
  @override
  String toString() => "Vec4i($val1, $val2, $val3, $val4)";
}

/// int
class Vec6i extends CvVec<cvg.Vec6i> {
  Vec6i._(ffi.Pointer<cvg.Vec6i> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec6i(int v1, int v2, int v3, int v4, int v5, int v6) {
    final p = calloc<cvg.Vec6i>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4
      ..ref.val5 = v5
      ..ref.val6 = v6;
    return Vec6i._(p);
  }

  factory Vec6i.fromPointer(ffi.Pointer<cvg.Vec6i> ptr) => Vec6i._(ptr);
  factory Vec6i.fromNative(cvg.Vec6i v) {
    final p = calloc<cvg.Vec6i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4
      ..ref.val5 = v.val5
      ..ref.val6 = v.val6;
    return Vec6i._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  int get val4 => ref.val4;
  int get val5 => ref.val5;
  int get val6 => ref.val6;
  @override
  List<int> get val => [val1, val2, val3, val4, val5, val6];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec6i get ref => ptr.ref;
  @override
  String toString() => "Vec6i($val1, $val2, $val3, $val4, $val5, $val6)";
}

/// int
class Vec8i extends CvVec<cvg.Vec8i> {
  Vec8i._(ffi.Pointer<cvg.Vec8i> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec8i(int v1, int v2, int v3, int v4, int v5, int v6, int v7, int v8) {
    final p = calloc<cvg.Vec8i>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4
      ..ref.val5 = v5
      ..ref.val6 = v6
      ..ref.val7 = v7
      ..ref.val8 = v8;
    return Vec8i._(p);
  }

  factory Vec8i.fromPointer(ffi.Pointer<cvg.Vec8i> ptr) => Vec8i._(ptr);
  factory Vec8i.fromNative(cvg.Vec8i v) {
    final p = calloc<cvg.Vec8i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4
      ..ref.val5 = v.val5
      ..ref.val6 = v.val6
      ..ref.val7 = v.val7
      ..ref.val8 = v.val8;
    return Vec8i._(p);
  }

  int get val1 => ref.val1;
  int get val2 => ref.val2;
  int get val3 => ref.val3;
  int get val4 => ref.val4;
  int get val5 => ref.val5;
  int get val6 => ref.val6;
  int get val7 => ref.val7;
  int get val8 => ref.val8;
  @override
  List<int> get val => [val1, val2, val3, val4, val5, val6, val7, val8];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<int> get props => val;

  @override
  cvg.Vec8i get ref => ptr.ref;
  @override
  String toString() => "Vec8i($val1, $val2, $val3, $val4, $val5, $val6, $val7, $val8)";
}

/// float
class Vec2f extends CvVec<cvg.Vec2f> {
  Vec2f._(ffi.Pointer<cvg.Vec2f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec2f(double v1, double v2) {
    final p = calloc<cvg.Vec2f>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2f._(p);
  }

  factory Vec2f.fromPointer(ffi.Pointer<cvg.Vec2f> ptr) => Vec2f._(ptr);
  factory Vec2f.fromNative(cvg.Vec2f v) {
    final p = calloc<cvg.Vec2f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2f._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  @override
  List<double> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec2f get ref => ptr.ref;
  @override
  String toString() => "Vec2f(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)})";
}

/// float
class Vec3f extends CvVec<cvg.Vec3f> {
  Vec3f._(ffi.Pointer<cvg.Vec3f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec3f(double v1, double v2, double v3) {
    final p = calloc<cvg.Vec3f>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3f._(p);
  }

  factory Vec3f.fromPointer(ffi.Pointer<cvg.Vec3f> ptr) => Vec3f._(ptr);
  factory Vec3f.fromNative(cvg.Vec3f v) {
    final p = calloc<cvg.Vec3f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3f._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  double get val3 => ref.val3;
  @override
  List<double> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec3f get ref => ptr.ref;
  @override
  String toString() =>
      "Vec3f(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)})";
}

/// float
class Vec4f extends CvVec<cvg.Vec4f> {
  Vec4f._(ffi.Pointer<cvg.Vec4f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec4f(double v1, double v2, double v3, double v4) {
    final p = calloc<cvg.Vec4f>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4f._(p);
  }

  factory Vec4f.fromPointer(ffi.Pointer<cvg.Vec4f> ptr) => Vec4f._(ptr);
  factory Vec4f.fromNative(cvg.Vec4f v) {
    final p = calloc<cvg.Vec4f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4f._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  double get val3 => ref.val3;
  double get val4 => ref.val4;
  @override
  List<double> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec4f get ref => ptr.ref;
  @override
  String toString() =>
      "Vec4f(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)}, ${val4.toStringAsFixed(3)})";
}

/// float
class Vec6f extends CvVec<cvg.Vec6f> {
  Vec6f._(ffi.Pointer<cvg.Vec6f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec6f(double v1, double v2, double v3, double v4, double v5, double v6) {
    final p = calloc<cvg.Vec6f>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4
      ..ref.val5 = v5
      ..ref.val6 = v6;
    return Vec6f._(p);
  }

  factory Vec6f.fromPointer(ffi.Pointer<cvg.Vec6f> ptr) => Vec6f._(ptr);
  factory Vec6f.fromNative(cvg.Vec6f v) {
    final p = calloc<cvg.Vec6f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4
      ..ref.val5 = v.val5
      ..ref.val6 = v.val6;
    return Vec6f._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  double get val3 => ref.val3;
  double get val4 => ref.val4;
  double get val5 => ref.val5;
  double get val6 => ref.val6;
  @override
  List<double> get val => [val1, val2, val3, val4, val5, val6];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec6f get ref => ptr.ref;
  @override
  String toString() =>
      "Vec6f(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)}, ${val4.toStringAsFixed(3)}, ${val5.toStringAsFixed(3)}, ${val6.toStringAsFixed(3)})";
}

/// double
class Vec2d extends CvVec<cvg.Vec2d> {
  Vec2d._(ffi.Pointer<cvg.Vec2d> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec2d(double v1, double v2) {
    final p = calloc<cvg.Vec2d>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2d._(p);
  }

  factory Vec2d.fromPointer(ffi.Pointer<cvg.Vec2d> ptr) => Vec2d._(ptr);
  factory Vec2d.fromNative(cvg.Vec2d v) {
    final p = calloc<cvg.Vec2d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2d._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  @override
  List<double> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec2d get ref => ptr.ref;
  @override
  String toString() => "Vec2d(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)})";
}

/// double
class Vec3d extends CvVec<cvg.Vec3d> {
  Vec3d._(ffi.Pointer<cvg.Vec3d> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec3d(double v1, double v2, double v3) {
    final p = calloc<cvg.Vec3d>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3d._(p);
  }

  factory Vec3d.fromPointer(ffi.Pointer<cvg.Vec3d> ptr) => Vec3d._(ptr);
  factory Vec3d.fromNative(cvg.Vec3d v) {
    final p = calloc<cvg.Vec3d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3d._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  double get val3 => ref.val3;
  @override
  List<double> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec3d get ref => ptr.ref;
  @override
  String toString() =>
      "Vec3d(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)})";
}

/// double
class Vec4d extends CvVec<cvg.Vec4d> {
  Vec4d._(ffi.Pointer<cvg.Vec4d> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec4d(double v1, double v2, double v3, double v4) {
    final p = calloc<cvg.Vec4d>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4d._(p);
  }

  factory Vec4d.fromPointer(ffi.Pointer<cvg.Vec4d> ptr) => Vec4d._(ptr);
  factory Vec4d.fromNative(cvg.Vec4d v) {
    final p = calloc<cvg.Vec4d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4d._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  double get val3 => ref.val3;
  double get val4 => ref.val4;
  @override
  List<double> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec4d get ref => ptr.ref;
  @override
  String toString() =>
      "Vec4d(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)}, ${val4.toStringAsFixed(3)})";
}

/// double
class Vec6d extends CvVec<cvg.Vec6d> {
  Vec6d._(ffi.Pointer<cvg.Vec6d> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory Vec6d(double v1, double v2, double v3, double v4, double v5, double v6) {
    final p = calloc<cvg.Vec6d>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4
      ..ref.val5 = v5
      ..ref.val6 = v6;
    return Vec6d._(p);
  }

  factory Vec6d.fromPointer(ffi.Pointer<cvg.Vec6d> ptr) => Vec6d._(ptr);
  factory Vec6d.fromNative(cvg.Vec6d v) {
    final p = calloc<cvg.Vec6d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4
      ..ref.val5 = v.val5
      ..ref.val6 = v.val6;
    return Vec6d._(p);
  }

  double get val1 => ref.val1;
  double get val2 => ref.val2;
  double get val3 => ref.val3;
  double get val4 => ref.val4;
  double get val5 => ref.val5;
  double get val6 => ref.val6;
  @override
  List<double> get val => [val1, val2, val3, val4, val5, val6];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<double> get props => val;

  @override
  cvg.Vec6d get ref => ptr.ref;
  @override
  String toString() =>
      "Vec6d(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)}, ${val4.toStringAsFixed(3)}, ${val5.toStringAsFixed(3)}, ${val6.toStringAsFixed(3)})";
}
