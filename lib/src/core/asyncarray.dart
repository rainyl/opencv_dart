library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/src/core/cv_exception.dart';

import '../core/mat_type.dart';
import '../core/point.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class AsyncArray implements ffi.Finalizable {
  AsyncArray._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  factory AsyncArray.empty() {
    final _ptr = _bindings.AsyncArray_New();
    return AsyncArray._(_ptr);
  }

  cvg.AsyncArray ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.AsyncArray_Close);

  Mat get() {
    return using<Mat>((arena) {
      final dst = Mat.empty();
      final result = _bindings.AsyncArray_GetAsync(ptr, dst.ptr);
      final dartStr = result.cast<Utf8>().toDartString();
      if (dartStr.length > 0) throw OpenCvDartException("$dartStr");
      return dst;
    });
  }
}
