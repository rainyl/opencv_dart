library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class AsyncArray implements ffi.Finalizable {
  AsyncArray._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  factory AsyncArray.fromPointer(cvg.AsyncArray ptr) => AsyncArray._(ptr);

  factory AsyncArray.empty() {
    return using<AsyncArray>((arena) {
      final ptr = arena<cvg.AsyncArray>();
      final status = _bindings.AsyncArray_New(ptr);
      throwIfFailed(status);
      return AsyncArray._(ptr.value);
    });
  }

  cvg.AsyncArray ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.AsyncArray_Close);

  Mat get() {
    return using<Mat>((arena) {
      final dst = Mat.empty();
      final status = _bindings.AsyncArray_Get(ptr, dst.ptr);
      throwIfFailed(status);
      return dst;
    });
  }
}
