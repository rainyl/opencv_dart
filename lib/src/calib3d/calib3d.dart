library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/contours.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../constants.g.dart';
import '../core/extensions.dart';
import '../core/base.dart';
import '../core/core.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class Fisheye {
  /// FisheyeUndistortImage transforms an image to compensate for fisheye lens distortion
  /// https://docs.opencv.org/3.4/db/d58/group__calib3d__fisheye.html#ga167df4b00a6fd55287ba829fbf9913b9
  static Mat undistortImage(
    InputArray distorted,
    InputArray K,
    InputArray D, {
    OutputArray? undistorted,
    InputArray? knew,
    Size newSize = (0, 0),
  }) {
    return using<Mat>((arena) {
      knew ??= Mat.empty();
      undistorted ??= Mat.empty();
      _bindings.Fisheye_UndistortImageWithParams(
        distorted.ptr,
        undistorted!.ptr,
        K.ptr,
        D.ptr,
        knew!.ptr,
        newSize.toSize(arena).ref,
      );
      return undistorted!;
    });
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
    cvg.TermCriteria? criteria,
  }) {
    R ??= Mat.empty();
    P ??= Mat.empty();
    undistorted ??= Mat.empty();
    criteria = termCriteriaNew(TERM_MAX_ITER + TERM_EPS, 10, 1e-8);
    _bindings.Fisheye_UndistortPoints(distorted.ptr, undistorted.ptr, K.ptr, D.ptr, R.ptr, P.ptr);
    return undistorted;
  }

  /// EstimateNewCameraMatrixForUndistortRectify estimates new camera matrix for undistortion or rectification.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d58/group__calib3d__fisheye.html#ga384940fdf04c03e362e94b6eb9b673c9
  static Mat estimateNewCameraMatrixForUndistortRectify(
    InputArray K,
    InputArray D,
    Size image_size,
    InputArray R, {
    OutputArray? P,
    double balance = 0.0,
    Size new_size = (0, 0),
    double fov_scale = 1.0,
  }) {
    return using<Mat>((arena) {
      P ??= Mat.empty();
      _bindings.Fisheye_EstimateNewCameraMatrixForUndistortRectify(
        K.ptr,
        D.ptr,
        image_size.toSize(arena).ref,
        R.ptr,
        P!.ptr,
        balance,
        new_size.toSize(arena).ref,
        fov_scale,
      );
      return P!;
    });
  }
}

/// InitUndistortRectifyMap computes the joint undistortion and rectification transformation and represents the result in the form of maps for remap
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga7dfb72c9cf9780a347fbe3d1c47e5d5a
(Mat map1, Mat map2) initUndistortRectifyMap(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  InputArray R,
  InputArray newCameraMatrix,
  Size size,
  int m1type, {
  OutputArray? map1,
  OutputArray? map2,
}) {
  return using<(Mat, Mat)>((arena) {
    map1 ??= Mat.empty();
    map2 ??= Mat.empty();
    _bindings.InitUndistortRectifyMap(
      cameraMatrix.ptr,
      distCoeffs.ptr,
      R.ptr,
      newCameraMatrix.ptr,
      size.toSize(arena).ref,
      m1type,
      map1!.ptr,
      map2!.ptr,
    );
    return (map1!, map2!);
  });
}

/// GetOptimalNewCameraMatrixWithParams computes and returns the optimal new camera matrix based on the free scaling parameter.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga7a6c4e032c97f03ba747966e6ad862b1
(Mat, Rect validPixROI) getOptimalNewCameraMatrix(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  Size imageSize,
  double alpha, {
  Size newImgSize = (0, 0),
  bool centerPrincipalPoint = false,
}) {
  return using<(Mat, Rect)>((arena) {
    final validPixROI = arena<cvg.Rect>();
    final _p = _bindings.GetOptimalNewCameraMatrixWithParams(
      cameraMatrix.ptr,
      distCoeffs.ptr,
      imageSize.toSize(arena).ref,
      alpha,
      newImgSize.toSize(arena).ref,
      validPixROI,
      centerPrincipalPoint,
    );
    return (Mat.fromCMat(_p), Rect.fromNative(validPixROI.ref));
  });
}

// CalibrateCamera finds the camera intrinsic and extrinsic parameters from several views of a calibration pattern.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga3207604e4b1a1758aa66acb6ed5aa65d
(double, Mat, Mat, Mat, Mat) calibrateCamera(
  Contours3f objectPoints,
  Contours2f imagePoints,
  Size imageSize,
  InputOutputArray cameraMatrix,
  InputOutputArray distCoeffs, {
  Mat? rvecs,
  Mat? tvecs,
  int flags = 0,
  cvg.TermCriteria? criteria,
}) {
  return using<(double, Mat, Mat, Mat, Mat)>((arena) {
    rvecs ??= Mat.empty();
    tvecs ??= Mat.empty();
    criteria ??= termCriteriaNew(TERM_COUNT + TERM_EPS, 30, 1e-4);
    final rmsErr = _bindings.CalibrateCamera(
      objectPoints.ptr,
      imagePoints.ptr,
      imageSize.toSize(arena).ref,
      cameraMatrix.ptr,
      distCoeffs.ptr,
      rvecs!.ptr,
      tvecs!.ptr,
      flags,
      criteria!,
    );
    return (rmsErr, cameraMatrix, distCoeffs, rvecs!, tvecs!);
  });
}

// Transforms an image to compensate for lens distortion.
//
// The function transforms an image to compensate radial and tangential lens distortion.
//
// The function is simply a combination of initUndistortRectifyMap (with unity R ) and remap (with bilinear interpolation). See the former function for details of the transformation being performed.
//
// Those pixels in the destination image, for which there is no correspondent pixels in the source image, are filled with zeros (black color).
//
// A particular subset of the source image that will be visible in the corrected image can be regulated by newCameraMatrix. You can use getOptimalNewCameraMatrix to compute the appropriate newCameraMatrix depending on your requirements.
//
// The camera matrix and the distortion parameters can be determined using calibrateCamera. If the resolution of images is different from the resolution used at the calibration stage, fx,fy,cx and cy need to be scaled accordingly, while the distortion coefficients remain the same.
Mat undistort(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  InputArray? newCameraMatrix,
}) {
  dst ??= Mat.empty();
  newCameraMatrix ??= Mat.empty();
  _bindings.Undistort(src.ptr, dst.ptr, cameraMatrix.ptr, distCoeffs.ptr, newCameraMatrix.ptr);
  return dst;
}

// UndistortPoints transforms points to compensate for lens distortion
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga55c716492470bfe86b0ee9bf3a1f0f7e
Mat undistortPoints(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  InputArray? R,
  InputArray? P,
}) {
  R ??= Mat.empty();
  P ??= Mat.empty();
  dst ??= Mat.empty();
  _bindings.UndistortPoints(src.ptr, dst.ptr, cameraMatrix.ptr, distCoeffs.ptr, R.ptr, P.ptr);
  return dst;
}

// FindChessboardCorners finds the positions of internal corners of the chessboard.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga93efa9b0aa890de240ca32b11253dd4a
(bool, Mat corners) findChessboardCorners(
  InputArray image,
  Size patternSize, {
  OutputArray? corners,
  int flags = CALIB_CB_ADAPTIVE_THRESH + CALIB_CB_NORMALIZE_IMAGE,
}) {
  return using<(bool, Mat)>((arena) {
    corners ??= Mat.empty();
    final r = _bindings.FindChessboardCorners(
      image.ptr,
      patternSize.toSize(arena).ref,
      corners!.ptr,
      flags,
    );
    return (r, corners!);
  });
}

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
(bool, Mat corners, Mat meta) findChessboardCornersSB(
  InputArray image,
  Size patternSize,
  int flags, {
  OutputArray? corners,
  OutputArray? meta,
}) {
  return using<(bool, Mat, Mat)>((arena) {
    corners ??= Mat.empty();
    meta ??= Mat.empty();
    final b = _bindings.FindChessboardCornersSBWithMeta(
      image.ptr,
      patternSize.toSize(arena).ref,
      corners!.ptr,
      flags,
      meta!.ptr,
    );
    return (b, corners!, meta!);
  });
}

// DrawChessboardCorners renders the detected chessboard corners.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga6a10b0bb120c4907e5eabbcd22319022
Mat drawChessboardCorners(
  InputOutputArray image,
  Size patternSize,
  InputArray corners,
  bool patternWasFound,
) {
  return using<Mat>((arena) {
    _bindings.DrawChessboardCorners(image.ptr, patternSize.toSize(arena).ref, corners.ptr, patternWasFound);
    return image;
  });
}

// EstimateAffinePartial2D computes an optimal limited affine transformation
// with 4 degrees of freedom between two 2D point sets.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#gad767faff73e9cbd8b9d92b955b50062d
(Mat, Mat inliers) estimateAffinePartial2D(
  List<Point2f> from,
  List<Point2f> to, {
  int method = RANSAC,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.99,
  int refineIters = 10,
  OutputArray? inliers,
}) {
  inliers ??= Mat.empty();
  final _from = from.toNativeVecotr();
  final _to = to.toNativeVecotr();
  final p = _bindings.EstimateAffinePartial2DWithParams(
    _from,
    _to,
    inliers.ptr,
    method,
    ransacReprojThreshold,
    maxIters,
    confidence,
    refineIters,
  );
  _bindings.Point2fVector_Close(_from);
  _bindings.Point2fVector_Close(_to);
  return (Mat.fromCMat(p), inliers);
}

// EstimateAffine2D Computes an optimal affine transformation between two 2D point sets.
//
// For further details, please see:
// https://docs.opencv.org/4.0.0/d9/d0c/group__calib3d.html#ga27865b1d26bac9ce91efaee83e94d4dd
(Mat, Mat inliers) estimateAffine2D(
  List<Point2f> from,
  List<Point2f> to, {
  int method = RANSAC,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.99,
  int refineIters = 10,
  OutputArray? inliers,
}) {
  inliers ??= Mat.empty();
  final _from = from.toNativeVecotr();
  final _to = to.toNativeVecotr();
  final p = _bindings.EstimateAffine2DWithParams(
    _from,
    _to,
    inliers.ptr,
    method,
    ransacReprojThreshold,
    maxIters,
    confidence,
    refineIters,
  );
  _bindings.Point2fVector_Close(_from);
  _bindings.Point2fVector_Close(_to);
  return (Mat.fromCMat(p), inliers);
}
