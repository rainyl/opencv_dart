library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import '../opencv.g.dart' as cvg;

class AsyncArray extends CvStruct<cvg.AsyncArray> {
  AsyncArray._(cvg.AsyncArrayPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory AsyncArray.fromPointer(cvg.AsyncArrayPtr ptr, [bool attach = true]) =>
      AsyncArray._(ptr, attach);

  factory AsyncArray.empty() {
    final p = calloc<cvg.AsyncArray>();
    cvRun(() => cvg.AsyncArray_New(p));
    final arr = AsyncArray._(p);
    return arr;
  }

  static final finalizer =
      OcvFinalizer<cvg.AsyncArrayPtr>(ffi.Native.addressOf(cvg.AsyncArray_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.AsyncArray_Close(ptr);
  }

  Mat get() {
    final dst = Mat.empty();
    cvRun(() => cvg.AsyncArray_Get(ref, dst.ref));
    return dst;
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.AsyncArray get ref => ptr.ref;
}
