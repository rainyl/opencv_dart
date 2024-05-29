/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_DTREES_H
#define CVD_ML_DTREES_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::DTrees>, PtrDTrees)
CVD_TYPEDEF(cv::ml::DTrees, DTrees)
#else
CVD_TYPEDEF(void *, PtrDTrees)
CVD_TYPEDEF(void, DTrees)
#endif

CVD_TYPEDEF_PTR(PtrDTrees)
CVD_TYPEDEF_PTR(DTrees)

// DTrees
CvStatus DTrees_Create(PtrDTrees *rval);
void     DTrees_Close(PtrDTrees *self);
CvStatus DTrees_Get(PtrDTrees self, DTrees *rval);

CvStatus DTrees_GetMaxCategories(DTrees self, int *rval);
CvStatus DTrees_SetMaxCategories(DTrees self, int val);
CvStatus DTrees_GetMaxDepth(DTrees self, int *rval);
CvStatus DTrees_SetMaxDepth(DTrees self, int val);
CvStatus DTrees_GetMinSampleCount(DTrees self, int *rval);
CvStatus DTrees_SetMinSampleCount(DTrees self, int val);
CvStatus DTrees_GetCVFolds(DTrees self, int *rval);
CvStatus DTrees_SetCVFolds(DTrees self, int val);
CvStatus DTrees_GetUseSurrogates(DTrees self, bool *rval);
CvStatus DTrees_SetUseSurrogates(DTrees self, bool val);
CvStatus DTrees_GetUse1SERule(DTrees self, bool *rval);
CvStatus DTrees_SetUse1SERule(DTrees self, bool val);
CvStatus DTrees_GetTruncatePrunedTree(DTrees self, bool *rval);
CvStatus DTrees_SetTruncatePrunedTree(DTrees self, bool val);
CvStatus DTrees_GetRegressionAccuracy(DTrees self, float *rval);
CvStatus DTrees_SetRegressionAccuracy(DTrees self, float val);
CvStatus DTrees_GetPriors(DTrees self, Mat *rval);
CvStatus DTrees_SetPriors(DTrees self, Mat val);
CvStatus DTrees_Predict(DTrees self, Mat samples, Mat results, int flags, float *rval);
CvStatus DTrees_Train(DTrees self, PtrTrainData trainData, int flags, bool *rval);
CvStatus DTrees_Train_1(DTrees self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus DTrees_Clear(DTrees self);
CvStatus DTrees_Save(DTrees self, char *filename);
CvStatus DTrees_Load(DTrees self, char *filepath);
CvStatus DTrees_LoadFromString(DTrees self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
