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
CvStatus TrainData_GetSubMatrix(Mat matrix, Mat idx, int layout, Mat *rval);
CvStatus TrainData_GetSubVector(Mat vec, Mat idx, Mat *rval);
CvStatus TrainData_MissingValue(float *rval);

// member functions
CvStatus TrainData_GetCatCount(PtrTrainData self, int vi, int *rval);
CvStatus TrainData_GetCatMap(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetCatOfs(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetClassLabels(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetDefaultSubstValues(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetLayout(PtrTrainData self, int *rval);
CvStatus TrainData_GetMissing(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetNAllVars(PtrTrainData self, int *rval);
CvStatus TrainData_GetNames(PtrTrainData self, VecVecChar *names);
CvStatus TrainData_GetNormCatResponses(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetNormCatValues(PtrTrainData self, int vi, Mat sidx, VecInt *values);
CvStatus TrainData_GetNSamples(PtrTrainData self, int *rval);
CvStatus TrainData_GetNTestSamples(PtrTrainData self, int *rval);
CvStatus TrainData_GetNTrainSamples(PtrTrainData self, int *rval);
CvStatus TrainData_GetNVars(PtrTrainData self, int *rval);
CvStatus TrainData_GetResponses(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetResponseType(PtrTrainData self, int *rval);
CvStatus TrainData_GetSample(PtrTrainData self, Mat varIdx, int sidx, VecFloat *buf);
CvStatus TrainData_GetSamples(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetSampleWeights(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTestNormCatResponses(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTestResponses(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTestSampleIdx(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTestSamples(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTestSampleWeights(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTrainNormCatResponses(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTrainResponses(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTrainSampleIdx(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetTrainSamples(PtrTrainData self, int layout, bool compressSamples, bool compressVars,
                                   Mat *rval);
CvStatus TrainData_GetTrainSampleWeights(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetValues(PtrTrainData self, int vi, Mat sidx, VecFloat *values);
CvStatus TrainData_GetVarIdx(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetVarSymbolFlags(PtrTrainData self, Mat *rval);
CvStatus TrainData_GetVarType(PtrTrainData self, Mat *rval);
CvStatus TrainData_SetTrainTestSplit(PtrTrainData self, int count, bool shuffle);
CvStatus TrainData_SetTrainTestSplitRatio(PtrTrainData self, double ratio, bool shuffle);
CvStatus TrainData_ShuffleTrainTest(PtrTrainData self);

#ifdef __cplusplus
}
#endif

#endif
