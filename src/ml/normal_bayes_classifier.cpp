/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "normal_bayes_classifier.h"

// NormalBayesClassifier
CvStatus NormalBayesClassifier_Create(PtrNormalBayesClassifier *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::NormalBayesClassifier>()};
  END_WRAP
}

void NormalBayesClassifier_Close(PtrNormalBayesClassifier *self)
{
  CVD_FREE(self)
}

CvStatus NormalBayesClassifier_Get(PtrNormalBayesClassifier self, NormalBayesClassifier *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus NormalBayesClassifier_PredictProb(NormalBayesClassifier self, Mat inputs, Mat outputs, Mat outputProbs, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predictProb(inputs.ptr, outputs.ptr, outputProbs.ptr, flags);
  END_WRAP
}

CvStatus NormalBayesClassifier_Train(NormalBayesClassifier self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(trainData.ptr, flags);
  END_WRAP
}

CvStatus NormalBayesClassifier_Train_1(NormalBayesClassifier self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(samples.ptr, layout, responses.ptr);
  END_WRAP
}

CvStatus NormalBayesClassifier_Clear(NormalBayesClassifier self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus NormalBayesClassifier_Save(NormalBayesClassifier self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus NormalBayesClassifier_Load(NormalBayesClassifier self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::NormalBayesClassifier::load(filepath);
  END_WRAP
}

CvStatus NormalBayesClassifier_LoadFromString(NormalBayesClassifier self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::NormalBayesClassifier>(strModel, objname);
  END_WRAP
}
