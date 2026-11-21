/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_TRAIN_DATA_H
#define CVD_ML_TRAIN_DATA_H

#include "dartcv/core/types.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::TrainData>, TrainData);
#else
CVD_TYPEDEF(void*, TrainData);
#endif

/// Empty Mats are passed to OpenCV as cv::noArray().
CvStatus* cv_ml_TrainData_create(
    Mat samples,
    int layout,
    Mat responses,
    Mat varIdx,
    Mat sampleIdx,
    Mat sampleWeights,
    Mat varType,
    TrainData* rval
);
CvStatus* cv_ml_TrainData_loadFromCSV(
    const char* filename,
    int headerLineCount,
    int responseStartIdx,
    int responseEndIdx,
    const char* varTypeSpec,
    char delimiter,
    char missch,
    TrainData* rval,
    CvCallback_0 callback
);
void cv_ml_TrainData_close(TrainDataPtr self);

int cv_ml_TrainData_getLayout(TrainData self);
int cv_ml_TrainData_getNSamples(TrainData self);
int cv_ml_TrainData_getNTrainSamples(TrainData self);
int cv_ml_TrainData_getNTestSamples(TrainData self);
int cv_ml_TrainData_getNVars(TrainData self);
int cv_ml_TrainData_getNAllVars(TrainData self);
int cv_ml_TrainData_getResponseType(TrainData self);
CvStatus* cv_ml_TrainData_getCatCount(TrainData self, int vi, int* rval);

CvStatus* cv_ml_TrainData_getSamples(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getResponses(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getMissing(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getVarIdx(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getVarType(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getVarSymbolFlags(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getSampleWeights(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTrainSampleWeights(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTestSampleWeights(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTrainSampleIdx(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTestSampleIdx(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTrainResponses(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTestResponses(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getNormCatResponses(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTrainNormCatResponses(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTestNormCatResponses(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getClassLabels(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getCatOfs(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getCatMap(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getDefaultSubstValues(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTestSamples(TrainData self, Mat rval);
CvStatus* cv_ml_TrainData_getTrainSamples(
    TrainData self, int layout, bool compressSamples, bool compressVars, Mat rval
);
CvStatus* cv_ml_TrainData_getNames(TrainData self, VecVecChar* rval);

CvStatus* cv_ml_TrainData_setTrainTestSplit(TrainData self, int count, bool shuffle);
CvStatus* cv_ml_TrainData_setTrainTestSplitRatio(TrainData self, double ratio, bool shuffle);
CvStatus* cv_ml_TrainData_shuffleTrainTest(TrainData self);

float cv_ml_TrainData_missingValue(void);
CvStatus* cv_ml_TrainData_getSubVector(Mat vec, Mat idx, Mat rval);
CvStatus* cv_ml_TrainData_getSubMatrix(Mat matrix, Mat idx, int layout, Mat rval);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_TRAIN_DATA_H
