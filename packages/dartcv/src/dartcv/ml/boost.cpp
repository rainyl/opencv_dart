/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/boost.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(Boost, cv::ml::Boost)

int cv_ml_Boost_get_maxCategories(Boost self) {
    return (CVDEREF(self))->getMaxCategories();
}
CvStatus* cv_ml_Boost_set_maxCategories(Boost self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMaxCategories(val);
    END_WRAP
}

int cv_ml_Boost_get_maxDepth(Boost self) {
    return (CVDEREF(self))->getMaxDepth();
}
CvStatus* cv_ml_Boost_set_maxDepth(Boost self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMaxDepth(val);
    END_WRAP
}

int cv_ml_Boost_get_minSampleCount(Boost self) {
    return (CVDEREF(self))->getMinSampleCount();
}
CvStatus* cv_ml_Boost_set_minSampleCount(Boost self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMinSampleCount(val);
    END_WRAP
}

int cv_ml_Boost_get_cvFolds(Boost self) {
    return (CVDEREF(self))->getCVFolds();
}
CvStatus* cv_ml_Boost_set_cvFolds(Boost self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setCVFolds(val);
    END_WRAP
}

bool cv_ml_Boost_get_useSurrogates(Boost self) {
    return (CVDEREF(self))->getUseSurrogates();
}
CvStatus* cv_ml_Boost_set_useSurrogates(Boost self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setUseSurrogates(val);
    END_WRAP
}

bool cv_ml_Boost_get_use1SERule(Boost self) {
    return (CVDEREF(self))->getUse1SERule();
}
CvStatus* cv_ml_Boost_set_use1SERule(Boost self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setUse1SERule(val);
    END_WRAP
}

bool cv_ml_Boost_get_truncatePrunedTree(Boost self) {
    return (CVDEREF(self))->getTruncatePrunedTree();
}
CvStatus* cv_ml_Boost_set_truncatePrunedTree(Boost self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTruncatePrunedTree(val);
    END_WRAP
}

float cv_ml_Boost_get_regressionAccuracy(Boost self) {
    return (CVDEREF(self))->getRegressionAccuracy();
}
CvStatus* cv_ml_Boost_set_regressionAccuracy(Boost self, float val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setRegressionAccuracy(val);
    END_WRAP
}

int cv_ml_Boost_get_boostType(Boost self) {
    return (CVDEREF(self))->getBoostType();
}
CvStatus* cv_ml_Boost_set_boostType(Boost self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setBoostType(val);
    END_WRAP
}

int cv_ml_Boost_get_weakCount(Boost self) {
    return (CVDEREF(self))->getWeakCount();
}
CvStatus* cv_ml_Boost_set_weakCount(Boost self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setWeakCount(val);
    END_WRAP
}

double cv_ml_Boost_get_weightTrimRate(Boost self) {
    return (CVDEREF(self))->getWeightTrimRate();
}
CvStatus* cv_ml_Boost_set_weightTrimRate(Boost self, double val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setWeightTrimRate(val);
    END_WRAP
}

CvStatus* cv_ml_Boost_getPriors(Boost self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getPriors();
    END_WRAP
}

CvStatus* cv_ml_Boost_setPriors(Boost self, Mat val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setPriors(CVDEREF(val));
    END_WRAP
}
