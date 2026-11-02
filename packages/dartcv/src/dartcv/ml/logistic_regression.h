/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_LOGISTIC_REGRESSION_H
#define CVD_ML_LOGISTIC_REGRESSION_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::LogisticRegression>, LogisticRegression);
#else
CVD_TYPEDEF(void*, LogisticRegression);
#endif

CVD_ML_STAT_MODEL_DECL(LogisticRegression)

double cv_ml_LogisticRegression_get_learningRate(LogisticRegression self);
CvStatus* cv_ml_LogisticRegression_set_learningRate(LogisticRegression self, double val);
int cv_ml_LogisticRegression_get_iterations(LogisticRegression self);
CvStatus* cv_ml_LogisticRegression_set_iterations(LogisticRegression self, int val);
int cv_ml_LogisticRegression_get_regularization(LogisticRegression self);
CvStatus* cv_ml_LogisticRegression_set_regularization(LogisticRegression self, int val);
int cv_ml_LogisticRegression_get_trainMethod(LogisticRegression self);
CvStatus* cv_ml_LogisticRegression_set_trainMethod(LogisticRegression self, int val);
int cv_ml_LogisticRegression_get_miniBatchSize(LogisticRegression self);
CvStatus* cv_ml_LogisticRegression_set_miniBatchSize(LogisticRegression self, int val);
CvStatus* cv_ml_LogisticRegression_get_learnt_thetas(LogisticRegression self, Mat rval);
CvStatus* cv_ml_LogisticRegression_getTermCriteria(LogisticRegression self, TermCriteria* rval);
CvStatus* cv_ml_LogisticRegression_setTermCriteria(LogisticRegression self, TermCriteria val);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_LOGISTIC_REGRESSION_H
