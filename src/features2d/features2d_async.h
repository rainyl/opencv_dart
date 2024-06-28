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
CvStatus *AKAZE_Close_Async(AKAZEPtr a, CvCallback_0 callback);
CvStatus *AKAZE_Detect_Async(AKAZE a, Mat src, CvCallback_1 callback);
CvStatus *AKAZE_DetectAndCompute_Async(AKAZE a, Mat src, Mat mask, Mat desc, CvCallback_1 callback);

// AgastFeatureDetector
CvStatus *AgastFeatureDetector_Create_Async(CvCallback_1 callback);
CvStatus *AgastFeatureDetector_Close_Async(AgastFeatureDetectorPtr a, CvCallback_0 callback);
CvStatus *AgastFeatureDetector_Detect_Async(AgastFeatureDetector a, Mat src, CvCallback_1 callback);

// BRISK
CvStatus *BRISK_Create_Async(CvCallback_1 callback);
CvStatus *BRISK_Close_Async(BRISKPtr b, CvCallback_0 callback);
CvStatus *BRISK_Detect_Async(BRISK b, Mat src, CvCallback_1 callback);
CvStatus *BRISK_DetectAndCompute_Async(BRISK b, Mat src, Mat mask, Mat desc, CvCallback_1 callback);

// FastFeatureDetector
CvStatus *FastFeatureDetector_Create_Async(CvCallback_1 callback);
CvStatus *FastFeatureDetector_CreateWithParams_Async(int threshold, bool nonmaxSuppression, int type, CvCallback_1 callback);
CvStatus *FastFeatureDetector_Close_Async(FastFeatureDetectorPtr f, CvCallback_0 callback);
CvStatus *FastFeatureDetector_Detect_Async(FastFeatureDetector f, Mat src, CvCallback_1 callback);

// GFTTDetector
CvStatus *GFTTDetector_Create_Async(CvCallback_1 callback);
CvStatus *GFTTDetector_Close_Async(GFTTDetectorPtr a, CvCallback_0 callback);
CvStatus *GFTTDetector_Detect_Async(GFTTDetector a, Mat src, CvCallback_1 callback);

// KAZE
CvStatus *KAZE_Create_Async(CvCallback_1 callback);
CvStatus *KAZE_Close_Async(KAZEPtr a, CvCallback_0 callback);
CvStatus *KAZE_Detect_Async(KAZE a, Mat src, CvCallback_1 callback);
CvStatus *KAZE_DetectAndCompute_Async(KAZE a, Mat src, Mat mask, Mat desc, CvCallback_1 callback);

// MSER
CvStatus *MSER_Create_Async(CvCallback_1 callback);
CvStatus *MSER_Close_Async(MSERPtr a, CvCallback_0 callback);
CvStatus *MSER_Detect_Async(MSER a, Mat src, CvCallback_1 callback);

// ORB
CvStatus *ORB_Create_Async(CvCallback_1 callback);
CvStatus *ORB_CreateWithParams_Async(int nfeatures, float scaleFactor, int nlevels, int edgeThreshold, int firstLevel, int WTA_K, int scoreType, int patchSize, int fastThreshold, CvCallback_1 callback);
CvStatus *ORB_Close_Async(ORBPtr o, CvCallback_0 callback);
CvStatus *ORB_Detect_Async(ORB o, Mat src, CvCallback_1 callback);
CvStatus *ORB_DetectAndCompute_Async(ORB o, Mat src, Mat mask, Mat desc, CvCallback_1 callback);

// SimpleBlobDetector
CvStatus *SimpleBlobDetector_Create_Async(CvCallback_1 callback);
CvStatus *SimpleBlobDetector_Create_WithParams_Async(SimpleBlobDetectorParams params, CvCallback_1 callback);
CvStatus *SimpleBlobDetector_Close_Async(SimpleBlobDetectorPtr b, CvCallback_0 callback);
CvStatus *SimpleBlobDetector_Detect_Async(SimpleBlobDetector b, Mat src, CvCallback_1 callback);

// BFMatcher
CvStatus *BFMatcher_Create_Async(CvCallback_1 callback);
CvStatus *BFMatcher_CreateWithParams_Async(int normType, bool crossCheck, CvCallback_1 callback);
CvStatus *BFMatcher_Close_Async(BFMatcherPtr b, CvCallback_0 callback);
CvStatus *BFMatcher_Match_Async(BFMatcher b, Mat query, Mat train, CvCallback_1 callback);
CvStatus *BFMatcher_KnnMatch_Async(BFMatcher b, Mat query, Mat train, int k, CvCallback_1 callback);

// FlannBasedMatcher
CvStatus *FlannBasedMatcher_Create_Async(CvCallback_1 callback);
CvStatus *FlannBasedMatcher_Close_Async(FlannBasedMatcherPtr f, CvCallback_0 callback);
CvStatus *FlannBasedMatcher_KnnMatch_Async(FlannBasedMatcher f, Mat query, Mat train, int k, CvCallback_1 callback);

// Utility functions
CvStatus *DrawKeyPoints_Async(Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback);
CvStatus *DrawMatches_Async(Mat img1, VecKeyPoint kp1, Mat img2, VecKeyPoint kp2, VecDMatch matches1to2, Mat outImg, const Scalar matchesColor, const Scalar pointColor, VecChar matchesMask, int flags, CvCallback_0 callback);

// SIFT
CvStatus *SIFT_Create_Async(CvCallback_1 callback);
CvStatus *SIFT_Close_Async(SIFTPtr f, CvCallback_0 callback);
CvStatus *SIFT_Detect_Async(SIFT f, Mat src, CvCallback_1 callback);
CvStatus *SIFT_DetectAndCompute_Async(SIFT f, Mat src, Mat mask, Mat desc, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_FEATURES2D_ASYNC_H_
