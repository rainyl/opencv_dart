/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/features2d/features2d.h"
#include "dartcv/core/vec.hpp"
#include "dartcv/features2d/utils.hpp"

#include <iostream>

CvStatus* cv_AKAZE_create(AKAZE* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::AKAZE>(cv::AKAZE::create());
    END_WRAP
}
void cv_AKAZE_close(AKAZEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_AKAZE_detect(AKAZE self, Mat src, VecKeyPoint* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_AKAZE_detectAndCompute(
    AKAZE self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detectAndCompute(CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc));

    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_AgastFeatureDetector_create(AgastFeatureDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create());
    END_WRAP
}
void cv_AgastFeatureDetector_close(AgastFeatureDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_AgastFeatureDetector_detect(
    AgastFeatureDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_BRISK_create(BRISK* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BRISK>(cv::BRISK::create());
    END_WRAP
}
void cv_BRISK_close(BRISKPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_BRISK_detect(BRISK self, Mat src, VecKeyPoint* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_BRISK_detectAndCompute(
    BRISK self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detectAndCompute(CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_FastFeatureDetector_create(FastFeatureDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create());
    END_WRAP
}
CvStatus* cv_FastFeatureDetector_create_1(
    int threshold, bool nonmaxSuppression, int type, FastFeatureDetector* rval
) {
    BEGIN_WRAP
    auto type_ = static_cast<cv::FastFeatureDetector::DetectorType>(type);
    rval->ptr = new cv::Ptr<cv::FastFeatureDetector>(
        cv::FastFeatureDetector::create(threshold, nonmaxSuppression, type_)
    );
    END_WRAP
}
void cv_FastFeatureDetector_close(FastFeatureDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_FastFeatureDetector_detect(
    FastFeatureDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_GFTTDetector_create(GFTTDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create());
    END_WRAP
}
void cv_GFTTDetector_close(GFTTDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_GFTTDetector_detect(
    GFTTDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_KAZE_create(KAZE* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::KAZE>(cv::KAZE::create());
    END_WRAP
}
void cv_KAZE_close(KAZEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_KAZE_detect(KAZE self, Mat src, VecKeyPoint* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_KAZE_detectAndCompute(
    KAZE self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detectAndCompute(CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_MSER_create(MSER* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::MSER>(cv::MSER::create());
    END_WRAP
}
void cv_MSER_close(MSERPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_MSER_detect(MSER self, Mat src, VecKeyPoint* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ORB_create(ORB* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::ORB>(cv::ORB::create());
    END_WRAP
}
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
) {
    BEGIN_WRAP
    auto type = static_cast<cv::ORB::ScoreType>(scoreType);
    rval->ptr = new cv::Ptr<cv::ORB>(cv::ORB::create(
        nfeatures,
        scaleFactor,
        nlevels,
        edgeThreshold,
        firstLevel,
        WTA_K,
        type,
        patchSize,
        fastThreshold
    ));
    END_WRAP
}
void cv_ORB_close(ORBPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_ORB_detect(ORB self, Mat src, VecKeyPoint* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    (*self.ptr)->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ORB_detectAndCompute(
    ORB self, Mat src, Mat mask, VecKeyPoint* out_keypoints, Mat desc, bool useProvidedKeypoints, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detectAndCompute(CVDEREF(src), CVDEREF(mask), CVDEREF_P(out_keypoints), CVDEREF(desc), useProvidedKeypoints);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SimpleBlobDetector_create(SimpleBlobDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create());
    END_WRAP
}
CvStatus* cv_SimpleBlobDetector_create_1(
    SimpleBlobDetectorParams params, SimpleBlobDetector* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SimpleBlobDetector>(
        cv::SimpleBlobDetector::create(SimpleBlobDetectorParams_c2cpp(params))
    );
    END_WRAP
}
void cv_SimpleBlobDetector_close(SimpleBlobDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_SimpleBlobDetector_detect(
    SimpleBlobDetector self, Mat src, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_SimpleBlobDetectorParams_create(SimpleBlobDetectorParams* rval) {
    BEGIN_WRAP
    *rval = SimpleBlobDetectorParams_cpp2c(cv::SimpleBlobDetector::Params());
    END_WRAP
}

CvStatus* cv_BFMatcher_create(BFMatcher* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create());
    END_WRAP
}
CvStatus* cv_BFMatcher_create_1(int normType, bool crossCheck, BFMatcher* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create(normType, crossCheck));
    END_WRAP
}
void cv_BFMatcher_close(BFMatcherPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_BFMatcher_match(
    BFMatcher self, Mat query, Mat train, VecDMatch* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->match(CVDEREF(query), CVDEREF(train), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_BFMatcher_knnMatch(
    BFMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->knnMatch(CVDEREF(query), CVDEREF(train), CVDEREF_P(rval), k);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_FlannBasedMatcher_create(FlannBasedMatcher* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::FlannBasedMatcher>(cv::FlannBasedMatcher::create());
    END_WRAP
}
void cv_FlannBasedMatcher_close(FlannBasedMatcherPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_FlannBasedMatcher_knnMatch(
    FlannBasedMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->knnMatch(CVDEREF(query), CVDEREF(train), CVDEREF_P(rval), k);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_drawKeyPoints(
    Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto color_ = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
    cv::drawKeypoints(
        CVDEREF(src), CVDEREF(kp), CVDEREF(dst), color_, static_cast<cv::DrawMatchesFlags>(flags)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SIFT_create(SIFT* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SIFT>(cv::SIFT::create());
    END_WRAP
}
void cv_SIFT_close(SIFTPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_SIFT_detect(SIFT self, Mat src, VecKeyPoint* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_SIFT_detectAndCompute(
    SIFT self, Mat src, Mat mask, Mat desc, VecKeyPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))->detectAndCompute(CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

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
) {
    BEGIN_WRAP
    auto mColor =
        cv::Scalar(matchesColor.val1, matchesColor.val2, matchesColor.val3, matchesColor.val4);
    auto pColor = cv::Scalar(pointColor.val1, pointColor.val2, pointColor.val3, pointColor.val4);
    cv::drawMatches(
        CVDEREF(img1),
        CVDEREF(kp1),
        CVDEREF(img2),
        CVDEREF(kp2),
        CVDEREF(matches1to2),
        CVDEREF(outImg),
        mColor,
        pColor,
        CVDEREF(matchesMask),
        static_cast<cv::DrawMatchesFlags>(flags)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
