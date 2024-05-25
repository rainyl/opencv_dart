/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_KNEAREST_H
#define CVD_ML_KNEAREST_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::KNearest>, PtrKNearest)
CVD_TYPEDEF(cv::ml::KNearest, KNearest)
#else
CVD_TYPEDEF(void *, PtrKNearest)
CVD_TYPEDEF(void, KNearest)
#endif

CVD_TYPEDEF_PTR(PtrKNearest)
CVD_TYPEDEF_PTR(KNearest)

// KNearest
CvStatus KNearest_Create(PtrKNearest *rval);
void     KNearest_Close(PtrKNearest *self);
CvStatus KNearest_Get(PtrKNearest self, KNearest *rval);

CvStatus KNearest_GetDefaultK(KNearest self, int *rval);
CvStatus KNearest_SetDefaultK(KNearest self, int val);
CvStatus KNearest_GetIsClassifier(KNearest self, bool *rval);
CvStatus KNearest_SetIsClassifier(KNearest self, bool val);
CvStatus KNearest_GetEmax(KNearest self, int *rval);
CvStatus KNearest_SetEmax(KNearest self, int val);
CvStatus KNearest_GetAlgorithmType(KNearest self, int *rval);
CvStatus KNearest_SetAlgorithmType(KNearest self, int val);
CvStatus KNearest_FindNearest(KNearest self, Mat samples, int k, Mat results, Mat neighborResponses, Mat dist, float *rval);
CvStatus KNearest_Train(KNearest self, PtrTrainData trainData, int flags, bool *rval);
CvStatus KNearest_Train_1(KNearest self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus KNearest_Clear(KNearest self);
CvStatus KNearest_Save(KNearest self, char *filename);
CvStatus KNearest_Load(KNearest self, char *filepath);
CvStatus KNearest_LoadFromString(KNearest self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
