#include "train_data.h"
#include "core/core.h"
#include <vector>

CvStatus TrainData_Create(Mat samples, int layout, Mat responses, Mat varIdx, Mat sampleIdx,
                          Mat sampleWeights, Mat varType, PtrTrainData *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::TrainData::create(*samples.ptr, layout, *responses.ptr, *varIdx.ptr, *sampleIdx.ptr,
                                     *sampleWeights.ptr, *varType.ptr);
  *rval = {new cv::Ptr<cv::ml::TrainData>(p)};
  END_WRAP
}
CvStatus TrainData_LoadFromCSV(char *filename, int headerLineCount, int responseStartIdx, int responseEndIdx,
                               char *varTypeSpec, char delimiter, char missch, PtrTrainData *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::TrainData::loadFromCSV(filename, headerLineCount, responseStartIdx, responseEndIdx,
                                          varTypeSpec, delimiter, missch);
  *rval = {new cv::Ptr<cv::ml::TrainData>(p)};
  END_WRAP
}
void TrainData_Close(PtrTrainData *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus TrainData_Get(PtrTrainData *self, TrainData *rval)
{
  BEGIN_WRAP
  *rval = {self->ptr->get()};
  END_WRAP
}

CvStatus TrainData_GetSubMatrix(Mat matrix, Mat idx, int layout, Mat *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::TrainData::getSubMatrix(*matrix.ptr, *idx.ptr, layout);
  *rval = {new cv::Mat(p)};
  END_WRAP
}
CvStatus TrainData_GetSubVector(Mat vec, Mat idx, Mat *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::TrainData::getSubVector(*vec.ptr, *idx.ptr);
  *rval = {new cv::Mat(p)};
  END_WRAP
}
CvStatus TrainData_MissingValue(float *rval)
{
  BEGIN_WRAP
  *rval = cv::ml::TrainData::missingValue();
  END_WRAP
}

CvStatus TrainData_GetCatCount(PtrTrainData self, int vi, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getCatCount(vi);
  END_WRAP
}
CvStatus TrainData_GetCatMap(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getCatMap())};
  END_WRAP
}
CvStatus TrainData_GetCatOfs(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getCatOfs())};
  END_WRAP
}
CvStatus TrainData_GetClassLabels(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getCatOfs())};
  END_WRAP
}
CvStatus TrainData_GetDefaultSubstValues(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getDefaultSubstValues())};
  END_WRAP
}
CvStatus TrainData_GetLayout(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getLayout();
  END_WRAP
}
CvStatus TrainData_GetMissing(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getMissing())};
  END_WRAP
}
CvStatus TrainData_GetNAllVars(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getNAllVars();
  END_WRAP
}
CvStatus TrainData_GetNames(PtrTrainData self, VecVecChar *names)
{
  BEGIN_WRAP
  auto                    vec = new std::vector<std::vector<char>>();
  std::vector<cv::String> cstrs;
  (*self.ptr)->getNames(cstrs);
  for (size_t i = 0; i < cstrs.size(); i++) {
    std::vector<char> cstr(cstrs[i].begin(), cstrs[i].end());
    vec->push_back(cstr);
  }
  *names = {vec};
  END_WRAP
}
CvStatus TrainData_GetNormCatResponses(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getNormCatResponses())};
  END_WRAP
}
CvStatus TrainData_GetNormCatValues(PtrTrainData self, int vi, Mat sidx, VecInt *values)
{
  BEGIN_WRAP
  // https://github.com/opencv/opencv/blob/05e48605a0aea00d3a89b9ab5e25cdf89568aa28/modules/ml/src/data.cpp#L888
  int  n = sidx.ptr->checkVector(1, CV_32S);
  int *buffer = new int[n];
  (*self.ptr)->getNormCatValues(vi, *sidx.ptr, buffer);
  *values = {new std::vector<int>(buffer, buffer + n)};
  END_WRAP
}
CvStatus TrainData_GetNSamples(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getNSamples();
  END_WRAP
}
CvStatus TrainData_GetNTestSamples(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getNTestSamples();
  END_WRAP
}
CvStatus TrainData_GetNTrainSamples(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getNTrainSamples();
  END_WRAP
}
CvStatus TrainData_GetNVars(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getNVars();
  END_WRAP
}
CvStatus TrainData_GetResponses(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getResponses())};
  END_WRAP
}
CvStatus TrainData_GetResponseType(PtrTrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getResponseType();
  END_WRAP
}
CvStatus TrainData_GetSample(PtrTrainData self, Mat varIdx, int sidx, VecFloat *buf)
{
  BEGIN_WRAP
  int    n = varIdx.ptr->checkVector(1, CV_32S);
  float *buffer = new float[n];
  (*self.ptr)->getSample(*varIdx.ptr, sidx, buffer);
  *buf = {new std::vector<float>(buffer, buffer + n)};
  END_WRAP
}
CvStatus TrainData_GetSamples(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getSamples())};
  END_WRAP
}
CvStatus TrainData_GetSampleWeights(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getSampleWeights())};
  END_WRAP
}
CvStatus TrainData_GetTestNormCatResponses(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTestNormCatResponses())};
  END_WRAP
}
CvStatus TrainData_GetTestResponses(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTestResponses())};
  END_WRAP
}
CvStatus TrainData_GetTestSampleIdx(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTestSampleIdx())};
  END_WRAP
}
CvStatus TrainData_GetTestSamples(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTestSamples())};
  END_WRAP
}
CvStatus TrainData_GetTestSampleWeights(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTestSampleWeights())};
  END_WRAP
}
CvStatus TrainData_GetTrainNormCatResponses(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTrainNormCatResponses())};
  END_WRAP
}
CvStatus TrainData_GetTrainResponses(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTrainResponses())};
  END_WRAP
}
CvStatus TrainData_GetTrainSampleIdx(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTrainSampleIdx())};
  END_WRAP
}
CvStatus TrainData_GetTrainSamples(PtrTrainData self, int layout, bool compressSamples, bool compressVars,
                                   Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTrainSamples(layout, compressSamples, compressVars))};
  END_WRAP
}
CvStatus TrainData_GetTrainSampleWeights(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getTrainSampleWeights())};
  END_WRAP
}
CvStatus TrainData_GetValues(PtrTrainData self, int vi, Mat sidx, VecFloat *values)
{
  BEGIN_WRAP
  // https://github.com/opencv/opencv/blob/05e48605a0aea00d3a89b9ab5e25cdf89568aa28/modules/ml/src/data.cpp#L888
  int    n = sidx.ptr->checkVector(1, CV_32S);
  float *buffer = new float[n];
  (*self.ptr)->getValues(vi, *sidx.ptr, buffer);
  *values = {new std::vector<float>(buffer, buffer + n)};
  END_WRAP
}
CvStatus TrainData_GetVarIdx(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getVarIdx())};
  END_WRAP
}
CvStatus TrainData_GetVarSymbolFlags(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getVarSymbolFlags())};
  END_WRAP
}
CvStatus TrainData_GetVarType(PtrTrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getVarType())};
  END_WRAP
}
CvStatus TrainData_SetTrainTestSplit(PtrTrainData self, int count, bool shuffle)
{
  BEGIN_WRAP(*self.ptr)->setTrainTestSplit(count, shuffle);
  END_WRAP
}
CvStatus TrainData_SetTrainTestSplitRatio(PtrTrainData self, double ratio, bool shuffle)
{
  BEGIN_WRAP(*self.ptr)->setTrainTestSplitRatio(ratio, shuffle);
  END_WRAP
}
CvStatus TrainData_ShuffleTrainTest(PtrTrainData self)
{
  BEGIN_WRAP(*self.ptr)->shuffleTrainTest();
  END_WRAP
}
