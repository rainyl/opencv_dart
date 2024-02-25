library cv;

import 'dart:ffi' as ffi;

import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

class DMatch extends CvObject with EquatableMixin {
  DMatch._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  factory DMatch(int queryIdx, int trainIdx, int imgIdx, double distance) {
    final _ptr = calloc<cvg.DMatch>()
      ..ref.queryIdx = queryIdx
      ..ref.trainIdx = trainIdx
      ..ref.imgIdx = imgIdx
      ..ref.distance = distance;
    return DMatch._(_ptr);
  }
  factory DMatch.fromNative(cvg.DMatch r) =>
      DMatch(r.queryIdx, r.trainIdx, r.imgIdx, r.distance);
  factory DMatch.fromPointer(ffi.Pointer<cvg.DMatch> p) => DMatch._(p);

  static final _finalizer =
      Finalizer<ffi.Pointer<cvg.DMatch>>((p0) => calloc.free(p0));
  int get queryIdx => _ptr.ref.queryIdx;
  int get trainIdx => _ptr.ref.trainIdx;
  int get imgIdx => _ptr.ref.imgIdx;
  double get distance => _ptr.ref.distance;
  ffi.Pointer<cvg.DMatch> _ptr;
  @override
  ffi.Pointer<cvg.DMatch> get ptr => _ptr;
  @override
  List<Object?> get props => [queryIdx, trainIdx, imgIdx, distance];

  @override
  cvg.DMatch get ref => _ptr.ref;
  @override
  cvg.DMatch toNative() => _ptr.ref;

  @override
  String toString() => "DMatch($queryIdx, $trainIdx, $imgIdx, $distance)";
}

abstract class DMatches {
  static List<DMatch> toList(cvg.DMatches matchesPtr) {
    return List.generate(
      matchesPtr.length,
      (index) => DMatch.fromNative(matchesPtr.dmatches[index]),
    );
  }
}

abstract class MultiDMatches {
  static List<List<DMatch>> toList(cvg.MultiDMatches multiDMatches) {
    return List.generate(
      multiDMatches.length,
      (i) => List.generate(
        multiDMatches.dmatches[i].length,
        (j) => DMatch.fromNative(multiDMatches.dmatches[i].dmatches[j]),
      ),
    );
  }
}

extension ListDMatchExtension on List<DMatch> {
  ffi.Pointer<cvg.DMatches> toNative(Arena arena) {
    final array = arena<cvg.DMatch>(length);
    for (var i = 0; i < this.length; i++) {
      array[i] = this[i].ref;
    }
    final vec = arena<cvg.DMatches>()
      ..ref.dmatches = array
      ..ref.length = length;
    return vec;
  }
}

extension ListListDMatchExtension on List<List<DMatch>> {
  ffi.Pointer<cvg.MultiDMatches> toNative(Arena arena) {
    final vec = arena<cvg.MultiDMatches>()..ref.length = this.length;
    for (var i = 0; i < this.length; i++) {
      final tmp = arena<cvg.DMatches>()..ref.length = this[i].length;
      for (var j = 0; j < this[i].length; j++) {
        tmp.ref.dmatches[j] = this[i][j].ref;
      }
      vec.ref.dmatches[i] = tmp.ref;
    }
    return vec;
  }
}
