// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.imgproc.clahe;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../g/imgproc.g.dart' as cvg;
import '../native_lib.dart' show cimgproc;

class CLAHE extends CvStruct<cvg.CLAHE> {
  CLAHE._(cvg.CLAHEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory CLAHE.fromPointer(cvg.CLAHEPtr ptr) => CLAHE._(ptr);
  factory CLAHE.empty() {
    final p = calloc<cvg.CLAHE>();
    cimgproc.cv_CLAHE_create(p);
    return CLAHE._(p);
  }

  factory CLAHE([double clipLimit = 40, (int width, int height) tileGridSize = (8, 8)]) =>
      CLAHE.create(clipLimit, tileGridSize);

  /// NewCLAHE returns a new CLAHE algorithm
  ///
  /// For further details, please see:
  /// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html
  factory CLAHE.create([double clipLimit = 40, (int width, int height) tileGridSize = (8, 8)]) {
    final p = calloc<cvg.CLAHE>();
    final size = calloc<cvg.CvSize>()
      ..ref.width = tileGridSize.$1
      ..ref.height = tileGridSize.$2;
    cimgproc.cv_CLAHE_create_1(clipLimit, size.ref, p);
    calloc.free(size);
    return CLAHE._(p);
  }

  /// Apply CLAHE.
  ///
  /// For further details, please see:
  /// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html#a4e92e0e427de21be8d1fae8dcd862c5e
  Mat apply(Mat src, {Mat? dst}) {
    dst ??= Mat.empty();
    cvRun(() => cimgproc.cv_CLAHE_apply(ref, src.ref, dst!.ref, ffi.nullptr));
    return dst;
  }

  Future<Mat> applyAsync(Mat src, {Mat? dst}) async {
    dst ??= Mat.empty();
    return cvRunAsync0((callback) => cimgproc.cv_CLAHE_apply(ref, src.ref, dst!.ref, callback), (c) {
      return c.complete(dst);
    });
  }

  double get clipLimit => cimgproc.cv_CLAHE_getClipLimit(ref);

  set clipLimit(double value) => cimgproc.cv_CLAHE_setClipLimit(ref, value);

  Size get tilesGridSize {
    final p = cimgproc.cv_CLAHE_getTilesGridSize(ref);
    return Size.fromPointer(p);
  }

  set tilesGridSize(Size value) => cimgproc.cv_CLAHE_setTilesGridSize(ref, value.ref);

  static final finalizer = OcvFinalizer<cvg.CLAHEPtr>(cimgproc.addresses.cv_CLAHE_close);

  void dispose() {
    finalizer.detach(this);
    cimgproc.cv_CLAHE_close(ptr);
  }

  @override
  cvg.CLAHE get ref => ptr.ref;
}

CLAHE createCLAHE({double clipLimit = 40, (int width, int height) tileGridSize = (8, 8)}) {
  return CLAHE.create(clipLimit, tileGridSize);
}
