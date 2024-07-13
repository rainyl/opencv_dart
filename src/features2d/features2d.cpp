/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "features2d.h"
#include "core/vec.hpp"
#include "utils.hpp"

#include <iostream>

CvStatus *AKAZE_Create(AKAZE *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::AKAZE>(cv::AKAZE::create())};
  END_WRAP
}
void AKAZE_Close(AKAZEPtr a) {
  a->ptr->reset();
  CVD_FREE(a);
}

CvStatus *AKAZE_Detect(AKAZE a, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}
CvStatus *AKAZE_DetectAndCompute(AKAZE a, Mat src, Mat mask, Mat desc, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *AgastFeatureDetector_Create(AgastFeatureDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create())};
  END_WRAP
}
void AgastFeatureDetector_Close(AgastFeatureDetectorPtr a) {
  a->ptr->reset();
  CVD_FREE(a);
}

CvStatus *AgastFeatureDetector_Detect(AgastFeatureDetector a, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *BRISK_Create(BRISK *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BRISK>(cv::BRISK::create())};
  END_WRAP
}
void BRISK_Close(BRISKPtr b) {
  b->ptr->reset();
  CVD_FREE(b);
}

CvStatus *BRISK_Detect(BRISK b, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*b.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}
CvStatus *BRISK_DetectAndCompute(BRISK b, Mat src, Mat mask, Mat desc, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*b.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *FastFeatureDetector_Create(FastFeatureDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create())};
  END_WRAP
}
CvStatus *FastFeatureDetector_CreateWithParams(
    int threshold, bool nonmaxSuppression, int type, FastFeatureDetector *rval
) {
  BEGIN_WRAP
  auto type_ = static_cast<cv::FastFeatureDetector::DetectorType>(type);
  *rval = {new cv::Ptr<cv::FastFeatureDetector>(
      cv::FastFeatureDetector::create(threshold, nonmaxSuppression, type_)
  )};
  END_WRAP
}
void FastFeatureDetector_Close(FastFeatureDetectorPtr f) {
  f->ptr->reset();
  CVD_FREE(f);
}

CvStatus *FastFeatureDetector_Detect(FastFeatureDetector f, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*f.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *GFTTDetector_Create(GFTTDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create())};
  END_WRAP
}
void GFTTDetector_Close(GFTTDetectorPtr a) {
  a->ptr->reset();
  CVD_FREE(a);
}

CvStatus *GFTTDetector_Detect(GFTTDetector a, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *KAZE_Create(KAZE *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::KAZE>(cv::KAZE::create())};
  END_WRAP
}
void KAZE_Close(KAZEPtr a) {
  a->ptr->reset();
  CVD_FREE(a);
}

CvStatus *KAZE_Detect(KAZE a, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}
CvStatus *KAZE_DetectAndCompute(KAZE a, Mat src, Mat mask, Mat desc, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *MSER_Create(MSER *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::MSER>(cv::MSER::create())};
  END_WRAP
}
void MSER_Close(MSERPtr a) {
  a->ptr->reset();
  CVD_FREE(a);
}

CvStatus *MSER_Detect(MSER a, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*a.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *ORB_Create(ORB *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ORB>(cv::ORB::create())};
  END_WRAP
}
CvStatus *ORB_CreateWithParams(
    int nfeatures,
    float scaleFactor,
    int nlevels,
    int edgeThreshold,
    int firstLevel,
    int WTA_K,
    int scoreType,
    int patchSize,
    int fastThreshold,
    ORB *rval
) {
  BEGIN_WRAP
  auto type = static_cast<cv::ORB::ScoreType>(scoreType);
  *rval = {new cv::Ptr<cv::ORB>(cv::ORB::create(
      nfeatures,
      scaleFactor,
      nlevels,
      edgeThreshold,
      firstLevel,
      WTA_K,
      type,
      patchSize,
      fastThreshold
  ))};
  END_WRAP
}
void ORB_Close(ORBPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *ORB_Detect(const ORB self, const Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *ORB_DetectAndCompute(ORB self, Mat src, Mat mask, Mat *desc, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  cv::Mat _desc;
  (*self.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, _desc);
  *rval = veckeypoint_cpp2c(detected);
  *desc = {new cv::Mat(_desc)};
  END_WRAP
}

CvStatus *SimpleBlobDetector_Create(SimpleBlobDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create())};
  END_WRAP
}
CvStatus *
SimpleBlobDetector_Create_WithParams(SimpleBlobDetectorParams params, SimpleBlobDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::SimpleBlobDetector>(
      cv::SimpleBlobDetector::create(ConvertCParamsToCPPParams(params))
  )};
  END_WRAP
}
void SimpleBlobDetector_Close(SimpleBlobDetectorPtr b) {
  b->ptr->reset();
  CVD_FREE(b);
}

CvStatus *SimpleBlobDetector_Detect(SimpleBlobDetector b, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*b.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}
CvStatus *SimpleBlobDetectorParams_Create(SimpleBlobDetectorParams *rval) {
  BEGIN_WRAP
  *rval = ConvertCPPParamsToCParams(cv::SimpleBlobDetector::Params());
  END_WRAP
}

CvStatus *BFMatcher_Create(BFMatcher *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create())};
  END_WRAP
}
CvStatus *BFMatcher_CreateWithParams(int normType, bool crossCheck, BFMatcher *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create(normType, crossCheck))};
  END_WRAP
}
void BFMatcher_Close(BFMatcherPtr b) {
  b->ptr->reset();
  CVD_FREE(b);
}

CvStatus *BFMatcher_Match(BFMatcher b, Mat query, Mat train, VecDMatch *rval) {
  BEGIN_WRAP
  std::vector<cv::DMatch> matches = std::vector<cv::DMatch>();
  (*b.ptr)->match(*query.ptr, *train.ptr, matches);
  *rval = vecdmatch_cpp2c(matches);
  END_WRAP
}
CvStatus *BFMatcher_KnnMatch(BFMatcher b, Mat query, Mat train, int k, VecVecDMatch *rval) {
  BEGIN_WRAP
  std::vector<std::vector<cv::DMatch>> matches = std::vector<std::vector<cv::DMatch>>();
  (*b.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
  *rval = vecvecdmatch_cpp2c(matches);
  END_WRAP
}

CvStatus *FlannBasedMatcher_Create(FlannBasedMatcher *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::FlannBasedMatcher>(cv::FlannBasedMatcher::create())};
  END_WRAP
}
void FlannBasedMatcher_Close(FlannBasedMatcherPtr f) {
  f->ptr->reset();
  CVD_FREE(f);
}

CvStatus *
FlannBasedMatcher_KnnMatch(FlannBasedMatcher f, Mat query, Mat train, int k, VecVecDMatch *rval) {
  BEGIN_WRAP
  std::vector<std::vector<cv::DMatch>> matches = std::vector<std::vector<cv::DMatch>>();
  (*f.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
  *rval = vecvecdmatch_cpp2c(matches);
  END_WRAP
}

CvStatus *DrawKeyPoints(Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags) {
  BEGIN_WRAP
  auto color_ = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
  auto _kp = veckeypoint_c2cpp(kp);
  cv::drawKeypoints(*src.ptr, _kp, *dst.ptr, color_, static_cast<cv::DrawMatchesFlags>(flags));
  END_WRAP
}

CvStatus *SIFT_Create(SIFT *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::SIFT>(cv::SIFT::create())};
  END_WRAP
}
void SIFT_Close(SIFTPtr f) {
  f->ptr->reset();
  CVD_FREE(f);
}

CvStatus *SIFT_Detect(SIFT f, Mat src, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*f.ptr)->detect(*src.ptr, detected);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}
CvStatus *SIFT_DetectAndCompute(SIFT f, Mat src, Mat mask, Mat desc, VecKeyPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected = std::vector<cv::KeyPoint>();
  (*f.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
  *rval = veckeypoint_cpp2c(detected);
  END_WRAP
}

CvStatus *DrawMatches(
    Mat img1,
    VecKeyPoint kp1,
    Mat img2,
    VecKeyPoint kp2,
    VecDMatch matches1to2,
    Mat outImg,
    const Scalar matchesColor,
    const Scalar pointColor,
    VecChar matchesMask,
    int flags
) {
  BEGIN_WRAP
  auto mColor =
      cv::Scalar(matchesColor.val1, matchesColor.val2, matchesColor.val3, matchesColor.val4);
  auto pColor = cv::Scalar(pointColor.val1, pointColor.val2, pointColor.val3, pointColor.val4);
  auto _kp1 = veckeypoint_c2cpp(kp1);
  auto _kp2 = veckeypoint_c2cpp(kp2);
  auto _matches1to2 = vecdmatch_c2cpp(matches1to2);
  auto _matchesMask = vecchar_c2cpp(matchesMask);
  cv::drawMatches(
      *img1.ptr,
      _kp1,
      *img2.ptr,
      _kp2,
      _matches1to2,
      *outImg.ptr,
      mColor,
      pColor,
      _matchesMask,
      static_cast<cv::DrawMatchesFlags>(flags)
  );
  END_WRAP
}
