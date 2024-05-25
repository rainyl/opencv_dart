/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_SVMSGD_H
#define CVD_ML_SVMSGD_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::SVMSGD>, PtrSVMSGD)
CVD_TYPEDEF(cv::ml::SVMSGD, SVMSGD)
#else
CVD_TYPEDEF(void *, PtrSVMSGD)
CVD_TYPEDEF(void, SVMSGD)
#endif

CVD_TYPEDEF_PTR(PtrSVMSGD)
CVD_TYPEDEF_PTR(SVMSGD)

// SVMSGD
CvStatus SVMSGD_Create(PtrSVMSGD *rval);
void     SVMSGD_Close(PtrSVMSGD *self);
CvStatus SVMSGD_Get(PtrSVMSGD self, SVMSGD *rval);

CvStatus SVMSGD_SetOptimalParameters(SVMSGD self, int svmsgdType, int marginType);
CvStatus SVMSGD_GetWeights(SVMSGD self, Mat *rval);
CvStatus SVMSGD_GetShift(SVMSGD self, float *rval);
CvStatus SVMSGD_GetSvmsgdType(SVMSGD self, int *rval);
CvStatus SVMSGD_SetSvmsgdType(SVMSGD self, int svmsgdType);
CvStatus SVMSGD_GetMarginType(SVMSGD self, int *rval);
CvStatus SVMSGD_SetMarginType(SVMSGD self, int marginType);
CvStatus SVMSGD_GetMarginRegularization(SVMSGD self, float *rval);
CvStatus SVMSGD_SetMarginRegularization(SVMSGD self, float marginRegularization);
CvStatus SVMSGD_GetInitialStepSize(SVMSGD self, float *rval);
CvStatus SVMSGD_SetInitialStepSize(SVMSGD self, float InitialStepSize);
CvStatus SVMSGD_GetStepDecreasingPower(SVMSGD self, float *rval);
CvStatus SVMSGD_SetStepDecreasingPower(SVMSGD self, float stepDecreasingPower);
CvStatus SVMSGD_GetTermCriteria(SVMSGD self, TermCriteria *rval);
CvStatus SVMSGD_SetTermCriteria(SVMSGD self, TermCriteria val);
CvStatus SVMSGD_Train(SVMSGD self, PtrTrainData trainData, int flags, bool *rval);
CvStatus SVMSGD_Train_1(SVMSGD self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus SVMSGD_Clear(SVMSGD self);
CvStatus SVMSGD_Save(SVMSGD self, char *filename);
CvStatus SVMSGD_Load(SVMSGD self, char *filepath);
CvStatus SVMSGD_LoadFromString(SVMSGD self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
