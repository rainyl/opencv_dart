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
CVD_TYPEDEF(cv::ml::SVM, SVM)
CVD_TYPEDEF(cv::Ptr<cv::ml::ParamGrid>, PtrParamGrid)
CVD_TYPEDEF(cv::ml::ParamGrid, ParamGrid)
#else
CVD_TYPEDEF(void *, PtrSVM)
CVD_TYPEDEF(void, SVM)
CVD_TYPEDEF(void *, PtrParamGrid)
CVD_TYPEDEF(void, ParamGrid)
#endif

CVD_TYPEDEF_PTR(PtrSVM)
CVD_TYPEDEF_PTR(SVM)
CVD_TYPEDEF_PTR(ParamGrid)

// ParamGrid
CvStatus ParamGrid_Empty(ParamGrid *rval);
CvStatus ParamGrid_New(double minVal, double maxVal, double logstep, ParamGrid *rval);
CvStatus ParamGrid_getMinVal(ParamGrid self, double *rval);
CvStatus ParamGrid_GetMaxVal(ParamGrid self, double *rval);
CvStatus ParamGrid_GetLogStep(ParamGrid self, double *rval);
void     ParamGrid_Close(PtrParamGrid *self);

// SVM
CvStatus SVM_Create(PtrSVM *rval);
void     SVM_Close(PtrSVM *self);
CvStatus SVM_Get(PtrSVM self, SVM *rval);

CvStatus SVM_GetC(SVM self, double *rval);
CvStatus SVM_GetClassWeights(SVM self, Mat *rval);
CvStatus SVM_GetCoef0(SVM self, double *rval);
CvStatus SVM_GetDecisionFunction(SVM self, int i, Mat alpha, Mat svidx, double *rval);
CvStatus SVM_GetDegree(SVM self, double *rval);
CvStatus SVM_GetGamma(SVM self, double *rval);
CvStatus SVM_GetKernelType(SVM self, int *rval);
CvStatus SVM_GetNu(SVM self, double *rval);
CvStatus SVM_GetP(SVM self, double *rval);
CvStatus SVM_GetSupportVectors(SVM self, Mat *rval);
CvStatus SVM_GetTermCriteria(SVM self, TermCriteria *rval);
CvStatus SVM_GetType(SVM self, int *rval);
CvStatus SVM_GetUncompressedSupportVectors(SVM self, Mat *rval);
CvStatus SVM_SetC(SVM self, double val);
CvStatus SVM_SetClassWeights(SVM self, Mat val);
CvStatus SVM_SetCoef0(SVM self, double val);
// CvStatus SVM_SetCustomKernel(SVM self, ); TODO
CvStatus SVM_SetDegree(SVM self, double val);
CvStatus SVM_SetGamma(SVM self, double val);
CvStatus SVM_SetKernel(SVM self, int kernelType);
CvStatus SVM_SetNu(SVM self, double val);
CvStatus SVM_SetP(SVM self, double val);
CvStatus SVM_SetTermCriteria(SVM self, TermCriteria val);
CvStatus SVM_SetType(SVM self, int val);
CvStatus SVM_TrainAuto(SVM self, PtrTrainData data, int kFold, ParamGrid Cgrid, ParamGrid gammaGrid,
                       ParamGrid pGrid, ParamGrid nuGrid, ParamGrid coeffGrid, ParamGrid degreeGrid,
                       bool balanced, bool *rval);
CvStatus SVM_TrainAuto_1(SVM self, Mat samples, int layout, Mat responses, int kFold, PtrParamGrid Cgrid,
                         PtrParamGrid gammaGrid, PtrParamGrid pGrid, PtrParamGrid nuGrid,
                         PtrParamGrid coeffGrid, PtrParamGrid degreeGrid, bool balanced, bool *rval);
CvStatus SVM_CalcError(SVM self, PtrTrainData data, bool test, Mat resp, float *rval);
CvStatus SVM_Empty(SVM self, bool *rval);
CvStatus SVM_GetVarCount(SVM self, int *rval);
CvStatus SVM_IsClassifier(SVM self, bool *rval);
CvStatus SVM_IsTrained(SVM self, bool *rval);
CvStatus SVM_Predict(SVM self, Mat samples, Mat results, int flags, float *rval);
CvStatus SVM_Train(SVM self, PtrTrainData trainData, int flags, bool *rval);
CvStatus SVM_Train_1(SVM self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus SVM_Clear(SVM self);
CvStatus SVM_GetDefaultName(SVM self, char *rval);
CvStatus SVM_GetDefaultGrid(SVM self, int param_id, ParamGrid *rval);
CvStatus SVM_GetDefaultGridPtr(SVM self, int param_id, PtrParamGrid *rval);
CvStatus SVM_Save(SVM self, char *filename);
CvStatus SVM_Load(SVM self, char *filepath);
CvStatus SVM_LoadFromString(SVM self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
