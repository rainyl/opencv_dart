/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ASYNC_CALIB3D_H
#define CVD_ASYNC_CALIB3D_H

#include "core/types.h"
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif
// fisheye
// // Performs camera calibration.
// CvStatus *fisheye_calibrate(VecVecPoint2f objectPoints, VecVecPoint2f
// imagePoints, const Size image_size,
//                             InputOutputArray K, InputOutputArray D, int
//                             flags, TermCriteria criteria, CvCallback_3
//                             callback);

// // Distorts 2D points using fisheye model.
// CvStatus *fisheye_distortPoints(InputArray undistorted, OutputArray
// distorted, InputArray K, InputArray D,
//                                 double alpha = 0);

// // Estimates new camera intrinsic matrix for undistortion or rectification.
// CvStatus *fisheye_estimateNewCameraMatrixForUndistortRectify(InputArray K,
// InputArray D,
//                                                              const Size
//                                                              &image_size,
//                                                              InputArray R,
//                                                              OutputArray P,
//                                                              double balance =
//                                                              0.0, const Size
//                                                              &new_size =
//                                                              Size(), double
//                                                              fov_scale
//                                                              = 1.0);

// // Computes undistortion and rectification maps for image transform by remap.
// If D is empty zero
// // distortion is used, if R or P is empty identity matrixes are used.
// CvStatus *fisheye_initUndistortRectifyMap(InputArray K, InputArray D,
// InputArray R, InputArray P,
//                                           const Size &size, int m1type,
//                                           OutputArray map1, OutputArray
//                                           map2);

// // Projects points using fisheye model.
// CvStatus *fisheye_projectPoints(InputArray objectPoints, OutputArray
// imagePoints, const Affine3d &affine,
//                                 InputArray K, InputArray D, double alpha = 0,
//                                 OutputArray jacobian = noArray());

// CvStatus *fisheye_projectPoints(InputArray objectPoints, OutputArray
// imagePoints, InputArray rvec,
//                                 InputArray tvec, InputArray K, InputArray D,
//                                 double alpha = 0, OutputArray jacobian =
//                                 noArray());

// // Finds an object pose from 3D-2D point correspondences for fisheye camera
// moodel. bool fisheye_solvePnP(InputArray objectPoints, InputArray
// imagePoints, InputArray cameraMatrix,
//                       InputArray distCoeffs, OutputArray rvec, OutputArray
//                       tvec, bool useExtrinsicGuess = false, int flags =
//                       SOLVEPNP_ITERATIVE, TermCriteria criteria =
//                       TermCriteria(TermCriteria_MAX_ITER + TermCriteria_EPS,
//                       10,
//                                                            1e-8));

// // This is an overloaded member function, provided for convenience. It
// differs from the above function
// // only in what argument(s) it accepts.
// double fisheye_stereoCalibrate(InputArrayOfArrays objectPoints,
// InputArrayOfArrays imagePoints1,
//                                InputArrayOfArrays imagePoints2,
//                                InputOutputArray K1, InputOutputArray D1,
//                                InputOutputArray K2, InputOutputArray D2, Size
//                                imageSize, OutputArray R, OutputArray T, int
//                                flags = fisheye_CALIB_FIX_INTRINSIC,
//                                TermCriteria criteria =
//                                TermCriteria(TermCriteria_COUNT +
//                                TermCriteria_EPS,
//                                                                     100,
//                                                                     DBL_EPSILON));

// // Performs stereo calibration.
// double fisheye_stereoCalibrate(InputArrayOfArrays objectPoints,
// InputArrayOfArrays imagePoints1,
//                                InputArrayOfArrays imagePoints2,
//                                InputOutputArray K1, InputOutputArray D1,
//                                InputOutputArray K2, InputOutputArray D2, Size
//                                imageSize, OutputArray R, OutputArray T,
//                                OutputArrayOfArrays rvecs, OutputArrayOfArrays
//                                tvecs, int flags =
//                                fisheye_CALIB_FIX_INTRINSIC, TermCriteria
//                                criteria = TermCriteria(TermCriteria_COUNT +
//                                TermCriteria_EPS,
//                                                                     100,
//                                                                     DBL_EPSILON));

// // Stereo rectification for fisheye camera model.
// CvStatus *fisheye_stereoRectify(InputArray K1, InputArray D1, InputArray K2,
// InputArray D2,
//                                 const Size &imageSize, InputArray R,
//                                 InputArray tvec, OutputArray R1, OutputArray
//                                 R2, OutputArray P1, OutputArray P2,
//                                 OutputArray Q, int flags, const Size
//                                 &newImageSize = Size(), double balance = 0.0,
//                                 double fov_scale = 1.0);

// // Transforms an image to compensate for fisheye lens distortion.
// CvStatus *fisheye_undistortImage(InputArray distorted, OutputArray
// undistorted, InputArray K, InputArray D,
//                                  InputArray Knew = noArray(), const Size
//                                  &new_size = Size());

// // Undistorts 2D points using fisheye model.
// CvStatus *fisheye_undistortPoints(
//     InputArray distorted, OutputArray undistorted, InputArray K, InputArray
//     D, InputArray R = noArray(), InputArray P = noArray(), TermCriteria
//     criteria = TermCriteria(TermCriteria_MAX_ITER + TermCriteria_EPS, 10,
//     1e-8));

CvStatus *fisheye_undistortImage_Async(Mat distorted, Mat k, Mat d, CVD_OUT CvCallback_1 callback);
CvStatus *fisheye_undistortImageWithParams_Async(
    Mat distorted, Mat k, Mat d, Mat knew, Size size, CVD_OUT CvCallback_1 callback
);
CvStatus *fisheye_undistortPoints_Async(
    Mat distorted, Mat k, Mat d, Mat R, Mat P, CVD_OUT CvCallback_1 callback
);
CvStatus *fisheye_estimateNewCameraMatrixForUndistortRectify_Async(
    Mat k,
    Mat d,
    Size imgSize,
    Mat r,
    double balance,
    Size newSize,
    double fovScale,
    CVD_OUT CvCallback_1 p
);

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
);
CvStatus *drawChessboardCorners_Async(
    Mat image, Size patternSize, bool patternWasFound, CVD_OUT CvCallback_0 callback
);
CvStatus *estimateAffinePartial2D_Async(VecPoint2f from, VecPoint2f to, CvCallback_1 callback);
CvStatus *estimateAffinePartial2DWithParams_Async(
    VecPoint2f from,
    VecPoint2f to,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    CVD_OUT CvCallback_2 callback
);
CvStatus *estimateAffine2D_Async(VecPoint2f from, VecPoint2f to, CVD_OUT CvCallback_1 callback);
CvStatus *estimateAffine2DWithParams_Async(
    VecPoint2f from,
    VecPoint2f to,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    CVD_OUT CvCallback_2 callback
);
CvStatus *
findChessboardCorners_Async(Mat image, Size patternSize, int flags, CvCallback_2 callback);
CvStatus *
findChessboardCornersSB_Async(Mat image, Size patternSize, int flags, CvCallback_2 callback);
CvStatus *findChessboardCornersSBWithMeta_Async(
    Mat image, Size patternSize, int flags, CVD_OUT CvCallback_3 callback
);
CvStatus *getOptimalNewCameraMatrix_Async(
    Mat cameraMatrix,
    Mat distCoeffs,
    Size size,
    double alpha,
    Size newImgSize,
    bool centerPrincipalPoint,
    CVD_OUT CvCallback_2 callback
);
CvStatus *initUndistortRectifyMap_Async(
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat r,
    Mat newCameraMatrix,
    Size size,
    int m1type,
    CVD_OUT CvCallback_2 callback
);

CvStatus *undistort_Async(
    Mat src, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix, CVD_OUT CvCallback_1 callback
);
CvStatus *undistortPoints_Async(
    Mat distorted, Mat k, Mat d, Mat r, Mat p, TermCriteria criteria, CVD_OUT CvCallback_1 callback
);

CvStatus *FindHomography_Async(
    Mat src,
    Mat dst,
    int method,
    double ransacReprojThreshold,
    const int maxIters,
    const double confidence,
    CvCallback_2 callback
);

#ifdef __cplusplus
}
#endif
#endif // CVD_ASYNC_CALIB3D_H
