library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'vec.dart';

class DMatch extends CvStruct<cvg.DMatch> {
  DMatch._(ffi.Pointer<cvg.DMatch> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory DMatch(int queryIdx, int trainIdx, int imgIdx, double distance) {
    final ptr = calloc<cvg.DMatch>()
      ..ref.queryIdx = queryIdx
      ..ref.trainIdx = trainIdx
      ..ref.imgIdx = imgIdx
      ..ref.distance = distance;
    return DMatch._(ptr);
  }
  factory DMatch.fromNative(cvg.DMatch r) => DMatch(r.queryIdx, r.trainIdx, r.imgIdx, r.distance);
  factory DMatch.fromPointer(ffi.Pointer<cvg.DMatch> p, [bool attach = true]) => DMatch._(p, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get queryIdx => ref.queryIdx;
  set queryIdx(int value) => ref.queryIdx = value;

  int get trainIdx => ref.trainIdx;
  set trainIdx(int value) => ref.trainIdx = value;

  int get imgIdx => ref.imgIdx;
  set imgIdx(int value) => ref.imgIdx = value;

  double get distance => ref.distance;
  set distance(double value) => ref.distance = value;

  @override
  List<Object?> get props => [queryIdx, trainIdx, imgIdx, distance];

  @override
  cvg.DMatch get ref => ptr.ref;
  @override
  String toString() => "DMatch($queryIdx, $trainIdx, $imgIdx, ${distance.toStringAsFixed(3)})";
}

class VecDMatch extends Vec<cvg.VecDMatch, DMatch> {
  VecDMatch.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecDMatch.fromList(List<DMatch> pts) =>
      VecDMatch.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecDMatch.generate(int length, DMatch Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecDMatch>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.DMatch>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecDMatch.fromPointer(pp);
  }

  @override
  VecDMatch clone() => VecDMatch.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<DMatch> get iterator => VecDMatchIterator(ref);
  @override
  cvg.VecDMatch get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecDMatch>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, DMatch value) {
    ref.ptr[idx].queryIdx = value.queryIdx;
    ref.ptr[idx].trainIdx = value.trainIdx;
    ref.ptr[idx].imgIdx = value.imgIdx;
    ref.ptr[idx].distance = value.distance;
  }
}

class VecDMatchIterator extends VecIterator<DMatch> {
  VecDMatchIterator(this.ref);
  cvg.VecDMatch ref;

  @override
  int get length => ref.length;

  @override
  DMatch operator [](int idx) => DMatch.fromPointer(ref.ptr + idx, false);
}

class VecVecDMatch extends Vec<cvg.VecVecDMatch, VecDMatch> {
  VecVecDMatch.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVecDMatch.fromList(List<List<DMatch>> pts) =>
      VecVecDMatch.generate(pts.length, (i) => VecDMatch.fromList(pts[i]), dispose: false);

  factory VecVecDMatch.generate(int length, VecDMatch Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecVecDMatch>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.VecDMatch>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecVecDMatch.fromPointer(pp);
  }

  @override
  VecVecDMatch clone() => VecVecDMatch.generate(length, (idx) => this[idx], dispose: false);

  @override
  Iterator<VecDMatch> get iterator => VecVecDMatchIterator(ref);
  @override
  cvg.VecVecDMatch get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecVecDMatch>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  // TODO: add support
  @override
  void operator []=(int idx, VecDMatch value) => throw UnsupportedError("");
}

class VecVecDMatchIterator extends VecIterator<VecDMatch> {
  VecVecDMatchIterator(this.ref);
  cvg.VecVecDMatch ref;

  @override
  int get length => ref.length;

  @override
  VecDMatch operator [](int idx) => VecDMatch.fromPointer(ref.ptr + idx, false);
}

extension ListDMatchExtension on List<DMatch> {
  VecDMatch get cvd => VecDMatch.fromList(this);
}

extension ListListDMatchExtension on List<List<DMatch>> {
  VecVecDMatch get cvd => VecVecDMatch.fromList(this);
}
