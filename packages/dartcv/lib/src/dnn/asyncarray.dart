// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.dnn;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/dnn.g.dart' as cvg;
import '../g/dnn.g.dart' as cdnn;

class AsyncArray extends CvStruct<cvg.AsyncArray> {
  AsyncArray._(cvg.AsyncArrayPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory AsyncArray.fromPointer(cvg.AsyncArrayPtr ptr, [bool attach = true]) => AsyncArray._(ptr, attach);

  factory AsyncArray.empty() {
    final p = calloc<cvg.AsyncArray>();
    cvRun(() => cdnn.cv_dnn_AsyncArray_new(p));
    final arr = AsyncArray._(p);
    return arr;
  }

  static final finalizer = OcvFinalizer<cvg.AsyncArrayPtr>(cdnn.addresses.cv_dnn_AsyncArray_close);

  void dispose() {
    finalizer.detach(this);
    cdnn.cv_dnn_AsyncArray_close(ptr);
  }

  Mat get() {
    final dst = Mat.empty();
    cvRun(() => cdnn.cv_dnn_AsyncArray_get(ref, dst.ref));
    return dst;
  }

  @override
  cvg.AsyncArray get ref => ptr.ref;
}
