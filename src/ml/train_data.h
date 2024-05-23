/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ML_TRAINDATA_H
#define CVD_ML_TRAINDATA_H

#include "core/core.h"
#include "core/exception.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html
CVD_TYPEDEF(cv::Ptr<cv::ml::TrainData>, PtrTrainData)
CVD_TYPEDEF(cv::ml::TrainData, TrainData)
#else
CVD_TYPEDEF(void *, PtrTrainData)
CVD_TYPEDEF(void, TrainData)
#endif

CVD_TYPEDEF_PTR(PtrTrainData)
CVD_TYPEDEF_PTR(TrainData)

// TrainData
CvStatus TrainData_Create(Mat samples, int layout, Mat responses, Mat varIdx, Mat sampleIdx,
                          Mat sampleWeights, Mat varType, PtrTrainData *rval);
CvStatus TrainData_LoadFromCSV(char *filename, int headerLineCount, int responseStartIdx, int responseEndIdx,
                               char *varTypeSpec, char delimiter, char missch, PtrTrainData *rval);
void     TrainData_Close(PtrTrainData *self);
CvStatus TrainData_Get(PtrTrainData *self, TrainData *rval);
// static functions
// input matrix (supported types: CV_32S, CV_32F, CV_64F)
CvStatus TrainData_GetSubMatrix(const Mat matrix, const Mat idx, int layout, Mat *rval);
CvStatus TrainData_GetSubVector(const Mat vec, const Mat idx, Mat *rval);
CvStatus TrainData_MissingValue(float *rval);

// member functions
CvStatus TrainData_GetCatCount(TrainData self, int vi, int *rval);
CvStatus TrainData_GetCatMap(TrainData self, Mat *rval);
CvStatus TrainData_GetCatOfs(TrainData self, Mat *rval);
CvStatus TrainData_GetClassLabels(TrainData self, Mat *rval);
CvStatus TrainData_GetDefaultSubstValues(TrainData self, Mat *rval);
CvStatus TrainData_GetLayout(TrainData self, int *rval);
CvStatus TrainData_GetMissing(TrainData self, Mat *rval);
CvStatus TrainData_GetNAllVars(TrainData self, int *rval);
CvStatus TrainData_GetNames(TrainData self, VecVecChar *names);
CvStatus TrainData_GetNormCatResponses(TrainData self, Mat *rval);
CvStatus TrainData_GetNSamples(TrainData self, int *rval);
CvStatus TrainData_GetNTestSamples(TrainData self, int *rval);
CvStatus TrainData_GetNTrainSamples(TrainData self, int *rval);
CvStatus TrainData_GetNVars(TrainData self, int *rval);
CvStatus TrainData_GetResponses(TrainData self, Mat *rval);
CvStatus TrainData_GetResponseType(TrainData self, int *rval);
CvStatus TrainData_GetSample(TrainData self, Mat varIdx, int sidx, float *buf);
CvStatus TrainData_GetSamples(TrainData self, Mat *rval);
CvStatus TrainData_GetSampleWeights(TrainData self, Mat *rval);
CvStatus TrainData_GetTestNormCatResponses(TrainData self, Mat *rval);
CvStatus TrainData_GetTestResponses(TrainData self, Mat *rval);
CvStatus TrainData_GetTestSampleIdx(TrainData self, Mat *rval);
CvStatus TrainData_GetTestSamples(TrainData self, Mat *rval);
CvStatus TrainData_GetTestSampleWeights(TrainData self, Mat *rval);
CvStatus TrainData_GetTrainNormCatResponses(TrainData self, Mat *rval);
CvStatus TrainData_GetTrainResponses(TrainData self, Mat *rval);
CvStatus TrainData_GetTrainSampleIdx(TrainData self, Mat *rval);
CvStatus TrainData_GetTrainSamples(TrainData self, int layout, bool compressSamples, bool compressVars,
                                   Mat *rval);
CvStatus TrainData_GetTrainSampleWeights(TrainData self, Mat *rval);
CvStatus TrainData_GetValues(TrainData self, int vi, Mat sidx, float *values);
CvStatus TrainData_GetVarIdx(TrainData self, Mat *rval);
CvStatus TrainData_GetVarSymbolFlags(TrainData self, Mat *rval);
CvStatus TrainData_GetVarType(TrainData self, Mat *rval);
CvStatus TrainData_SetTrainTestSplit(TrainData self, int count, bool shuffle);
CvStatus TrainData_SetTrainTestSplitRatio(TrainData self, double ratio, bool shuffle);
CvStatus TrainData_ShuffleTrainTest(TrainData self);

#ifdef __cplusplus
}
#endif

#endif
