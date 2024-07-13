/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright _Async(c) 2024 Rainyl.
*/

#ifndef CVD_VIDEO_ASYNC_H_
#define CVD_VIDEO_ASYNC_H_

#include "core/types.h"
#include "video.h"

#ifdef __cplusplus
extern "C" {
#endif

CvStatus *BackgroundSubtractorMOG2_Create_Async(CvCallback_1 callback);
CvStatus *BackgroundSubtractorMOG2_CreateWithParams_Async(
    int history, double varThreshold, bool detectShadows, CvCallback_1 callback
);
// void BackgroundSubtractorMOG2_Close_Async(BackgroundSubtractorMOG2Ptr self);
CvStatus *
BackgroundSubtractorMOG2_Apply_Async(BackgroundSubtractorMOG2 self, Mat src, CvCallback_1 callback);

CvStatus *BackgroundSubtractorKNN_Create_Async(CvCallback_1 callback);
CvStatus *BackgroundSubtractorKNN_CreateWithParams_Async(
    int history, double dist2Threshold, bool detectShadows, CvCallback_1 callback
);
// void BackgroundSubtractorKNN_Close_Async(BackgroundSubtractorKNNPtr self);
CvStatus *
BackgroundSubtractorKNN_Apply_Async(BackgroundSubtractorKNN self, Mat src, CvCallback_1 callback);

CvStatus *CalcOpticalFlowPyrLK_Async(
    Mat prevImg,
    Mat nextImg,
    VecPoint2f prevPts,
    VecPoint2f *nextPts,
    Size winSize,
    int maxLevel,
    TermCriteria criteria,
    int flags,
    double minEigThreshold,
    CvCallback_2 callback
);
CvStatus *CalcOpticalFlowFarneback_Async(
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

CvStatus *FindTransformECC_Async(
    Mat templateImage,
    Mat inputImage,
    Mat warpMatrix,
    int motionType,
    TermCriteria criteria,
    Mat inputMask,
    int gaussFiltSize,
    CvCallback_1 callback
);

CvStatus *TrackerMIL_Init_Async(TrackerMIL self, Mat image, Rect bbox, CvCallback_0 callback);
CvStatus *TrackerMIL_Update_Async(TrackerMIL self, Mat image, CvCallback_2 callback);
CvStatus *TrackerMIL_Create_Async(CvCallback_1 callback);
// void TrackerMIL_Close_Async(TrackerMILPtr self);

CvStatus *KalmanFilter_New_Async(
    int dynamParams, int measureParams, int controlParams, int type, CvCallback_1 callback
);
// void KalmanFilter_Close_Async(KalmanFilterPtr self);

CvStatus *KalmanFilter_Init_Async(
    KalmanFilter self, int dynamParams, int measureParams, CvCallback_0 callback
);
CvStatus *KalmanFilter_InitWithParams_Async(
    KalmanFilter self,
    int dynamParams,
    int measureParams,
    int controlParams,
    int type,
    CvCallback_0 callback
);
CvStatus *KalmanFilter_Predict_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *
KalmanFilter_PredictWithParams_Async(KalmanFilter self, Mat control, CvCallback_1 callback);
CvStatus *KalmanFilter_Correct_Async(KalmanFilter self, Mat measurement, CvCallback_1 callback);

CvStatus *KalmanFilter_GetStatePre_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetStatePost_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetTransitionMatrix_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetControlMatrix_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetMeasurementMatrix_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetProcessNoiseCov_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetMeasurementNoiseCov_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetErrorCovPre_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetGain_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetErrorCovPost_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetTemp1_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetTemp2_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetTemp3_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetTemp4_Async(KalmanFilter self, CvCallback_1 callback);
CvStatus *KalmanFilter_GetTemp5_Async(KalmanFilter self, CvCallback_1 callback);

CvStatus *KalmanFilter_SetStatePre_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *KalmanFilter_SetStatePost_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *
KalmanFilter_SetTransitionMatrix_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *KalmanFilter_SetControlMatrix_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *
KalmanFilter_SetMeasurementMatrix_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *
KalmanFilter_SetProcessNoiseCov_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *
KalmanFilter_SetMeasurementNoiseCov_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *KalmanFilter_SetErrorCovPre_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *KalmanFilter_SetGain_Async(KalmanFilter self, Mat value, CvCallback_0 callback);
CvStatus *KalmanFilter_SetErrorCovPost_Async(KalmanFilter self, Mat value, CvCallback_0 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_VIDEO_ASYNC_H_
