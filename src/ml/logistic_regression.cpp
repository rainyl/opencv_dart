/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "logistic_regression.h"

// LogisticRegression
CvStatus LogisticRegression_Create(PtrLogisticRegression *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::LogisticRegression>()};
  END_WRAP
}

void LogisticRegression_Close(PtrLogisticRegression *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus LogisticRegression_Get(PtrLogisticRegression self, LogisticRegression *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus LogisticRegression_GetLearningRate(LogisticRegression self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getLearningRate();
  END_WRAP
}

CvStatus LogisticRegression_SetLearningRate(LogisticRegression self, double val)
{
  BEGIN_WRAP
  self.ptr->setLearningRate(val);
  END_WRAP
}

CvStatus LogisticRegression_GetIterations(LogisticRegression self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getIterations();
  END_WRAP
}

CvStatus LogisticRegression_SetIterations(LogisticRegression self, int val)
{
  BEGIN_WRAP
  self.ptr->setIterations(val);
  END_WRAP
}

CvStatus LogisticRegression_GetRegularization(LogisticRegression self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRegularization();
  END_WRAP
}

CvStatus LogisticRegression_SetRegularization(LogisticRegression self, int val)
{
  BEGIN_WRAP
  self.ptr->setRegularization(val);
  END_WRAP
}

CvStatus LogisticRegression_GetTrainMethod(LogisticRegression self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getTrainMethod();
  END_WRAP
}

CvStatus LogisticRegression_SetTrainMethod(LogisticRegression self, int val)
{
  BEGIN_WRAP
  self.ptr->setTrainMethod(val);
  END_WRAP
}

CvStatus LogisticRegression_GetMiniBatchSize(LogisticRegression self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getMiniBatchSize();
  END_WRAP
}

CvStatus LogisticRegression_SetMiniBatchSize(LogisticRegression self, int val)
{
  BEGIN_WRAP
  self.ptr->setMiniBatchSize(val);
  END_WRAP
}

CvStatus LogisticRegression_GetTermCriteria(LogisticRegression self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = self.ptr->getTermCriteria();
  *rval = {new cv::TermCriteria(tc.type, tc.maxCount, tc.epsilon)};
  END_WRAP
}

CvStatus LogisticRegression_SetTermCriteria(LogisticRegression self, TermCriteria val)
{
  BEGIN_WRAP
  self.ptr->setTermCriteria(*val.ptr);
  END_WRAP
}

CvStatus LogisticRegression_Predict(LogisticRegression self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus LogisticRegression_Train(LogisticRegression self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus LogisticRegression_Train_1(LogisticRegression self, Mat samples, int layout, Mat responses,
                                    bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus LogisticRegression_Clear(LogisticRegression self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus LogisticRegression_GetLearntThetas(LogisticRegression self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->get_learnt_thetas())};
  END_WRAP
}

CvStatus LogisticRegression_Save(LogisticRegression self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus LogisticRegression_Load(LogisticRegression self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::LogisticRegression::load(filepath);
  END_WRAP
}

CvStatus LogisticRegression_LoadFromString(LogisticRegression self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::LogisticRegression>(strModel, objname);
  END_WRAP
}
