import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class Point extends CvStruct<cvg.Point> {
  Point._(ffi.Pointer<cvg.Point> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }
  factory Point(int x, int y) {
    final ptr = calloc<cvg.Point>()
      ..ref.x = x
      ..ref.y = y;
    return Point._(ptr);
  }
  factory Point.fromNative(cvg.Point p) => Point(p.x, p.y);
  factory Point.fromPointer(ffi.Pointer<cvg.Point> ptr) => Point._(ptr);

  static final finalizer = Finalizer<ffi.Pointer<cvg.Point>>((p0) => calloc.free(p0));
  int get x => ptr.ref.x;
  int get y => ptr.ref.y;

  @override
  cvg.Point get ref => ptr.ref;
  @override
  cvg.Point toNative() => ptr.ref;

  @override
  String toString() => 'Point($x, $y)';
  @override
  List<int> get props => [x, y];
}

class Point2f extends CvStruct<cvg.Point2f> {
  Point2f._(ffi.Pointer<cvg.Point2f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }
  factory Point2f(double x, double y) {
    final ptr = calloc<cvg.Point2f>()
      ..ref.x = x
      ..ref.y = y;
    return Point2f._(ptr);
  }
  factory Point2f.fromNative(cvg.Point2f p) => Point2f(p.x, p.y);
  factory Point2f.fromPointer(ffi.Pointer<cvg.Point2f> ptr) => Point2f._(ptr);

  static final finalizer = Finalizer<ffi.Pointer<cvg.Point2f>>((p0) => calloc.free(p0));
  double get x => ptr.ref.x;
  double get y => ptr.ref.y;

  @override
  cvg.Point2f get ref => ptr.ref;
  @override
  cvg.Point2f toNative() => ptr.ref;

  @override
  String toString() => 'Point2f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y];
}

class Point3f extends CvStruct<cvg.Point3f> {
  Point3f._(ffi.Pointer<cvg.Point3f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }
  factory Point3f(double x, double y, double z) {
    final ptr = calloc<cvg.Point3f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3f._(ptr);
  }
  factory Point3f.fromNative(cvg.Point3f p) => Point3f(p.x, p.y, p.z);
  factory Point3f.fromPointer(ffi.Pointer<cvg.Point3f> ptr) => Point3f._(ptr);

  static final finalizer = Finalizer<ffi.Pointer<cvg.Point3f>>((p0) => calloc.free(p0));
  double get x => ptr.ref.x;
  double get y => ptr.ref.y;
  double get z => ptr.ref.z;

  @override
  cvg.Point3f get ref => ptr.ref;
  @override
  cvg.Point3f toNative() => ptr.ref;

  @override
  String toString() => 'Point3f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}, ${z.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y, z];
}

class VecPoint extends Vec<Point> {
  VecPoint._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecPoint.fromPointer(cvg.VecPoint ptr) {
    final p = calloc<cvg.VecPoint>();
    try {
      cvRun(() => CFFI.VecPoint_NewFromVec(ptr, p));
      final vec = VecPoint._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecPoint.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint>();
    cvRun(() => CFFI.VecPoint_NewFromMat(mat.ptr, p));
    final vec = VecPoint._(p.value);
    calloc.free(p);
    return vec;
  }
  factory VecPoint.fromList(List<Point> pts) {
    final p = calloc<cvg.VecPoint>();
    cvRun(() => CFFI.VecPoint_New(p));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i];
      cvRun(() => CFFI.VecPoint_Append(p.value, point.ref));
    }
    final vec = VecPoint._(p.value);
    calloc.free(p);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecPoint_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecPoint ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecPoint_Close);
  @override
  Iterator<Point> get iterator => VecPointIterator(ptr);
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

class VecPoint2f extends Vec<Point2f> {
  VecPoint2f._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecPoint2f.fromPointer(cvg.VecPoint2f ptr) {
    final p = calloc<cvg.VecPoint2f>();
    try {
      cvRun(() => CFFI.VecPoint2f_NewFromVec(ptr, p));
      final vec = VecPoint2f._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecPoint2f.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint2f>();
    cvRun(() => CFFI.VecPoint2f_NewFromMat(mat.ptr, p));
    final vec = VecPoint2f._(p.value);
    calloc.free(p);
    return vec;
  }
  factory VecPoint2f.fromList(List<Point2f> pts) {
    final ptr = calloc<cvg.VecPoint2f>();
    cvRun(() => CFFI.VecPoint2f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final p = pts[i];
      cvRun(() => CFFI.VecPoint2f_Append(ptr.value, p.ref));
    }
    final vec = VecPoint2f._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  cvg.VecPoint2f ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecPoint2f_Close);
  @override
  Iterator<Point2f> get iterator => VecPoint2fIterator(ptr);
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

class VecPoint3f extends Vec<Point3f> {
  VecPoint3f._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecPoint3f.fromPointer(cvg.VecPoint3f ptr) {
    final p = calloc<cvg.VecPoint3f>();
    try {
      cvRun(() => CFFI.VecPoint3f_NewFromVec(ptr, p));
      final vec = VecPoint3f._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecPoint3f.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint3f>();
    cvRun(() => CFFI.VecPoint3f_NewFromMat(mat.ptr, p));
    final vec = VecPoint3f._(p.value);
    calloc.free(p);
    return vec;
  }
  factory VecPoint3f.fromList(List<Point3f> pts) {
    final ptr = calloc<cvg.VecPoint3f>();
    cvRun(() => CFFI.VecPoint3f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i];
      cvRun(() => CFFI.VecPoint3f_Append(ptr.value, point.ref));
    }
    final vec = VecPoint3f._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  cvg.VecPoint3f ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecPoint3f_Close);
  @override
  Iterator<Point3f> get iterator => VecPoint3fIterator(ptr);
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
class VecVecPoint extends Vec<Vec<Point>> {
  VecVecPoint._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecVecPoint.fromPointer(cvg.VecVecPoint ptr) {
    final p = calloc<cvg.VecVecPoint>();
    try {
      cvRun(() => CFFI.VecVecPoint_NewFromVec(ptr, p));
      final vec = VecVecPoint._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecVecPoint.fromList(List<List<Point>> pts) {
    final ptr = calloc<cvg.VecVecPoint>();
    cvRun(() => CFFI.VecVecPoint_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].ocv;
      cvRun(() => CFFI.VecVecPoint_Append(ptr.value, point.ptr));
    }
    final vec = VecVecPoint._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  cvg.VecVecPoint ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecVecPoint_Close);
  @override
  Iterator<VecPoint> get iterator => VecVecPointIterator(ptr);
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

  @override
  VecPoint operator [](int idx) {
    return cvRunArena<VecPoint>((arena) {
      final p = arena<cvg.VecPoint>();
      cvRun(() => CFFI.VecVecPoint_At(ptr, idx, p));
      final vec = VecPoint.fromPointer(p.value);
      return vec;
    });
  }
}

class VecVecPoint2f extends Vec<Vec<Point2f>> {
  VecVecPoint2f._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecVecPoint2f.fromPointer(cvg.VecVecPoint2f ptr){
    final p = calloc<cvg.VecVecPoint2f>();
    try {
      cvRun(() => CFFI.VecVecPoint2f_NewFromVec(ptr, p));
      final vec = VecVecPoint2f._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecVecPoint2f.fromList(List<List<Point2f>> pts) {
    final ptr = calloc<cvg.VecVecPoint2f>();
    cvRun(() => CFFI.VecVecPoint2f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].ocv;
      cvRun(() => CFFI.VecVecPoint2f_Append(ptr.value, point.ptr));
    }
    final vec = VecVecPoint2f._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  cvg.VecVecPoint2f ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecVecPoint2f_Close);
  @override
  Iterator<VecPoint2f> get iterator => VecVecPoint2fIterator(ptr);
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

  @override
  VecPoint2f operator [](int idx) {
    return cvRunArena<VecPoint2f>((arena) {
      final p = arena<cvg.VecPoint2f>();
      cvRun(() => CFFI.VecVecPoint2f_At(ptr, idx, p));
      final vec = VecPoint2f.fromPointer(p.value);
      return vec;
    });
  }
}

class VecVecPoint3f extends Vec<Vec<Point3f>> {
  VecVecPoint3f._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecVecPoint3f.fromPointer(cvg.VecVecPoint3f ptr){
    final p = calloc<cvg.VecVecPoint3f>();
    try {
      cvRun(() => CFFI.VecVecPoint3f_NewFromVec(ptr, p));
      final vec = VecVecPoint3f._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecVecPoint3f.fromList(List<List<Point3f>> pts) {
    final ptr = calloc<cvg.VecVecPoint3f>();
    cvRun(() => CFFI.VecVecPoint3f_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].ocv;
      cvRun(() => CFFI.VecVecPoint3f_Append(ptr.value, point.ptr));
    }
    final vec = VecVecPoint3f._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  cvg.VecVecPoint3f ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecVecPoint3f_Close);
  @override
  Iterator<VecPoint3f> get iterator => VecVecPoint3fIterator(ptr);
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

  @override
  VecPoint3f operator [](int idx) {
    return cvRunArena<VecPoint3f>((arena) {
      final p = arena<cvg.VecPoint3f>();
      cvRun(() => CFFI.VecVecPoint3f_At(ptr, idx, p));
      final vec = VecPoint3f.fromPointer(p.value);
      return vec;
    });
  }
}

extension ListPointExtension on List<Point> {
  VecPoint get ocv => VecPoint.fromList(this);
}

extension ListPoint2fExtension on List<Point2f> {
  VecPoint2f get ocv => VecPoint2f.fromList(this);
}

extension ListPoint3fExtension on List<Point3f> {
  VecPoint3f get ocv => VecPoint3f.fromList(this);
}

extension ListListPointExtension on List<List<Point>> {
  VecVecPoint get ocv => VecVecPoint.fromList(this);
}

extension ListListPoint2fExtension on List<List<Point2f>> {
  VecVecPoint2f get ocv => VecVecPoint2f.fromList(this);
}

extension ListListPoint3fExtension on List<List<Point3f>> {
  VecVecPoint3f get ocv => VecVecPoint3f.fromList(this);
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
