library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/contours.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../core/termcriteria.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

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
      cvRun(
        () => cvg.Fisheye_UndistortImageWithParams(
          distorted.ref,
          undistorted!.ref,
          K.ref,
          D.ref,
          knew!.ref,
          newSize.toSize(arena).ref,
        ),
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
  }) {
    R ??= Mat.empty();
    P ??= Mat.empty();
    undistorted ??= Mat.empty();
    cvRun(() => cvg.Fisheye_UndistortPoints(
        distorted.ref, undistorted!.ref, K.ref, D.ref, R!.ref, P!.ref));
    return undistorted;
  }

  /// EstimateNewCameraMatrixForUndistortRectify estimates new camera matrix for undistortion or rectification.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d58/group__calib3d__fisheye.html#ga384940fdf04c03e362e94b6eb9b673c9
  static Mat estimateNewCameraMatrixForUndistortRectify(
    InputArray K,
    InputArray D,
    Size imageSize,
    InputArray R, {
    OutputArray? P,
    double balance = 0.0,
    Size newSize = (0, 0),
    double fovScale = 1.0,
  }) {
    return using<Mat>((arena) {
      P ??= Mat.empty();
      cvRun(
        () => cvg.Fisheye_EstimateNewCameraMatrixForUndistortRectify(
          K.ref,
          D.ref,
          imageSize.toSize(arena).ref,
          R.ref,
          P!.ref,
          balance,
          newSize.toSize(arena).ref,
          fovScale,
        ),
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
    cvRun(
      () => cvg.InitUndistortRectifyMap(
        cameraMatrix.ref,
        distCoeffs.ref,
        R.ref,
        newCameraMatrix.ref,
        size.toSize(arena).ref,
        m1type,
        map1!.ref,
        map2!.ref,
      ),
    );
    return (map1!, map2!);
  });
}

/// GetOptimalNewCameraMatrixWithParams computes and returns the optimal new camera matrix based on the free scaling parameter.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga7a6c4e032c97f03ba747966e6ad862b1
(Mat rval, Rect validPixROI) getOptimalNewCameraMatrix(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  Size imageSize,
  double alpha, {
  Size newImgSize = (0, 0),
  bool centerPrincipalPoint = false,
}) {
  return using<(Mat, Rect)>((arena) {
    final validPixROI = arena<cvg.Rect>();
    final matPtr = arena<cvg.Mat>();
    cvRun(
      () => cvg.GetOptimalNewCameraMatrixWithParams(
        cameraMatrix.ref,
        distCoeffs.ref,
        imageSize.toSize(arena).ref,
        alpha,
        newImgSize.toSize(arena).ref,
        validPixROI,
        centerPrincipalPoint,
        matPtr,
      ),
    );
    return (Mat.fromCMat(matPtr.ref), Rect.fromNative(validPixROI.ref));
  });
}

// CalibrateCamera finds the camera intrinsic and extrinsic parameters from several views of a calibration pattern.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga3207604e4b1a1758aa66acb6ed5aa65d
(double rmsErr, Mat cameraMatrix, Mat distCoeffs, Mat rvecs, Mat tvecs) calibrateCamera(
  Contours3f objectPoints,
  Contours2f imagePoints,
  Size imageSize,
  InputOutputArray cameraMatrix,
  InputOutputArray distCoeffs, {
  Mat? rvecs,
  Mat? tvecs,
  int flags = 0,
  TermCriteria criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) {
  return using<(double, Mat, Mat, Mat, Mat)>((arena) {
    rvecs ??= Mat.empty();
    tvecs ??= Mat.empty();
    final rmsErr = arena<ffi.Double>();

    cvRun(
      () => cvg.CalibrateCamera(
        objectPoints.ref,
        imagePoints.ref,
        imageSize.toSize(arena).ref,
        cameraMatrix.ref,
        distCoeffs.ref,
        rvecs!.ref,
        tvecs!.ref,
        flags,
        criteria.toTermCriteria(arena).ref,
        rmsErr,
      ),
    );
    return (rmsErr.value, cameraMatrix, distCoeffs, rvecs!, tvecs!);
  });
}

// Transforms an image to compensate for lens distortion.
// The function transforms an image to compensate radial and tangential lens distortion.
// The function is simply a combination of initUndistortRectifyMap (with unity R ) and remap (with bilinear interpolation). See the former function for details of the transformation being performed.
// Those pixels in the destination image, for which there is no correspondent pixels in the source image, are filled with zeros (black color).
// A particular subset of the source image that will be visible in the corrected image can be regulated by newCameraMatrix. You can use getOptimalNewCameraMatrix to compute the appropriate newCameraMatrix depending on your requirements.
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
  cvRun(() =>
      cvg.Undistort(src.ref, dst!.ref, cameraMatrix.ref, distCoeffs.ref, newCameraMatrix!.ref));
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
  TermCriteria criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) {
  R ??= Mat.empty();
  P ??= Mat.empty();
  dst ??= Mat.empty();
  cvRunArena(
    (arena) => cvRun(
      () => cvg.UndistortPoints(
        src.ref,
        dst!.ref,
        cameraMatrix.ref,
        distCoeffs.ref,
        R!.ref,
        P!.ref,
        criteria.toTermCriteria(arena).ref,
      ),
    ),
  );
  return dst;
}

// FindChessboardCorners finds the positions of internal corners of the chessboard.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga93efa9b0aa890de240ca32b11253dd4a
(bool success, Mat corners) findChessboardCorners(
  InputArray image,
  Size patternSize, {
  OutputArray? corners,
  int flags = CALIB_CB_ADAPTIVE_THRESH + CALIB_CB_NORMALIZE_IMAGE,
}) {
  return using<(bool, Mat)>((arena) {
    corners ??= Mat.empty();
    final r = arena<ffi.Bool>();
    cvRun(
      () => cvg.FindChessboardCorners(
        image.ref,
        patternSize.toSize(arena).ref,
        corners!.ref,
        flags,
        r,
      ),
    );
    return (r.value, corners!);
  });
}

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
(bool, Mat corners) findChessboardCornersSB(
  InputArray image,
  Size patternSize,
  int flags, {
  OutputArray? corners,
}) {
  corners ??= Mat.empty();
  final rval = cvRunArena<bool>((arena) {
    final b = arena<ffi.Bool>();
    cvRun(
      () => cvg.FindChessboardCornersSB(
        image.ref,
        patternSize.toSize(arena).ref,
        corners!.ref,
        flags,
        b,
      ),
    );
    return b.value;
  });
  return (rval, corners);
}

// Finds the positions of internal corners of the chessboard using a sector based approach.
// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
(bool, Mat corners, Mat meta) findChessboardCornersSBWithMeta(
  InputArray image,
  Size patternSize,
  int flags, {
  OutputArray? corners,
  OutputArray? meta,
}) {
  corners ??= Mat.empty();
  meta ??= Mat.empty();
  final rval = cvRunArena<bool>((arena) {
    final b = arena<ffi.Bool>();
    cvRun(
      () => cvg.FindChessboardCornersSBWithMeta(
        image.ref,
        patternSize.toSize(arena).ref,
        corners!.ref,
        flags,
        meta!.ref,
        b,
      ),
    );
    return b.value;
  });
  return (rval, corners, meta);
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
  return cvRunArena<Mat>((arena) {
    cvRun(() => cvg.DrawChessboardCorners(
        image.ref, patternSize.toSize(arena).ref, corners.ref, patternWasFound));
    return image;
  });
}

// EstimateAffinePartial2D computes an optimal limited affine transformation
// with 4 degrees of freedom between two 2D point sets.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#gad767faff73e9cbd8b9d92b955b50062d
(Mat, Mat inliers) estimateAffinePartial2D(
  VecPoint2f from,
  VecPoint2f to, {
  int method = RANSAC,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.99,
  int refineIters = 10,
  OutputArray? inliers,
}) {
  return cvRunArena<(Mat, Mat)>((arena) {
    inliers ??= Mat.empty();
    final p = arena<cvg.Mat>();
    cvRun(
      () => cvg.EstimateAffinePartial2DWithParams(
        from.ref,
        to.ref,
        inliers!.ref,
        method,
        ransacReprojThreshold,
        maxIters,
        confidence,
        refineIters,
        p,
      ),
    );
    return (Mat.fromCMat(p.ref), inliers!);
  });
}

// EstimateAffine2D Computes an optimal affine transformation between two 2D point sets.
//
// For further details, please see:
// https://docs.opencv.org/4.0.0/d9/d0c/group__calib3d.html#ga27865b1d26bac9ce91efaee83e94d4dd
(Mat, Mat inliers) estimateAffine2D(
  VecPoint2f from,
  VecPoint2f to, {
  int method = RANSAC,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.99,
  int refineIters = 10,
  OutputArray? inliers,
}) {
  return cvRunArena<(Mat, Mat)>((arena) {
    inliers ??= Mat.empty();
    final p = arena<cvg.Mat>();
    cvRun(
      () => cvg.EstimateAffine2DWithParams(
        from.ref,
        to.ref,
        inliers!.ref,
        method,
        ransacReprojThreshold,
        maxIters,
        confidence,
        refineIters,
        p,
      ),
    );
    return (Mat.fromCMat(p.ref), inliers!);
  });
}
