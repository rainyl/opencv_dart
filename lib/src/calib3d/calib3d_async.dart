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
import '../g/calib3d.g.dart' as ccalib3d;
import '../g/constants.g.dart';

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
  int m1type,
) async =>
    cvRunAsync2<(Mat, Mat)>(
      (callback) => ccalib3d.initUndistortRectifyMap_Async(
        cameraMatrix.ref,
        distCoeffs.ref,
        R.ref,
        newCameraMatrix.ref,
        size.cvd.ref,
        m1type,
        callback,
      ),
      matCompleter2,
    );

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
}) async =>
    cvRunAsync2(
      (callback) => ccalib3d.getOptimalNewCameraMatrix_Async(
        cameraMatrix.ref,
        distCoeffs.ref,
        imageSize.cvd.ref,
        alpha,
        newImgSize.cvd.ref,
        centerPrincipalPoint,
        callback,
      ),
      (c, p, p1) => c.complete((Mat.fromPointer(p.cast()), Rect.fromPointer(p1.cast()))),
    );

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
}) async =>
    cvRunAsync3(
      (callback) => ccalib3d.calibrateCamera_Async(
        objectPoints.ref,
        imagePoints.ref,
        imageSize.cvd.ref,
        cameraMatrix.ref,
        distCoeffs.ref,
        flags,
        criteria.cvd.ref,
        callback,
      ),
      (c, p, p1, p2) {
        final rmsErr = p.cast<ffi.Double>().value;
        calloc.free(p);
        final rvecs = Mat.fromPointer(p1.cast());
        final tvecs = Mat.fromPointer(p2.cast());
        return c.complete((rmsErr, cameraMatrix, distCoeffs, rvecs, tvecs));
      },
    );

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
  InputArray? newCameraMatrix,
}) async =>
    cvRunAsync(
      (callback) => ccalib3d.undistort_Async(
        src.ref,
        cameraMatrix.ref,
        distCoeffs.ref,
        newCameraMatrix?.ref ?? Mat.empty().ref,
        callback,
      ),
      matCompleter,
    );

// UndistortPoints transforms points to compensate for lens distortion
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga55c716492470bfe86b0ee9bf3a1f0f7e
Future<Mat> undistortPointsAsync(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  InputArray? R,
  InputArray? P,
  (int type, int count, double eps) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) async =>
    cvRunAsync(
      (callback) => ccalib3d.undistortPoints_Async(
        src.ref,
        cameraMatrix.ref,
        distCoeffs.ref,
        R?.ref ?? Mat.empty().ref,
        P?.ref ?? Mat.empty().ref,
        criteria.cvd.ref,
        callback,
      ),
      matCompleter,
    );

// FindChessboardCorners finds the positions of internal corners of the chessboard.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga93efa9b0aa890de240ca32b11253dd4a
Future<(bool success, Mat corners)> findChessboardCornersAsync(
  InputArray image,
  (int, int) patternSize, {
  int flags = CALIB_CB_ADAPTIVE_THRESH + CALIB_CB_NORMALIZE_IMAGE,
}) async =>
    cvRunAsync2(
      (callback) => ccalib3d.findChessboardCorners_Async(
        image.ref,
        patternSize.cvd.ref,
        flags,
        callback,
      ),
      (c, p, p1) {
        final rval = p.cast<ffi.Bool>().value;
        calloc.free(p);
        final corners = Mat.fromPointer(p1.cast());
        return c.complete((rval, corners));
      },
    );

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
Future<(bool, Mat corners)> findChessboardCornersSBAsync(
  InputArray image,
  (int, int) patternSize,
  int flags,
) async =>
    cvRunAsync2(
      (callback) => ccalib3d.findChessboardCornersSB_Async(
        image.ref,
        patternSize.cvd.ref,
        flags,
        callback,
      ),
      (c, p, p1) {
        final rval = p.cast<ffi.Bool>().value;
        calloc.free(p);
        final corners = Mat.fromPointer(p1.cast());
        return c.complete((rval, corners));
      },
    );

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
Future<(bool, Mat corners, Mat meta)> findChessboardCornersSBWithMetaAsync(
  InputArray image,
  (int, int) patternSize,
  int flags,
) async =>
    cvRunAsync3(
      (callback) =>
          ccalib3d.findChessboardCornersSBWithMeta_Async(image.ref, patternSize.cvd.ref, flags, callback),
      (c, p, p1, p2) {
        final rval = p.cast<ffi.Bool>().value;
        calloc.free(p);
        final corners = Mat.fromPointer(p1.cast());
        final meta = Mat.fromPointer(p2.cast());
        return c.complete((rval, corners, meta));
      },
    );

// DrawChessboardCorners renders the detected chessboard corners.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga6a10b0bb120c4907e5eabbcd22319022
Future<Mat> drawChessboardCornersAsync(
  InputOutputArray image,
  (int, int) patternSize,
  InputArray corners,
  bool patternWasFound,
) async =>
    cvRunAsync0<Mat>(
      (callback) =>
          ccalib3d.drawChessboardCorners_Async(image.ref, patternSize.cvd.ref, patternWasFound, callback),
      (c) => c.complete(image),
    );

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
}) async =>
    cvRunAsync2(
      (callback) => ccalib3d.estimateAffinePartial2DWithParams_Async(
        from.ref,
        to.ref,
        method,
        ransacReprojThreshold,
        maxIters,
        confidence,
        refineIters,
        callback,
      ),
      matCompleter2,
    );

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
}) async =>
    cvRunAsync2(
      (callback) => ccalib3d.estimateAffine2DWithParams_Async(
        from.ref,
        to.ref,
        method,
        ransacReprojThreshold,
        maxIters,
        confidence,
        refineIters,
        callback,
      ),
      matCompleter2,
    );
