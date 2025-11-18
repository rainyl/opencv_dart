// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.svd;

import 'dart:ffi' as ffi;

import '../g/core.g.dart' as ccore;
import 'base.dart';
import 'mat.dart';

/// SVDCompute decomposes matrix and stores the results to user-provided matrices
///
/// https://docs.opencv.org/4.1.2/df/df7/classcv_1_1SVD.html#a76f0b2044df458160292045a3d3714c6
class SVD {
  ///   decomposes matrix and stores the results to user-provided matrices
  /// The methods/functions perform SVD of matrix.
  ///
  /// https://docs.opencv.org/4.1.2/df/df7/classcv_1_1SVD.html#a76f0b2044df458160292045a3d3714c6
  static (Mat w, Mat u, Mat vt) compute(Mat src, {Mat? w, Mat? u, Mat? vt, int flags = 0}) {
    w ??= Mat.empty();
    u ??= Mat.empty();
    vt ??= Mat.empty();
    cvRun(() => ccore.cv_SVD_Compute(src.ref, w!.ref, u!.ref, vt!.ref, flags, ffi.nullptr));
    return (w, u, vt);
  }

  /// async version of [compute]
  static Future<(Mat w, Mat u, Mat vt)> computeAsync(
    Mat src, {
    Mat? w,
    Mat? u,
    Mat? vt,
    int flags = 0,
  }) async {
    w ??= Mat.empty();
    u ??= Mat.empty();
    vt ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccore.cv_SVD_Compute(src.ref, w!.ref, u!.ref, vt!.ref, flags, callback),
      (c) => c.complete((w!, u!, vt!)),
    );
  }

  static Mat backSubst(Mat w, Mat u, Mat vt, Mat rhs, {Mat? dst}) {
    dst ??= Mat.empty();
    cvRun(() => ccore.cv_SVD_backSubst(w.ref, u.ref, vt.ref, rhs.ref, dst!.ref, ffi.nullptr));
    return dst;
  }

  static Future<Mat> backSubstAsync(Mat w, Mat u, Mat vt, Mat rhs, {Mat? dst}) async {
    dst ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccore.cv_SVD_backSubst(w.ref, u.ref, vt.ref, rhs.ref, dst!.ref, callback),
      (c) => c.complete(dst),
    );
  }
}
