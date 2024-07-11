import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'point.dart';
import 'size.dart';
import 'vec.dart';

class Rect extends CvStruct<cvg.Rect> {
  Rect._(ffi.Pointer<cvg.Rect> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Rect(int x, int y, int width, int height) {
    final ptr = calloc<cvg.Rect>()
      ..ref.x = x
      ..ref.y = y
      ..ref.width = width
      ..ref.height = height;
    return Rect._(ptr);
  }
  factory Rect.fromNative(cvg.Rect p) => Rect(p.x, p.y, p.width, p.height);
  factory Rect.fromPointer(ffi.Pointer<cvg.Rect> ptr, [bool attach = true]) => Rect._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ptr.ref.x;
  int get y => ptr.ref.y;
  int get width => ptr.ref.width;
  int get height => ptr.ref.height;
  int get right => x + width;
  int get bottom => y + height;

  @override
  cvg.Rect get ref => ptr.ref;
  @override
  String toString() => "Rect($x, $y, $width, $height)";
  @override
  List<int> get props => [x, y, width, height];
}

class Rect2f extends CvStruct<cvg.Rect2f> {
  Rect2f._(ffi.Pointer<cvg.Rect2f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Rect2f(double x, double y, double width, double height) {
    final ptr = calloc<cvg.Rect2f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.width = width
      ..ref.height = height;
    return Rect2f._(ptr);
  }
  factory Rect2f.fromNative(cvg.Rect2f p) => Rect2f(p.x, p.y, p.width, p.height);
  factory Rect2f.fromPointer(ffi.Pointer<cvg.Rect2f> ptr, [bool attach = true]) => Rect2f._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  double get y => ptr.ref.y;
  double get width => ptr.ref.width;
  double get height => ptr.ref.height;
  double get right => x + width;
  double get bottom => y + height;

  @override
  cvg.Rect2f get ref => ptr.ref;
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
    final sz = calloc<cvg.Size2f>()
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
    cvRun(() => ccore.RotatedRect_Points(ptr.ref, pts));
    return VecPoint2f.fromPointer(pts);
  }

  Rect get boundingRect {
    final rect = calloc<cvg.Rect>();
    cvRun(() => ccore.RotatedRect_BoundingRect(ptr.ref, rect));
    return Rect.fromPointer(rect);
  }

  Rect2f get boundingRect2f {
    final rect = calloc<cvg.Rect2f>();
    cvRun(() => ccore.RotatedRect_BoundingRect2f(ptr.ref, rect));
    return Rect2f.fromPointer(rect);
  }

  Point2f get center => Point2f.fromNative(ref.center);
  Size2f get size => Size2f(ref.size.width, ref.size.height);
  double get angle => ref.angle;

  @override
  cvg.RotatedRect get ref => ptr.ref;
  @override
  String toString() => "RotatedRect($center, $size, ${angle.toStringAsFixed(3)})";
  @override
  List<Object> get props => [center, size, angle];
}

class VecRect extends Vec<cvg.VecRect, Rect> {
  VecRect.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecRect([int length = 0, int x = 0, int y = 0, int width = 0, int height = 0]) =>
      VecRect.generate(length, (i) => Rect(x, y, width, height));

  factory VecRect.fromList(List<Rect> pts) => VecRect.generate(pts.length, (i) => pts[i]);

  factory VecRect.generate(int length, Rect Function(int i) generator) {
    final p = calloc<cvg.Rect>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecRect>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecRect.fromPointer(pp);
  }

  factory VecRect.fromVec(cvg.VecRect ref) {
    final p = calloc<cvg.VecRect>()..ref = ref;
    return VecRect.fromPointer(p);
  }

  @override
  int get length => ref.length;

  @override
  Iterator<Rect> get iterator => VecRectIterator(ref);

  @override
  cvg.VecRect get ref => ptr.ref;
}

class VecRectIterator extends VecIterator<Rect> {
  VecRectIterator(this.ref);
  cvg.VecRect ref;

  @override
  int get length => ref.length;

  @override
  Rect operator [](int idx) => Rect.fromNative(ref.ptr[idx]);
}

extension ListRectExtension on List<Rect> {
  VecRect get cvd => VecRect.fromList(this);
}

// Completers for async
void rectCompleter(Completer<Rect> completer, VoidPtr p) =>
    completer.complete(Rect.fromPointer(p.cast<cvg.Rect>()));

void rotatedRectCompleter(Completer<RotatedRect> completer, VoidPtr p) =>
    completer.complete(RotatedRect.fromPointer(p.cast<cvg.RotatedRect>()));
