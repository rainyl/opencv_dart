// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'mat.dart';
import 'vec.dart';

class Point extends CvStruct<cvg.CvPoint> {
  Point.fromPointer(ffi.Pointer<cvg.CvPoint> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point(int x, int y) {
    final ptr = calloc<cvg.CvPoint>()
      ..ref.x = x
      ..ref.y = y;
    return Point.fromPointer(ptr);
  }
  factory Point.fromNative(cvg.CvPoint p) => Point(p.x, p.y);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ref.x;
  set x(int value) => ref.x = value;

  int get y => ref.y;
  set y(int value) => ref.y = value;

  @override
  cvg.CvPoint get ref => ptr.ref;
  @override
  String toString() => 'Point($x, $y)';
  @override
  List<int> get props => [x, y];
}

class Point2f extends CvStruct<cvg.CvPoint2f> {
  Point2f.fromPointer(ffi.Pointer<cvg.CvPoint2f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point2f(double x, double y) {
    final ptr = calloc<cvg.CvPoint2f>()
      ..ref.x = x
      ..ref.y = y;
    return Point2f.fromPointer(ptr);
  }
  factory Point2f.fromNative(cvg.CvPoint2f p) => Point2f(p.x, p.y);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  set x(double value) => ref.x = value;

  double get y => ptr.ref.y;
  set y(double value) => ref.y = value;

  @override
  cvg.CvPoint2f get ref => ptr.ref;
  @override
  String toString() => 'Point2f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y];
}

class Point3f extends CvStruct<cvg.CvPoint3f> {
  Point3f.fromPointer(ffi.Pointer<cvg.CvPoint3f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point3f(double x, double y, double z) {
    final ptr = calloc<cvg.CvPoint3f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3f.fromPointer(ptr);
  }
  factory Point3f.fromNative(cvg.CvPoint3f p) => Point3f(p.x, p.y, p.z);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  set x(double value) => ref.x = value;

  double get y => ptr.ref.y;
  set y(double value) => ref.y = value;

  double get z => ptr.ref.z;
  set z(double value) => ref.z = value;

  @override
  cvg.CvPoint3f get ref => ptr.ref;
  @override
  String toString() => 'Point3f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}, ${z.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y, z];
}

class Point3i extends CvStruct<cvg.CvPoint3i> {
  Point3i.fromPointer(ffi.Pointer<cvg.CvPoint3i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point3i(int x, int y, int z) {
    final ptr = calloc<cvg.CvPoint3i>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3i.fromPointer(ptr);
  }
  factory Point3i.fromNative(cvg.CvPoint3i p) => Point3i(p.x, p.y, p.z);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ptr.ref.x;
  set x(int value) => ref.x = value;

  int get y => ptr.ref.y;
  set y(int value) => ref.y = value;

  int get z => ptr.ref.z;
  set z(int value) => ref.z = value;

  @override
  cvg.CvPoint3i get ref => ptr.ref;
  @override
  String toString() => 'Point3i($x, $y, $z)';
  @override
  List<int> get props => [x, y, z];
}

class VecPoint extends Vec<cvg.VecPoint, Point> {
  VecPoint.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecPoint([int length = 0, int x = 0, int y = 0]) => VecPoint.generate(length, (i) => Point(x, y));

  factory VecPoint.fromList(List<Point> pts) => VecPoint.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint.generate(int length, Point Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecPoint>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.CvPoint>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecPoint.fromPointer(pp);
  }

  factory VecPoint.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint>();
    cvRun(() => ccore.Mat_toVecPoint(mat.ref, p));
    return VecPoint.fromPointer(p);
  }

  @override
  VecPoint clone() => VecPoint.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  Iterator<Point> get iterator => VecPointIterator(ref);

  @override
  cvg.VecPoint get ref => ptr.ref;

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecPoint>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, Point value) {
    ref.ptr[idx].x = value.x;
    ref.ptr[idx].y = value.y;
  }

  @override
  Point operator [](int idx) => Point.fromPointer(ref.ptr + idx, false);
}

class VecPointIterator extends VecIterator<Point> {
  VecPointIterator(this.ref);
  cvg.VecPoint ref;

  @override
  int get length => ref.length;

  @override
  Point operator [](int idx) => Point.fromPointer(ref.ptr + idx, false);
}

class VecPoint2f extends Vec<cvg.VecPoint2f, Point2f> {
  VecPoint2f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecPoint2f([int length = 0, double x = 0, double y = 0]) =>
      VecPoint2f.generate(length, (i) => Point2f(x, y));

  factory VecPoint2f.fromList(List<Point2f> pts) =>
      VecPoint2f.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint2f.generate(int length, Point2f Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecPoint2f>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.CvPoint2f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecPoint2f.fromPointer(pp);
  }

  factory VecPoint2f.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint2f>();
    cvRun(() => ccore.Mat_toVecPoint2f(mat.ref, p));
    return VecPoint2f.fromPointer(p);
  }

  @override
  VecPoint2f clone() => VecPoint2f.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<Point2f> get iterator => VecPoint2fIterator(ref);

  @override
  cvg.VecPoint2f get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  void reattach({ffi.Pointer<cvg.VecPoint2f>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, Point2f value) {
    ref.ptr[idx].x = value.x;
    ref.ptr[idx].y = value.y;
  }

  @override
  Point2f operator [](int idx) => Point2f.fromPointer(ref.ptr + idx, false);
}

class VecPoint2fIterator extends VecIterator<Point2f> {
  VecPoint2fIterator(this.ref);
  cvg.VecPoint2f ref;

  @override
  int get length => ref.length;

  @override
  Point2f operator [](int idx) => Point2f.fromPointer(ref.ptr + idx, false);
}

class VecPoint3f extends Vec<cvg.VecPoint3f, Point3f> {
  VecPoint3f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecPoint3f([int length = 0, double x = 0, double y = 0, double z = 0]) =>
      VecPoint3f.generate(length, (i) => Point3f(x, y, z));

  factory VecPoint3f.fromList(List<Point3f> pts) =>
      VecPoint3f.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint3f.generate(int length, Point3f Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecPoint3f>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.CvPoint3f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecPoint3f.fromPointer(pp);
  }

  factory VecPoint3f.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint3f>();
    cvRun(() => ccore.Mat_toVecPoint3f(mat.ref, p));
    return VecPoint3f.fromPointer(p);
  }

  @override
  VecPoint3f clone() => VecPoint3f.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<Point3f> get iterator => VecPoint3fIterator(ref);

  @override
  cvg.VecPoint3f get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecPoint3f>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, Point3f value) {
    ref.ptr[idx].x = value.x;
    ref.ptr[idx].y = value.y;
    ref.ptr[idx].z = value.z;
  }

  @override
  Point3f operator [](int idx) => Point3f.fromPointer(ref.ptr + idx, false);
}

class VecPoint3fIterator extends VecIterator<Point3f> {
  VecPoint3fIterator(this.ref);
  cvg.VecPoint3f ref;

  @override
  int get length => ref.length;

  @override
  Point3f operator [](int idx) => Point3f.fromPointer(ref.ptr + idx, false);
}

class VecPoint3i extends Vec<cvg.VecPoint3i, Point3i> {
  VecPoint3i.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecPoint3i([int length = 0, int x = 0, int y = 0, int z = 0]) =>
      VecPoint3i.generate(length, (i) => Point3i(x, y, z));

  factory VecPoint3i.fromList(List<Point3i> pts) =>
      VecPoint3i.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint3i.generate(int length, Point3i Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecPoint3i>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.CvPoint3i>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecPoint3i.fromPointer(pp);
  }

  factory VecPoint3i.fromMat(Mat mat) {
    final p = calloc<cvg.VecPoint3i>();
    cvRun(() => ccore.Mat_toVecPoint3i(mat.ref, p));
    return VecPoint3i.fromPointer(p);
  }

  @override
  VecPoint3i clone() => VecPoint3i.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<Point3i> get iterator => VecPoint3iIterator(ref);

  @override
  cvg.VecPoint3i get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecPoint3i>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, Point3i value) {
    ref.ptr[idx].x = value.x;
    ref.ptr[idx].y = value.y;
    ref.ptr[idx].z = value.z;
  }

  @override
  Point3i operator [](int idx) => Point3i.fromPointer(ref.ptr + idx, false);
}

class VecPoint3iIterator extends VecIterator<Point3i> {
  VecPoint3iIterator(this.ref);
  cvg.VecPoint3i ref;

  @override
  int get length => ref.length;

  @override
  Point3i operator [](int idx) => Point3i.fromPointer(ref.ptr + idx, false);
}

// VecVecPoint
class VecVecPoint extends Vec<cvg.VecVecPoint, VecPoint> {
  VecVecPoint.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVecPoint.fromVecPoint(VecPoint v) => VecVecPoint.generate(1, (i) => v, dispose: false);

  factory VecVecPoint.fromList(List<List<Point>> pts) =>
      VecVecPoint.generate(pts.length, (i) => pts[i].cvd, dispose: false);

  factory VecVecPoint.generate(int length, VecPoint Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVecPoint>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.VecPoint>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVecPoint.fromPointer(pp);
  }

  @override
  VecVecPoint clone() => VecVecPoint.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<VecPoint> get iterator => VecVecPointIterator(ref);

  @override
  cvg.VecVecPoint get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecVecPoint>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, VecPoint value) => throw UnsupportedError("VecVecPoint is read-only");

  @override
  VecPoint operator [](int idx) => VecPoint.fromPointer(ref.ptr + idx, false);
}

class VecVecPointIterator extends VecIterator<VecPoint> {
  VecVecPointIterator(this.ref);
  cvg.VecVecPoint ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecPoint operator [](int idx) => VecPoint.fromPointer(ref.ptr + idx, false);
}

class VecVecPoint2f extends Vec<cvg.VecVecPoint2f, VecPoint2f> {
  VecVecPoint2f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVecPoint2f.fromVecPoint(VecPoint2f v) => VecVecPoint2f.generate(1, (i) => v);

  factory VecVecPoint2f.fromList(List<List<Point2f>> pts) =>
      VecVecPoint2f.generate(pts.length, (i) => pts[i].cvd, dispose: false);

  factory VecVecPoint2f.generate(int length, VecPoint2f Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVecPoint2f>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.VecPoint2f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVecPoint2f.fromPointer(pp);
  }

  @override
  VecVecPoint2f clone() => VecVecPoint2f.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<VecPoint2f> get iterator => VecVecPoint2fIterator(ref);

  @override
  cvg.VecVecPoint2f get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecVecPoint2f>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, VecPoint2f value) => throw UnsupportedError("VecVecPoint2f is read-only");

  @override
  VecPoint2f operator [](int idx) => VecPoint2f.fromPointer(ref.ptr + idx, false);
}

class VecVecPoint2fIterator extends VecIterator<VecPoint2f> {
  VecVecPoint2fIterator(this.ref);
  cvg.VecVecPoint2f ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecPoint2f operator [](int idx) => VecPoint2f.fromPointer(ref.ptr + idx, false);
}

class VecVecPoint3f extends Vec<cvg.VecVecPoint3f, VecPoint3f> {
  VecVecPoint3f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }
  factory VecVecPoint3f.fromVecPoint(VecPoint3f v) => VecVecPoint3f.generate(1, (i) => v);

  factory VecVecPoint3f.fromList(List<List<Point3f>> pts) =>
      VecVecPoint3f.generate(pts.length, (i) => pts[i].cvd, dispose: false);

  factory VecVecPoint3f.generate(int length, VecPoint3f Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVecPoint3f>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.VecPoint3f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVecPoint3f.fromPointer(pp);
  }

  @override
  VecVecPoint3f clone() => VecVecPoint3f.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<VecPoint3f> get iterator => VecVecPoint3fIterator(ref);

  @override
  cvg.VecVecPoint3f get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecVecPoint3f>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, VecPoint3f value) => throw UnsupportedError("VecVecPoint3f is read-only");

  @override
  VecPoint3f operator [](int idx) => VecPoint3f.fromPointer(ref.ptr + idx, false);
}

class VecVecPoint3fIterator extends VecIterator<VecPoint3f> {
  VecVecPoint3fIterator(this.ref);
  cvg.VecVecPoint3f ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecPoint3f operator [](int idx) => VecPoint3f.fromPointer(ref.ptr + idx, false);
}

extension ListPointExtension on List<Point> {
  VecPoint get cvd => asVec();
  VecPoint asVec() => VecPoint.fromList(this);
}

extension ListPoint2fExtension on List<Point2f> {
  VecPoint2f get cvd => asVec();
  VecPoint2f asVec() => VecPoint2f.fromList(this);
}

extension ListPoint3fExtension on List<Point3f> {
  VecPoint3f get cvd => asVec();
  VecPoint3f asVec() => VecPoint3f.fromList(this);
}

extension ListPoint3iExtension on List<Point3i> {
  VecPoint3i get cvd => asVec();
  VecPoint3i asVec() => VecPoint3i.fromList(this);
}

extension ListListPointExtension on List<List<Point>> {
  VecVecPoint get cvd => asVec();
  VecVecPoint asVec() => VecVecPoint.fromList(this);
}

extension VecPointExtension on VecPoint {
  @Deprecated("use asVecVec() instead")
  VecVecPoint get toVecVecPoint => VecVecPoint.fromVecPoint(this);
  VecVecPoint asVecVec() => VecVecPoint.fromVecPoint(this);
}

extension ListListPoint2fExtension on List<List<Point2f>> {
  VecVecPoint2f get cvd => asVec();
  VecVecPoint2f asVec() => VecVecPoint2f.fromList(this);
}

extension ListListPoint3fExtension on List<List<Point3f>> {
  VecVecPoint3f get cvd => asVec();
  VecVecPoint3f asVec() => VecVecPoint3f.fromList(this);
}

extension PointRecordExtension on (int x, int y) {
  @Deprecated("use toPoint() instead")
  Point get asPoint => Point(this.$1, this.$2);
  Point toPoint() => Point(this.$1, this.$2);
}

extension Point2fRecordExtension on (double x, double y) {
  @Deprecated("use toPoint2f() instead")
  Point2f get asPoint2f => Point2f(this.$1, this.$2);
  Point2f toPoint2f() => Point2f(this.$1, this.$2);
}

extension Point3fRecordExtension on (double x, double y, double z) {
  @Deprecated("use toPoint3f() instead")
  Point3f get asPoint3f => Point3f(this.$1, this.$2, this.$3);
  Point3f toPoint3f() => Point3f(this.$1, this.$2, this.$3);
}

// completers
void vecPointCompleter(Completer<VecPoint> completer, VoidPtr p) =>
    completer.complete(VecPoint.fromPointer(p.cast<cvg.VecPoint>()));

void vecPoint2fCompleter(Completer<VecPoint2f> completer, VoidPtr p) =>
    completer.complete(VecPoint2f.fromPointer(p.cast<cvg.VecPoint2f>()));
