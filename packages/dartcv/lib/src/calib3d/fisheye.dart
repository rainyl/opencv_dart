// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.calib3d.fisheye;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../core/termcriteria.dart';
import '../g/constants.g.dart';
import '../native_lib.dart' show ccalib3d;
import 'calib3d.dart';

class Fisheye {
  /// Performs camera calibration.
  ///
  /// https://docs.opencv.org/4.11.0/db/d58/group__calib3d__fisheye.html#gad626a78de2b1dae7489e152a5a5a89e1
  static (double rval, VecMat rvecs, VecMat tvecs) calibrate(
    VecMat objectPoints,
    VecMat imagePoints,
    Size imageSize,
    InputOutputArray K,
    InputOutputArray D, {
    VecMat? rvecs,
    VecMat? tvecs,
    int flags = 0,
    TermCriteria? criteria,
  }) {
    criteria ??= TermCriteria(TERM_COUNT + TERM_EPS, 100, 2.0e-16);
    rvecs ??= VecMat();
    tvecs ??= VecMat();
    final prval = calloc<ffi.Double>();
    cvRun(
      () => ccalib3d.cv_fisheye_calibrate(
        objectPoints.ref,
        imagePoints.ref,
        imageSize.ref,
        K.ref,
        D.ref,
        rvecs!.ref,
        tvecs!.ref,
        flags,
        criteria!.ref,
        prval,
        ffi.nullptr,
      ),
    );
    final rval = prval.value;
    calloc.free(prval);
    return (rval, rvecs, tvecs);
  }

  /// async version of [calibrate]
  static Future<(double rval, VecMat rvecs, VecMat tvecs)> calibrateAsync(
    VecMat objectPoints,
    VecMat imagePoints,
    Size imageSize,
    InputOutputArray K,
    InputOutputArray D, {
    VecMat? rvecs,
    VecMat? tvecs,
    int flags = 0,
    TermCriteria? criteria,
  }) async {
    criteria ??= TermCriteria(TERM_COUNT + TERM_EPS, 100, 2.0e-16);
    rvecs ??= VecMat();
    tvecs ??= VecMat();
    final prval = calloc<ffi.Double>();
    return cvRunAsync0(
        (callback) => ccalib3d.cv_fisheye_calibrate(
              objectPoints.ref,
              imagePoints.ref,
              imageSize.ref,
              K.ref,
              D.ref,
              rvecs!.ref,
              tvecs!.ref,
              flags,
              criteria!.ref,
              prval,
              callback,
            ), (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvecs!, tvecs!));
    });
  }

  /// Distorts 2D points using fisheye model.
  ///
  /// https://docs.opencv.org/4.11.0/db/d58/group__calib3d__fisheye.html#ga75d8877a98e38d0b29b6892c5f8d7765
  static Mat distortPoints(
    InputArray undistorted,
    InputArray K,
    InputArray D, {
    InputOutputArray? Kundistorted,
    OutputArray? distorted,
    double alpha = 0,
  }) {
    distorted ??= Mat.empty();

    cvRun(
      () => Kundistorted == null
          ? ccalib3d.cv_fisheye_distortPoints(
              undistorted.ref,
              distorted!.ref,
              K.ref,
              D.ref,
              alpha,
              ffi.nullptr,
            )
          : ccalib3d.cv_fisheye_distortPoints_1(
              undistorted.ref,
              distorted!.ref,
              Kundistorted.ref,
              K.ref,
              D.ref,
              alpha,
              ffi.nullptr,
            ),
    );
    return distorted;
  }

  /// async version of [distortPoints]
  static Future<Mat> distortPointsAsync(
    InputArray undistorted,
    InputArray K,
    InputArray D, {
    InputOutputArray? Kundistorted,
    OutputArray? distorted,
    double alpha = 0,
  }) async {
    distorted ??= Mat.empty();

    return cvRunAsync0(
      (callback) => Kundistorted == null
          ? ccalib3d.cv_fisheye_distortPoints(
              undistorted.ref,
              distorted!.ref,
              K.ref,
              D.ref,
              alpha,
              callback,
            )
          : ccalib3d.cv_fisheye_distortPoints_1(
              undistorted.ref,
              distorted!.ref,
              Kundistorted.ref,
              K.ref,
              D.ref,
              alpha,
              callback,
            ),
      (c) => c.complete(distorted),
    );
  }

  /// EstimateNewCameraMatrixForUndistortRectify estimates new camera matrix for undistortion or rectification.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d58/group__calib3d__fisheye.html#ga384940fdf04c03e362e94b6eb9b673c9
  static Mat estimateNewCameraMatrixForUndistortRectify(
    InputArray K,
    InputArray D,
    (int, int) imageSize,
    InputArray R, {
    OutputArray? P,
    double balance = 0.0,
    (int, int) newSize = (0, 0),
    double fovScale = 1.0,
  }) {
    P ??= Mat.empty();
    cvRun(
      () => ccalib3d.cv_fisheye_estimateNewCameraMatrixForUndistortRectify(
        K.ref,
        D.ref,
        imageSize.cvd.ref,
        R.ref,
        P!.ref,
        balance,
        newSize.cvd.ref,
        fovScale,
        ffi.nullptr,
      ),
    );
    return P;
  }

  /// async version of [estimateNewCameraMatrixForUndistortRectify]
  static Future<Mat> estimateNewCameraMatrixForUndistortRectifyAsync(
    InputArray K,
    InputArray D,
    (int, int) imageSize,
    InputArray R, {
    OutputArray? P,
    double balance = 0.0,
    (int, int) newSize = (0, 0),
    double fovScale = 1.0,
  }) async {
    P ??= Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccalib3d.cv_fisheye_estimateNewCameraMatrixForUndistortRectify(
        K.ref,
        D.ref,
        imageSize.cvd.ref,
        R.ref,
        P!.ref,
        balance,
        newSize.cvd.ref,
        fovScale,
        callback,
      ),
      (c) => c.complete(P),
    );
  }

  /// Computes undistortion and rectification maps for image transform by remap. If D is empty zero distortion is used, if R or P is empty identity matrixes are used.
  ///
  /// https://docs.opencv.org/4.11.0/db/d58/group__calib3d__fisheye.html#ga0d37b45f780b32f63ed19c21aa9fd333
  static (Mat map1, Mat map2) initUndistortRectifyMap(
    InputArray K,
    InputArray D,
    InputArray R,
    InputArray P,
    Size size,
    int m1type, {
    OutputArray? map1,
    OutputArray? map2,
  }) {
    map1 ??= Mat.empty();
    map2 ??= Mat.empty();
    cvRun(
      () => ccalib3d.cv_fisheye_initUndistortRectifyMap(
        K.ref,
        D.ref,
        R.ref,
        P.ref,
        size.ref,
        m1type,
        map1!.ref,
        map2!.ref,
        ffi.nullptr,
      ),
    );
    return (map1, map2);
  }

  /// async version of [initUndistortRectifyMap]
  static Future<(Mat map1, Mat map2)> initUndistortRectifyMapAsync(
    InputArray K,
    InputArray D,
    InputArray R,
    InputArray P,
    Size size,
    int m1type, {
    OutputArray? map1,
    OutputArray? map2,
  }) async {
    map1 ??= Mat.empty();
    map2 ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccalib3d.cv_fisheye_initUndistortRectifyMap(
        K.ref,
        D.ref,
        R.ref,
        P.ref,
        size.ref,
        m1type,
        map1!.ref,
        map2!.ref,
        callback,
      ),
      (c) => c.complete((map1!, map2!)),
    );
  }

  /// Projects points using fisheye model.
  ///
  /// https://docs.opencv.org/4.11.0/db/d58/group__calib3d__fisheye.html#gab1ad1dc30c42ee1a50ce570019baf2c4
  static (Mat imagePoints, Mat jacobian) projectPoints(
    InputArray objectPoints,
    InputArray rvec,
    InputArray tvec,
    InputArray K,
    InputArray D, {
    OutputArray? imagePoints,
    double alpha = 0,
    OutputArray? jacobian,
  }) {
    imagePoints ??= Mat.empty();
    jacobian ??= Mat.empty();
    cvRun(
      () => ccalib3d.cv_fisheye_projectPoints(
        objectPoints.ref,
        imagePoints!.ref,
        rvec.ref,
        tvec.ref,
        K.ref,
        D.ref,
        alpha,
        jacobian!.ref,
        ffi.nullptr,
      ),
    );
    return (imagePoints, jacobian);
  }

  /// async version of [projectPoints]
  static Future<(Mat imagePoints, Mat jacobian)> projectPointsAsync(
    InputArray objectPoints,
    InputArray rvec,
    InputArray tvec,
    InputArray K,
    InputArray D, {
    OutputArray? imagePoints,
    double alpha = 0,
    OutputArray? jacobian,
  }) async {
    imagePoints ??= Mat.empty();
    jacobian ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccalib3d.cv_fisheye_projectPoints(
        objectPoints.ref,
        imagePoints!.ref,
        rvec.ref,
        tvec.ref,
        K.ref,
        D.ref,
        alpha,
        jacobian!.ref,
        callback,
      ),
      (c) => c.complete((imagePoints!, jacobian!)),
    );
  }

  /// Finds an object pose from 3D-2D point correspondences for fisheye camera moodel.
  ///
  /// https://docs.opencv.org/4.11.0/db/d58/group__calib3d__fisheye.html#gab1ad1dc30c42ee1a50ce570019baf2c4
  static (bool rval, Mat rvec, Mat tvec) solvePnP(
    InputArray objectPoints,
    InputArray imagePoints,
    InputArray cameraMatrix,
    InputArray distCoeffs, {
    OutputArray? rvec,
    OutputArray? tvec,
    bool useExtrinsicGuess = false,
    int flags = SOLVEPNP_ITERATIVE,
    TermCriteria? criteria,
  }) {
    criteria ??= TermCriteria(TERM_MAX_ITER + TERM_EPS, 10, 1e-8);
    rvec ??= Mat.empty();
    tvec ??= Mat.empty();
    final prval = calloc<ffi.Bool>();
    cvRun(
      () => ccalib3d.cv_fisheye_solvePnP(
        objectPoints.ref,
        imagePoints.ref,
        cameraMatrix.ref,
        distCoeffs.ref,
        rvec!.ref,
        tvec!.ref,
        useExtrinsicGuess,
        flags,
        criteria!.ref,
        prval,
        ffi.nullptr,
      ),
    );
    final rval = prval.value;
    calloc.free(prval);
    return (rval, rvec, tvec);
  }

  /// async version of [solvePnP]
  static Future<(bool rval, Mat rvec, Mat tvec)> solvePnPAsync(
    InputArray objectPoints,
    InputArray imagePoints,
    InputArray cameraMatrix,
    InputArray distCoeffs, {
    OutputArray? rvec,
    OutputArray? tvec,
    bool useExtrinsicGuess = false,
    int flags = SOLVEPNP_ITERATIVE,
    TermCriteria? criteria,
  }) async {
    criteria ??= TermCriteria(TERM_MAX_ITER + TERM_EPS, 10, 1e-8);
    rvec ??= Mat.empty();
    tvec ??= Mat.empty();
    final prval = calloc<ffi.Bool>();
    return cvRunAsync0(
        (callback) => ccalib3d.cv_fisheye_solvePnP(
              objectPoints.ref,
              imagePoints.ref,
              cameraMatrix.ref,
              distCoeffs.ref,
              rvec!.ref,
              tvec!.ref,
              useExtrinsicGuess,
              flags,
              criteria!.ref,
              prval,
              callback,
            ), (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvec!, tvec!));
    });
  }

  /// void distortPoints (InputArray undistorted, InputArray Kundistorted, InputArray K, InputArray D, OutputArray distorted, double alpha=0)
  ///
  /// FisheyeUndistortImage transforms an image to compensate for fisheye lens distortion
  /// https://docs.opencv.org/3.4/db/d58/group__calib3d__fisheye.html#ga167df4b00a6fd55287ba829fbf9913b9
  static Mat undistortImage(
    InputArray distorted,
    InputArray K,
    InputArray D, {
    OutputArray? undistorted,
    InputArray? knew,
    (int, int) newSize = (0, 0),
  }) {
    knew ??= Mat.empty();
    undistorted ??= Mat.empty();
    cvRun(
      () => ccalib3d.cv_fisheye_undistortImage_1(
        distorted.ref,
        undistorted!.ref,
        K.ref,
        D.ref,
        knew!.ref,
        newSize.cvd.ref,
        ffi.nullptr,
      ),
    );
    return undistorted;
  }

  /// async version of [undistortImage]
  static Future<Mat> undistortImageAsync(
    InputArray distorted,
    InputArray K,
    InputArray D, {
    OutputArray? undistorted,
    InputArray? knew,
    (int, int) newSize = (0, 0),
  }) async {
    knew ??= Mat.empty();
    undistorted ??= Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccalib3d.cv_fisheye_undistortImage_1(
        distorted.ref,
        undistorted!.ref,
        K.ref,
        D.ref,
        knew!.ref,
        newSize.cvd.ref,
        callback,
      ),
      (c) => c.complete(undistorted),
    );
  }

  /// FisheyeUndistortPoints transforms points to compensate for fisheye lens distortion
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d58/group__calib3d__fisheye.html#gab738cdf90ceee97b2b52b0d0e7511541
  static Mat undistortPoints(
    InputArray distorted,
    InputArray K,
    InputArray D, {
    OutputArray? undistorted,
    InputArray? R,
    InputArray? P,
  }) {
    R ??= Mat.empty();
    P ??= Mat.empty();
    undistorted ??= Mat.empty();
    cvRun(
      () => ccalib3d.cv_fisheye_undistortPoints(
        distorted.ref,
        undistorted!.ref,
        K.ref,
        D.ref,
        R!.ref,
        P!.ref,
        ffi.nullptr,
      ),
    );
    return undistorted;
  }

  /// async version of [undistortPoints]
  static Future<Mat> undistortPointsAsync(
    InputArray distorted,
    InputArray K,
    InputArray D, {
    OutputArray? undistorted,
    InputArray? R,
    InputArray? P,
  }) async {
    R ??= Mat.empty();
    P ??= Mat.empty();
    undistorted ??= Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccalib3d.cv_fisheye_undistortPoints(
        distorted.ref,
        undistorted!.ref,
        K.ref,
        D.ref,
        R!.ref,
        P!.ref,
        callback,
      ),
      (c) => c.complete(undistorted),
    );
  }
}
