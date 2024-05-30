library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../constants.g.dart';
import '../core/mat_type.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/point.dart';
import '../core/termcriteria.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class BackgroundSubtractorMOG2 extends CvStruct<cvg.BackgroundSubtractorMOG2> {
  BackgroundSubtractorMOG2(cvg.BackgroundSubtractorMOG2Ptr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }
  factory BackgroundSubtractorMOG2.empty() {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(() => CFFI.BackgroundSubtractorMOG2_Create(p));
    return BackgroundSubtractorMOG2(p);
  }
  factory BackgroundSubtractorMOG2.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(
      () => CFFI.BackgroundSubtractorMOG2_CreateWithParams(
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
    cvRun(() => CFFI.BackgroundSubtractorMOG2_Apply(ref, src.ref, dst.ref));
    return dst;
  }

  @override
  cvg.BackgroundSubtractorMOG2 get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorMOG2Ptr>(CFFI.addresses.BackgroundSubtractorMOG2_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.BackgroundSubtractorMOG2_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

class BackgroundSubtractorKNN extends CvStruct<cvg.BackgroundSubtractorKNN> {
  BackgroundSubtractorKNN(cvg.BackgroundSubtractorKNNPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorKNNPtr>(CFFI.addresses.BackgroundSubtractorKNN_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.BackgroundSubtractorKNN_Close(ptr);
  }

  factory BackgroundSubtractorKNN.empty() {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(() => CFFI.BackgroundSubtractorKNN_Create(p));
    return BackgroundSubtractorKNN(p);
  }
  factory BackgroundSubtractorKNN.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(
      () => CFFI.BackgroundSubtractorKNN_CreateWithParams(
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
    cvRun(() => CFFI.BackgroundSubtractorKNN_Apply(ref, src.ref, dst.ref));
    return dst;
  }

  @override
  cvg.BackgroundSubtractorKNN get ref => ptr.ref;

  @override
  List<int> get props => [ptr.address];
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
    () => CFFI.BackgroundSubtractorMOG2_CreateWithParams(
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
    () => CFFI.CalcOpticalFlowFarneback(
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
(VecPoint2f nextPts, VecUChar? status, VecFloat? error) calcOpticalFlowPyrLK(
  InputArray prevImg,
  InputArray nextImg,
  VecPoint2f prevPts,
  VecPoint2f nextPts, {
  VecUChar? status,
  VecFloat? err,
  Size winSize = (21, 21),
  int maxLevel = 3,
  TermCriteria criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
  int flags = 0,
  double minEigThreshold = 1e-4,
}) {
  status ??= VecUChar();
  err ??= VecFloat();
  cvRunArena((arena) {
    cvRun(
      () => CFFI.CalcOpticalFlowPyrLKWithParams(
        prevImg.ref,
        nextImg.ref,
        prevPts.ref,
        nextPts.ref,
        status!.ref,
        err!.ref,
        winSize.toSize(arena).ref,
        maxLevel,
        criteria.toNativePtr(arena).ref,
        flags,
        minEigThreshold,
      ),
    );
  });
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
  TermCriteria criteria,
  InputArray inputMask,
  int gaussFiltSize,
) {
  final ret = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(
      () => CFFI.FindTransformECC(
        templateImage.ref,
        inputImage.ref,
        warpMatrix.ref,
        motionType,
        criteria.toNativePtr(arena).ref,
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
  TrackerMIL(cvg.TrackerMILPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }
  factory TrackerMIL.create() {
    final p = calloc<cvg.TrackerMIL>();
    cvRun(() => CFFI.TrackerMIL_Create(p));
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

    cvRun(() => CFFI.TrackerMIL_Init(ref, image.ref, boundingBox.ref));
  }

  /// Update the tracker, find the new most likely bounding box for the target.
  /// https://docs.opencv.org/4.x/d0/d0a/classcv_1_1Tracker.html#a92d2012f576e6c06eb2e257d110a6529
  (bool, Rect) update(Mat img) {
    return cvRunArena<(bool, Rect)>((arena) {
      final bBox = calloc<cvg.Rect>();
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.TrackerMIL_Update(ref, img.ref, bBox, p));
      return (p.value, Rect.fromPointer(bBox));
    });
  }

  static final finalizer = OcvFinalizer<cvg.TrackerMILPtr>(CFFI.addresses.TrackerMIL_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.TrackerMIL_Close(ptr);
  }

  @override
  cvg.TrackerMIL get ref => ptr.ref;

  @override
  List<int> get props => [ptr.address];
}

/// KalmanFilter implements a standard Kalman filter http://en.wikipedia.org/wiki/Kalman_filter.
/// However, you can modify transitionMatrix, controlMatrix, and measurementMatrix
/// to get an extended Kalman filter functionality.
///
/// For further details, please see:
/// https://docs.opencv.org/4.6.0/dd/d6a/classcv_1_1KalmanFilter.html
class KalmanFilter extends CvStruct<cvg.KalmanFilter> {
  KalmanFilter(cvg.KalmanFilterPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory KalmanFilter.create(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    final p = calloc<cvg.KalmanFilter>();
    cvRun(() => CFFI.KalmanFilter_New(dynamParams, measureParams, controlParams, type, p));
    return KalmanFilter(p);
  }

  Mat correct(Mat measurement) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_Correct(ref, measurement.ref, p));
    return Mat.fromPointer(p);
  }

  Mat predict({Mat? control}) {
    final p = calloc<cvg.Mat>();
    if (control == null) {
      cvRun(() => CFFI.KalmanFilter_Predict(ref, p));
    } else {
      CFFI.KalmanFilter_PredictWithParams(ref, control.ref, p);
    }
    return Mat.fromPointer(p);
  }

  void init(int dynamParams, int measureParams,
      {int controlParams = 0, int type = MatType.CV_32F}) {
    cvRun(() =>
        CFFI.KalmanFilter_InitWithParams(ref, dynamParams, measureParams, controlParams, type));
  }

  @override
  cvg.KalmanFilter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.KalmanFilterPtr>(CFFI.addresses.KalmanFilter_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.KalmanFilter_Close(ptr);
  }

  // corrected state (x(k)): x(k)=x'(k)+K(k)*(z(k)-H*x'(k))
  Mat get statePost {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetStatePost(ref, p));
    return Mat.fromPointer(p);
  }

  set statePost(Mat state) {
    cvRun(() => CFFI.KalmanFilter_SetStatePost(ref, state.ref));
  }

  Mat get statePre {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetStatePre(ref, p));
    return Mat.fromPointer(p);
  }

  set statePre(Mat state) {
    cvRun(() => CFFI.KalmanFilter_SetStatePre(ref, state.ref));
  }

  Mat get transitionMatrix {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetTransitionMatrix(ref, p));
    return Mat.fromPointer(p);
  }

  set transitionMatrix(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetTransitionMatrix(ref, m.ref));
  }

  Mat get temp1 {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetTemp1(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp2 {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetTemp2(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp3 {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetTemp3(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp4 {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetTemp4(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get temp5 {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetTemp5(ref, p));
    return Mat.fromPointer(p);
  }

  Mat get processNoiseCov {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetProcessNoiseCov(ref, p));
    return Mat.fromPointer(p);
  }

  set processNoiseCov(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetProcessNoiseCov(ref, m.ref));
  }

  Mat get measurementNoiseCov {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetMeasurementNoiseCov(ref, p));
    return Mat.fromPointer(p);
  }

  set measurementNoiseCov(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetMeasurementNoiseCov(ref, m.ref));
  }

  Mat get measurementMatrix {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetMeasurementMatrix(ref, p));
    return Mat.fromPointer(p);
  }

  set measurementMatrix(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetMeasurementMatrix(ref, m.ref));
  }

  Mat get gain {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetGain(ref, p));
    return Mat.fromPointer(p);
  }

  set gain(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetGain(ref, m.ref));
  }

  Mat get errorCovPre {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetErrorCovPre(ref, p));
    return Mat.fromPointer(p);
  }

  set errorCovPre(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetErrorCovPre(ref, m.ref));
  }

  Mat get errorCovPost {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetErrorCovPost(ref, p));
    return Mat.fromPointer(p);
  }

  set errorCovPost(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetErrorCovPost(ref, m.ref));
  }

  Mat get controlMatrix {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.KalmanFilter_GetControlMatrix(ref, p));
    return Mat.fromPointer(p);
  }

  set controlMatrix(Mat m) {
    cvRun(() => CFFI.KalmanFilter_SetControlMatrix(ref, m.ref));
  }

  @override
  List<int> get props => [ptr.address];
}
