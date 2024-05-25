/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#ifndef CVD_ML_NORMAL_BAYES_CLASSIFIER_H
#define CVD_ML_NORMAL_BAYES_CLASSIFIER_H

#include "core/core.h"
#include "core/exception.h"
#include "train_data.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::NormalBayesClassifier>, PtrNormalBayesClassifier)
CVD_TYPEDEF(cv::ml::NormalBayesClassifier, NormalBayesClassifier)
#else
CVD_TYPEDEF(void *, PtrNormalBayesClassifier)
CVD_TYPEDEF(void, NormalBayesClassifier)
#endif

CVD_TYPEDEF_PTR(PtrNormalBayesClassifier)
CVD_TYPEDEF_PTR(NormalBayesClassifier)

// NormalBayesClassifier
CvStatus NormalBayesClassifier_Create(PtrNormalBayesClassifier *rval);
void     NormalBayesClassifier_Close(PtrNormalBayesClassifier *self);
CvStatus NormalBayesClassifier_Get(PtrNormalBayesClassifier self, NormalBayesClassifier *rval);

CvStatus NormalBayesClassifier_PredictProb(NormalBayesClassifier self, Mat inputs, Mat outputs, Mat outputProbs, int flags, float *rval);
CvStatus NormalBayesClassifier_Train(NormalBayesClassifier self, PtrTrainData trainData, int flags, bool *rval);
CvStatus NormalBayesClassifier_Train_1(NormalBayesClassifier self, Mat samples, int layout, Mat responses, bool *rval);
CvStatus NormalBayesClassifier_Clear(NormalBayesClassifier self);
CvStatus NormalBayesClassifier_Save(NormalBayesClassifier self, char *filename);
CvStatus NormalBayesClassifier_Load(NormalBayesClassifier self, char *filepath);
CvStatus NormalBayesClassifier_LoadFromString(NormalBayesClassifier self, const char *strModel, const char *objname);

#ifdef __cplusplus
}
#endif

#endif
