/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_RTREES_H
#define CVD_ML_RTREES_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::RTrees>, PtrRTrees)
CVD_TYPEDEF(cv::ml::RTrees, RTrees)
#else
CVD_TYPEDEF(void *, PtrRTrees)
CVD_TYPEDEF(void, RTrees)
#endif

CVD_TYPEDEF_PTR(PtrRTrees)
CVD_TYPEDEF_PTR(RTrees)

// RTrees
CvStatus RTrees_Create(PtrRTrees *rval);
void     RTrees_Close(PtrRTrees *self);
CvStatus RTrees_Get(PtrRTrees self, RTrees *rval);

CvStatus RTrees_GetCalculateVarImportance(RTrees self, bool *rval);
CvStatus RTrees_SetCalculateVarImportance(RTrees self, bool val);
CvStatus RTrees_GetActiveVarCount(RTrees self, int *rval);
CvStatus RTrees_SetActiveVarCount(RTrees self, int val);
CvStatus RTrees_GetTermCriteria(RTrees self, TermCriteria *rval);
CvStatus RTrees_SetTermCriteria(RTrees self, TermCriteria val);
CvStatus RTrees_GetVarImportance(RTrees self, Mat *rval);
CvStatus RTrees_GetVotes(RTrees self, Mat samples, Mat results, int flags);
CvStatus RTrees_GetOOBError(RTrees self, double *rval);
CvStatus RTrees_Train(RTrees self, PtrTrainData trainData, int flags, bool *rval);
CvStatus RTrees_Train_1(RTrees self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus RTrees_Clear(RTrees self);
CvStatus RTrees_Save(RTrees self, char *filename);
CvStatus RTrees_Load(RTrees self, char *filepath);
CvStatus RTrees_LoadFromString(RTrees self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
