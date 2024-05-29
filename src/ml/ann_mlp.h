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
// CVD_TYPEDEF(cv::ml::ANN_MLP, ANN_MLP)
#else
CVD_TYPEDEF(void *, PtrANN_MLP)
// CVD_TYPEDEF(void, ANN_MLP)
#endif

CVD_TYPEDEF_PTR(PtrANN_MLP)
// CVD_TYPEDEF_PTR(ANN_MLP)

// ANN_MLP
CvStatus ANN_MLP_Create(PtrANN_MLP *rval);
void     ANN_MLP_Close(PtrANN_MLP *self);
// CvStatus ANN_MLP_Get(PtrANN_MLP self, ANN_MLP *rval);

CvStatus ANN_MLP_SetTrainMethod(PtrANN_MLP self, int method, double param1, double param2);
CvStatus ANN_MLP_GetTrainMethod(PtrANN_MLP self, int *rval);
CvStatus ANN_MLP_SetActivationFunction(PtrANN_MLP self, int type, double param1, double param2);
CvStatus ANN_MLP_SetLayerSizes(PtrANN_MLP self, Mat _layer_sizes);
CvStatus ANN_MLP_GetLayerSizes(PtrANN_MLP self, Mat *rval);
CvStatus ANN_MLP_SetTermCriteria(PtrANN_MLP self, TermCriteria val);
CvStatus ANN_MLP_GetTermCriteria(PtrANN_MLP self, TermCriteria *rval);
CvStatus ANN_MLP_SetBackpropWeightScale(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetBackpropWeightScale(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetBackpropMomentumScale(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetBackpropMomentumScale(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDW0(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDW0(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWPlus(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWPlus(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWMinus(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWMinus(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWMin(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWMin(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetRpropDWMax(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetRpropDWMax(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealInitialT(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetAnnealInitialT(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealFinalT(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetAnnealFinalT(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealCoolingRatio(PtrANN_MLP self, double val);
CvStatus ANN_MLP_GetAnnealCoolingRatio(PtrANN_MLP self, double *rval);
CvStatus ANN_MLP_SetAnnealItePerStep(PtrANN_MLP self, int val);
CvStatus ANN_MLP_GetAnnealItePerStep(PtrANN_MLP self, int *rval);
CvStatus ANN_MLP_Predict(PtrANN_MLP self, Mat samples, Mat results, int flags, float *rval);
CvStatus ANN_MLP_Train(PtrANN_MLP self, PtrTrainData trainData, int flags, bool *rval);
CvStatus ANN_MLP_Train_1(PtrANN_MLP self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus ANN_MLP_Clear(PtrANN_MLP self);
CvStatus ANN_MLP_Save(PtrANN_MLP self, char *filename);
CvStatus ANN_MLP_Load(char *filepath, PtrANN_MLP *rval);
CvStatus ANN_MLP_LoadFromString( const char *strModel, const char *objname, PtrANN_MLP *rval);

#ifdef __cplusplus
}
#endif

#endif
