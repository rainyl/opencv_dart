library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'vec.dart';

class KeyPoint extends CvStruct<cvg.KeyPoint> {
  KeyPoint._(ffi.Pointer<cvg.KeyPoint> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory KeyPoint(double x, double y, double size, double angle, double response, int octave, int classID) {
    final ptr = calloc<cvg.KeyPoint>()
      ..ref.x = x
      ..ref.y = y
      ..ref.size = size
      ..ref.angle = angle
      ..ref.response = response
      ..ref.octave = octave
      ..ref.classID = classID;
    return KeyPoint._(ptr);
  }
  factory KeyPoint.fromNative(cvg.KeyPoint r) => KeyPoint(
        r.x,
        r.y,
        r.size,
        r.angle,
        r.response,
        r.octave,
        r.classID,
      );
  factory KeyPoint.fromPointer(ffi.Pointer<cvg.KeyPoint> p, [bool attach = true]) => KeyPoint._(p, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ref.x;
  double get y => ref.y;
  double get size => ref.size;
  double get angle => ref.angle;
  double get response => ref.response;
  int get octave => ref.octave;
  int get classID => ref.classID;

  @override
  List<Object?> get props => [x, y, size, angle, response, octave, classID];

  @override
  cvg.KeyPoint get ref => ptr.ref;
  @override
  String toString() => "KeyPoint("
      "${x.toStringAsFixed(3)}, "
      "${y.toStringAsFixed(3)}, "
      "${size.toStringAsFixed(3)}, "
      "${angle.toStringAsFixed(3)}, "
      "${response.toStringAsFixed(3)}, "
      "$octave, $classID)";
}

class VecKeyPoint extends Vec<cvg.VecKeyPoint, KeyPoint> implements CvStruct<cvg.VecKeyPoint> {
  VecKeyPoint.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecKeyPoint.fromVec(cvg.VecKeyPoint ref) {
    final p = calloc<cvg.VecKeyPoint>()..ref = ref;
    return VecKeyPoint.fromPointer(p);
  }

  factory VecKeyPoint.fromList(List<KeyPoint> pts) => VecKeyPoint.generate(pts.length, (i) => pts[i]);

  factory VecKeyPoint.generate(int length, KeyPoint Function(int) generator) {
    final p = calloc<cvg.KeyPoint>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecKeyPoint>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecKeyPoint.fromPointer(pp);
  }

  @override
  int get length => ref.length;

  @override
  Iterator<KeyPoint> get iterator => VecKeyPointIterator(ref);

  @override
  cvg.VecKeyPoint get ref => ptr.ref;
}

class VecKeyPointIterator extends VecIterator<KeyPoint> {
  VecKeyPointIterator(this.ref);
  cvg.VecKeyPoint ref;

  @override
  int get length => ref.length;

  @override
  KeyPoint operator [](int idx) => KeyPoint.fromNative(ref.ptr[idx]);
}

extension ListKeyPointExtension on List<KeyPoint> {
  VecKeyPoint get cvd => VecKeyPoint.fromList(this);
}
