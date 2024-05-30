import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'base.dart';
import 'point.dart';
import 'size.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class Rect extends CvStruct<cvg.Rect> {
  Rect._(ffi.Pointer<cvg.Rect> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
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
  factory Rect.fromPointer(ffi.Pointer<cvg.Rect> ptr) => Rect._(ptr);

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
  Rect2f._(ffi.Pointer<cvg.Rect2f> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
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
  factory Rect2f.fromPointer(ffi.Pointer<cvg.Rect2f> ptr) => Rect2f._(ptr);

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
  RotatedRect._(ffi.Pointer<cvg.RotatedRect> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }
  factory RotatedRect(Point2f center, Size2f size, double angle) {
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
  factory RotatedRect.fromPointer(ffi.Pointer<cvg.RotatedRect> ptr) => RotatedRect._(ptr);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  List<Point2f> get points {
    return using<List<Point2f>>((arena) {
      final pts = calloc<cvg.VecPoint2f>();
      cvRun(() => CFFI.RotatedRect_Points(ptr.ref, pts));
      return VecPoint2f.fromPointer(pts).toList();
    });
  }

  Rect get boundingRect {
    return using<Rect>((arena) {
      final rect = calloc<cvg.Rect>();
      cvRun(() => CFFI.RotatedRect_BoundingRect(ptr.ref, rect));
      return Rect.fromPointer(rect);
    });
  }

  Rect2f get boundingRect2f {
    return using<Rect2f>((arena) {
      final rect = calloc<cvg.Rect2f>();
      cvRun(() => CFFI.RotatedRect_BoundingRect2f(ptr.ref, rect));
      return Rect2f.fromPointer(rect);
    });
  }

  Point2f get center => Point2f.fromNative(ref.center);
  Size2f get size => (ref.size.width, ref.size.height);
  double get angle => ref.angle;

  @override
  cvg.RotatedRect get ref => ptr.ref;
  @override
  String toString() => "RotatedRect($center, $size, ${angle.toStringAsFixed(3)})";
  @override
  List<Object> get props => [center, size, angle];
}

class VecRect extends Vec<Rect> implements CvStruct<cvg.VecRect> {
  VecRect._(this.ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }
  factory VecRect([int length = 0, int x = 0, int y = 0, int width = 0, int height = 0]) =>
      VecRect.fromList(List.generate(length, (i) => Rect(x, y, width, height)));
  factory VecRect.fromPointer(cvg.VecRectPtr ptr) => VecRect._(ptr);
  factory VecRect.fromVec(cvg.VecRect ptr) {
    final p = calloc<cvg.VecRect>();
    cvRun(() => CFFI.VecRect_NewFromVec(ptr, p));
    final vec = VecRect._(p);
    return vec;
  }
  factory VecRect.fromList(List<Rect> pts) {
    final ptr = calloc<cvg.VecRect>();
    cvRun(() => CFFI.VecRect_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecRect_Append(ptr.ref, pts[i].ref));
    }
    final vec = VecRect._(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecRect_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  static final finalizer = OcvFinalizer<cvg.VecRectPtr>(CFFI.addresses.VecRect_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecRect_Close(ptr);
  }

  @override
  cvg.VecRectPtr ptr;
  @override
  Iterator<Rect> get iterator => VecRectIterator(ref);

  @override
  cvg.VecRect get ref => ptr.ref;
}

class VecRectIterator extends VecIterator<Rect> {
  VecRectIterator(this.ptr);
  cvg.VecRect ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecRect_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  Rect operator [](int idx) {
    return cvRunArena<Rect>((arena) {
      final p = calloc<cvg.Rect>();
      cvRun(() => CFFI.VecRect_At(ptr, idx, p));
      return Rect.fromPointer(p);
    });
  }
}

extension ListRectExtension on List<Rect> {
  VecRect get cvd => VecRect.fromList(this);
}
