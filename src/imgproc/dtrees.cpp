/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "dtrees.h"

// DTrees
CvStatus DTrees_Create(PtrDTrees *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::DTrees>()};
  END_WRAP
}

void DTrees_Close(PtrDTrees *self)
{
  CVD_FREE(self)
}

CvStatus DTrees_Get(PtrDTrees self, DTrees *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus DTrees_GetMaxCategories(DTrees self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getMaxCategories();
  END_WRAP
}

CvStatus DTrees_SetMaxCategories(DTrees self, int val)
{
  BEGIN_WRAP
  self.ptr->setMaxCategories(val);
  END_WRAP
}

CvStatus DTrees_GetMaxDepth(DTrees self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getMaxDepth();
  END_WRAP
}

CvStatus DTrees_SetMaxDepth(DTrees self, int val)
{
  BEGIN_WRAP
  self.ptr->setMaxDepth(val);
  END_WRAP
}

CvStatus DTrees_GetMinSampleCount(DTrees self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getMinSampleCount();
  END_WRAP
}

CvStatus DTrees_SetMinSampleCount(DTrees self, int val)
{
  BEGIN_WRAP
  self.ptr->setMinSampleCount(val);
  END_WRAP
}

CvStatus DTrees_GetCVFolds(DTrees self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getCVFolds();
  END_WRAP
}

CvStatus DTrees_SetCVFolds(DTrees self, int val)
{
  BEGIN_WRAP
  self.ptr->setCVFolds(val);
  END_WRAP
}

CvStatus DTrees_GetUseSurrogates(DTrees self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getUseSurrogates();
  END_WRAP
}

CvStatus DTrees_SetUseSurrogates(DTrees self, bool val)
{
  BEGIN_WRAP
  self.ptr->setUseSurrogates(val);
  END_WRAP
}

CvStatus DTrees_GetUse1SERule(DTrees self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getUse1SERule();
  END_WRAP
}

CvStatus DTrees_SetUse1SERule(DTrees self, bool val)
{
  BEGIN_WRAP
  self.ptr->setUse1SERule(val);
  END_WRAP
}

CvStatus DTrees_GetTruncatePrunedTree(DTrees self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getTruncatePrunedTree();
  END_WRAP
}

CvStatus DTrees_SetTruncatePrunedTree(DTrees self, bool val)
{
  BEGIN_WRAP
  self.ptr->setTruncatePrunedTree(val);
  END_WRAP
}

CvStatus DTrees_GetRegressionAccuracy(DTrees self, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getRegressionAccuracy();
  END_WRAP
}

CvStatus DTrees_SetRegressionAccuracy(DTrees self, float val)
{
  BEGIN_WRAP
  self.ptr->setRegressionAccuracy(val);
  END_WRAP
}

CvStatus DTrees_GetPriors(DTrees self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->getPriors()};
  END_WRAP
}

CvStatus DTrees_SetPriors(DTrees self, Mat val)
{
  BEGIN_WRAP
  self.ptr->setPriors(val.ptr);
  END_WRAP
}

CvStatus DTrees_Predict(DTrees self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predict(samples.ptr, results.ptr, flags);
  END_WRAP
}

CvStatus DTrees_Train(DTrees self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(trainData.ptr, flags);
  END_WRAP
}

CvStatus DTrees_Train_1(DTrees self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(samples.ptr, layout, responses.ptr);
  END_WRAP
}

CvStatus DTrees_Clear(DTrees self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus DTrees_Save(DTrees self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus DTrees_Load(DTrees self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::DTrees::load(filepath);
  END_WRAP
}

CvStatus DTrees_LoadFromString(DTrees self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::DTrees>(strModel, objname);
  END_WRAP
}
