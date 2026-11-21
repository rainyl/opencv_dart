/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/ann_mlp.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(ANN_MLP, cv::ml::ANN_MLP)

CvStatus* cv_ml_ANN_MLP_getLayerSizes(ANN_MLP self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getLayerSizes();
    END_WRAP
}
CvStatus* cv_ml_ANN_MLP_setLayerSizes(ANN_MLP self, Mat val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setLayerSizes(CVDEREF(val));
    END_WRAP
}
CvStatus* cv_ml_ANN_MLP_setActivationFunction(
    ANN_MLP self, int type, double param1, double param2
) {
    BEGIN_WRAP(CVDEREF(self))
    ->setActivationFunction(type, param1, param2);
    END_WRAP
}
CvStatus* cv_ml_ANN_MLP_setTrainMethod(ANN_MLP self, int method, double param1, double param2) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTrainMethod(method, param1, param2);
    END_WRAP
}
int cv_ml_ANN_MLP_get_trainMethod(ANN_MLP self) {
    return (CVDEREF(self))->getTrainMethod();
}
CvStatus* cv_ml_ANN_MLP_getTermCriteria(ANN_MLP self, TermCriteria* rval) {
    BEGIN_WRAP
    auto tc = (CVDEREF(self))->getTermCriteria();
    *rval = {tc.type, tc.maxCount, tc.epsilon};
    END_WRAP
}
CvStatus* cv_ml_ANN_MLP_setTermCriteria(ANN_MLP self, TermCriteria val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTermCriteria(cv::TermCriteria(val.type, val.maxCount, val.epsilon));
    END_WRAP
}
CvStatus* cv_ml_ANN_MLP_getWeights(ANN_MLP self, int layerIdx, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getWeights(layerIdx);
    END_WRAP
}

#define CVD_ANN_MLP_PROP(TYPE, NAME, CV_NAME)                                                      \
    TYPE cv_ml_ANN_MLP_get_##NAME(ANN_MLP self) {                                                  \
        return (CVDEREF(self))->get##CV_NAME();                                                    \
    }                                                                                              \
    void cv_ml_ANN_MLP_set_##NAME(ANN_MLP self, TYPE val) {                                        \
        (CVDEREF(self))->set##CV_NAME(val);                                                        \
    }

CVD_ANN_MLP_PROP(double, backpropWeightScale, BackpropWeightScale)
CVD_ANN_MLP_PROP(double, backpropMomentumScale, BackpropMomentumScale)
CVD_ANN_MLP_PROP(double, rpropDW0, RpropDW0)
CVD_ANN_MLP_PROP(double, rpropDWPlus, RpropDWPlus)
CVD_ANN_MLP_PROP(double, rpropDWMinus, RpropDWMinus)
CVD_ANN_MLP_PROP(double, rpropDWMin, RpropDWMin)
CVD_ANN_MLP_PROP(double, rpropDWMax, RpropDWMax)
CVD_ANN_MLP_PROP(double, annealInitialT, AnnealInitialT)
CVD_ANN_MLP_PROP(double, annealFinalT, AnnealFinalT)
CVD_ANN_MLP_PROP(double, annealCoolingRatio, AnnealCoolingRatio)
CVD_ANN_MLP_PROP(int, annealItePerStep, AnnealItePerStep)

#undef CVD_ANN_MLP_PROP
