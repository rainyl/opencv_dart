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
import '../g/calib3d.g.dart' as ccalib3d;
import '../g/constants.g.dart';
import '../g/types.g.dart' as cvg;
import 'usac_params.dart';

/// CalibrateCamera finds the camera intrinsic and extrinsic parameters from several views of a calibration pattern.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga3207604e4b1a1758aa66acb6ed5aa65d
(double rmsErr, Mat cameraMatrix, Mat distCoeffs, Mat rvecs, Mat tvecs) calibrateCamera(
  Contours3f objectPoints,
  Contours2f imagePoints,
  (int, int) imageSize,
  InputOutputArray cameraMatrix,
  InputOutputArray distCoeffs, {
  Mat? rvecs,
  Mat? tvecs,
  int flags = 0,
  (int type, int count, double eps) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) {
  rvecs ??= Mat.empty();
  tvecs ??= Mat.empty();
  final cRmsErr = calloc<ffi.Double>();

  cvRun(
    () => ccalib3d.cv_calibrateCamera(
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
      ffi.nullptr,
    ),
  );
  final rmsErr = cRmsErr.value;
  calloc.free(cRmsErr);
  return (rmsErr, cameraMatrix, distCoeffs, rvecs, tvecs);
}

/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gacd8162cfd39138d0bc29e4b53d080673
bool checkChessboard(Mat img, Size size) => ccalib3d.cv_checkChessboard(img.ref, size.ref);

/// For points in an image of a stereo pair, computes the corresponding epilines in the other image.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga19e3401c94c44b47c229be6e51d158b7
Mat computeCorrespondEpilines(InputArray points, int whichImage, InputArray F, {OutputArray? lines}) {
  lines ??= Mat.empty();
  cvRun(() => ccalib3d.cv_computeCorrespondEpilines(points.ref, whichImage, F.ref, lines!.ref, ffi.nullptr));
  return lines;
}

/// Converts points from homogeneous to Euclidean space.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gac42edda3a3a0f717979589fcd6ac0035
Mat convertPointsFromHomogeneous(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccalib3d.cv_convertPointsFromHomogeneous(src.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Converts points from Euclidean to homogeneous space.
///
/// `void cv::convertPointsToHomogeneous (InputArray src, OutputArray dst);`
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga13159f129eec8a7d9bd8501f012d5543
Mat convertPointsToHomogeneous(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccalib3d.cv_convertPointsToHomogeneous(src.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Refines coordinates of corresponding points.
///
/// void cv::correctMatches (InputArray F, InputArray points1, InputArray points2, OutputArray newPoints1, OutputArray newPoints2);
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gaf32c99d17908e175ac71e7a08fad587b
(Mat newPoints1, Mat newPoints2) correctMatches(
  Mat F,
  InputArray points1,
  InputArray points2, {
  OutputArray? newPoints1,
  OutputArray? newPoints2,
}) {
  newPoints1 ??= Mat.empty();
  newPoints2 ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_correctMatches(
      F.ref,
      points1.ref,
      points2.ref,
      newPoints1!.ref,
      newPoints2!.ref,
      ffi.nullptr,
    ),
  );
  return (newPoints1, newPoints2);
}

/// Decompose an essential matrix to possible rotations and translation.
///
/// void cv::decomposeEssentialMat (InputArray E, OutputArray R1, OutputArray R2, OutputArray t);
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga54a2f5b3f8aeaf6c76d4a31dece85d5d
(Mat r1, Mat r2, Mat t) decomposeEssentialMat(Mat E, {OutputArray? R1, OutputArray? R2, OutputArray? t}) {
  R1 ??= Mat.empty();
  R2 ??= Mat.empty();
  t ??= Mat.empty();
  cvRun(() => ccalib3d.cv_decomposeEssentialMat(E.ref, R1!.ref, R2!.ref, t!.ref, ffi.nullptr));
  return (R1, R2, t);
}

/// Decompose a homography matrix to rotation(s), translation(s) and plane normal(s).
///
/// int cv::decomposeHomographyMat (InputArray H, InputArray K, OutputArrayOfArrays rotations, OutputArrayOfArrays translations, OutputArrayOfArrays normals)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga7f60bdff78833d1e3fd6d9d0fd538d92
(int rval, VecMat rotations, VecMat translations, VecMat normals) decomposeHomographyMat(
  Mat H,
  Mat K, {
  VecMat? rotations,
  VecMat? translations,
  VecMat? normals,
}) {
  rotations ??= VecMat();
  translations ??= VecMat();
  normals ??= VecMat();
  final prval = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_decomposeHomographyMat(
      H.ref,
      K.ref,
      rotations!.ref,
      translations!.ref,
      normals!.ref,
      prval,
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, rotations, translations, normals);
}

/// Decomposes a projection matrix into a rotation matrix and a camera intrinsic matrix.
///
/// void cv::decomposeProjectionMatrix (InputArray projMatrix, OutputArray cameraMatrix, OutputArray rotMatrix, OutputArray transVect, OutputArray rotMatrixX=noArray(), OutputArray rotMatrixY=noArray(), OutputArray rotMatrixZ=noArray(), OutputArray eulerAngles=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gaaae5a7899faa1ffdf268cd9088940248
(Mat cameraMatrix, Mat rotMatrix, Mat transVect) decomposeProjectionMatrix(
  Mat projMatrix, {
  OutputArray? cameraMatrix,
  OutputArray? rotMatrix,
  OutputArray? transVect,
  OutputArray? rotMatrixX,
  OutputArray? rotMatrixY,
  OutputArray? rotMatrixZ,
  OutputArray? eulerAngles,
}) {
  cameraMatrix ??= Mat.empty();
  rotMatrix ??= Mat.empty();
  transVect ??= Mat.empty();
  rotMatrixX ??= Mat.empty();
  rotMatrixY ??= Mat.empty();
  rotMatrixZ ??= Mat.empty();
  eulerAngles ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_decomposeProjectionMatrix(
      projMatrix.ref,
      cameraMatrix!.ref,
      rotMatrix!.ref,
      transVect!.ref,
      rotMatrixX!.ref,
      rotMatrixY!.ref,
      rotMatrixZ!.ref,
      eulerAngles!.ref,
      ffi.nullptr,
    ),
  );
  return (cameraMatrix, rotMatrix, transVect);
}

/// DrawChessboardCorners renders the detected chessboard corners.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga6a10b0bb120c4907e5eabbcd22319022
Mat drawChessboardCorners(
  InputOutputArray image,
  (int, int) patternSize,
  VecPoint2f corners,
  bool patternWasFound,
) {
  cvRun(
    () => ccalib3d.cv_drawChessboardCorners(
      image.ref,
      patternSize.cvd.ref,
      corners.ref,
      patternWasFound,
      ffi.nullptr,
    ),
  );
  return image;
}

/// Draw axes of the world/object coordinate system from pose estimation.
///
/// For further details, please see:
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab3ab7bb2bdfe7d5d9745bb92d13f9564
void drawFrameAxes(
  Mat image,
  Mat cameraMatrix,
  Mat distCoeffs,
  Mat rvec,
  Mat tvec,
  double length, {
  int thickness = 3,
}) {
  return cvRun(
    () => ccalib3d.cv_drawFrameAxes(
      image.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec.ref,
      tvec.ref,
      length,
      thickness,
      ffi.nullptr,
    ),
  );
}

/// EstimateAffinePartial2D computes an optimal limited affine transformation
/// with 4 degrees of freedom between two 2D point sets.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#gad767faff73e9cbd8b9d92b955b50062d
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
  inliers ??= Mat.empty();
  final rval = Mat.empty();
  cvRun(
    () => ccalib3d.cv_estimateAffinePartial2D_1(
      from.ref,
      to.ref,
      inliers!.ref,
      method,
      ransacReprojThreshold,
      maxIters,
      confidence,
      refineIters,
      rval.ptr,
      ffi.nullptr,
    ),
  );
  return (rval, inliers);
}

/// EstimateAffine2D Computes an optimal affine transformation between two 2D point sets.
///
/// For further details, please see:
/// https://docs.opencv.org/4.0.0/d9/d0c/group__calib3d.html#ga27865b1d26bac9ce91efaee83e94d4dd
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
  inliers ??= Mat.empty();
  final rval = Mat.empty();
  cvRun(
    () => ccalib3d.cv_estimateAffine2D_1(
      from.ref,
      to.ref,
      inliers!.ref,
      method,
      ransacReprojThreshold,
      maxIters,
      confidence,
      refineIters,
      rval.ptr,
      ffi.nullptr,
    ),
  );
  return (rval, inliers);
}

/// Computes an optimal affine transformation between two 3D point sets.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gac12d1f05b3bb951288e7250713ce98f0
(int rval, Mat, Mat inliers) estimateAffine3D(
  Mat src,
  Mat dst, {
  Mat? out,
  Mat? inliers,
  double ransacThreshold = 3,
  double confidence = 0.99,
}) {
  out ??= Mat.empty();
  inliers ??= Mat.empty();
  final p = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_estimateAffine3D_1(
      src.ref,
      dst.ref,
      out!.ref,
      inliers!.ref,
      ransacThreshold,
      confidence,
      p,
      ffi.nullptr,
    ),
  );
  final rval = p.value;
  calloc.free(p);
  return (rval, out, inliers);
}

/// Estimates the sharpness of a detected chessboard.
///
/// Scalar cv::estimateChessboardSharpness (InputArray image, Size patternSize, InputArray corners, float rise_distance=0.8F, bool vertical=false, OutputArray sharpness=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga1b976b476cd2083edd4323a34e9e1ffa
Scalar estimateChessboardSharpness(
  InputArray image,
  (int, int) patternSize,
  InputArray corners, {
  double riseDistance = 0.8,
  bool vertical = false,
  OutputArray? sharpness,
}) {
  sharpness ??= Mat.empty();
  final prval = calloc<cvg.Scalar>();
  cvRun(
    () => ccalib3d.cv_estimateChessboardSharpness(
      image.ref,
      patternSize.cvd.ref,
      corners.ref,
      riseDistance,
      vertical,
      sharpness!.ref,
      prval,
      ffi.nullptr,
    ),
  );
  return Scalar.fromPointer(prval);
}

/// Computes an optimal translation between two 3D point sets.
///
/// int cv::estimateTranslation3D (InputArray src, InputArray dst, OutputArray out, OutputArray inliers, double ransacThreshold=3, double confidence=0.99)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga0ea15af08887dd5afa68d81711d395ff
(int rval, Mat out, Mat inliers) estimateTranslation3D(
  InputArray src,
  InputArray dst, {
  OutputArray? out,
  OutputArray? inliers,
  double ransacThreshold = 3,
  double confidence = 0.99,
}) {
  out ??= Mat.empty();
  inliers ??= Mat.empty();
  final prval = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_estimateTranslation3D(
      src.ref,
      dst.ref,
      out!.ref,
      inliers!.ref,
      ransacThreshold,
      confidence,
      prval,
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, out, inliers);
}

/// Filters homography decompositions based on additional information.
///
/// void cv::filterHomographyDecompByVisibleRefpoints (InputArrayOfArrays rotations, InputArrayOfArrays normals, InputArray beforePoints, InputArray afterPoints, OutputArray possibleSolutions, InputArray pointsMask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga32f867159200f7bd55e72dca92d8494c
Mat filterHomographyDecompByVisibleRefpoints(
  VecMat rotations,
  VecMat normals,
  InputArray beforePoints,
  InputArray afterPoints, {
  OutputArray? possibleSolutions,
  InputArray? pointsMask,
}) {
  possibleSolutions ??= Mat.empty();
  pointsMask ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_filterHomographyDecompByVisibleRefpoints(
      rotations.ref,
      normals.ref,
      beforePoints.ref,
      afterPoints.ref,
      possibleSolutions!.ref,
      pointsMask!.ref,
      ffi.nullptr,
    ),
  );
  return possibleSolutions;
}

/// Filters off small noise blobs (speckles) in the disparity map.
///
/// void cv::filterSpeckles (InputOutputArray img, double newVal, int maxSpeckleSize, double maxDiff, InputOutputArray buf=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gabe331f205a6dd7a9aa5db8a38157d25b
void filterSpeckles(
  InputOutputArray img,
  double newVal,
  int maxSpeckleSize,
  double maxDiff, {
  OutputArray? buf,
}) {
  buf ??= Mat.empty();
  return cvRun(
    () => ccalib3d.cv_filterSpeckles(img.ref, newVal, maxSpeckleSize, maxDiff, buf!.ref, ffi.nullptr),
  );
}

/// finds subpixel-accurate positions of the chessboard corners
///
/// bool cv::find4QuadCornerSubpix (InputArray img, InputOutputArray corners, Size region_size)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab8816c8a176e1d78893b843b3f01557a
bool find4QuadCornerSubpix(InputArray img, InputOutputArray corners, (int, int) regionSize) {
  final prval = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_find4QuadCornerSubpix(img.ref, corners.ref, regionSize.cvd.ref, prval, ffi.nullptr),
  );
  final rval = prval.value;
  calloc.free(prval);
  return rval;
}

/// FindChessboardCorners finds the positions of internal corners of the chessboard.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga93efa9b0aa890de240ca32b11253dd4a
(bool success, VecPoint2f corners) findChessboardCorners(
  InputArray image,
  (int, int) patternSize, {
  VecPoint2f? corners,
  int flags = CALIB_CB_ADAPTIVE_THRESH + CALIB_CB_NORMALIZE_IMAGE,
}) {
  corners ??= VecPoint2f();
  final r = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_findChessboardCorners(
      image.ref,
      patternSize.cvd.ref,
      corners!.ptr,
      flags,
      r,
      ffi.nullptr,
    ),
  );
  final rval = r.value;
  calloc.free(r);
  return (rval, corners);
}

/// Finds the positions of internal corners of the chessboard using a sector based approach.
///
/// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
(bool, VecPoint2f corners) findChessboardCornersSB(
  InputArray image,
  (int, int) patternSize, {
  int flags = 0,
  VecPoint2f? corners,
}) {
  final corners = VecPoint2f();
  final p = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_findChessboardCornersSB(
      image.ref,
      patternSize.toSize().ref,
      corners.ptr,
      flags,
      p,
      ffi.nullptr,
    ),
  );
  final rval = p.value;
  calloc.free(p);
  return (rval, corners);
}

/// Finds the positions of internal corners of the chessboard using a sector based approach.
///
/// https://docs.opencv.org/4.x/d9/d0c/group__calib3d.html#gadc5bcb05cb21cf1e50963df26986d7c9
(bool, VecPoint2f corners, Mat meta) findChessboardCornersSBWithMeta(
  InputArray image,
  (int, int) patternSize,
  int flags, {
  VecPoint2f? corners,
  OutputArray? meta,
}) {
  corners ??= VecPoint2f();
  meta ??= Mat.empty();
  final b = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_findChessboardCornersSB_1(
      image.ref,
      patternSize.cvd.ref,
      corners!.ptr,
      flags,
      meta!.ref,
      b,
      ffi.nullptr,
    ),
  );
  final rval = b.value;
  calloc.free(b);
  return (rval, corners, meta);
}

/// Finds centers in the grid of circles.
///
/// bool cv::findCirclesGrid (InputArray image, Size patternSize, OutputArray centers, int flags=CALIB_CB_SYMMETRIC_GRID, const Ptr< FeatureDetector > &blobDetector=SimpleBlobDetector::create())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga7f02cd21c8352142890190227628fa80
(bool, Mat) findCirclesGrid(
  InputArray image,
  Size patternSize, {
  int flags = CALIB_CB_SYMMETRIC_GRID,
  OutputArray? centers,
}) {
  centers ??= Mat.empty();
  final prval = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_findCirclesGrid(image.ref, patternSize.ref, centers!.ref, flags, prval, ffi.nullptr),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, centers);
}

/// Calculates an essential matrix from the corresponding points in two images.
///
/// Mat cv::findEssentialMat (InputArray points1, InputArray points2, double focal=1.0, Point2d pp=Point2d(0, 0), int method=RANSAC, double prob=0.999, double threshold=1.0, int maxIters=1000, OutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab39a252d16802e86d7d712b1065a1a51
Mat findEssentialMat(
  InputArray points1,
  InputArray points2, {
  double focal = 1.0,
  Point2d? pp,
  int method = RANSAC,
  double prob = 0.999,
  double threshold = 1.0,
  int maxIters = 1000,
  OutputArray? mask,
}) {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  pp ??= Point2d(0, 0);
  cvRun(
    () => ccalib3d.cv_findEssentialMat(
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
      ffi.nullptr,
    ),
  );
  return Mat.fromPointer(prval);
}

/// Calculates an essential matrix from the corresponding points in two images.
///
/// Mat cv::findEssentialMat (InputArray points1, InputArray points2, InputArray cameraMatrix, int method=RANSAC, double prob=0.999, double threshold=1.0, int maxIters=1000, OutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gad245d60e64d0c1270dbfd0520847bb87
Mat findEssentialMatCameraMatrix(
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
  cvRun(
    () => ccalib3d.cv_findEssentialMat_1(
      points1.ref,
      points2.ref,
      cameraMatrix.ref,
      method,
      prob,
      threshold,
      maxIters,
      mask!.ref,
      prval,
      ffi.nullptr,
    ),
  );
  return Mat.fromPointer(prval);
}

/// Calculates a fundamental matrix from the corresponding points in two images.
///
/// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, int method=FM_RANSAC, double ransacReprojThreshold=3., double confidence=0.99, OutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga59b0d57f46f8677fb5904294a23d404a
Mat findFundamentalMat(
  InputArray points1,
  InputArray points2, {
  int method = FM_RANSAC,
  double ransacReprojThreshold = 3,
  double confidence = 0.99,
  int maxIters = 1000,
  OutputArray? mask,
}) {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  cvRun(
    () => ccalib3d.cv_findFundamentalMat(
      points1.ref,
      points2.ref,
      method,
      ransacReprojThreshold,
      confidence,
      maxIters,
      mask!.ref,
      prval,
      ffi.nullptr,
    ),
  );
  return Mat.fromPointer(prval);
}

/// Calculates a fundamental matrix from the corresponding points in two images.
///
/// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, OutputArray mask, const UsacParams &params)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gae850fad056e407befb9e2db04dd9e509
Mat findFundamentalMatUsac(InputArray points1, InputArray points2, UsacParams params, {OutputArray? mask}) {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  cvRun(
    () =>
        ccalib3d.cv_findFundamentalMat_1(points1.ref, points2.ref, mask!.ref, params.ref, prval, ffi.nullptr),
  );
  return Mat.fromPointer(prval);
}

/// FindHomography finds an optimal homography matrix using 4 or more point pairs (as opposed to GetPerspectiveTransform, which uses exactly 4)
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d9/d0c/group__calib3d.html#ga4abc2ece9fab9398f2e560d53c8c9780
Mat findHomography(
  InputArray srcPoints,
  InputArray dstPoints, {
  int method = 0,
  double ransacReprojThreshold = 3,
  OutputArray? mask,
  int maxIters = 2000,
  double confidence = 0.995,
}) {
  mask ??= Mat.empty();
  final mat = Mat.empty();
  cvRun(
    () => ccalib3d.cv_findHomography(
      srcPoints.ref,
      dstPoints.ref,
      method,
      ransacReprojThreshold,
      mask!.ref,
      maxIters,
      confidence,
      mat.ptr,
      ffi.nullptr,
    ),
  );
  return mat;
}

/// FindHomography finds an optimal homography matrix using 4 or more point pairs (as opposed to GetPerspectiveTransform, which uses exactly 4)
///
/// Mat cv::findHomography (InputArray srcPoints, InputArray dstPoints, OutputArray mask, const UsacParams &params)
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga4b3841447530523e5272ec05c5d1e411
Mat findHomographyUsac(InputArray srcPoints, InputArray dstPoints, UsacParams params, {OutputArray? mask}) {
  mask ??= Mat.empty();
  final prval = calloc<cvg.Mat>();
  cvRun(
    () =>
        ccalib3d.cv_findHomography_1(srcPoints.ref, dstPoints.ref, mask!.ref, params.ref, prval, ffi.nullptr),
  );
  return Mat.fromPointer(prval);
}

/// Returns the default new camera matrix.
///
/// The function returns the camera matrix that is either an exact copy of the input cameraMatrix (when centerPrinicipalPoint=false ),
/// or the modified one (when centerPrincipalPoint=true).
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga744529385e88ef7bc841cbe04b35bfbf
Mat getDefaultNewCameraMatrix(InputArray cameraMatrix, {Size? imgsize, bool centerPrincipalPoint = false}) {
  final prval = calloc<cvg.Mat>();
  imgsize ??= Size(0, 0);
  cvRun(
    () => ccalib3d.cv_getDefaultNewCameraMatrix(
      cameraMatrix.ref,
      imgsize!.ref,
      centerPrincipalPoint,
      prval,
      ffi.nullptr,
    ),
  );
  return Mat.fromPointer(prval);
}

/// GetOptimalNewCameraMatrixWithParams computes and returns the optimal new camera matrix based on the free scaling parameter.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga7a6c4e032c97f03ba747966e6ad862b1
(Mat rval, Rect validPixROI) getOptimalNewCameraMatrix(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  (int, int) imageSize,
  double alpha, {
  (int, int) newImgSize = (0, 0),
  bool centerPrincipalPoint = false,
}) {
  final validPixROI = calloc<cvg.CvRect>();
  final rval = Mat.empty();
  cvRun(
    () => ccalib3d.cv_getOptimalNewCameraMatrix(
      cameraMatrix.ref,
      distCoeffs.ref,
      imageSize.cvd.ref,
      alpha,
      newImgSize.cvd.ref,
      validPixROI,
      centerPrincipalPoint,
      rval.ptr,
      ffi.nullptr,
    ),
  );
  return (rval, Rect.fromPointer(validPixROI));
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
  (int, int) size,
  int m1type, {
  OutputArray? map1,
  OutputArray? map2,
}) {
  map1 ??= Mat.empty();
  map2 ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_initUndistortRectifyMap(
      cameraMatrix.ref,
      distCoeffs.ref,
      R.ref,
      newCameraMatrix.ref,
      size.cvd.ref,
      m1type,
      map1!.ref,
      map2!.ref,
      ffi.nullptr,
    ),
  );
  return (map1, map2);
}

/// initializes maps for remap for wide-angle
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga9185f4fbe1ad74af2c56a392393cf9f4
(double rval, Mat map1, Mat map2) initWideAngleProjMap(
  InputArray cameraMatrix,
  InputArray distCoeffs,
  Size imageSize,
  int destImageWidth,
  int m1type, {
  OutputArray? map1,
  OutputArray? map2,
  int projType = PROJ_SPHERICAL_EQRECT,
  double alpha = 0,
}) {
  map1 ??= Mat.empty();
  map2 ??= Mat.empty();
  final prval = calloc<ffi.Float>();
  cvRun(
    () => ccalib3d.cv_initWideAngleProjMap(
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
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, map1, map2);
}

/// Computes partial derivatives of the matrix product for each multiplied matrix.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga905541c1275852eabff7dbdfbc10d160
(Mat dABdA, Mat dABdB) matMulDeriv(InputArray A, InputArray B, {OutputArray? dABdA, OutputArray? dABdB}) {
  dABdA ??= Mat.empty();
  dABdB ??= Mat.empty();
  cvRun(() => ccalib3d.cv_matMulDeriv(A.ref, B.ref, dABdA!.ref, dABdB!.ref, ffi.nullptr));
  return (dABdA, dABdB);
}

/// Projects 3D points to an image plane.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga1019495a2c8d1743ed5cc23fa0daff8c
(Mat imagePoints, Mat jacobian) projectPoints(
  InputArray objectPoints,
  InputArray rvec,
  InputArray tvec,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? imagePoints,
  OutputArray? jacobian,
  double aspectRatio = 0,
}) {
  imagePoints ??= Mat.empty();
  jacobian ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_projectPoints(
      objectPoints.ref,
      rvec.ref,
      tvec.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      imagePoints!.ref,
      jacobian!.ref,
      aspectRatio,
      ffi.nullptr,
    ),
  );
  return (imagePoints, jacobian);
}

/// Recovers the relative camera rotation and the translation from an estimated essential matrix and the corresponding points in two images, using chirality check. Returns the number of inliers that pass the check.
///
/// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, OutputArray R, OutputArray t, double focal=1.0, Point2d pp=Point2d(0, 0), InputOutputArray mask=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga40919d0c7eaf77b0df67dd76d5d24fa1
(int rval, Mat R, Mat t) recoverPose(
  InputArray E,
  InputArray points1,
  InputArray points2, {
  OutputArray? R,
  OutputArray? t,
  double focal = 1,
  Point2d? pp,
  InputOutputArray? mask,
}) {
  R ??= Mat.empty();
  t ??= Mat.empty();
  mask ??= Mat.empty();
  pp ??= Point2d(0, 0);
  final prval = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_recoverPose_1(
      E.ref,
      points1.ref,
      points2.ref,
      R!.ref,
      t!.ref,
      focal,
      pp!.ref,
      mask!.ref,
      prval,
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, R, t);
}

// Recovers the relative camera rotation and the translation from an estimated essential matrix and the corresponding points in two images, using chirality check. Returns the number of inliers that pass the check.
///
/// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, InputArray cameraMatrix, OutputArray R, OutputArray t, double distanceThresh, InputOutputArray mask=noArray(), OutputArray triangulatedPoints=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gadb7d2dfcc184c1d2f496d8639f4371c0
(int rval, Mat R, Mat t, Mat triangulatedPoints) recoverPoseCameraMatrix(
  InputArray E,
  InputArray points1,
  InputArray points2,
  InputArray cameraMatrix, {
  OutputArray? R,
  OutputArray? t,
  double distanceThresh = 1,
  InputOutputArray? mask,
  OutputArray? triangulatedPoints,
}) {
  R ??= Mat.empty();
  t ??= Mat.empty();
  mask ??= Mat.empty();
  triangulatedPoints ??= Mat.empty();
  final prval = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_recoverPose(
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
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, R, t, triangulatedPoints);
}

// void cv::reprojectImageTo3D (InputArray disparity, OutputArray _3dImage, InputArray Q, bool handleMissingValues=false, int ddepth=-1)
// TODO: add Stereo
// Mat reprojectImageTo3D(
//   InputArray disparity,
//   InputArray Q, {
//   OutputArray? out3dImage,
//   bool handleMissingValues = false,
//   int ddepth = -1,
// }) {
//   out3dImage ??= Mat.empty();
//   cvRun(
//     () => ccalib3d.cv_reprojectImageTo3D(
//       disparity.ref,
//       out3dImage!.ref,
//       Q.ref,
//       handleMissingValues,
//       ddepth,
//       ffi.nullptr,
//     ),
//   );
//   return out3dImage;
// }

/// Converts a rotation matrix to a rotation vector or vice versa.
///
/// void cv::Rodrigues (InputArray src, OutputArray dst, OutputArray jacobian=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga61585db663d9da06b68e70cfbf6a1eac
Mat Rodrigues(InputArray src, {OutputArray? dst, OutputArray? jacobian}) {
  dst ??= Mat.empty();
  jacobian ??= Mat.empty();
  cvRun(() => ccalib3d.cv_Rodrigues(src.ref, dst!.ref, jacobian!.ref, ffi.nullptr));
  return dst;
}

/// Computes an RQ decomposition of 3x3 matrices.
///
/// Vec3d cv::RQDecomp3x3 (InputArray src, OutputArray mtxR, OutputArray mtxQ, OutputArray Qx=noArray(), OutputArray Qy=noArray(), OutputArray Qz=noArray())
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga1aaacb6224ec7b99d34866f8f9baac83
(Vec3d rval, Mat mtxR, Mat mtxQ) RQDecomp3x3(
  InputArray src, {
  OutputArray? mtxR,
  OutputArray? mtxQ,
  OutputArray? Qx,
  OutputArray? Qy,
  OutputArray? Qz,
}) {
  mtxR ??= Mat.empty();
  mtxQ ??= Mat.empty();
  Qx ??= Mat.empty();
  Qy ??= Mat.empty();
  Qz ??= Mat.empty();
  final prval = calloc<cvg.Vec3d>();
  cvRun(
    () =>
        ccalib3d.cv_RQDecomp3x3(src.ref, mtxR!.ref, mtxQ!.ref, Qx!.ref, Qy!.ref, Qz!.ref, prval, ffi.nullptr),
  );
  return (Vec3d.fromPointer(prval), mtxR, mtxQ);
}

/// Calculates the Sampson Distance between two points.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gacbba2ee98258ca81d352a31faa15a021
double sampsonDistance(InputArray pt1, InputArray pt2, InputArray F) =>
    ccalib3d.cv_sampsonDistance(pt1.ref, pt2.ref, F.ref);

/// Finds an object pose from 3 3D-2D point correspondences.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gae5af86788e99948d40b39a03f6acf623
(int rval, VecMat rvecs, VecMat tvecs) solveP3P(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs,
  int flags, {
  VecMat? rvecs,
  VecMat? tvecs,
}) {
  rvecs ??= VecMat();
  tvecs ??= VecMat();
  final prval = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_solveP3P(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvecs!.ptr,
      tvecs!.ptr,
      flags,
      prval,
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, rvecs, tvecs);
}

/// Finds an object pose from 3D-2D point correspondences.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga549c2075fac14829ff4a58bc931c033d
(bool rval, Mat rvec, Mat tvec) solvePnP(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? rvec,
  OutputArray? tvec,
  bool useExtrinsicGuess = false,
  int flags = SOLVEPNP_ITERATIVE,
}) {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  final prval = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_solvePnP(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      useExtrinsicGuess,
      flags,
      prval,
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, rvec, tvec);
}

/// Finds an object pose from 3D-2D point correspondences.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga624af8a6641b9bdb487f63f694e8bb90
(int rval, VecMat rvecs, VecMat tvecs, Mat reprojectionError) solvePnPGeneric(
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
}) {
  rvecs ??= VecMat();
  tvecs ??= VecMat();
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  reprojectionError ??= Mat.empty();
  final prval = calloc<ffi.Int>();
  cvRun(
    () => ccalib3d.cv_solvePnPGeneric(
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
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, rvecs, tvecs, reprojectionError);
}

/// Finds an object pose from 3D-2D point correspondences using the RANSAC scheme.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga50620f0e26e02caa2e9adc07b5fbf24e
(bool rval, Mat rvec, Mat tvec, Mat inliers) solvePnPRansac(
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
}) {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  inliers ??= Mat.empty();
  final prval = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_solvePnPRansac(
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
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, rvec, tvec, inliers);
}

/// Finds an object pose from 3D-2D point correspondences using the RANSAC scheme.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gab14667ec49eda61b4a3f14eb9704373b
(bool rval, Mat rvec, Mat tvec, Mat inliers) solvePnPRansacUsac(
  InputArray objectPoints,
  InputArray imagePoints,
  InputOutputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? rvec,
  OutputArray? tvec,
  OutputArray? inliers,
  UsacParams? params,
}) {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  inliers ??= Mat.empty();
  params ??= UsacParams();
  final prval = calloc<ffi.Bool>();
  cvRun(
    () => ccalib3d.cv_solvePnPRansac_1(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      inliers!.ref,
      params!.ref,
      prval,
      ffi.nullptr,
    ),
  );
  final rval = prval.value;
  calloc.free(prval);
  return (rval, rvec, tvec, inliers);
}

/// Refine a pose (the translation and the rotation that transform a 3D point expressed in the
/// object coordinate frame to the camera coordinate frame) from a 3D-2D point correspondences and
/// starting from an initial solution.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga650ba4d286a96d992f82c3e6dfa525fa
void solvePnPRefineLM(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs,
  InputOutputArray rvec,
  InputOutputArray tvec, {
  TermCriteria? criteria,
}) {
  // in opencv, this is TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 20, FLT_EPSILON)
  // FLT_EPSILON depends on the platform, here we use 1e-7 to simplify this.
  // which may get different results on than opencv c++.
  criteria ??= TermCriteria(TERM_EPS + TERM_COUNT, 20, 1e-7);
  return cvRun(
    () => ccalib3d.cv_solvePnPRefineLM(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec.ref,
      tvec.ref,
      criteria!.ref,
      ffi.nullptr,
    ),
  );
}

/// Refine a pose (the translation and the rotation that transform a 3D point expressed in the
/// object coordinate frame to the camera coordinate frame) from a 3D-2D point correspondences and
/// starting from an initial solution.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga17491c0282e4af874f6206a9166774a5
void solvePnPRefineVVS(
  InputArray objectPoints,
  InputArray imagePoints,
  InputArray cameraMatrix,
  InputArray distCoeffs,
  InputOutputArray rvec,
  InputOutputArray tvec, {
  TermCriteria? criteria,
  double VVSlambda = 1.0,
}) {
  criteria ??= TermCriteria(TERM_EPS + TERM_COUNT, 20, 1e-7);
  return cvRun(
    () => ccalib3d.cv_solvePnPRefineVVS(
      objectPoints.ref,
      imagePoints.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec.ref,
      tvec.ref,
      criteria!.ref,
      VVSlambda,
      ffi.nullptr,
    ),
  );
}

// TODO: add Stereo
// double cv::stereoCalibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints1, InputArrayOfArrays imagePoints2, InputOutputArray cameraMatrix1, InputOutputArray distCoeffs1, InputOutputArray cameraMatrix2, InputOutputArray distCoeffs2, Size imageSize, InputOutputArray R, InputOutputArray T, OutputArray E, OutputArray F, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, OutputArray perViewErrors, int flags=CALIB_FIX_INTRINSIC, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 30, 1e-6));
// (
//   double rval,
//   Mat cameraMatrix1,
//   Mat distCoeffs1,
//   Mat cameraMatrix2,
//   Mat distCoeffs2,
//   Mat R,
//   Mat T,
//   Mat E,
//   Mat F,
//   VecMat rvecs,
//   VecMat tvecs,
//   Mat perViewErrors
// ) stereoCalibrate(
//   VecMat objectPoints,
//   VecMat imagePoints1,
//   VecMat imagePoints2,
//   InputOutputArray cameraMatrix1,
//   InputOutputArray distCoeffs1,
//   InputOutputArray cameraMatrix2,
//   InputOutputArray distCoeffs2,
//   Size imageSize,
//   InputOutputArray R,
//   InputOutputArray T, {
//   OutputArray? E,
//   OutputArray? F,
//   VecMat? rvecs,
//   VecMat? tvecs,
//   OutputArray? perViewErrors,
//   int flags = CALIB_FIX_INTRINSIC,
//   TermCriteria? criteria,
// }) {
//   E ??= Mat.empty();
//   F ??= Mat.empty();
//   rvecs ??= VecMat();
//   tvecs ??= VecMat();
//   perViewErrors ??= Mat.empty();
//   criteria ??= TermCriteria(TERM_EPS + TERM_COUNT, 30, 1e-6);
//   final prval = calloc<ffi.Double>();
//   cvRun(
//     () => ccalib3d.cv_stereoCalibrate(
//       objectPoints.ref,
//       imagePoints1.ref,
//       imagePoints2.ref,
//       cameraMatrix1.ref,
//       distCoeffs1.ref,
//       cameraMatrix2.ref,
//       distCoeffs2.ref,
//       imageSize.ref,
//       R.ref,
//       T.ref,
//       E!.ref,
//       F!.ref,
//       rvecs!.ref,
//       tvecs!.ref,
//       perViewErrors!.ref,
//       flags,
//       criteria!.ref,
//       prval,
//       ffi.nullptr,
//     ),
//   );
//   final rval = prval.value;
//   calloc.free(prval);
//   return (
//     rval,
//     cameraMatrix1,
//     distCoeffs1,
//     cameraMatrix2,
//     distCoeffs2,
//     R,
//     T,
//     E,
//     F,
//     rvecs,
//     tvecs,
//     perViewErrors
//   );
// }

// // void cv::stereoRectify (InputArray cameraMatrix1, InputArray distCoeffs1, InputArray cameraMatrix2, InputArray distCoeffs2, Size imageSize, InputArray R, InputArray T, OutputArray R1, OutputArray R2, OutputArray P1, OutputArray P2, OutputArray Q, int flags=CALIB_ZERO_DISPARITY, double alpha=-1, Size newImageSize=Size(), Rect *validPixROI1=0, Rect *validPixROI2=0);
// (Mat R1, Mat R2, Mat P1, Mat P2, Mat Q) stereoRectify(
//   InputArray cameraMatrix1,
//   InputArray distCoeffs1,
//   InputArray cameraMatrix2,
//   InputArray distCoeffs2,
//   Size imageSize,
//   InputArray R,
//   InputArray T, {
//   OutputArray? R1,
//   OutputArray? R2,
//   OutputArray? P1,
//   OutputArray? P2,
//   OutputArray? Q,
//   int flags = CALIB_ZERO_DISPARITY,
//   double alpha = -1,
//   Size? newImageSize,
//   Rect? validPixROI1,
//   Rect? validPixROI2,
// }) {
//   R1 ??= Mat.empty();
//   R2 ??= Mat.empty();
//   P1 ??= Mat.empty();
//   P2 ??= Mat.empty();
//   Q ??= Mat.empty();
//   newImageSize ??= Size(0, 0);
//   final pValidPixROI1 = validPixROI1 == null ? ffi.nullptr : calloc<cvg.CvRect>();
//   final pValidPixROI2 = validPixROI2 == null ? ffi.nullptr : calloc<cvg.CvRect>();
//   cvRun(
//     () => ccalib3d.cv_stereoRectify(
//       cameraMatrix1.ref,
//       distCoeffs1.ref,
//       cameraMatrix2.ref,
//       distCoeffs2.ref,
//       imageSize.ref,
//       R.ref,
//       T.ref,
//       R1!.ref,
//       R2!.ref,
//       P1!.ref,
//       P2!.ref,
//       Q!.ref,
//       flags,
//       alpha,
//       newImageSize!.ref,
//       pValidPixROI1,
//       pValidPixROI2,
//       ffi.nullptr,
//     ),
//   );
//   if (validPixROI1 != null && pValidPixROI1 != ffi.nullptr) {
//     validPixROI1.x = pValidPixROI1.ref.x;
//     validPixROI1.y = pValidPixROI1.ref.y;
//     validPixROI1.width = pValidPixROI1.ref.width;
//     validPixROI1.height = pValidPixROI1.ref.height;
//     calloc.free(pValidPixROI1);
//   }
//   if (validPixROI2 != null && pValidPixROI2 != ffi.nullptr) {
//     validPixROI2.x = pValidPixROI2.ref.x;
//     validPixROI2.y = pValidPixROI2.ref.y;
//     validPixROI2.width = pValidPixROI2.ref.width;
//     validPixROI2.height = pValidPixROI2.ref.height;
//     calloc.free(pValidPixROI2);
//   }
//   return (R1, R2, P1, P2, Q);
// }

// // bool cv::stereoRectifyUncalibrated (InputArray points1, InputArray points2, InputArray F, Size imgSize, OutputArray H1, OutputArray H2, double threshold=5);
// (bool rval, Mat H1, Mat H2) stereoRectifyUncalibrated(
//   InputArray points1,
//   InputArray points2,
//   InputArray F,
//   Size imgSize, {
//   OutputArray? H1,
//   OutputArray? H2,
//   double threshold = 5,
// }) {
//   H1 ??= Mat.empty();
//   H2 ??= Mat.empty();
//   final prval = calloc<ffi.Bool>();
//   cvRun(
//     () => ccalib3d.cv_stereoRectifyUncalibrated(
//       points1.ref,
//       points2.ref,
//       F.ref,
//       imgSize.ref,
//       H1!.ref,
//       H2!.ref,
//       threshold,
//       prval,
//       ffi.nullptr,
//     ),
//   );
//   final rval = prval.value;
//   calloc.free(prval);
//   return (rval, H1, H2);
// }

/// This function reconstructs 3-dimensional points (in homogeneous coordinates) by using their observations with a stereo camera.
///
/// void cv::triangulatePoints (InputArray projMatr1, InputArray projMatr2, InputArray projPoints1, InputArray projPoints2, OutputArray points4D);
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#gad3fc9a0c82b08df034234979960b778c
Mat triangulatePoints(
  InputArray projMatr1,
  InputArray projMatr2,
  InputArray projPoints1,
  InputArray projPoints2, {
  OutputArray? points4D,
}) {
  points4D ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_triangulatePoints(
      projMatr1.ref,
      projMatr2.ref,
      projPoints1.ref,
      projPoints2.ref,
      points4D!.ref,
      ffi.nullptr,
    ),
  );
  return points4D;
}

/// Transforms an image to compensate for lens distortion.
/// The function transforms an image to compensate radial and tangential lens distortion.
/// The function is simply a combination of initUndistortRectifyMap (with unity R ) and remap (with bilinear interpolation). See the former function for details of the transformation being performed.
/// Those pixels in the destination image, for which there is no correspondent pixels in the source image, are filled with zeros (black color).
/// A particular subset of the source image that will be visible in the corrected image can be regulated by newCameraMatrix. You can use getOptimalNewCameraMatrix to compute the appropriate newCameraMatrix depending on your requirements.
/// The camera matrix and the distortion parameters can be determined using calibrateCamera. If the resolution of images is different from the resolution used at the calibration stage, fx,fy,cx and cy need to be scaled accordingly, while the distortion coefficients remain the same.
Mat undistort(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  InputArray? newCameraMatrix,
}) {
  dst ??= Mat.empty();
  newCameraMatrix ??= Mat.empty();
  cvRun(
    () => ccalib3d.cv_undistort(
      src.ref,
      dst!.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      newCameraMatrix!.ref,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// Compute undistorted image points position.
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga6327c952253fd43f729c4008c2a45c17
Mat undistortImagePoints(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  TermCriteria? criteria,
}) {
  dst ??= Mat.empty();
  criteria ??= TermCriteria(TERM_MAX_ITER + TERM_EPS, 5, 0.01);
  cvRun(
    () => ccalib3d.cv_undistortImagePoints(
      src.ref,
      dst!.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      criteria!.ref,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// UndistortPoints transforms points to compensate for lens distortion
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d0c/group__calib3d.html#ga55c716492470bfe86b0ee9bf3a1f0f7e
Mat undistortPoints(
  InputArray src,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  OutputArray? dst,
  InputArray? R,
  InputArray? P,
  (int type, int count, double eps) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
}) {
  R ??= Mat.empty();
  P ??= Mat.empty();
  dst ??= Mat.empty();
  final tc = criteria.cvd;
  cvRun(
    () => ccalib3d.cv_undistortPoints(
      src.ref,
      dst!.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      R!.ref,
      P!.ref,
      tc.ref,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// validates disparity using the left-right check. The matrix "cost" should be computed by the
/// stereo correspondence algorithm
///
/// https://docs.opencv.org/4.11.0/d9/d0c/group__calib3d.html#ga214b498b8d01d0417e0d08be64c54eb5
/// TODO: add Stereo matchers
// void validateDisparity(
//   InputOutputArray disparity,
//   InputArray cost,
//   int minDisparity,
//   int numberOfDisparities, {
//   int disp12MaxDisp = 1,
// }) {
//   return cvRun(
//     () => ccalib3d.cv_validateDisparity(
//       disparity.ref,
//       cost.ref,
//       minDisparity,
//       numberOfDisparities,
//       disp12MaxDisp,
//       ffi.nullptr,
//     ),
//   );
// }

// constants
const int PROJ_SPHERICAL_ORTHO = 0;
const int PROJ_SPHERICAL_EQRECT = 1;

/// Pose refinement using non-linear Levenberg-Marquardt minimization scheme @cite Madsen04 @cite Eade13 \n
/// Initial solution for non-planar "objectPoints" needs at least 6 points and uses the DLT algorithm. \n
/// Initial solution for planar "objectPoints" needs at least 4 points and uses pose from homography decomposition.
const int SOLVEPNP_ITERATIVE = 0;

/// EPnP: Efficient Perspective-n-Point Camera Pose Estimation @cite lepetit2009epnp
const int SOLVEPNP_EPNP = 1;

/// Complete Solution Classification for the Perspective-Three-Point Problem @cite gao2003complete
const int SOLVEPNP_P3P = 2;

/// **Broken implementation. Using this flag will fallback to EPnP.** \n
/// A Direct Least-Squares (DLS) Method for PnP @cite hesch2011direct
const int SOLVEPNP_DLS = 3;

/// **Broken implementation. Using this flag will fallback to EPnP.** \n
/// Exhaustive Linearization for Robust Camera Pose and Focal Length Estimation @cite penate2013exhaustive
const int SOLVEPNP_UPNP = 4;

/// An Efficient Algebraic Solution to the Perspective-Three-Point Problem @cite Ke17
const int SOLVEPNP_AP3P = 5;

/// Infinitesimal Plane-Based Pose Estimation @cite Collins14 \n
///Object points must be coplanar.
const int SOLVEPNP_IPPE = 6;

/// Infinitesimal Plane-Based Pose Estimation @cite Collins14 \n
/// This is a special case suitable for marker pose estimation.\n
/// 4 coplanar object points must be defined in the following order:
///  - point 0: [-squareLength / 2,  squareLength / 2, 0]
///  - point 1: [ squareLength / 2,  squareLength / 2, 0]
///  - point 2: [ squareLength / 2, -squareLength / 2, 0]
///  - point 3: [-squareLength / 2, -squareLength / 2, 0]
const int SOLVEPNP_IPPE_SQUARE = 7;

/// SQPnP: A Consistently Fast and Globally OptimalSolution to the Perspective-n-Point Problem @cite Terzakis2020SQPnP
const int SOLVEPNP_SQPNP = 8;

// the algorithm for finding fundamental matrix
/// 7-point algorithm
const int FM_7POINT = 1;

/// 8-point algorithm
const int FM_8POINT = 2;

/// least-median algorithm. 7-point algorithm is used.
const int FM_LMEDS = 4;

/// RANSAC algorithm. It needs at least 15 points. 7-point algorithm is used.
const int FM_RANSAC = 8;
