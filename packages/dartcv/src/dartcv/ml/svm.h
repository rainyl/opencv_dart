/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_SVM_H
#define CVD_ML_SVM_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::SVM>, SVM);
#else
CVD_TYPEDEF(void*, SVM);
#endif

/// Value copy of cv::ml::ParamGrid.
typedef struct MlParamGrid {
    double minVal;
    double maxVal;
    double logStep;
} MlParamGrid;

CVD_ML_STAT_MODEL_DECL(SVM)

int cv_ml_SVM_get_type(SVM self);
void cv_ml_SVM_set_type(SVM self, int val);
int cv_ml_SVM_get_kernelType(SVM self);
void cv_ml_SVM_set_kernelType(SVM self, int val);
double cv_ml_SVM_get_gamma(SVM self);
void cv_ml_SVM_set_gamma(SVM self, double val);
double cv_ml_SVM_get_coef0(SVM self);
void cv_ml_SVM_set_coef0(SVM self, double val);
double cv_ml_SVM_get_degree(SVM self);
void cv_ml_SVM_set_degree(SVM self, double val);
double cv_ml_SVM_get_C(SVM self);
void cv_ml_SVM_set_C(SVM self, double val);
double cv_ml_SVM_get_nu(SVM self);
void cv_ml_SVM_set_nu(SVM self, double val);
double cv_ml_SVM_get_p(SVM self);
void cv_ml_SVM_set_p(SVM self, double val);

CvStatus* cv_ml_SVM_getClassWeights(SVM self, Mat rval);
CvStatus* cv_ml_SVM_setClassWeights(SVM self, Mat val);
CvStatus* cv_ml_SVM_getTermCriteria(SVM self, TermCriteria* rval);
CvStatus* cv_ml_SVM_setTermCriteria(SVM self, TermCriteria val);

CvStatus* cv_ml_SVM_getSupportVectors(SVM self, Mat rval);
CvStatus* cv_ml_SVM_getUncompressedSupportVectors(SVM self, Mat rval);
CvStatus* cv_ml_SVM_getDecisionFunction(SVM self, int i, Mat alpha, Mat svidx, double* rval);
CvStatus* cv_ml_SVM_getDefaultGrid(int paramId, MlParamGrid* rval);
CvStatus* cv_ml_SVM_trainAuto(
    SVM self,
    TrainData data,
    int kFold,
    MlParamGrid Cgrid,
    MlParamGrid gammaGrid,
    MlParamGrid pGrid,
    MlParamGrid nuGrid,
    MlParamGrid coeffGrid,
    MlParamGrid degreeGrid,
    bool balanced,
    bool* rval,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_SVM_H
