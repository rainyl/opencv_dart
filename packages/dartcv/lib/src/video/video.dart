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

class BackgroundSubtractorMOG2 extends CvStruct<cvg.BackgroundSubtractorMOG2> {
  BackgroundSubtractorMOG2(cvg.BackgroundSubtractorMOG2Ptr ptr, [bool attach = true])
      : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory BackgroundSubtractorMOG2.empty() {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(() => cvideo.cv_BackgroundSubtractorMOG2_create(p));
    return BackgroundSubtractorMOG2(p);
  }
  factory BackgroundSubtractorMOG2.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(
      () => cvideo.cv_BackgroundSubtractorMOG2_create_1(
        history,
        varThreshold,
        detectShadows,
        p,
      ),
    );
    return BackgroundSubtractorMOG2(p);
  }

  Mat apply(Mat src) {
    final dst = Mat.empty();
    cvRun(() => cvideo.cv_BackgroundSubtractorMOG2_apply(ref, src.ref, dst.ref, ffi.nullptr));
    return dst;
  }

  @override
  cvg.BackgroundSubtractorMOG2 get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorMOG2Ptr>(cvideo.addresses.cv_BackgroundSubtractorMOG2_close);

  void dispose() {
    finalizer.detach(this);
    cvideo.cv_BackgroundSubtractorMOG2_close(ptr);
  }
}

class BackgroundSubtractorKNN extends CvStruct<cvg.BackgroundSubtractorKNN> {
  BackgroundSubtractorKNN(cvg.BackgroundSubtractorKNNPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorKNNPtr>(cvideo.addresses.cv_BackgroundSubtractorKNN_close);

  void dispose() {
    finalizer.detach(this);
    cvideo.cv_BackgroundSubtractorKNN_close(ptr);
  }

  factory BackgroundSubtractorKNN.empty() {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(() => cvideo.cv_BackgroundSubtractorKNN_create(p));
    return BackgroundSubtractorKNN(p);
  }
  factory BackgroundSubtractorKNN.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(
      () => cvideo.cv_BackgroundSubtractorKNN_create_1(
        history,
        varThreshold,
        detectShadows,
        p,
      ),
    );
    return BackgroundSubtractorKNN(p);
  }

  Mat apply(Mat src) {
    final dst = Mat.empty();
    cvRun(() => cvideo.cv_BackgroundSubtractorKNN_apply(ref, src.ref, dst.ref, ffi.nullptr));
    return dst;
  }

  @override
  cvg.BackgroundSubtractorKNN get ref => ptr.ref;
}

/// NewBackgroundSubtractorMOG2 returns a new BackgroundSubtractor algorithm
/// of type MOG2. MOG2 is a Gaussian Mixture-based Background/Foreground
/// Segmentation Algorithm.
///
/// For further details, please see:
/// https://docs.opencv.org/master/de/de1/group__video__motion.html#ga2beb2dee7a073809ccec60f145b6b29c
/// https://docs.opencv.org/master/d7/d7b/classcv_1_1BackgroundSubtractorMOG2.html
BackgroundSubtractorMOG2 createBackgroundSubtractorMOG2({
  int history = 500,
  double varThreshold = 16,
  bool detectShadows = true,
}) {
  final p = calloc<cvg.BackgroundSubtractorMOG2>();
  cvRun(
    () => cvideo.cv_BackgroundSubtractorMOG2_create_1(
      history,
      varThreshold,
      detectShadows,
      p,
    ),
  );
  return BackgroundSubtractorMOG2(p);
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
Mat calcOpticalFlowFarneback(
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
) {
  cvRun(
    () => cvideo.cv_calcOpticalFlowFarneback(
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
      ffi.nullptr,
    ),
  );
  return flow;
}

/// CalcOpticalFlowPyrLK calculates an optical flow for a sparse feature set using
/// the iterative Lucas-Kanade method with pyramids.
///
/// For further details, please see:
/// https://docs.opencv.org/master/dc/d6b/group__video__track.html#ga473e4b886d0bcc6b65831eb88ed93323
(VecPoint2f nextPts, VecUChar? status, VecF32? error) calcOpticalFlowPyrLK(
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
  status ??= VecUChar();
  err ??= VecF32();
  cvRun(
    () => cvideo.cv_calcOpticalFlowPyrLK_1(
      prevImg.ref,
      nextImg.ref,
      prevPts.ref,
      nextPts.ptr,
      status!.ptr,
      err!.ptr,
      winSize.cvd.ref,
      maxLevel,
      criteria.toTermCriteria().ref,
      flags,
      minEigThreshold,
      ffi.nullptr,
    ),
  );
  return (nextPts, status, err);
}

/// FindTransformECC finds the geometric transform (warp) between two images in terms of the ECC criterion.
///
/// For futther details, please see:
/// https://docs.opencv.org/4.x/dc/d6b/group__video__track.html#ga1aa357007eaec11e9ed03500ecbcbe47
(double ret, Mat warpMatrix) findTransformECC(
  InputArray templateImage,
  InputArray inputImage,
  InputOutputArray warpMatrix,
  int motionType,
  (int, int, double) criteria,
  InputArray inputMask,
  int gaussFiltSize,
) {
  final p = calloc<ffi.Double>();
  cvRun(
    () => cvideo.cv_findTransformECC(
      templateImage.ref,
      inputImage.ref,
      warpMatrix.ref,
      motionType,
      criteria.toTermCriteria().ref,
      inputMask.ref,
      gaussFiltSize,
      p,
      ffi.nullptr,
    ),
  );
  final rval = (p.value, warpMatrix);
  calloc.free(p);
  return rval;
}

/// Tracker is the base interface for object tracking.
///
/// see: https://docs.opencv.org/master/d0/d0a/classcv_1_1Tracker.html
class TrackerMIL extends CvStruct<cvg.TrackerMIL> {
  TrackerMIL(cvg.TrackerMILPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory TrackerMIL.create() {
    final p = calloc<cvg.TrackerMIL>();
    cvRun(() => cvideo.cv_TrackerMIL_create(p));
    return TrackerMIL(p);
  }

  void init(InputArray image, Rect boundingBox) {
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

    cvRun(() => cvideo.cv_TrackerMIL_init(ref, image.ref, boundingBox.ref, ffi.nullptr));
  }

  /// Update the tracker, find the new most likely bounding box for the target.
  /// https://docs.opencv.org/4.x/d0/d0a/classcv_1_1Tracker.html#a92d2012f576e6c06eb2e257d110a6529
  (bool, Rect) update(Mat img) {
    final bBox = calloc<cvg.CvRect>();
    final p = calloc<ffi.Bool>();
    cvRun(() => cvideo.cv_TrackerMIL_update(ref, img.ref, bBox, p, ffi.nullptr));
    final rval = (p.value, Rect.fromPointer(bBox));
    calloc.free(p);
    return rval;
  }

  static final finalizer = OcvFinalizer<cvg.TrackerMILPtr>(cvideo.addresses.cv_TrackerMIL_close);

  void dispose() {
    finalizer.detach(this);
    cvideo.cv_TrackerMIL_close(ptr);
  }

  @override
  cvg.TrackerMIL get ref => ptr.ref;
}

/// KalmanFilter implements a standard Kalman filter http://en.wikipedia.org/wiki/Kalman_filter.
/// However, you can modify transitionMatrix, controlMatrix, and measurementMatrix
/// to get an extended Kalman filter functionality.
///
/// For further details, please see:
/// https://docs.opencv.org/4.6.0/dd/d6a/classcv_1_1KalmanFilter.html
class KalmanFilter extends CvStruct<cvg.KalmanFilter> {
  KalmanFilter(cvg.KalmanFilterPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory KalmanFilter.create(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    final p = calloc<cvg.KalmanFilter>();
    cvRun(() => cvideo.cv_KalmanFilter_create(dynamParams, measureParams, controlParams, type, p));
    return KalmanFilter(p);
  }

  Mat correct(Mat measurement) {
    final dst = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_correct(ref, measurement.ref, dst.ptr, ffi.nullptr));
    return dst;
  }

  Mat predict({Mat? control}) {
    final dst = Mat.empty();
    control == null
        ? cvRun(() => cvideo.cv_KalmanFilter_predict(ref, dst.ptr, ffi.nullptr))
        : cvRun(() => cvideo.cv_KalmanFilter_predict_1(ref, control.ref, dst.ptr, ffi.nullptr));
    return dst;
  }

  void init(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    cvRun(
      () => cvideo.cv_KalmanFilter_init_1(ref, dynamParams, measureParams, controlParams, type, ffi.nullptr),
    );
  }

  @override
  cvg.KalmanFilter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.KalmanFilterPtr>(cvideo.addresses.cv_KalmanFilter_close);

  void dispose() {
    finalizer.detach(this);
    cvideo.cv_KalmanFilter_close(ptr);
  }

  // corrected state (x(k)): x(k)=x'(k)+K(k)*(z(k)-H*x'(k))
  Mat get statePost {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_statePost(ref, p.ptr));
    return p;
  }

  set statePost(Mat state) {
    cvRun(() => cvideo.cv_KalmanFilter_set_statePost(ref, state.ref));
  }

  Mat get statePre {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_statePre(ref, p.ptr));
    return p;
  }

  set statePre(Mat state) {
    cvRun(() => cvideo.cv_KalmanFilter_set_statePre(ref, state.ref));
  }

  Mat get transitionMatrix {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_transitionMatrix(ref, p.ptr));
    return p;
  }

  set transitionMatrix(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_transitionMatrix(ref, m.ref));
  }

  Mat get temp1 {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_temp1(ref, p.ptr));
    return p;
  }

  Mat get temp2 {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_temp2(ref, p.ptr));
    return p;
  }

  Mat get temp3 {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_temp3(ref, p.ptr));
    return p;
  }

  Mat get temp4 {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_temp4(ref, p.ptr));
    return p;
  }

  Mat get temp5 {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_temp5(ref, p.ptr));
    return p;
  }

  Mat get processNoiseCov {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_processNoiseCov(ref, p.ptr));
    return p;
  }

  set processNoiseCov(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_processNoiseCov(ref, m.ref));
  }

  Mat get measurementNoiseCov {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_measurementNoiseCov(ref, p.ptr));
    return p;
  }

  set measurementNoiseCov(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_measurementNoiseCov(ref, m.ref));
  }

  Mat get measurementMatrix {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_measurementMatrix(ref, p.ptr));
    return p;
  }

  set measurementMatrix(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_measurementMatrix(ref, m.ref));
  }

  Mat get gain {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_gain(ref, p.ptr));
    return p;
  }

  set gain(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_gain(ref, m.ref));
  }

  Mat get errorCovPre {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_errorCovPre(ref, p.ptr));
    return p;
  }

  set errorCovPre(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_errorCovPre(ref, m.ref));
  }

  Mat get errorCovPost {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_errorCovPost(ref, p.ptr));
    return p;
  }

  set errorCovPost(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_errorCovPost(ref, m.ref));
  }

  Mat get controlMatrix {
    final p = Mat.empty();
    cvRun(() => cvideo.cv_KalmanFilter_get_controlMatrix(ref, p.ptr));
    return p;
  }

  set controlMatrix(Mat m) {
    cvRun(() => cvideo.cv_KalmanFilter_set_controlMatrix(ref, m.ref));
  }
}
