library cv;

import 'dart:ffi' as ffi;

import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class KeyPoint extends CvObject with EquatableMixin {
  KeyPoint._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  factory KeyPoint(double x, double y, double size, double angle,
      double response, int octave, int classID) {
    final _ptr = calloc<cvg.KeyPoint>()
      ..ref.x = x
      ..ref.y = y
      ..ref.size = size
      ..ref.angle = angle
      ..ref.response = response
      ..ref.octave = octave
      ..ref.classID = classID;
    return KeyPoint._(_ptr);
  }
  factory KeyPoint.fromNative(cvg.KeyPoint r) =>
      KeyPoint(r.x, r.y, r.size, r.angle, r.response, r.octave, r.classID);
  factory KeyPoint.fromPointer(ffi.Pointer<cvg.KeyPoint> p) => KeyPoint._(p);

  static final _finalizer =
      Finalizer<ffi.Pointer<cvg.KeyPoint>>((p0) => calloc.free(p0));
  double get x => _ptr.ref.x;
  double get y => _ptr.ref.y;
  double get size => _ptr.ref.size;
  double get angle => _ptr.ref.angle;
  double get response => _ptr.ref.response;
  int get octave => _ptr.ref.octave;
  int get classID => _ptr.ref.classID;
  ffi.Pointer<cvg.KeyPoint> _ptr;
  @override
  ffi.Pointer<cvg.KeyPoint> get ptr => _ptr;
  @override
  List<Object?> get props => [x, y, size, angle, response, octave, classID];

  @override
  cvg.KeyPoint get ref => _ptr.ref;
  @override
  cvg.KeyPoint toNative() => _ptr.ref;

  @override
  String toString() =>
      "KeyPoint($x, $y, $size, $angle, $response, $octave, $classID)";
}

abstract class KeyPoints {
  static List<KeyPoint> toList(cvg.KeyPoints pointsPtr) {
    return List.generate(
      pointsPtr.length,
      (index) => KeyPoint.fromNative(pointsPtr.keypoints[index]),
    );
  }
}

extension ListKeyPointExtension on List<KeyPoint> {
  ffi.Pointer<cvg.KeyPoints> toNative(Arena arena) {
    final array = arena<cvg.KeyPoint>(length);
    for (var i = 0; i < this.length; i++) {
      array[i] = this[i].ref;
    }
    final vec = arena<cvg.KeyPoints>()
      ..ref.keypoints = array
      ..ref.length = length;
    return vec;
  }
}
