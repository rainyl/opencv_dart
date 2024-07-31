library cv.dnn;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/dnn.g.dart' as cdnn;

class AsyncArray extends CvStruct<cdnn.AsyncArray> {
  AsyncArray._(cdnn.AsyncArrayPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory AsyncArray.fromPointer(cdnn.AsyncArrayPtr ptr, [bool attach = true]) => AsyncArray._(ptr, attach);

  factory AsyncArray.empty() {
    final p = calloc<cdnn.AsyncArray>();
    cvRun(() => cdnn.AsyncArray_New(p));
    final arr = AsyncArray._(p);
    return arr;
  }

  static final finalizer = OcvFinalizer<cdnn.AsyncArrayPtr>(cdnn.addresses.AsyncArray_Close);

  void dispose() {
    finalizer.detach(this);
    cdnn.AsyncArray_Close(ptr);
  }

  Mat get() {
    final dst = Mat.empty();
    cvRun(() => cdnn.AsyncArray_Get(ref, dst.ref));
    return dst;
  }

  @override
  cdnn.AsyncArray get ref => ptr.ref;
}
