/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "ann_mlp.h"

// ANN_MLP
CvStatus ANN_MLP_Create(PtrANN_MLP *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::ANN_MLP::create();
  *rval = {new cv::Ptr<cv::ml::ANN_MLP>(p)};
  END_WRAP
}

void ANN_MLP_Close(PtrANN_MLP *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus ANN_MLP_Get(PtrANN_MLP self, ANN_MLP *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus ANN_MLP_SetTrainMethod(ANN_MLP self, int method, double param1, double param2)
{
  BEGIN_WRAP
  self.ptr->setTrainMethod(method, param1, param2);
  END_WRAP
}

CvStatus ANN_MLP_GetTrainMethod(ANN_MLP self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getTrainMethod();
  END_WRAP
}

CvStatus ANN_MLP_SetActivationFunction(ANN_MLP self, int type, double param1, double param2)
{
  BEGIN_WRAP
  self.ptr->setActivationFunction(type, param1, param2);
  END_WRAP
}

CvStatus ANN_MLP_SetLayerSizes(ANN_MLP self, Mat _layer_sizes)
{
  BEGIN_WRAP
  self.ptr->setLayerSizes(*_layer_sizes.ptr);
  END_WRAP
}

CvStatus ANN_MLP_GetLayerSizes(ANN_MLP self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getLayerSizes())};
  END_WRAP
}

CvStatus ANN_MLP_SetTermCriteria(ANN_MLP self, TermCriteria val)
{
  BEGIN_WRAP
  self.ptr->setTermCriteria(*val.ptr);
  END_WRAP
}

CvStatus ANN_MLP_GetTermCriteria(ANN_MLP self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = self.ptr->getTermCriteria();
  *rval = {new cv::TermCriteria(tc.type, tc.maxCount, tc.epsilon)};
  END_WRAP
}

CvStatus ANN_MLP_SetBackpropWeightScale(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setBackpropWeightScale(val);
  END_WRAP
}

CvStatus ANN_MLP_GetBackpropWeightScale(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getBackpropWeightScale();
  END_WRAP
}

CvStatus ANN_MLP_SetBackpropMomentumScale(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setBackpropMomentumScale(val);
  END_WRAP
}

CvStatus ANN_MLP_GetBackpropMomentumScale(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getBackpropMomentumScale();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDW0(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setRpropDW0(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDW0(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRpropDW0();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWPlus(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setRpropDWPlus(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWPlus(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRpropDWPlus();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWMinus(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setRpropDWMinus(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWMinus(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRpropDWMinus();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWMin(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setRpropDWMin(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWMin(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRpropDWMin();
  END_WRAP
}

CvStatus ANN_MLP_SetRpropDWMax(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setRpropDWMax(val);
  END_WRAP
}

CvStatus ANN_MLP_GetRpropDWMax(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRpropDWMax();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealInitialT(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setAnnealInitialT(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealInitialT(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getAnnealInitialT();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealFinalT(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setAnnealFinalT(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealFinalT(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getAnnealFinalT();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealCoolingRatio(ANN_MLP self, double val)
{
  BEGIN_WRAP
  self.ptr->setAnnealCoolingRatio(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealCoolingRatio(ANN_MLP self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getAnnealCoolingRatio();
  END_WRAP
}

CvStatus ANN_MLP_SetAnnealItePerStep(ANN_MLP self, int val)
{
  BEGIN_WRAP
  self.ptr->setAnnealItePerStep(val);
  END_WRAP
}

CvStatus ANN_MLP_GetAnnealItePerStep(ANN_MLP self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getAnnealItePerStep();
  END_WRAP
}

CvStatus ANN_MLP_Predict(ANN_MLP self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus ANN_MLP_Train(ANN_MLP self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus ANN_MLP_Train_1(ANN_MLP self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus ANN_MLP_Clear(ANN_MLP self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus ANN_MLP_Save(ANN_MLP self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus ANN_MLP_Load(ANN_MLP self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::ANN_MLP::load(filepath);
  END_WRAP
}

CvStatus ANN_MLP_LoadFromString(ANN_MLP self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::ANN_MLP>(strModel, objname);
  END_WRAP
}
