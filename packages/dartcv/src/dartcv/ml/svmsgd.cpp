/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/svmsgd.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(SVMSGD, cv::ml::SVMSGD)

int cv_ml_SVMSGD_get_svmsgdType(SVMSGD self) {
    return (CVDEREF(self))->getSvmsgdType();
}
CvStatus* cv_ml_SVMSGD_set_svmsgdType(SVMSGD self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setSvmsgdType(val);
    END_WRAP
}

int cv_ml_SVMSGD_get_marginType(SVMSGD self) {
    return (CVDEREF(self))->getMarginType();
}
CvStatus* cv_ml_SVMSGD_set_marginType(SVMSGD self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMarginType(val);
    END_WRAP
}

float cv_ml_SVMSGD_get_marginRegularization(SVMSGD self) {
    return (CVDEREF(self))->getMarginRegularization();
}
CvStatus* cv_ml_SVMSGD_set_marginRegularization(SVMSGD self, float val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMarginRegularization(val);
    END_WRAP
}

float cv_ml_SVMSGD_get_initialStepSize(SVMSGD self) {
    return (CVDEREF(self))->getInitialStepSize();
}
CvStatus* cv_ml_SVMSGD_set_initialStepSize(SVMSGD self, float val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setInitialStepSize(val);
    END_WRAP
}

float cv_ml_SVMSGD_get_stepDecreasingPower(SVMSGD self) {
    return (CVDEREF(self))->getStepDecreasingPower();
}
CvStatus* cv_ml_SVMSGD_set_stepDecreasingPower(SVMSGD self, float val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setStepDecreasingPower(val);
    END_WRAP
}

CvStatus* cv_ml_SVMSGD_getWeights(SVMSGD self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getWeights();
    END_WRAP
}

CvStatus* cv_ml_SVMSGD_getTermCriteria(SVMSGD self, TermCriteria* rval) {
    BEGIN_WRAP
    auto tc = (CVDEREF(self))->getTermCriteria();
    *rval = {tc.type, tc.maxCount, tc.epsilon};
    END_WRAP
}
CvStatus* cv_ml_SVMSGD_setTermCriteria(SVMSGD self, TermCriteria val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTermCriteria(cv::TermCriteria(val.type, val.maxCount, val.epsilon));
    END_WRAP
}

float cv_ml_SVMSGD_getShift(SVMSGD self) {
    return (CVDEREF(self))->getShift();
}
CvStatus* cv_ml_SVMSGD_setOptimalParameters(SVMSGD self, int svmsgdType, int marginType) {
    BEGIN_WRAP(CVDEREF(self))
    ->setOptimalParameters(svmsgdType, marginType);
    END_WRAP
}
