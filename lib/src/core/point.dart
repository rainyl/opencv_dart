import 'dart:ffi' as ffi;
import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;
import 'base.dart';

final _bindings = cvg.CvNative(loadNativeLibrary());

class Point extends CvObject with EquatableMixin {
  Point._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  factory Point(int x, int y) {
    final ptr = calloc<cvg.Point>()
      ..ref.x = x
      ..ref.y = y;
    return Point._(ptr);
  }
  factory Point.fromNative(cvg.Point p) => Point(p.x, p.y);
  factory Point.fromPointer(ffi.Pointer<cvg.Point> p) => Point._(p);

  static final _finalizer =
      Finalizer<ffi.Pointer<cvg.Point>>((p0) => calloc.free(p0));
  int get x => _ptr.ref.x;
  int get y => _ptr.ref.y;
  ffi.Pointer<cvg.Point> _ptr;
  ffi.Pointer<cvg.Point> get ptr => _ptr;

  @override
  cvg.Point toNative() => _ptr.ref;
  @override
  cvg.Point get ref => _ptr.ref;

  @override
  String toString() => 'Point($x, $y)';

  @override
  List<Object?> get props => [x, y];
}

class Point2f extends CvObject with EquatableMixin {
  Point2f._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr.cast());
  }

  factory Point2f(double x, double y) {
    final p = calloc<cvg.Point2f>()
      ..ref.x = x
      ..ref.y = y;
    return Point2f._(p);
  }
  factory Point2f.fromNative(cvg.Point2f p) => Point2f(p.x, p.y);
  factory Point2f.fromPointer(ffi.Pointer<cvg.Point2f> p) => Point2f._(p);

  static final _finalizer =
      ffi.NativeFinalizer(_bindings.addresses.Point2f_Close.cast());
  double get x => _ptr.ref.x;
  double get y => _ptr.ref.y;
  ffi.Pointer<cvg.Point2f> _ptr;
  ffi.Pointer<cvg.Point2f> get ptr => _ptr;

  @override
  cvg.Point2f get ref => _ptr.ref;
  @override
  cvg.Point2f toNative() => ptr.ref;

  @override
  String toString() => 'Point2f($x, $y)';

  @override
  List<Object?> get props => [x, y];
}

class Point3f extends CvObject with EquatableMixin {
  Point3f._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr.cast());
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

  static final _finalizer =
      ffi.NativeFinalizer(_bindings.addresses.Point3f_Close.cast());
  double get x => _ptr.ref.x;
  double get y => _ptr.ref.y;
  double get z => _ptr.ref.z;
  ffi.Pointer<cvg.Point3f> _ptr;
  ffi.Pointer<cvg.Point3f> get ptr => _ptr;

  @override
  String toString() => 'Point3f($x, $y, $z)';
  @override
  List<Object?> get props => [x, y, z];

  @override
  cvg.Point3f get ref => _ptr.ref;
  @override
  cvg.Point3f toNative() => _ptr.ref;
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

extension ListPointsExtension on List<List<Point>> {
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

extension ListToVector1 on List<Point2f> {
  ///! Remeber to free from `native` side
  cvg.Point2fVector toNativeVecotr() {
    final vec = _bindings.Point2fVector_New();
    for (var i = 0; i < length; i++) {
      _bindings.Point2fVector_Append(vec, this[i].toNative());
    }
    return vec;
  }
}
