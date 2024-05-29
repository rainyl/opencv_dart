/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "ann_mlp.h"
#include "opencv2/ml.hpp"

// ANN_MLP
CvStatus ANN_MLP_Create(PtrANN_MLP *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::ANN_MLP::create();
  rval->ptr = new cv::Ptr<cv::ml::ANN_MLP>(p);
  END_WRAP
}

void ANN_MLP_Close(PtrANN_MLP *self)
{
  self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus ANN_MLP_SetTrainMethod(PtrANN_MLP self, int method, double param1, double param2)
{
  BEGIN_WRAP
  (*self.ptr)->setTrainMethod(method, param1, param2);
  END_WRAP
}

CvStatus ANN_MLP_GetTrainMethod(PtrANN_MLP self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getTrainMethod();
  END_WRAP
}

CvStatus ANN_MLP_SetActivationFunction(PtrANN_MLP self, int type, double param1, double param2)
{
  BEGIN_WRAP
  (*self.ptr)->setActivationFunction(type, param1, param2);
  END_WRAP
}

CvStatus ANN_MLP_SetLayerSizes(PtrANN_MLP self, Mat _layer_sizes)
{
  BEGIN_WRAP
  (*self.ptr)->setLayerSizes(*_layer_sizes.ptr);
  END_WRAP
}

CvStatus ANN_MLP_GetLayerSizes(PtrANN_MLP self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getLayerSizes())};
  END_WRAP
}

CvStatus ANN_MLP_SetTermCriteria(PtrANN_MLP self, TermCriteria val)
{
  BEGIN_WRAP
  auto tc = cv::TermCriteria(val.type, val.maxCount, val.epsilon);
  (*self.ptr)->setTermCriteria(tc);
  END_WRAP
}

CvStatus ANN_MLP_GetTermCriteria(PtrANN_MLP self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = (*self.ptr)->getTermCriteria();
  *rval = {tc.type, tc.maxCount, tc.epsilon};
  END_WRAP
}

CvStatus ANN_MLP_SetBackpropWeightScale(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setBackpropWeightScale(val);
  END_WRAP
}

CvStatus ANN_MLP_GetBackpropWeightScale(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getBackpropWeightScale();
  END_WRAP
}

CvStatus ANN_MLP_SetBackpropMomentumScale(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setBackpropMomentumScale(val);
  END_WRAP
}

CvStatus ANN_MLP_GetBackpropMomentumScale(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getBackpropMomentumScale();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDW0(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setRpropDW0(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDW0(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getRpropDW0();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWPlus(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setRpropDWPlus(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWPlus(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getRpropDWPlus();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWMinus(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setRpropDWMinus(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWMinus(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getRpropDWMinus();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWMin(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setRpropDWMin(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWMin(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getRpropDWMin();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWMax(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setRpropDWMax(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWMax(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getRpropDWMax();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealInitialT(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setAnnealInitialT(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealInitialT(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getAnnealInitialT();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealFinalT(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setAnnealFinalT(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealFinalT(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getAnnealFinalT();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealCoolingRatio(PtrANN_MLP self, double val)
{
  BEGIN_WRAP
  (*self.ptr)->setAnnealCoolingRatio(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealCoolingRatio(PtrANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getAnnealCoolingRatio();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealItePerStep(PtrANN_MLP self, int val)
{
  BEGIN_WRAP
  (*self.ptr)->setAnnealItePerStep(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealItePerStep(PtrANN_MLP self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getAnnealItePerStep();
  END_WRAP
}

CvStatus ANN_MLP_Predict(PtrANN_MLP self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus ANN_MLP_Train(PtrANN_MLP self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus ANN_MLP_Train_1(PtrANN_MLP self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus ANN_MLP_Clear(PtrANN_MLP self)
{
  BEGIN_WRAP
  (*self.ptr)->clear();
  END_WRAP
}

CvStatus ANN_MLP_Save(PtrANN_MLP self, char *filename)
{
  BEGIN_WRAP
  (*self.ptr)->save(filename);
  END_WRAP
}

CvStatus ANN_MLP_Load(char *filepath, PtrANN_MLP *rval)
{
  BEGIN_WRAP
  cv::Ptr<cv::ml::ANN_MLP> p = cv::ml::ANN_MLP::load(filepath);
  (*rval->ptr) = p;
  END_WRAP
}

CvStatus ANN_MLP_LoadFromString( const char *strModel, const char *objname, PtrANN_MLP *rval)
{
  BEGIN_WRAP
  (*rval->ptr) = cv::Algorithm::loadFromString<cv::ml::ANN_MLP>(strModel, objname);
  END_WRAP
}
