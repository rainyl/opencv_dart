/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "svmsgd.h"

// SVMSGD
CvStatus SVMSGD_Create(PtrSVMSGD *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::SVMSGD>()};
  END_WRAP
}

void SVMSGD_Close(PtrSVMSGD *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus SVMSGD_Get(PtrSVMSGD self, SVMSGD *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus SVMSGD_SetOptimalParameters(SVMSGD self, int svmsgdType, int marginType)
{
  BEGIN_WRAP
  self.ptr->setOptimalParameters(svmsgdType, marginType);
  END_WRAP
}

CvStatus SVMSGD_GetWeights(SVMSGD self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getWeights())};
  END_WRAP
}

CvStatus SVMSGD_GetShift(SVMSGD self, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getShift();
  END_WRAP
}

CvStatus SVMSGD_GetSvmsgdType(SVMSGD self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getSvmsgdType();
  END_WRAP
}

CvStatus SVMSGD_SetSvmsgdType(SVMSGD self, int svmsgdType)
{
  BEGIN_WRAP
  self.ptr->setSvmsgdType(svmsgdType);
  END_WRAP
}

CvStatus SVMSGD_GetMarginType(SVMSGD self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getMarginType();
  END_WRAP
}

CvStatus SVMSGD_SetMarginType(SVMSGD self, int marginType)
{
  BEGIN_WRAP
  self.ptr->setMarginType(marginType);
  END_WRAP
}

CvStatus SVMSGD_GetMarginRegularization(SVMSGD self, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getMarginRegularization();
  END_WRAP
}

CvStatus SVMSGD_SetMarginRegularization(SVMSGD self, float marginRegularization)
{
  BEGIN_WRAP
  self.ptr->setMarginRegularization(marginRegularization);
  END_WRAP
}

CvStatus SVMSGD_GetInitialStepSize(SVMSGD self, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getInitialStepSize();
  END_WRAP
}

CvStatus SVMSGD_SetInitialStepSize(SVMSGD self, float InitialStepSize)
{
  BEGIN_WRAP
  self.ptr->setInitialStepSize(InitialStepSize);
  END_WRAP
}

CvStatus SVMSGD_GetStepDecreasingPower(SVMSGD self, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getStepDecreasingPower();
  END_WRAP
}

CvStatus SVMSGD_SetStepDecreasingPower(SVMSGD self, float stepDecreasingPower)
{
  BEGIN_WRAP
  self.ptr->setStepDecreasingPower(stepDecreasingPower);
  END_WRAP
}

CvStatus SVMSGD_GetTermCriteria(SVMSGD self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = self.ptr->getTermCriteria();
  *rval = {new cv::TermCriteria(tc.type, tc.maxCount, tc.epsilon)};
  END_WRAP
}

CvStatus SVMSGD_SetTermCriteria(SVMSGD self, TermCriteria val)
{
  BEGIN_WRAP
  self.ptr->setTermCriteria(*val.ptr);
  END_WRAP
}

CvStatus SVMSGD_Train(SVMSGD self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus SVMSGD_Train_1(SVMSGD self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus SVMSGD_Clear(SVMSGD self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus SVMSGD_Save(SVMSGD self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus SVMSGD_Load(SVMSGD self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::SVMSGD::load(filepath);
  END_WRAP
}

CvStatus SVMSGD_LoadFromString(SVMSGD self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::SVMSGD>(strModel, objname);
  END_WRAP
}
