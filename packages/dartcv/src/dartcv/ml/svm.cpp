/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/svm.h"
#include "dartcv/ml/stat_model.hpp"

CVD_ML_STAT_MODEL_IMPL(SVM, cv::ml::SVM)

static cv::ml::ParamGrid cvd_param_grid(MlParamGrid g) {
    return cv::ml::ParamGrid(g.minVal, g.maxVal, g.logStep);
}

int cv_ml_SVM_get_type(SVM self) {
    return (CVDEREF(self))->getType();
}
void cv_ml_SVM_set_type(SVM self, int val) {
    (CVDEREF(self))->setType(val);
}
int cv_ml_SVM_get_kernelType(SVM self) {
    return (CVDEREF(self))->getKernelType();
}
void cv_ml_SVM_set_kernelType(SVM self, int val) {
    (CVDEREF(self))->setKernel(val);
}
double cv_ml_SVM_get_gamma(SVM self) {
    return (CVDEREF(self))->getGamma();
}
void cv_ml_SVM_set_gamma(SVM self, double val) {
    (CVDEREF(self))->setGamma(val);
}
double cv_ml_SVM_get_coef0(SVM self) {
    return (CVDEREF(self))->getCoef0();
}
void cv_ml_SVM_set_coef0(SVM self, double val) {
    (CVDEREF(self))->setCoef0(val);
}
double cv_ml_SVM_get_degree(SVM self) {
    return (CVDEREF(self))->getDegree();
}
void cv_ml_SVM_set_degree(SVM self, double val) {
    (CVDEREF(self))->setDegree(val);
}
double cv_ml_SVM_get_C(SVM self) {
    return (CVDEREF(self))->getC();
}
void cv_ml_SVM_set_C(SVM self, double val) {
    (CVDEREF(self))->setC(val);
}
double cv_ml_SVM_get_nu(SVM self) {
    return (CVDEREF(self))->getNu();
}
void cv_ml_SVM_set_nu(SVM self, double val) {
    (CVDEREF(self))->setNu(val);
}
double cv_ml_SVM_get_p(SVM self) {
    return (CVDEREF(self))->getP();
}
void cv_ml_SVM_set_p(SVM self, double val) {
    (CVDEREF(self))->setP(val);
}

CvStatus* cv_ml_SVM_getClassWeights(SVM self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getClassWeights();
    END_WRAP
}
CvStatus* cv_ml_SVM_setClassWeights(SVM self, Mat val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setClassWeights(CVDEREF(val));
    END_WRAP
}
CvStatus* cv_ml_SVM_getTermCriteria(SVM self, TermCriteria* rval) {
    BEGIN_WRAP
    auto tc = (CVDEREF(self))->getTermCriteria();
    *rval = {tc.type, tc.maxCount, tc.epsilon};
    END_WRAP
}
CvStatus* cv_ml_SVM_setTermCriteria(SVM self, TermCriteria val) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTermCriteria(cv::TermCriteria(val.type, val.maxCount, val.epsilon));
    END_WRAP
}

CvStatus* cv_ml_SVM_getSupportVectors(SVM self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getSupportVectors();
    END_WRAP
}
CvStatus* cv_ml_SVM_getUncompressedSupportVectors(SVM self, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getUncompressedSupportVectors();
    END_WRAP
}
CvStatus* cv_ml_SVM_getDecisionFunction(
    SVM self, int i, Mat alpha, Mat svidx, double* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = (CVDEREF(self))->getDecisionFunction(i, CVDEREF(alpha), CVDEREF(svidx));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_ml_SVM_getDefaultGrid(int paramId, MlParamGrid* rval) {
    BEGIN_WRAP
    auto g = cv::ml::SVM::getDefaultGrid(paramId);
    *rval = {g.minVal, g.maxVal, g.logStep};
    END_WRAP
}
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
) {
    BEGIN_WRAP
    *rval = (CVDEREF(self))
                ->trainAuto(
                    CVDEREF(data),
                    kFold,
                    cvd_param_grid(Cgrid),
                    cvd_param_grid(gammaGrid),
                    cvd_param_grid(pGrid),
                    cvd_param_grid(nuGrid),
                    cvd_param_grid(coeffGrid),
                    cvd_param_grid(degreeGrid),
                    balanced
                );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
