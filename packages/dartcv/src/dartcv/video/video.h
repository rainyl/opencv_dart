/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_VIDEO_H_
#define CVD_VIDEO_H_

#include "dartcv/core/types.h"

#ifdef __cplusplus
#include <opencv2/video.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::BackgroundSubtractorMOG2>, BackgroundSubtractorMOG2);
CVD_TYPEDEF(cv::Ptr<cv::BackgroundSubtractorKNN>, BackgroundSubtractorKNN);
CVD_TYPEDEF(cv::Ptr<cv::Tracker>, Tracker);
CVD_TYPEDEF(cv::Ptr<cv::TrackerMIL>, TrackerMIL);
CVD_TYPEDEF(cv::Ptr<cv::TrackerGOTURN>, TrackerGOTURN);
CVD_TYPEDEF(cv::KalmanFilter, KalmanFilter);
#else
CVD_TYPEDEF(void, BackgroundSubtractorMOG2);
CVD_TYPEDEF(void, BackgroundSubtractorKNN);
CVD_TYPEDEF(void, Tracker);
CVD_TYPEDEF(void, TrackerMIL);
CVD_TYPEDEF(void, TrackerGOTURN);
CVD_TYPEDEF(void, KalmanFilter);
#endif

CvStatus* cv_BackgroundSubtractorMOG2_create(BackgroundSubtractorMOG2* rval);
CvStatus* cv_BackgroundSubtractorMOG2_create_1(
    int history, double varThreshold, bool detectShadows, BackgroundSubtractorMOG2* rval
);
void cv_BackgroundSubtractorMOG2_close(BackgroundSubtractorMOG2Ptr self);
CvStatus* cv_BackgroundSubtractorMOG2_apply(
    BackgroundSubtractorMOG2 self, Mat src, Mat dst, CvCallback_0 callback
);

CvStatus* cv_BackgroundSubtractorKNN_create(BackgroundSubtractorKNN* rval);
CvStatus* cv_BackgroundSubtractorKNN_create_1(
    int history, double dist2Threshold, bool detectShadows, BackgroundSubtractorKNN* rval
);
void cv_BackgroundSubtractorKNN_close(BackgroundSubtractorKNNPtr self);
CvStatus* cv_BackgroundSubtractorKNN_apply(
    BackgroundSubtractorKNN self, Mat src, Mat dst, CvCallback_0 callback
);

CvStatus* cv_calcOpticalFlowPyrLK(
    Mat prevImg,
    Mat nextImg,
    VecPoint2f prevPts,
    VecPoint2f* nextPts,
    VecUChar* status,
    VecF32* err,
    CvCallback_0 callback
);
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
);
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
);

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
);

CvStatus* cv_TrackerMIL_create(TrackerMIL* rval);
CvStatus* cv_TrackerMIL_init(TrackerMIL self, Mat image, CvRect bbox, CvCallback_0 callback);
CvStatus* cv_TrackerMIL_update(
    TrackerMIL self, Mat image, CvRect* boundingBox, bool* rval, CvCallback_0 callback
);
void cv_TrackerMIL_close(TrackerMILPtr self);

CvStatus* cv_KalmanFilter_create(
    int dynamParams, int measureParams, int controlParams, int type, KalmanFilter* rval
);
void cv_KalmanFilter_close(KalmanFilterPtr self);

CvStatus* cv_KalmanFilter_init(
    KalmanFilter self, int dynamParams, int measureParams, CvCallback_0 callback
);
CvStatus* cv_KalmanFilter_init_1(
    KalmanFilter self,
    int dynamParams,
    int measureParams,
    int controlParams,
    int type,
    CvCallback_0 callback
);
CvStatus* cv_KalmanFilter_predict(KalmanFilter self, Mat* rval, CvCallback_0 callback);
CvStatus* cv_KalmanFilter_predict_1(
    KalmanFilter self, Mat control, Mat* rval, CvCallback_0 callback
);
CvStatus* cv_KalmanFilter_correct(
    KalmanFilter self, Mat measurement, Mat* rval, CvCallback_0 callback
);

CvStatus* cv_KalmanFilter_get_statePre(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_statePost(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_transitionMatrix(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_controlMatrix(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_measurementMatrix(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_processNoiseCov(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_measurementNoiseCov(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_errorCovPre(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_gain(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_errorCovPost(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_temp1(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_temp2(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_temp3(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_temp4(KalmanFilter self, Mat* rval);
CvStatus* cv_KalmanFilter_get_temp5(KalmanFilter self, Mat* rval);

CvStatus* cv_KalmanFilter_set_statePre(KalmanFilter self, Mat statePre);
CvStatus* cv_KalmanFilter_set_statePost(KalmanFilter self, Mat statePost);
CvStatus* cv_KalmanFilter_set_transitionMatrix(KalmanFilter self, Mat transitionMatrix);
CvStatus* cv_KalmanFilter_set_controlMatrix(KalmanFilter self, Mat controlMatrix);
CvStatus* cv_KalmanFilter_set_measurementMatrix(KalmanFilter self, Mat measurementMatrix);
CvStatus* cv_KalmanFilter_set_processNoiseCov(KalmanFilter self, Mat processNoiseCov);
CvStatus* cv_KalmanFilter_set_measurementNoiseCov(KalmanFilter self, Mat measurementNoiseCov);
CvStatus* cv_KalmanFilter_set_errorCovPre(KalmanFilter self, Mat errorCovPre);
CvStatus* cv_KalmanFilter_set_gain(KalmanFilter self, Mat gain);
CvStatus* cv_KalmanFilter_set_errorCovPost(KalmanFilter self, Mat errorCovPost);

#ifdef __cplusplus
}
#endif

#endif  //CVD_VIDEO_H_
