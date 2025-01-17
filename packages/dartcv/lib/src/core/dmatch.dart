// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
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
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecDMatch([int length = 0]) => VecDMatch.fromPointer(ccore.std_VecDMatch_new(length));

  factory VecDMatch.fromList(List<DMatch> pts) =>
      VecDMatch.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecDMatch.generate(int length, DMatch Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecDMatch_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecDMatch_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecDMatch.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.VecDMatchPtr>(ccore.addresses.std_VecDMatch_free);

  @override
  VecDMatch clone() => VecDMatch.generate(length, (idx) => this[idx], dispose: false);

  @override
  void resize(int newSize) => ccore.std_VecDMatch_resize(ptr, newSize);

  @override
  void reserve(int newCapacity) => ccore.std_VecDMatch_reserve(ptr, newCapacity);

  @override
  void clear() => ccore.std_VecDMatch_clear(ptr);

  @override
  void shrinkToFit() => ccore.std_VecDMatch_shrink_to_fit(ptr);

  @override
  void extend(Vec other) => ccore.std_VecDMatch_extend(ptr, (other as VecDMatch).ptr);

  @override
  void add(DMatch element) => ccore.std_VecDMatch_push_back(ptr, element.ref);

  @override
  int size() => ccore.std_VecDMatch_length(ptr);

  @override
  int get length => ccore.std_VecDMatch_length(ptr);

  @override
  Iterator<DMatch> get iterator => VecDMatchIterator(ptr);
  @override
  cvg.VecDMatch get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, DMatch value) => ccore.std_VecDMatch_set(ptr, idx, value.ref);

  @override
  DMatch operator [](int idx) => DMatch.fromPointer(ccore.std_VecDMatch_get_p(ptr, idx));
}

class VecDMatchIterator extends VecIterator<DMatch> {
  VecDMatchIterator(this.ptr);
  cvg.VecDMatchPtr ptr;

  @override
  int get length => ccore.std_VecDMatch_length(ptr);

  @override
  DMatch operator [](int idx) => DMatch.fromPointer(ccore.std_VecDMatch_get_p(ptr, idx));
}

class VecVecDMatch extends VecUnmodifible<cvg.VecVecDMatch, VecDMatch> {
  VecVecDMatch.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecVecDMatch([int length = 0]) => VecVecDMatch.fromPointer(ccore.std_VecVecDMatch_new(length));

  factory VecVecDMatch.fromList(List<List<DMatch>> pts) =>
      VecVecDMatch.generate(pts.length, (i) => VecDMatch.fromList(pts[i]), dispose: false);

  factory VecVecDMatch.generate(int length, VecDMatch Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecVecDMatch_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecVecDMatch_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecVecDMatch.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.VecVecDMatchPtr>(ccore.addresses.std_VecVecDMatch_free);

  @override
  VecVecDMatch clone() => VecVecDMatch.generate(length, (i) => this[i], dispose: false);

  @override
  int size() => ccore.std_VecVecDMatch_length(ptr);

  @override
  int get length => ccore.std_VecVecDMatch_length(ptr);

  @override
  Iterator<VecDMatch> get iterator => VecVecDMatchIterator(ptr);
  @override
  cvg.VecVecDMatch get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecVecDMatch_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  VecDMatch operator [](int idx) => VecDMatch.fromPointer(ccore.std_VecVecDMatch_get_p(ptr, idx), false);

  List<List<DMatch>> copyToList() => List.generate(
        length,
        (i) => List.generate(
          ccore.std_VecVecDMatch_length_i(ptr, i),
          (j) => DMatch.fromPointer(ccore.std_VecVecDMatch_get_ij(ptr, i, j)),
        ),
      );
}

class VecVecDMatchIterator extends VecIterator<VecDMatch> {
  VecVecDMatchIterator(this.ptr);
  cvg.VecVecDMatchPtr ptr;

  @override
  int get length => ccore.std_VecVecDMatch_length(ptr);

  @override
  VecDMatch operator [](int idx) => VecDMatch.fromPointer(ccore.std_VecVecDMatch_get_p(ptr, idx), false);
}

extension ListDMatchExtension on List<DMatch> {
  VecDMatch get cvd => asVec();
  VecDMatch asVec() => VecDMatch.fromList(this);
}

extension ListListDMatchExtension on List<List<DMatch>> {
  VecVecDMatch get cvd => asVec();
  VecVecDMatch asVec() => VecVecDMatch.fromList(this);
}
