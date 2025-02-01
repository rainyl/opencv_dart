/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/video/video.h"
#include "dartcv/core/vec.hpp"

#include <iostream>

CvStatus* cv_BackgroundSubtractorMOG2_create(BackgroundSubtractorMOG2* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BackgroundSubtractorMOG2>(cv::createBackgroundSubtractorMOG2());
    END_WRAP
}
CvStatus* cv_BackgroundSubtractorMOG2_create_1(
    int history, double varThreshold, bool detectShadows, BackgroundSubtractorMOG2* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BackgroundSubtractorMOG2>(
        cv::createBackgroundSubtractorMOG2(history, varThreshold, detectShadows)
    );
    END_WRAP
}
void cv_BackgroundSubtractorMOG2_close(BackgroundSubtractorMOG2Ptr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_BackgroundSubtractorMOG2_apply(
    BackgroundSubtractorMOG2 self, Mat src, Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->apply(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_BackgroundSubtractorKNN_create(BackgroundSubtractorKNN* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BackgroundSubtractorKNN>(cv::createBackgroundSubtractorKNN());
    END_WRAP
}
CvStatus* cv_BackgroundSubtractorKNN_create_1(
    int history, double dist2Threshold, bool detectShadows, BackgroundSubtractorKNN* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BackgroundSubtractorKNN>(
        cv::createBackgroundSubtractorKNN(history, dist2Threshold, detectShadows)
    );
    END_WRAP
}
void cv_BackgroundSubtractorKNN_close(BackgroundSubtractorKNNPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_BackgroundSubtractorKNN_apply(
    BackgroundSubtractorKNN self, Mat src, Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->apply(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_calcOpticalFlowPyrLK(
    Mat prevImg,
    Mat nextImg,
    VecPoint2f prevPts,
    VecPoint2f* nextPts,
    VecUChar* status,
    VecF32* err,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::calcOpticalFlowPyrLK(
        CVDEREF(prevImg), CVDEREF(nextImg), CVDEREF(prevPts), CVDEREF_P(nextPts), CVDEREF_P(status), CVDEREF_P(err)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_calcOpticalFlowPyrLK_1(
    Mat prevImg,
    Mat nextImg,
    VecPoint2f prevPts,
    VecPoint2f* nextPts,
    VecUChar* status,
    VecF32* err,
    CvSize winSize,
    int maxLevel,
    TermCriteria criteria,
    int flags,
    double minEigThreshold,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
    cv::calcOpticalFlowPyrLK(
        CVDEREF(prevImg),
        CVDEREF(nextImg),
        CVDEREF(prevPts),
        CVDEREF_P(nextPts),
        CVDEREF_P(status),
        CVDEREF_P(err),
        cv::Size(winSize.width, winSize.height),
        maxLevel,
        tc,
        flags,
        minEigThreshold
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_calcOpticalFlowFarneback(
    Mat prevImg,
    Mat nextImg,
    Mat flow,
    double pyrScale,
    int levels,
    int winsize,
    int iterations,
    int polyN,
    double polySigma,
    int flags,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::calcOpticalFlowFarneback(
        CVDEREF(prevImg),
        CVDEREF(nextImg),
        CVDEREF(flow),
        pyrScale,
        levels,
        winsize,
        iterations,
        polyN,
        polySigma,
        flags
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_findTransformECC(
    Mat templateImage,
    Mat inputImage,
    Mat warpMatrix,
    int motionType,
    TermCriteria criteria,
    Mat inputMask,
    int gaussFiltSize,
    double* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
    *rval = cv::findTransformECC(
        CVDEREF(templateImage),
        CVDEREF(inputImage),
        CVDEREF(warpMatrix),
        motionType,
        tc,
        CVDEREF(inputMask),
        gaussFiltSize
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_TrackerMIL_init(TrackerMIL self, Mat image, CvRect bbox, CvCallback_0 callback) {
    BEGIN_WRAP
    auto rect = cv::Rect(bbox.x, bbox.y, bbox.width, bbox.height);
    (CVDEREF(self))->init(CVDEREF(image), rect);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_TrackerMIL_update(
    TrackerMIL self, Mat image, CvRect* boundingBox, bool* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Rect bb;
    *rval = (CVDEREF(self))->update(CVDEREF(image), bb);
    *boundingBox = {bb.x, bb.y, bb.width, bb.height};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_TrackerMIL_create(TrackerMIL* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::TrackerMIL>(cv::TrackerMIL::create());
    END_WRAP
}
void cv_TrackerMIL_close(TrackerMILPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_KalmanFilter_create(
    int dynamParams, int measureParams, int controlParams, int type, KalmanFilter* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::KalmanFilter(dynamParams, measureParams, controlParams, type);
    END_WRAP
}
void cv_KalmanFilter_close(KalmanFilterPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_KalmanFilter_init(
    KalmanFilter self, int dynamParams, int measureParams, CvCallback_0 callback
) {
    BEGIN_WRAP
    self.ptr->init(dynamParams, measureParams);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_KalmanFilter_init_1(
    KalmanFilter self,
    int dynamParams,
    int measureParams,
    int controlParams,
    int type,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    self.ptr->init(dynamParams, measureParams, controlParams, type);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_KalmanFilter_predict(KalmanFilter self, Mat* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto result = self.ptr->predict();
    rval->ptr = new cv::Mat(result);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_KalmanFilter_predict_1(
    KalmanFilter self, Mat control, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto result = self.ptr->predict(CVDEREF(control));
    rval->ptr = new cv::Mat(result);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_KalmanFilter_correct(
    KalmanFilter self, Mat measurement, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto result = self.ptr->correct(CVDEREF(measurement));
    rval->ptr = new cv::Mat(result);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_KalmanFilter_get_statePre(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->statePre);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_statePost(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->statePost);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_transitionMatrix(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->transitionMatrix);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_controlMatrix(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->controlMatrix);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_measurementMatrix(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->measurementMatrix);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_processNoiseCov(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->processNoiseCov);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_measurementNoiseCov(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->measurementNoiseCov);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_errorCovPre(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->errorCovPre);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_gain(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->gain);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_errorCovPost(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->errorCovPost);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_temp1(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->temp1);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_temp2(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->temp2);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_temp3(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->temp3);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_temp4(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->temp4);
    END_WRAP
}
CvStatus* cv_KalmanFilter_get_temp5(KalmanFilter self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->temp5);
    END_WRAP
}

CvStatus* cv_KalmanFilter_set_statePre(KalmanFilter self, Mat statePre) {
    BEGIN_WRAP
    self.ptr->statePre = CVDEREF(statePre);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_statePost(KalmanFilter self, Mat statePost) {
    BEGIN_WRAP
    self.ptr->statePost = CVDEREF(statePost);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_transitionMatrix(KalmanFilter self, Mat transitionMatrix) {
    BEGIN_WRAP
    self.ptr->transitionMatrix = CVDEREF(transitionMatrix);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_controlMatrix(KalmanFilter self, Mat controlMatrix) {
    BEGIN_WRAP
    self.ptr->controlMatrix = CVDEREF(controlMatrix);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_measurementMatrix(KalmanFilter self, Mat measurementMatrix) {
    BEGIN_WRAP
    self.ptr->measurementMatrix = CVDEREF(measurementMatrix);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_processNoiseCov(KalmanFilter self, Mat processNoiseCov) {
    BEGIN_WRAP
    self.ptr->processNoiseCov = CVDEREF(processNoiseCov);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_measurementNoiseCov(KalmanFilter self, Mat measurementNoiseCov) {
    BEGIN_WRAP
    self.ptr->measurementNoiseCov = CVDEREF(measurementNoiseCov);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_errorCovPre(KalmanFilter self, Mat errorCovPre) {
    BEGIN_WRAP
    self.ptr->errorCovPre = CVDEREF(errorCovPre);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_gain(KalmanFilter self, Mat gain) {
    BEGIN_WRAP
    self.ptr->gain = CVDEREF(gain);
    END_WRAP
}
CvStatus* cv_KalmanFilter_set_errorCovPost(KalmanFilter self, Mat errorCovPost) {
    BEGIN_WRAP
    self.ptr->errorCovPost = CVDEREF(errorCovPost);
    END_WRAP
}
