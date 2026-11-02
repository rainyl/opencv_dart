/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/rtrees.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(RTrees, cv::ml::RTrees)

int cv_ml_RTrees_get_maxCategories(RTrees self) {
    return (CVDEREF(self))->getMaxCategories();
}
CvStatus* cv_ml_RTrees_set_maxCategories(RTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMaxCategories(val);
    END_WRAP
}

int cv_ml_RTrees_get_maxDepth(RTrees self) {
    return (CVDEREF(self))->getMaxDepth();
}
CvStatus* cv_ml_RTrees_set_maxDepth(RTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMaxDepth(val);
    END_WRAP
}

int cv_ml_RTrees_get_minSampleCount(RTrees self) {
    return (CVDEREF(self))->getMinSampleCount();
}
CvStatus* cv_ml_RTrees_set_minSampleCount(RTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMinSampleCount(val);
    END_WRAP
}

int cv_ml_RTrees_get_cvFolds(RTrees self) {
    return (CVDEREF(self))->getCVFolds();
}
CvStatus* cv_ml_RTrees_set_cvFolds(RTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setCVFolds(val);
    END_WRAP
}

bool cv_ml_RTrees_get_useSurrogates(RTrees self) {
    return (CVDEREF(self))->getUseSurrogates();
}
CvStatus* cv_ml_RTrees_set_useSurrogates(RTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setUseSurrogates(val);
    END_WRAP
}

bool cv_ml_RTrees_get_use1SERule(RTrees self) {
    return (CVDEREF(self))->getUse1SERule();
}
CvStatus* cv_ml_RTrees_set_use1SERule(RTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setUse1SERule(val);
    END_WRAP
}

bool cv_ml_RTrees_get_truncatePrunedTree(RTrees self) {
    return (CVDEREF(self))->getTruncatePrunedTree();
}
CvStatus* cv_ml_RTrees_set_truncatePrunedTree(RTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTruncatePrunedTree(val);
    END_WRAP
}

float cv_ml_RTrees_get_regressionAccuracy(RTrees self) {
    return (CVDEREF(self))->getRegressionAccuracy();
}
CvStatus* cv_ml_RTrees_set_regressionAccuracy(RTrees self, float val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setRegressionAccuracy(val);
    END_WRAP
}

bool cv_ml_RTrees_get_calculateVarImportance(RTrees self) {
    return (CVDEREF(self))->getCalculateVarImportance();
}
CvStatus* cv_ml_RTrees_set_calculateVarImportance(RTrees self, bool val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setCalculateVarImportance(val);
    END_WRAP
}

int cv_ml_RTrees_get_activeVarCount(RTrees self) {
    return (CVDEREF(self))->getActiveVarCount();
}
CvStatus* cv_ml_RTrees_set_activeVarCount(RTrees self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setActiveVarCount(val);
    END_WRAP
}

CvStatus* cv_ml_RTrees_getPriors(RTrees self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getPriors();
    END_WRAP
}

CvStatus* cv_ml_RTrees_setPriors(RTrees self, Mat val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setPriors(CVDEREF(val));
    END_WRAP
}

CvStatus* cv_ml_RTrees_getVarImportance(RTrees self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getVarImportance();
    END_WRAP
}

CvStatus* cv_ml_RTrees_getTermCriteria(RTrees self, TermCriteria* rval) {
    BEGIN_WRAP
    auto tc = (CVDEREF(self))->getTermCriteria();
    *rval = {tc.type, tc.maxCount, tc.epsilon};
    END_WRAP
}
CvStatus* cv_ml_RTrees_setTermCriteria(RTrees self, TermCriteria val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTermCriteria(cv::TermCriteria(val.type, val.maxCount, val.epsilon));
    END_WRAP
}

CvStatus* cv_ml_RTrees_getVotes(RTrees self, Mat samples, Mat results, int flags) {
    BEGIN_WRAP(CVDEREF(self))
    ->getVotes(CVDEREF(samples), CVDEREF(results), flags);
    END_WRAP
}
double cv_ml_RTrees_getOOBError(RTrees self) {
    return (CVDEREF(self))->getOOBError();
}
