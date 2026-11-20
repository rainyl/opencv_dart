/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/em.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(EM, cv::ml::EM)

int cv_ml_EM_get_clustersNumber(EM self) {
    return (CVDEREF(self))->getClustersNumber();
}
CvStatus* cv_ml_EM_set_clustersNumber(EM self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setClustersNumber(val);
    END_WRAP
}

int cv_ml_EM_get_covarianceMatrixType(EM self) {
    return (CVDEREF(self))->getCovarianceMatrixType();
}
CvStatus* cv_ml_EM_set_covarianceMatrixType(EM self, int val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setCovarianceMatrixType(val);
    END_WRAP
}

CvStatus* cv_ml_EM_getWeights(EM self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getWeights();
    END_WRAP
}

CvStatus* cv_ml_EM_getMeans(EM self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getMeans();
    END_WRAP
}

CvStatus* cv_ml_EM_getTermCriteria(EM self, TermCriteria* rval) {
    BEGIN_WRAP
    auto tc = (CVDEREF(self))->getTermCriteria();
    *rval = {tc.type, tc.maxCount, tc.epsilon};
    END_WRAP
}
CvStatus* cv_ml_EM_setTermCriteria(EM self, TermCriteria val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTermCriteria(cv::TermCriteria(val.type, val.maxCount, val.epsilon));
    END_WRAP
}

CvStatus* cv_ml_EM_getCovs(EM self, VecMat* rval) {
    BEGIN_WRAP(CVDEREF(self))
    ->getCovs(CVDEREF_P(rval));
    END_WRAP
}
CvStatus* cv_ml_EM_predict2(EM self, Mat sample, Mat probs, Vec2d* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto v = (CVDEREF(self))->predict2(CVDEREF(sample), CVDEREF(probs));
    *rval = {v[0], v[1]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_ml_EM_trainEM(
    EM self,
    Mat samples,
    Mat logLikelihoods,
    Mat labels,
    Mat probs,
    bool* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval =
        (CVDEREF(self))
            ->trainEM(CVDEREF(samples), CVDEREF(logLikelihoods), CVDEREF(labels), CVDEREF(probs));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_ml_EM_trainE(
    EM self,
    Mat samples,
    Mat means0,
    VecMat covs0,
    Mat weights0,
    Mat logLikelihoods,
    Mat labels,
    Mat probs,
    bool* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::_InputArray covs = covs0.ptr == nullptr || covs0.ptr->empty() ? cv::_InputArray()
                                                                      : cv::_InputArray(*covs0.ptr);
    *rval = (CVDEREF(self))
                ->trainE(
                    CVDEREF(samples),
                    CVDEREF(means0),
                    covs,
                    cvd_or_noarray(weights0),
                    CVDEREF(logLikelihoods),
                    CVDEREF(labels),
                    CVDEREF(probs)
                );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_ml_EM_trainM(
    EM self,
    Mat samples,
    Mat probs0,
    Mat logLikelihoods,
    Mat labels,
    Mat probs,
    bool* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = (CVDEREF(self))
                ->trainM(
                    CVDEREF(samples),
                    CVDEREF(probs0),
                    CVDEREF(logLikelihoods),
                    CVDEREF(labels),
                    CVDEREF(probs)
                );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
