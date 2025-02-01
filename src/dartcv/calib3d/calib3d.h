/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_CALIB_H_
#define CVD_CALIB_H_

#ifdef __cplusplus
#include <opencv2/calib3d.hpp>

extern "C" {
#endif
#include "dartcv/core/types.h"
#include <stddef.h>

//  Performs camera calibration.
// double  cv::fisheye::calibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints, const Size &image_size, InputOutputArray K, InputOutputArray D, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, int flags=0, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 100, DBL_EPSILON))
CvStatus *cv_fisheye_calibrate(
    VecMat objectPoints,
    VecMat imagePoints,
    CvSize imageSize,
    MatInOut k,
    MatInOut d,
    VecMat rvecs,
    VecMat tvecs,
    int flags,
    TermCriteria criteria,
    double *rval,
    CvCallback_0 callback
);

//  Distorts 2D points using fisheye model.
// void cv::fisheye::distortPoints (InputArray undistorted, OutputArray distorted, InputArray K, InputArray D, double alpha=0)
CvStatus *cv_fisheye_distortPoints(
    MatIn undistorted, MatOut distorted, MatIn K, MatIn D, double alpha, CvCallback_0 callback
);

// void cv::fisheye::distortPoints (InputArray undistorted, OutputArray distorted, InputArray Kundistorted, InputArray K, InputArray D, double alpha=0)
CvStatus *cv_fisheye_distortPoints_1(
    MatIn undistorted, MatOut distorted, MatInOut Kundistorted, MatIn K, MatIn D, double alpha, CvCallback_0 callback
);

// Estimates new camera intrinsic matrix for undistortion or rectification.
// void  cv::fisheye::estimateNewCameraMatrixForUndistortRectify (InputArray K, InputArray D, const Size &image_size, InputArray R, OutputArray P, double balance=0.0, const Size &new_size=Size(), double fov_scale=1.0)
CvStatus *cv_fisheye_estimateNewCameraMatrixForUndistortRectify(
    MatIn k,
    MatIn d,
    CvSize imgSize,
    MatIn r,
    MatOut p,
    double balance,
    CvSize newSize,
    double fovScale,
    CvCallback_0 callback
);

//  Computes undistortion and rectification maps for image transform by remap. If D is empty zero distortion is used, if R or P is empty identity matrixes are used.
// void  cv::fisheye::initUndistortRectifyMap (InputArray K, InputArray D, InputArray R, InputArray P, const cv::Size &size, int m1type, OutputArray map1, OutputArray map2)
CvStatus *cv_fisheye_initUndistortRectifyMap(
    MatIn k,
    MatIn d,
    MatIn r,
    MatIn p,
    CvSize imgSize,
    int m1type,
    MatOut map1,
    MatOut map2,
    CvCallback_0 callback
);

//  Projects points using fisheye model.
// void  cv::fisheye::projectPoints (InputArray objectPoints, OutputArray imagePoints, const Affine3d &affine, InputArray K, InputArray D, double alpha=0, OutputArray jacobian=noArray())
// void  cv::fisheye::projectPoints (InputArray objectPoints, OutputArray imagePoints, InputArray rvec, InputArray tvec, InputArray K, InputArray D, double alpha=0, OutputArray jacobian=noArray())
CvStatus *cv_fisheye_projectPoints(
    MatIn objectPoints, MatOut imagePoints, MatIn rvec, MatIn tvec, MatIn k, MatIn d, double alpha, MatOut jacobian,
    CvCallback_0 callback
);

//  Finds an object pose from 3D-2D point correspondences for fisheye camera moodel.
// bool  cv::fisheye::solvePnP (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArray rvec, OutputArray tvec, bool useExtrinsicGuess=false, int flags=SOLVEPNP_ITERATIVE, TermCriteria criteria=TermCriteria(TermCriteria::MAX_ITER+TermCriteria::EPS, 10, 1e-8))
CvStatus *cv_fisheye_solvePnP(
    MatIn objectPoints, MatIn imagePoints, MatIn cameraMatrix, MatIn distCoeffs, MatOut rvec, MatOut tvec,
    bool useExtrinsicGuess, int flags, TermCriteria criteria, bool *rval, CvCallback_0 callback
);

//  This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
// double  cv::fisheye::stereoCalibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints1, InputArrayOfArrays imagePoints2, InputOutputArray K1, InputOutputArray D1, InputOutputArray K2, InputOutputArray D2, Size imageSize, OutputArray R, OutputArray T, int flags=fisheye::CALIB_FIX_INTRINSIC, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 100, DBL_EPSILON))
// CvStatus *cv_fisheye_stereoCalibrate(
//     VecMat objectPoints,
//     VecMat imagePoints1,
//     VecMat imagePoints2,
//     VecMat k1,
//     VecMat d1,
//     VecMat k2,
//     VecMat d2,
//     CvSize imgSize,
//     Mat r,
//     Mat t,
//     CvCallback_0 callback
// );

//  Performs stereo calibration.
// double  cv::fisheye::stereoCalibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints1, InputArrayOfArrays imagePoints2, InputOutputArray K1, InputOutputArray D1, InputOutputArray K2, InputOutputArray D2, Size imageSize, OutputArray R, OutputArray T, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, int flags=fisheye::CALIB_FIX_INTRINSIC, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 100, DBL_EPSILON))
// CvStatus *cv_fisheye_stereoCalibrate_1(
//     VecMat objectPoints,
//     VecMat imagePoints1,
//     VecMat imagePoints2,
//     VecMat k1,
//     VecMat d1,
//     VecMat k2,
//     VecMat d2,
//     CvSize imgSize,
//     Mat r,
//     Mat t,
//     VecMat rvecs,
//     VecMat tvecs,
//     CvCallback_0 callback
// );

//  Stereo rectification for fisheye camera model.
// void  cv::fisheye::stereoRectify (InputArray K1, InputArray D1, InputArray K2, InputArray D2, const Size &imageSize, InputArray R, InputArray tvec, OutputArray R1, OutputArray R2, OutputArray P1, OutputArray P2, OutputArray Q, int flags, const Size &newImageSize=Size(), double balance=0.0, double fov_scale=1.0)
// CvStatus *cv_fisheye_stereoRectify(
//     Mat k1,
//     Mat d1,
//     Mat k2,
//     Mat d2,
//     CvSize imgSize,
//     Mat r,
//     Mat t,
//     Mat r1,
//     Mat r2,
//     Mat p1,
//     Mat p2,
//     Mat q,
//     int flags,
//     CvSize newSize,
//     double balance,
//     double fovScale,
//     CvCallback_0 callback
// );

//  Transforms an image to compensate for fisheye lens distortion.
// void  cv::fisheye::undistortImage (InputArray distorted, OutputArray undistorted, InputArray K, InputArray D, InputArray Knew=cv::noArray(), const Size &new_size=Size())
CvStatus *cv_fisheye_undistortImage(
    Mat distorted, Mat undistorted, Mat k, Mat d, CvCallback_0 callback
);

CvStatus *cv_fisheye_undistortImage_1(
    Mat distorted, Mat undistorted, Mat k, Mat d, Mat knew, CvSize size, CvCallback_0 callback
);

// Undistorts 2D points using fisheye model.
// void  cv::fisheye::undistortPoints (InputArray distorted, OutputArray undistorted, InputArray K, InputArray D, InputArray R=noArray(), InputArray P=noArray(), TermCriteria criteria=TermCriteria(TermCriteria::MAX_ITER+TermCriteria::EPS, 10, 1e-8))
CvStatus *cv_fisheye_undistortPoints(
    Mat distorted, Mat undistorted, Mat k, Mat d, Mat R, Mat P, CvCallback_0 callback
);


CvStatus *cv_calibrateCamera(
    VecVecPoint3f objectPoints,
    VecVecPoint2f imagePoints,
    CvSize imageSize,
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat rvecs,
    Mat tvecs,
    int flag,
    TermCriteria criteria,
    double *rval,
    CvCallback_0 callback
);


// Finds the camera intrinsic and extrinsic parameters from several views of a calibration pattern.
// double cv::calibrateCameraRO (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints, Size imageSize, int iFixedPoint, InputOutputArray cameraMatrix, InputOutputArray distCoeffs, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, OutputArray newObjPoints, OutputArray stdDeviationsIntrinsics, OutputArray stdDeviationsExtrinsics, OutputArray stdDeviationsObjPoints, OutputArray perViewErrors, int flags=0, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 30, DBL_EPSILON));

// Computes Hand-Eye calibration:
// void cv::calibrateHandEye (InputArrayOfArrays R_gripper2base, InputArrayOfArrays t_gripper2base, InputArrayOfArrays R_target2cam, InputArrayOfArrays t_target2cam, OutputArray R_cam2gripper, OutputArray t_cam2gripper, HandEyeCalibrationMethod method=CALIB_HAND_EYE_TSAI);

// Computes Robot-World/Hand-Eye calibration:
// void cv::calibrateRobotWorldHandEye (InputArrayOfArrays R_world2cam, InputArrayOfArrays t_world2cam, InputArrayOfArrays R_base2gripper, InputArrayOfArrays t_base2gripper, OutputArray R_base2world, OutputArray t_base2world, OutputArray R_gripper2cam, OutputArray t_gripper2cam, RobotWorldHandEyeCalibrationMethod method=CALIB_ROBOT_WORLD_HAND_EYE_SHAH);

// Computes useful camera characteristics from the camera intrinsic matrix.
// void cv::calibrationMatrixValues (InputArray cameraMatrix, Size imageSize, double apertureWidth, double apertureHeight, double &fovx, double &fovy, double &focalLength, Point2d &principalPoint, double &aspectRatio);

bool cv_checkChessboard(Mat img, CvSize size);

// Combines two rotation-and-shift transformations.
// void cv::composeRT (InputArray rvec1, InputArray tvec1, InputArray rvec2, InputArray tvec2, OutputArray rvec3, OutputArray tvec3, OutputArray dr3dr1=noArray(), OutputArray dr3dt1=noArray(), OutputArray dr3dr2=noArray(), OutputArray dr3dt2=noArray(), OutputArray dt3dr1=noArray(), OutputArray dt3dt1=noArray(), OutputArray dt3dr2=noArray(), OutputArray dt3dt2=noArray());

// For points in an image of a stereo pair, computes the corresponding epilines in the other image.
// void cv::computeCorrespondEpilines (InputArray points, int whichImage, InputArray F, OutputArray lines);
CvStatus *cv_computeCorrespondEpilines(MatIn src, int whichImage, MatIn F, MatOut lines, CvCallback_0 callback);

// Converts points from homogeneous to Euclidean space.
// void cv::convertPointsFromHomogeneous (InputArray src, OutputArray dst);
CvStatus *cv_convertPointsFromHomogeneous(MatIn src, MatOut dst, CvCallback_0 callback);

// Converts points to/from homogeneous coordinates.
// void cv::convertPointsHomogeneous (InputArray src, OutputArray dst);
CvStatus *cv_convertPointsHomogeneous(MatIn src, MatOut dst, CvCallback_0 callback);

// Converts points from Euclidean to homogeneous space.
// void cv::convertPointsToHomogeneous (InputArray src, OutputArray dst);
CvStatus *cv_convertPointsToHomogeneous(MatIn src, MatOut dst, CvCallback_0 callback);

// Refines coordinates of corresponding points.
// void cv::correctMatches (InputArray F, InputArray points1, InputArray points2, OutputArray newPoints1, OutputArray newPoints2);
CvStatus *cv_correctMatches(MatIn F, MatIn points1, MatIn points2, MatOut newPoints1, MatOut newPoints2,
                            CvCallback_0 callback);

// Decompose an essential matrix to possible rotations and translation.
// void cv::decomposeEssentialMat (InputArray E, OutputArray R1, OutputArray R2, OutputArray t);
CvStatus *cv_decomposeEssentialMat(MatIn E, MatOut R1, MatOut R2, MatOut t, CvCallback_0 callback);

// Decompose a homography matrix to rotation(s), translation(s) and plane normal(s).
// int cv::decomposeHomographyMat (InputArray H, InputArray K, OutputArrayOfArrays rotations, OutputArrayOfArrays translations, OutputArrayOfArrays normals)
CvStatus *cv_decomposeHomographyMat(MatIn H, MatIn K, VecMat rotations, VecMat translations, VecMat normals, int *rval,
                                    CvCallback_0 callback);

// Decomposes a projection matrix into a rotation matrix and a camera intrinsic matrix.
// void cv::decomposeProjectionMatrix (InputArray projMatrix, OutputArray cameraMatrix, OutputArray rotMatrix, OutputArray transVect, OutputArray rotMatrixX=noArray(), OutputArray rotMatrixY=noArray(), OutputArray rotMatrixZ=noArray(), OutputArray eulerAngles=noArray())
CvStatus *cv_decomposeProjectionMatrix(MatIn projMatrix, MatOut cameraMatrix, MatOut rotMatrix, MatOut transVect,
                                       MatOut rotMatrixX, MatOut rotMatrixY, MatOut rotMatrixZ, MatOut eulerAngles,
                                       CvCallback_0 callback);

// Renders the detected chessboard corners.
// void cv::drawChessboardCorners (InputOutputArray image, Size patternSize, InputArray corners, bool patternWasFound)
CvStatus *cv_drawChessboardCorners(
    Mat image, CvSize patternSize, VecPoint2f corners, bool patternWasFound, CvCallback_0 callback
);


// Draw axes of the world/object coordinate system from pose estimation.
// void cv::drawFrameAxes (InputOutputArray image, InputArray cameraMatrix, InputArray distCoeffs, InputArray rvec, InputArray tvec, float length, int thickness=3)
CvStatus *cv_drawFrameAxes(
    MatInOut image,
    MatIn cameraMatrix,
    MatIn distCoeffs,
    MatIn rvec,
    MatIn tvec,
    float length,
    int thickness,
    CvCallback_0 callback
);

// Computes an optimal affine transformation between two 2D point sets.
CvStatus *cv_estimateAffine2D(VecPoint2f from, VecPoint2f to, Mat *rval, CvCallback_0 callback);

CvStatus *cv_estimateAffine2D_1(
    VecPoint2f from,
    VecPoint2f to,
    Mat inliers,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    Mat *rval,
    CvCallback_0 callback
);

// Computes an optimal affine transformation between two 3D point sets.
// cv::Mat cv::estimateAffine3D (InputArray src, InputArray dst, double *scale=nullptr, bool force_rotation=true)
CvStatus *cv_estimateAffine3D(
    Mat src,
    Mat dst,
    double *scale,
    bool force_rotation,
    Mat *rval,
    CvCallback_0 callback
);

// Computes an optimal affine transformation between two 3D point sets.
// int cv::estimateAffine3D (InputArray src, InputArray dst, OutputArray out, OutputArray inliers, double ransacThreshold=3, double confidence=0.99)
CvStatus *cv_estimateAffine3D_1(
    Mat src,
    Mat dst,
    CVD_OUT Mat out,
    CVD_OUT Mat inliers,
    double ransacThreshold,
    double confidence,
    int *rval,
    CvCallback_0 callback
);


// Computes an optimal limited affine transformation with 4 degrees of freedom between two 2D point sets.
// cv::Mat cv::estimateAffinePartial2D (InputArray from, InputArray to, OutputArray inliers=noArray(), int method=RANSAC, double ransacReprojThreshold=3, size_t maxIters=2000, double confidence=0.99, size_t refineIters=10)
CvStatus *cv_estimateAffinePartial2D(
    VecPoint2f from, VecPoint2f to, Mat *rval, CvCallback_0 callback
);

CvStatus *cv_estimateAffinePartial2D_1(
    VecPoint2f from,
    VecPoint2f to,
    Mat inliers,
    int method,
    double ransacReprojThreshold,
    size_t maxIters,
    double confidence,
    size_t refineIters,
    Mat *rval,
    CvCallback_0 callback
);

// Estimates the sharpness of a detected chessboard.
// Scalar cv::estimateChessboardSharpness (InputArray image, Size patternSize, InputArray corners, float rise_distance=0.8F, bool vertical=false, OutputArray sharpness=noArray())
CvStatus *cv_estimateChessboardSharpness(MatIn image, CvSize patternSize, MatIn corners, float rise_distance,
                                         bool vertical, MatOut sharpness, Scalar *rval, CvCallback_0 callback);

// Computes an optimal translation between two 3D point sets.
// int cv::estimateTranslation3D (InputArray src, InputArray dst, OutputArray out, OutputArray inliers, double ransacThreshold=3, double confidence=0.99)
CvStatus *cv_estimateTranslation3D(MatIn src, MatIn dst, MatOut out, MatOut inliers, double ransacThreshold,
                                   double confidence, int *rval, CvCallback_0 callback);

// Filters homography decompositions based on additional information.
// void cv::filterHomographyDecompByVisibleRefpoints (InputArrayOfArrays rotations, InputArrayOfArrays normals, InputArray beforePoints, InputArray afterPoints, OutputArray possibleSolutions, InputArray pointsMask=noArray())
CvStatus *cv_filterHomographyDecompByVisibleRefpoints(VecMat rotations, VecMat normals, MatIn beforePoints,
                                                      MatIn afterPoints, MatOut possibleSolutions, MatIn pointsMask,
                                                      CvCallback_0 callback);

// Filters off small noise blobs (speckles) in the disparity map.
// void cv::filterSpeckles (InputOutputArray img, double newVal, int maxSpeckleSize, double maxDiff, InputOutputArray buf=noArray())
CvStatus *cv_filterSpeckles(MatInOut img, double newVal, int maxSpeckleSize, double maxDiff, MatInOut buf,
                            CvCallback_0 callback);

// finds subpixel-accurate positions of the chessboard corners
// bool cv::find4QuadCornerSubpix (InputArray img, InputOutputArray corners, Size region_size)
CvStatus *cv_find4QuadCornerSubpix(MatIn img, MatInOut corners, CvSize region_size, bool *rval, CvCallback_0 callback);

// Finds the positions of internal corners of the chessboard.
// bool cv::findChessboardCorners (InputArray image, Size patternSize, OutputArray corners, int flags=CALIB_CB_ADAPTIVE_THRESH+CALIB_CB_NORMALIZE_IMAGE)
CvStatus *cv_findChessboardCorners(
    Mat image, CvSize patternSize, VecPoint2f *corners, int flags, bool *rval, CvCallback_0 callback
);

// Finds the positions of internal corners of the chessboard using a sector based approach.
// bool cv::findChessboardCornersSB (InputArray image, Size patternSize, OutputArray corners, int flags, OutputArray meta)
CvStatus *cv_findChessboardCornersSB(
    Mat image, CvSize patternSize, VecPoint2f *out_corners, int flags, bool *rval, CvCallback_0 callback
);

CvStatus *cv_findChessboardCornersSB_1(
    Mat image,
    CvSize patternSize,
    VecPoint2f *out_corners,
    int flags,
    Mat meta,
    bool *rval,
    CvCallback_0 callback
);

// Finds centers in the grid of circles.
// bool cv::findCirclesGrid (InputArray image, Size patternSize, OutputArray centers, int flags, const Ptr< FeatureDetector > &blobDetector, const CirclesGridFinderParameters &parameters)
// bool cv::findCirclesGrid (InputArray image, Size patternSize, OutputArray centers, int flags=CALIB_CB_SYMMETRIC_GRID, const Ptr< FeatureDetector > &blobDetector=SimpleBlobDetector::create())
CvStatus *cv_findCirclesGrid(MatIn image, CvSize patternSize, MatOut centers, int flags, bool *rval,
                             CvCallback_0 callback);

// Calculates an essential matrix from the corresponding points in two images.
// Mat cv::findEssentialMat (InputArray points1, InputArray points2, double focal, Point2d pp, int method, double prob, double threshold, OutputArray mask)
// Mat cv::findEssentialMat (InputArray points1, InputArray points2, double focal=1.0, Point2d pp=Point2d(0, 0), int method=RANSAC, double prob=0.999, double threshold=1.0, int maxIters=1000, OutputArray mask=noArray())
CvStatus *cv_findEssentialMat(MatIn points1, MatIn points2, double focal, CvPoint2d pp, int method, double prob,
                              double threshold, int maxIters, MatOut mask, Mat *rval, CvCallback_0 callback);

// Mat cv::findEssentialMat (InputArray points1, InputArray points2, InputArray cameraMatrix, int method, double prob, double threshold, OutputArray mask)
// Mat cv::findEssentialMat (InputArray points1, InputArray points2, InputArray cameraMatrix1, InputArray cameraMatrix2, InputArray dist_coeff1, InputArray dist_coeff2, OutputArray mask, const UsacParams &params)
// Mat cv::findEssentialMat (InputArray points1, InputArray points2, InputArray cameraMatrix, int method=RANSAC, double prob=0.999, double threshold=1.0, int maxIters=1000, OutputArray mask=noArray())
CvStatus *cv_findEssentialMat_1(MatIn points1, MatIn points2, MatIn cameraMatrix, int method, double prob,
                                double threshold, int maxIters, MatOut mask, Mat *rval, CvCallback_0 callback);

// Calculates an essential matrix from the corresponding points in two images from potentially two different cameras.
// Mat cv::findEssentialMat (InputArray points1, InputArray points2, InputArray cameraMatrix1, InputArray distCoeffs1, InputArray cameraMatrix2, InputArray distCoeffs2, int method=RANSAC, double prob=0.999, double threshold=1.0, OutputArray mask=noArray())


// Calculates a fundamental matrix from the corresponding points in two images.
// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, int method, double ransacReprojThreshold, double confidence, int maxIters, OutputArray mask=noArray())
// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, int method=FM_RANSAC, double ransacReprojThreshold=3., double confidence=0.99, OutputArray mask=noArray())
CvStatus *cv_findFundamentalMat(
    MatIn points1,
    MatIn points2,
    int method,
    double ransacReprojThreshold,
    double confidence,
    int maxIters,
    MatOut mask,
    Mat *rval,
    CvCallback_0 callback
);

// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, OutputArray mask, const UsacParams &params)
CvStatus *cv_findFundamentalMat_1(
    MatIn points1,
    MatIn points2,
    MatOut mask,
    UsacParams params,
    Mat *rval,
    CvCallback_0 callback
);

// Mat cv::findFundamentalMat (InputArray points1, InputArray points2, OutputArray mask, int method=FM_RANSAC, double ransacReprojThreshold=3., double confidence=0.99)
CvStatus *cv_findFundamentalMat_2(
    MatIn points1,
    MatIn points2,
    MatOut mask,
    int method,
    double ransacReprojThreshold,
    double confidence,
    Mat *rval,
    CvCallback_0 callback
);

// Finds a perspective transformation between two planes.
// Mat cv::findHomography (InputArray srcPoints, InputArray dstPoints, int method=0, double ransacReprojThreshold=3, OutputArray mask=noArray(), const int maxIters=2000, const double confidence=0.995)
CvStatus *cv_findHomography(
    Mat src,
    Mat dst,
    int method,
    double ransacReprojThreshold,
    MatOut mask,
    int maxIters,
    double confidence,
    Mat *rval,
    CvCallback_0 callback
);

// Mat cv::findHomography (InputArray srcPoints, InputArray dstPoints, OutputArray mask, int method=0, double ransacReprojThreshold=3)
// Mat cv::findHomography (InputArray srcPoints, InputArray dstPoints, OutputArray mask, const UsacParams &params)
CvStatus *cv_findHomography_1(MatIn srcPoints, MatIn dstPoints, MatOut mask, UsacParams params, Mat *rval,
                              CvCallback_0 callback);


// Returns the default new camera matrix.
// Mat cv::getDefaultNewCameraMatrix (InputArray cameraMatrix, Size imgsize=Size(), bool centerPrincipalPoint=false)
CvStatus *cv_getDefaultNewCameraMatrix(
    Mat cameraMatrix,
    CvSize size,
    bool centerPrincipalPoint,
    Mat *rval,
    CvCallback_0 callback
);

// Returns the new camera intrinsic matrix based on the free scaling parameter.
// Mat cv::getOptimalNewCameraMatrix (InputArray cameraMatrix, InputArray distCoeffs, Size imageSize, double alpha, Size newImgSize=Size(), Rect *validPixROI=0, bool centerPrincipalPoint=false)
CvStatus *cv_getOptimalNewCameraMatrix(
    Mat cameraMatrix,
    Mat distCoeffs,
    CvSize size,
    double alpha,
    CvSize newImgSize,
    CvRect *validPixROI,
    bool centerPrincipalPoint,
    Mat *rval,
    CvCallback_0 callback
);

// computes valid disparity ROI from the valid ROIs of the rectified images (that are returned by stereoRectify)
// Rect cv::getValidDisparityROI (Rect roi1, Rect roi2, int minDisparity, int numberOfDisparities, int blockSize)

// Finds an initial camera intrinsic matrix from 3D-2D point correspondences.
// Mat cv::initCameraMatrix2D (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints, Size imageSize, double aspectRatio=1.0)

// Computes the projection and inverse-rectification transformation map. In essense, this is the inverse of initUndistortRectifyMap to accomodate stereo-rectification of projectors ('inverse-cameras') in projector-camera pairs.
// void cv::initInverseRectificationMap (InputArray cameraMatrix, InputArray distCoeffs, InputArray R, InputArray newCameraMatrix, const Size &size, int m1type, OutputArray map1, OutputArray map2)

// Computes the undistortion and rectification transformation map.
// void cv::initUndistortRectifyMap (InputArray cameraMatrix, InputArray distCoeffs, InputArray R, InputArray newCameraMatrix, Size size, int m1type, OutputArray map1, OutputArray map2)
CvStatus *cv_initUndistortRectifyMap(
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat r,
    Mat newCameraMatrix,
    CvSize size,
    int m1type,
    Mat map1,
    Mat map2,
    CvCallback_0 callback
);

// initializes maps for remap for wide-angle
// float cv::initWideAngleProjMap (InputArray cameraMatrix, InputArray distCoeffs, Size imageSize, int destImageWidth, int m1type, OutputArray map1, OutputArray map2, enum UndistortTypes projType=PROJ_SPHERICAL_EQRECT, double alpha=0)
CvStatus *cv_initWideAngleProjMap(
    MatIn cameraMatrix,
    MatIn distCoeffs,
    CvSize size,
    int destImageWidth,
    int m1type,
    MatOut map1,
    MatOut map2,
    int projType,
    double alpha,
    float *rval,
    CvCallback_0 callback
);

// Computes partial derivatives of the matrix product for each multiplied matrix.
// void cv::matMulDeriv (InputArray A, InputArray B, OutputArray dABdA, OutputArray dABdB)
CvStatus *cv_matMulDeriv(
    MatIn A,
    MatIn B,
    MatOut dABdA,
    MatOut dABdB,
    CvCallback_0 callback
);

// Projects 3D points to an image plane.
// void cv::projectPoints (InputArray objectPoints, InputArray rvec, InputArray tvec, InputArray cameraMatrix, InputArray distCoeffs, OutputArray imagePoints, OutputArray jacobian=noArray(), double aspectRatio=0)
CvStatus *cv_projectPoints(
    MatIn objectPoints,
    MatIn rvec,
    MatIn tvec,
    MatIn cameraMatrix,
    MatIn distCoeffs,
    MatOut imagePoints,
    MatOut jacobian,
    double aspectRatio,
    CvCallback_0 callback
);


// Recovers the relative camera rotation and the translation from an estimated essential matrix and the corresponding points in two images, using chirality check. Returns the number of inliers that pass the check.
// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, InputArray cameraMatrix, OutputArray R, OutputArray t, InputOutputArray mask=noArray())
// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, InputArray cameraMatrix, OutputArray R, OutputArray t, double distanceThresh, InputOutputArray mask=noArray(), OutputArray triangulatedPoints=noArray())
CvStatus *cv_recoverPose(
    MatIn E, MatIn points1, MatIn points2, MatIn cameraMatrix, MatOut R, MatOut t, double distanceThresh, MatInOut mask,
    MatOut triangulatedPoints, int *rval, CvCallback_0 callback
);

// int cv::recoverPose (InputArray E, InputArray points1, InputArray points2, OutputArray R, OutputArray t, double focal=1.0, Point2d pp=Point2d(0, 0), InputOutputArray mask=noArray())
CvStatus *cv_recoverPose_1(
    MatIn E, MatIn points1, MatIn points2, MatOut R, MatOut t, double focal, CvPoint2d pp, MatInOut mask, int *rval,
    CvCallback_0 callback
);

// Recovers the relative camera rotation and the translation from corresponding points in two images from two different cameras, using cheirality check. Returns the number of inliers that pass the check.
// int cv::recoverPose (InputArray points1, InputArray points2, InputArray cameraMatrix1, InputArray distCoeffs1, InputArray cameraMatrix2, InputArray distCoeffs2, OutputArray E, OutputArray R, OutputArray t, int method=cv::RANSAC, double prob=0.999, double threshold=1.0, InputOutputArray mask=noArray())

// computes the rectification transformations for 3-head camera, where all the heads are on the same line.
// float cv::rectify3Collinear (InputArray cameraMatrix1, InputArray distCoeffs1, InputArray cameraMatrix2, InputArray distCoeffs2, InputArray cameraMatrix3, InputArray distCoeffs3, InputArrayOfArrays imgpt1, InputArrayOfArrays imgpt3, Size imageSize, InputArray R12, InputArray T12, InputArray R13, InputArray T13, OutputArray R1, OutputArray R2, OutputArray R3, OutputArray P1, OutputArray P2, OutputArray P3, OutputArray Q, double alpha, Size newImgSize, Rect *roi1, Rect *roi2, int flags)

// Reprojects a disparity image to 3D space.
// void cv::reprojectImageTo3D (InputArray disparity, OutputArray _3dImage, InputArray Q, bool handleMissingValues=false, int ddepth=-1)
CvStatus *cv_reprojectImageTo3D(
    MatIn disparity, MatOut _3dImage, MatIn Q, bool handleMissingValues, int ddepth, CvCallback_0 callback
);

// Converts a rotation matrix to a rotation vector or vice versa.
// void cv::Rodrigues (InputArray src, OutputArray dst, OutputArray jacobian=noArray())
CvStatus *cv_Rodrigues(MatIn src, MatOut dst, MatOut jacobian, CvCallback_0 callback);

// Computes an RQ decomposition of 3x3 matrices.
// Vec3d cv::RQDecomp3x3 (InputArray src, OutputArray mtxR, OutputArray mtxQ, OutputArray Qx=noArray(), OutputArray Qy=noArray(), OutputArray Qz=noArray())
CvStatus *cv_RQDecomp3x3(MatIn src, MatOut mtxR, MatOut mtxQ, MatOut Qx, MatOut Qy, MatOut Qz, Vec3d *rval,
                         CvCallback_0 callback);

// Calculates the Sampson Distance between two points.
// double cv::sampsonDistance (InputArray pt1, InputArray pt2, InputArray F)
double cv_sampsonDistance(MatIn pt1, MatIn pt2, MatIn F);

// Finds an object pose from 3 3D-2D point correspondences.
// int cv::solveP3P (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, int flags)
CvStatus *cv_solveP3P(MatIn objectPoints, MatIn imagePoints, MatIn cameraMatrix, MatIn distCoeffs, VecMat *rvecs,
                      VecMat *tvecs, int flags, int *rval, CvCallback_0 callback);

// Finds an object pose from 3D-2D point correspondences.
// bool cv::solvePnP (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArray rvec, OutputArray tvec, bool useExtrinsicGuess=false, int flags=SOLVEPNP_ITERATIVE)
CvStatus *cv_solvePnP(MatIn objectPoints, MatIn imagePoints, MatIn cameraMatrix, MatIn distCoeffs, MatOut rvec,
                      MatOut tvec, bool useExtrinsicGuess, int flags, bool *rval, CvCallback_0 callback);

// Finds an object pose from 3D-2D point correspondences.
// int cv::solvePnPGeneric (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, bool useExtrinsicGuess=false, SolvePnPMethod flags=SOLVEPNP_ITERATIVE, InputArray rvec=noArray(), InputArray tvec=noArray(), OutputArray reprojectionError=noArray())
CvStatus *cv_solvePnPGeneric(MatIn objectPoints, MatIn imagePoints, MatIn cameraMatrix, MatIn distCoeffs, VecMat *rvecs,
                             VecMat *tvecs, bool useExtrinsicGuess, int flags, MatIn rvec, MatIn tvec,
                             MatOut reprojectionError, int *rval, CvCallback_0 callback);

// Finds an object pose from 3D-2D point correspondences using the RANSAC scheme.
// bool cv::solvePnPRansac (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArray rvec, OutputArray tvec, bool useExtrinsicGuess=false, int iterationsCount=100, float reprojectionError=8.0, double confidence=0.99, OutputArray inliers=noArray(), int flags=SOLVEPNP_ITERATIVE)
CvStatus *cv_solvePnPRansac(MatIn objectPoints, MatIn imagePoints, MatIn cameraMatrix, MatIn distCoeffs, MatOut rvec,
                            MatOut tvec, bool useExtrinsicGuess, int iterationsCount, float reprojectionError,
                            double confidence, MatOut inliers, int flags, bool *rval, CvCallback_0 callback);

// bool cv::solvePnPRansac (InputArray objectPoints, InputArray imagePoints, InputOutputArray cameraMatrix, InputArray distCoeffs, OutputArray rvec, OutputArray tvec, OutputArray inliers, const UsacParams &params=UsacParams())
CvStatus *cv_solvePnPRansac_1(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                              Mat inliers, struct UsacParams params, bool *rval, CvCallback_0 callback);

// Refine a pose (the translation and the rotation that transform a 3D point expressed in the object coordinate frame to the camera coordinate frame) from a 3D-2D point correspondences and starting from an initial solution.
// void cv::solvePnPRefineLM (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, InputOutputArray rvec, InputOutputArray tvec, TermCriteria criteria=TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 20, FLT_EPSILON))
CvStatus *cv_solvePnPRefineLM(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                              struct TermCriteria criteria, CvCallback_0 callback);

// Refine a pose (the translation and the rotation that transform a 3D point expressed in the object coordinate frame to the camera coordinate frame) from a 3D-2D point correspondences and starting from an initial solution.
// void cv::solvePnPRefineVVS (InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, InputOutputArray rvec, InputOutputArray tvec, TermCriteria criteria=TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 20, FLT_EPSILON), double VVSlambda=1)
CvStatus *cv_solvePnPRefineVVS(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                               struct TermCriteria criteria, double VVSlambda, CvCallback_0 callback);

// Calibrates a stereo camera set up. This function finds the intrinsic parameters for each of the two cameras and the extrinsic parameters between the two cameras.
// double cv::stereoCalibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints1, InputArrayOfArrays imagePoints2, InputOutputArray cameraMatrix1, InputOutputArray distCoeffs1, InputOutputArray cameraMatrix2, InputOutputArray distCoeffs2, Size imageSize, InputOutputArray R, InputOutputArray T, OutputArray E, OutputArray F, OutputArray perViewErrors, int flags=CALIB_FIX_INTRINSIC, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 30, 1e-6));
// double cv::stereoCalibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints1, InputArrayOfArrays imagePoints2, InputOutputArray cameraMatrix1, InputOutputArray distCoeffs1, InputOutputArray cameraMatrix2, InputOutputArray distCoeffs2, Size imageSize, OutputArray R, OutputArray T, OutputArray E, OutputArray F, int flags=CALIB_FIX_INTRINSIC, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 30, 1e-6));
// double cv::stereoCalibrate (InputArrayOfArrays objectPoints, InputArrayOfArrays imagePoints1, InputArrayOfArrays imagePoints2, InputOutputArray cameraMatrix1, InputOutputArray distCoeffs1, InputOutputArray cameraMatrix2, InputOutputArray distCoeffs2, Size imageSize, InputOutputArray R, InputOutputArray T, OutputArray E, OutputArray F, OutputArrayOfArrays rvecs, OutputArrayOfArrays tvecs, OutputArray perViewErrors, int flags=CALIB_FIX_INTRINSIC, TermCriteria criteria=TermCriteria(TermCriteria::COUNT+TermCriteria::EPS, 30, 1e-6));
CvStatus *cv_stereoCalibrate(VecMat objectPoints, VecMat imagePoints1, VecMat imagePoints2, MatInOut cameraMatrix1,
                             MatInOut distCoeffs1, MatInOut cameraMatrix2, MatInOut distCoeffs2, CvSize imageSize,
                             MatInOut R, MatInOut T, MatOut E, MatOut F, VecMat rvecs, VecMat tvecs,
                             MatOut perViewErrors, int flags, struct TermCriteria criteria, double *rval,
                             CvCallback_0 callback);

// Computes rectification transforms for each head of a calibrated stereo camera.
// void cv::stereoRectify (InputArray cameraMatrix1, InputArray distCoeffs1, InputArray cameraMatrix2, InputArray distCoeffs2, Size imageSize, InputArray R, InputArray T, OutputArray R1, OutputArray R2, OutputArray P1, OutputArray P2, OutputArray Q, int flags=CALIB_ZERO_DISPARITY, double alpha=-1, Size newImageSize=Size(), Rect *validPixROI1=0, Rect *validPixROI2=0);
CvStatus *cv_stereoRectify(MatIn cameraMatrix1, MatIn distCoeffs1, MatIn cameraMatrix2, MatIn distCoeffs2,
                           CvSize imageSize, MatIn R, MatIn T, MatOut R1, MatOut R2, MatOut P1, MatOut P2, MatOut Q,
                           int flags, double alpha, CvSize newImageSize, struct CvRect *validPixROI1,
                           struct CvRect *validPixROI2, CvCallback_0 callback);

// Computes a rectification transform for an uncalibrated stereo camera.
// bool cv::stereoRectifyUncalibrated (InputArray points1, InputArray points2, InputArray F, Size imgSize, OutputArray H1, OutputArray H2, double threshold=5);
CvStatus *cv_stereoRectifyUncalibrated(MatIn points1, MatIn points2, MatIn F, CvSize imgSize, MatOut H1, MatOut H2,
                                       double threshold, bool *rval, CvCallback_0 callback);

// This function reconstructs 3-dimensional points (in homogeneous coordinates) by using their observations with a stereo camera.
// void cv::triangulatePoints (InputArray projMatr1, InputArray projMatr2, InputArray projPoints1, InputArray projPoints2, OutputArray points4D);
CvStatus *cv_triangulatePoints(MatIn projMatr1, MatIn projMatr2, MatIn projPoints1, MatIn projPoints2, MatOut points4D,
                               CvCallback_0 callback);

// Transforms an image to compensate for lens distortion.
// void cv::undistort (InputArray src, OutputArray dst, InputArray cameraMatrix, InputArray distCoeffs, InputArray newCameraMatrix=noArray());
CvStatus *cv_undistort(
    Mat src, Mat dst, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix, CvCallback_0 callback
);


// Compute undistorted image points position.
// void cv::undistortImagePoints (InputArray src, OutputArray dst, InputArray cameraMatrix, InputArray distCoeffs, TermCriteria=TermCriteria(TermCriteria::MAX_ITER+TermCriteria::EPS, 5, 0.01));
CvStatus *cv_undistortImagePoints(Mat src, Mat dst, Mat cameraMatrix, Mat distCoeffs, struct TermCriteria criteria,
                                  CvCallback_0 callback);

// Computes the ideal point coordinates from the observed point coordinates.
// void cv::undistortPoints (InputArray src, OutputArray dst, InputArray cameraMatrix, InputArray distCoeffs, InputArray R, InputArray P, TermCriteria criteria);
// void cv::undistortPoints (InputArray src, OutputArray dst, InputArray cameraMatrix, InputArray distCoeffs, InputArray R=noArray(), InputArray P=noArray());
CvStatus *cv_undistortPoints(
    Mat distorted,
    Mat undistorted,
    Mat k,
    Mat d,
    Mat r,
    Mat p,
    TermCriteria criteria,
    CvCallback_0 callback
);

// validates disparity using the left-right check. The matrix "cost" should be computed by the stereo correspondence algorithm
// void cv::validateDisparity (InputOutputArray disparity, InputArray cost, int minDisparity, int numberOfDisparities, int disp12MaxDisp=1);
CvStatus *cv_validateDisparity(Mat disparity, Mat cost, int minDisparity, int numberOfDisparities, int disp12MaxDisp,
                               CvCallback_0 callback);

#ifdef __cplusplus
}
#endif

#endif  //CVD_CALIB_H_
