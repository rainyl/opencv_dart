import 'dart:ffi' as ffi;
import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class Point with EquatableMixin implements ffi.Finalizable {
  Point._(this.ptr) {
    _finalizer.attach(this, ptr);
  }
  factory Point(int x, int y) {
    final ptr = calloc<cvg.Point>()
      ..ref.x = x
      ..ref.y = y;
    return Point._(ptr);
  }
  factory Point.fromNative(cvg.Point p) => Point(p.x, p.y);
  factory Point.fromPointer(ffi.Pointer<cvg.Point> p) => Point._(p);

  static final _finalizer = Finalizer<ffi.Pointer<cvg.Point>>((p0) => calloc.free(p0));
  int get x => ptr.ref.x;
  int get y => ptr.ref.y;
  ffi.Pointer<cvg.Point> ptr;

  cvg.Point toNative() => ptr.ref;
  cvg.Point get ref => ptr.ref;

  @override
  String toString() => 'Point($x, $y)';

  @override
  List<Object?> get props => [x, y];
}

class Point2f with EquatableMixin implements ffi.Finalizable {
  Point2f._(this.ptr) {
    _finalizer.attach(this, ptr.cast());
  }

  factory Point2f(double x, double y) {
    final p = calloc<cvg.Point2f>()
      ..ref.x = x
      ..ref.y = y;
    return Point2f._(p);
  }
  factory Point2f.fromNative(cvg.Point2f p) => Point2f(p.x, p.y);
  factory Point2f.fromPointer(ffi.Pointer<cvg.Point2f> p) => Point2f._(p);

  static final _finalizer = Finalizer<ffi.Pointer<cvg.Point2f>>((p0) => calloc.free(p0));
  double get x => ptr.ref.x;
  double get y => ptr.ref.y;
  ffi.Pointer<cvg.Point2f> ptr;

  cvg.Point2f get ref => ptr.ref;
  cvg.Point2f toNative() => ptr.ref;

  @override
  String toString() => 'Point2f($x, $y)';

  @override
  List<Object?> get props => [x, y];
}

class Point3f with EquatableMixin implements ffi.Finalizable {
  Point3f._(this.ptr) {
    _finalizer.attach(this, ptr.cast());
  }

  factory Point3f(double x, double y, double z) {
    final p = calloc<cvg.Point3f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3f._(p);
  }
  factory Point3f.fromNative(cvg.Point3f p) => Point3f(p.x, p.y, p.z);
  factory Point3f.fromPointer(ffi.Pointer<cvg.Point3f> p) => Point3f._(p);

  static final _finalizer = Finalizer<ffi.Pointer<cvg.Point3f>>((p0) => calloc.free(p0));
  double get x => ptr.ref.x;
  double get y => ptr.ref.y;
  double get z => ptr.ref.z;
  ffi.Pointer<cvg.Point3f> ptr;

  @override
  String toString() => 'Point3f($x, $y, $z)';
  @override
  List<Object?> get props => [x, y, z];

  cvg.Point3f get ref => ptr.ref;
  cvg.Point3f toNative() => ptr.ref;
}

class ListPoint2f {
  static List<Point2f> fromMat(Mat mat) {
    final vec = _bindings.Point2fVector_NewFromMat(mat.ptr);
    final ret = List.generate(
      _bindings.Point2fVector_Size(vec),
      (index) => Point2f.fromNative(_bindings.Point2fVector_At(vec, index)),
    );

    _bindings.Point2fVector_Close(vec);
    return ret;
  }
}

extension ListPointExtension on List<Point> {
  ///! Remeber to free from `native` side
  cvg.PointVector toNativeVecotr() {
    final vec = _bindings.PointVector_New();
    for (var i = 0; i < length; i++) {
      _bindings.PointVector_Append(vec, this[i].toNative());
    }
    return vec;
  }

  ffi.Pointer<cvg.Points> toNativePoints(Arena arena) {
    final points = arena<cvg.Points>()..ref.length = length;
    for (var i = 0; i < length; i++) {
      points.ref.points[i] = this[i].toNative();
    }
    return points;
  }
}

extension ListListPointExtension on List<List<Point>> {
  ///! Remeber to free from `native` side
  cvg.PointsVector toNativeVector() {
    final vec = _bindings.PointsVector_New();
    for (var i = 0; i < length; i++) {
      _bindings.PointsVector_Append(vec, this[i].toNativeVecotr());
    }
    return vec;
  }
}

extension PointsToList on cvg.Points {
  List<Point> toList() {
    final list = <Point>[];
    for (var i = 0; i < this.length; i++) {
      list.add(Point.fromNative(this.points[i]));
    }
    return list;
  }
}

extension ListPoint2fExtension on List<Point2f> {
  ///! Remeber to free from `native` side
  cvg.Point2fVector toNativeVecotr() {
    final vec = _bindings.Point2fVector_New();
    for (var i = 0; i < length; i++) {
      _bindings.Point2fVector_Append(vec, this[i].toNative());
    }
    return vec;
  }
}

extension ListPoint3fExtension on List<Point3f> {
  ///! Remeber to free from `native` side
  cvg.Point3fVector toNativeVecotr() {
    final vec = _bindings.Point3fVector_New();
    for (var i = 0; i < length; i++) {
      _bindings.Point3fVector_Append(vec, this[i].toNative());
    }
    return vec;
  }
}
