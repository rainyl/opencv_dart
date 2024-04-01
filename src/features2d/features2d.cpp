/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "features2d.h"

CvStatus AKAZE_Create(AKAZE *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::AKAZE>(cv::AKAZE::create())};
  END_WRAP
}
void AKAZE_Close(AKAZE *a)
{
  delete a->ptr;
  a->ptr = nullptr;
}
CvStatus AKAZE_Detect(AKAZE a, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}
CvStatus AKAZE_DetectAndCompute(AKAZE a, Mat src, Mat mask, Mat desc, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus AgastFeatureDetector_Create(AgastFeatureDetector *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create())};
  END_WRAP
}
void AgastFeatureDetector_Close(AgastFeatureDetector *a)
{
  delete a->ptr;
  a->ptr = nullptr;
}
CvStatus AgastFeatureDetector_Detect(AgastFeatureDetector a, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus BRISK_Create(BRISK *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BRISK>(cv::BRISK::create())};
  END_WRAP
}
void BRISK_Close(BRISK *b)
{
  delete b->ptr;
  b->ptr = nullptr;
}
CvStatus BRISK_Detect(BRISK b, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*b.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}
CvStatus BRISK_DetectAndCompute(BRISK b, Mat src, Mat mask, Mat desc, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*b.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus FastFeatureDetector_Create(FastFeatureDetector *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create())};
  END_WRAP
}
CvStatus FastFeatureDetector_CreateWithParams(int threshold, bool nonmaxSuppression, int type,
                                              FastFeatureDetector *rval)
{
  BEGIN_WRAP
  auto type_ = static_cast<cv::FastFeatureDetector::DetectorType>(type);
  *rval = {new cv::Ptr<cv::FastFeatureDetector>(
      cv::FastFeatureDetector::create(threshold, nonmaxSuppression, type_))};
  END_WRAP
}
void FastFeatureDetector_Close(FastFeatureDetector *f)
{
  delete f->ptr;
  f->ptr = nullptr;
}
CvStatus FastFeatureDetector_Detect(FastFeatureDetector f, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*f.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus GFTTDetector_Create(GFTTDetector *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create())};
  END_WRAP
}
void GFTTDetector_Close(GFTTDetector *a)
{
  delete a->ptr;
  a->ptr = nullptr;
}
CvStatus GFTTDetector_Detect(GFTTDetector a, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus KAZE_Create(KAZE *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::KAZE>(cv::KAZE::create())};
  END_WRAP
}
void KAZE_Close(KAZE *a)
{
  delete a->ptr;
  a->ptr = nullptr;
}
CvStatus KAZE_Detect(KAZE a, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}
CvStatus KAZE_DetectAndCompute(KAZE a, Mat src, Mat mask, Mat desc, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus MSER_Create(MSER *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::MSER>(cv::MSER::create())};
  END_WRAP
}
void MSER_Close(MSER *a)
{
  delete a->ptr;
  a->ptr = nullptr;
}
CvStatus MSER_Detect(MSER a, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus ORB_Create(ORB *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ORB>(cv::ORB::create())};
  END_WRAP
}
CvStatus ORB_CreateWithParams(int nfeatures, float scaleFactor, int nlevels, int edgeThreshold,
                              int firstLevel, int WTA_K, int scoreType, int patchSize, int fastThreshold,
                              ORB *rval)
{
  BEGIN_WRAP
  auto type = static_cast<cv::ORB::ScoreType>(scoreType);
  *rval = {new cv::Ptr<cv::ORB>(cv::ORB::create(nfeatures, scaleFactor, nlevels, edgeThreshold, firstLevel,
                                                WTA_K, type, patchSize, fastThreshold))};
  END_WRAP
}
void ORB_Close(ORB *o)
{
  delete o->ptr;
  o->ptr = nullptr;
}
CvStatus ORB_Detect(ORB o, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*o.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}
CvStatus ORB_DetectAndCompute(ORB o, Mat src, Mat mask, Mat desc, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*o.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

cv::SimpleBlobDetector::Params ConvertCParamsToCPPParams(SimpleBlobDetectorParams params)
{
  cv::SimpleBlobDetector::Params converted;

  converted.blobColor = params.blobColor;
  converted.filterByArea = params.filterByArea;
  converted.filterByCircularity = params.filterByCircularity;
  converted.filterByColor = params.filterByColor;
  converted.filterByConvexity = params.filterByConvexity;
  converted.filterByInertia = params.filterByInertia;
  converted.maxArea = params.maxArea;
  converted.maxCircularity = params.maxCircularity;
  converted.maxConvexity = params.maxConvexity;
  converted.maxInertiaRatio = params.maxInertiaRatio;
  converted.maxThreshold = params.maxThreshold;
  converted.minArea = params.minArea;
  converted.minCircularity = params.minCircularity;
  converted.minConvexity = params.minConvexity;
  converted.minDistBetweenBlobs = params.minDistBetweenBlobs;
  converted.minInertiaRatio = params.minInertiaRatio;
  converted.minRepeatability = params.minRepeatability;
  converted.minThreshold = params.minThreshold;
  converted.thresholdStep = params.thresholdStep;

  return converted;
}

SimpleBlobDetectorParams ConvertCPPParamsToCParams(cv::SimpleBlobDetector::Params params)
{
  SimpleBlobDetectorParams converted;

  converted.blobColor = params.blobColor;
  converted.filterByArea = params.filterByArea;
  converted.filterByCircularity = params.filterByCircularity;
  converted.filterByColor = params.filterByColor;
  converted.filterByConvexity = params.filterByConvexity;
  converted.filterByInertia = params.filterByInertia;
  converted.maxArea = params.maxArea;
  converted.maxCircularity = params.maxCircularity;
  converted.maxConvexity = params.maxConvexity;
  converted.maxInertiaRatio = params.maxInertiaRatio;
  converted.maxThreshold = params.maxThreshold;
  converted.minArea = params.minArea;
  converted.minCircularity = params.minCircularity;
  converted.minConvexity = params.minConvexity;
  converted.minDistBetweenBlobs = params.minDistBetweenBlobs;
  converted.minInertiaRatio = params.minInertiaRatio;
  converted.minRepeatability = params.minRepeatability;
  converted.minThreshold = params.minThreshold;
  converted.thresholdStep = params.thresholdStep;

  return converted;
}

CvStatus SimpleBlobDetector_Create(SimpleBlobDetector *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create())};
  END_WRAP
}
CvStatus SimpleBlobDetector_Create_WithParams(SimpleBlobDetectorParams params, SimpleBlobDetector *rval)
{
  BEGIN_WRAP
  *rval = {
      new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create(ConvertCParamsToCPPParams(params)))};
  END_WRAP
}
void SimpleBlobDetector_Close(SimpleBlobDetector *b)
{
  delete b->ptr;
  b->ptr = nullptr;
}
CvStatus SimpleBlobDetector_Detect(SimpleBlobDetector b, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*b.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}
CvStatus SimpleBlobDetectorParams_Create(SimpleBlobDetectorParams *rval)
{
  BEGIN_WRAP
  *rval = ConvertCPPParamsToCParams(cv::SimpleBlobDetector::Params());
  END_WRAP
}

CvStatus BFMatcher_Create(BFMatcher *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create())};
  END_WRAP
}
CvStatus BFMatcher_CreateWithParams(int normType, bool crossCheck, BFMatcher *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create(normType, crossCheck))};
  END_WRAP
}
void BFMatcher_Close(BFMatcher *b)
{
  delete b->ptr;
  b->ptr = nullptr;
}
CvStatus BFMatcher_Match(BFMatcher b, Mat query, Mat train, VecDMatch *rval)
{
  BEGIN_WRAP
  std::vector<cv::DMatch> matches = std::vector<cv::DMatch>();
  (*b.ptr)->match(*query.ptr, *train.ptr, matches);
  *rval = {new std::vector<cv::DMatch>(matches)};
  END_WRAP
}
CvStatus BFMatcher_KnnMatch(BFMatcher b, Mat query, Mat train, int k, VecVecDMatch *rval)
{
  BEGIN_WRAP
  std::vector<std::vector<cv::DMatch>> matches = std::vector<std::vector<cv::DMatch>>();
  (*b.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
  *rval = {new std::vector<std::vector<cv::DMatch>>(matches)};
  END_WRAP
}

CvStatus FlannBasedMatcher_Create(FlannBasedMatcher *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::FlannBasedMatcher>(cv::FlannBasedMatcher::create())};
  END_WRAP
}
void FlannBasedMatcher_Close(FlannBasedMatcher *f)
{
  delete f->ptr;
  f->ptr = nullptr;
}
CvStatus FlannBasedMatcher_KnnMatch(FlannBasedMatcher f, Mat query, Mat train, int k, VecVecDMatch *rval)
{
  BEGIN_WRAP
  std::vector<std::vector<cv::DMatch>> matches = std::vector<std::vector<cv::DMatch>>();
  (*f.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
  *rval = {new std::vector<std::vector<cv::DMatch>>(matches)};
  END_WRAP
}

CvStatus DrawKeyPoints(Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags)
{
  BEGIN_WRAP
  auto color_ = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
  cv::drawKeypoints(*src.ptr, *kp.ptr, *dst.ptr, color_, static_cast<cv::DrawMatchesFlags>(flags));
  END_WRAP
}

CvStatus SIFT_Create(SIFT *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::SIFT>(cv::SIFT::create())};
  END_WRAP
}
void SIFT_Close(SIFT *f)
{
  delete f->ptr;
  f->ptr = nullptr;
}
CvStatus SIFT_Detect(SIFT f, Mat src, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*f.ptr)->detect(*src.ptr, detected);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}
CvStatus SIFT_DetectAndCompute(SIFT f, Mat src, Mat mask, Mat desc, VecKeyPoint *rval)
{
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*f.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = {new std::vector<cv::KeyPoint>(detected)};
  END_WRAP
}

CvStatus DrawMatches(Mat img1, VecKeyPoint kp1, Mat img2, VecKeyPoint kp2, VecDMatch matches1to2, Mat outImg,
                     const Scalar matchesColor, const Scalar pointColor, VecChar matchesMask, int flags)
{
  BEGIN_WRAP
  auto mColor = cv::Scalar(matchesColor.val1, matchesColor.val2, matchesColor.val3, matchesColor.val4);
  auto pColor = cv::Scalar(pointColor.val1, pointColor.val2, pointColor.val3, pointColor.val4);
  cv::drawMatches(*img1.ptr, *kp1.ptr, *img2.ptr, *kp2.ptr, *matches1to2.ptr, *outImg.ptr, mColor, pColor,
                  *matchesMask.ptr, static_cast<cv::DrawMatchesFlags>(flags));
  END_WRAP
}
