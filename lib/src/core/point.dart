import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class Point extends CvStruct<cvg.Point> {
  Point._(ffi.Pointer<cvg.Point> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point(int x, int y) {
    final ptr = calloc<cvg.Point>()
      ..ref.x = x
      ..ref.y = y;
    return Point._(ptr);
  }
  factory Point.fromNative(cvg.Point p) => Point(p.x, p.y);
  factory Point.fromPointer(ffi.Pointer<cvg.Point> ptr, [bool attach = true]) =>
      Point._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ref.x;
  int get y => ref.y;

  @override
  cvg.Point get ref => ptr.ref;
  @override
  String toString() => 'Point($x, $y)';
  @override
  List<int> get props => [x, y];
}

class Point2f extends CvStruct<cvg.Point2f> {
  Point2f._(ffi.Pointer<cvg.Point2f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point2f(double x, double y) {
    final ptr = calloc<cvg.Point2f>()
      ..ref.x = x
      ..ref.y = y;
    return Point2f._(ptr);
  }
  factory Point2f.fromNative(cvg.Point2f p) => Point2f(p.x, p.y);
  factory Point2f.fromPointer(ffi.Pointer<cvg.Point2f> ptr, [bool attach = true]) =>
      Point2f._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  double get y => ptr.ref.y;

  @override
  cvg.Point2f get ref => ptr.ref;
  @override
  String toString() => 'Point2f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y];
}

class Point3f extends CvStruct<cvg.Point3f> {
  Point3f._(ffi.Pointer<cvg.Point3f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point3f(double x, double y, double z) {
    final ptr = calloc<cvg.Point3f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3f._(ptr);
  }
  factory Point3f.fromNative(cvg.Point3f p) => Point3f(p.x, p.y, p.z);
  factory Point3f.fromPointer(ffi.Pointer<cvg.Point3f> ptr, [bool attach = true]) =>
      Point3f._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  double get y => ptr.ref.y;
  double get z => ptr.ref.z;

  @override
  cvg.Point3f get ref => ptr.ref;
  @override
  String toString() =>
      'Point3f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}, ${z.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y, z];
}

class VecPoint extends Vec<Point> implements CvStruct<cvg.VecPoint> {
  VecPoint._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VecPoint([int length = 0, int x = 0, int y = 0]) {
    return cvRunArena<VecPoint>((arena) {
      final p = arena<cvg.Point>(length);
      for (int i = 0; i < length; i++) {
        final point = arena<cvg.Point>()
          ..ref.x = x
          ..ref.y = y;
        p[i] = point.ref;
      }
      final pp = calloc<cvg.VecPoint>();
      cvRun(() => CFFI.VecPoint_NewFromPointer(p, length, pp));
      return VecPoint._(pp);
    });
  }

  factory VecPoint.fromPointer(cvg.VecPointPtr ptr, [bool attach = true]) =>
      VecPoint._(ptr, attach);

  /// Copy data from [cvg.VecPoint.ptr]
  factory VecPoint.fromVec(cvg.VecPoint ptr) {
    final p = calloc<cvg.VecPoint>();
    cvRun(() => CFFI.VecPoint_NewFromVec(ptr, p));
    final vec = VecPoint._(p);
    return vec;
  }
  factory VecPoint.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint>();
    cvRun(() => CFFI.VecPoint_NewFromMat(mat.ref, p));
    final vec = VecPoint._(p);
    return vec;
  }
  factory VecPoint.fromList(List<Point> pts) {
    final p = calloc<cvg.VecPoint>();
    cvRun(() => CFFI.VecPoint_New(p));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i];
      cvRun(() => CFFI.VecPoint_Append(p.ref, point.ref));
    }
    final vec = VecPoint._(p);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecPoint_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  @override
  cvg.VecPointPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecPointPtr>(CFFI.addresses.VecPoint_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecPoint_Close(ptr);
  }

  @override
  Iterator<Point> get iterator => VecPointIterator(ref);

  @override
  cvg.VecPoint get ref => ptr.ref;
}

class VecPointIterator extends VecIterator<Point> {
  VecPointIterator(this.ptr);
  cvg.VecPoint ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecPoint_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  Point operator [](int idx) {
    final p = calloc<cvg.Point>();
    cvRun(() => CFFI.VecPoint_At(ptr, idx, p));
    return Point.fromPointer(p);
  }
}

class VecPoint2f extends Vec<Point2f> implements CvStruct<cvg.VecPoint2f> {
  VecPoint2f._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecPoint2f([int length = 0, double x = 0, double y = 0]) {
    return cvRunArena<VecPoint2f>((arena) {
      final p = arena<cvg.Point2f>(length);
      for (int i = 0; i < length; i++) {
        final point = arena<cvg.Point2f>()
          ..ref.x = x
          ..ref.y = y;
        p[i] = point.ref;
      }
      final pp = calloc<cvg.VecPoint2f>();
      cvRun(() => CFFI.VecPoint2f_NewFromPointer(p, length, pp));
      return VecPoint2f._(pp);
    });
  }
  factory VecPoint2f.fromPointer(cvg.VecPoint2fPtr ptr, [bool attach = true]) =>
      VecPoint2f._(ptr, attach);
  factory VecPoint2f.fromVec(cvg.VecPoint2f ptr) {
    final p = calloc<cvg.VecPoint2f>();
    cvRun(() => CFFI.VecPoint2f_NewFromVec(ptr, p));
    final vec = VecPoint2f._(p);
    return vec;
  }
  factory VecPoint2f.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint2f>();
    cvRun(() => CFFI.VecPoint2f_NewFromMat(mat.ref, p));
    final vec = VecPoint2f._(p);
    return vec;
  }
  factory VecPoint2f.fromList(List<Point2f> pts) {
    final ptr = calloc<cvg.VecPoint2f>();
    cvRun(() => CFFI.VecPoint2f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final p = pts[i];
      cvRun(() => CFFI.VecPoint2f_Append(ptr.ref, p.ref));
    }
    final vec = VecPoint2f._(ptr);
    return vec;
  }

  @override
  cvg.VecPoint2fPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecPoint2fPtr>(CFFI.addresses.VecPoint2f_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecPoint2f_Close(ptr);
  }

  @override
  Iterator<Point2f> get iterator => VecPoint2fIterator(ref);

  @override
  cvg.VecPoint2f get ref => ptr.ref;
}

class VecPoint2fIterator extends VecIterator<Point2f> {
  VecPoint2fIterator(this.ptr);
  cvg.VecPoint2f ptr;

  @override
  int get length {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VecPoint2f_Size(ptr, p));
      final len = p.value;
      return len;
    });
  }

  @override
  Point2f operator [](int idx) {
    final p = calloc<cvg.Point2f>();
    cvRun(() => CFFI.VecPoint2f_At(ptr, idx, p));
    return Point2f.fromPointer(p);
  }
}

class VecPoint3f extends Vec<Point3f> implements CvStruct<cvg.VecPoint3f> {
  VecPoint3f._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecPoint3f([int length = 0, double x = 0, double y = 0, double z = 0]) {
    return cvRunArena<VecPoint3f>((arena) {
      final p = arena<cvg.Point3f>(length);
      for (int i = 0; i < length; i++) {
        final point = arena<cvg.Point3f>()
          ..ref.x = x
          ..ref.y = y
          ..ref.z = z;
        p[i] = point.ref;
      }
      final pp = calloc<cvg.VecPoint3f>();
      cvRun(() => CFFI.VecPoint3f_NewFromPointer(p, length, pp));
      return VecPoint3f._(pp);
    });
  }
  factory VecPoint3f.fromPointer(cvg.VecPoint3fPtr ptr, [bool attach = true]) =>
      VecPoint3f._(ptr, attach);
  factory VecPoint3f.fromVec(cvg.VecPoint3f ptr) {
    final p = calloc<cvg.VecPoint3f>();
    cvRun(() => CFFI.VecPoint3f_NewFromVec(ptr, p));
    final vec = VecPoint3f._(p);
    return vec;
  }
  factory VecPoint3f.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint3f>();
    cvRun(() => CFFI.VecPoint3f_NewFromMat(mat.ref, p));
    final vec = VecPoint3f._(p);
    return vec;
  }
  factory VecPoint3f.fromList(List<Point3f> pts) {
    final ptr = calloc<cvg.VecPoint3f>();
    cvRun(() => CFFI.VecPoint3f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i];
      cvRun(() => CFFI.VecPoint3f_Append(ptr.ref, point.ref));
    }
    final vec = VecPoint3f._(ptr);
    return vec;
  }

  @override
  cvg.VecPoint3fPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecPoint3fPtr>(CFFI.addresses.VecPoint3f_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecPoint3f_Close(ptr);
  }

  @override
  Iterator<Point3f> get iterator => VecPoint3fIterator(ref);

  @override
  cvg.VecPoint3f get ref => ptr.ref;
}

class VecPoint3fIterator extends VecIterator<Point3f> {
  VecPoint3fIterator(this.ptr);
  cvg.VecPoint3f ptr;

  @override
  int get length {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VecPoint3f_Size(ptr, p));
      final len = p.value;
      return len;
    });
  }

  @override
  Point3f operator [](int idx) {
    final p = calloc<cvg.Point3f>();
    cvRun(() => CFFI.VecPoint3f_At(ptr, idx, p));
    return Point3f.fromPointer(p);
  }
}

// VecVecPoint
class VecVecPoint extends Vec<VecPoint> implements CvStruct<cvg.VecVecPoint> {
  VecVecPoint._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecVecPoint.fromPointer(cvg.VecVecPointPtr ptr, [bool attach = true]) =>
      VecVecPoint._(ptr, attach);
  factory VecVecPoint.fromVec(cvg.VecVecPoint ptr) {
    final p = calloc<cvg.VecVecPoint>();
    cvRun(() => CFFI.VecVecPoint_NewFromVec(ptr, p));
    final vec = VecVecPoint._(p);
    return vec;
  }
  factory VecVecPoint.fromList(List<List<Point>> pts) {
    final ptr = calloc<cvg.VecVecPoint>();
    cvRun(() => CFFI.VecVecPoint_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].cvd;
      cvRun(() => CFFI.VecVecPoint_Append(ptr.ref, point.ref));
    }
    final vec = VecVecPoint._(ptr);
    return vec;
  }

  @override
  cvg.VecVecPointPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecVecPointPtr>(CFFI.addresses.VecVecPoint_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecVecPoint_Close(ptr);
  }

  @override
  Iterator<VecPoint> get iterator => VecVecPointIterator(ref);

  @override
  cvg.VecVecPoint get ref => ptr.ref;
}

class VecVecPointIterator extends VecIterator<VecPoint> {
  VecVecPointIterator(this.ptr);
  cvg.VecVecPoint ptr;

  @override
  int get length => using<int>(
        (arena) {
          final p = arena<ffi.Int>();
          cvRun(() => CFFI.VecVecPoint_Size(ptr, p));
          final len = p.value;
          return len;
        },
      );

  /// return the reference
  @override
  VecPoint operator [](int idx) {
    return cvRunArena<VecPoint>((arena) {
      final p = calloc<cvg.VecPoint>();
      cvRun(() => CFFI.VecVecPoint_At(ptr, idx, p));
      final vec = VecPoint.fromPointer(p, false);
      return vec;
    });
  }
}

class VecVecPoint2f extends Vec<Vec<Point2f>> implements CvStruct<cvg.VecVecPoint2f> {
  VecVecPoint2f._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecVecPoint2f.fromPointer(cvg.VecVecPoint2fPtr ptr, [bool attach = true]) =>
      VecVecPoint2f._(ptr, attach);
  factory VecVecPoint2f.fromVec(cvg.VecVecPoint2f ptr) {
    final p = calloc<cvg.VecVecPoint2f>();
    cvRun(() => CFFI.VecVecPoint2f_NewFromVec(ptr, p));
    final vec = VecVecPoint2f._(p);
    return vec;
  }
  factory VecVecPoint2f.fromList(List<List<Point2f>> pts) {
    final ptr = calloc<cvg.VecVecPoint2f>();
    cvRun(() => CFFI.VecVecPoint2f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].cvd;
      cvRun(() => CFFI.VecVecPoint2f_Append(ptr.ref, point.ref));
    }
    final vec = VecVecPoint2f._(ptr);
    return vec;
  }

  @override
  cvg.VecVecPoint2fPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecVecPoint2fPtr>(CFFI.addresses.VecVecPoint2f_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecVecPoint2f_Close(ptr);
  }

  @override
  Iterator<VecPoint2f> get iterator => VecVecPoint2fIterator(ref);

  @override
  cvg.VecVecPoint2f get ref => ptr.ref;
}

class VecVecPoint2fIterator extends VecIterator<VecPoint2f> {
  VecVecPoint2fIterator(this.ptr);
  cvg.VecVecPoint2f ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecVecPoint2f_Size(ptr, p));
        final len = p.value;
        return len;
      });

  /// return the reference
  @override
  VecPoint2f operator [](int idx) {
    return cvRunArena<VecPoint2f>((arena) {
      final p = calloc<cvg.VecPoint2f>();
      cvRun(() => CFFI.VecVecPoint2f_At(ptr, idx, p));
      final vec = VecPoint2f.fromPointer(p, false);
      return vec;
    });
  }
}

class VecVecPoint3f extends Vec<Vec<Point3f>> implements CvStruct<cvg.VecVecPoint3f> {
  VecVecPoint3f._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VecVecPoint3f.fromPointer(cvg.VecVecPoint3fPtr ptr, [bool attach = true]) =>
      VecVecPoint3f._(ptr, attach);
  factory VecVecPoint3f.fromVec(cvg.VecVecPoint3f ptr) {
    final p = calloc<cvg.VecVecPoint3f>();
    cvRun(() => CFFI.VecVecPoint3f_NewFromVec(ptr, p));
    final vec = VecVecPoint3f._(p);
    return vec;
  }
  factory VecVecPoint3f.fromList(List<List<Point3f>> pts) {
    final ptr = calloc<cvg.VecVecPoint3f>();
    cvRun(() => CFFI.VecVecPoint3f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].cvd;
      cvRun(() => CFFI.VecVecPoint3f_Append(ptr.ref, point.ref));
    }
    final vec = VecVecPoint3f._(ptr);
    return vec;
  }

  @override
  cvg.VecVecPoint3fPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecVecPoint3fPtr>(CFFI.addresses.VecVecPoint3f_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecVecPoint3f_Close(ptr);
  }

  @override
  Iterator<VecPoint3f> get iterator => VecVecPoint3fIterator(ref);

  @override
  cvg.VecVecPoint3f get ref => ptr.ref;
}

class VecVecPoint3fIterator extends VecIterator<VecPoint3f> {
  VecVecPoint3fIterator(this.ptr);
  cvg.VecVecPoint3f ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecVecPoint3f_Size(ptr, p));
        final len = p.value;
        return len;
      });

  /// return the reference
  @override
  VecPoint3f operator [](int idx) {
    return cvRunArena<VecPoint3f>((arena) {
      final p = calloc<cvg.VecPoint3f>();
      cvRun(() => CFFI.VecVecPoint3f_At(ptr, idx, p));
      final vec = VecPoint3f.fromPointer(p, false);
      return vec;
    });
  }
}

extension ListPointExtension on List<Point> {
  VecPoint get cvd => VecPoint.fromList(this);
}

extension ListPoint2fExtension on List<Point2f> {
  VecPoint2f get cvd => VecPoint2f.fromList(this);
}

extension ListPoint3fExtension on List<Point3f> {
  VecPoint3f get cvd => VecPoint3f.fromList(this);
}

extension ListListPointExtension on List<List<Point>> {
  VecVecPoint get cvd => VecVecPoint.fromList(this);
}

extension ListListPoint2fExtension on List<List<Point2f>> {
  VecVecPoint2f get cvd => VecVecPoint2f.fromList(this);
}

extension ListListPoint3fExtension on List<List<Point3f>> {
  VecVecPoint3f get cvd => VecVecPoint3f.fromList(this);
}

extension PointRecordExtension on (int x, int y) {
  ffi.Pointer<cvg.Point> toPoint(Arena arena) {
    final point = arena<cvg.Point>()
      ..ref.x = this.$1
      ..ref.y = this.$2;
    return point;
  }
}

extension Point2fRecordExtension on (double x, double y) {
  ffi.Pointer<cvg.Point2f> toPoint(Arena arena) {
    final point = arena<cvg.Point2f>()
      ..ref.x = this.$1
      ..ref.y = this.$2;
    return point;
  }
}

extension Point3fRecordExtension on (double x, double y, double z) {
  ffi.Pointer<cvg.Point3f> toPoint(Arena arena) {
    final point = arena<cvg.Point3f>()
      ..ref.x = this.$1
      ..ref.y = this.$2
      ..ref.z = this.$3;
    return point;
  }
}
