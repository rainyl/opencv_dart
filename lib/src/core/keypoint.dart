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
  set x(double value) => ref.x = value;

  double get y => ref.y;
  set y(double value) => ref.y = value;

  double get size => ref.size;
  set size(double value) => ref.size = value;

  double get angle => ref.angle;
  set angle(double value) => ref.angle = value;

  double get response => ref.response;
  set response(double value) => ref.response = value;

  int get octave => ref.octave;
  set octave(int value) => ref.octave = value;

  int get classID => ref.classID;
  set classID(int value) => ref.classID = value;

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

class VecKeyPoint extends Vec<cvg.VecKeyPoint, KeyPoint> {
  VecKeyPoint.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecKeyPoint.fromList(List<KeyPoint> pts) =>
      VecKeyPoint.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecKeyPoint.generate(int length, KeyPoint Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecKeyPoint>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.KeyPoint>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecKeyPoint.fromPointer(pp);
  }

  @override
  VecKeyPoint clone() => VecKeyPoint.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<KeyPoint> get iterator => VecKeyPointIterator(ref);

  @override
  cvg.VecKeyPoint get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecKeyPoint>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, KeyPoint value) {
    ref.ptr[idx].x = value.x;
    ref.ptr[idx].y = value.y;
    ref.ptr[idx].size = value.size;
    ref.ptr[idx].angle = value.angle;
    ref.ptr[idx].octave = value.octave;
    ref.ptr[idx].classID = value.classID;
    ref.ptr[idx].response = value.response;
  }

  @override
  KeyPoint operator [](int idx) => KeyPoint.fromPointer(ref.ptr + idx, false);
}

class VecKeyPointIterator extends VecIterator<KeyPoint> {
  VecKeyPointIterator(this.ref);
  cvg.VecKeyPoint ref;

  @override
  int get length => ref.length;

  @override
  KeyPoint operator [](int idx) => KeyPoint.fromPointer(ref.ptr + idx, false);
}

extension ListKeyPointExtension on List<KeyPoint> {
  VecKeyPoint get cvd => VecKeyPoint.fromList(this);
}
