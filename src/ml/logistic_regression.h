/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_LOGISTIC_REGRESSION_H
#define CVD_ML_LOGISTIC_REGRESSION_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::LogisticRegression>, PtrLogisticRegression)
CVD_TYPEDEF(cv::ml::LogisticRegression, LogisticRegression)
#else
CVD_TYPEDEF(void *, PtrLogisticRegression)
CVD_TYPEDEF(void, LogisticRegression)
#endif

CVD_TYPEDEF_PTR(PtrLogisticRegression)
CVD_TYPEDEF_PTR(LogisticRegression)

// LogisticRegression
CvStatus LogisticRegression_Create(PtrLogisticRegression *rval);
void     LogisticRegression_Close(PtrLogisticRegression *self);
CvStatus LogisticRegression_Get(PtrLogisticRegression self, LogisticRegression *rval);

CvStatus LogisticRegression_GetLearningRate(LogisticRegression self, double *rval);
CvStatus LogisticRegression_SetLearningRate(LogisticRegression self, double val);
CvStatus LogisticRegression_GetIterations(LogisticRegression self, int *rval);
CvStatus LogisticRegression_SetIterations(LogisticRegression self, int val);
CvStatus LogisticRegression_GetRegularization(LogisticRegression self, int *rval);
CvStatus LogisticRegression_SetRegularization(LogisticRegression self, int val);
CvStatus LogisticRegression_GetTrainMethod(LogisticRegression self, int *rval);
CvStatus LogisticRegression_SetTrainMethod(LogisticRegression self, int val);
CvStatus LogisticRegression_GetMiniBatchSize(LogisticRegression self, int *rval);
CvStatus LogisticRegression_SetMiniBatchSize(LogisticRegression self, int val);
CvStatus LogisticRegression_GetTermCriteria(LogisticRegression self, TermCriteria *rval);
CvStatus LogisticRegression_SetTermCriteria(LogisticRegression self, TermCriteria val);
CvStatus LogisticRegression_Predict(LogisticRegression self, Mat samples, Mat results, int flags, float *rval);
CvStatus LogisticRegression_Train(LogisticRegression self, PtrTrainData trainData, int flags, bool *rval);
CvStatus LogisticRegression_Train_1(LogisticRegression self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus LogisticRegression_Clear(LogisticRegression self);
CvStatus LogisticRegression_GetLearntThetas(LogisticRegression self, Mat *rval);
CvStatus LogisticRegression_Save(LogisticRegression self, char *filename);
CvStatus LogisticRegression_Load(LogisticRegression self, char *filepath);
CvStatus LogisticRegression_LoadFromString(LogisticRegression self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
