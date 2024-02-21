library cv;

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// SVDCompute decomposes matrix and stores the results to user-provided matrices
///
/// https://docs.opencv.org/4.1.2/df/df7/classcv_1_1SVD.html#a76f0b2044df458160292045a3d3714c6
class SVD {
  static void compute(Mat src, Mat w, Mat u, Mat vt, {int flags = 0}) {
    _bindings.SVD_Compute(src.ptr, w.ptr, u.ptr, vt.ptr, flags);
  }
}
