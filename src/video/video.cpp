/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "video.h"
#include "core/vec.hpp"
#include <vector>

CvStatus *BackgroundSubtractorMOG2_Create(BackgroundSubtractorMOG2 *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BackgroundSubtractorMOG2>(cv::createBackgroundSubtractorMOG2())};
  END_WRAP
}
CvStatus *BackgroundSubtractorMOG2_CreateWithParams(
    int history, double varThreshold, bool detectShadows, BackgroundSubtractorMOG2 *rval
) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BackgroundSubtractorMOG2>(
      cv::createBackgroundSubtractorMOG2(history, varThreshold, detectShadows)
  )};
  END_WRAP
}
void BackgroundSubtractorMOG2_Close(BackgroundSubtractorMOG2Ptr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *BackgroundSubtractorMOG2_Apply(BackgroundSubtractorMOG2 self, Mat src, Mat dst) {
  BEGIN_WRAP(*self.ptr)->apply(*src.ptr, *dst.ptr);
  END_WRAP
}

CvStatus *BackgroundSubtractorKNN_Create(BackgroundSubtractorKNN *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BackgroundSubtractorKNN>(cv::createBackgroundSubtractorKNN())};
  END_WRAP
}
CvStatus *BackgroundSubtractorKNN_CreateWithParams(
    int history, double dist2Threshold, bool detectShadows, BackgroundSubtractorKNN *rval
) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::BackgroundSubtractorKNN>(
      cv::createBackgroundSubtractorKNN(history, dist2Threshold, detectShadows)
  )};
  END_WRAP
}
void BackgroundSubtractorKNN_Close(BackgroundSubtractorKNNPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *BackgroundSubtractorKNN_Apply(BackgroundSubtractorKNN self, Mat src, Mat dst) {
  BEGIN_WRAP(*self.ptr)->apply(*src.ptr, *dst.ptr);
  END_WRAP
}

CvStatus *CalcOpticalFlowPyrLK(
    Mat prevImg, Mat nextImg, VecPoint2f prevPts, VecPoint2f *nextPts, VecUChar *status, VecF32 *err
) {
  BEGIN_WRAP
  auto _prevPts = vecpoint2f_c2cpp(prevPts);
  auto _nextPts = vecpoint2f_c2cpp(*nextPts);
  std::vector<uchar> _status;
  std::vector<float> _err;
  cv::calcOpticalFlowPyrLK(*prevImg.ptr, *nextImg.ptr, _prevPts, _nextPts, _status, _err);

  vecpoint2f_cpp2c(_nextPts, nextPts);

  *status = vecuchar_cpp2c(_status);
  *err = vecfloat_cpp2c(_err);
  END_WRAP
}

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
) {
  BEGIN_WRAP
  auto _prevPts = vecpoint2f_c2cpp(prevPts);
  auto _nextPts = vecpoint2f_c2cpp(*nextPts);
  std::vector<uchar> _status;
  std::vector<float> _err;
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  cv::calcOpticalFlowPyrLK(
      *prevImg.ptr,
      *nextImg.ptr,
      _prevPts,
      _nextPts,
      _status,
      _err,
      cv::Size(winSize.width, winSize.height),
      maxLevel,
      tc,
      flags,
      minEigThreshold
  );
  vecpoint2f_cpp2c(_nextPts, nextPts);

  *status = vecuchar_cpp2c(_status);
  *err = vecfloat_cpp2c(_err);
  END_WRAP
}
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
) {
  BEGIN_WRAP
  cv::calcOpticalFlowFarneback(
      *prevImg.ptr,
      *nextImg.ptr,
      *flow.ptr,
      pyrScale,
      levels,
      winsize,
      iterations,
      polyN,
      polySigma,
      flags
  );
  END_WRAP
}

CvStatus *FindTransformECC(
    Mat templateImage,
    Mat inputImage,
    Mat warpMatrix,
    int motionType,
    TermCriteria criteria,
    Mat inputMask,
    int gaussFiltSize,
    double *rval
) {
  BEGIN_WRAP
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  *rval = cv::findTransformECC(
      *templateImage.ptr,
      *inputImage.ptr,
      *warpMatrix.ptr,
      motionType,
      tc,
      *inputMask.ptr,
      gaussFiltSize
  );
  END_WRAP
}

CvStatus *TrackerMIL_Init(TrackerMIL self, Mat image, Rect bbox) {
  BEGIN_WRAP
  auto rect = cv::Rect(bbox.x, bbox.y, bbox.width, bbox.height);
  (*self.ptr)->init(*image.ptr, rect);
  END_WRAP
}
CvStatus *TrackerMIL_Update(TrackerMIL self, Mat image, Rect *boundingBox, bool *rval) {
  BEGIN_WRAP
  cv::Rect bb;
  *rval = (*self.ptr)->update(*image.ptr, bb);
  *boundingBox = {bb.x, bb.y, bb.width, bb.height};
  END_WRAP
}

CvStatus *TrackerMIL_Create(TrackerMIL *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::TrackerMIL>(cv::TrackerMIL::create())};
  END_WRAP
}
void TrackerMIL_Close(TrackerMILPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *KalmanFilter_New(
    int dynamParams, int measureParams, int controlParams, int type, KalmanFilter *rval
) {
  BEGIN_WRAP
  *rval = {new cv::KalmanFilter(dynamParams, measureParams, controlParams, type)};
  END_WRAP
}
void KalmanFilter_Close(KalmanFilterPtr self) { CVD_FREE(self); }

CvStatus *KalmanFilter_Init(KalmanFilter self, int dynamParams, int measureParams) {
  BEGIN_WRAP
  self.ptr->init(dynamParams, measureParams);
  END_WRAP
}
CvStatus *KalmanFilter_InitWithParams(
    KalmanFilter self, int dynamParams, int measureParams, int controlParams, int type
) {
  BEGIN_WRAP
  self.ptr->init(dynamParams, measureParams, controlParams, type);
  END_WRAP
}
CvStatus *KalmanFilter_Predict(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  auto result = self.ptr->predict();
  *rval = {new cv::Mat(result)};
  END_WRAP
}
CvStatus *KalmanFilter_PredictWithParams(KalmanFilter self, Mat control, Mat *rval) {
  BEGIN_WRAP
  auto result = self.ptr->predict(*control.ptr);
  *rval = {new cv::Mat(result)};
  END_WRAP
}
CvStatus *KalmanFilter_Correct(KalmanFilter self, Mat measurement, Mat *rval) {
  BEGIN_WRAP
  auto result = self.ptr->correct(*measurement.ptr);
  *rval = {new cv::Mat(result)};
  END_WRAP
}

CvStatus *KalmanFilter_GetStatePre(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->statePre)};
  END_WRAP
}
CvStatus *KalmanFilter_GetStatePost(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->statePost)};
  END_WRAP
}
CvStatus *KalmanFilter_GetTransitionMatrix(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->transitionMatrix)};
  END_WRAP
}
CvStatus *KalmanFilter_GetControlMatrix(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->controlMatrix)};
  END_WRAP
}
CvStatus *KalmanFilter_GetMeasurementMatrix(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->measurementMatrix)};
  END_WRAP
}
CvStatus *KalmanFilter_GetProcessNoiseCov(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->processNoiseCov)};
  END_WRAP
}
CvStatus *KalmanFilter_GetMeasurementNoiseCov(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->measurementNoiseCov)};
  END_WRAP
}
CvStatus *KalmanFilter_GetErrorCovPre(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->errorCovPre)};
  END_WRAP
}
CvStatus *KalmanFilter_GetGain(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->gain)};
  END_WRAP
}
CvStatus *KalmanFilter_GetErrorCovPost(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->errorCovPost)};
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp1(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->temp1)};
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp2(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->temp2)};
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp3(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->temp3)};
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp4(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->temp4)};
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp5(KalmanFilter self, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->temp5)};
  END_WRAP
}

CvStatus *KalmanFilter_SetStatePre(KalmanFilter self, Mat statePre) {
  BEGIN_WRAP
  self.ptr->statePre = *statePre.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetStatePost(KalmanFilter self, Mat statePost) {
  BEGIN_WRAP
  self.ptr->statePost = *statePost.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetTransitionMatrix(KalmanFilter self, Mat transitionMatrix) {
  BEGIN_WRAP
  self.ptr->transitionMatrix = *transitionMatrix.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetControlMatrix(KalmanFilter self, Mat controlMatrix) {
  BEGIN_WRAP
  self.ptr->controlMatrix = *controlMatrix.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetMeasurementMatrix(KalmanFilter self, Mat measurementMatrix) {
  BEGIN_WRAP
  self.ptr->measurementMatrix = *measurementMatrix.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetProcessNoiseCov(KalmanFilter self, Mat processNoiseCov) {
  BEGIN_WRAP
  self.ptr->processNoiseCov = *processNoiseCov.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetMeasurementNoiseCov(KalmanFilter self, Mat measurementNoiseCov) {
  BEGIN_WRAP
  self.ptr->measurementNoiseCov = *measurementNoiseCov.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetErrorCovPre(KalmanFilter self, Mat errorCovPre) {
  BEGIN_WRAP
  self.ptr->errorCovPre = *errorCovPre.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetGain(KalmanFilter self, Mat gain) {
  BEGIN_WRAP
  self.ptr->gain = *gain.ptr;
  END_WRAP
}
CvStatus *KalmanFilter_SetErrorCovPost(KalmanFilter self, Mat errorCovPost) {
  BEGIN_WRAP
  self.ptr->errorCovPost = *errorCovPost.ptr;
  END_WRAP
}
