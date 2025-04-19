// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';

/// TermCriteria is the criteria for iterative algorithms.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d5d/classcv_1_1TermCriteria.html
// typedef TermCriteria = (int type, int count, double eps);

class TermCriteria extends CvStruct<cvg.TermCriteria> {
  TermCriteria.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.TermCriteria>());
    }
  }

  factory TermCriteria(int type, int cound, double eps) {
    final p =
        calloc<cvg.TermCriteria>()
          ..ref.type = type
          ..ref.maxCount = cound
          ..ref.epsilon = eps;
    return TermCriteria.fromPointer(p);
  }

  factory TermCriteria.fromRecord((int type, int count, double eps) record) =>
      TermCriteria(record.$1, record.$2, record.$3);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get type => ref.type;
  int get maxCount => ref.maxCount;
  double get eps => ref.epsilon;

  @override
  List<num> get props => [type, maxCount, eps];

  @override
  cvg.TermCriteria get ref => ptr.ref;
}

extension TermCriteriaExtension on (int, int, double) {
  TermCriteria get cvd => toTermCriteria();
  TermCriteria toTermCriteria() => TermCriteria(this.$1, this.$2, this.$3);
}
