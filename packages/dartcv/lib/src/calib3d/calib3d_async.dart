// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.calib3d;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/contours.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/termcriteria.dart';
import '../g/constants.g.dart';
import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccalib3d;

/// InitUndistortRectifyMap computes the joint undistortion and rectification transformation and represents the result in the form of maps for remap
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga7dfb72c9cf9780a347fbe3d1c47e5d5a
Future<(Mat, Mat)> initUndistortRectifyMapAsync(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  InputArray R,
  InputArray newCameraMatrix,
  (int, int) size,
  int m1type, {
  OutputArray? map1,
  OutputArray? map2,
}) async {
  map1 ??= Mat.empty();
  map2 ??= Mat.empty();
  return cvRunAsync0<(Mat, Mat)>(
      (callback) => ccalib3d.cv_initUndistortRectifyMap(
            cameraMatrix.ref,
            distCoeffs.ref,
            R.ref,
            newCameraMatrix.ref,
            size.cvd.ref,
            m1type,
            map1!.ref,
            map2!.ref,
            callback,
          ),
      (c) => c.complete((map1!, map2!)));
}

/// GetOptimalNewCameraMatrixWithParams computes and returns the optimal new camera matrix based on the free scaling parameter.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga7a6c4e032c97f03ba747966e6ad862b1
Future<(Mat rval, Rect validPixROI)> getOptimalNewCameraMatrixAsync(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  (int, int) imageSize,
  double alpha, {
  (int, int) newImgSize = (0, 0),
  bool centerPrincipalPoint = false,
}) async {
  final validPixROI = calloc<cvg.CvRect>();
  final rval = Mat.empty();
  return cvRunAsync0<(Mat, Rect)>(
    (callback) => ccalib3d.cv_getOptimalNewCameraMatrix(
      cameraMatrix.ref,
      distCoeffs.ref,
      imageSize.cvd.ref,
      alpha,
      newImgSize.cvd.ref,
      validPixROI,
      centerPrincipalPoint,
      rval.ptr,
      callback,
    ),
    (c) => c.complete((rval, Rect.fromPointer(validPixROI))),
  );
}

// CalibrateCamera finds the camera intrinsic and extrinsic parameters from several views of a calibration pattern.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga3207604e4b1a1758aa66acb6ed5aa65d
Future<(double rmsErr, Mat cameraMatrix, Mat distCoeffs, Mat rvecs, Mat tvecs)> calibrateCameraAsync(
  Contours3f objectPoints,
  Contours2f imagePoints,
  (int, int) imageSize,
  InputOutputArray cameraMatrix,
  InputOutputArray distCoeffs, {
  Mat? rvecs,
  Mat? tvecs,
  int flags = 0,
  (int type, int count, double eps) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) async {
  rvecs ??= Mat.empty();
  tvecs ??= Mat.empty();
  final cRmsErr = calloc<ffi.Double>();

  return cvRunAsync0(
      (callback) => ccalib3d.cv_calibrateCamera(
            objectPoints.ref,
            imagePoints.ref,
            imageSize.cvd.ref,
            cameraMatrix.ref,
            distCoeffs.ref,
            rvecs!.ref,
            tvecs!.ref,
            flags,
            criteria.cvd.ref,
            cRmsErr,
            callback,
          ), (c) {
    final rmsErr = cRmsErr.value;
    calloc.free(cRmsErr);
    return c.complete((rmsErr, cameraMatrix, distCoeffs, rvecs!, tvecs!));
  });
}

// Transforms an image to compensate for lens distortion.
// The function transforms an image to compensate radial and tangential lens distortion.
// The function is simply a combination of initUndistortRectifyMap (with unity R ) and remap (with bilinear interpolation). See the former function for details of the transformation being performed.
// Those pixels in the destination image, for which there is no correspondent pixels in the source image, are filled with zeros (black color).
// A particular subset of the source image that will be visible in the corrected image can be regulated by newCameraMatrix. You can use getOptimalNewCameraMatrix to compute the appropriate newCameraMatrix depending on your requirements.
// The camera matrix and the distortion parameters can be determined using calibrateCamera. If the resolution of images is different from the resolution used at the calibration stage, fx,fy,cx and cy need to be scaled accordingly, while the distortion coefficients remain the same.
Future<Mat> undistortAsync(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  InputArray? newCameraMatrix,
}) async {
  dst ??= Mat.empty();
  newCameraMatrix ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_undistort(
      src.ref,
      dst!.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      newCameraMatrix!.ref,
      callback,
    ),
    (c) => c.complete(dst!),
  );
}

// UndistortPoints transforms points to compensate for lens distortion
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga55c716492470bfe86b0ee9bf3a1f0f7e
Future<Mat> undistortPointsAsync(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  InputArray? R,
  InputArray? P,
  (int type, int count, double eps) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) async {
  R ??= Mat.empty();
  P ??= Mat.empty();
  dst ??= Mat.empty();
  final tc = criteria.cvd;
  return cvRunAsync0(
    (callback) => ccalib3d.cv_undistortPoints(
      src.ref,
      dst!.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      R!.ref,
      P!.ref,
      tc.ref,
      callback,
    ),
    (c) => c.complete(dst!),
  );
}

// FindChessboardCorners finds the positions of internal corners of the chessboard.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga93efa9b0aa890de240ca32b11253dd4a
Future<(bool success, Mat corners)> findChessboardCornersAsync(
  InputArray image,
  (int, int) patternSize, {
  OutputArray? corners,
  int flags = CALIB_CB_ADAPTIVE_THRESH + CALIB_CB_NORMALIZE_IMAGE,
}) async {
  corners ??= Mat.empty();
  final r = calloc<ffi.Bool>();
  return cvRunAsync0(
      (callback) => ccalib3d.cv_findChessboardCorners(
            image.ref,
            patternSize.cvd.ref,
            corners!.ref,
            flags,
            r,
            callback,
          ), (c) {
    final rval = r.value;
    calloc.free(r);
    return c.complete((rval, corners!));
  });
}

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
Future<(bool, VecPoint2f corners)> findChessboardCornersSBAsync(
  InputArray image,
  (int, int) patternSize,
  int flags, {
  VecPoint2f? corners,
}) async {
  corners ??= VecPoint2f();
  final b = calloc<ffi.Bool>();
  return cvRunAsync0(
      (callback) => ccalib3d.cv_findChessboardCornersSB(
            image.ref,
            patternSize.cvd.ref,
            corners!.ptr,
            flags,
            b,
            callback,
          ), (c) {
    final rval = b.value;
    calloc.free(b);
    return c.complete((rval, corners!));
  });
}

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
Future<(bool, VecPoint2f corners, Mat meta)> findChessboardCornersSBWithMetaAsync(
  InputArray image,
  (int, int) patternSize,
  int flags, {
  VecPoint2f? corners,
  OutputArray? meta,
}) async {
  corners ??= VecPoint2f();
  meta ??= Mat.empty();
  final b = calloc<ffi.Bool>();
  return cvRunAsync0(
      (callback) => ccalib3d.cv_FindChessboardCornersSB_1(
            image.ref,
            patternSize.cvd.ref,
            corners!.ptr,
            flags,
            meta!.ref,
            b,
            callback,
          ), (c) {
    final rval = b.value;
    calloc.free(b);
    return c.complete((rval, corners!, meta!));
  });
}

// DrawChessboardCorners renders the detected chessboard corners.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga6a10b0bb120c4907e5eabbcd22319022
Future<Mat> drawChessboardCornersAsync(
  InputOutputArray image,
  (int, int) patternSize,
  InputArray corners,
  bool patternWasFound,
) async {
  return cvRunAsync0(
    (callback) => ccalib3d.cv_drawChessboardCorners(
      image.ref,
      patternSize.cvd.ref,
      corners.ref,
      patternWasFound,
      callback,
    ),
    (c) => c.complete(image),
  );
}

// EstimateAffinePartial2D computes an optimal limited affine transformation
// with 4 degrees of freedom between two 2D point sets.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#gad767faff73e9cbd8b9d92b955b50062d
Future<(Mat, Mat inliers)> estimateAffinePartial2DAsync(
  VecPoint2f from,
  VecPoint2f to, {
  int method = RANSAC,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.99,
  int refineIters = 10,
  OutputArray? inliers,
}) async {
  inliers ??= Mat.empty();
  final rval = Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_estimateAffine2D_1(
      from.ref,
      to.ref,
      inliers!.ref,
      method,
      ransacReprojThreshold,
      maxIters,
      confidence,
      refineIters,
      rval.ptr,
      callback,
    ),
    (c) => c.complete((rval, inliers!)),
  );
}

// EstimateAffine2D Computes an optimal affine transformation between two 2D point sets.
//
// For further details, please see:
// https://docs.opencv.org/4.0.0/d9/d0c/group__calib3d.html#ga27865b1d26bac9ce91efaee83e94d4dd
Future<(Mat, Mat inliers)> estimateAffine2DAsync(
  VecPoint2f from,
  VecPoint2f to, {
  int method = RANSAC,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.99,
  int refineIters = 10,
  OutputArray? inliers,
}) async {
  inliers ??= Mat.empty();
  final rval = Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_estimateAffine2D_1(
      from.ref,
      to.ref,
      inliers!.ref,
      method,
      ransacReprojThreshold,
      maxIters,
      confidence,
      refineIters,
      rval.ptr,
      callback,
    ),
    (c) => c.complete((rval, inliers!)),
  );
}

/// FindHomography finds an optimal homography matrix using 4 or more point pairs (as opposed to GetPerspectiveTransform, which uses exactly 4)
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d9/d0c/group__calib3d.html#ga4abc2ece9fab9398f2e560d53c8c9780
Future<(Mat, Mat)> findHomographyAsync(
  InputArray srcPoints,
  InputArray dstPoints, {
  int method = 0,
  double ransacReprojThreshold = 3,
  OutputArray? mask,
  int maxIters = 2000,
  double confidence = 0.995,
}) async {
  mask ??= Mat.empty();
  final mat = Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_findHomography(
      srcPoints.ref,
      dstPoints.ref,
      method,
      ransacReprojThreshold,
      mask!.ref,
      maxIters,
      confidence,
      mat.ptr,
      callback,
    ),
    (c) => c.complete((mat, mask!)),
  );
}
