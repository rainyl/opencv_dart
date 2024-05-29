/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "boost.h"

// Boost
CvStatus Boost_Create(PtrBoost *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::Boost>()};
  END_WRAP
}

void Boost_Close(PtrBoost *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus Boost_Get(PtrBoost self, Boost *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus Boost_GetBoostType(Boost self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getBoostType();
  END_WRAP
}

CvStatus Boost_SetBoostType(Boost self, int val)
{
  BEGIN_WRAP
  self.ptr->setBoostType(val);
  END_WRAP
}

CvStatus Boost_GetWeakCount(Boost self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getWeakCount();
  END_WRAP
}

CvStatus Boost_SetWeakCount(Boost self, int val)
{
  BEGIN_WRAP
  self.ptr->setWeakCount(val);
  END_WRAP
}

CvStatus Boost_GetWeightTrimRate(Boost self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getWeightTrimRate();
  END_WRAP
}

CvStatus Boost_SetWeightTrimRate(Boost self, double val)
{
  BEGIN_WRAP
  self.ptr->setWeightTrimRate(val);
  END_WRAP
}

CvStatus Boost_Predict(Boost self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus Boost_Train(Boost self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus Boost_Train_1(Boost self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus Boost_Clear(Boost self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus Boost_Save(Boost self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus Boost_Load(Boost self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::Boost::load(filepath);
  END_WRAP
}

CvStatus Boost_LoadFromString(Boost self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::Boost>(strModel, objname);
  END_WRAP
}
