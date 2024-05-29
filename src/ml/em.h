/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_EM_H
#define CVD_ML_EM_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::EM>, PtrEM)
CVD_TYPEDEF(cv::ml::EM, EM)
#else
CVD_TYPEDEF(void *, PtrEM)
CVD_TYPEDEF(void, EM)
#endif

CVD_TYPEDEF_PTR(PtrEM)
CVD_TYPEDEF_PTR(EM)

// EM
CvStatus EM_Create(PtrEM *rval);
void     EM_Close(PtrEM *self);
CvStatus EM_Get(PtrEM self, EM *rval);

CvStatus EM_GetClustersNumber(EM self, int *rval);
CvStatus EM_SetClustersNumber(EM self, int val);
CvStatus EM_GetCovarianceMatrixType(EM self, int *rval);
CvStatus EM_SetCovarianceMatrixType(EM self, int val);
CvStatus EM_GetTermCriteria(EM self, TermCriteria *rval);
CvStatus EM_SetTermCriteria(EM self, TermCriteria val);
CvStatus EM_Predict(EM self, Mat samples, Mat results, int flags, float *rval);
CvStatus EM_Predict2(EM self, Mat sample, Mat probs, Vec2d *rval);
CvStatus EM_TrainEM(EM self, Mat samples, Mat logLikelihoods, Mat labels, Mat probs, bool *rval);
CvStatus EM_TrainE(EM self, Mat samples, Mat means0, Mat covs0, Mat weights0, Mat logLikelihoods, Mat labels, Mat probs, bool *rval);
CvStatus EM_TrainM(EM self, Mat samples, Mat probs0, Mat logLikelihoods, Mat labels, Mat probs, bool *rval);
CvStatus EM_Clear(EM self);
CvStatus EM_Save(EM self, char *filename);
CvStatus EM_Load(EM self, char *filepath);
CvStatus EM_LoadFromString(EM self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
