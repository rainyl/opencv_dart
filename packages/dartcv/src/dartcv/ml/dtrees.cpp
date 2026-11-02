/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/dtrees.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(DTrees, cv::ml::DTrees)
CVD_ML_TREES_IMPL(DTrees)

int cv_ml_DTrees_get_maxCategories(DTrees self) {
    return (CVDEREF(self))->getMaxCategories();
}
CvStatus* cv_ml_DTrees_set_maxCategories(DTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMaxCategories(val);
    END_WRAP
}

int cv_ml_DTrees_get_maxDepth(DTrees self) {
    return (CVDEREF(self))->getMaxDepth();
}
CvStatus* cv_ml_DTrees_set_maxDepth(DTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMaxDepth(val);
    END_WRAP
}

int cv_ml_DTrees_get_minSampleCount(DTrees self) {
    return (CVDEREF(self))->getMinSampleCount();
}
CvStatus* cv_ml_DTrees_set_minSampleCount(DTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMinSampleCount(val);
    END_WRAP
}

int cv_ml_DTrees_get_cvFolds(DTrees self) {
    return (CVDEREF(self))->getCVFolds();
}
CvStatus* cv_ml_DTrees_set_cvFolds(DTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setCVFolds(val);
    END_WRAP
}

bool cv_ml_DTrees_get_useSurrogates(DTrees self) {
    return (CVDEREF(self))->getUseSurrogates();
}
CvStatus* cv_ml_DTrees_set_useSurrogates(DTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setUseSurrogates(val);
    END_WRAP
}

bool cv_ml_DTrees_get_use1SERule(DTrees self) {
    return (CVDEREF(self))->getUse1SERule();
}
CvStatus* cv_ml_DTrees_set_use1SERule(DTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setUse1SERule(val);
    END_WRAP
}

bool cv_ml_DTrees_get_truncatePrunedTree(DTrees self) {
    return (CVDEREF(self))->getTruncatePrunedTree();
}
CvStatus* cv_ml_DTrees_set_truncatePrunedTree(DTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTruncatePrunedTree(val);
    END_WRAP
}

float cv_ml_DTrees_get_regressionAccuracy(DTrees self) {
    return (CVDEREF(self))->getRegressionAccuracy();
}
CvStatus* cv_ml_DTrees_set_regressionAccuracy(DTrees self, float val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setRegressionAccuracy(val);
    END_WRAP
}

CvStatus* cv_ml_DTrees_getPriors(DTrees self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getPriors();
    END_WRAP
}

CvStatus* cv_ml_DTrees_setPriors(DTrees self, Mat val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setPriors(CVDEREF(val));
    END_WRAP
}
