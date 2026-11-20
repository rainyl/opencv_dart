/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_NORMAL_BAYES_CLASSIFIER_H
#define CVD_ML_NORMAL_BAYES_CLASSIFIER_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::NormalBayesClassifier>, NormalBayesClassifier);
#else
CVD_TYPEDEF(void*, NormalBayesClassifier);
#endif

CVD_ML_STAT_MODEL_DECL(NormalBayesClassifier)

CvStatus* cv_ml_NormalBayesClassifier_predictProb(
    NormalBayesClassifier self,
    Mat inputs,
    Mat outputs,
    Mat outputProbs,
    int flags,
    float* rval,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_NORMAL_BAYES_CLASSIFIER_H
