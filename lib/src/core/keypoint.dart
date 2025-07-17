// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/core.g.dart' as ccore;
import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'vec.dart';

class KeyPoint extends CvStruct<cvg.KeyPoint> {
  KeyPoint._(ffi.Pointer<cvg.KeyPoint> ptr, {bool attach = true}) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.KeyPoint>());
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
  factory KeyPoint.fromNative(cvg.KeyPoint r) =>
      KeyPoint(r.x, r.y, r.size, r.angle, r.response, r.octave, r.classID);
  factory KeyPoint.fromPointer(ffi.Pointer<cvg.KeyPoint> p, {bool attach = true}) =>
      KeyPoint._(p, attach: attach);

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
  String toString() =>
      "KeyPoint("
      "${x.toStringAsFixed(3)}, "
      "${y.toStringAsFixed(3)}, "
      "${size.toStringAsFixed(3)}, "
      "${angle.toStringAsFixed(3)}, "
      "${response.toStringAsFixed(3)}, "
      "$octave, $classID)";
}

class VecKeyPoint extends Vec<cvg.VecKeyPoint, KeyPoint> {
  VecKeyPoint.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<cvg.KeyPoint>(),
      );
    }
  }

  factory VecKeyPoint([int length = 0]) =>
      VecKeyPoint.fromPointer(ccore.std_VecKeyPoint_new(length), length: length);

  factory VecKeyPoint.fromList(List<KeyPoint> pts) =>
      VecKeyPoint.generate(pts.length, (i) => pts[i], dispose: false);

  factory VecKeyPoint.generate(int length, KeyPoint Function(int i) generator, {bool dispose = true}) {
    final p = ccore.std_VecKeyPoint_new(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      ccore.std_VecKeyPoint_set(p, i, v.ref);
      if (dispose) v.dispose();
    }
    return VecKeyPoint.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecKeyPointPtr>(ccore.addresses.std_VecKeyPoint_free);

  @override
  VecKeyPoint clone() => VecKeyPoint.generate(length, (idx) => this[idx], dispose: false);

  @override
  void resize(int newSize) => ccore.std_VecKeyPoint_resize(ptr, newSize);

  @override
  void reserve(int newCapacity) => ccore.std_VecKeyPoint_reserve(ptr, newCapacity);

  @override
  void clear() => ccore.std_VecKeyPoint_clear(ptr);

  @override
  void shrinkToFit() => ccore.std_VecKeyPoint_shrink_to_fit(ptr);

  @override
  void extend(Vec other) => ccore.std_VecKeyPoint_extend(ptr, (other as VecKeyPoint).ptr);

  @override
  void add(KeyPoint element) => ccore.std_VecKeyPoint_push_back(ptr, element.ref);

  @override
  int size() => ccore.std_VecKeyPoint_length(ptr);

  @override
  int get length => ccore.std_VecKeyPoint_length(ptr);

  @override
  Iterator<KeyPoint> get iterator => VecKeyPointIterator(ptr);

  @override
  cvg.VecKeyPoint get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecKeyPoint_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void operator []=(int idx, KeyPoint value) => ccore.std_VecKeyPoint_set(ptr, idx, value.ref);

  @override
  KeyPoint operator [](int idx) => KeyPoint.fromPointer(ccore.std_VecKeyPoint_get_p(ptr, idx));
}

class VecKeyPointIterator extends VecIterator<KeyPoint> {
  VecKeyPointIterator(this.ptr);
  cvg.VecKeyPointPtr ptr;

  @override
  int get length => ccore.std_VecKeyPoint_length(ptr);

  @override
  KeyPoint operator [](int idx) => KeyPoint.fromPointer(ccore.std_VecKeyPoint_get_p(ptr, idx));
}

extension ListKeyPointExtension on List<KeyPoint> {
  VecKeyPoint get cvd => asVec();
  VecKeyPoint asVec() => VecKeyPoint.fromList(this);
}
