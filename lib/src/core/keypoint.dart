library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class KeyPoint extends CvStruct<cvg.KeyPoint> {
  KeyPoint._(ffi.Pointer<cvg.KeyPoint> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
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
  factory KeyPoint.fromPointer(ffi.Pointer<cvg.KeyPoint> p) => KeyPoint._(p);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);
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

class VecKeyPoint extends Vec<KeyPoint> implements CvStruct<cvg.VecKeyPoint> {
  VecKeyPoint._(this.ptr) {
    finalizer.attach(this, ptr.cast());
  }
  factory VecKeyPoint.fromPointer(cvg.VecKeyPointPtr ptr) => VecKeyPoint._(ptr);
  factory VecKeyPoint.fromVec(cvg.VecKeyPoint ptr) {
    final p = calloc<cvg.VecKeyPoint>();
    cvRun(() => CFFI.VecKeyPoint_NewFromVec(ptr, p));
    final vec = VecKeyPoint._(p);
    return vec;
  }
  factory VecKeyPoint.fromList(List<KeyPoint> pts) {
    final ptr = calloc<cvg.VecKeyPoint>();
    cvRun(() => CFFI.VecKeyPoint_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecKeyPoint_Append(ptr.ref, pts[i].ref));
    }
    final vec = VecKeyPoint._(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecKeyPoint_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  @override
  cvg.VecKeyPointPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecKeyPointPtr>(CFFI.addresses.VecKeyPoint_Close);
  @override
  Iterator<KeyPoint> get iterator => VecKeyPointIterator(ref);

  @override
  cvg.VecKeyPoint get ref => ptr.ref;
}

class VecKeyPointIterator extends VecIterator<KeyPoint> {
  VecKeyPointIterator(this.ptr);
  cvg.VecKeyPoint ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecKeyPoint_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  KeyPoint operator [](int idx) {
    return cvRunArena<KeyPoint>((arena) {
      final p = arena<cvg.KeyPoint>();
      cvRun(() => CFFI.VecKeyPoint_At(ptr, idx, p));
      return KeyPoint.fromNative(p.ref);
    });
  }
}

extension ListKeyPointExtension on List<KeyPoint> {
  VecKeyPoint get cvd => VecKeyPoint.fromList(this);
}
