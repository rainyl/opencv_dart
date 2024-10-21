// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.video;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/termcriteria.dart';
import '../core/vec.dart';
import '../g/constants.g.dart';
import '../g/video.g.dart' as cvg;
import '../native_lib.dart' show cvideo;
import 'video.dart';

extension BackgroundSubtractorMOG2Async on BackgroundSubtractorMOG2 {
  Future<Mat> applyAsync(Mat src) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => cvideo.cv_BackgroundSubtractorMOG2_apply(ref, src.ref, dst.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}

extension BackgroundSubtractorKNNAsync on BackgroundSubtractorKNN {
  Future<Mat> applyAsync(Mat src) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => cvideo.cv_BackgroundSubtractorKNN_apply(ref, src.ref, dst.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}

/// Apply computes a foreground mask using the current BackgroundSubtractorMOG2.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/df6/classcv_1_1BackgroundSubtractor.html#aa735e76f7069b3fa9c3f32395f9ccd21

/// CalcOpticalFlowFarneback computes a dense optical flow using
/// Gunnar Farneback's algorithm.
///
/// For further details, please see:
/// https://docs.opencv.org/master/dc/d6b/group__video__track.html#ga5d10ebbd59fe09c5f650289ec0ece5af
Future<Mat> calcOpticalFlowFarnebackAsync(
  InputArray prev,
  InputArray next,
  InputOutputArray flow,
  double pyrScale,
  int levels,
  int winsize,
  int iterations,
  int polyN,
  double polySigma,
  int flags,
) async {
  return cvRunAsync0(
    (callback) => cvideo.cv_calcOpticalFlowFarneback(
      prev.ref,
      next.ref,
      flow.ref,
      pyrScale,
      levels,
      winsize,
      iterations,
      polyN,
      polySigma,
      flags,
      callback,
    ),
    (c) {
      return c.complete(flow);
    },
  );
}

/// CalcOpticalFlowPyrLK calculates an optical flow for a sparse feature set using
/// the iterative Lucas-Kanade method with pyramids.
///
/// For further details, please see:
/// https://docs.opencv.org/master/dc/d6b/group__video__track.html#ga473e4b886d0bcc6b65831eb88ed93323
Future<(VecPoint2f nextPts, VecUChar status, VecF32 error)> calcOpticalFlowPyrLKAsync(
  InputArray prevImg,
  InputArray nextImg,
  VecPoint2f prevPts,
  VecPoint2f nextPts, {
  VecUChar? status,
  VecF32? err,
  (int, int) winSize = (21, 21),
  int maxLevel = 3,
  (int, int, double) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
  int flags = 0,
  double minEigThreshold = 1e-4,
}) {
  final s = status?.ptr ?? calloc<cvg.VecUChar>();
  final e = err?.ptr ?? calloc<cvg.VecF32>();
  return cvRunAsync0(
    (callback) => cvideo.cv_calcOpticalFlowPyrLK_1(
      prevImg.ref,
      nextImg.ref,
      prevPts.ref,
      nextPts.ptr,
      s,
      e,
      winSize.cvd.ref,
      maxLevel,
      criteria.toTermCriteria().ref,
      flags,
      minEigThreshold,
      callback,
    ),
    (c) {
      nextPts.reattach();
      return c.complete((nextPts, status ?? VecUChar.fromPointer(s), VecF32.fromPointer(e)));
    },
  );
}

/// FindTransformECC finds the geometric transform (warp) between two images in terms of the ECC criterion.
///
/// For futther details, please see:
/// https://docs.opencv.org/4.x/dc/d6b/group__video__track.html#ga1aa357007eaec11e9ed03500ecbcbe47
Future<(double ret, Mat warpMatrix)> findTransformECCAsync(
  InputArray templateImage,
  InputArray inputImage,
  InputOutputArray warpMatrix,
  int motionType,
  (int, int, double) criteria,
  InputArray inputMask,
  int gaussFiltSize,
) {
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => cvideo.cv_findTransformECC(
      templateImage.ref,
      inputImage.ref,
      warpMatrix.ref,
      motionType,
      criteria.toTermCriteria().ref,
      inputMask.ref,
      gaussFiltSize,
      p,
      callback,
    ),
    (c) {
      final rval = (p.value, warpMatrix);
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// Tracker is the base interface for object tracking.
///
/// see: https://docs.opencv.org/master/d0/d0a/classcv_1_1Tracker.html
extension TrackerMILAsync on TrackerMIL {
  Future<void> initAsync(InputArray image, Rect boundingBox) async {
    cvAssert(boundingBox.x >= 0, "boundingBox.x must be >= 0");
    cvAssert(boundingBox.y >= 0, "boundingBox.y must be >= 0");
    cvAssert(
      boundingBox.right <= image.cols,
      "boundingBox.right=${boundingBox.right} must be <= image.cols=${image.cols}",
    );
    cvAssert(
      boundingBox.bottom <= image.rows,
      "boundingBox.bottom=${boundingBox.bottom} must be <= image.rows=${image.rows}",
    );

    return cvRunAsync0(
      (callback) => cvideo.cv_TrackerMIL_init(ref, image.ref, boundingBox.ref, callback),
      (c) {
        c.complete();
      },
    );
  }

  /// Update the tracker, find the new most likely bounding box for the target.
  /// https://docs.opencv.org/4.x/d0/d0a/classcv_1_1Tracker.html#a92d2012f576e6c06eb2e257d110a6529
  Future<(bool, Rect)> updateAsync(Mat img) async {
    final bBox = calloc<cvg.CvRect>();
    final p = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideo.cv_TrackerMIL_update(ref, img.ref, bBox, p, callback),
      (c) {
        final rval = (p.value, Rect.fromPointer(bBox));
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }
}

/// KalmanFilter implements a standard Kalman filter http://en.wikipedia.org/wiki/Kalman_filter.
/// However, you can modify transitionMatrix, controlMatrix, and measurementMatrix
/// to get an extended Kalman filter functionality.
///
/// For further details, please see:
/// https://docs.opencv.org/4.6.0/dd/d6a/classcv_1_1KalmanFilter.html
extension KalmanFilterAsync on KalmanFilter {
  Future<Mat> correctAsync(Mat measurement) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => cvideo.cv_KalmanFilter_correct(ref, measurement.ref, dst.ptr, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  Future<Mat> predictAsync({Mat? control}) async {
    final dst = Mat.empty();
    if (control == null) {
      return cvRunAsync0(
        (callback) => cvideo.cv_KalmanFilter_predict(ref, dst.ptr, callback),
        (c) {
          return c.complete(dst);
        },
      );
    }
    return cvRunAsync0(
      (callback) => cvideo.cv_KalmanFilter_predict_1(ref, control.ref, dst.ptr, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  Future<void> initAsync(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) async {
    return cvRunAsync0(
      (callback) =>
          cvideo.cv_KalmanFilter_init_1(ref, dynamParams, measureParams, controlParams, type, callback),
      (c) {
        c.complete();
      },
    );
  }
}
