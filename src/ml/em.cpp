/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "em.h"

// EM
CvStatus EM_Create(PtrEM *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::EM>()};
  END_WRAP
}

void EM_Close(PtrEM *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus EM_Get(PtrEM self, EM *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus EM_GetClustersNumber(EM self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getClustersNumber();
  END_WRAP
}

CvStatus EM_SetClustersNumber(EM self, int val)
{
  BEGIN_WRAP
  self.ptr->setClustersNumber(val);
  END_WRAP
}

CvStatus EM_GetCovarianceMatrixType(EM self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getCovarianceMatrixType();
  END_WRAP
}

CvStatus EM_SetCovarianceMatrixType(EM self, int val)
{
  BEGIN_WRAP
  self.ptr->setCovarianceMatrixType(val);
  END_WRAP
}

CvStatus EM_GetTermCriteria(EM self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = self.ptr->getTermCriteria();
  *rval = {tc.type, tc.maxCount, tc.epsilon};
  END_WRAP
}

CvStatus EM_SetTermCriteria(EM self, TermCriteria val)
{
  BEGIN_WRAP
  auto tc = cv::TermCriteria(val.type, val.maxCount, val.epsilon);
  self.ptr->setTermCriteria(tc);
  END_WRAP
}

CvStatus EM_Predict(EM self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus EM_Predict2(EM self, Mat sample, Mat probs, Vec2d *rval)
{
  BEGIN_WRAP
  auto r = self.ptr->predict2(*sample.ptr, *probs.ptr);
  *rval = {r.val[0], r.val[1]};
  END_WRAP
}

CvStatus EM_TrainEM(EM self, Mat samples, Mat logLikelihoods, Mat labels, Mat probs, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->trainEM(*samples.ptr, *logLikelihoods.ptr, *labels.ptr, *probs.ptr);
  END_WRAP
}

CvStatus EM_TrainE(EM self, Mat samples, Mat means0, Mat covs0, Mat weights0, Mat logLikelihoods, Mat labels,
                   Mat probs, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->trainE(*samples.ptr, *means0.ptr, *covs0.ptr, *weights0.ptr, *logLikelihoods.ptr,
                           *labels.ptr, *probs.ptr);
  END_WRAP
}

CvStatus EM_TrainM(EM self, Mat samples, Mat probs0, Mat logLikelihoods, Mat labels, Mat probs, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->trainM(*samples.ptr, *probs0.ptr, *logLikelihoods.ptr, *labels.ptr, *probs.ptr);
  END_WRAP
}

CvStatus EM_Clear(EM self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus EM_Save(EM self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus EM_Load(EM self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::EM::load(filepath);
  END_WRAP
}

CvStatus EM_LoadFromString(EM self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::EM>(strModel, objname);
  END_WRAP
}
