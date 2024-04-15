library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import '../opencv.g.dart' as cvg;

class AsyncArray extends CvStruct<cvg.AsyncArray> {
  AsyncArray._(cvg.AsyncArrayPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory AsyncArray.fromPointer(cvg.AsyncArrayPtr ptr) => AsyncArray._(ptr);

  factory AsyncArray.empty() {
    final p = calloc<cvg.AsyncArray>();
    cvRun(() => cvg.AsyncArray_New(p));
    final arr = AsyncArray._(p);
    return arr;
  }

  static final finalizer = OcvFinalizer<cvg.AsyncArrayPtr>(ffi.Native.addressOf(cvg.AsyncArray_Close));

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
