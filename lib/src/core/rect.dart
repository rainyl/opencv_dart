import 'dart:ffi' as ffi;
import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;
import 'base.dart';
import 'point.dart';

class Rect extends CvObject with EquatableMixin {
  Rect._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  factory Rect(int x, int y, int width, int height) {
    final _ptr = calloc<cvg.Rect>()
      ..ref.x = x
      ..ref.y = y
      ..ref.width = width
      ..ref.height = height;
    return Rect._(_ptr);
  }
  factory Rect.fromNative(cvg.Rect r) => Rect(r.x, r.y, r.width, r.height);
  factory Rect.fromPointer(ffi.Pointer<cvg.Rect> p) => Rect._(p);

  static final _finalizer =
      Finalizer<ffi.Pointer<cvg.Rect>>((p0) => calloc.free(p0));
  int get x => _ptr.ref.x;
  int get y => _ptr.ref.y;
  int get width => _ptr.ref.width;
  int get height => _ptr.ref.height;
  ffi.Pointer<cvg.Rect> _ptr;
  @override
  ffi.Pointer<cvg.Rect> get ptr => _ptr;
  @override
  List<Object?> get props => [x, y, width, height];

  @override
  cvg.Rect get ref => _ptr.ref;
  @override
  cvg.Rect toNative() => _ptr.ref;

  @override
  String toString() => "Rect($x, $y, $width, $height)";
}

abstract class Rects{
  static List<Rect> toList(cvg.Rects rects){
    return List.generate(rects.length, (i) => Rect.fromNative(rects.rects[i]));
  }
}

extension ListRectExtension on List<Rect> {
  ffi.Pointer<cvg.Rects> toNative(Arena arena){
    final vec = arena<cvg.Rects>()..ref.length = this.length;
    for (var i = 0; i < this.length; i++) {
      vec.ref.rects[i] = this[i].toNative();
    }
    return vec;
  }
}

class RotatedRect extends CvObject {
  RotatedRect._(this._ptr) : super(_ptr);
  factory RotatedRect(List<Point> pts, Rect boundingRect, Point center,
      int width, int height, double angle) {
    final _ptr = calloc<cvg.RotatedRect>();
    using((arena) {
      final size = calloc<cvg.Size>()
        ..ref.width = width
        ..ref.height = height;
      final ptsPtr = pts.toNativePoints(arena);
      _ptr
        ..ref.pts = ptsPtr.ref // here, ptsPtr.ref should be copied to ..ref.pts
        ..ref.boundingRect = boundingRect.toNative()
        ..ref.center = center.toNative()
        ..ref.size = size.ref
        ..ref.angle = angle;
    });

    return RotatedRect._(_ptr);
  }
  factory RotatedRect.fromNative(cvg.RotatedRect r) {
    final _ptr = calloc<cvg.RotatedRect>()..ref = r;
    return RotatedRect._(_ptr);
  }
  factory RotatedRect.fromPointer(ffi.Pointer<cvg.RotatedRect> p) =>
      RotatedRect._(p);

  List<Point> get pts => _ptr.ref.pts.toList();
  Rect get boundingRect => Rect.fromNative(_ptr.ref.boundingRect);
  Point get center => Point.fromNative(_ptr.ref.center);
  int get width => _ptr.ref.size.width;
  int get height => _ptr.ref.size.height;
  double get angle => _ptr.ref.angle;
  ffi.Pointer<cvg.RotatedRect> _ptr;
  @override
  ffi.Pointer<cvg.RotatedRect> get ptr => _ptr;

  @override
  String toString() => "RotatedRect($center, $width, $height, $angle)";

  @override
  cvg.RotatedRect get ref => _ptr.ref;
  @override
  cvg.RotatedRect toNative() => _ptr.ref;
}
