/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_RTREES_H
#define CVD_ML_RTREES_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::RTrees>, RTrees);
#else
CVD_TYPEDEF(void*, RTrees);
#endif

CVD_ML_STAT_MODEL_DECL(RTrees)

int cv_ml_RTrees_get_maxCategories(RTrees self);
CvStatus* cv_ml_RTrees_set_maxCategories(RTrees self, int val);
int cv_ml_RTrees_get_maxDepth(RTrees self);
CvStatus* cv_ml_RTrees_set_maxDepth(RTrees self, int val);
int cv_ml_RTrees_get_minSampleCount(RTrees self);
CvStatus* cv_ml_RTrees_set_minSampleCount(RTrees self, int val);
int cv_ml_RTrees_get_cvFolds(RTrees self);
CvStatus* cv_ml_RTrees_set_cvFolds(RTrees self, int val);
bool cv_ml_RTrees_get_useSurrogates(RTrees self);
CvStatus* cv_ml_RTrees_set_useSurrogates(RTrees self, bool val);
bool cv_ml_RTrees_get_use1SERule(RTrees self);
CvStatus* cv_ml_RTrees_set_use1SERule(RTrees self, bool val);
bool cv_ml_RTrees_get_truncatePrunedTree(RTrees self);
CvStatus* cv_ml_RTrees_set_truncatePrunedTree(RTrees self, bool val);
float cv_ml_RTrees_get_regressionAccuracy(RTrees self);
CvStatus* cv_ml_RTrees_set_regressionAccuracy(RTrees self, float val);
bool cv_ml_RTrees_get_calculateVarImportance(RTrees self);
CvStatus* cv_ml_RTrees_set_calculateVarImportance(RTrees self, bool val);
int cv_ml_RTrees_get_activeVarCount(RTrees self);
CvStatus* cv_ml_RTrees_set_activeVarCount(RTrees self, int val);
CvStatus* cv_ml_RTrees_getPriors(RTrees self, Mat rval);
CvStatus* cv_ml_RTrees_setPriors(RTrees self, Mat val);
CvStatus* cv_ml_RTrees_getVarImportance(RTrees self, Mat rval);
CvStatus* cv_ml_RTrees_getTermCriteria(RTrees self, TermCriteria* rval);
CvStatus* cv_ml_RTrees_setTermCriteria(RTrees self, TermCriteria val);

CvStatus* cv_ml_RTrees_getVotes(RTrees self, Mat samples, Mat results, int flags);
double cv_ml_RTrees_getOOBError(RTrees self);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_RTREES_H
