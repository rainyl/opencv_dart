/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/normal_bayes_classifier.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(NormalBayesClassifier, cv::ml::NormalBayesClassifier)

CvStatus* cv_ml_NormalBayesClassifier_predictProb(
    NormalBayesClassifier self,
    Mat inputs,
    Mat outputs,
    Mat outputProbs,
    int flags,
    float* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = (CVDEREF(self))
                ->predictProb(CVDEREF(inputs), CVDEREF(outputs), CVDEREF(outputProbs), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
