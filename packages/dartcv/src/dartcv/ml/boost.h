/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_BOOST_H
#define CVD_ML_BOOST_H

#include "dartcv/core/types.h"
#include "dartcv/ml/dtrees.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::Boost>, Boost);
#else
CVD_TYPEDEF(void*, Boost);
#endif

CVD_ML_STAT_MODEL_DECL(Boost)
CVD_ML_TREES_DECL(Boost)

int cv_ml_Boost_get_maxCategories(Boost self);
CvStatus* cv_ml_Boost_set_maxCategories(Boost self, int val);
int cv_ml_Boost_get_maxDepth(Boost self);
CvStatus* cv_ml_Boost_set_maxDepth(Boost self, int val);
int cv_ml_Boost_get_minSampleCount(Boost self);
CvStatus* cv_ml_Boost_set_minSampleCount(Boost self, int val);
int cv_ml_Boost_get_cvFolds(Boost self);
CvStatus* cv_ml_Boost_set_cvFolds(Boost self, int val);
bool cv_ml_Boost_get_useSurrogates(Boost self);
CvStatus* cv_ml_Boost_set_useSurrogates(Boost self, bool val);
bool cv_ml_Boost_get_use1SERule(Boost self);
CvStatus* cv_ml_Boost_set_use1SERule(Boost self, bool val);
bool cv_ml_Boost_get_truncatePrunedTree(Boost self);
CvStatus* cv_ml_Boost_set_truncatePrunedTree(Boost self, bool val);
float cv_ml_Boost_get_regressionAccuracy(Boost self);
CvStatus* cv_ml_Boost_set_regressionAccuracy(Boost self, float val);
int cv_ml_Boost_get_boostType(Boost self);
CvStatus* cv_ml_Boost_set_boostType(Boost self, int val);
int cv_ml_Boost_get_weakCount(Boost self);
CvStatus* cv_ml_Boost_set_weakCount(Boost self, int val);
double cv_ml_Boost_get_weightTrimRate(Boost self);
CvStatus* cv_ml_Boost_set_weightTrimRate(Boost self, double val);
CvStatus* cv_ml_Boost_getPriors(Boost self, Mat rval);
CvStatus* cv_ml_Boost_setPriors(Boost self, Mat val);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_BOOST_H
