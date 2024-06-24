library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

/// SVDCompute decomposes matrix and stores the results to user-provided matrices
///
/// https://docs.opencv.org/4.1.2/df/df7/classcv_1_1SVD.html#a76f0b2044df458160292045a3d3714c6
class SVD {
  static (Mat w, Mat u, Mat vt) compute(Mat src, {Mat? w, Mat? u, Mat? vt, int flags = 0}) {
    final pw = w?.ptr ?? calloc<cvg.Mat>();
    final pu = u?.ptr ?? calloc<cvg.Mat>();
    final pvt = vt?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.SVD_Compute(src.ref, pw, pu, pvt, flags));
    return (w ?? Mat.fromPointer(pw), u ?? Mat.fromPointer(pu), vt ?? Mat.fromPointer(pvt));
  }

  static Future<(Mat w, Mat u, Mat vt)> computeAsync(Mat src, {int flags = 0}) async =>
      cvRunAsync3((callback) => CFFI.SVD_Compute_Async(src.ref, flags, callback), matCompleter3);

  static Mat backSubst(Mat w, Mat u, Mat vt, Mat rhs, {Mat? dst}) {
    final pdst = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.SVD_backSubst(w.ref, u.ref, vt.ref, rhs.ref, pdst));
    return dst ?? Mat.fromPointer(pdst);
  }

  static Future<Mat> backSubstAsync(Mat w, Mat u, Mat vt, Mat rhs, {Mat? dst}) async => cvRunAsync(
        (callback) => CFFI.SVD_backSubst_Async(w.ref, u.ref, vt.ref, rhs.ref, callback),
        matCompleter,
      );
}
