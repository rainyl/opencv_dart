library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/opencv_core.dart';

import '../g/types.g.dart' as cvg;

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
  int get trainIdx => ref.trainIdx;
  int get imgIdx => ref.imgIdx;
  double get distance => ref.distance;
  @override
  List<Object?> get props => [queryIdx, trainIdx, imgIdx, distance];

  @override
  cvg.DMatch get ref => ptr.ref;
  @override
  String toString() => "DMatch($queryIdx, $trainIdx, $imgIdx, ${distance.toStringAsFixed(3)})";
}

class VecDMatch extends Vec<cvg.VecDMatch, DMatch> implements CvStruct<cvg.VecDMatch> {
  VecDMatch.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecDMatch.fromVec(cvg.VecDMatch ref) {
    final p = calloc<cvg.VecDMatch>()..ref = ref;
    return VecDMatch.fromPointer(p);
  }

  factory VecDMatch.fromList(List<DMatch> pts) => VecDMatch.generate(pts.length, (i) => pts[i]);

  factory VecDMatch.generate(int length, DMatch Function(int i) generator) {
    final p = calloc<cvg.DMatch>(length);
    for (var i = 0; i < length; i++) {
      p[i] = generator(i).ref;
    }
    final ptr = calloc<cvg.VecDMatch>()
      ..ref.ptr = p
      ..ref.length = length;
    return VecDMatch.fromPointer(ptr);
  }

  @override
  int get length => ref.length;

  @override
  Iterator<DMatch> get iterator => VecDMatchIterator(ref);
  @override
  cvg.VecDMatch get ref => ptr.ref;
}

class VecDMatchIterator extends VecIterator<DMatch> {
  VecDMatchIterator(this.ref);
  cvg.VecDMatch ref;

  @override
  int get length => ref.length;

  @override
  DMatch operator [](int idx) => DMatch.fromNative(ref.ptr[idx]);
}

class VecVecDMatch extends Vec<cvg.VecVecDMatch, VecDMatch> implements CvStruct<cvg.VecVecDMatch> {
  VecVecDMatch.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecVecDMatch.fromVec(cvg.VecVecDMatch ref) {
    final p = calloc<cvg.VecVecDMatch>()..ref = ref;
    return VecVecDMatch.fromPointer(p);
  }

  factory VecVecDMatch.fromList(List<List<DMatch>> pts) =>
      VecVecDMatch.generate(pts.length, (i) => VecDMatch.fromList(pts[i]));

  factory VecVecDMatch.generate(int length, VecDMatch Function(int i) generator) {
    final p = calloc<cvg.VecDMatch>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecVecDMatch>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecVecDMatch.fromPointer(pp);
  }

  @override
  Iterator<VecDMatch> get iterator => VecVecDMatchIterator(ref);
  @override
  cvg.VecVecDMatch get ref => ptr.ref;
}

class VecVecDMatchIterator extends VecIterator<VecDMatch> {
  VecVecDMatchIterator(this.ref);
  cvg.VecVecDMatch ref;

  @override
  int get length => ref.length;

  @override
  VecDMatch operator [](int idx) => VecDMatch.fromVec(ref.ptr[idx]);
}

extension ListDMatchExtension on List<DMatch> {
  VecDMatch get cvd => VecDMatch.fromList(this);
}

extension ListListDMatchExtension on List<List<DMatch>> {
  VecVecDMatch get cvd => VecVecDMatch.fromList(this);
}
