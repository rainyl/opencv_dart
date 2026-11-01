/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_ANN_MLP_H
#define CVD_ML_ANN_MLP_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::ANN_MLP>, ANN_MLP);
#else
CVD_TYPEDEF(void*, ANN_MLP);
#endif

CVD_ML_STAT_MODEL_DECL(ANN_MLP)

CvStatus* cv_ml_ANN_MLP_getLayerSizes(ANN_MLP self, Mat rval);
CvStatus* cv_ml_ANN_MLP_setLayerSizes(ANN_MLP self, Mat val);
CvStatus* cv_ml_ANN_MLP_setActivationFunction(ANN_MLP self, int type, double param1, double param2);
CvStatus* cv_ml_ANN_MLP_setTrainMethod(ANN_MLP self, int method, double param1, double param2);
int cv_ml_ANN_MLP_get_trainMethod(ANN_MLP self);
CvStatus* cv_ml_ANN_MLP_getTermCriteria(ANN_MLP self, TermCriteria* rval);
CvStatus* cv_ml_ANN_MLP_setTermCriteria(ANN_MLP self, TermCriteria val);
CvStatus* cv_ml_ANN_MLP_getWeights(ANN_MLP self, int layerIdx, Mat rval);

double cv_ml_ANN_MLP_get_backpropWeightScale(ANN_MLP self);
void cv_ml_ANN_MLP_set_backpropWeightScale(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_backpropMomentumScale(ANN_MLP self);
void cv_ml_ANN_MLP_set_backpropMomentumScale(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_rpropDW0(ANN_MLP self);
void cv_ml_ANN_MLP_set_rpropDW0(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_rpropDWPlus(ANN_MLP self);
void cv_ml_ANN_MLP_set_rpropDWPlus(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_rpropDWMinus(ANN_MLP self);
void cv_ml_ANN_MLP_set_rpropDWMinus(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_rpropDWMin(ANN_MLP self);
void cv_ml_ANN_MLP_set_rpropDWMin(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_rpropDWMax(ANN_MLP self);
void cv_ml_ANN_MLP_set_rpropDWMax(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_annealInitialT(ANN_MLP self);
void cv_ml_ANN_MLP_set_annealInitialT(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_annealFinalT(ANN_MLP self);
void cv_ml_ANN_MLP_set_annealFinalT(ANN_MLP self, double val);
double cv_ml_ANN_MLP_get_annealCoolingRatio(ANN_MLP self);
void cv_ml_ANN_MLP_set_annealCoolingRatio(ANN_MLP self, double val);
int cv_ml_ANN_MLP_get_annealItePerStep(ANN_MLP self);
void cv_ml_ANN_MLP_set_annealItePerStep(ANN_MLP self, int val);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_ANN_MLP_H
