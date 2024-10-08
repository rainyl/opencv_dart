/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#ifndef CVD_FEATURES2D_ASYNC_H_
#define CVD_FEATURES2D_ASYNC_H_

#include "core/types.h"
#include "features2d.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

// AKAZE
CvStatus *AKAZE_Create_Async(CvCallback_1 callback);
CvStatus *AKAZE_Close_Async(AKAZEPtr self, CvCallback_0 callback);
CvStatus *AKAZE_Detect_Async(AKAZE self, Mat src, CvCallback_1 callback);
CvStatus *AKAZE_DetectAndCompute_Async(AKAZE self, Mat src, Mat mask, CvCallback_2 callback);

// AgastFeatureDetector
CvStatus *AgastFeatureDetector_Create_Async(CvCallback_1 callback);
CvStatus *AgastFeatureDetector_Close_Async(AgastFeatureDetectorPtr self, CvCallback_0 callback);
CvStatus *AgastFeatureDetector_Detect_Async(AgastFeatureDetector self, Mat src, CvCallback_1 callback);

// BRISK
CvStatus *BRISK_Create_Async(CvCallback_1 callback);
CvStatus *BRISK_Close_Async(BRISKPtr self, CvCallback_0 callback);
CvStatus *BRISK_Detect_Async(BRISK self, Mat src, CvCallback_1 callback);
CvStatus *BRISK_DetectAndCompute_Async(BRISK self, Mat src, Mat mask, CvCallback_2 callback);

// FastFeatureDetector
CvStatus *FastFeatureDetector_Create_Async(CvCallback_1 callback);
CvStatus *FastFeatureDetector_CreateWithParams_Async(int threshold, bool nonmaxSuppression, int type, CvCallback_1 callback);
CvStatus *FastFeatureDetector_Close_Async(FastFeatureDetectorPtr self, CvCallback_0 callback);
CvStatus *FastFeatureDetector_Detect_Async(FastFeatureDetector self, Mat src, CvCallback_1 callback);

// GFTTDetector
CvStatus *GFTTDetector_Create_Async(CvCallback_1 callback);
CvStatus *GFTTDetector_Close_Async(GFTTDetectorPtr self, CvCallback_0 callback);
CvStatus *GFTTDetector_Detect_Async(GFTTDetector self, Mat src, CvCallback_1 callback);

// KAZE
CvStatus *KAZE_Create_Async(CvCallback_1 callback);
CvStatus *KAZE_Close_Async(KAZEPtr self, CvCallback_0 callback);
CvStatus *KAZE_Detect_Async(KAZE self, Mat src, CvCallback_1 callback);
CvStatus *KAZE_DetectAndCompute_Async(KAZE self, Mat src, Mat mask, CvCallback_2 callback);

// MSER
CvStatus *MSER_Create_Async(CvCallback_1 callback);
CvStatus *MSER_Close_Async(MSERPtr self, CvCallback_0 callback);
CvStatus *MSER_Detect_Async(MSER self, Mat src, CvCallback_1 callback);

// ORB
CvStatus *ORB_Create_Async(CvCallback_1 callback);
CvStatus *ORB_CreateWithParams_Async(int nfeatures, float scaleFactor, int nlevels, int edgeThreshold, int firstLevel, int WTA_K, int scoreType, int patchSize, int fastThreshold, CvCallback_1 callback);
CvStatus *ORB_Close_Async(ORBPtr self, CvCallback_0 callback);
CvStatus *ORB_Detect_Async(ORB self, Mat src, CvCallback_1 callback);
CvStatus *ORB_DetectAndCompute_Async(ORB self, Mat src, Mat mask, CvCallback_2 callback);

// SimpleBlobDetector
CvStatus *SimpleBlobDetector_Create_Async(CvCallback_1 callback);
CvStatus *SimpleBlobDetector_Create_WithParams_Async(SimpleBlobDetectorParams params, CvCallback_1 callback);
CvStatus *SimpleBlobDetector_Close_Async(SimpleBlobDetectorPtr self, CvCallback_0 callback);
CvStatus *SimpleBlobDetector_Detect_Async(SimpleBlobDetector self, Mat src, CvCallback_1 callback);

// BFMatcher
CvStatus *BFMatcher_Create_Async(CvCallback_1 callback);
CvStatus *BFMatcher_CreateWithParams_Async(int normType, bool crossCheck, CvCallback_1 callback);
CvStatus *BFMatcher_Close_Async(BFMatcherPtr self, CvCallback_0 callback);
CvStatus *BFMatcher_Match_Async(BFMatcher self, Mat query, Mat train, CvCallback_1 callback);
CvStatus *BFMatcher_KnnMatch_Async(BFMatcher self, Mat query, Mat train, int k, CvCallback_1 callback);

// FlannBasedMatcher
CvStatus *FlannBasedMatcher_Create_Async(CvCallback_1 callback);
CvStatus *FlannBasedMatcher_Close_Async(FlannBasedMatcherPtr self, CvCallback_0 callback);
CvStatus *FlannBasedMatcher_KnnMatch_Async(FlannBasedMatcher self, Mat query, Mat train, int k, CvCallback_1 callback);

// Utility functions
CvStatus *DrawKeyPoints_Async(Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback);
CvStatus *DrawMatches_Async(Mat img1, VecKeyPoint kp1, Mat img2, VecKeyPoint kp2, VecDMatch matches1to2, Mat outImg, const Scalar matchesColor, const Scalar pointColor, VecChar matchesMask, int flags, CvCallback_0 callback);

// SIFT
CvStatus *SIFT_Create_Async(CvCallback_1 callback);
CvStatus *SIFT_Close_Async(SIFTPtr self, CvCallback_0 callback);
CvStatus *SIFT_Detect_Async(SIFT self, Mat src, CvCallback_1 callback);
CvStatus *SIFT_DetectAndCompute_Async(SIFT self, Mat src, Mat mask, CvCallback_2 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_FEATURES2D_ASYNC_H_
