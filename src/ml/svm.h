/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ML_SVM_H
#define CVD_ML_SVM_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
// https://docs.opencv.org/4.x/d1/d2d/classcv_1_1ml_1_1SVM.html
CVD_TYPEDEF(cv::Ptr<cv::ml::SVM>, PtrSVM)
CVD_TYPEDEF(cv::Ptr<cv::ml::ParamGrid>, PtrParamGrid)
#else
CVD_TYPEDEF(void *, PtrSVM)
CVD_TYPEDEF(void *, PtrParamGrid)
#endif

CVD_TYPEDEF_PTR(PtrSVM)
CVD_TYPEDEF_PTR(PtrParamGrid)

// ParamGrid
CvStatus ParamGrid_Empty(PtrParamGrid *rval);
CvStatus ParamGrid_New(double minVal, double maxVal, double logstep, PtrParamGrid *rval);
CvStatus ParamGrid_getMinVal(PtrParamGrid self, double *rval);
CvStatus ParamGrid_GetMaxVal(PtrParamGrid self, double *rval);
CvStatus ParamGrid_GetLogStep(PtrParamGrid self, double *rval);
void     ParamGrid_Close(PtrParamGrid *self);

// SVM
CvStatus SVM_Create(PtrSVM *rval);
void     SVM_Close(PtrSVM *self);

CvStatus SVM_GetC(PtrSVM self, double *rval);
CvStatus SVM_GetClassWeights(PtrSVM self, Mat *rval);
CvStatus SVM_GetCoef0(PtrSVM self, double *rval);
CvStatus SVM_GetDecisionFunction(PtrSVM self, int i, Mat alpha, Mat svidx, double *rval);
CvStatus SVM_GetDegree(PtrSVM self, double *rval);
CvStatus SVM_GetGamma(PtrSVM self, double *rval);
CvStatus SVM_GetKernelType(PtrSVM self, int *rval);
CvStatus SVM_GetNu(PtrSVM self, double *rval);
CvStatus SVM_GetP(PtrSVM self, double *rval);
CvStatus SVM_GetSupportVectors(PtrSVM self, Mat *rval);
CvStatus SVM_GetTermCriteria(PtrSVM self, TermCriteria *rval);
CvStatus SVM_GetType(PtrSVM self, int *rval);
CvStatus SVM_GetUncompressedSupportVectors(PtrSVM self, Mat *rval);
CvStatus SVM_SetC(PtrSVM self, double val);
CvStatus SVM_SetClassWeights(PtrSVM self, Mat val);
CvStatus SVM_SetCoef0(PtrSVM self, double val);
// CvStatus SVM_SetCustomKernel(PtrSVM self, ); TODO
CvStatus SVM_SetDegree(PtrSVM self, double val);
CvStatus SVM_SetGamma(PtrSVM self, double val);
CvStatus SVM_SetKernel(PtrSVM self, int kernelType);
CvStatus SVM_SetNu(PtrSVM self, double val);
CvStatus SVM_SetP(PtrSVM self, double val);
CvStatus SVM_SetTermCriteria(PtrSVM self, TermCriteria val);
CvStatus SVM_SetType(PtrSVM self, int val);
CvStatus SVM_TrainAuto(PtrSVM self, PtrTrainData data, int kFold, PtrParamGrid Cgrid, PtrParamGrid gammaGrid,
                       PtrParamGrid pGrid, PtrParamGrid nuGrid, PtrParamGrid coeffGrid,
                       PtrParamGrid degreeGrid, bool balanced, bool *rval);
CvStatus SVM_TrainAuto_1(PtrSVM self, Mat samples, int layout, Mat responses, int kFold, PtrParamGrid Cgrid,
                         PtrParamGrid gammaGrid, PtrParamGrid pGrid, PtrParamGrid nuGrid,
                         PtrParamGrid coeffGrid, PtrParamGrid degreeGrid, bool balanced, bool *rval);
CvStatus SVM_CalcError(PtrSVM self, PtrTrainData data, bool test, Mat resp, float *rval);
CvStatus SVM_Empty(PtrSVM self, bool *rval);
CvStatus SVM_GetVarCount(PtrSVM self, int *rval);
CvStatus SVM_IsClassifier(PtrSVM self, bool *rval);
CvStatus SVM_IsTrained(PtrSVM self, bool *rval);
CvStatus SVM_Predict(PtrSVM self, Mat samples, Mat results, int flags, float *rval);
CvStatus SVM_Train(PtrSVM self, PtrTrainData trainData, int flags, bool *rval);
CvStatus SVM_Train_1(PtrSVM self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus SVM_Clear(PtrSVM self);
CvStatus SVM_GetDefaultName(PtrSVM self, char *rval);
CvStatus SVM_GetDefaultGridPtr(PtrSVM self, int param_id, PtrParamGrid *rval);
CvStatus SVM_Save(PtrSVM self, char *filename);
CvStatus SVM_Load(char *filepath, PtrSVM *rval);
CvStatus SVM_LoadFromString(const char *strModel, const char *objname, PtrSVM *rval);

#ifdef __cplusplus
}
#endif

#endif
