/* Created by Rainyl. Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl. */
#include "features2d_async.h"
#include "features2d.cpp"

#include "core/types.h"

// Asynchronous functions for AKAZE
CvStatus *AKAZE_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new AKAZE{new cv::Ptr<cv::AKAZE>(cv::AKAZE::create())});
    END_WRAP
}

CvStatus *AKAZE_Close_Async(AKAZEPtr a, CvCallback_0 callback)
{
    BEGIN_WRAP
    a->ptr->reset();
    CVD_FREE(a);
    callback();
    END_WRAP
}

CvStatus *AKAZE_Detect_Async(AKAZE a, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

CvStatus *AKAZE_DetectAndCompute_Async(AKAZE a, Mat src, Mat mask, Mat desc, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for AgastFeatureDetector
CvStatus *AgastFeatureDetector_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new AgastFeatureDetector{new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create())});
    END_WRAP
}

CvStatus *AgastFeatureDetector_Close_Async(AgastFeatureDetectorPtr a, CvCallback_0 callback)
{
    BEGIN_WRAP
    a->ptr->reset();
    CVD_FREE(a);
    callback();
    END_WRAP
}

CvStatus *AgastFeatureDetector_Detect_Async(AgastFeatureDetector a, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for BRISK
CvStatus *BRISK_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new BRISK{new cv::Ptr<cv::BRISK>(cv::BRISK::create())});
    END_WRAP
}

CvStatus *BRISK_Close_Async(BRISKPtr b, CvCallback_0 callback)
{
    BEGIN_WRAP
    b->ptr->reset();
    CVD_FREE(b);
    callback();
    END_WRAP
}

CvStatus *BRISK_Detect_Async(BRISK b, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*b.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

CvStatus *BRISK_DetectAndCompute_Async(BRISK b, Mat src, Mat mask, Mat desc, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*b.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for FastFeatureDetector
CvStatus *FastFeatureDetector_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new FastFeatureDetector{new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create())});
    END_WRAP
}

CvStatus *FastFeatureDetector_CreateWithParams_Async(int threshold, bool nonmaxSuppression, int type, CvCallback_1 callback)
{
    BEGIN_WRAP
    auto type_ = static_cast<cv::FastFeatureDetector::DetectorType>(type);
    callback(new FastFeatureDetector{new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create(threshold, nonmaxSuppression, type_))});
    END_WRAP
}

CvStatus *FastFeatureDetector_Close_Async(FastFeatureDetectorPtr f, CvCallback_0 callback)
{
    BEGIN_WRAP
    f->ptr->reset();
    CVD_FREE(f);
    callback();
    END_WRAP
}

CvStatus *FastFeatureDetector_Detect_Async(FastFeatureDetector f, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*f.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for GFTTDetector
CvStatus *GFTTDetector_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new GFTTDetector{new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create())});
    END_WRAP
}

CvStatus *GFTTDetector_Close_Async(GFTTDetectorPtr a, CvCallback_0 callback)
{
    BEGIN_WRAP
    a->ptr->reset();
    CVD_FREE(a);
    callback();
    END_WRAP
}

CvStatus *GFTTDetector_Detect_Async(GFTTDetector a, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for KAZE
CvStatus *KAZE_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new KAZE{new cv::Ptr<cv::KAZE>(cv::KAZE::create())});
    END_WRAP
}

CvStatus *KAZE_Close_Async(KAZEPtr a, CvCallback_0 callback)
{
    BEGIN_WRAP
    a->ptr->reset();
    CVD_FREE(a);
    callback();
    END_WRAP
}

CvStatus *KAZE_Detect_Async(KAZE a, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

CvStatus *KAZE_DetectAndCompute_Async(KAZE a, Mat src, Mat mask, Mat desc, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for MSER
CvStatus *MSER_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new MSER{new cv::Ptr<cv::MSER>(cv::MSER::create())});
    END_WRAP
}

CvStatus *MSER_Close_Async(MSERPtr a, CvCallback_0 callback)
{
    BEGIN_WRAP
    a->ptr->reset();
    CVD_FREE(a);
    callback();
    END_WRAP
}

CvStatus *MSER_Detect_Async(MSER a, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*a.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for ORB
CvStatus *ORB_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new ORB{new cv::Ptr<cv::ORB>(cv::ORB::create())});
    END_WRAP
}

CvStatus *ORB_CreateWithParams_Async(int nfeatures, float scaleFactor, int nlevels, int edgeThreshold, int firstLevel, int WTA_K, int scoreType, int patchSize, int fastThreshold, CvCallback_1 callback)
{
    BEGIN_WRAP
    auto type = static_cast<cv::ORB::ScoreType>(scoreType);
    callback(new ORB{new cv::Ptr<cv::ORB>(cv::ORB::create(nfeatures, scaleFactor, nlevels, edgeThreshold, firstLevel, WTA_K, type, patchSize, fastThreshold))});
    END_WRAP
}

CvStatus *ORB_Close_Async(ORBPtr o, CvCallback_0 callback)
{
    BEGIN_WRAP
    o->ptr->reset();
    CVD_FREE(o);
    callback();
    END_WRAP
}

CvStatus *ORB_Detect_Async(ORB o, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*o.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

CvStatus *ORB_DetectAndCompute_Async(ORB o, Mat src, Mat mask, Mat desc, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*o.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for SimpleBlobDetector
CvStatus *SimpleBlobDetector_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new SimpleBlobDetector{new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create())});
    END_WRAP
}

CvStatus *SimpleBlobDetector_Create_WithParams_Async(SimpleBlobDetectorParams params, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new SimpleBlobDetector{new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create(ConvertCParamsToCPPParams(params)))});
    END_WRAP
}

CvStatus *SimpleBlobDetector_Close_Async(SimpleBlobDetectorPtr b, CvCallback_0 callback)
{
    BEGIN_WRAP
    b->ptr->reset();
    CVD_FREE(b);
    callback();
    END_WRAP
}

CvStatus *SimpleBlobDetector_Detect_Async(SimpleBlobDetector b, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*b.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

// Asynchronous functions for BFMatcher
CvStatus *BFMatcher_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new BFMatcher{new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create())});
    END_WRAP
}

CvStatus *BFMatcher_CreateWithParams_Async(int normType, bool crossCheck, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new BFMatcher{new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create(normType, crossCheck))});
    END_WRAP
}

CvStatus *BFMatcher_Close_Async(BFMatcherPtr b, CvCallback_0 callback)
{
    BEGIN_WRAP
    b->ptr->reset();
    CVD_FREE(b);
    callback();
    END_WRAP
}

CvStatus *BFMatcher_Match_Async(BFMatcher b, Mat query, Mat train, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::DMatch> matches;
    (*b.ptr)->match(*query.ptr, *train.ptr, matches);
    callback(new VecDMatch{new std::vector<cv::DMatch>(matches)});
    END_WRAP
}

CvStatus *BFMatcher_KnnMatch_Async(BFMatcher b, Mat query, Mat train, int k, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<std::vector<cv::DMatch>> matches;
    (*b.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
    callback(new VecVecDMatch{new std::vector<std::vector<cv::DMatch>>(matches)});
    END_WRAP
}

// Asynchronous functions for FlannBasedMatcher
CvStatus *FlannBasedMatcher_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new FlannBasedMatcher{new cv::Ptr<cv::FlannBasedMatcher>(cv::FlannBasedMatcher::create())});
    END_WRAP
}

CvStatus *FlannBasedMatcher_Close_Async(FlannBasedMatcherPtr f, CvCallback_0 callback)
{
    BEGIN_WRAP
    f->ptr->reset();
    CVD_FREE(f);
    callback();
    END_WRAP
}

CvStatus *FlannBasedMatcher_KnnMatch_Async(FlannBasedMatcher f, Mat query, Mat train, int k, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<std::vector<cv::DMatch>> matches;
    (*f.ptr)->knnMatch(*query.ptr, *train.ptr, matches, k);
    callback(new VecVecDMatch{new std::vector<std::vector<cv::DMatch>>(matches)});
    END_WRAP
}

// Asynchronous utility functions
CvStatus *DrawKeyPoints_Async(Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback)
{
    BEGIN_WRAP
    auto color_ = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
    cv::drawKeypoints(*src.ptr, *kp.ptr, *dst.ptr, color_, static_cast<cv::DrawMatchesFlags>(flags));
    callback();
    END_WRAP
}

CvStatus *DrawMatches_Async(Mat img1, VecKeyPoint kp1, Mat img2, VecKeyPoint kp2, VecDMatch matches1to2, Mat outImg, const Scalar matchesColor, const Scalar pointColor, VecChar matchesMask, int flags, CvCallback_0 callback)
{
    BEGIN_WRAP
    auto mColor = cv::Scalar(matchesColor.val1, matchesColor.val2, matchesColor.val3, matchesColor.val4);
    auto pColor = cv::Scalar(pointColor.val1, pointColor.val2, pointColor.val3, pointColor.val4);
    cv::drawMatches(*img1.ptr, *kp1.ptr, *img2.ptr, *kp2.ptr, *matches1to2.ptr, *outImg.ptr, mColor, pColor, *matchesMask.ptr, static_cast<cv::DrawMatchesFlags>(flags));
    callback();
    END_WRAP
}

// Asynchronous functions for SIFT
CvStatus *SIFT_Create_Async(CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new SIFT{new cv::Ptr<cv::SIFT>(cv::SIFT::create())});
    END_WRAP
}

CvStatus *SIFT_Close_Async(SIFTPtr f, CvCallback_0 callback)
{
    BEGIN_WRAP
    f->ptr->reset();
    CVD_FREE(f);
    callback();
    END_WRAP
}

CvStatus *SIFT_Detect_Async(SIFT f, Mat src, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*f.ptr)->detect(*src.ptr, detected);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}

CvStatus *SIFT_DetectAndCompute_Async(SIFT f, Mat src, Mat mask, Mat desc, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<cv::KeyPoint> detected;
    (*f.ptr)->detectAndCompute(*src.ptr, *mask.ptr, detected, *desc.ptr);
    callback(new VecKeyPoint{new std::vector<cv::KeyPoint>(detected)});
    END_WRAP
}
