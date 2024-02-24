library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/mat_type.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/rect.dart';
import '../core/extensions.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class BackgroundSubtractorMOG2 extends CvObject {
  BackgroundSubtractorMOG2(this._ptr) : super(_ptr) {
    finalizer.attach(this, _ptr);
  }
  factory BackgroundSubtractorMOG2.empty() {
    return BackgroundSubtractorMOG2(_bindings.BackgroundSubtractorMOG2_Create());
  }
  factory BackgroundSubtractorMOG2.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    return BackgroundSubtractorMOG2(_bindings.BackgroundSubtractorMOG2_CreateWithParams(
      history,
      varThreshold,
      detectShadows,
    ));
  }

  Mat apply(Mat src) {
    final dst = Mat.empty();
    _bindings.BackgroundSubtractorMOG2_Apply(_ptr, src.ptr, dst.ptr);
    return dst;
  }

  cvg.BackgroundSubtractorMOG2 _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.BackgroundSubtractorMOG2_Close);

  @override
  ffi.NativeType get ref => throw UnsupportedError("");

  @override
  ffi.NativeType toNative() => throw UnsupportedError("");
}

class BackgroundSubtractorKNN extends CvObject {
  BackgroundSubtractorKNN(this._ptr) : super(_ptr) {
    finalizer.attach(this, _ptr);
  }

  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.BackgroundSubtractorKNN_Close);

  factory BackgroundSubtractorKNN.empty() {
    return BackgroundSubtractorKNN(_bindings.BackgroundSubtractorKNN_Create());
  }
  factory BackgroundSubtractorKNN.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    return BackgroundSubtractorKNN(_bindings.BackgroundSubtractorKNN_CreateWithParams(
      history,
      varThreshold,
      detectShadows,
    ));
  }

  Mat apply(Mat src) {
    final dst = Mat.empty();
    _bindings.BackgroundSubtractorKNN_Apply(_ptr, src.ptr, dst.ptr);
    return dst;
  }

  cvg.BackgroundSubtractorKNN _ptr;
  @override
  cvg.BackgroundSubtractorKNN get ptr => _ptr;

  @override
  ffi.NativeType get ref => throw UnsupportedError("");

  @override
  ffi.NativeType toNative() => throw UnsupportedError("");
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
  return BackgroundSubtractorMOG2(_bindings.BackgroundSubtractorMOG2_CreateWithParams(
    history,
    varThreshold,
    detectShadows,
  ));
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

void calcOpticalFlowFarneback(
  InputArray prev,
  InputArray next,
  InputOutputArray flow,
  double pyr_scale,
  int levels,
  int winsize,
  int iterations,
  int poly_n,
  double poly_sigma,
  int flags,
) {
  _bindings.CalcOpticalFlowFarneback(
    prev.ptr,
    next.ptr,
    flow.ptr,
    pyr_scale,
    levels,
    winsize,
    iterations,
    poly_n,
    poly_sigma,
    flags,
  );
}

/// CalcOpticalFlowPyrLK calculates an optical flow for a sparse feature set using
/// the iterative Lucas-Kanade method with pyramids.
///
/// For further details, please see:
/// https://docs.opencv.org/master/dc/d6b/group__video__track.html#ga473e4b886d0bcc6b65831eb88ed93323
void calcOpticalFlowPyrLK(
  InputArray prevImg,
  InputArray nextImg,
  InputArray prevPts,
  InputOutputArray nextPts,
  OutputArray status,
  OutputArray err, {
  Size winSize = (21, 21),
  int maxLevel = 3,
  cvg.TermCriteria? criteria,
  int flags = 0,
  double minEigThreshold = 1e-4,
}) {
  using((arena) {
    criteria ??= _bindings.TermCriteria_New(TERM_COUNT + TERM_EPS, 30, 0.01);
    _bindings.CalcOpticalFlowPyrLKWithParams(
      prevImg.ptr,
      nextImg.ptr,
      prevPts.ptr,
      nextPts.ptr,
      status.ptr,
      err.ptr,
      winSize.toSize(arena).ref,
      maxLevel,
      criteria!,
      flags,
      minEigThreshold,
    );
  });
}

/// FindTransformECC finds the geometric transform (warp) between two images in terms of the ECC criterion.
///
/// For futther details, please see:
/// https://docs.opencv.org/4.x/dc/d6b/group__video__track.html#ga1aa357007eaec11e9ed03500ecbcbe47
double findTransformECC(
  InputArray templateImage,
  InputArray inputImage,
  InputOutputArray warpMatrix,
  int motionType,
  cvg.TermCriteria criteria,
  InputArray inputMask,
  int gaussFiltSize,
) {
  return _bindings.FindTransformECC(
    templateImage.ptr,
    inputImage.ptr,
    warpMatrix.ptr,
    motionType,
    criteria,
    inputMask.ptr,
    gaussFiltSize,
  );
}

/// Tracker is the base interface for object tracking.
///
/// see: https://docs.opencv.org/master/d0/d0a/classcv_1_1Tracker.html
class TrackerMIL extends CvObject {
  TrackerMIL(this._ptr) : super(_ptr) {
    finalizer.attach(this, _ptr);
  }
  factory TrackerMIL.create() {
    return TrackerMIL(_bindings.TrackerMIL_Create());
  }

  bool init(
    InputArray image,
    Rect boundingBox,
  ) {
    return _bindings.Tracker_Init(_ptr, image.ptr, boundingBox.ref);
  }

  (Rect, bool) update(Mat img) {
    final boundingBox = Rect(0, 0, 0, 0);
    final ret = _bindings.Tracker_Update(_ptr, img.ptr, boundingBox.ptr);
    return (boundingBox, ret);
  }

  cvg.TrackerMIL _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.TrackerMIL_Close);

  @override
  ffi.NativeType get ref => throw UnsupportedError("");

  @override
  ffi.NativeType toNative() => throw UnsupportedError("");
}

/// KalmanFilter implements a standard Kalman filter http://en.wikipedia.org/wiki/Kalman_filter.
/// However, you can modify transitionMatrix, controlMatrix, and measurementMatrix
/// to get an extended Kalman filter functionality.
///
/// For further details, please see:
/// https://docs.opencv.org/4.6.0/dd/d6a/classcv_1_1KalmanFilter.html
class KalmanFilter extends CvObject {
  KalmanFilter(this._ptr) : super(_ptr) {
    finalizer.attach(this, _ptr);
  }

  factory KalmanFilter.create(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    return KalmanFilter(_bindings.KalmanFilter_NewWithParams(dynamParams, measureParams, controlParams, type));
  }

  Mat correct(Mat measurement) {
    return Mat.fromCMat(_bindings.KalmanFilter_Correct(_ptr, measurement.ptr));
  }

  Mat predict({Mat? control}) {
    if (control == null) {
      return Mat.fromCMat(_bindings.KalmanFilter_Predict(_ptr));
    } else {
      return Mat.fromCMat(_bindings.KalmanFilter_PredictWithParams(_ptr, control.ptr));
    }
  }

  init(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    _bindings.KalmanFilter_InitWithParams(_ptr, dynamParams, measureParams, controlParams, type);
  }

  cvg.TrackerMIL _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.KalmanFilter_Close);

  // corrected state (x(k)): x(k)=x'(k)+K(k)*(z(k)-H*x'(k))
  Mat get statePost => Mat.fromCMat(_bindings.KalmanFilter_GetStatePost(_ptr));
  set statePost(Mat state) {
    _bindings.KalmanFilter_SetStatePost(_ptr, state.ptr);
  }

  Mat get statePre => Mat.fromCMat(_bindings.KalmanFilter_GetStatePre(_ptr));
  set statePre(Mat state) {
    _bindings.KalmanFilter_SetStatePre(_ptr, state.ptr);
  }

  Mat get transitionMatrix => Mat.fromCMat(_bindings.KalmanFilter_GetTransitionMatrix(_ptr));
  set transitionMatrix(Mat m) {
    _bindings.KalmanFilter_SetTransitionMatrix(_ptr, m.ptr);
  }

  Mat get temp1 => Mat.fromCMat(_bindings.KalmanFilter_GetTemp1(_ptr));
  Mat get temp2 => Mat.fromCMat(_bindings.KalmanFilter_GetTemp2(_ptr));
  Mat get temp3 => Mat.fromCMat(_bindings.KalmanFilter_GetTemp3(_ptr));
  Mat get temp4 => Mat.fromCMat(_bindings.KalmanFilter_GetTemp4(_ptr));
  Mat get temp5 => Mat.fromCMat(_bindings.KalmanFilter_GetTemp5(_ptr));

  Mat get processNoiseCov => Mat.fromCMat(_bindings.KalmanFilter_GetProcessNoiseCov(_ptr));
  set processNoiseCov(Mat m) {
    _bindings.KalmanFilter_SetProcessNoiseCov(_ptr, m.ptr);
  }

  Mat get measurementNoiseCov => Mat.fromCMat(_bindings.KalmanFilter_GetMeasurementNoiseCov(_ptr));
  set measurementNoiseCov(Mat m) {
    _bindings.KalmanFilter_SetMeasurementNoiseCov(_ptr, m.ptr);
  }

  Mat get measurementMatrix => Mat.fromCMat(_bindings.KalmanFilter_GetMeasurementMatrix(_ptr));
  set measurementMatrix(Mat m) {
    _bindings.KalmanFilter_SetMeasurementMatrix(_ptr, m.ptr);
  }

  Mat get gain => Mat.fromCMat(_bindings.KalmanFilter_GetGain(_ptr));
  set gain(Mat m) {
    _bindings.KalmanFilter_SetGain(_ptr, m.ptr);
  }

  Mat get errorCovPre => Mat.fromCMat(_bindings.KalmanFilter_GetErrorCovPre(_ptr));
  set errorCovPre(Mat m) {
    _bindings.KalmanFilter_SetErrorCovPre(_ptr, m.ptr);
  }

  Mat get errorCovPost => Mat.fromCMat(_bindings.KalmanFilter_GetErrorCovPost(_ptr));
  set errorCovPost(Mat m) {
    _bindings.KalmanFilter_SetErrorCovPost(_ptr, m.ptr);
  }

  Mat get controlMatrix => Mat.fromCMat(_bindings.KalmanFilter_GetControlMatrix(_ptr));
  set controlMatrix(Mat m) {
    _bindings.KalmanFilter_SetControlMatrix(_ptr, m.ptr);
  }

  @override
  ffi.NativeType get ref => throw UnsupportedError("");

  @override
  ffi.NativeType toNative() => throw UnsupportedError("");
}
