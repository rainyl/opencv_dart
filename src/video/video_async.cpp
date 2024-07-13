/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "video_async.h"
#include "core/vec.hpp"
#include <vector>

CvStatus *BackgroundSubtractorMOG2_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new BackgroundSubtractorMOG2{
      new cv::Ptr<cv::BackgroundSubtractorMOG2>(cv::createBackgroundSubtractorMOG2())
  });
  END_WRAP
}
CvStatus *BackgroundSubtractorMOG2_CreateWithParams_Async(
    int history, double varThreshold, bool detectShadows, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new BackgroundSubtractorMOG2{new cv::Ptr<cv::BackgroundSubtractorMOG2>(
      cv::createBackgroundSubtractorMOG2(history, varThreshold, detectShadows)
  )});
  END_WRAP
}
// void BackgroundSubtractorMOG2_Close(BackgroundSubtractorMOG2Ptr self)
// {
//   self->ptr->reset();
//   CVD_FREE(self);
// }

CvStatus *BackgroundSubtractorMOG2_Apply_Async(
    BackgroundSubtractorMOG2 self, Mat src, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->apply(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *BackgroundSubtractorKNN_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new BackgroundSubtractorKNN{
      new cv::Ptr<cv::BackgroundSubtractorKNN>(cv::createBackgroundSubtractorKNN())
  });
  END_WRAP
}
CvStatus *BackgroundSubtractorKNN_CreateWithParams_Async(
    int history, double dist2Threshold, bool detectShadows, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new BackgroundSubtractorKNN{new cv::Ptr<cv::BackgroundSubtractorKNN>(
      cv::createBackgroundSubtractorKNN(history, dist2Threshold, detectShadows)
  )});
  END_WRAP
}
// void BackgroundSubtractorKNN_Close(BackgroundSubtractorKNNPtr self)
// {
//   self->ptr->reset();
//   CVD_FREE(self);
// }

CvStatus *
BackgroundSubtractorKNN_Apply_Async(BackgroundSubtractorKNN self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->apply(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

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
  callback(vecuchar_cpp2c_p(_status), vecfloat_cpp2c_p(_err));
  END_WRAP
}
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
  callback();
  END_WRAP
}

CvStatus *FindTransformECC_Async(
    Mat templateImage,
    Mat inputImage,
    Mat warpMatrix,
    int motionType,
    TermCriteria criteria,
    Mat inputMask,
    int gaussFiltSize,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  double rval = cv::findTransformECC(
      *templateImage.ptr,
      *inputImage.ptr,
      *warpMatrix.ptr,
      motionType,
      tc,
      *inputMask.ptr,
      gaussFiltSize
  );
  callback(new double(rval));
  END_WRAP
}

CvStatus *TrackerMIL_Init_Async(TrackerMIL self, Mat image, Rect bbox, CvCallback_0 callback) {
  BEGIN_WRAP
  auto rect = cv::Rect(bbox.x, bbox.y, bbox.width, bbox.height);
  (*self.ptr)->init(*image.ptr, rect);
  callback();
  END_WRAP
}
CvStatus *TrackerMIL_Update_Async(TrackerMIL self, Mat image, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Rect bb;
  bool rval = (*self.ptr)->update(*image.ptr, bb);
  callback(new bool(rval), new Rect{bb.x, bb.y, bb.width, bb.height});
  END_WRAP
}

CvStatus *TrackerMIL_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new TrackerMIL{new cv::Ptr<cv::TrackerMIL>(cv::TrackerMIL::create())});
  END_WRAP
}
// void TrackerMIL_Close(TrackerMILPtr self)
// {
//   self->ptr->reset();
//   CVD_FREE(self);
// }

CvStatus *KalmanFilter_New_Async(
    int dynamParams, int measureParams, int controlParams, int type, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new KalmanFilter{new cv::KalmanFilter(dynamParams, measureParams, controlParams, type)});
  END_WRAP
}
// void KalmanFilter_Close(KalmanFilterPtr self) { CVD_FREE(self); }

CvStatus *KalmanFilter_Init_Async(
    KalmanFilter self, int dynamParams, int measureParams, CvCallback_0 callback
) {
  BEGIN_WRAP
  self.ptr->init(dynamParams, measureParams);
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_InitWithParams_Async(
    KalmanFilter self,
    int dynamParams,
    int measureParams,
    int controlParams,
    int type,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  self.ptr->init(dynamParams, measureParams, controlParams, type);
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_Predict_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto result = self.ptr->predict();
  callback(new Mat{new cv::Mat(result)});
  END_WRAP
}
CvStatus *
KalmanFilter_PredictWithParams_Async(KalmanFilter self, Mat control, CvCallback_1 callback) {
  BEGIN_WRAP
  auto result = self.ptr->predict(*control.ptr);
  callback(new Mat{new cv::Mat(result)});
  END_WRAP
}
CvStatus *KalmanFilter_Correct_Async(KalmanFilter self, Mat measurement, CvCallback_1 callback) {
  BEGIN_WRAP
  auto result = self.ptr->correct(*measurement.ptr);
  callback(new Mat{new cv::Mat(result)});
  END_WRAP
}

CvStatus *KalmanFilter_GetStatePre_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->statePre)});
  END_WRAP
}
CvStatus *KalmanFilter_GetStatePost_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->statePost)});
  END_WRAP
}
CvStatus *KalmanFilter_GetTransitionMatrix_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->transitionMatrix)});
  END_WRAP
}
CvStatus *KalmanFilter_GetControlMatrix_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->controlMatrix)});
  END_WRAP
}
CvStatus *KalmanFilter_GetMeasurementMatrix_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->measurementMatrix)});
  END_WRAP
}
CvStatus *KalmanFilter_GetProcessNoiseCov_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->processNoiseCov)});
  END_WRAP
}
CvStatus *KalmanFilter_GetMeasurementNoiseCov_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->measurementNoiseCov)});
  END_WRAP
}
CvStatus *KalmanFilter_GetErrorCovPre_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->errorCovPre)});
  END_WRAP
}
CvStatus *KalmanFilter_GetGain_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->gain)});
  END_WRAP
}
CvStatus *KalmanFilter_GetErrorCovPost_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->errorCovPost)});
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp1_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->temp1)});
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp2_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->temp2)});
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp3_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->temp3)});
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp4_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->temp4)});
  END_WRAP
}
CvStatus *KalmanFilter_GetTemp5_Async(KalmanFilter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->temp5)});
  END_WRAP
}

CvStatus *KalmanFilter_SetStatePre_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->statePre = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_SetStatePost_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->statePost = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *
KalmanFilter_SetTransitionMatrix_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->transitionMatrix = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_SetControlMatrix_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->controlMatrix = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *
KalmanFilter_SetMeasurementMatrix_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->measurementMatrix = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *
KalmanFilter_SetProcessNoiseCov_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->processNoiseCov = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *
KalmanFilter_SetMeasurementNoiseCov_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->measurementNoiseCov = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_SetErrorCovPre_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->errorCovPre = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_SetGain_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->gain = *value.ptr;
  callback();
  END_WRAP
}
CvStatus *KalmanFilter_SetErrorCovPost_Async(KalmanFilter self, Mat value, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->errorCovPost = *value.ptr;
  callback();
  END_WRAP
}
