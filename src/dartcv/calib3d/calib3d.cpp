/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma warning(disable : 4996)
#include <opencv2/imgcodecs.hpp>
#include "dartcv/calib3d/calib3d.h"

cv::UsacParams cv_UsacParams_c2cpp(struct UsacParams params) {
    cv::UsacParams _params;
    _params.confidence = params.confidence;
    _params.isParallel = params.isParallel;
    _params.loIterations = params.loIterations;
    _params.loMethod = static_cast<cv::LocalOptimMethod>(params.loMethod);
    _params.loSampleSize = params.loSampleSize;
    _params.maxIterations = params.maxIterations;
    _params.neighborsSearch = static_cast<cv::NeighborSearchMethod>(params.neighborsSearch);
    _params.randomGeneratorState = params.randomGeneratorState;
    _params.sampler = static_cast<cv::SamplingMethod>(params.sampler);
    _params.score = static_cast<cv::ScoreMethod>(params.score);
    _params.threshold = params.threshold;
    _params.final_polisher = static_cast<cv::PolishingMethod>(params.final_polisher);
    _params.final_polisher_iterations = params.final_polisher_iterations;
    return _params;
}

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
) {
    BEGIN_WRAP
        *rval = cv::fisheye::calibrate(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            cv::Size(imageSize.width, imageSize.height),
            CVDEREF(k),
            CVDEREF(d),
            CVDEREF(rvecs),
            CVDEREF(tvecs),
            flags,
            cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_distortPoints(
    MatIn undistorted, MatOut distorted, MatIn K, MatIn D, double alpha, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::fisheye::distortPoints(
            CVDEREF(undistorted), CVDEREF(distorted), CVDEREF(K), CVDEREF(D), alpha
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_distortPoints_1(
    MatIn undistorted, MatOut distorted, MatInOut Kundistorted, MatIn K, MatIn D, double alpha, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::fisheye::distortPoints(
            CVDEREF(undistorted), CVDEREF(distorted), CVDEREF(Kundistorted), CVDEREF(K), CVDEREF(D), alpha
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_estimateNewCameraMatrixForUndistortRectify(
    Mat k,
    Mat d,
    CvSize imgSize,
    Mat r,
    Mat p,
    double balance,
    CvSize newSize,
    double fovScale,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size newSz(newSize.width, newSize.height);
        cv::Size imgSz(imgSize.width, imgSize.height);
        cv::fisheye::estimateNewCameraMatrixForUndistortRectify(
            CVDEREF(k), CVDEREF(d), imgSz, CVDEREF(r), CVDEREF(p), balance, newSz, fovScale
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        cv::fisheye::initUndistortRectifyMap(
            CVDEREF(k), CVDEREF(d), CVDEREF(r), CVDEREF(p), cv::Size(imgSize.width, imgSize.height), m1type,
            CVDEREF(map1), CVDEREF(map2)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_projectPoints(
    MatIn objectPoints, MatOut imagePoints, MatIn rvec, MatIn tvec, MatIn k, MatIn d, double alpha, MatOut jacobian,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::fisheye::projectPoints(
            CVDEREF(objectPoints), CVDEREF(imagePoints), CVDEREF(rvec), CVDEREF(tvec), CVDEREF(k), CVDEREF(d), alpha,
            CVDEREF(jacobian)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_solvePnP(
    MatIn objectPoints, MatIn imagePoints, MatIn cameraMatrix, MatIn distCoeffs, MatOut rvec, MatOut tvec,
    bool useExtrinsicGuess, int flags, TermCriteria criteria, bool *rval, CvCallback_0 callback
) {
    BEGIN_WRAP
        *rval = cv::fisheye::solvePnP(
            CVDEREF(objectPoints), CVDEREF(imagePoints), CVDEREF(cameraMatrix), CVDEREF(distCoeffs), CVDEREF(rvec),
            CVDEREF(tvec), useExtrinsicGuess, flags,
            cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_undistortImage(
    Mat distorted, Mat undistorted, Mat k, Mat d, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::fisheye::undistortImage(CVDEREF(distorted), CVDEREF(undistorted), CVDEREF(k), CVDEREF(d));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_undistortImage_1(
    Mat distorted, Mat undistorted, Mat k, Mat d, Mat knew, CvSize size, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size sz(size.width, size.height);
        cv::fisheye::undistortImage(
            CVDEREF(distorted), CVDEREF(undistorted), CVDEREF(k), CVDEREF(d), CVDEREF(knew), sz
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_fisheye_undistortPoints(
    Mat distorted, Mat undistorted, Mat k, Mat d, Mat R, Mat P, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::fisheye::undistortPoints(
            CVDEREF(distorted), CVDEREF(undistorted), CVDEREF(k), CVDEREF(d), CVDEREF(R), CVDEREF(P)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}


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
) {
    BEGIN_WRAP
        auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
        *rval = cv::calibrateCamera(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            cv::Size(imageSize.width, imageSize.height),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvecs),
            CVDEREF(tvecs),
            flag,
            tc
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

bool cv_checkChessboard(Mat img, CvSize size) {
    return cv::checkChessboard(CVDEREF(img), cv::Size(size.width, size.height));
}

CvStatus *cv_computeCorrespondEpilines(MatIn src, int whichImage, MatIn F, MatOut lines, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::computeCorrespondEpilines(CVDEREF(src), whichImage, CVDEREF(F), CVDEREF(lines));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_convertPointsFromHomogeneous(MatIn src, MatOut dst, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::convertPointsFromHomogeneous(CVDEREF(src), CVDEREF(dst));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_convertPointsHomogeneous(MatIn src, MatOut dst, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::convertPointsHomogeneous(CVDEREF(src), CVDEREF(dst));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_convertPointsToHomogeneous(MatIn src, MatOut dst, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::convertPointsToHomogeneous(CVDEREF(src), CVDEREF(dst));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_correctMatches(MatIn F, MatIn points1, MatIn points2, MatOut newPoints1, MatOut newPoints2,
                            CvCallback_0 callback) {
    BEGIN_WRAP
        cv::correctMatches(CVDEREF(F), CVDEREF(points1), CVDEREF(points2), CVDEREF(newPoints1), CVDEREF(newPoints2));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_decomposeEssentialMat(MatIn E, MatOut R1, MatOut R2, MatOut t, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::decomposeEssentialMat(CVDEREF(E), CVDEREF(R1), CVDEREF(R2), CVDEREF(t));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_decomposeHomographyMat(MatIn H, MatIn K, VecMat rotations, VecMat translations, VecMat normals, int *rval,
                                    CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::decomposeHomographyMat(
            CVDEREF(H), CVDEREF(K), CVDEREF(rotations), CVDEREF(translations), CVDEREF(normals)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_decomposeProjectionMatrix(MatIn projMatrix, MatOut cameraMatrix, MatOut rotMatrix, MatOut transVect,
                                       MatOut rotMatrixX, MatOut rotMatrixY, MatOut rotMatrixZ, MatOut eulerAngles,
                                       CvCallback_0 callback) {
    BEGIN_WRAP
        cv::decomposeProjectionMatrix(
            CVDEREF(projMatrix), CVDEREF(cameraMatrix), CVDEREF(rotMatrix), CVDEREF(transVect), CVDEREF(rotMatrixX),
            CVDEREF(rotMatrixY), CVDEREF(rotMatrixZ), CVDEREF(eulerAngles)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_drawChessboardCorners(
    Mat image, CvSize patternSize, VecPoint2f corners, bool patternWasFound, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size sz(patternSize.width, patternSize.height);
        cv::drawChessboardCorners(CVDEREF(image), sz, CVDEREF(corners), patternWasFound);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_drawFrameAxes(
    Mat image,
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat rvec,
    Mat tvec,
    float length,
    int thickness,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::drawFrameAxes(
            CVDEREF(image),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            length,
            thickness
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_estimateAffinePartial2D(
    VecPoint2f from, VecPoint2f to, Mat *rval, CvCallback_0 callback
) {
    BEGIN_WRAP
        rval->ptr = new cv::Mat(cv::estimateAffinePartial2D(CVDEREF(from), CVDEREF(to)));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        auto m = cv::estimateAffinePartial2D(
            CVDEREF(from),
            CVDEREF(to),
            CVDEREF(inliers),
            method,
            ransacReprojThreshold,
            maxIters,
            confidence,
            refineIters
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_estimateAffine2D(VecPoint2f from, VecPoint2f to, Mat *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        rval->ptr = new cv::Mat(cv::estimateAffine2D(CVDEREF(from), CVDEREF(to)));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        auto m = cv::estimateAffine2D(
            CVDEREF(from),
            CVDEREF(to),
            CVDEREF(inliers),
            method,
            ransacReprojThreshold,
            maxIters,
            confidence,
            refineIters
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_estimateAffine3D(
    Mat src,
    Mat dst,
    double *scale,
    bool force_rotation,
    Mat *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        rval->ptr = new cv::Mat(cv::estimateAffine3D(CVDEREF(src), CVDEREF(dst), scale, force_rotation));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_estimateAffine3D_1(
    Mat src,
    Mat dst,
    CVD_OUT Mat out,
    CVD_OUT Mat inliers,
    double ransacThreshold,
    double confidence,
    int *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        *rval = cv::estimateAffine3D(CVDEREF(src), CVDEREF(dst), CVDEREF(out), CVDEREF(inliers), ransacThreshold,
                                     confidence);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_estimateChessboardSharpness(MatIn image, CvSize patternSize, MatIn corners, float rise_distance,
                                         bool vertical, MatOut sharpness, Scalar *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        const auto m = cv::estimateChessboardSharpness(
            CVDEREF(image),
            cv::Size(patternSize.width, patternSize.height),
            CVDEREF(corners),
            rise_distance,
            vertical,
            CVDEREF(sharpness)
        );
        *rval = {m.val[0], m.val[1], m.val[2], m.val[3]};
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_estimateTranslation3D(MatIn src, MatIn dst, MatOut out, MatOut inliers, double ransacThreshold,
                                   double confidence, int *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::estimateTranslation3D(
            CVDEREF(src),
            CVDEREF(dst),
            CVDEREF(out),
            CVDEREF(inliers),
            ransacThreshold,
            confidence
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_filterHomographyDecompByVisibleRefpoints(VecMat rotations, VecMat normals, MatIn beforePoints,
                                                      MatIn afterPoints, MatOut possibleSolutions, MatIn pointsMask,
                                                      CvCallback_0 callback) {
    BEGIN_WRAP
        cv::filterHomographyDecompByVisibleRefpoints(
            CVDEREF(rotations),
            CVDEREF(normals),
            CVDEREF(beforePoints),
            CVDEREF(afterPoints),
            CVDEREF(possibleSolutions),
            CVDEREF(pointsMask)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_filterSpeckles(MatInOut img, double newVal, int maxSpeckleSize, double maxDiff, MatInOut buf,
                            CvCallback_0 callback) {
    BEGIN_WRAP
        cv::filterSpeckles(CVDEREF(img), newVal, maxSpeckleSize, maxDiff, CVDEREF(buf));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_find4QuadCornerSubpix(MatIn img, MatInOut corners, CvSize region_size, bool *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::find4QuadCornerSubpix(CVDEREF(img), CVDEREF(corners),
                                          cv::Size(region_size.width, region_size.height));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findChessboardCorners(
    Mat image, CvSize patternSize, VecPoint2f *corners, int flags, bool *rval, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size sz(patternSize.width, patternSize.height);
        *rval = cv::findChessboardCorners(CVDEREF(image), sz, CVDEREF_P(corners), flags);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findChessboardCornersSB(
    Mat image, CvSize patternSize, VecPoint2f *out_corners, int flags, bool *rval, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size sz(patternSize.width, patternSize.height);
        *rval = cv::findChessboardCornersSB(CVDEREF(image), sz, CVDEREF_P(out_corners), flags);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findChessboardCornersSB_1(
    Mat image,
    CvSize patternSize,
    VecPoint2f *out_corners,
    int flags,
    Mat meta,
    bool *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size sz(patternSize.width, patternSize.height);
        *rval = cv::findChessboardCornersSB(CVDEREF(image), sz, CVDEREF_P(out_corners), flags, CVDEREF(meta));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findCirclesGrid(MatIn image, CvSize patternSize, MatOut centers, int flags, bool *rval,
                             CvCallback_0 callback) {
    BEGIN_WRAP
        cv::Size sz(patternSize.width, patternSize.height);
        *rval = cv::findCirclesGrid(CVDEREF(image), sz, CVDEREF(centers), flags);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findEssentialMat(MatIn points1, MatIn points2, double focal, CvPoint2d pp, int method, double prob,
                              double threshold, int maxIters, MatOut mask, Mat *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        auto m = cv::findEssentialMat(
            CVDEREF(points1),
            CVDEREF(points2),
            focal,
            cv::Point2d(pp.x, pp.y),
            method,
            prob,
            threshold,
            maxIters,
            CVDEREF(mask)
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findEssentialMat_1(MatIn points1, MatIn points2, MatIn cameraMatrix, int method, double prob,
                                double threshold, int maxIters, MatOut mask, Mat *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        auto m = cv::findEssentialMat(
            CVDEREF(points1),
            CVDEREF(points2),
            CVDEREF(cameraMatrix),
            method,
            prob,
            threshold,
            maxIters,
            CVDEREF(mask)
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        auto m = cv::findFundamentalMat(
            CVDEREF(points1),
            CVDEREF(points2),
            method,
            ransacReprojThreshold,
            confidence,
            maxIters,
            CVDEREF(mask)
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findFundamentalMat_1(
    MatIn points1,
    MatIn points2,
    MatOut mask,
    UsacParams params,
    Mat *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        auto m = cv::findFundamentalMat(
            CVDEREF(points1),
            CVDEREF(points2),
            CVDEREF(mask),
            cv_UsacParams_c2cpp(params)
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findFundamentalMat_2(
    MatIn points1,
    MatIn points2,
    MatOut mask,
    int method,
    double ransacReprojThreshold,
    double confidence,
    Mat *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        auto m = cv::findFundamentalMat(
            CVDEREF(points1),
            CVDEREF(points2),
            CVDEREF(mask),
            method,
            ransacReprojThreshold,
            confidence
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}


CvStatus *cv_findHomography(
    Mat src,
    Mat dst,
    int method,
    double ransacReprojThreshold,
    Mat mask,
    const int maxIters,
    const double confidence,
    Mat *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        auto m = cv::findHomography(
            CVDEREF(src),
            CVDEREF(dst),
            method,
            ransacReprojThreshold,
            CVDEREF(mask),
            maxIters,
            confidence
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_findHomography_1(MatIn srcPoints, MatIn dstPoints, MatOut mask, UsacParams params, Mat *rval,
                              CvCallback_0 callback) {
    BEGIN_WRAP
        auto m = cv::findHomography(
            CVDEREF(srcPoints),
            CVDEREF(dstPoints),
            CVDEREF(mask),
            cv_UsacParams_c2cpp(params)
        );
        rval->ptr = new cv::Mat(m);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_getDefaultNewCameraMatrix(
    Mat cameraMatrix,
    CvSize size,
    bool centerPrincipalPoint,
    Mat *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::Size sz(size.width, size.height);
        rval->ptr = new cv::Mat(cv::getDefaultNewCameraMatrix(CVDEREF(cameraMatrix), sz, centerPrincipalPoint));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        cv::Size sz(size.width, size.height);
        cv::Size newSize(newImgSize.width, newImgSize.height);
        cv::Rect rect(validPixROI->x, validPixROI->y, validPixROI->width, validPixROI->height);
        auto mat = cv::getOptimalNewCameraMatrix(
            CVDEREF(cameraMatrix), CVDEREF(distCoeffs), sz, alpha, newSize, &rect, centerPrincipalPoint
        );
        validPixROI->x = rect.x;
        validPixROI->y = rect.y;
        validPixROI->width = rect.width;
        validPixROI->height = rect.height;
        rval->ptr = new cv::Mat(mat);
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        cv::initUndistortRectifyMap(
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(r),
            CVDEREF(newCameraMatrix),
            cv::Size(size.width, size.height),
            m1type,
            CVDEREF(map1),
            CVDEREF(map2)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        *rval = cv::initWideAngleProjMap(
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            cv::Size(size.width, size.height),
            destImageWidth,
            m1type,
            CVDEREF(map1),
            CVDEREF(map2),
            projType,
            alpha
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_matMulDeriv(
    MatIn A,
    MatIn B,
    MatOut dABdA,
    MatOut dABdB,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::matMulDeriv(CVDEREF(A), CVDEREF(B), CVDEREF(dABdA), CVDEREF(dABdB));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

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
) {
    BEGIN_WRAP
        cv::projectPoints(
            CVDEREF(objectPoints),
            CVDEREF(rvec),
            CVDEREF(tvec),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(imagePoints),
            CVDEREF(jacobian),
            aspectRatio
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_recoverPose(
    MatIn E, MatIn points1, MatIn points2, MatIn cameraMatrix, MatOut R, MatOut t, double distanceThresh, MatInOut mask,
    MatOut triangulatedPoints, int *rval, CvCallback_0 callback
) {
    BEGIN_WRAP
        *rval = cv::recoverPose(
            CVDEREF(E),
            CVDEREF(points1),
            CVDEREF(points2),
            CVDEREF(cameraMatrix),
            CVDEREF(R),
            CVDEREF(t),
            distanceThresh,
            CVDEREF(mask),
            CVDEREF(triangulatedPoints)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_recoverPose_1(
    MatIn E, MatIn points1, MatIn points2, MatOut R, MatOut t, double focal, CvPoint2d pp, MatInOut mask, int *rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        *rval = cv::recoverPose(
            CVDEREF(E),
            CVDEREF(points1),
            CVDEREF(points2),
            CVDEREF(R),
            CVDEREF(t),
            focal,
            cv::Point2d(pp.x, pp.y),
            CVDEREF(mask)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_reprojectImageTo3D(
    MatIn disparity, MatOut _3dImage, MatIn Q, bool handleMissingValues, int ddepth, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::reprojectImageTo3D(
            CVDEREF(disparity),
            CVDEREF(_3dImage),
            CVDEREF(Q),
            handleMissingValues,
            ddepth
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_Rodrigues(MatIn src, MatOut dst, MatOut jacobian, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::Rodrigues(CVDEREF(src), CVDEREF(dst), CVDEREF(jacobian));
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_RQDecomp3x3(MatIn src, MatOut mtxR, MatOut mtxQ, MatOut Qx, MatOut Qy, MatOut Qz, Vec3d *rval,
                         CvCallback_0 callback) {
    BEGIN_WRAP
        cv::RQDecomp3x3(
            CVDEREF(src),
            CVDEREF(mtxR),
            CVDEREF(mtxQ),
            CVDEREF(Qx),
            CVDEREF(Qy),
            CVDEREF(Qz)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

double cv_sampsonDistance(MatIn pt1, MatIn pt2, MatIn F) {
    return cv::sampsonDistance(CVDEREF(pt1), CVDEREF(pt2), CVDEREF(F));
}

CvStatus *cv_solveP3P(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, VecMat *rvecs, VecMat *tvecs,
                      int flags, int *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::solveP3P(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF_P(rvecs),
            CVDEREF_P(tvecs),
            flags
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_solvePnP(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                      bool useExtrinsicGuess, int flags, bool *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::solvePnP(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            useExtrinsicGuess,
            flags
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_solvePnPGeneric(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, VecMat *rvecs,
                             VecMat *tvecs, bool useExtrinsicGuess, int flags, Mat rvec, Mat tvec,
                             Mat reprojectionError, int *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::solvePnPGeneric(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF_P(rvecs),
            CVDEREF_P(tvecs),
            useExtrinsicGuess,
            static_cast<cv::SolvePnPMethod>(flags),
            CVDEREF(rvec),
            CVDEREF(tvec),
            CVDEREF(reprojectionError)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_solvePnPRansac(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                            bool useExtrinsicGuess, int iterationsCount, float reprojectionError, double confidence,
                            Mat inliers, int flags, bool *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::solvePnPRansac(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            useExtrinsicGuess,
            iterationsCount,
            reprojectionError,
            confidence,
            CVDEREF(inliers),
            flags
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_solvePnPRansac_1(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                              Mat inliers, struct UsacParams params, bool *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::solvePnPRansac(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            CVDEREF(inliers),
            cv_UsacParams_c2cpp(params)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_solvePnPRefineLM(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                              struct TermCriteria criteria, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::solvePnPRefineLM(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_solvePnPRefineVVS(Mat objectPoints, Mat imagePoints, Mat cameraMatrix, Mat distCoeffs, Mat rvec, Mat tvec,
                               struct TermCriteria criteria, double VVSlambda, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::solvePnPRefineVVS(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon),
            VVSlambda
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_stereoCalibrate(VecMat objectPoints, VecMat imagePoints1, VecMat imagePoints2, MatInOut cameraMatrix1,
                             MatInOut distCoeffs1, MatInOut cameraMatrix2, MatInOut distCoeffs2, CvSize imageSize,
                             MatInOut R, MatInOut T, MatOut E, MatOut F, VecMat rvecs, VecMat tvecs,
                             MatOut perViewErrors, int flags, struct TermCriteria criteria, double *rval,
                             CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::stereoCalibrate(
            CVDEREF(objectPoints),
            CVDEREF(imagePoints1),
            CVDEREF(imagePoints2),
            CVDEREF(cameraMatrix1),
            CVDEREF(distCoeffs1),
            CVDEREF(cameraMatrix2),
            CVDEREF(distCoeffs2),
            cv::Size(imageSize.width, imageSize.height),
            CVDEREF(R),
            CVDEREF(T),
            CVDEREF(E),
            CVDEREF(F),
            CVDEREF(rvecs),
            CVDEREF(tvecs),
            CVDEREF(perViewErrors),
            flags,
            cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_stereoRectify(MatIn cameraMatrix1, MatIn distCoeffs1, MatIn cameraMatrix2, MatIn distCoeffs2,
                           CvSize imageSize, MatIn R, MatIn T, MatOut R1, MatOut R2, MatOut P1, MatOut P2, MatOut Q,
                           int flags, double alpha, CvSize newImageSize, struct CvRect *validPixROI1,
                           struct CvRect *validPixROI2, CvCallback_0 callback) {
    BEGIN_WRAP
        cv::Rect _validPixROI1;
        cv::Rect _validPixROI2;
        cv::stereoRectify(
            CVDEREF(cameraMatrix1),
            CVDEREF(distCoeffs1),
            CVDEREF(cameraMatrix2),
            CVDEREF(distCoeffs2),
            cv::Size(imageSize.width, imageSize.height),
            CVDEREF(R),
            CVDEREF(T),
            CVDEREF(R1),
            CVDEREF(R2),
            CVDEREF(P1),
            CVDEREF(P2),
            CVDEREF(Q),
            flags,
            alpha,
            cv::Size(newImageSize.width, newImageSize.height),
            &_validPixROI1,
            &_validPixROI2
        );
        if (validPixROI1 != nullptr) {
            validPixROI1->x = _validPixROI1.x;
            validPixROI1->y = _validPixROI1.y;
            validPixROI1->width = _validPixROI1.width;
            validPixROI1->height = _validPixROI1.height;
        }
        if (validPixROI2 != nullptr) {
            validPixROI2->x = _validPixROI2.x;
            validPixROI2->y = _validPixROI2.y;
            validPixROI2->width = _validPixROI2.width;
            validPixROI2->height = _validPixROI2.height;
        }
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_stereoRectifyUncalibrated(MatIn points1, MatIn points2, MatIn F, CvSize imgSize, MatOut H1, MatOut H2,
                                       double threshold, bool *rval, CvCallback_0 callback) {
    BEGIN_WRAP
        *rval = cv::stereoRectifyUncalibrated(
            CVDEREF(points1),
            CVDEREF(points2),
            CVDEREF(F),
            cv::Size(imgSize.width, imgSize.height),
            CVDEREF(H1),
            CVDEREF(H2),
            threshold
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_triangulatePoints(MatIn projMatr1, MatIn projMatr2, MatIn projPoints1, MatIn projPoints2, MatOut points4D,
                               CvCallback_0 callback) {
    BEGIN_WRAP
        cv::triangulatePoints(
            CVDEREF(projMatr1),
            CVDEREF(projMatr2),
            CVDEREF(projPoints1),
            CVDEREF(projPoints2),
            CVDEREF(points4D)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_undistort(
    Mat src, Mat dst, Mat cameraMatrix, Mat distCoeffs, Mat newCameraMatrix, CvCallback_0 callback
) {
    BEGIN_WRAP
        cv::undistort(
            CVDEREF(src),
            CVDEREF(dst),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(newCameraMatrix)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_undistortImagePoints(Mat src, Mat dst, Mat cameraMatrix, Mat distCoeffs, struct TermCriteria criteria,
                                  CvCallback_0 callback) {
    BEGIN_WRAP
        cv::undistortImagePoints(
            CVDEREF(src),
            CVDEREF(dst),
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon)
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_undistortPoints(
    Mat distorted,
    Mat undistorted,
    Mat k,
    Mat d,
    Mat r,
    Mat p,
    TermCriteria criteria,
    CvCallback_0 callback
) {
    BEGIN_WRAP
        auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
        cv::undistortPoints(
            CVDEREF(distorted), CVDEREF(undistorted), CVDEREF(k), CVDEREF(d), CVDEREF(r), CVDEREF(p), tc
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}

CvStatus *cv_validateDisparity(Mat disparity, Mat cost, int minDisparity, int numberOfDisparities, int disp12MaxDisp,
                               CvCallback_0 callback) {
    BEGIN_WRAP
        cv::validateDisparity(
            CVDEREF(disparity), CVDEREF(cost), minDisparity, numberOfDisparities, disp12MaxDisp
        );
        if (callback != nullptr) {
            callback();
        }
    END_WRAP
}
