/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_CALIB_H_
#define _OPENCV3_CALIB_H_

#ifdef __cplusplus
#include <opencv2/calib3d.hpp>
#include <opencv2/opencv.hpp>

extern "C" {
#endif

#include "core/core.h"
#include <stddef.h>
// Calib
CvStatus *Fisheye_UndistortImage(Mat distorted, Mat undistorted, Mat k, Mat d);
CvStatus *Fisheye_UndistortImageWithParams(
    Mat distorted, Mat *undistorted, Mat k, Mat d, Mat knew, Size size
);
CvStatus *Fisheye_UndistortPoints(Mat distorted, Mat undistorted, Mat k, Mat d, Mat R, Mat P);
CvStatus *Fisheye_EstimateNewCameraMatrixForUndistortRectify(
    Mat k, Mat d, Size imgSize, Mat r, Mat p, double balance, Size newSize, double fovScale
);

CvStatus *InitUndistortRectifyMap(
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat r,
    Mat newCameraMatrix,
    Size size,
    int m1type,
    Mat *map1,
    Mat *map2
);
CvStatus *GetOptimalNewCameraMatrixWithParams(
    Mat cameraMatrix,
    Mat distCoeffs,
    Size size,
    double alpha,
    Size newImgSize,
    Rect *validPixROI,
    bool centerPrincipalPoint,
    Mat *rval
);
CvStatus *CalibrateCamera(
    VecVecPoint3f objectPoints,
    VecVecPoint2f imagePoints,
    Size imageSize,
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat rvecs,
    Mat tvecs,
    int flag,
    TermCriteria criteria,
    double *rval
);
CvStatus *Undistort(Mat src, Mat dst, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix);
CvStatus *
UndistortPoints(Mat distorted, Mat undistorted, Mat k, Mat d, Mat r, Mat p, TermCriteria criteria);
CvStatus *FindChessboardCorners(Mat image, Size patternSize, Mat corners, int flags, bool *rval);
CvStatus *FindChessboardCornersSB(Mat image, Size patternSize, Mat corners, int flags, bool *rval);
CvStatus *FindChessboardCornersSBWithMeta(
    Mat image, Size patternSize, Mat corners, int flags, Mat meta, bool *rval
);
CvStatus *DrawChessboardCorners(Mat image, Size patternSize, Mat corners, bool patternWasFound);
CvStatus *EstimateAffinePartial2D(VecPoint2f from, VecPoint2f to, Mat *rval);
CvStatus *EstimateAffinePartial2DWithParams(
    VecPoint2f from,
    VecPoint2f to,
    Mat inliers,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    Mat *rval
);
CvStatus *EstimateAffine2D(VecPoint2f from, VecPoint2f to, Mat *rval);
CvStatus *EstimateAffine2DWithParams(
    VecPoint2f from,
    VecPoint2f to,
    Mat inliers,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    Mat *rval
);
CvStatus *FindHomography(
    Mat src,
    Mat dst,
    int method,
    double ransacReprojThreshold,
    Mat mask,
    const int maxIters,
    const double confidence,
    Mat *rval
);
#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_CALIB_H
