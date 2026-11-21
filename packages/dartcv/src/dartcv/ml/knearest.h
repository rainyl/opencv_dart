/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_KNEAREST_H
#define CVD_ML_KNEAREST_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::KNearest>, KNearest);
#else
CVD_TYPEDEF(void*, KNearest);
#endif

CVD_ML_STAT_MODEL_DECL(KNearest)

int cv_ml_KNearest_get_defaultK(KNearest self);
void cv_ml_KNearest_set_defaultK(KNearest self, int val);
bool cv_ml_KNearest_get_isClassifier(KNearest self);
void cv_ml_KNearest_set_isClassifier(KNearest self, bool val);
int cv_ml_KNearest_get_emax(KNearest self);
void cv_ml_KNearest_set_emax(KNearest self, int val);
int cv_ml_KNearest_get_algorithmType(KNearest self);
void cv_ml_KNearest_set_algorithmType(KNearest self, int val);

CvStatus* cv_ml_KNearest_findNearest(
    KNearest self,
    Mat samples,
    int k,
    Mat results,
    Mat neighborResponses,
    Mat dist,
    float* rval,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_KNEAREST_H
