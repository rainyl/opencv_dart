/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ASYNC_CALIB3D_H
#define CVD_ASYNC_CALIB3D_H

#include "core/types.h"
#ifdef __cplusplus
extern "C" {
#endif
CvStatus *Fisheye_UndistortImage(Mat distorted, Mat k, Mat d, CVD_OUT CvCallback_1 callback);
CvStatus *Fisheye_UndistortImageWithParams(Mat distorted, Mat k, Mat d, Mat knew, Size size,
                                           CVD_OUT CvCallback_1 callback);
CvStatus *Fisheye_UndistortPoints(Mat distorted, Mat k, Mat d, Mat R, Mat P, CVD_OUT CvCallback_1 callback);
CvStatus *Fisheye_EstimateNewCameraMatrixForUndistortRectify(Mat k, Mat d, Size imgSize, Mat r,
                                                             double balance, Size newSize, double fovScale,
                                                             CVD_OUT CvCallback_1 p);

CvStatus *InitUndistortRectifyMap(Mat cameraMatrix, Mat distCoeffs, Mat r, Mat newCameraMatrix, Size size,
                                  int m1type, CVD_OUT CvCallback_2 callback);
CvStatus *GetOptimalNewCameraMatrixWithParams(Mat cameraMatrix, Mat distCoeffs, Size size, double alpha,
                                              Size newImgSize, bool centerPrincipalPoint,
                                              CVD_OUT CvCallback_2 callback);
CvStatus *CalibrateCamera(VecVecPoint3f objectPoints, VecVecPoint2f imagePoints, Size imageSize, int flag,
                          TermCriteria criteria, CVD_OUT CvCallback_5 callback);
CvStatus *Undistort(Mat src, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix,
                    CVD_OUT CvCallback_1 callback);
CvStatus *UndistortPoints(Mat distorted, Mat k, Mat d, Mat r, Mat p, TermCriteria criteria,
                          CVD_OUT CvCallback_1 callback);
CvStatus *FindChessboardCorners(Mat image, Size patternSize, int flags, CVD_OUT CvCallback_2 callback);
CvStatus *FindChessboardCornersSB(Mat image, Size patternSize, int flags);
CvStatus *FindChessboardCornersSBWithMeta(Mat image, Size patternSize, int flags, Mat meta,
                                          CVD_OUT CvCallback_2 callback);
CvStatus *DrawChessboardCorners(Mat image, Size patternSize, bool patternWasFound,
                                CVD_OUT CvCallback_2 callback);
CvStatus *EstimateAffinePartial2D(VecPoint2f from, VecPoint2f to, CVD_OUT CvCallback_1 callback);
CvStatus *EstimateAffinePartial2DWithParams(VecPoint2f from, VecPoint2f to, Mat inliers, int method,
                                            double ransacReprojThreshold, size_t maxIters, double confidence,
                                            size_t refineIters, CVD_OUT CvCallback_1 callback);
CvStatus *EstimateAffine2D(VecPoint2f from, VecPoint2f to, CVD_OUT CvCallback_1 callback);
CvStatus *EstimateAffine2DWithParams(VecPoint2f from, VecPoint2f to, Mat inliers, int method,
                                     double ransacReprojThreshold, size_t maxIters, double confidence,
                                     size_t refineIters, CVD_OUT CvCallback_1 callback);
#ifdef __cplusplus
}
#endif
#endif // CVD_ASYNC_CALIB3D_H
