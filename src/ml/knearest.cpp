/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "knearest.h"

// KNearest
CvStatus KNearest_Create(PtrKNearest *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::KNearest>()};
  END_WRAP
}

void KNearest_Close(PtrKNearest *self)
{
  CVD_FREE(self)
}

CvStatus KNearest_Get(PtrKNearest self, KNearest *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus KNearest_GetDefaultK(KNearest self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getDefaultK();
  END_WRAP
}

CvStatus KNearest_SetDefaultK(KNearest self, int val)
{
  BEGIN_WRAP
  self.ptr->setDefaultK(val);
  END_WRAP
}

CvStatus KNearest_GetIsClassifier(KNearest self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getIsClassifier();
  END_WRAP
}

CvStatus KNearest_SetIsClassifier(KNearest self, bool val)
{
  BEGIN_WRAP
  self.ptr->setIsClassifier(val);
  END_WRAP
}

CvStatus KNearest_GetEmax(KNearest self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getEmax();
  END_WRAP
}

CvStatus KNearest_SetEmax(KNearest self, int val)
{
  BEGIN_WRAP
  self.ptr->setEmax(val);
  END_WRAP
}

CvStatus KNearest_GetAlgorithmType(KNearest self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getAlgorithmType();
  END_WRAP
}

CvStatus KNearest_SetAlgorithmType(KNearest self, int val)
{
  BEGIN_WRAP
  self.ptr->setAlgorithmType(val);
  END_WRAP
}

CvStatus KNearest_FindNearest(KNearest self, Mat samples, int k, Mat results, Mat neighborResponses, Mat dist, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->findNearest(samples.ptr, k, results.ptr, neighborResponses.ptr, dist.ptr);
  END_WRAP
}

CvStatus KNearest_Train(KNearest self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(trainData.ptr, flags);
  END_WRAP
}

CvStatus KNearest_Train_1(KNearest self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(samples.ptr, layout, responses.ptr);
  END_WRAP
}

CvStatus KNearest_Clear(KNearest self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus KNearest_Save(KNearest self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus KNearest_Load(KNearest self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::KNearest::load(filepath);
  END_WRAP
}

CvStatus KNearest_LoadFromString(KNearest self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::KNearest>(strModel, objname);
  END_WRAP
}
