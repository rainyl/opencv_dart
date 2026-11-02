/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/logistic_regression.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(LogisticRegression, cv::ml::LogisticRegression)

double cv_ml_LogisticRegression_get_learningRate(LogisticRegression self) {
    return (CVDEREF(self))->getLearningRate();
}
CvStatus* cv_ml_LogisticRegression_set_learningRate(LogisticRegression self, double val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setLearningRate(val);
    END_WRAP
}

int cv_ml_LogisticRegression_get_iterations(LogisticRegression self) {
    return (CVDEREF(self))->getIterations();
}
CvStatus* cv_ml_LogisticRegression_set_iterations(LogisticRegression self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setIterations(val);
    END_WRAP
}

int cv_ml_LogisticRegression_get_regularization(LogisticRegression self) {
    return (CVDEREF(self))->getRegularization();
}
CvStatus* cv_ml_LogisticRegression_set_regularization(LogisticRegression self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setRegularization(val);
    END_WRAP
}

int cv_ml_LogisticRegression_get_trainMethod(LogisticRegression self) {
    return (CVDEREF(self))->getTrainMethod();
}
CvStatus* cv_ml_LogisticRegression_set_trainMethod(LogisticRegression self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTrainMethod(val);
    END_WRAP
}

int cv_ml_LogisticRegression_get_miniBatchSize(LogisticRegression self) {
    return (CVDEREF(self))->getMiniBatchSize();
}
CvStatus* cv_ml_LogisticRegression_set_miniBatchSize(LogisticRegression self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setMiniBatchSize(val);
    END_WRAP
}

CvStatus* cv_ml_LogisticRegression_get_learnt_thetas(LogisticRegression self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->get_learnt_thetas();
    END_WRAP
}

CvStatus* cv_ml_LogisticRegression_getTermCriteria(LogisticRegression self, TermCriteria* rval) {
    BEGIN_WRAP
    auto tc = (CVDEREF(self))->getTermCriteria();
    *rval = {tc.type, tc.maxCount, tc.epsilon};
    END_WRAP
}
CvStatus* cv_ml_LogisticRegression_setTermCriteria(LogisticRegression self, TermCriteria val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTermCriteria(cv::TermCriteria(val.type, val.maxCount, val.epsilon));
    END_WRAP
}
