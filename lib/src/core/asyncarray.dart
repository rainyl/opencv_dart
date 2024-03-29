library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import '../opencv.g.dart' as cvg;

class AsyncArray extends CvPtrVoid<cvg.AsyncArray> {
  AsyncArray._(cvg.AsyncArray ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }

  factory AsyncArray.fromPointer(cvg.AsyncArray ptr) => AsyncArray._(ptr);

  factory AsyncArray.empty() {
    final p = calloc<cvg.AsyncArray>();
    cvRun(() => CFFI.AsyncArray_New(p));
    final arr = AsyncArray._(p.value);
    calloc.free(p);
    return arr;
  }

  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.AsyncArray_Close);

  Mat get() {
    final dst = Mat.empty();
    cvRun(() => CFFI.AsyncArray_Get(ptr, dst.ptr));
    return dst;
  }

  @override
  List<int> get props => [ptr.address];
}
