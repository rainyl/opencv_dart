#include "calib3d_async.h"
#include "core/types.h"
#include "core/vec.hpp"
#include <opencv2/calib3d.hpp>

CvStatus *fisheye_undistortImage_Async(Mat distorted, Mat k, Mat d, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::fisheye::undistortImage(*distorted.ptr, dst, *k.ptr, *d.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *fisheye_undistortImageWithParams_Async(
    Mat distorted, Mat k, Mat d, Mat knew, Size size, CVD_OUT CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::fisheye::undistortImage(
      *distorted.ptr, dst, *k.ptr, *d.ptr, *knew.ptr, cv::Size(size.width, size.height)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *fisheye_undistortPoints_Async(
    Mat distorted, Mat k, Mat d, Mat R, Mat P, CVD_OUT CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::fisheye::undistortPoints(*distorted.ptr, dst, *k.ptr, *d.ptr, *R.ptr, *P.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *fisheye_estimateNewCameraMatrixForUndistortRectify_Async(
    Mat k,
    Mat d,
    Size imgSize,
    Mat r,
    double balance,
    Size newSize,
    double fovScale,
    CVD_OUT CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::fisheye::estimateNewCameraMatrixForUndistortRectify(
      *k.ptr,
      *d.ptr,
      cv::Size(imgSize.width, imgSize.height),
      *r.ptr,
      dst,
      balance,
      cv::Size(newSize.width, newSize.height),
      fovScale
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

// calib3d
CvStatus *calibrateCamera_Async(
    VecVecPoint3f objectPoints,
    VecVecPoint2f imagePoints,
    Size imageSize,
    Mat cameraMatrix,
    Mat distCoeffs,
    int flag,
    TermCriteria criteria,
    CVD_OUT CvCallback_3 callback
) {
  BEGIN_WRAP
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  cv::Mat rvecs;
  cv::Mat tvecs;
  auto _objectPoints = vecvecpoint3f_c2cpp(objectPoints);
  auto _imagePoints = vecvecpoint2f_c2cpp(imagePoints);
  auto rval = cv::calibrateCamera(
      _objectPoints,
      _imagePoints,
      cv::Size(imageSize.width, imageSize.height),
      *cameraMatrix.ptr,
      *distCoeffs.ptr,
      rvecs,
      tvecs,
      flag,
      tc
  );
  callback(new double(rval), new Mat{new cv::Mat(rvecs)}, new Mat{new cv::Mat(tvecs)});
  END_WRAP
}
CvStatus *drawChessboardCorners_Async(
    Mat image, Size patternSize, bool patternWasFound, CVD_OUT CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::drawChessboardCorners(
      *image.ptr, cv::Size(patternSize.width, patternSize.height), dst, patternWasFound
  );
  callback();
  END_WRAP
}
CvStatus *estimateAffinePartial2D_Async(VecPoint2f from, VecPoint2f to, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  auto _from = vecpoint2f_c2cpp(from);
  auto _to = vecpoint2f_c2cpp(to);
  cv::estimateAffinePartial2D(_from, _to, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *estimateAffinePartial2DWithParams_Async(
    VecPoint2f from,
    VecPoint2f to,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    CVD_OUT CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat inliers;
  auto _from = vecpoint2f_c2cpp(from);
  auto _to = vecpoint2f_c2cpp(to);
  cv::Mat dst = cv::estimateAffinePartial2D(
      _from, _to, inliers, method, ransacReprojThreshold, maxIters, confidence, refineIters
  );
  callback(new Mat{new cv::Mat(dst)}, new Mat{new cv::Mat(inliers)});
  END_WRAP
}
CvStatus *estimateAffine2D_Async(VecPoint2f from, VecPoint2f to, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  auto _from = vecpoint2f_c2cpp(from);
  auto _to = vecpoint2f_c2cpp(to);
  cv::estimateAffine2D(_from, _to, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *estimateAffine2DWithParams_Async(
    VecPoint2f from,
    VecPoint2f to,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    CVD_OUT CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat inliers;
  auto _from = vecpoint2f_c2cpp(from);
  auto _to = vecpoint2f_c2cpp(to);
  cv::Mat dst = cv::estimateAffine2D(
      _from, _to, inliers, method, ransacReprojThreshold, maxIters, confidence, refineIters
  );
  callback(new Mat{new cv::Mat(dst)}, new Mat{new cv::Mat(inliers)});
  END_WRAP
}
CvStatus *
findChessboardCorners_Async(Mat image, Size patternSize, int flags, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Mat dst2;
  auto rval = cv::findChessboardCorners(
      *image.ptr, cv::Size(patternSize.width, patternSize.height), dst, flags
  );
  callback(new bool(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *
findChessboardCornersSB_Async(Mat image, Size patternSize, int flags, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Mat dst2;
  auto rval = cv::findChessboardCornersSB(
      *image.ptr, cv::Size(patternSize.width, patternSize.height), dst, flags
  );
  callback(new bool(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *findChessboardCornersSBWithMeta_Async(
    Mat image, Size patternSize, int flags, CVD_OUT CvCallback_3 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Mat dst2;
  auto rval = cv::findChessboardCornersSB(
      *image.ptr, cv::Size(patternSize.width, patternSize.height), dst, flags, dst2
  );
  callback(new bool(rval), new Mat{new cv::Mat(dst)}, new Mat{new cv::Mat(dst2)});
  END_WRAP
}
CvStatus *getOptimalNewCameraMatrix_Async(
    Mat cameraMatrix,
    Mat distCoeffs,
    Size size,
    double alpha,
    Size newImgSize,
    bool centerPrincipalPoint,
    CVD_OUT CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Rect dst;
  auto rval = cv::getOptimalNewCameraMatrix(
      *cameraMatrix.ptr,
      *distCoeffs.ptr,
      cv::Size(size.width, size.height),
      alpha,
      cv::Size(newImgSize.width, newImgSize.height),
      &dst,
      centerPrincipalPoint
  );
  callback(new Mat{new cv::Mat(rval)}, new Rect{dst.x, dst.y, dst.width, dst.height});
  END_WRAP
}
CvStatus *initUndistortRectifyMap_Async(
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat r,
    Mat newCameraMatrix,
    Size size,
    int m1type,
    CVD_OUT CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat dst1;
  cv::Mat dst2;
  cv::initUndistortRectifyMap(
      *cameraMatrix.ptr,
      *distCoeffs.ptr,
      *r.ptr,
      *newCameraMatrix.ptr,
      cv::Size(size.width, size.height),
      m1type,
      dst1,
      dst2
  );
  callback(new Mat{new cv::Mat(dst1)}, new Mat{new cv::Mat(dst2)});
  END_WRAP
}

CvStatus *undistort_Async(
    Mat src, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix, CVD_OUT CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::undistort(*src.ptr, dst, *cameraMatrix.ptr, *distCoeffs.ptr, *newCameraMatrix.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *undistortPoints_Async(
    Mat distorted, Mat k, Mat d, Mat r, Mat p, TermCriteria criteria, CVD_OUT CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::undistortPoints(
      *distorted.ptr,
      dst,
      *k.ptr,
      *d.ptr,
      *r.ptr,
      *p.ptr,
      cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *FindHomography_Async(
    Mat src,
    Mat dst,
    int method,
    double ransacReprojThreshold,
    const int maxIters,
    const double confidence,
    CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat mask;
  cv::Mat out = cv::findHomography(
      *src.ptr, *dst.ptr, method, ransacReprojThreshold, mask, maxIters, confidence
  );
  callback(new Mat{new cv::Mat(out)}, new Mat{new cv::Mat(mask)});
  END_WRAP
}
