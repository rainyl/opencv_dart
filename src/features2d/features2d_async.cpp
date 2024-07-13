/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#include "features2d_async.h"
#include "utils.hpp"

#include "core/types.h"
#include "core/vec.hpp"

// Asynchronous functions for AKAZE
CvStatus *AKAZE_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new AKAZE{new cv::Ptr<cv::AKAZE>(cv::AKAZE::create())});
  END_WRAP
}

CvStatus *AKAZE_Close_Async(AKAZEPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *AKAZE_Detect_Async(AKAZE self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

CvStatus *AKAZE_DetectAndCompute_Async(AKAZE self, Mat src, Mat mask, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  cv::Mat desc;
  (*self.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, desc);
  callback(veckeypoint_cpp2c_p(detected), new Mat{new cv::Mat(desc)});
  END_WRAP
}

// Asynchronous functions for AgastFeatureDetector
CvStatus *AgastFeatureDetector_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new AgastFeatureDetector{
      new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create())
  });
  END_WRAP
}

CvStatus *AgastFeatureDetector_Close_Async(AgastFeatureDetectorPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *
AgastFeatureDetector_Detect_Async(AgastFeatureDetector self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

// Asynchronous functions for BRISK
CvStatus *BRISK_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new BRISK{new cv::Ptr<cv::BRISK>(cv::BRISK::create())});
  END_WRAP
}

CvStatus *BRISK_Close_Async(BRISKPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *BRISK_Detect_Async(BRISK self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

CvStatus *BRISK_DetectAndCompute_Async(BRISK self, Mat src, Mat mask, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  cv::Mat desc;
  (*self.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, desc);
  callback(veckeypoint_cpp2c_p(detected), new Mat{new cv::Mat(desc)});
  END_WRAP
}

// Asynchronous functions for FastFeatureDetector
CvStatus *FastFeatureDetector_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new FastFeatureDetector{
      new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create())
  });
  END_WRAP
}

CvStatus *FastFeatureDetector_CreateWithParams_Async(
    int threshold, bool nonmaxSuppression, int type, CvCallback_1 callback
) {
  BEGIN_WRAP
  auto type_ = static_cast<cv::FastFeatureDetector::DetectorType>(type);
  callback(new FastFeatureDetector{new cv::Ptr<cv::FastFeatureDetector>(
      cv::FastFeatureDetector::create(threshold, nonmaxSuppression, type_)
  )});
  END_WRAP
}

CvStatus *FastFeatureDetector_Close_Async(FastFeatureDetectorPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *
FastFeatureDetector_Detect_Async(FastFeatureDetector self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

// Asynchronous functions for GFTTDetector
CvStatus *GFTTDetector_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new GFTTDetector{new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create())});
  END_WRAP
}

CvStatus *GFTTDetector_Close_Async(GFTTDetectorPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *GFTTDetector_Detect_Async(GFTTDetector self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

// Asynchronous functions for KAZE
CvStatus *KAZE_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new KAZE{new cv::Ptr<cv::KAZE>(cv::KAZE::create())});
  END_WRAP
}

CvStatus *KAZE_Close_Async(KAZEPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *KAZE_Detect_Async(KAZE self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

CvStatus *KAZE_DetectAndCompute_Async(KAZE self, Mat src, Mat mask, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  cv::Mat desc;
  (*self.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, desc);
  callback(veckeypoint_cpp2c_p(detected), new Mat{new cv::Mat(desc)});
  END_WRAP
}

// Asynchronous functions for MSER
CvStatus *MSER_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new MSER{new cv::Ptr<cv::MSER>(cv::MSER::create())});
  END_WRAP
}

CvStatus *MSER_Close_Async(MSERPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *MSER_Detect_Async(MSER self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

// Asynchronous functions for ORB
CvStatus *ORB_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new ORB{new cv::Ptr<cv::ORB>(cv::ORB::create())});
  END_WRAP
}

CvStatus *ORB_CreateWithParams_Async(
    int nfeatures,
    float scaleFactor,
    int nlevels,
    int edgeThreshold,
    int firstLevel,
    int WTA_K,
    int scoreType,
    int patchSize,
    int fastThreshold,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  auto type = static_cast<cv::ORB::ScoreType>(scoreType);
  callback(new ORB{new cv::Ptr<cv::ORB>(cv::ORB::create(
      nfeatures,
      scaleFactor,
      nlevels,
      edgeThreshold,
      firstLevel,
      WTA_K,
      type,
      patchSize,
      fastThreshold
  ))});
  END_WRAP
}

CvStatus *ORB_Close_Async(ORBPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *ORB_Detect_Async(ORB self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

CvStatus *ORB_DetectAndCompute_Async(ORB self, Mat src, Mat mask, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  cv::Mat desc;
  (*self.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, desc);
  callback(veckeypoint_cpp2c_p(detected), new Mat{new cv::Mat(desc)});
  END_WRAP
}

// Asynchronous functions for SimpleBlobDetector
CvStatus *SimpleBlobDetector_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(
      new SimpleBlobDetector{new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create())}
  );
  END_WRAP
}

CvStatus *
SimpleBlobDetector_Create_WithParams_Async(SimpleBlobDetectorParams params, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new SimpleBlobDetector{new cv::Ptr<cv::SimpleBlobDetector>(
      cv::SimpleBlobDetector::create(ConvertCParamsToCPPParams(params))
  )});
  END_WRAP
}

CvStatus *SimpleBlobDetector_Close_Async(SimpleBlobDetectorPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *SimpleBlobDetector_Detect_Async(SimpleBlobDetector self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

// Asynchronous functions for BFMatcher
CvStatus *BFMatcher_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new BFMatcher{new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create())});
  END_WRAP
}

CvStatus *BFMatcher_CreateWithParams_Async(int normType, bool crossCheck, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new BFMatcher{new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create(normType, crossCheck))});
  END_WRAP
}

CvStatus *BFMatcher_Close_Async(BFMatcherPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *BFMatcher_Match_Async(BFMatcher self, Mat query, Mat train, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::DMatch> matches;
  (*self.ptr)->match(*query.ptr, *train.ptr, matches);
  callback(vecdmatch_cpp2c_p(matches));
  END_WRAP
}

CvStatus *
BFMatcher_KnnMatch_Async(BFMatcher self, Mat query, Mat train, int k, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<std::vector<cv::DMatch>> matches;
  (*self.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
  callback(vecvecdmatch_cpp2c_p(matches));
  END_WRAP
}

// Asynchronous functions for FlannBasedMatcher
CvStatus *FlannBasedMatcher_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new FlannBasedMatcher{new cv::Ptr<cv::FlannBasedMatcher>(cv::FlannBasedMatcher::create())
  });
  END_WRAP
}

CvStatus *FlannBasedMatcher_Close_Async(FlannBasedMatcherPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *FlannBasedMatcher_KnnMatch_Async(
    FlannBasedMatcher self, Mat query, Mat train, int k, CvCallback_1 callback
) {
  BEGIN_WRAP
  std::vector<std::vector<cv::DMatch>> matches;
  (*self.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
  callback(vecvecdmatch_cpp2c_p(matches));
  END_WRAP
}

// Asynchronous utility functions
CvStatus *DrawKeyPoints_Async(
    Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback
) {
  BEGIN_WRAP
  auto color_ = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
  auto _kp = veckeypoint_c2cpp(kp);
  cv::drawKeypoints(*src.ptr, _kp, *dst.ptr, color_, static_cast<cv::DrawMatchesFlags>(flags));
  callback();
  END_WRAP
}

CvStatus *DrawMatches_Async(
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
  callback();
  END_WRAP
}

// Asynchronous functions for SIFT
CvStatus *SIFT_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new SIFT{new cv::Ptr<cv::SIFT>(cv::SIFT::create())});
  END_WRAP
}

CvStatus *SIFT_Close_Async(SIFTPtr self, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->reset();
  CVD_FREE(self);
  callback();
  END_WRAP
}

CvStatus *SIFT_Detect_Async(SIFT self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  (*self.ptr)->detect(*src.ptr, detected);
  callback(veckeypoint_cpp2c_p(detected));
  END_WRAP
}

CvStatus *SIFT_DetectAndCompute_Async(SIFT self, Mat src, Mat mask, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<cv::KeyPoint> detected;
  cv::Mat desc;
  (*self.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, desc);
  callback(veckeypoint_cpp2c_p(detected), new Mat{new cv::Mat(desc)});
  END_WRAP
}
