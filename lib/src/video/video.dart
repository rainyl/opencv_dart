library cv;

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
import '../g/video_io.g.dart' as cvg;
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
    cvRun(() => cvideo.BackgroundSubtractorMOG2_Create(p));
    return BackgroundSubtractorMOG2(p);
  }
  factory BackgroundSubtractorMOG2.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(
      () => cvideo.BackgroundSubtractorMOG2_CreateWithParams(
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
    cvRun(() => cvideo.BackgroundSubtractorMOG2_Apply(ref, src.ref, dst.ref));
    return dst;
  }

  @override
  cvg.BackgroundSubtractorMOG2 get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorMOG2Ptr>(cvideo.addresses.BackgroundSubtractorMOG2_Close);

  void dispose() {
    finalizer.detach(this);
    cvideo.BackgroundSubtractorMOG2_Close(ptr);
  }
}

class BackgroundSubtractorKNN extends CvStruct<cvg.BackgroundSubtractorKNN> {
  BackgroundSubtractorKNN(cvg.BackgroundSubtractorKNNPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorKNNPtr>(cvideo.addresses.BackgroundSubtractorKNN_Close);

  void dispose() {
    finalizer.detach(this);
    cvideo.BackgroundSubtractorKNN_Close(ptr);
  }

  factory BackgroundSubtractorKNN.empty() {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(() => cvideo.BackgroundSubtractorKNN_Create(p));
    return BackgroundSubtractorKNN(p);
  }
  factory BackgroundSubtractorKNN.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(
      () => cvideo.BackgroundSubtractorKNN_CreateWithParams(
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
    cvRun(() => cvideo.BackgroundSubtractorKNN_Apply(ref, src.ref, dst.ref));
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
    () => cvideo.BackgroundSubtractorMOG2_CreateWithParams(
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
    () => cvideo.CalcOpticalFlowFarneback(
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
  final s = status?.ptr ?? calloc<cvg.VecUChar>();
  final e = err?.ptr ?? calloc<cvg.VecF32>();
  cvRun(
    () => cvideo.CalcOpticalFlowPyrLKWithParams(
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
    ),
  );
  nextPts.reattach();
  return (nextPts, status ?? VecUChar.fromPointer(s), VecF32.fromPointer(e));
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
  final ret = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(
      () => cvideo.FindTransformECC(
        templateImage.ref,
        inputImage.ref,
        warpMatrix.ref,
        motionType,
        criteria.toTermCriteria().ref,
        inputMask.ref,
        gaussFiltSize,
        p,
      ),
    );
    return p.value;
  });
  return (ret, warpMatrix);
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
    cvRun(() => cvideo.TrackerMIL_Create(p));
    return TrackerMIL(p);
  }

  void init(InputArray image, Rect boundingBox) {
    assert(boundingBox.x >= 0, "boundingBox.x must be >= 0");
    assert(boundingBox.y >= 0, "boundingBox.y must be >= 0");
    assert(
      boundingBox.right <= image.cols,
      "boundingBox.right=${boundingBox.right} must be <= image.cols=${image.cols}",
    );
    assert(
      boundingBox.bottom <= image.rows,
      "boundingBox.bottom=${boundingBox.bottom} must be <= image.rows=${image.rows}",
    );

    cvRun(() => cvideo.TrackerMIL_Init(ref, image.ref, boundingBox.ref));
  }

  /// Update the tracker, find the new most likely bounding box for the target.
  /// https://docs.opencv.org/4.x/d0/d0a/classcv_1_1Tracker.html#a92d2012f576e6c06eb2e257d110a6529
  (bool, Rect) update(Mat img) {
    return cvRunArena<(bool, Rect)>((arena) {
      final bBox = calloc<cvg.Rect>();
      final p = arena<ffi.Bool>();
      cvRun(() => cvideo.TrackerMIL_Update(ref, img.ref, bBox, p));
      return (p.value, Rect.fromPointer(bBox));
    });
  }

  static final finalizer = OcvFinalizer<cvg.TrackerMILPtr>(cvideo.addresses.TrackerMIL_Close);

  void dispose() {
    finalizer.detach(this);
    cvideo.TrackerMIL_Close(ptr);
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
    cvRun(() => cvideo.KalmanFilter_New(dynamParams, measureParams, controlParams, type, p));
    return KalmanFilter(p);
  }

  Mat correct(Mat measurement) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_Correct(ref, measurement.ref, p));
    return Mat.fromPointer(p);
  }

  Mat predict({Mat? control}) {
    final p = calloc<cvg.Mat>();
    control == null
        ? cvRun(() => cvideo.KalmanFilter_Predict(ref, p))
        : cvRun(() => cvideo.KalmanFilter_PredictWithParams(ref, control.ref, p));
    return Mat.fromPointer(p);
  }

  void init(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    cvRun(() => cvideo.KalmanFilter_InitWithParams(ref, dynamParams, measureParams, controlParams, type));
  }

  @override
  cvg.KalmanFilter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.KalmanFilterPtr>(cvideo.addresses.KalmanFilter_Close);

  void dispose() {
    finalizer.detach(this);
    cvideo.KalmanFilter_Close(ptr);
  }

  // corrected state (x(k)): x(k)=x'(k)+K(k)*(z(k)-H*x'(k))
  Mat get statePost {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetStatePost(ref, p));
    return Mat.fromPointer(p);
  }

  set statePost(Mat state) {
    cvRun(() => cvideo.KalmanFilter_SetStatePost(ref, state.ref));
  }

  Mat get statePre {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetStatePre(ref, p));
    return Mat.fromPointer(p);
  }

  set statePre(Mat state) {
    cvRun(() => cvideo.KalmanFilter_SetStatePre(ref, state.ref));
  }

  Mat get transitionMatrix {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetTransitionMatrix(ref, p));
    return Mat.fromPointer(p);
  }

  set transitionMatrix(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetTransitionMatrix(ref, m.ref));
  }

  Mat get temp1 {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetTemp1(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp2 {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetTemp2(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp3 {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetTemp3(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp4 {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetTemp4(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp5 {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetTemp5(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get processNoiseCov {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetProcessNoiseCov(ref, p));
    return Mat.fromPointer(p);
  }

  set processNoiseCov(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetProcessNoiseCov(ref, m.ref));
  }

  Mat get measurementNoiseCov {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetMeasurementNoiseCov(ref, p));
    return Mat.fromPointer(p);
  }

  set measurementNoiseCov(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetMeasurementNoiseCov(ref, m.ref));
  }

  Mat get measurementMatrix {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetMeasurementMatrix(ref, p));
    return Mat.fromPointer(p);
  }

  set measurementMatrix(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetMeasurementMatrix(ref, m.ref));
  }

  Mat get gain {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetGain(ref, p));
    return Mat.fromPointer(p);
  }

  set gain(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetGain(ref, m.ref));
  }

  Mat get errorCovPre {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetErrorCovPre(ref, p));
    return Mat.fromPointer(p);
  }

  set errorCovPre(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetErrorCovPre(ref, m.ref));
  }

  Mat get errorCovPost {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetErrorCovPost(ref, p));
    return Mat.fromPointer(p);
  }

  set errorCovPost(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetErrorCovPost(ref, m.ref));
  }

  Mat get controlMatrix {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvideo.KalmanFilter_GetControlMatrix(ref, p));
    return Mat.fromPointer(p);
  }

  set controlMatrix(Mat m) {
    cvRun(() => cvideo.KalmanFilter_SetControlMatrix(ref, m.ref));
  }
}
