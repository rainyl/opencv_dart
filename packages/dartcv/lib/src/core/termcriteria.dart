// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import '../ffi.dart' as ffi;
import '../g/types.g.dart' if (dart.library.js_interop) '../g_web/types.g.dart' as cvg;
import '../package_ffi.dart';
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
    final p = calloc<cvg.TermCriteria>()
      ..ref.type = type
      ..ref.maxCount = cound
      ..ref.epsilon = eps;
    return TermCriteria.fromPointer(p);
  }

  factory TermCriteria.fromRecord((int type, int count, double eps) record) =>
      TermCriteria(record.$1, record.$2, record.$3);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  void freeNative() {
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

  /// The struct value to pass to a native function, on the Dart heap.
  ///
  /// Use it instead of `cvd.ref`: that takes a view of the native memory of a
  /// temporary wrapper, which a GC can free (through its finalizer) before
  /// the call copies the struct, and the native code then reads freed memory.
  cvg.TermCriteria get cvdRef => ffi.Struct.create<cvg.TermCriteria>()
    ..type = this.$1
    ..maxCount = this.$2
    ..epsilon = this.$3;
}
