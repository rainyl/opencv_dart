/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_FEATURES2D_H_
#define CVD_FEATURES2D_H_

#ifdef __cplusplus
#include <opencv2/features2d.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"
#include <stddef.h>
#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::AKAZE>, AKAZE);
CVD_TYPEDEF(cv::Ptr<cv::AgastFeatureDetector>, AgastFeatureDetector);
CVD_TYPEDEF(cv::Ptr<cv::BRISK>, BRISK);
CVD_TYPEDEF(cv::Ptr<cv::FastFeatureDetector>, FastFeatureDetector);
CVD_TYPEDEF(cv::Ptr<cv::GFTTDetector>, GFTTDetector);
CVD_TYPEDEF(cv::Ptr<cv::KAZE>, KAZE);
CVD_TYPEDEF(cv::Ptr<cv::MSER>, MSER);
CVD_TYPEDEF(cv::Ptr<cv::ORB>, ORB);
CVD_TYPEDEF(cv::Ptr<cv::SimpleBlobDetector>, SimpleBlobDetector);
CVD_TYPEDEF(cv::Ptr<cv::BFMatcher>, BFMatcher);
CVD_TYPEDEF(cv::Ptr<cv::FlannBasedMatcher>, FlannBasedMatcher);
CVD_TYPEDEF(cv::Ptr<cv::SIFT>, SIFT);
#else
CVD_TYPEDEF(void, AKAZE);
CVD_TYPEDEF(void, AgastFeatureDetector);
CVD_TYPEDEF(void, BRISK);
CVD_TYPEDEF(void, FastFeatureDetector);
CVD_TYPEDEF(void, GFTTDetector);
CVD_TYPEDEF(void, KAZE);
CVD_TYPEDEF(void, MSER);
CVD_TYPEDEF(void, ORB);
CVD_TYPEDEF(void, SimpleBlobDetector);
CVD_TYPEDEF(void, BFMatcher);
CVD_TYPEDEF(void, FlannBasedMatcher);
CVD_TYPEDEF(void, SIFT);
#endif

// Wrapper for SimpleBlobDetectorParams aka SimpleBlobDetector::Params
typedef struct SimpleBlobDetectorParams {
    unsigned char blobColor;
    bool filterByArea;
    bool filterByCircularity;
    bool filterByColor;
    bool filterByConvexity;
    bool filterByInertia;
    float maxArea;
    float maxCircularity;
    float maxConvexity;
    float maxInertiaRatio;
    float maxThreshold;
    float minArea;
    float minCircularity;
    float minConvexity;
    float minDistBetweenBlobs;
    float minInertiaRatio;
    size_t minRepeatability;
    float minThreshold;
    float thresholdStep;
} SimpleBlobDetectorParams;

CvStatus* cv_AKAZE_create(AKAZE* rval);
void cv_AKAZE_close(AKAZEPtr self);
CvStatus* cv_AKAZE_detect(AKAZE self, Mat src, VecKeyPoint* rval, CvCallback_0 callback);
CvStatus* cv_AKAZE_detectAndCompute(
    AKAZE self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_AgastFeatureDetector_create(AgastFeatureDetector* rval);
void cv_AgastFeatureDetector_close(AgastFeatureDetectorPtr self);
CvStatus* cv_AgastFeatureDetector_detect(
    AgastFeatureDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_BRISK_create(BRISK* rval);
void cv_BRISK_close(BRISKPtr self);
CvStatus* cv_BRISK_detect(BRISK self, Mat src, VecKeyPoint* rval, CvCallback_0 callback);
CvStatus* cv_BRISK_detectAndCompute(
    BRISK self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_FastFeatureDetector_create(FastFeatureDetector* rval);
CvStatus* cv_FastFeatureDetector_create_1(
    int threshold, bool nonmaxSuppression, int type, FastFeatureDetector* rval
);
void cv_FastFeatureDetector_close(FastFeatureDetectorPtr self);
CvStatus* cv_FastFeatureDetector_detect(
    FastFeatureDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_GFTTDetector_create(GFTTDetector* rval);
void cv_GFTTDetector_close(GFTTDetectorPtr self);
CvStatus* cv_GFTTDetector_detect(
    GFTTDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_KAZE_create(KAZE* rval);
void cv_KAZE_close(KAZEPtr self);
CvStatus* cv_KAZE_detect(KAZE self, Mat src, VecKeyPoint* rval, CvCallback_0 callback);
CvStatus* cv_KAZE_detectAndCompute(
    KAZE self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_MSER_create(MSER* rval);
void cv_MSER_close(MSERPtr self);
CvStatus* cv_MSER_detect(MSER self, Mat src, VecKeyPoint* rval, CvCallback_0 callback);

CvStatus* cv_ORB_create(ORB* rval);
CvStatus* cv_ORB_create_1(
    int nfeatures,
    float scaleFactor,
    int nlevels,
    int edgeThreshold,
    int firstLevel,
    int WTA_K,
    int scoreType,
    int patchSize,
    int fastThreshold,
    ORB* rval
);
void cv_ORB_close(ORBPtr self);
CvStatus* cv_ORB_detect(ORB self, Mat src, VecKeyPoint* rval, CvCallback_0 callback);
CvStatus* cv_ORB_detectAndCompute(
    ORB self, Mat src, Mat mask, VecKeyPoint* out_keypoints, Mat desc, bool useProvidedKeypoints, CvCallback_0 callback
);

CvStatus* cv_SimpleBlobDetector_create(SimpleBlobDetector* rval);
CvStatus* cv_SimpleBlobDetector_create_1(SimpleBlobDetectorParams params, SimpleBlobDetector* rval);
void cv_SimpleBlobDetector_close(SimpleBlobDetectorPtr self);
CvStatus* cv_SimpleBlobDetector_detect(
    SimpleBlobDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
);
CvStatus* cv_SimpleBlobDetectorParams_create(SimpleBlobDetectorParams* rval);

CvStatus* cv_BFMatcher_create(BFMatcher* rval);
CvStatus* cv_BFMatcher_create_1(int normType, bool crossCheck, BFMatcher* rval);
void cv_BFMatcher_close(BFMatcherPtr self);
CvStatus* cv_BFMatcher_match(
    BFMatcher self, Mat query, Mat train, VecDMatch* rval, CvCallback_0 callback
);
CvStatus* cv_BFMatcher_knnMatch(
    BFMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
);

CvStatus* cv_FlannBasedMatcher_create(FlannBasedMatcher* rval);
void cv_FlannBasedMatcher_close(FlannBasedMatcherPtr self);
CvStatus* cv_FlannBasedMatcher_knnMatch(
    FlannBasedMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
);

CvStatus* cv_drawKeyPoints(
    Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback
);

CvStatus* cv_SIFT_create(SIFT* rval);
void cv_SIFT_close(SIFTPtr self);
CvStatus* cv_SIFT_detect(SIFT self, Mat src, VecKeyPoint* rval, CvCallback_0 callback);
CvStatus* cv_SIFT_detectAndCompute(
    SIFT self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
);

CvStatus* cv_drawMatches(
    Mat img1,
    VecKeyPoint kp1,
    Mat img2,
    VecKeyPoint kp2,
    VecDMatch matches1to2,
    Mat outImg,
    const Scalar matchesColor,
    const Scalar pointColor,
    VecChar matchesMask,
    int flags,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  //CVD_FEATURES2D_H_
