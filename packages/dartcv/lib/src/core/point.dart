// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/core.g.dart' as ccore;
import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'mat.dart';
import 'vec.dart';

class Point extends CvStruct<cvg.CvPoint> {
  Point.fromPointer(ffi.Pointer<cvg.CvPoint> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvPoint>());
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
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvPoint2f>());
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

class Point2d extends CvStruct<cvg.CvPoint2d> {
  Point2d.fromPointer(ffi.Pointer<cvg.CvPoint2d> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvPoint2d>());
    }
  }
  factory Point2d(double x, double y) {
    final ptr = calloc<cvg.CvPoint2d>()
      ..ref.x = x
      ..ref.y = y;
    return Point2d.fromPointer(ptr);
  }
  factory Point2d.fromNative(cvg.CvPoint2d p) => Point2d(p.x, p.y);

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
  cvg.CvPoint2d get ref => ptr.ref;
  @override
  String toString() => 'Point2d(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y];
}

class Point3f extends CvStruct<cvg.CvPoint3f> {
  Point3f.fromPointer(ffi.Pointer<cvg.CvPoint3f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvPoint3f>());
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
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvPoint3i>());
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
  VecPoint.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<cvg.CvPoint>(),
      );
    }
  }

  factory VecPoint([int length = 0, int x = 0, int y = 0]) => VecPoint.generate(length, (i) => Point(x, y));

  factory VecPoint.fromList(List<Point> pts) => VecPoint.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint.generate(int length, Point Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecPoint_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecPoint_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecPoint.fromPointer(p, length: length);
  }

  factory VecPoint.fromMat(Mat mat) {
    final p = VecPoint();
    cvRun(() => ccore.cv_Mat_toVecPoint(mat.ref, p.ptr, ffi.nullptr));
    return p;
  }

  static final finalizer = OcvFinalizer<cvg.VecPointPtr>(ccore.addresses.std_VecPoint_free);

  @override
  VecPoint clone() => VecPoint.generate(length, (idx) => this[idx], dispose: true);

  @override
  void resize(int newSize) => ccore.std_VecPoint_resize(ptr, newSize);

  @override
  void reserve(int newCapacity) => ccore.std_VecPoint_reserve(ptr, newCapacity);

  @override
  void clear() => ccore.std_VecPoint_clear(ptr);

  @override
  void shrinkToFit() => ccore.std_VecPoint_shrink_to_fit(ptr);

  @override
  void extend(Vec other) => ccore.std_VecPoint_extend(ptr, (other as VecPoint).ptr);

  @override
  void add(Point element) => ccore.std_VecPoint_push_back(ptr, element.ref);

  @override
  int size() => ccore.std_VecPoint_length(ptr);

  @override
  int get length => ccore.std_VecPoint_length(ptr);

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecPoint_free(ptr);
  }

  @override
  Iterator<Point> get iterator => VecPointIterator(ptr);

  @override
  cvg.VecPoint get ref => ptr.ref;

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, Point value) => ccore.std_VecPoint_set(ptr, idx, value.ref);

  @override
  Point operator [](int idx) => Point.fromPointer(ccore.std_VecPoint_get_p(ptr, idx));
}

class VecPointIterator extends VecIterator<Point> {
  VecPointIterator(this.ptr);
  cvg.VecPointPtr ptr;

  @override
  int get length => ccore.std_VecPoint_length(ptr);

  @override
  Point operator [](int idx) => Point.fromPointer(ccore.std_VecPoint_get_p(ptr, idx));
}

class VecPoint2f extends Vec<cvg.VecPoint2f, Point2f> {
  VecPoint2f.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<cvg.CvPoint2f>(),
      );
    }
  }

  factory VecPoint2f([int length = 0, double x = 0, double y = 0]) =>
      VecPoint2f.generate(length, (i) => Point2f(x, y));

  factory VecPoint2f.fromList(List<Point2f> pts) =>
      VecPoint2f.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint2f.generate(int length, Point2f Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecPoint2f_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecPoint2f_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecPoint2f.fromPointer(p, length: length);
  }

  factory VecPoint2f.fromMat(Mat mat) {
    final p = VecPoint2f();
    cvRun(() => ccore.cv_Mat_toVecPoint2f(mat.ref, p.ptr, ffi.nullptr));
    return p;
  }

  static final finalizer = OcvFinalizer<cvg.VecPoint2fPtr>(ccore.addresses.std_VecPoint2f_free);

  @override
  VecPoint2f clone() => VecPoint2f.generate(length, (idx) => this[idx], dispose: true);

  @override
  void resize(int newSize) => ccore.std_VecPoint2f_resize(ptr, newSize);

  @override
  void reserve(int newCapacity) => ccore.std_VecPoint2f_reserve(ptr, newCapacity);

  @override
  void clear() => ccore.std_VecPoint2f_clear(ptr);

  @override
  void shrinkToFit() => ccore.std_VecPoint2f_shrink_to_fit(ptr);

  @override
  void extend(Vec other) => ccore.std_VecPoint2f_extend(ptr, (other as VecPoint2f).ptr);

  @override
  void add(Point2f element) => ccore.std_VecPoint2f_push_back(ptr, element.ref);

  @override
  int size() => ccore.std_VecPoint2f_length(ptr);

  @override
  int get length => ccore.std_VecPoint2f_length(ptr);

  @override
  Iterator<Point2f> get iterator => VecPoint2fIterator(ptr);

  @override
  cvg.VecPoint2f get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecPoint2f_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, Point2f value) => ccore.std_VecPoint2f_set(ptr, idx, value.ref);

  @override
  Point2f operator [](int idx) => Point2f.fromPointer(ccore.std_VecPoint2f_get_p(ptr, idx));
}

class VecPoint2fIterator extends VecIterator<Point2f> {
  VecPoint2fIterator(this.ptr);
  cvg.VecPoint2fPtr ptr;

  @override
  int get length => ccore.std_VecPoint2f_length(ptr);

  @override
  Point2f operator [](int idx) => Point2f.fromPointer(ccore.std_VecPoint2f_get_p(ptr, idx));
}

class VecPoint3f extends Vec<cvg.VecPoint3f, Point3f> {
  VecPoint3f.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<cvg.CvPoint3f>(),
      );
    }
  }

  factory VecPoint3f([int length = 0, double x = 0, double y = 0, double z = 0]) =>
      VecPoint3f.generate(length, (i) => Point3f(x, y, z));

  factory VecPoint3f.fromList(List<Point3f> pts) =>
      VecPoint3f.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint3f.generate(int length, Point3f Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecPoint3f_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecPoint3f_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecPoint3f.fromPointer(p, length: length);
  }

  factory VecPoint3f.fromMat(Mat mat) {
    final p = VecPoint3f();
    cvRun(() => ccore.cv_Mat_toVecPoint3f(mat.ref, p.ptr, ffi.nullptr));
    return p;
  }

  static final finalizer = OcvFinalizer<cvg.VecPoint3fPtr>(ccore.addresses.std_VecPoint3f_free);

  @override
  VecPoint3f clone() => VecPoint3f.generate(length, (idx) => this[idx], dispose: true);

  @override
  void resize(int newSize) => ccore.std_VecPoint3f_resize(ptr, newSize);

  @override
  void reserve(int newCapacity) => ccore.std_VecPoint3f_reserve(ptr, newCapacity);

  @override
  void clear() => ccore.std_VecPoint3f_clear(ptr);

  @override
  void shrinkToFit() => ccore.std_VecPoint3f_shrink_to_fit(ptr);

  @override
  void extend(Vec other) => ccore.std_VecPoint3f_extend(ptr, (other as VecPoint3f).ptr);

  @override
  void add(Point3f element) => ccore.std_VecPoint3f_push_back(ptr, element.ref);

  @override
  int size() => ccore.std_VecPoint3f_length(ptr);

  @override
  int get length => ccore.std_VecPoint3f_length(ptr);

  @override
  Iterator<Point3f> get iterator => VecPoint3fIterator(ptr);

  @override
  cvg.VecPoint3f get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecPoint3f_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, Point3f value) => ccore.std_VecPoint3f_set(ptr, idx, value.ref);

  @override
  Point3f operator [](int idx) => Point3f.fromPointer(ccore.std_VecPoint3f_get_p(ptr, idx));
}

class VecPoint3fIterator extends VecIterator<Point3f> {
  VecPoint3fIterator(this.ptr);
  cvg.VecPoint3fPtr ptr;

  @override
  int get length => ccore.std_VecPoint3f_length(ptr);

  @override
  Point3f operator [](int idx) => Point3f.fromPointer(ccore.std_VecPoint3f_get_p(ptr, idx));
}

class VecPoint3i extends Vec<cvg.VecPoint3i, Point3i> {
  VecPoint3i.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<cvg.CvPoint3i>(),
      );
    }
  }

  factory VecPoint3i([int length = 0, int x = 0, int y = 0, int z = 0]) =>
      VecPoint3i.generate(length, (i) => Point3i(x, y, z));

  factory VecPoint3i.fromList(List<Point3i> pts) =>
      VecPoint3i.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecPoint3i.generate(int length, Point3i Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecPoint3i_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecPoint3i_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecPoint3i.fromPointer(p, length: length);
  }

  factory VecPoint3i.fromMat(Mat mat) {
    final p = VecPoint3i();
    cvRun(() => ccore.cv_Mat_toVecPoint3i(mat.ref, p.ptr, ffi.nullptr));
    return p;
  }

  static final finalizer = OcvFinalizer<cvg.VecPoint3iPtr>(ccore.addresses.std_VecPoint3i_free);

  @override
  VecPoint3i clone() => VecPoint3i.generate(length, (idx) => this[idx], dispose: true);

  @override
  void resize(int newSize) => ccore.std_VecPoint3i_resize(ptr, newSize);

  @override
  void reserve(int newCapacity) => ccore.std_VecPoint3i_reserve(ptr, newCapacity);

  @override
  void clear() => ccore.std_VecPoint3i_clear(ptr);

  @override
  void shrinkToFit() => ccore.std_VecPoint3i_shrink_to_fit(ptr);

  @override
  void extend(Vec other) => ccore.std_VecPoint3i_extend(ptr, (other as VecPoint3i).ptr);

  @override
  void add(Point3i element) => ccore.std_VecPoint3i_push_back(ptr, element.ref);

  @override
  int size() => ccore.std_VecPoint3i_length(ptr);

  @override
  int get length => ccore.std_VecPoint3i_length(ptr);

  @override
  Iterator<Point3i> get iterator => VecPoint3iIterator(ptr);

  @override
  cvg.VecPoint3i get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecPoint3i_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, Point3i value) => ccore.std_VecPoint3i_set(ptr, idx, value.ref);

  @override
  Point3i operator [](int idx) => Point3i.fromPointer(ccore.std_VecPoint3i_get_p(ptr, idx));
}

class VecPoint3iIterator extends VecIterator<Point3i> {
  VecPoint3iIterator(this.ptr);
  cvg.VecPoint3iPtr ptr;

  @override
  int get length => ccore.std_VecPoint3i_length(ptr);

  @override
  Point3i operator [](int idx) => Point3i.fromPointer(ccore.std_VecPoint3i_get_p(ptr, idx));
}

// VecVecPoint
class VecVecPoint extends VecUnmodifible<cvg.VecVecPoint, VecPoint> {
  VecVecPoint.fromPointer(super.ptr, {bool attach = true, int? externalSize}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this, externalSize: externalSize);
    }
  }

  factory VecVecPoint([int length = 0]) => VecVecPoint.fromPointer(ccore.std_VecVecPoint_new(length));

  factory VecVecPoint.fromVecPoint(VecPoint v) => VecVecPoint.generate(1, (i) => v, dispose: false);

  factory VecVecPoint.fromList(List<List<Point>> pts) =>
      VecVecPoint.generate(pts.length, (i) => pts[i].cvd, dispose: false);

  factory VecVecPoint.generate(int length, VecPoint Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecVecPoint_new(length);
    int count = 0;
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      count += v.length;
      ccore.std_VecVecPoint_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecVecPoint.fromPointer(p, externalSize: count * ffi.sizeOf<cvg.CvPoint>());
  }

  static final finalizer = OcvFinalizer<cvg.VecVecPointPtr>(ccore.addresses.std_VecVecPoint_free);

  @override
  VecVecPoint clone() => VecVecPoint.generate(length, (i) => this[i], dispose: false);

  @override
  int size() => ccore.std_VecVecPoint_length(ptr);

  @override
  int get length => ccore.std_VecVecPoint_length(ptr);

  @override
  Iterator<VecPoint> get iterator => VecVecPointIterator(ptr);

  @override
  cvg.VecVecPoint get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecVecPoint_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  /// Returns a **reference**
  ///
  /// Note: the memory of returned [VecPoint] is owned by this [VecVecPoint],
  /// explicitly call [VecPoint.clone] if the parent [VecVecPoint] may be disposed.
  @override
  VecPoint operator [](int idx) => VecPoint.fromPointer(ccore.std_VecVecPoint_get_p(ptr, idx), attach: false);

  List<List<Point>> copyToList() => List.generate(
    length,
    (i) => List.generate(
      ccore.std_VecVecPoint_length_i(ptr, i),
      (j) => Point.fromPointer(ccore.std_VecVecPoint_get_ij(ptr, i, j)),
    ),
  );
}

class VecVecPointIterator extends VecIterator<VecPoint> {
  VecVecPointIterator(this.ptr);
  cvg.VecVecPointPtr ptr;

  @override
  int get length => ccore.std_VecVecPoint_length(ptr);

  /// return the reference
  @override
  VecPoint operator [](int idx) => VecPoint.fromPointer(ccore.std_VecVecPoint_get_p(ptr, idx), attach: false);
}

class VecVecPoint2f extends VecUnmodifible<cvg.VecVecPoint2f, VecPoint2f> {
  VecVecPoint2f.fromPointer(super.ptr, {bool attach = true, int? externalSize}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this, externalSize: externalSize);
    }
  }

  factory VecVecPoint2f([int length = 0]) => VecVecPoint2f.fromPointer(ccore.std_VecVecPoint2f_new(length));

  factory VecVecPoint2f.fromVecPoint(VecPoint2f v) => VecVecPoint2f.generate(1, (i) => v);

  factory VecVecPoint2f.fromList(List<List<Point2f>> pts) =>
      VecVecPoint2f.generate(pts.length, (i) => pts[i].cvd, dispose: false);

  factory VecVecPoint2f.generate(int length, VecPoint2f Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecVecPoint2f_new(length);
    int count = 0;
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      count += v.length;
      ccore.std_VecVecPoint2f_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecVecPoint2f.fromPointer(p, externalSize: count * ffi.sizeOf<cvg.CvPoint2f>());
  }

  static final finalizer = OcvFinalizer<cvg.VecVecPoint2fPtr>(ccore.addresses.std_VecVecPoint2f_free);

  @override
  VecVecPoint2f clone() => VecVecPoint2f.generate(length, (i) => this[i], dispose: false);

  @override
  int size() => ccore.std_VecVecPoint2f_length(ptr);

  @override
  int get length => ccore.std_VecVecPoint2f_length(ptr);

  @override
  Iterator<VecPoint2f> get iterator => VecVecPoint2fIterator(ptr);

  @override
  cvg.VecVecPoint2f get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecVecPoint2f_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  /// Returns a **reference**
  ///
  /// Note: the memory of returned [VecPoint2f] is owned by this [VecVecPoint2f],
  /// explicitly call [VecPoint2f.clone] if the parent [VecVecPoint2f] may be disposed.
  @override
  VecPoint2f operator [](int idx) =>
      VecPoint2f.fromPointer(ccore.std_VecVecPoint2f_get_p(ptr, idx), attach: false);

  List<List<Point2f>> copyToList() => List.generate(
    length,
    (i) => List.generate(
      ccore.std_VecVecPoint2f_length_i(ptr, i),
      (j) => Point2f.fromPointer(ccore.std_VecVecPoint2f_get_ij(ptr, i, j)),
    ),
  );
}

class VecVecPoint2fIterator extends VecIterator<VecPoint2f> {
  VecVecPoint2fIterator(this.ptr);
  cvg.VecVecPoint2fPtr ptr;

  @override
  int get length => ccore.std_VecVecPoint2f_length(ptr);

  /// return the reference
  @override
  VecPoint2f operator [](int idx) =>
      VecPoint2f.fromPointer(ccore.std_VecVecPoint2f_get_p(ptr, idx), attach: false);
}

class VecVecPoint3f extends VecUnmodifible<cvg.VecVecPoint3f, VecPoint3f> {
  VecVecPoint3f.fromPointer(super.ptr, {bool attach = true, int? externalSize}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this, externalSize: externalSize);
    }
  }

  factory VecVecPoint3f([int length = 0]) => VecVecPoint3f.fromPointer(ccore.std_VecVecPoint3f_new(length));

  factory VecVecPoint3f.fromVecPoint(VecPoint3f v) => VecVecPoint3f.generate(1, (i) => v);

  factory VecVecPoint3f.fromList(List<List<Point3f>> pts) =>
      VecVecPoint3f.generate(pts.length, (i) => pts[i].cvd, dispose: false);

  factory VecVecPoint3f.generate(int length, VecPoint3f Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecVecPoint3f_new(length);
    int count = 0;
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      count += v.length;
      ccore.std_VecVecPoint3f_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecVecPoint3f.fromPointer(p, externalSize: count * ffi.sizeOf<cvg.CvPoint3f>());
  }

  static final finalizer = OcvFinalizer<cvg.VecVecPoint3fPtr>(ccore.addresses.std_VecVecPoint3f_free);

  @override
  VecVecPoint3f clone() => VecVecPoint3f.generate(length, (i) => this[i], dispose: false);

  @override
  int size() => ccore.std_VecVecPoint3f_length(ptr);

  @override
  int get length => ccore.std_VecVecPoint3f_length(ptr);

  @override
  Iterator<VecPoint3f> get iterator => VecVecPoint3fIterator(ptr);

  @override
  cvg.VecVecPoint3f get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecVecPoint3f_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  /// Returns a **reference**
  ///
  /// Note: the memory of returned [VecPoint3f] is owned by this [VecVecPoint3f],
  /// explicitly call [VecPoint3f.clone] if the parent [VecVecPoint3f] may be disposed.
  @override
  VecPoint3f operator [](int idx) =>
      VecPoint3f.fromPointer(ccore.std_VecVecPoint3f_get_p(ptr, idx), attach: false);

  List<List<Point3f>> copyToList() => List.generate(
    length,
    (i) => List.generate(
      ccore.std_VecVecPoint3f_length_i(ptr, i),
      (j) => Point3f.fromPointer(ccore.std_VecVecPoint3f_get_ij(ptr, i, j)),
    ),
  );
}

class VecVecPoint3fIterator extends VecIterator<VecPoint3f> {
  VecVecPoint3fIterator(this.ptr);
  cvg.VecVecPoint3fPtr ptr;

  @override
  int get length => ccore.std_VecVecPoint3f_length(ptr);

  /// return the reference
  @override
  VecPoint3f operator [](int idx) =>
      VecPoint3f.fromPointer(ccore.std_VecVecPoint3f_get_p(ptr, idx), attach: false);
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
  Point toPoint() => Point(this.$1, this.$2);
}

extension Point2fRecordExtension on (double x, double y) {
  Point2f toPoint2f() => Point2f(this.$1, this.$2);
}

extension Point3fRecordExtension on (double x, double y, double z) {
  Point3f toPoint3f() => Point3f(this.$1, this.$2, this.$3);
}
