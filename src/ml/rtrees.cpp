/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "rtrees.h"

// RTrees
CvStatus RTrees_Create(PtrRTrees *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::RTrees>()};
  END_WRAP
}

void RTrees_Close(PtrRTrees *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus RTrees_Get(PtrRTrees self, RTrees *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus RTrees_GetCalculateVarImportance(RTrees self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getCalculateVarImportance();
  END_WRAP
}

CvStatus RTrees_SetCalculateVarImportance(RTrees self, bool val)
{
  BEGIN_WRAP
  self.ptr->setCalculateVarImportance(val);
  END_WRAP
}

CvStatus RTrees_GetActiveVarCount(RTrees self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getActiveVarCount();
  END_WRAP
}

CvStatus RTrees_SetActiveVarCount(RTrees self, int val)
{
  BEGIN_WRAP
  self.ptr->setActiveVarCount(val);
  END_WRAP
}

CvStatus RTrees_GetTermCriteria(RTrees self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = self.ptr->getTermCriteria();
  *rval = {new cv::TermCriteria(tc.type, tc.maxCount, tc.epsilon)};
  END_WRAP
}

CvStatus RTrees_SetTermCriteria(RTrees self, TermCriteria val)
{
  BEGIN_WRAP
  self.ptr->setTermCriteria(*val.ptr);
  END_WRAP
}

CvStatus RTrees_GetVarImportance(RTrees self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getVarImportance())};
  END_WRAP
}

CvStatus RTrees_GetVotes(RTrees self, Mat samples, Mat results, int flags)
{
  BEGIN_WRAP
  self.ptr->getVotes(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus RTrees_GetOOBError(RTrees self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getOOBError();
  END_WRAP
}

CvStatus RTrees_Train(RTrees self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus RTrees_Train_1(RTrees self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus RTrees_Clear(RTrees self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus RTrees_Save(RTrees self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus RTrees_Load(RTrees self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::RTrees::load(filepath);
  END_WRAP
}

CvStatus RTrees_LoadFromString(RTrees self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::RTrees>(strModel, objname);
  END_WRAP
}
