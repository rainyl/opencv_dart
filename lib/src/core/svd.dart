library cv.svd;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

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
    final pw = w?.ptr ?? calloc<ccore.Mat>();
    final pu = u?.ptr ?? calloc<ccore.Mat>();
    final pvt = vt?.ptr ?? calloc<ccore.Mat>();
    cvRun(() => ccore.SVD_Compute(src.ref, pw, pu, pvt, flags));
    return (w ?? Mat.fromPointer(pw), u ?? Mat.fromPointer(pu), vt ?? Mat.fromPointer(pvt));
  }

  /// async version of [compute]
  static Future<(Mat w, Mat u, Mat vt)> computeAsync(Mat src, {int flags = 0}) async =>
      cvRunAsync3((callback) => ccore.SVD_Compute_Async(src.ref, flags, callback), matCompleter3);

  static Mat backSubst(Mat w, Mat u, Mat vt, Mat rhs, {Mat? dst}) {
    final pdst = dst?.ptr ?? calloc<ccore.Mat>();
    cvRun(() => ccore.SVD_backSubst(w.ref, u.ref, vt.ref, rhs.ref, pdst));
    return dst ?? Mat.fromPointer(pdst);
  }

  static Future<Mat> backSubstAsync(Mat w, Mat u, Mat vt, Mat rhs, {Mat? dst}) async => cvRunAsync(
        (callback) => ccore.SVD_backSubst_Async(w.ref, u.ref, vt.ref, rhs.ref, callback),
        matCompleter,
      );
}
