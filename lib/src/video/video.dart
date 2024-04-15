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
    finalizer.attach(this, ptr.cast());
  }
  factory BackgroundSubtractorMOG2.empty() {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(() => cvg.BackgroundSubtractorMOG2_Create(p));
    return BackgroundSubtractorMOG2(p);
  }
  factory BackgroundSubtractorMOG2.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorMOG2>();
    cvRun(
      () => cvg.BackgroundSubtractorMOG2_CreateWithParams(
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
    cvRun(() => cvg.BackgroundSubtractorMOG2_Apply(ref, src.ref, dst.ref));
    return dst;
  }

  @override
  cvg.BackgroundSubtractorMOG2 get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorMOG2Ptr>(ffi.Native.addressOf(cvg.BackgroundSubtractorMOG2_Close));

  @override
  List<int> get props => [ptr.address];
}

class BackgroundSubtractorKNN extends CvStruct<cvg.BackgroundSubtractorKNN> {
  BackgroundSubtractorKNN(cvg.BackgroundSubtractorKNNPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  static final finalizer =
      OcvFinalizer<cvg.BackgroundSubtractorKNNPtr>(ffi.Native.addressOf(cvg.BackgroundSubtractorKNN_Close));

  factory BackgroundSubtractorKNN.empty() {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(() => cvg.BackgroundSubtractorKNN_Create(p));
    return BackgroundSubtractorKNN(p);
  }
  factory BackgroundSubtractorKNN.create({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) {
    final p = calloc<cvg.BackgroundSubtractorKNN>();
    cvRun(
      () => cvg.BackgroundSubtractorKNN_CreateWithParams(
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
    cvRun(() => cvg.BackgroundSubtractorKNN_Apply(ref, src.ref, dst.ref));
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
    () => cvg.BackgroundSubtractorMOG2_CreateWithParams(
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
    () => cvg.CalcOpticalFlowFarneback(
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
      () => cvg.CalcOpticalFlowPyrLKWithParams(
        prevImg.ref,
        nextImg.ref,
        prevPts.ref,
        nextPts.ref,
        status!.ref,
        err!.ref,
        winSize.toSize(arena).ref,
        maxLevel,
        criteria.toTermCriteria(arena).ref,
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
      () => cvg.FindTransformECC(
        templateImage.ref,
        inputImage.ref,
        warpMatrix.ref,
        motionType,
        criteria.toTermCriteria(arena).ref,
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
    finalizer.attach(this, ptr.cast());
  }
  factory TrackerMIL.create() {
    final p = calloc<cvg.TrackerMIL>();
    cvRun(() => cvg.TrackerMIL_Create(p));
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

    cvRun(() => cvg.TrackerMIL_Init(ref, image.ref, boundingBox.ref));
  }

  /// Update the tracker, find the new most likely bounding box for the target.
  /// https://docs.opencv.org/4.x/d0/d0a/classcv_1_1Tracker.html#a92d2012f576e6c06eb2e257d110a6529
  (bool, Rect) update(Mat img) {
    return cvRunArena<(bool, Rect)>((arena) {
      final bBox = arena<cvg.Rect>();
      final p = arena<ffi.Bool>();
      cvRun(() => cvg.TrackerMIL_Update(ref, img.ref, bBox, p));
      return (p.value, Rect.fromNative(bBox.ref));
    });
  }

  static final finalizer = OcvFinalizer<cvg.TrackerMILPtr>(ffi.Native.addressOf(cvg.TrackerMIL_Close));
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
    finalizer.attach(this, ptr.cast());
  }

  factory KalmanFilter.create(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) {
    final p = calloc<cvg.KalmanFilter>();
    cvRun(() => cvg.KalmanFilter_New(dynamParams, measureParams, controlParams, type, p));
    return KalmanFilter(p);
  }

  Mat correct(Mat measurement) {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_Correct(ref, measurement.ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  Mat predict({Mat? control}) {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      if (control == null) {
        cvRun(() => cvg.KalmanFilter_Predict(ref, p));
      } else {
        cvg.KalmanFilter_PredictWithParams(ref, control.ref, p);
      }
      return Mat.fromCMat(p.ref);
    });
  }

  void init(int dynamParams, int measureParams,
      {int controlParams = 0, int type = MatType.CV_32F}) {
    cvRun(() =>
        cvg.KalmanFilter_InitWithParams(ref, dynamParams, measureParams, controlParams, type));
  }

  @override
  cvg.KalmanFilter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.KalmanFilterPtr>(ffi.Native.addressOf(cvg.KalmanFilter_Close));

  // corrected state (x(k)): x(k)=x'(k)+K(k)*(z(k)-H*x'(k))
  Mat get statePost {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetStatePost(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set statePost(Mat state) {
    cvRun(() => cvg.KalmanFilter_SetStatePost(ref, state.ref));
  }

  Mat get statePre {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetStatePre(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set statePre(Mat state) {
    cvRun(() => cvg.KalmanFilter_SetStatePre(ref, state.ref));
  }

  Mat get transitionMatrix {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetTransitionMatrix(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set transitionMatrix(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetTransitionMatrix(ref, m.ref));
  }

  Mat get temp1 {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetTemp1(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  Mat get temp2 {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetTemp2(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  Mat get temp3 {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetTemp3(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  Mat get temp4 {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetTemp4(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  Mat get temp5 {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetTemp5(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  Mat get processNoiseCov {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetProcessNoiseCov(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set processNoiseCov(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetProcessNoiseCov(ref, m.ref));
  }

  Mat get measurementNoiseCov {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetMeasurementNoiseCov(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set measurementNoiseCov(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetMeasurementNoiseCov(ref, m.ref));
  }

  Mat get measurementMatrix {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetMeasurementMatrix(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set measurementMatrix(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetMeasurementMatrix(ref, m.ref));
  }

  Mat get gain {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetGain(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set gain(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetGain(ref, m.ref));
  }

  Mat get errorCovPre {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetErrorCovPre(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set errorCovPre(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetErrorCovPre(ref, m.ref));
  }

  Mat get errorCovPost {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetErrorCovPost(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set errorCovPost(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetErrorCovPost(ref, m.ref));
  }

  Mat get controlMatrix {
    return cvRunArena<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => cvg.KalmanFilter_GetControlMatrix(ref, p));
      return Mat.fromCMat(p.ref);
    });
  }

  set controlMatrix(Mat m) {
    cvRun(() => cvg.KalmanFilter_SetControlMatrix(ref, m.ref));
  }

  @override
  List<int> get props => [ptr.address];
}
