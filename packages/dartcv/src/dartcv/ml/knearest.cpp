/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/knearest.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(KNearest, cv::ml::KNearest)

int cv_ml_KNearest_get_defaultK(KNearest self) {
    return (CVDEREF(self))->getDefaultK();
}
void cv_ml_KNearest_set_defaultK(KNearest self, int val) {
    (CVDEREF(self))->setDefaultK(val);
}
bool cv_ml_KNearest_get_isClassifier(KNearest self) {
    return (CVDEREF(self))->getIsClassifier();
}
void cv_ml_KNearest_set_isClassifier(KNearest self, bool val) {
    (CVDEREF(self))->setIsClassifier(val);
}
int cv_ml_KNearest_get_emax(KNearest self) {
    return (CVDEREF(self))->getEmax();
}
void cv_ml_KNearest_set_emax(KNearest self, int val) {
    (CVDEREF(self))->setEmax(val);
}
int cv_ml_KNearest_get_algorithmType(KNearest self) {
    return (CVDEREF(self))->getAlgorithmType();
}
void cv_ml_KNearest_set_algorithmType(KNearest self, int val) {
    (CVDEREF(self))->setAlgorithmType(val);
}

CvStatus* cv_ml_KNearest_findNearest(
    KNearest self,
    Mat samples,
    int k,
    Mat results,
    Mat neighborResponses,
    Mat dist,
    float* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = (CVDEREF(self))
                ->findNearest(
                    CVDEREF(samples), k, CVDEREF(results), CVDEREF(neighborResponses), CVDEREF(dist)
                );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
