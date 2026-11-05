/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_EM_H
#define CVD_ML_EM_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::EM>, EM);
#else
CVD_TYPEDEF(void*, EM);
#endif

CVD_ML_STAT_MODEL_DECL(EM)

int cv_ml_EM_get_clustersNumber(EM self);
CvStatus* cv_ml_EM_set_clustersNumber(EM self, int val);
int cv_ml_EM_get_covarianceMatrixType(EM self);
CvStatus* cv_ml_EM_set_covarianceMatrixType(EM self, int val);
CvStatus* cv_ml_EM_getWeights(EM self, Mat rval);
CvStatus* cv_ml_EM_getMeans(EM self, Mat rval);
CvStatus* cv_ml_EM_getTermCriteria(EM self, TermCriteria* rval);
CvStatus* cv_ml_EM_setTermCriteria(EM self, TermCriteria val);

CvStatus* cv_ml_EM_getCovs(EM self, VecMat* rval);
CvStatus* cv_ml_EM_predict2(EM self, Mat sample, Mat probs, Vec2d* rval, CvCallback_0 callback);
/// Empty optional inputs (covs0, weights0) are passed to OpenCV as cv::noArray().
CvStatus* cv_ml_EM_trainEM(
    EM self,
    Mat samples,
    Mat logLikelihoods,
    Mat labels,
    Mat probs,
    bool* rval,
    CvCallback_0 callback
);
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
);
CvStatus* cv_ml_EM_trainM(
    EM self,
    Mat samples,
    Mat probs0,
    Mat logLikelihoods,
    Mat labels,
    Mat probs,
    bool* rval,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_EM_H
