import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'vec.dart';

abstract class CvVec<T extends ffi.Struct> extends CvStruct<T> {
  CvVec.fromPointer(super.ptr) : super.fromPointer();
  List<num> get val;
}

/// uchar
class Vec2b extends CvVec<cvg.Vec2b> {
  Vec2b._(ffi.Pointer<cvg.Vec2b> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec2b(int v1, int v2) {
    final p = calloc<cvg.Vec2b>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2b._(p);
  }

  factory Vec2b.fromPointer(ffi.Pointer<cvg.Vec2b> ptr, [bool attach = true]) => Vec2b._(ptr, attach);
  factory Vec2b.fromNative(cvg.Vec2b v) {
    final p = calloc<cvg.Vec2b>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2b._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec2b get ref => ptr.ref;
  @override
  String toString() => "Vec2b($val1, $val2)";
}

/// uchar
class Vec3b extends CvVec<cvg.Vec3b> {
  Vec3b._(ffi.Pointer<cvg.Vec3b> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec3b(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3b>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3b._(p);
  }

  factory Vec3b.fromPointer(ffi.Pointer<cvg.Vec3b> ptr, [bool attach = true]) => Vec3b._(ptr, attach);
  factory Vec3b.fromNative(cvg.Vec3b v) {
    final p = calloc<cvg.Vec3b>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3b._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec3b get ref => ptr.ref;
  @override
  String toString() => "Vec3b($val1, $val2, $val3)";
}

/// uchar
class Vec4b extends CvVec<cvg.Vec4b> {
  Vec4b._(ffi.Pointer<cvg.Vec4b> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec4b(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4b>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4b._(p);
  }

  factory Vec4b.fromPointer(ffi.Pointer<cvg.Vec4b> ptr, [bool attach = true]) => Vec4b._(ptr, attach);
  factory Vec4b.fromNative(cvg.Vec4b v) {
    final p = calloc<cvg.Vec4b>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4b._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  int get val4 => ref.val4;
  set val4(int v) => ref.val4 = v;

  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec4b get ref => ptr.ref;
  @override
  String toString() => "Vec4b($val1, $val2, $val3, $val4)";
}

/// ushort
class Vec2w extends CvVec<cvg.Vec2w> {
  Vec2w._(ffi.Pointer<cvg.Vec2w> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec2w(int v1, int v2) {
    final p = calloc<cvg.Vec2w>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2w._(p);
  }

  factory Vec2w.fromPointer(ffi.Pointer<cvg.Vec2w> ptr, [bool attach = true]) => Vec2w._(ptr, attach);
  factory Vec2w.fromNative(cvg.Vec2w v) {
    final p = calloc<cvg.Vec2w>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2w._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec2w get ref => ptr.ref;
  @override
  String toString() => "Vec2w($val1, $val2)";
}

/// ushort
class Vec3w extends CvVec<cvg.Vec3w> {
  Vec3w._(ffi.Pointer<cvg.Vec3w> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec3w(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3w>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3w._(p);
  }

  factory Vec3w.fromPointer(ffi.Pointer<cvg.Vec3w> ptr, [bool attach = true]) => Vec3w._(ptr, attach);
  factory Vec3w.fromNative(cvg.Vec3w v) {
    final p = calloc<cvg.Vec3w>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3w._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec3w get ref => ptr.ref;
  @override
  String toString() => "Vec3w($val1, $val2, $val3)";
}

/// ushort
class Vec4w extends CvVec<cvg.Vec4w> {
  Vec4w._(ffi.Pointer<cvg.Vec4w> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec4w(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4w>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4w._(p);
  }

  factory Vec4w.fromPointer(ffi.Pointer<cvg.Vec4w> ptr, [bool attach = true]) => Vec4w._(ptr, attach);
  factory Vec4w.fromNative(cvg.Vec4w v) {
    final p = calloc<cvg.Vec4w>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4w._(p);
  }
  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  int get val4 => ref.val4;
  set val4(int v) => ref.val4 = v;

  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec4w get ref => ptr.ref;
  @override
  String toString() => "Vec4w($val1, $val2, $val3, $val4)";
}

/// short
class Vec2s extends CvVec<cvg.Vec2s> {
  Vec2s._(ffi.Pointer<cvg.Vec2s> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec2s(int v1, int v2) {
    final p = calloc<cvg.Vec2s>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2s._(p);
  }

  factory Vec2s.fromPointer(ffi.Pointer<cvg.Vec2s> ptr, [bool attach = true]) => Vec2s._(ptr, attach);
  factory Vec2s.fromNative(cvg.Vec2s v) {
    final p = calloc<cvg.Vec2s>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2s._(p);
  }
  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec2s get ref => ptr.ref;
  @override
  String toString() => "Vec2s($val1, $val2)";
}

/// short
class Vec3s extends CvVec<cvg.Vec3s> {
  Vec3s._(ffi.Pointer<cvg.Vec3s> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec3s(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3s>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3s._(p);
  }

  factory Vec3s.fromPointer(ffi.Pointer<cvg.Vec3s> ptr, [bool attach = true]) => Vec3s._(ptr, attach);
  factory Vec3s.fromNative(cvg.Vec3s v) {
    final p = calloc<cvg.Vec3s>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3s._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec3s get ref => ptr.ref;
  @override
  String toString() => "Vec3s($val1, $val2, $val3)";
}

/// short
class Vec4s extends CvVec<cvg.Vec4s> {
  Vec4s._(ffi.Pointer<cvg.Vec4s> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec4s(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4s>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4s._(p);
  }

  factory Vec4s.fromPointer(ffi.Pointer<cvg.Vec4s> ptr, [bool attach = true]) => Vec4s._(ptr, attach);
  factory Vec4s.fromNative(cvg.Vec4s v) {
    final p = calloc<cvg.Vec4s>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4s._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  int get val4 => ref.val4;
  set val4(int v) => ref.val4 = v;

  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec4s get ref => ptr.ref;
  @override
  String toString() => "Vec4s($val1, $val2, $val3, $val4)";
}

/// int
class Vec2i extends CvVec<cvg.Vec2i> {
  Vec2i._(ffi.Pointer<cvg.Vec2i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec2i(int v1, int v2) {
    final p = calloc<cvg.Vec2i>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2i._(p);
  }

  factory Vec2i.fromPointer(ffi.Pointer<cvg.Vec2i> ptr, [bool attach = true]) => Vec2i._(ptr, attach);
  factory Vec2i.fromNative(cvg.Vec2i v) {
    final p = calloc<cvg.Vec2i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2i._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  @override
  List<int> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec2i get ref => ptr.ref;
  @override
  String toString() => "Vec2i($val1, $val2)";
}

/// int
class Vec3i extends CvVec<cvg.Vec3i> {
  Vec3i._(ffi.Pointer<cvg.Vec3i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec3i(int v1, int v2, int v3) {
    final p = calloc<cvg.Vec3i>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3i._(p);
  }

  factory Vec3i.fromPointer(ffi.Pointer<cvg.Vec3i> ptr, [bool attach = true]) => Vec3i._(ptr, attach);
  factory Vec3i.fromNative(cvg.Vec3i v) {
    final p = calloc<cvg.Vec3i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3i._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  @override
  List<int> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec3i get ref => ptr.ref;
  @override
  String toString() => "Vec3i($val1, $val2, $val3)";
}

/// int
class Vec4i extends CvVec<cvg.Vec4i> {
  Vec4i._(ffi.Pointer<cvg.Vec4i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec4i(int v1, int v2, int v3, int v4) {
    final p = calloc<cvg.Vec4i>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4i._(p);
  }

  factory Vec4i.fromPointer(ffi.Pointer<cvg.Vec4i> ptr, [bool attach = true]) => Vec4i._(ptr, attach);
  factory Vec4i.fromNative(cvg.Vec4i v) {
    final p = calloc<cvg.Vec4i>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4i._(p);
  }

  int get val1 => ref.val1;
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  int get val4 => ref.val4;
  set val4(int v) => ref.val4 = v;

  @override
  List<int> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec4i get ref => ptr.ref;
  @override
  String toString() => "Vec4i($val1, $val2, $val3, $val4)";
}

/// int
class Vec6i extends CvVec<cvg.Vec6i> {
  Vec6i._(ffi.Pointer<cvg.Vec6i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
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

  factory Vec6i.fromPointer(ffi.Pointer<cvg.Vec6i> ptr, [bool attach = true]) => Vec6i._(ptr, attach);
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
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  int get val4 => ref.val4;
  set val4(int v) => ref.val4 = v;

  int get val5 => ref.val5;
  set val5(int v) => ref.val5 = v;

  int get val6 => ref.val6;
  set val6(int v) => ref.val6 = v;

  @override
  List<int> get val => [val1, val2, val3, val4, val5, val6];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec6i get ref => ptr.ref;
  @override
  String toString() => "Vec6i($val1, $val2, $val3, $val4, $val5, $val6)";
}

/// int
class Vec8i extends CvVec<cvg.Vec8i> {
  Vec8i._(ffi.Pointer<cvg.Vec8i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
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

  factory Vec8i.fromPointer(ffi.Pointer<cvg.Vec8i> ptr, [bool attach = true]) => Vec8i._(ptr, attach);
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
  set val1(int v) => ref.val1 = v;

  int get val2 => ref.val2;
  set val2(int v) => ref.val2 = v;

  int get val3 => ref.val3;
  set val3(int v) => ref.val3 = v;

  int get val4 => ref.val4;
  set val4(int v) => ref.val4 = v;

  int get val5 => ref.val5;
  set val5(int v) => ref.val5 = v;

  int get val6 => ref.val6;
  set val6(int v) => ref.val6 = v;

  int get val7 => ref.val7;
  set val7(int v) => ref.val7 = v;

  int get val8 => ref.val8;
  set val8(int v) => ref.val8 = v;

  @override
  List<int> get val => [val1, val2, val3, val4, val5, val6, val7, val8];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<int> get props => val;

  @override
  cvg.Vec8i get ref => ptr.ref;
  @override
  String toString() => "Vec8i($val1, $val2, $val3, $val4, $val5, $val6, $val7, $val8)";
}

/// float
class Vec2f extends CvVec<cvg.Vec2f> {
  Vec2f._(ffi.Pointer<cvg.Vec2f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec2f(double v1, double v2) {
    final p = calloc<cvg.Vec2f>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2f._(p);
  }

  factory Vec2f.fromPointer(ffi.Pointer<cvg.Vec2f> ptr, [bool attach = true]) => Vec2f._(ptr, attach);
  factory Vec2f.fromNative(cvg.Vec2f v) {
    final p = calloc<cvg.Vec2f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2f._(p);
  }

  double get val1 => ref.val1;
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  @override
  List<double> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<double> get props => val;

  @override
  cvg.Vec2f get ref => ptr.ref;
  @override
  String toString() => "Vec2f(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)})";
}

/// float
class Vec3f extends CvVec<cvg.Vec3f> {
  Vec3f._(ffi.Pointer<cvg.Vec3f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec3f(double v1, double v2, double v3) {
    final p = calloc<cvg.Vec3f>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3f._(p);
  }

  factory Vec3f.fromPointer(ffi.Pointer<cvg.Vec3f> ptr, [bool attach = true]) => Vec3f._(ptr, attach);
  factory Vec3f.fromNative(cvg.Vec3f v) {
    final p = calloc<cvg.Vec3f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3f._(p);
  }

  double get val1 => ref.val1;
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  double get val3 => ref.val3;
  set val3(double v) => ref.val3 = v;

  @override
  List<double> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

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
  Vec4f._(ffi.Pointer<cvg.Vec4f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec4f(double v1, double v2, double v3, double v4) {
    final p = calloc<cvg.Vec4f>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4f._(p);
  }

  factory Vec4f.fromPointer(ffi.Pointer<cvg.Vec4f> ptr, [bool attach = true]) => Vec4f._(ptr, attach);
  factory Vec4f.fromNative(cvg.Vec4f v) {
    final p = calloc<cvg.Vec4f>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4f._(p);
  }

  double get val1 => ref.val1;
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  double get val3 => ref.val3;
  set val3(double v) => ref.val3 = v;

  double get val4 => ref.val4;
  set val4(double v) => ref.val4 = v;

  @override
  List<double> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

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
  Vec6f._(ffi.Pointer<cvg.Vec6f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
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

  factory Vec6f.fromPointer(ffi.Pointer<cvg.Vec6f> ptr, [bool attach = true]) => Vec6f._(ptr, attach);
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
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  double get val3 => ref.val3;
  set val3(double v) => ref.val3 = v;

  double get val4 => ref.val4;
  set val4(double v) => ref.val4 = v;

  double get val5 => ref.val5;
  set val5(double v) => ref.val5 = v;

  double get val6 => ref.val6;
  set val6(double v) => ref.val6 = v;

  @override
  List<double> get val => [val1, val2, val3, val4, val5, val6];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

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
  Vec2d._(ffi.Pointer<cvg.Vec2d> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec2d(double v1, double v2) {
    final p = calloc<cvg.Vec2d>()
      ..ref.val1 = v1
      ..ref.val2 = v2;
    return Vec2d._(p);
  }

  factory Vec2d.fromPointer(ffi.Pointer<cvg.Vec2d> ptr, [bool attach = true]) => Vec2d._(ptr, attach);
  factory Vec2d.fromNative(cvg.Vec2d v) {
    final p = calloc<cvg.Vec2d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2;
    return Vec2d._(p);
  }

  double get val1 => ref.val1;
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  @override
  List<double> get val => [val1, val2];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<double> get props => val;

  @override
  cvg.Vec2d get ref => ptr.ref;
  @override
  String toString() => "Vec2d(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)})";
}

/// double
class Vec3d extends CvVec<cvg.Vec3d> {
  Vec3d._(ffi.Pointer<cvg.Vec3d> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec3d(double v1, double v2, double v3) {
    final p = calloc<cvg.Vec3d>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3;
    return Vec3d._(p);
  }

  factory Vec3d.fromPointer(ffi.Pointer<cvg.Vec3d> ptr, [bool attach = true]) => Vec3d._(ptr, attach);
  factory Vec3d.fromNative(cvg.Vec3d v) {
    final p = calloc<cvg.Vec3d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3;
    return Vec3d._(p);
  }

  double get val1 => ref.val1;
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  double get val3 => ref.val3;
  set val3(double v) => ref.val3 = v;

  @override
  List<double> get val => [val1, val2, val3];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

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
  Vec4d._(ffi.Pointer<cvg.Vec4d> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Vec4d(double v1, double v2, double v3, double v4) {
    final p = calloc<cvg.Vec4d>()
      ..ref.val1 = v1
      ..ref.val2 = v2
      ..ref.val3 = v3
      ..ref.val4 = v4;
    return Vec4d._(p);
  }

  factory Vec4d.fromPointer(ffi.Pointer<cvg.Vec4d> ptr, [bool attach = true]) => Vec4d._(ptr, attach);
  factory Vec4d.fromNative(cvg.Vec4d v) {
    final p = calloc<cvg.Vec4d>()
      ..ref.val1 = v.val1
      ..ref.val2 = v.val2
      ..ref.val3 = v.val3
      ..ref.val4 = v.val4;
    return Vec4d._(p);
  }

  double get val1 => ref.val1;
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  double get val3 => ref.val3;
  set val3(double v) => ref.val3 = v;

  double get val4 => ref.val4;
  set val4(double v) => ref.val4 = v;

  @override
  List<double> get val => [val1, val2, val3, val4];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

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
  Vec6d._(ffi.Pointer<cvg.Vec6d> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
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

  factory Vec6d.fromPointer(ffi.Pointer<cvg.Vec6d> ptr, [bool attach = true]) => Vec6d._(ptr, attach);
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
  set val1(double v) => ref.val1 = v;

  double get val2 => ref.val2;
  set val2(double v) => ref.val2 = v;

  double get val3 => ref.val3;
  set val3(double v) => ref.val3 = v;

  double get val4 => ref.val4;
  set val4(double v) => ref.val4 = v;

  double get val5 => ref.val5;
  set val5(double v) => ref.val5 = v;

  double get val6 => ref.val6;
  set val6(double v) => ref.val6 = v;

  @override
  List<double> get val => [val1, val2, val3, val4, val5, val6];

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<double> get props => val;

  @override
  cvg.Vec6d get ref => ptr.ref;
  @override
  String toString() =>
      "Vec6d(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)}, ${val4.toStringAsFixed(3)}, ${val5.toStringAsFixed(3)}, ${val6.toStringAsFixed(3)})";
}

class VecVec4i extends Vec<cvg.VecVec4i, Vec4i> {
  VecVec4i.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVec4i.fromList(List<Vec4i> pts) => VecVec4i.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecVec4i.generate(int length, Vec4i Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVec4i>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.Vec4i>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVec4i.fromPointer(pp);
  }

  @override
  VecVec4i clone() => VecVec4i.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<Vec4i> get iterator => VecVec4iIterator(ref);

  @override
  cvg.VecVec4i get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();
}

class VecVec4iIterator extends VecIterator<Vec4i> {
  VecVec4iIterator(this.ref);
  cvg.VecVec4i ref;

  @override
  int get length => ref.length;

  @override
  Vec4i operator [](int idx) => Vec4i.fromPointer(ref.ptr + idx, false);
}

class VecVec4f extends Vec<cvg.VecVec4f, Vec4f> {
  VecVec4f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVec4f.fromList(List<Vec4f> pts) => VecVec4f.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecVec4f.generate(int length, Vec4f Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVec4f>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.Vec4f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVec4f.fromPointer(pp);
  }

  @override
  VecVec4f clone() => VecVec4f.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<Vec4f> get iterator => VecVec4fIterator(ref);

  @override
  cvg.VecVec4f get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();
}

class VecVec4fIterator extends VecIterator<Vec4f> {
  VecVec4fIterator(this.ref);
  cvg.VecVec4f ref;

  @override
  int get length => ref.length;

  @override
  Vec4f operator [](int idx) => Vec4f.fromPointer(ref.ptr + idx, false);
}

class VecVec6f extends Vec<cvg.VecVec6f, Vec6f> {
  VecVec6f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVec6f.fromList(List<Vec6f> pts) => VecVec6f.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecVec6f.generate(int length, Vec6f Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVec6f>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.Vec6f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVec6f.fromPointer(pp);
  }

  @override
  VecVec6f clone() => VecVec6f.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<Vec6f> get iterator => VecVec6fIterator(ref);

  @override
  cvg.VecVec6f get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();
}

class VecVec6fIterator extends VecIterator<Vec6f> {
  VecVec6fIterator(this.ref);
  cvg.VecVec6f ref;

  @override
  int get length => ref.length;

  @override
  Vec6f operator [](int idx) => Vec6f.fromPointer(ref.ptr + idx, false);
}

extension VecVec4iExtension on List<Vec4i> {
  VecVec4i get cvd => VecVec4i.fromList(this);
}

extension VecVec4fExtension on List<Vec4f> {
  VecVec4f get cvd => VecVec4f.fromList(this);
}

extension VecVec6fExtension on List<Vec6f> {
  VecVec6f get cvd => VecVec6f.fromList(this);
}
