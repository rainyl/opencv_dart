/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "calib3d.h"

CvStatus Fisheye_UndistortImage(Mat distorted, Mat undistorted, Mat k, Mat d)
{
  BEGIN_WRAP
  cv::fisheye::undistortImage(*distorted.ptr, *undistorted.ptr, *k.ptr, *d.ptr);
  END_WRAP
}

CvStatus Fisheye_UndistortImageWithParams(Mat distorted, Mat undistorted, Mat k, Mat d, Mat knew, Size size)
{
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::fisheye::undistortImage(*distorted.ptr, *undistorted.ptr, *k.ptr, *d.ptr, *knew.ptr, sz);
  END_WRAP
}

CvStatus Fisheye_UndistortPoints(Mat distorted, Mat undistorted, Mat k, Mat d, Mat r, Mat p)
{
  BEGIN_WRAP
  cv::fisheye::undistortPoints(*distorted.ptr, *undistorted.ptr, *k.ptr, *d.ptr, *r.ptr, *p.ptr);
  END_WRAP
}

CvStatus Fisheye_EstimateNewCameraMatrixForUndistortRectify(Mat k, Mat d, Size imgSize, Mat r, Mat p, double balance, Size newSize, double fovScale)
{
  BEGIN_WRAP
  cv::Size newSz(newSize.width, newSize.height);
  cv::Size imgSz(imgSize.width, imgSize.height);
  cv::fisheye::estimateNewCameraMatrixForUndistortRectify(*k.ptr, *d.ptr, imgSz, *r.ptr, *p.ptr, balance, newSz, fovScale);
  END_WRAP
}

CvStatus InitUndistortRectifyMap(Mat cameraMatrix, Mat distCoeffs, Mat r, Mat newCameraMatrix, Size size, int m1type, Mat map1, Mat map2)
{
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::initUndistortRectifyMap(*cameraMatrix.ptr, *distCoeffs.ptr, *r.ptr, *newCameraMatrix.ptr, sz, m1type, *map1.ptr, *map2.ptr);
  END_WRAP
}

CvStatus GetOptimalNewCameraMatrixWithParams(Mat cameraMatrix, Mat distCoeffs, Size size, double alpha, Size newImgSize, Rect *validPixROI, bool centerPrincipalPoint, Mat *rval)
{
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::Size newSize(newImgSize.width, newImgSize.height);
  cv::Rect rect(validPixROI->x, validPixROI->y, validPixROI->width, validPixROI->height);
  cv::Mat *mat = new cv::Mat(
      cv::getOptimalNewCameraMatrix(*cameraMatrix.ptr, *distCoeffs.ptr, sz, alpha, newSize, &rect, centerPrincipalPoint));
  validPixROI->x = rect.x;
  validPixROI->y = rect.y;
  validPixROI->width = rect.width;
  validPixROI->height = rect.height;
  *rval = {mat};
  END_WRAP
}

CvStatus CalibrateCamera(VecVecPoint3f objectPoints, VecVecPoint2f imagePoints, Size imageSize, Mat cameraMatrix, Mat distCoeffs, Mat rvecs, Mat tvecs, int flag, TermCriteria criteria, double *rval)
{
  BEGIN_WRAP
  *rval = cv::calibrateCamera(*objectPoints.ptr, *imagePoints.ptr, cv::Size(imageSize.width, imageSize.height), *cameraMatrix.ptr, *distCoeffs.ptr, *rvecs.ptr, *tvecs.ptr, flag, *criteria.ptr);
  END_WRAP
}

CvStatus Undistort(Mat src, Mat dst, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix)
{
  BEGIN_WRAP
  cv::undistort(*src.ptr, *dst.ptr, *cameraMatrix.ptr, *distCoeffs.ptr, *newCameraMatrix.ptr);
  END_WRAP
}

CvStatus UndistortPoints(Mat distorted, Mat undistorted, Mat k, Mat d, Mat r, Mat p)
{
  BEGIN_WRAP
  cv::undistortPoints(*distorted.ptr, *undistorted.ptr, *k.ptr, *d.ptr, *r.ptr, *p.ptr);
  END_WRAP
}

CvStatus FindChessboardCorners(Mat image, Size patternSize, Mat corners, int flags, bool *rval)
{
  BEGIN_WRAP
  cv::Size sz(patternSize.width, patternSize.height);
  *rval = cv::findChessboardCorners(*image.ptr, sz, *corners.ptr, flags);
  END_WRAP
}

CvStatus FindChessboardCornersSB(Mat image, Size patternSize, Mat corners, int flags, bool *rval)
{
  BEGIN_WRAP
  cv::Size sz(patternSize.width, patternSize.height);
  *rval = cv::findChessboardCornersSB(*image.ptr, sz, *corners.ptr, flags);
  END_WRAP
}

CvStatus FindChessboardCornersSBWithMeta(Mat image, Size patternSize, Mat corners, int flags, Mat meta, bool *rval)
{
  BEGIN_WRAP
  cv::Size sz(patternSize.width, patternSize.height);
  *rval = cv::findChessboardCornersSB(*image.ptr, sz, *corners.ptr, flags, *meta.ptr);
  END_WRAP
}

CvStatus DrawChessboardCorners(Mat image, Size patternSize, Mat corners, bool patternWasFound)
{
  BEGIN_WRAP
  cv::Size sz(patternSize.width, patternSize.height);
  cv::drawChessboardCorners(*image.ptr, sz, *corners.ptr, patternWasFound);
  END_WRAP
}

CvStatus EstimateAffinePartial2D(VecPoint2f from, VecPoint2f to, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::estimateAffinePartial2D(*from.ptr, *to.ptr))};
  END_WRAP
}

CvStatus EstimateAffinePartial2DWithParams(VecPoint2f from, VecPoint2f to, Mat inliers, int method, double ransacReprojThreshold, size_t maxIters, double confidence, size_t refineIters, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::estimateAffinePartial2D(*from.ptr, *to.ptr, *inliers.ptr, method, ransacReprojThreshold, maxIters, confidence, refineIters))};
  END_WRAP
}

CvStatus EstimateAffine2D(VecPoint2f from, VecPoint2f to, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::estimateAffine2D(*from.ptr, *to.ptr))};
  END_WRAP
}

CvStatus EstimateAffine2DWithParams(VecPoint2f from, VecPoint2f to, Mat inliers, int method, double ransacReprojThreshold, size_t maxIters, double confidence, size_t refineIters, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::estimateAffine2D(*from.ptr, *to.ptr, *inliers.ptr, method, ransacReprojThreshold, maxIters, confidence, refineIters))};
  END_WRAP
}
