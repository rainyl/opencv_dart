/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_SVMSGD_H
#define CVD_ML_SVMSGD_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::SVMSGD>, SVMSGD);
#else
CVD_TYPEDEF(void*, SVMSGD);
#endif

CVD_ML_STAT_MODEL_DECL(SVMSGD)

int cv_ml_SVMSGD_get_svmsgdType(SVMSGD self);
CvStatus* cv_ml_SVMSGD_set_svmsgdType(SVMSGD self, int val);
int cv_ml_SVMSGD_get_marginType(SVMSGD self);
CvStatus* cv_ml_SVMSGD_set_marginType(SVMSGD self, int val);
float cv_ml_SVMSGD_get_marginRegularization(SVMSGD self);
CvStatus* cv_ml_SVMSGD_set_marginRegularization(SVMSGD self, float val);
float cv_ml_SVMSGD_get_initialStepSize(SVMSGD self);
CvStatus* cv_ml_SVMSGD_set_initialStepSize(SVMSGD self, float val);
float cv_ml_SVMSGD_get_stepDecreasingPower(SVMSGD self);
CvStatus* cv_ml_SVMSGD_set_stepDecreasingPower(SVMSGD self, float val);
CvStatus* cv_ml_SVMSGD_getWeights(SVMSGD self, Mat rval);
CvStatus* cv_ml_SVMSGD_getTermCriteria(SVMSGD self, TermCriteria* rval);
CvStatus* cv_ml_SVMSGD_setTermCriteria(SVMSGD self, TermCriteria val);

float cv_ml_SVMSGD_getShift(SVMSGD self);
CvStatus* cv_ml_SVMSGD_setOptimalParameters(SVMSGD self, int svmsgdType, int marginType);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_SVMSGD_H
