import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'base.dart';
import 'point.dart';
import 'size.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class Rect extends CvStruct<cvg.Rect> {
  Rect._(ffi.Pointer<cvg.Rect> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
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

  static final finalizer = Finalizer<ffi.Pointer<cvg.Rect>>((p0) => calloc.free(p0));
  int get x => ptr.ref.x;
  int get y => ptr.ref.y;
  int get width => ptr.ref.width;
  int get height => ptr.ref.height;
  int get right => x + width;
  int get bottom => y + height;

  @override
  cvg.Rect get ref => ptr.ref;
  @override
  cvg.Rect toNative() => ptr.ref;

  @override
  String toString() => "Rect($x, $y, $width, $height)";
  @override
  List<int> get props => [x, y, width, height];
}

class RotatedRect extends CvStruct<cvg.RotatedRect> {
  RotatedRect._(ffi.Pointer<cvg.RotatedRect> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }
  factory RotatedRect(List<Point> pts, Rect boundingRect, Point center, Size size, double angle) {
    final sz = calloc<cvg.Size>()
      ..ref.width = size.$1
      ..ref.height = size.$2;
    final ptr = calloc<cvg.RotatedRect>()
      ..ref.pts = pts.ocv.ptr
      ..ref.boundingRect = boundingRect.ref
      ..ref.center = center.ref
      ..ref.size = sz.ref
      ..ref.angle = angle;
    final rect = RotatedRect._(ptr);
    calloc.free(sz);
    return rect;
  }
  factory RotatedRect.fromNative(cvg.RotatedRect rect) {
    final pts = VecPoint.fromPointer(rect.pts).toList();
    return RotatedRect(
      pts,
      Rect.fromNative(rect.boundingRect),
      Point.fromNative(rect.center),
      (rect.size.width, rect.size.height),
      rect.angle,
    );
  }
  factory RotatedRect.fromPointer(ffi.Pointer<cvg.RotatedRect> ptr) => RotatedRect._(ptr);

  static final finalizer = Finalizer<ffi.Pointer<cvg.RotatedRect>>((p0) => calloc.free(p0));
  List<Point> get pts => VecPoint.fromPointer(ref.pts).toList();
  Rect get boundingRect => Rect.fromNative(ref.boundingRect);
  Point get center => Point.fromNative(ref.center);
  Size get size => (ref.size.width, ref.size.height);
  double get angle => ref.angle;

  @override
  cvg.RotatedRect get ref => ptr.ref;
  @override
  cvg.RotatedRect toNative() => ptr.ref;

  @override
  String toString() => "RotatedRect($boundingRect, $center, $size, ${angle.toStringAsFixed(3)})";
  @override
  List<Object> get props => [pts, boundingRect, center, size, angle];
}

class VecRect extends Vec<Rect> {
  VecRect._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecRect.fromPointer(cvg.VecRect ptr) {
    final p = calloc<cvg.VecRect>();
    try {
      cvRun(() => CFFI.VecRect_NewFromVec(ptr, p));
      final vec = VecRect._(p.value);
      return vec;
    } finally {
      calloc.free(p);
    }
  }
  factory VecRect.fromList(List<Rect> pts) {
    final ptr = calloc<cvg.VecRect>();
    cvRun(() => CFFI.VecRect_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecRect_Append(ptr.value, pts[i].ref));
    }
    final vec = VecRect._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecRect_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecRect ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecRect_Close);
  @override
  Iterator<Rect> get iterator => VecRectIterator(ptr);
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
      final p = arena<cvg.Rect>();
      cvRun(() => CFFI.VecRect_At(ptr, idx, p));
      return Rect.fromNative(p.ref);
    });
  }
}

extension ListRectExtension on List<Rect> {
  VecRect get ocv => VecRect.fromList(this);
}
