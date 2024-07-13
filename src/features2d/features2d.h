/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
#ifndef _OPENCV3_FEATURES2D_H_
#define _OPENCV3_FEATURES2D_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"
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
  bool          filterByArea;
  bool          filterByCircularity;
  bool          filterByColor;
  bool          filterByConvexity;
  bool          filterByInertia;
  float         maxArea;
  float         maxCircularity;
  float         maxConvexity;
  float         maxInertiaRatio;
  float         maxThreshold;
  float         minArea;
  float         minCircularity;
  float         minConvexity;
  float         minDistBetweenBlobs;
  float         minInertiaRatio;
  size_t        minRepeatability;
  float         minThreshold;
  float         thresholdStep;
} SimpleBlobDetectorParams;

CvStatus *AKAZE_Create(AKAZE *rval);
void      AKAZE_Close(AKAZEPtr a);
CvStatus *AKAZE_Detect(AKAZE a, Mat src, VecKeyPoint *rval);
CvStatus *AKAZE_DetectAndCompute(AKAZE a, Mat src, Mat mask, Mat desc, VecKeyPoint *rval);

CvStatus *AgastFeatureDetector_Create(AgastFeatureDetector *rval);
void      AgastFeatureDetector_Close(AgastFeatureDetectorPtr a);
CvStatus *AgastFeatureDetector_Detect(AgastFeatureDetector a, Mat src, VecKeyPoint *rval);

CvStatus *BRISK_Create(BRISK *rval);
void      BRISK_Close(BRISKPtr b);
CvStatus *BRISK_Detect(BRISK b, Mat src, VecKeyPoint *rval);
CvStatus *BRISK_DetectAndCompute(BRISK b, Mat src, Mat mask, Mat desc, VecKeyPoint *rval);

CvStatus *FastFeatureDetector_Create(FastFeatureDetector *rval);
CvStatus *FastFeatureDetector_CreateWithParams(int threshold, bool nonmaxSuppression, int type,
                                               FastFeatureDetector *rval);
void      FastFeatureDetector_Close(FastFeatureDetectorPtr f);
CvStatus *FastFeatureDetector_Detect(FastFeatureDetector f, Mat src, VecKeyPoint *rval);

CvStatus *GFTTDetector_Create(GFTTDetector *rval);
void      GFTTDetector_Close(GFTTDetectorPtr a);
CvStatus *GFTTDetector_Detect(GFTTDetector a, Mat src, VecKeyPoint *rval);

CvStatus *KAZE_Create(KAZE *rval);
void      KAZE_Close(KAZEPtr a);
CvStatus *KAZE_Detect(KAZE a, Mat src, VecKeyPoint *rval);
CvStatus *KAZE_DetectAndCompute(KAZE a, Mat src, Mat mask, Mat desc, VecKeyPoint *rval);

CvStatus *MSER_Create(MSER *rval);
void      MSER_Close(MSERPtr a);
CvStatus *MSER_Detect(MSER a, Mat src, VecKeyPoint *rval);

CvStatus *ORB_Create(ORB *rval);
CvStatus *ORB_CreateWithParams(int nfeatures, float scaleFactor, int nlevels, int edgeThreshold,
                               int firstLevel, int WTA_K, int scoreType, int patchSize, int fastThreshold,
                               ORB *rval);
void      ORB_Close(ORBPtr self);
CvStatus *ORB_Detect(ORB self, Mat src, VecKeyPoint *rval);
CvStatus *ORB_DetectAndCompute(ORB self, Mat src, Mat mask, Mat *desc, VecKeyPoint *rval);

CvStatus *SimpleBlobDetector_Create(SimpleBlobDetector *rval);
CvStatus *SimpleBlobDetector_Create_WithParams(SimpleBlobDetectorParams params, SimpleBlobDetector *rval);
void      SimpleBlobDetector_Close(SimpleBlobDetectorPtr b);
CvStatus *SimpleBlobDetector_Detect(SimpleBlobDetector b, Mat src, VecKeyPoint *rval);
CvStatus *SimpleBlobDetectorParams_Create(SimpleBlobDetectorParams *rval);

CvStatus *BFMatcher_Create(BFMatcher *rval);
CvStatus *BFMatcher_CreateWithParams(int normType, bool crossCheck, BFMatcher *rval);
void      BFMatcher_Close(BFMatcherPtr b);
CvStatus *BFMatcher_Match(BFMatcher b, Mat query, Mat train, VecDMatch *rval);
CvStatus *BFMatcher_KnnMatch(BFMatcher b, Mat query, Mat train, int k, VecVecDMatch *rval);

CvStatus *FlannBasedMatcher_Create(FlannBasedMatcher *rval);
void      FlannBasedMatcher_Close(FlannBasedMatcherPtr f);
CvStatus *FlannBasedMatcher_KnnMatch(FlannBasedMatcher f, Mat query, Mat train, int k, VecVecDMatch *rval);

CvStatus *DrawKeyPoints(Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags);

CvStatus *SIFT_Create(SIFT *rval);
void      SIFT_Close(SIFTPtr f);
CvStatus *SIFT_Detect(SIFT f, Mat src, VecKeyPoint *rval);
CvStatus *SIFT_DetectAndCompute(SIFT f, Mat src, Mat mask, Mat desc, VecKeyPoint *rval);

CvStatus *DrawMatches(Mat img1, VecKeyPoint kp1, Mat img2, VecKeyPoint kp2, VecDMatch matches1to2, Mat outImg,
                      const Scalar matchesColor, const Scalar pointColor, VecChar matchesMask, int flags);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_FEATURES2D_H_
