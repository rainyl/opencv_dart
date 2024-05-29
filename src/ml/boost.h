/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_BOOST_H
#define CVD_ML_BOOST_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::Boost>, PtrBoost)
CVD_TYPEDEF(cv::ml::Boost, Boost)
#else
CVD_TYPEDEF(void *, PtrBoost)
CVD_TYPEDEF(void, Boost)
#endif

CVD_TYPEDEF_PTR(PtrBoost)
CVD_TYPEDEF_PTR(Boost)

// Boost
CvStatus Boost_Create(PtrBoost *rval);
void     Boost_Close(PtrBoost *self);
CvStatus Boost_Get(PtrBoost self, Boost *rval);

CvStatus Boost_GetBoostType(Boost self, int *rval);
CvStatus Boost_SetBoostType(Boost self, int val);
CvStatus Boost_GetWeakCount(Boost self, int *rval);
CvStatus Boost_SetWeakCount(Boost self, int val);
CvStatus Boost_GetWeightTrimRate(Boost self, double *rval);
CvStatus Boost_SetWeightTrimRate(Boost self, double val);
CvStatus Boost_Predict(Boost self, Mat samples, Mat results, int flags, float *rval);
CvStatus Boost_Train(Boost self, PtrTrainData trainData, int flags, bool *rval);
CvStatus Boost_Train_1(Boost self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus Boost_Clear(Boost self);
CvStatus Boost_Save(Boost self, char *filename);
CvStatus Boost_Load(Boost self, char *filepath);
CvStatus Boost_LoadFromString(Boost self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
