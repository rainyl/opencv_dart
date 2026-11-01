/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#include "dartcv/ml/train_data.h"
#include "dartcv/core/vec.hpp"
#include <string>

static cv::_InputArray cvd_or_noarray(Mat m) {
    if (m.ptr == nullptr || m.ptr->empty()) {
        return cv::_InputArray();
    }
    return cv::_InputArray(*m.ptr);
}

CvStatus* cv_ml_TrainData_create(
    Mat samples,
    int layout,
    Mat responses,
    Mat varIdx,
    Mat sampleIdx,
    Mat sampleWeights,
    Mat varType,
    TrainData* rval
) {
    BEGIN_WRAP
    auto p = cv::ml::TrainData::create(
        CVDEREF(samples),
        layout,
        CVDEREF(responses),
        cvd_or_noarray(varIdx),
        cvd_or_noarray(sampleIdx),
        cvd_or_noarray(sampleWeights),
        cvd_or_noarray(varType)
    );
    rval->ptr = new cv::Ptr<cv::ml::TrainData>(p);
    END_WRAP
}

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
) {
    BEGIN_WRAP
    auto p = cv::ml::TrainData::loadFromCSV(
        filename,
        headerLineCount,
        responseStartIdx,
        responseEndIdx,
        varTypeSpec == nullptr ? cv::String() : cv::String(varTypeSpec),
        delimiter,
        missch
    );
    if (p.empty()) {
        CV_Error(cv::Error::StsError, std::string("Failed to load train data from ") + filename);
    }
    rval->ptr = new cv::Ptr<cv::ml::TrainData>(p);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_ml_TrainData_close(TrainDataPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

int cv_ml_TrainData_getLayout(TrainData self) {
    return (CVDEREF(self))->getLayout();
}
int cv_ml_TrainData_getNSamples(TrainData self) {
    return (CVDEREF(self))->getNSamples();
}
int cv_ml_TrainData_getNTrainSamples(TrainData self) {
    return (CVDEREF(self))->getNTrainSamples();
}
int cv_ml_TrainData_getNTestSamples(TrainData self) {
    return (CVDEREF(self))->getNTestSamples();
}
int cv_ml_TrainData_getNVars(TrainData self) {
    return (CVDEREF(self))->getNVars();
}
int cv_ml_TrainData_getNAllVars(TrainData self) {
    return (CVDEREF(self))->getNAllVars();
}
int cv_ml_TrainData_getResponseType(TrainData self) {
    return (CVDEREF(self))->getResponseType();
}
CvStatus* cv_ml_TrainData_getCatCount(TrainData self, int vi, int* rval) {
    BEGIN_WRAP
    *rval = (CVDEREF(self))->getCatCount(vi);
    END_WRAP
}

#define CVD_TRAINDATA_MAT_GETTER(FN)                                                               \
    CvStatus* cv_ml_TrainData_##FN(TrainData self, Mat rval) {                                     \
        BEGIN_WRAP                                                                                 \
        CVDEREF(rval) = (CVDEREF(self))->FN();                                                     \
        END_WRAP                                                                                   \
    }

CVD_TRAINDATA_MAT_GETTER(getSamples)
CVD_TRAINDATA_MAT_GETTER(getResponses)
CVD_TRAINDATA_MAT_GETTER(getMissing)
CVD_TRAINDATA_MAT_GETTER(getVarIdx)
CVD_TRAINDATA_MAT_GETTER(getVarType)
CVD_TRAINDATA_MAT_GETTER(getVarSymbolFlags)
CVD_TRAINDATA_MAT_GETTER(getSampleWeights)
CVD_TRAINDATA_MAT_GETTER(getTrainSampleWeights)
CVD_TRAINDATA_MAT_GETTER(getTestSampleWeights)
CVD_TRAINDATA_MAT_GETTER(getTrainSampleIdx)
CVD_TRAINDATA_MAT_GETTER(getTestSampleIdx)
CVD_TRAINDATA_MAT_GETTER(getTrainResponses)
CVD_TRAINDATA_MAT_GETTER(getTestResponses)
CVD_TRAINDATA_MAT_GETTER(getNormCatResponses)
CVD_TRAINDATA_MAT_GETTER(getTrainNormCatResponses)
CVD_TRAINDATA_MAT_GETTER(getTestNormCatResponses)
CVD_TRAINDATA_MAT_GETTER(getClassLabels)
CVD_TRAINDATA_MAT_GETTER(getCatOfs)
CVD_TRAINDATA_MAT_GETTER(getCatMap)
CVD_TRAINDATA_MAT_GETTER(getDefaultSubstValues)
CVD_TRAINDATA_MAT_GETTER(getTestSamples)

#undef CVD_TRAINDATA_MAT_GETTER

CvStatus* cv_ml_TrainData_getTrainSamples(
    TrainData self, int layout, bool compressSamples, bool compressVars, Mat rval
) {
    BEGIN_WRAP
    CVDEREF(rval) = (CVDEREF(self))->getTrainSamples(layout, compressSamples, compressVars);
    END_WRAP
}

CvStatus* cv_ml_TrainData_getNames(TrainData self, VecVecChar* rval) {
    BEGIN_WRAP
    std::vector<cv::String> names;
    (CVDEREF(self))->getNames(names);
    rval->ptr = vecstr_2_vecvecchar(names);
    END_WRAP
}

CvStatus* cv_ml_TrainData_setTrainTestSplit(TrainData self, int count, bool shuffle) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTrainTestSplit(count, shuffle);
    END_WRAP
}
CvStatus* cv_ml_TrainData_setTrainTestSplitRatio(TrainData self, double ratio, bool shuffle) {
    BEGIN_WRAP(CVDEREF(self))
    ->setTrainTestSplitRatio(ratio, shuffle);
    END_WRAP
}
CvStatus* cv_ml_TrainData_shuffleTrainTest(TrainData self) {
    BEGIN_WRAP(CVDEREF(self))
    ->shuffleTrainTest();
    END_WRAP
}

float cv_ml_TrainData_missingValue(void) {
    return cv::ml::TrainData::missingValue();
}
CvStatus* cv_ml_TrainData_getSubVector(Mat vec, Mat idx, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = cv::ml::TrainData::getSubVector(CVDEREF(vec), CVDEREF(idx));
    END_WRAP
}
CvStatus* cv_ml_TrainData_getSubMatrix(Mat matrix, Mat idx, int layout, Mat rval) {
    BEGIN_WRAP
    CVDEREF(rval) = cv::ml::TrainData::getSubMatrix(CVDEREF(matrix), CVDEREF(idx), layout);
    END_WRAP
}
