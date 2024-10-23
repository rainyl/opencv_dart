// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'point.dart';
import 'size.dart';
import 'vec.dart';

class Rect extends CvStruct<cvg.CvRect> {
  Rect._(ffi.Pointer<cvg.CvRect> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Rect(int x, int y, int width, int height) {
    final ptr = calloc<cvg.CvRect>()
      ..ref.x = x
      ..ref.y = y
      ..ref.width = width
      ..ref.height = height;
    return Rect._(ptr);
  }
  factory Rect.fromNative(cvg.CvRect p) => Rect(p.x, p.y, p.width, p.height);
  factory Rect.fromPointer(ffi.Pointer<cvg.CvRect> ptr, [bool attach = true]) => Rect._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ptr.ref.x;
  set x(int v) => ptr.ref.x = v;

  int get y => ptr.ref.y;
  set y(int v) => ptr.ref.y = v;

  int get width => ptr.ref.width;
  set width(int v) => ptr.ref.width = v;

  int get height => ptr.ref.height;
  set height(int v) => ptr.ref.height = v;

  int get right => x + width;
  int get bottom => y + height;

  @override
  cvg.CvRect get ref => ptr.ref;
  @override
  String toString() => "Rect($x, $y, $width, $height)";
  @override
  List<int> get props => [x, y, width, height];
}

class Rect2f extends CvStruct<cvg.CvRect2f> {
  Rect2f._(ffi.Pointer<cvg.CvRect2f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Rect2f(double x, double y, double width, double height) {
    final ptr = calloc<cvg.CvRect2f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.width = width
      ..ref.height = height;
    return Rect2f._(ptr);
  }
  factory Rect2f.fromNative(cvg.CvRect2f p) => Rect2f(p.x, p.y, p.width, p.height);
  factory Rect2f.fromPointer(ffi.Pointer<cvg.CvRect2f> ptr, [bool attach = true]) => Rect2f._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  set x(double v) => ptr.ref.x = v;

  double get y => ptr.ref.y;
  set y(double v) => ptr.ref.y = v;

  double get width => ptr.ref.width;
  set width(double v) => ptr.ref.width = v;

  double get height => ptr.ref.height;
  set height(double v) => ptr.ref.height = v;

  double get right => x + width;
  double get bottom => y + height;

  @override
  cvg.CvRect2f get ref => ptr.ref;
  @override
  String toString() =>
      "Rect2f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}, ${width.toStringAsFixed(3)}, ${height.toStringAsFixed(3)})";
  @override
  List<double> get props => [x, y, width, height];
}

class RotatedRect extends CvStruct<cvg.RotatedRect> {
  RotatedRect._(ffi.Pointer<cvg.RotatedRect> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory RotatedRect(Point2f center, (double, double) size, double angle) {
    final sz = calloc<cvg.CvSize2f>()
      ..ref.width = size.$1
      ..ref.height = size.$2;
    final ptr = calloc<cvg.RotatedRect>()
      ..ref.center = center.ref
      ..ref.size = sz.ref
      ..ref.angle = angle;
    final rect = RotatedRect._(ptr);
    calloc.free(sz);
    return rect;
  }
  factory RotatedRect.fromNative(cvg.RotatedRect rect) =>
      RotatedRect(Point2f.fromNative(rect.center), (rect.size.width, rect.size.height), rect.angle);
  factory RotatedRect.fromPointer(ffi.Pointer<cvg.RotatedRect> ptr, [bool attach = true]) =>
      RotatedRect._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  VecPoint2f get points {
    final pts = calloc<cvg.VecPoint2f>();
    cvRun(() => ccore.cv_RotatedRect_points(ptr.ref, pts));
    return VecPoint2f.fromPointer(pts);
  }

  Rect get boundingRect {
    final rect = calloc<cvg.CvRect>();
    cvRun(() => ccore.cv_RotatedRect_boundingRect(ptr.ref, rect));
    return Rect.fromPointer(rect);
  }

  Rect2f get boundingRect2f {
    final rect = calloc<cvg.CvRect2f>();
    cvRun(() => ccore.cv_RotatedRect_boundingRect2f(ptr.ref, rect));
    return Rect2f.fromPointer(rect);
  }

  Point2f get center => Point2f.fromNative(ref.center);
  set center(Point2f value) => ref.center = value.ref;

  Size2f get size => Size2f(ref.size.width, ref.size.height);
  set size(Size2f value) => ref.size = value.ref;

  double get angle => ref.angle;
  set angle(double value) => ref.angle = value;

  @override
  cvg.RotatedRect get ref => ptr.ref;
  @override
  String toString() => "RotatedRect($center, $size, ${angle.toStringAsFixed(3)})";
  @override
  List<Object> get props => [center, size, angle];
}

class VecRect extends Vec<cvg.VecRect, Rect> {
  VecRect.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecRect([int length = 0, int x = 0, int y = 0, int width = 0, int height = 0]) =>
      VecRect.generate(length, (i) => Rect(x, y, width, height));

  factory VecRect.fromList(List<Rect> pts) => VecRect.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecRect.generate(int length, Rect Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecRect>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.CvRect>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecRect.fromPointer(pp);
  }

  @override
  VecRect clone() => VecRect.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<Rect> get iterator => VecRectIterator(ref);

  @override
  cvg.VecRect get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecRect>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, Rect value) {
    ref.ptr[idx].x = value.x;
    ref.ptr[idx].y = value.y;
    ref.ptr[idx].width = value.width;
    ref.ptr[idx].height = value.height;
  }

  @override
  Rect operator [](int idx) => Rect.fromPointer(ref.ptr + idx, false);
}

class VecRectIterator extends VecIterator<Rect> {
  VecRectIterator(this.ref);
  cvg.VecRect ref;

  @override
  int get length => ref.length;

  @override
  Rect operator [](int idx) => Rect.fromPointer(ref.ptr + idx, false);
}

extension ListRectExtension on List<Rect> {
  VecRect get cvd => asVec();
  VecRect asVec() => VecRect.fromList(this);
}
