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
import 'video.dart';

extension BackgroundSubtractorMOG2Async on BackgroundSubtractorMOG2 {
  static Future<BackgroundSubtractorMOG2> emptyAsync() async => cvRunAsync(
        cvideo.BackgroundSubtractorMOG2_Create_Async,
        (c, p) => c.complete(BackgroundSubtractorMOG2(p.cast<cvg.BackgroundSubtractorMOG2>())),
      );

  static Future<BackgroundSubtractorMOG2> createAsync({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) async =>
      cvRunAsync(
        (callback) => cvideo.BackgroundSubtractorMOG2_CreateWithParams_Async(
          history,
          varThreshold,
          detectShadows,
          callback,
        ),
        (c, p) => c.complete(BackgroundSubtractorMOG2(p.cast<cvg.BackgroundSubtractorMOG2>())),
      );

  Future<Mat> applyAsync(Mat src) async => cvRunAsync(
        (callback) => cvideo.BackgroundSubtractorMOG2_Apply_Async(ref, src.ref, callback),
        matCompleter,
      );
}

extension BackgroundSubtractorKNNAsync on BackgroundSubtractorKNN {
  static Future<BackgroundSubtractorKNN> emptyAsync() async => cvRunAsync(
        cvideo.BackgroundSubtractorMOG2_Create_Async,
        (c, p) => c.complete(BackgroundSubtractorKNN(p.cast<cvg.BackgroundSubtractorKNN>())),
      );

  static Future<BackgroundSubtractorKNN> createAsync({
    int history = 500,
    double varThreshold = 16,
    bool detectShadows = true,
  }) async =>
      cvRunAsync(
        (callback) => cvideo.BackgroundSubtractorKNN_CreateWithParams_Async(
          history,
          varThreshold,
          detectShadows,
          callback,
        ),
        (c, p) => c.complete(BackgroundSubtractorKNN(p.cast<cvg.BackgroundSubtractorKNN>())),
      );

  Future<Mat> applyAsync(Mat src) async => cvRunAsync(
        (callback) => cvideo.BackgroundSubtractorKNN_Apply_Async(ref, src.ref, callback),
        matCompleter,
      );
}

/// NewBackgroundSubtractorMOG2 returns a new BackgroundSubtractor algorithm
/// of type MOG2. MOG2 is a Gaussian Mixture-based Background/Foreground
/// Segmentation Algorithm.
///
/// For further details, please see:
/// https://docs.opencv.org/master/de/de1/group__video__motion.html#ga2beb2dee7a073809ccec60f145b6b29c
/// https://docs.opencv.org/master/d7/d7b/classcv_1_1BackgroundSubtractorMOG2.html
Future<BackgroundSubtractorMOG2> createBackgroundSubtractorMOG2Async({
  int history = 500,
  double varThreshold = 16,
  bool detectShadows = true,
}) async =>
    cvRunAsync(
      (callback) => cvideo.BackgroundSubtractorMOG2_CreateWithParams_Async(
        history,
        varThreshold,
        detectShadows,
        callback,
      ),
      (c, p) => c.complete(BackgroundSubtractorMOG2(p.cast<cvg.BackgroundSubtractorMOG2>())),
    );

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
) async =>
    cvRunAsync0(
      (callback) => cvideo.CalcOpticalFlowFarneback_Async(
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
      (c) => c.complete(flow),
    );

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
  (int, int) winSize = (21, 21),
  int maxLevel = 3,
  (int, int, double) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
  int flags = 0,
  double minEigThreshold = 1e-4,
}) async =>
    cvRunAsync3(
        (callback) => cvideo.CalcOpticalFlowPyrLK_Async(
              prevImg.ref,
              nextImg.ref,
              prevPts.ref,
              nextPts.ref,
              winSize.cvd.ref,
              maxLevel,
              criteria.cvd.ref,
              flags,
              minEigThreshold,
              callback,
            ), (c, p, p1, p2) {
      nextPts.reattach(p2.cast<cvg.VecPoint2f>());
      c.complete(
        (
          nextPts,
          VecUChar.fromPointer(p.cast<cvg.VecUChar>()),
          VecF32.fromPointer(p1.cast<cvg.VecF32>()),
        ),
      );
    });

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
) async =>
    cvRunAsync(
        (callback) => cvideo.FindTransformECC_Async(
              templateImage.ref,
              inputImage.ref,
              warpMatrix.ref,
              motionType,
              criteria.cvd.ref,
              inputMask.ref,
              gaussFiltSize,
              callback,
            ), (completer, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      completer.complete((rval, warpMatrix));
    });

/// Tracker is the base interface for object tracking.
///
/// see: https://docs.opencv.org/master/d0/d0a/classcv_1_1Tracker.html
extension TrackerMILAsync on TrackerMIL {
  static Future<TrackerMIL> createAsync() async => cvRunAsync(
        cvideo.TrackerMIL_Create_Async,
        (completer, p) => completer.complete(TrackerMIL(p.cast<cvg.TrackerMIL>())),
      );

  Future<void> initAsync(InputArray image, Rect boundingBox) async {
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
  Future<(bool, Rect)> updateAsync(Mat img) async => cvRunAsync2(
        (callback) => cvideo.TrackerMIL_Update_Async(ref, img.ref, callback),
        (completer, p, p1) {
          final rval = p.cast<ffi.Bool>().value;
          calloc.free(p);
          completer.complete((rval, Rect.fromPointer(p1.cast<cvg.Rect>())));
        },
      );
}

/// KalmanFilter implements a standard Kalman filter http://en.wikipedia.org/wiki/Kalman_filter.
/// However, you can modify transitionMatrix, controlMatrix, and measurementMatrix
/// to get an extended Kalman filter functionality.
///
/// For further details, please see:
/// https://docs.opencv.org/4.6.0/dd/d6a/classcv_1_1KalmanFilter.html
extension KalmanFilterAsync on KalmanFilter {
  static Future<KalmanFilter> createAsync(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) async =>
      cvRunAsync(
        (callback) =>
            cvideo.KalmanFilter_New_Async(dynamParams, measureParams, controlParams, type, callback),
        (completer, p) => completer.complete(KalmanFilter(p.cast<cvg.KalmanFilter>())),
      );

  Future<Mat> correctAsync(Mat measurement) async => cvRunAsync(
      (callback) => cvideo.KalmanFilter_Correct_Async(ref, measurement.ref, callback), matCompleter);

  Future<Mat> predictAsync({Mat? control}) async => cvRunAsync(
        (callback) => control == null
            ? cvideo.KalmanFilter_Predict_Async(ref, callback)
            : cvideo.KalmanFilter_PredictWithParams_Async(ref, control.ref, callback),
        matCompleter,
      );

  Future<void> initAsync(
    int dynamParams,
    int measureParams, {
    int controlParams = 0,
    int type = MatType.CV_32F,
  }) async =>
      cvRunAsync0(
        (callback) => cvideo.KalmanFilter_InitWithParams_Async(
          ref,
          dynamParams,
          measureParams,
          controlParams,
          type,
          callback,
        ),
        (c) => c.complete(),
      );

  // corrected state (x(k)): x(k)=x'(k)+K(k)*(z(k)-H*x'(k))
  Future<Mat> getStatePost() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetStatePost_Async(ref, callback), matCompleter);

  Future<void> setStatePost(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetStatePost_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getStatePre() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetStatePre_Async(ref, callback), matCompleter);

  Future<void> setStatePre(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetStatePre_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getTransitionMatrix() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetTransitionMatrix_Async(ref, callback), matCompleter);

  Future<void> setTransitionMatrix(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetTransitionMatrix_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getTemp1() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetTemp1_Async(ref, callback), matCompleter);

  Future<Mat> getTemp2() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetTemp2_Async(ref, callback), matCompleter);

  Future<Mat> getTemp3() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetTemp3_Async(ref, callback), matCompleter);

  Future<Mat> getTemp4() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetTemp4_Async(ref, callback), matCompleter);

  Future<Mat> getTemp5() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetTemp5_Async(ref, callback), matCompleter);

  Future<Mat> getProcessNoiseCov() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetProcessNoiseCov_Async(ref, callback), matCompleter);

  Future<void> setProcessNoiseCov(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetProcessNoiseCov_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getMeasurementNoiseCov() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetMeasurementNoiseCov_Async(ref, callback), matCompleter);

  Future<void> setMeasurementNoiseCov(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetMeasurementNoiseCov_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getMeasurementMatrix() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetMeasurementMatrix_Async(ref, callback), matCompleter);

  Future<void> setMeasurementMatrix(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetMeasurementMatrix_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getGain() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetGain_Async(ref, callback), matCompleter);

  Future<void> setGain(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetGain_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getErrorCovPre() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetErrorCovPre_Async(ref, callback), matCompleter);

  Future<void> setErrorCovPre(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetErrorCovPre_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getErrorCovPost() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetErrorCovPost_Async(ref, callback), matCompleter);

  Future<void> setErrorCovPost(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetErrorCovPost_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> getControlMatrix() async =>
      cvRunAsync((callback) => cvideo.KalmanFilter_GetControlMatrix_Async(ref, callback), matCompleter);

  Future<void> setControlMatrix(Mat m) async => cvRunAsync0(
        (callback) => cvideo.KalmanFilter_SetControlMatrix_Async(ref, m.ref, callback),
        (c) => c.complete(),
      );
}
