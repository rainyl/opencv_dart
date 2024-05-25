/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_ANN_MLP_H
#define CVD_ML_ANN_MLP_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::ANN_MLP>, PtrANN_MLP)
CVD_TYPEDEF(cv::ml::ANN_MLP, ANN_MLP)
#else
CVD_TYPEDEF(void *, PtrANN_MLP)
CVD_TYPEDEF(void, ANN_MLP)
#endif

CVD_TYPEDEF_PTR(PtrANN_MLP)
CVD_TYPEDEF_PTR(ANN_MLP)

// ANN_MLP
CvStatus ANN_MLP_Create(PtrANN_MLP *rval);
void     ANN_MLP_Close(PtrANN_MLP *self);
CvStatus ANN_MLP_Get(PtrANN_MLP self, ANN_MLP *rval);

CvStatus ANN_MLP_SetTrainMethod(ANN_MLP self, int method, double param1, double param2);
CvStatus ANN_MLP_GetTrainMethod(ANN_MLP self, int *rval);
CvStatus ANN_MLP_SetActivationFunction(ANN_MLP self, int type, double param1, double param2);
CvStatus ANN_MLP_SetLayerSizes(ANN_MLP self, Mat _layer_sizes);
CvStatus ANN_MLP_GetLayerSizes(ANN_MLP self, Mat *rval);
CvStatus ANN_MLP_SetTermCriteria(ANN_MLP self, TermCriteria val);
CvStatus ANN_MLP_GetTermCriteria(ANN_MLP self, TermCriteria *rval);
CvStatus ANN_MLP_SetBackpropWeightScale(ANN_MLP self, double val);
CvStatus ANN_MLP_GetBackpropWeightScale(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetBackpropMomentumScale(ANN_MLP self, double val);
CvStatus ANN_MLP_GetBackpropMomentumScale(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDW0(ANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDW0(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWPlus(ANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWPlus(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWMinus(ANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWMinus(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWMin(ANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWMin(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWMax(ANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWMax(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealInitialT(ANN_MLP self, double val);
CvStatus ANN_MLP_GetAnnealInitialT(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealFinalT(ANN_MLP self, double val);
CvStatus ANN_MLP_GetAnnealFinalT(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealCoolingRatio(ANN_MLP self, double val);
CvStatus ANN_MLP_GetAnnealCoolingRatio(ANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealItePerStep(ANN_MLP self, int val);
CvStatus ANN_MLP_GetAnnealItePerStep(ANN_MLP self, int *rval);
CvStatus ANN_MLP_Predict(ANN_MLP self, Mat samples, Mat results, int flags, float *rval);
CvStatus ANN_MLP_Train(ANN_MLP self, PtrTrainData trainData, int flags, bool *rval);
CvStatus ANN_MLP_Train_1(ANN_MLP self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus ANN_MLP_Clear(ANN_MLP self);
CvStatus ANN_MLP_Save(ANN_MLP self, char *filename);
CvStatus ANN_MLP_Load(ANN_MLP self, char *filepath);
CvStatus ANN_MLP_LoadFromString(ANN_MLP self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
