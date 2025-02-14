// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.calib3d;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/contours.dart';
import '../core/cv_vec.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/termcriteria.dart';
import '../g/constants.g.dart';
import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccalib3d;
import 'calib3d.dart';
import 'usac_params.dart';

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
    ),
    (c) {
      final rmsErr = cRmsErr.value;
      calloc.free(cRmsErr);
      return c.complete((rmsErr, cameraMatrix, distCoeffs, rvecs!, tvecs!));
    },
  );
}

/// For points in an image of a stereo pair, computes the corresponding epilines in the other image.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga19e3401c94c44b47c229be6e51d158b7
Future<Mat> computeCorrespondEpilinesAsync(
  InputArray points,
  int whichImage,
  InputArray F, {
  OutputArray? lines,
}) async {
  lines ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_computeCorrespondEpilines(points.ref, whichImage, F.ref, lines!.ref, callback),
    (c) => c.complete(lines!),
  );
}

/// Converts points from homogeneous to Euclidean space.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gac42edda3a3a0f717979589fcd6ac0035
Future<Mat> convertPointsFromHomogeneousAsync(InputArray src, {OutputArray? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_convertPointsFromHomogeneous(src.ref, dst!.ref, callback),
    (c) => c.complete(dst),
  );
}

/// Converts points from Euclidean to homogeneous space.
///
/// `void cv::convertPointsToHomogeneous (InputArray src, OutputArray dst);`
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga13159f129eec8a7d9bd8501f012d5543
Future<Mat> convertPointsToHomogeneousAsync(InputArray src, {OutputArray? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_convertPointsToHomogeneous(src.ref, dst!.ref, callback),
    (c) => c.complete(dst),
  );
}

/// Refines coordinates of corresponding points.
///
/// void cv::correctMatches (InputArray F, InputArray points1, InputArray points2, OutputArray newPoints1, OutputArray newPoints2);
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gaf32c99d17908e175ac71e7a08fad587b
Future<(Mat newPoints1, Mat newPoints2)> correctMatchesAsync(
  Mat F,
  InputArray points1,
  InputArray points2, {
  OutputArray? newPoints1,
  OutputArray? newPoints2,
}) async {
  newPoints1 ??= Mat.empty();
  newPoints2 ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_correctMatches(
      F.ref,
      points1.ref,
      points2.ref,
      newPoints1!.ref,
      newPoints2!.ref,
      callback,
    ),
    (c) => c.complete((newPoints1!, newPoints2!)),
  );
}

/// Decompose an essential matrix to possible rotations and translation.
///
/// void cv::decomposeEssentialMat (InputArray E, OutputArray R1, OutputArray R2, OutputArray t);
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga54a2f5b3f8aeaf6c76d4a31dece85d5d
Future<(Mat r1, Mat r2, Mat t)> decomposeEssentialMatAsync(
  Mat E, {
  OutputArray? R1,
  OutputArray? R2,
  OutputArray? t,
}) async {
  R1 ??= Mat.empty();
  R2 ??= Mat.empty();
  t ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_decomposeEssentialMat(E.ref, R1!.ref, R2!.ref, t!.ref, callback),
    (c) => c.complete((R1!, R2!, t!)),
  );
}

/// Decompose a homography matrix to rotation(s), translation(s) and plane normal(s).
///
/// int cv::decomposeHomographyMat (InputArray H, InputArray K, OutputArrayOfArrays rotations, OutputArrayOfArrays translations, OutputArrayOfArrays normals)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga7f60bdff78833d1e3fd6d9d0fd538d92
Future<(int rval, VecMat rotations, VecMat translations, VecMat normals)> decomposeHomographyMatAsync(
  Mat H,
  Mat K, {
  VecMat? rotations,
  VecMat? translations,
  VecMat? normals,
}) async {
  rotations ??= VecMat();
  translations ??= VecMat();
  normals ??= VecMat();
  final prval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_decomposeHomographyMat(
      H.ref,
      K.ref,
      rotations!.ref,
      translations!.ref,
      normals!.ref,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rotations!, translations!, normals!));
    },
  );
}

/// Decomposes a projection matrix into a rotation matrix and a camera intrinsic matrix.
///
/// void cv::decomposeProjectionMatrix (InputArray projMatrix, OutputArray cameraMatrix, OutputArray rotMatrix, OutputArray transVect, OutputArray rotMatrixX=noArray(), OutputArray rotMatrixY=noArray(), OutputArray rotMatrixZ=noArray(), OutputArray eulerAngles=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gaaae5a7899faa1ffdf268cd9088940248
Future<(Mat cameraMatrix, Mat rotMatrix, Mat transVect)> decomposeProjectionMatrixAsync(
  Mat projMatrix, {
  OutputArray? cameraMatrix,
  OutputArray? rotMatrix,
  OutputArray? transVect,
  OutputArray? rotMatrixX,
  OutputArray? rotMatrixY,
  OutputArray? rotMatrixZ,
  OutputArray? eulerAngles,
}) async {
  cameraMatrix ??= Mat.empty();
  rotMatrix ??= Mat.empty();
  transVect ??= Mat.empty();
  rotMatrixX ??= Mat.empty();
  rotMatrixY ??= Mat.empty();
  rotMatrixZ ??= Mat.empty();
  eulerAngles ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_decomposeProjectionMatrix(
      projMatrix.ref,
      cameraMatrix!.ref,
      rotMatrix!.ref,
      transVect!.ref,
      rotMatrixX!.ref,
      rotMatrixY!.ref,
      rotMatrixZ!.ref,
      eulerAngles!.ref,
      callback,
    ),
    (c) {
      return c.complete((cameraMatrix!, rotMatrix!, transVect!));
    },
  );
}

// DrawChessboardCorners renders the detected chessboard corners.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga6a10b0bb120c4907e5eabbcd22319022
Future<Mat> drawChessboardCornersAsync(
  InputOutputArray image,
  (int, int) patternSize,
  VecPoint2f corners,
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

/// Draw axes of the world/object coordinate system from pose estimation.
///
/// For further details, please see:
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab3ab7bb2bdfe7d5d9745bb92d13f9564
Future<void> drawFrameAxesAsync(
  Mat image,
  Mat cameraMatrix,
  Mat distCoeffs,
  Mat rvec,
  Mat tvec,
  double length, {
  int thickness = 3,
}) async {
  return cvRunAsync0(
    (callback) => ccalib3d.cv_drawFrameAxes(
      image.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec.ref,
      tvec.ref,
      length,
      thickness,
      callback,
    ),
    (c) => c.complete(),
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

/// Computes an optimal affine transformation between two 3D point sets.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gac12d1f05b3bb951288e7250713ce98f0
Future<(int rval, Mat, Mat inliers)> estimateAffine3DAsync(
  Mat src,
  Mat dst, {
  Mat? out,
  Mat? inliers,
  double ransacThreshold = 3,
  double confidence = 0.99,
}) async {
  out ??= Mat.empty();
  inliers ??= Mat.empty();
  final p = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_estimateAffine3D_1(
      src.ref,
      dst.ref,
      out!.ref,
      inliers!.ref,
      ransacThreshold,
      confidence,
      p,
      callback,
    ),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, out!, inliers!));
    },
  );
}

/// Estimates the sharpness of a detected chessboard.
///
/// Scalar cv::estimateChessboardSharpness (InputArray image, Size patternSize, InputArray corners, float rise_distance=0.8F, bool vertical=false, OutputArray sharpness=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga1b976b476cd2083edd4323a34e9e1ffa
Future<Scalar> estimateChessboardSharpnessAsync(
  InputArray image,
  (int, int) patternSize,
  InputArray corners, {
  double riseDistance = 0.8,
  bool vertical = false,
  OutputArray? sharpness,
}) async {
  sharpness ??= Mat.empty();
  final prval = calloc<cvg.Scalar>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_estimateChessboardSharpness(
      image.ref,
      patternSize.cvd.ref,
      corners.ref,
      riseDistance,
      vertical,
      sharpness!.ref,
      prval,
      callback,
    ),
    (c) => c.complete(Scalar.fromPointer(prval)),
  );
}

/// Computes an optimal translation between two 3D point sets.
///
/// int cv::estimateTranslation3D (InputArray src, InputArray dst, OutputArray out, OutputArray inliers, double ransacThreshold=3, double confidence=0.99)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga0ea15af08887dd5afa68d81711d395ff
Future<(int rval, Mat out, Mat inliers)> estimateTranslation3DAsync(
  InputArray src,
  InputArray dst, {
  OutputArray? out,
  OutputArray? inliers,
  double ransacThreshold = 3,
  double confidence = 0.99,
}) async {
  out ??= Mat.empty();
  inliers ??= Mat.empty();
  final prval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_estimateTranslation3D(
      src.ref,
      dst.ref,
      out!.ref,
      inliers!.ref,
      ransacThreshold,
      confidence,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, out!, inliers!));
    },
  );
}

/// Filters homography decompositions based on additional information.
///
/// void cv::filterHomographyDecompByVisibleRefpoints (InputArrayOfArrays rotations, InputArrayOfArrays normals, InputArray beforePoints, InputArray afterPoints, OutputArray possibleSolutions, InputArray pointsMask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga32f867159200f7bd55e72dca92d8494c
Future<Mat> filterHomographyDecompByVisibleRefpointsAsync(
  VecMat rotations,
  VecMat normals,
  InputArray beforePoints,
  InputArray afterPoints, {
  OutputArray? possibleSolutions,
  InputArray? pointsMask,
}) async {
  possibleSolutions ??= Mat.empty();
  pointsMask ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_filterHomographyDecompByVisibleRefpoints(
      rotations.ref,
      normals.ref,
      beforePoints.ref,
      afterPoints.ref,
      possibleSolutions!.ref,
      pointsMask!.ref,
      callback,
    ),
    (c) => c.complete(possibleSolutions!),
  );
}

/// Filters off small noise blobs (speckles) in the disparity map.
///
/// void cv::filterSpeckles (InputOutputArray img, double newVal, int maxSpeckleSize, double maxDiff, InputOutputArray buf=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gabe331f205a6dd7a9aa5db8a38157d25b
Future<void> filterSpecklesAsync(
  InputOutputArray img,
  double newVal,
  int maxSpeckleSize,
  double maxDiff, {
  OutputArray? buf,
}) async {
  buf ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_filterSpeckles(img.ref, newVal, maxSpeckleSize, maxDiff, buf!.ref, callback),
    (c) => c.complete(),
  );
}

/// finds subpixel-accurate positions of the chessboard corners
///
/// bool cv::find4QuadCornerSubpix (InputArray img, InputOutputArray corners, Size region_size)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab8816c8a176e1d78893b843b3f01557a
Future<bool> find4QuadCornerSubpixAsync(
  InputArray img,
  InputOutputArray corners,
  (int, int) regionSize,
) async {
  final prval = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) =>
        ccalib3d.cv_find4QuadCornerSubpix(img.ref, corners.ref, regionSize.cvd.ref, prval, callback),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete(rval);
    },
  );
}

// FindChessboardCorners finds the positions of internal corners of the chessboard.
//
// For further details, please see:
// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga93efa9b0aa890de240ca32b11253dd4a
Future<(bool success, VecPoint2f corners)> findChessboardCornersAsync(
  InputArray image,
  (int, int) patternSize, {
  VecPoint2f? corners,
  int flags = CALIB_CB_ADAPTIVE_THRESH + CALIB_CB_NORMALIZE_IMAGE,
}) async {
  corners ??= VecPoint2f();
  final r = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) =>
        ccalib3d.cv_findChessboardCorners(image.ref, patternSize.cvd.ref, corners!.ptr, flags, r, callback),
    (c) {
      final rval = r.value;
      calloc.free(r);
      return c.complete((rval, corners!));
    },
  );
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
    (callback) =>
        ccalib3d.cv_findChessboardCornersSB(image.ref, patternSize.cvd.ref, corners!.ptr, flags, b, callback),
    (c) {
      final rval = b.value;
      calloc.free(b);
      return c.complete((rval, corners!));
    },
  );
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
    (callback) => ccalib3d.cv_findChessboardCornersSB_1(
      image.ref,
      patternSize.cvd.ref,
      corners!.ptr,
      flags,
      meta!.ref,
      b,
      callback,
    ),
    (c) {
      final rval = b.value;
      calloc.free(b);
      return c.complete((rval, corners!, meta!));
    },
  );
}

/// Finds centers in the grid of circles.
///
/// bool cv::findCirclesGrid (InputArray image, Size patternSize, OutputArray centers, int flags=CALIB_CB_SYMMETRIC_GRID, const Ptr< FeatureDetector > &blobDetector=SimpleBlobDetector::create())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga7f02cd21c8352142890190227628fa80
Future<(bool, Mat)> findCirclesGridAsync(
  InputArray image,
  Size patternSize, {
  int flags = CALIB_CB_SYMMETRIC_GRID,
  OutputArray? centers,
}) async {
  centers ??= Mat.empty();
  final prval = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) =>
        ccalib3d.cv_findCirclesGrid(image.ref, patternSize.ref, centers!.ref, flags, prval, callback),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, centers!));
    },
  );
}

/// Calculates an essential matrix from the corresponding points in two images.
///
/// Mat cv::findEssentialMat (InputArray points1, InputArray points2, double focal=1.0, Point2d pp=Point2d(0, 0), int method=RANSAC, double prob=0.999, double threshold=1.0, int maxIters=1000, OutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab39a252d16802e86d7d712b1065a1a51
Future<Mat> findEssentialMatAsync(
  InputArray points1,
  InputArray points2, {
  double focal = 1.0,
  Point2d? pp,
  int method = RANSAC,
  double prob = 0.999,
  double threshold = 1.0,
  int maxIters = 1000,
  OutputArray? mask,
}) async {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  pp ??= Point2d(0, 0);
  return cvRunAsync0(
    (callback) => ccalib3d.cv_findEssentialMat(
      points1.ref,
      points2.ref,
      focal,
      pp!.ref,
      method,
      prob,
      threshold,
      maxIters,
      mask!.ref,
      prval,
      callback,
    ),
    (c) => c.complete(Mat.fromPointer(prval)),
  );
}

/// Calculates an essential matrix from the corresponding points in two images.
///
/// Mat cv::findEssentialMat (InputArray points1, InputArray points2, InputArray cameraMatrix, int method=RANSAC, double prob=0.999, double threshold=1.0, int maxIters=1000, OutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gad245d60e64d0c1270dbfd0520847bb87
Future<Mat> findEssentialMatCameraMatrixAsync(
  InputArray points1,
  InputArray points2,
  InputArray cameraMatrix, {
  int method = RANSAC,
  double prob = 0.999,
  double threshold = 1.0,
  int maxIters = 1000,
  OutputArray? mask,
}) {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_findEssentialMat_1(
      points1.ref,
      points2.ref,
      cameraMatrix.ref,
      method,
      prob,
      threshold,
      maxIters,
      mask!.ref,
      prval,
      callback,
    ),
    (c) => c.complete(Mat.fromPointer(prval)),
  );
}

/// Calculates a fundamental matrix from the corresponding points in two images.
///
/// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, int method=FM_RANSAC, double ransacReprojThreshold=3., double confidence=0.99, OutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga59b0d57f46f8677fb5904294a23d404a
Future<Mat> findFundamentalMatAsync(
  InputArray points1,
  InputArray points2, {
  int method = FM_RANSAC,
  double ransacReprojThreshold = 3,
  double confidence = 0.99,
  int maxIters = 1000,
  OutputArray? mask,
}) async {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_findFundamentalMat(
      points1.ref,
      points2.ref,
      method,
      ransacReprojThreshold,
      confidence,
      maxIters,
      mask!.ref,
      prval,
      callback,
    ),
    (c) => c.complete(Mat.fromPointer(prval)),
  );
}

/// Calculates a fundamental matrix from the corresponding points in two images.
///
/// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, OutputArray mask, const UsacParams &params)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gae850fad056e407befb9e2db04dd9e509
Future<Mat> findFundamentalMatUsacAsync(
  InputArray points1,
  InputArray points2,
  UsacParams params, {
  OutputArray? mask,
}) async {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  return cvRunAsync0(
    (callback) =>
        ccalib3d.cv_findFundamentalMat_1(points1.ref, points2.ref, mask!.ref, params.ref, prval, callback),
    (c) => c.complete(Mat.fromPointer(prval)),
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

/// FindHomography finds an optimal homography matrix using 4 or more point pairs (as opposed to GetPerspectiveTransform, which uses exactly 4)
///
/// Mat cv::findHomography (InputArray srcPoints, InputArray dstPoints, OutputArray mask, const UsacParams &params)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga4b3841447530523e5272ec05c5d1e411
Future<Mat> findHomographyUsacAsync(
  InputArray srcPoints,
  InputArray dstPoints,
  UsacParams params, {
  OutputArray? mask,
}) async {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  return cvRunAsync0(
    (callback) =>
        ccalib3d.cv_findHomography_1(srcPoints.ref, dstPoints.ref, mask!.ref, params.ref, prval, callback),
    (c) => c.complete(Mat.fromPointer(prval)),
  );
}

/// Returns the default new camera matrix.
///
/// The function returns the camera matrix that is either an exact copy of the input cameraMatrix (when centerPrinicipalPoint=false ),
/// or the modified one (when centerPrincipalPoint=true).
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga744529385e88ef7bc841cbe04b35bfbf
Future<Mat> getDefaultNewCameraMatrixAsync(
  InputArray cameraMatrix, {
  Size? imgsize,
  bool centerPrincipalPoint = false,
}) async {
  final prval = calloc<cvg.Mat>();
  imgsize ??= Size(0, 0);
  return cvRunAsync0(
    (callback) => ccalib3d.cv_getDefaultNewCameraMatrix(
      cameraMatrix.ref,
      imgsize!.ref,
      centerPrincipalPoint,
      prval,
      callback,
    ),
    (c) => c.complete(Mat.fromPointer(prval)),
  );
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
    (c) => c.complete((map1!, map2!)),
  );
}

/// initializes maps for remap for wide-angle
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga9185f4fbe1ad74af2c56a392393cf9f4
Future<(double rval, Mat map1, Mat map2)> initWideAngleProjMapAsync(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  Size imageSize,
  int destImageWidth,
  int m1type, {
  OutputArray? map1,
  OutputArray? map2,
  int projType = PROJ_SPHERICAL_EQRECT,
  double alpha = 0,
}) async {
  map1 ??= Mat.empty();
  map2 ??= Mat.empty();
  final prval = calloc<ffi.Float>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_initWideAngleProjMap(
      cameraMatrix.ref,
      distCoeffs.ref,
      imageSize.ref,
      destImageWidth,
      m1type,
      map1!.ref,
      map2!.ref,
      projType,
      alpha,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, map1!, map2!));
    },
  );
}

/// Computes partial derivatives of the matrix product for each multiplied matrix.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga905541c1275852eabff7dbdfbc10d160
Future<(Mat dABdA, Mat dABdB)> matMulDerivAsync(
  InputArray A,
  InputArray B, {
  OutputArray? dABdA,
  OutputArray? dABdB,
}) async {
  dABdA ??= Mat.empty();
  dABdB ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_matMulDeriv(A.ref, B.ref, dABdA!.ref, dABdB!.ref, callback),
    (c) => c.complete((dABdA!, dABdB!)),
  );
}

/// Projects 3D points to an image plane.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga1019495a2c8d1743ed5cc23fa0daff8c
Future<(Mat imagePoints, Mat jacobian)> projectPointsAsync(
  InputArray objectPoints,
  InputArray rvec,
  InputArray tvec,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? imagePoints,
  OutputArray? jacobian,
  double aspectRatio = 0,
}) async {
  imagePoints ??= Mat.empty();
  jacobian ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_projectPoints(
      objectPoints.ref,
      rvec.ref,
      tvec.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      imagePoints!.ref,
      jacobian!.ref,
      aspectRatio,
      callback,
    ),
    (c) => c.complete((imagePoints!, jacobian!)),
  );
}

/// Recovers the relative camera rotation and the translation from an estimated essential matrix and the corresponding points in two images, using chirality check. Returns the number of inliers that pass the check.
///
/// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, OutputArray R, OutputArray t, double focal=1.0, Point2d pp=Point2d(0, 0), InputOutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga40919d0c7eaf77b0df67dd76d5d24fa1
Future<(int rval, Mat R, Mat t)> recoverPoseAsync(
  InputArray E,
  InputArray points1,
  InputArray points2, {
  OutputArray? R,
  OutputArray? t,
  double focal = 1,
  Point2d? pp,
  InputOutputArray? mask,
}) async {
  R ??= Mat.empty();
  t ??= Mat.empty();
  mask ??= Mat.empty();
  pp ??= Point2d(0, 0);
  final prval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_recoverPose_1(
      E.ref,
      points1.ref,
      points2.ref,
      R!.ref,
      t!.ref,
      focal,
      pp!.ref,
      mask!.ref,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, R!, t!));
    },
  );
}

// Recovers the relative camera rotation and the translation from an estimated essential matrix and the corresponding points in two images, using chirality check. Returns the number of inliers that pass the check.
///
/// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, InputArray cameraMatrix, OutputArray R, OutputArray t, double distanceThresh, InputOutputArray mask=noArray(), OutputArray triangulatedPoints=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gadb7d2dfcc184c1d2f496d8639f4371c0
Future<(int rval, Mat R, Mat t, Mat triangulatedPoints)> recoverPoseCameraMatrixAsync(
  InputArray E,
  InputArray points1,
  InputArray points2,
  InputArray cameraMatrix, {
  OutputArray? R,
  OutputArray? t,
  double distanceThresh = 1,
  InputOutputArray? mask,
  OutputArray? triangulatedPoints,
}) async {
  R ??= Mat.empty();
  t ??= Mat.empty();
  mask ??= Mat.empty();
  triangulatedPoints ??= Mat.empty();
  final prval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_recoverPose(
      E.ref,
      points1.ref,
      points2.ref,
      cameraMatrix.ref,
      R!.ref,
      t!.ref,
      distanceThresh,
      mask!.ref,
      triangulatedPoints!.ref,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, R!, t!, triangulatedPoints!));
    },
  );
}

/// Converts a rotation matrix to a rotation vector or vice versa.
///
/// void cv::Rodrigues (InputArray src, OutputArray dst, OutputArray jacobian=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga61585db663d9da06b68e70cfbf6a1eac
Future<Mat> RodriguesAsync(InputArray src, {OutputArray? dst, OutputArray? jacobian}) async {
  dst ??= Mat.empty();
  jacobian ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_Rodrigues(src.ref, dst!.ref, jacobian!.ref, callback),
    (c) => c.complete(dst!),
  );
}

/// Computes an RQ decomposition of 3x3 matrices.
///
/// Vec3d cv::RQDecomp3x3 (InputArray src, OutputArray mtxR, OutputArray mtxQ, OutputArray Qx=noArray(), OutputArray Qy=noArray(), OutputArray Qz=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga1aaacb6224ec7b99d34866f8f9baac83
Future<(Vec3d rval, Mat mtxR, Mat mtxQ)> RQDecomp3x3Async(
  InputArray src, {
  OutputArray? mtxR,
  OutputArray? mtxQ,
  OutputArray? Qx,
  OutputArray? Qy,
  OutputArray? Qz,
}) async {
  mtxR ??= Mat.empty();
  mtxQ ??= Mat.empty();
  Qx ??= Mat.empty();
  Qy ??= Mat.empty();
  Qz ??= Mat.empty();
  final prval = calloc<cvg.Vec3d>();
  return cvRunAsync0(
    (callback) =>
        ccalib3d.cv_RQDecomp3x3(src.ref, mtxR!.ref, mtxQ!.ref, Qx!.ref, Qy!.ref, Qz!.ref, prval, callback),
    (c) => c.complete((Vec3d.fromPointer(prval), mtxR!, mtxQ!)),
  );
}

/// Finds an object pose from 3 3D-2D point correspondences.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gae5af86788e99948d40b39a03f6acf623
Future<(int rval, VecMat rvecs, VecMat tvecs)> solveP3PAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs,
  int flags, {
  VecMat? rvecs,
  VecMat? tvecs,
}) async {
  rvecs ??= VecMat();
  tvecs ??= VecMat();
  final prval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solveP3P(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvecs!.ptr,
      tvecs!.ptr,
      flags,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvecs!, tvecs!));
    },
  );
}

/// Finds an object pose from 3D-2D point correspondences.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga549c2075fac14829ff4a58bc931c033d
Future<(bool rval, Mat rvec, Mat tvec)> solvePnPAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? rvec,
  OutputArray? tvec,
  bool useExtrinsicGuess = false,
  int flags = SOLVEPNP_ITERATIVE,
}) async {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  final prval = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solvePnP(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      useExtrinsicGuess,
      flags,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvec!, tvec!));
    },
  );
}

/// Finds an object pose from 3D-2D point correspondences.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga624af8a6641b9bdb487f63f694e8bb90
Future<(int rval, VecMat rvecs, VecMat tvecs, Mat reprojectionError)> solvePnPGenericAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  VecMat? rvecs,
  VecMat? tvecs,
  bool useExtrinsicGuess = false,
  int flags = SOLVEPNP_ITERATIVE,
  InputArray? rvec,
  InputArray? tvec,
  OutputArray? reprojectionError,
}) async {
  rvecs ??= VecMat();
  tvecs ??= VecMat();
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  reprojectionError ??= Mat.empty();
  final prval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solvePnPGeneric(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvecs!.ptr,
      tvecs!.ptr,
      useExtrinsicGuess,
      flags,
      rvec!.ref,
      tvec!.ref,
      reprojectionError!.ref,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvecs!, tvecs!, reprojectionError!));
    },
  );
}

/// Finds an object pose from 3D-2D point correspondences using the RANSAC scheme.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga50620f0e26e02caa2e9adc07b5fbf24e
Future<(bool rval, Mat rvec, Mat tvec, Mat inliers)> solvePnPRansacAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? rvec,
  OutputArray? tvec,
  bool useExtrinsicGuess = false,
  int iterationsCount = 100,
  double reprojectionError = 8.0,
  double confidence = 0.99,
  OutputArray? inliers,
  int flags = SOLVEPNP_ITERATIVE,
}) async {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  inliers ??= Mat.empty();
  final prval = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solvePnPRansac(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      useExtrinsicGuess,
      iterationsCount,
      reprojectionError,
      confidence,
      inliers!.ref,
      flags,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvec!, tvec!, inliers!));
    },
  );
}

/// Finds an object pose from 3D-2D point correspondences using the RANSAC scheme.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab14667ec49eda61b4a3f14eb9704373b
Future<(bool rval, Mat rvec, Mat tvec, Mat inliers)> solvePnPRansacUsacAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputOutputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? rvec,
  OutputArray? tvec,
  OutputArray? inliers,
  UsacParams? params,
}) async {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  inliers ??= Mat.empty();
  params ??= UsacParams();
  final prval = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solvePnPRansac_1(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      inliers!.ref,
      params!.ref,
      prval,
      callback,
    ),
    (c) {
      final rval = prval.value;
      calloc.free(prval);
      return c.complete((rval, rvec!, tvec!, inliers!));
    },
  );
}

/// Refine a pose (the translation and the rotation that transform a 3D point expressed in the
/// object coordinate frame to the camera coordinate frame) from a 3D-2D point correspondences and
/// starting from an initial solution.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga650ba4d286a96d992f82c3e6dfa525fa
Future<void> solvePnPRefineLMAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs,
  InputOutputArray rvec,
  InputOutputArray tvec, {
  TermCriteria? criteria,
}) async {
  // in opencv, this is TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 20, FLT_EPSILON)
  // FLT_EPSILON depends on the platform, here we use 1e-7 to simplify this.
  // which may get different results on than opencv c++.
  criteria ??= TermCriteria(TERM_EPS + TERM_COUNT, 20, 1e-7);
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solvePnPRefineLM(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec.ref,
      tvec.ref,
      criteria!.ref,
      callback,
    ),
    (c) => c.complete(),
  );
}

/// Refine a pose (the translation and the rotation that transform a 3D point expressed in the
/// object coordinate frame to the camera coordinate frame) from a 3D-2D point correspondences and
/// starting from an initial solution.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga17491c0282e4af874f6206a9166774a5
Future<void> solvePnPRefineVVSAsync(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs,
  InputOutputArray rvec,
  InputOutputArray tvec, {
  TermCriteria? criteria,
  double VVSlambda = 1.0,
}) async {
  criteria ??= TermCriteria(TERM_EPS + TERM_COUNT, 20, 1e-7);
  return cvRunAsync0(
    (callback) => ccalib3d.cv_solvePnPRefineVVS(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec.ref,
      tvec.ref,
      criteria!.ref,
      VVSlambda,
      callback,
    ),
    (c) => c.complete(),
  );
}

/// This function reconstructs 3-dimensional points (in homogeneous coordinates) by using their observations with a stereo camera.
///
/// void cv::triangulatePoints (InputArray projMatr1, InputArray projMatr2, InputArray projPoints1, InputArray projPoints2, OutputArray points4D);
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gad3fc9a0c82b08df034234979960b778c
Future<Mat> triangulatePointsAsync(
  InputArray projMatr1,
  InputArray projMatr2,
  InputArray projPoints1,
  InputArray projPoints2, {
  OutputArray? points4D,
}) async {
  points4D ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccalib3d.cv_triangulatePoints(
      projMatr1.ref,
      projMatr2.ref,
      projPoints1.ref,
      projPoints2.ref,
      points4D!.ref,
      callback,
    ),
    (c) => c.complete(points4D!),
  );
}

/// Transforms an image to compensate for lens distortion.
/// The function transforms an image to compensate radial and tangential lens distortion.
/// The function is simply a combination of initUndistortRectifyMap (with unity R ) and remap (with bilinear interpolation). See the former function for details of the transformation being performed.
/// Those pixels in the destination image, for which there is no correspondent pixels in the source image, are filled with zeros (black color).
/// A particular subset of the source image that will be visible in the corrected image can be regulated by newCameraMatrix. You can use getOptimalNewCameraMatrix to compute the appropriate newCameraMatrix depending on your requirements.
/// The camera matrix and the distortion parameters can be determined using calibrateCamera. If the resolution of images is different from the resolution used at the calibration stage, fx,fy,cx and cy need to be scaled accordingly, while the distortion coefficients remain the same.
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

/// Compute undistorted image points position.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga6327c952253fd43f729c4008c2a45c17
Future<Mat> undistortImagePointsAsync(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  TermCriteria? criteria,
}) async {
  dst ??= Mat.empty();
  criteria ??= TermCriteria(TERM_MAX_ITER + TERM_EPS, 5, 0.01);
  return cvRunAsync0(
    (callback) => ccalib3d.cv_undistortImagePoints(
      src.ref,
      dst!.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      criteria!.ref,
      callback,
    ),
    (c) => c.complete(dst!),
  );
}

/// UndistortPoints transforms points to compensate for lens distortion
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga55c716492470bfe86b0ee9bf3a1f0f7e
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

/// validates disparity using the left-right check. The matrix "cost" should be computed by the
/// stereo correspondence algorithm
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga214b498b8d01d0417e0d08be64c54eb5
// TODO
// Future<void> validateDisparityAsync(
//   InputOutputArray disparity,
//   InputArray cost,
//   int minDisparity,
//   int numberOfDisparities, {
//   int disp12MaxDisp = 1,
// }) async {
//   return cvRunAsync0(
//     (callback) => ccalib3d.cv_validateDisparity(
//       disparity.ref,
//       cost.ref,
//       minDisparity,
//       numberOfDisparities,
//       disp12MaxDisp,
//       callback,
//     ),
//     (c) => c.complete(),
//   );
// }
