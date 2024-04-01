library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class DMatch extends CvStruct<cvg.DMatch> {
  DMatch._(ffi.Pointer<cvg.DMatch> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
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
  factory DMatch.fromPointer(ffi.Pointer<cvg.DMatch> p) => DMatch._(p);

  static final finalizer = Finalizer<ffi.Pointer<cvg.DMatch>>((p0) => calloc.free(p0));
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

class VecDMatch extends Vec<DMatch> implements CvStruct<cvg.VecDMatch> {
  VecDMatch._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecDMatch.fromPointer(cvg.VecDMatchPtr ptr) => VecDMatch._(ptr);
  factory VecDMatch.fromVec(cvg.VecDMatch ptr) {
    final p = calloc<cvg.VecDMatch>();
    cvRun(() => CFFI.VecDMatch_NewFromVec(ptr, p));
    final vec = VecDMatch._(p);
    return vec;
  }
  factory VecDMatch.fromList(List<DMatch> pts) {
    final ptr = calloc<cvg.VecDMatch>();
    cvRun(() => CFFI.VecDMatch_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecDMatch_Append(ptr.ref, pts[i].ref));
    }
    final vec = VecDMatch._(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecDMatch_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  static final finalizer = Finalizer<cvg.VecDMatchPtr>((p) {
    CFFI.VecDMatch_Close(p);
    calloc.free(p);
  });
  @override
  Iterator<DMatch> get iterator => VecDMatchIterator(ref);
  @override
  cvg.VecDMatch get ref => ptr.ref;
  @override
  ffi.Pointer<cvg.VecDMatch> ptr;
}

class VecDMatchIterator extends VecIterator<DMatch> {
  VecDMatchIterator(this.ptr);
  cvg.VecDMatch ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecDMatch_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  DMatch operator [](int idx) {
    return cvRunArena<DMatch>((arena) {
      final p = arena<cvg.DMatch>();
      cvRun(() => CFFI.VecDMatch_At(ptr, idx, p));
      return DMatch.fromNative(p.ref);
    });
  }
}

class VecVecDMatch extends Vec<VecDMatch> implements CvStruct<cvg.VecVecDMatch> {
  VecVecDMatch._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecVecDMatch.fromPointer(cvg.VecVecDMatchPtr ptr) => VecVecDMatch._(ptr);
  factory VecVecDMatch.fromVec(cvg.VecVecDMatch ptr) {
    final p = calloc<cvg.VecVecDMatch>();
    cvRun(() => CFFI.VecVecDMatch_NewFromVec(ptr, p));
    final vec = VecVecDMatch._(p);
    return vec;
  }
  factory VecVecDMatch.fromList(List<List<DMatch>> pts) {
    final p = calloc<cvg.VecVecDMatch>();
    cvRun(() => CFFI.VecVecDMatch_New(p));
    for (var i = 0; i < pts.length; i++) {
      final point = pts[i].ocv;
      cvRun(() => CFFI.VecVecDMatch_Append(p.ref, point.ref));
    }
    final vec = VecVecDMatch._(p);
    return vec;
  }

  @override
  cvg.VecVecDMatchPtr ptr;
  static final finalizer = Finalizer<cvg.VecVecDMatchPtr>((p) {
    CFFI.VecVecDMatch_Close(p);
    calloc.free(p);
  });
  @override
  Iterator<VecDMatch> get iterator => VecVecDMatchIterator(ref);
  @override
  cvg.VecVecDMatch get ref => ptr.ref;
}

class VecVecDMatchIterator extends VecIterator<VecDMatch> {
  VecVecDMatchIterator(this.ptr);
  cvg.VecVecDMatch ptr;

  @override
  int get length => using<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.VecVecDMatch_Size(ptr, p));
        final len = p.value;
        return len;
      });

  @override
  VecDMatch operator [](int idx) {
    return cvRunArena<VecDMatch>((arena) {
      final p = arena<cvg.VecDMatch>();
      cvRun(() => CFFI.VecVecDMatch_At(ptr, idx, p));
      final vec = VecDMatch.fromVec(p.ref);
      return vec;
    });
  }
}

extension ListDMatchExtension on List<DMatch> {
  VecDMatch get ocv => VecDMatch.fromList(this);
}

extension ListListDMatchExtension on List<List<DMatch>> {
  VecVecDMatch get ocv => VecVecDMatch.fromList(this);
}
