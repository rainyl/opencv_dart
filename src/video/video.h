/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_VIDEO_H_
#define _OPENCV3_VIDEO_H_

#include "core/core.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
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

CvStatus *BackgroundSubtractorMOG2_Create(BackgroundSubtractorMOG2 *rval);
CvStatus *BackgroundSubtractorMOG2_CreateWithParams(
    int history, double varThreshold, bool detectShadows, BackgroundSubtractorMOG2 *rval
);
void BackgroundSubtractorMOG2_Close(BackgroundSubtractorMOG2Ptr self);
CvStatus *BackgroundSubtractorMOG2_Apply(BackgroundSubtractorMOG2 self, Mat src, Mat dst);

CvStatus *BackgroundSubtractorKNN_Create(BackgroundSubtractorKNN *rval);
CvStatus *BackgroundSubtractorKNN_CreateWithParams(
    int history, double dist2Threshold, bool detectShadows, BackgroundSubtractorKNN *rval
);
void BackgroundSubtractorKNN_Close(BackgroundSubtractorKNNPtr self);
CvStatus *BackgroundSubtractorKNN_Apply(BackgroundSubtractorKNN self, Mat src, Mat dst);

CvStatus *CalcOpticalFlowPyrLK(
    Mat prevImg, Mat nextImg, VecPoint2f prevPts, VecPoint2f *nextPts, VecUChar *status, VecF32 *err
);
CvStatus *CalcOpticalFlowPyrLKWithParams(
    Mat prevImg,
    Mat nextImg,
    VecPoint2f prevPts,
    VecPoint2f *nextPts,
    VecUChar *status,
    VecF32 *err,
    Size winSize,
    int maxLevel,
    TermCriteria criteria,
    int flags,
    double minEigThreshold
);
CvStatus *CalcOpticalFlowFarneback(
    Mat prevImg,
    Mat nextImg,
    Mat flow,
    double pyrScale,
    int levels,
    int winsize,
    int iterations,
    int polyN,
    double polySigma,
    int flags
);

CvStatus *FindTransformECC(
    Mat templateImage,
    Mat inputImage,
    Mat warpMatrix,
    int motionType,
    TermCriteria criteria,
    Mat inputMask,
    int gaussFiltSize,
    double *rval
);

CvStatus *TrackerMIL_Init(TrackerMIL self, Mat image, Rect bbox);
CvStatus *TrackerMIL_Update(TrackerMIL self, Mat image, Rect *boundingBox, bool *rval);
CvStatus *TrackerMIL_Create(TrackerMIL *rval);
void TrackerMIL_Close(TrackerMILPtr self);

CvStatus *KalmanFilter_New(
    int dynamParams, int measureParams, int controlParams, int type, KalmanFilter *rval
);
void KalmanFilter_Close(KalmanFilterPtr self);

CvStatus *KalmanFilter_Init(KalmanFilter self, int dynamParams, int measureParams);
CvStatus *KalmanFilter_InitWithParams(
    KalmanFilter self, int dynamParams, int measureParams, int controlParams, int type
);
CvStatus *KalmanFilter_Predict(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_PredictWithParams(KalmanFilter self, Mat control, Mat *rval);
CvStatus *KalmanFilter_Correct(KalmanFilter self, Mat measurement, Mat *rval);

CvStatus *KalmanFilter_GetStatePre(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetStatePost(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetTransitionMatrix(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetControlMatrix(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetMeasurementMatrix(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetProcessNoiseCov(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetMeasurementNoiseCov(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetErrorCovPre(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetGain(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetErrorCovPost(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetTemp1(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetTemp2(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetTemp3(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetTemp4(KalmanFilter self, Mat *rval);
CvStatus *KalmanFilter_GetTemp5(KalmanFilter self, Mat *rval);

CvStatus *KalmanFilter_SetStatePre(KalmanFilter self, Mat statePre);
CvStatus *KalmanFilter_SetStatePost(KalmanFilter self, Mat statePost);
CvStatus *KalmanFilter_SetTransitionMatrix(KalmanFilter self, Mat transitionMatrix);
CvStatus *KalmanFilter_SetControlMatrix(KalmanFilter self, Mat controlMatrix);
CvStatus *KalmanFilter_SetMeasurementMatrix(KalmanFilter self, Mat measurementMatrix);
CvStatus *KalmanFilter_SetProcessNoiseCov(KalmanFilter self, Mat processNoiseCov);
CvStatus *KalmanFilter_SetMeasurementNoiseCov(KalmanFilter self, Mat measurementNoiseCov);
CvStatus *KalmanFilter_SetErrorCovPre(KalmanFilter self, Mat errorCovPre);
CvStatus *KalmanFilter_SetGain(KalmanFilter self, Mat gain);
CvStatus *KalmanFilter_SetErrorCovPost(KalmanFilter self, Mat errorCovPost);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_VIDEO_H_
