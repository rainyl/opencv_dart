#include "train_data.h"
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

CvStatus TrainData_GetSubMatrix(const Mat &matrix, const Mat &idx, int layout, Mat *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::TrainData::getSubMatrix(*matrix.ptr, *idx.ptr, layout);
  *rval = {new cv::Mat(p)};
  END_WRAP
}
CvStatus TrainData_GetSubVector(const Mat &vec, const Mat &idx, Mat *rval)
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

CvStatus TrainData_GetCatCount(TrainData self, int vi, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getCatCount(vi);
  END_WRAP
}
CvStatus TrainData_GetCatMap(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getCatMap())};
  END_WRAP
}
CvStatus TrainData_GetCatOfs(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getCatOfs())};
  END_WRAP
}
CvStatus TrainData_GetClassLabels(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getCatOfs())};
  END_WRAP
}
CvStatus TrainData_GetDefaultSubstValues(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getDefaultSubstValues())};
  END_WRAP
}
CvStatus TrainData_GetLayout(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getLayout();
  END_WRAP
}
CvStatus TrainData_GetMissing(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getMissing())};
  END_WRAP
}
CvStatus TrainData_GetNAllVars(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getNAllVars();
  END_WRAP
}
CvStatus TrainData_GetNames(TrainData self, VecVecChar *names)
{
  BEGIN_WRAP
  auto                    vec = new std::vector<std::vector<char>>();
  std::vector<cv::String> cstrs;
  self.ptr->getNames(cstrs);
  for (size_t i = 0; i < cstrs.size(); i++) {
    std::vector<char> cstr(cstrs[i].begin(), cstrs[i].end());
    vec->push_back(cstr);
  }
  *names = {vec};
  END_WRAP
}
CvStatus TrainData_GetNormCatResponses(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getNormCatResponses())};
  END_WRAP
}
CvStatus TrainData_GetNSamples(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getNSamples();
  END_WRAP
}
CvStatus TrainData_GetNTestSamples(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getNTestSamples();
  END_WRAP
}
CvStatus TrainData_GetNTrainSamples(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getNTrainSamples();
  END_WRAP
}
CvStatus TrainData_GetNVars(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getNVars();
  END_WRAP
}
CvStatus TrainData_GetResponses(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getResponses())};
  END_WRAP
}
CvStatus TrainData_GetResponseType(TrainData self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getResponseType();
  END_WRAP
}
CvStatus TrainData_GetSample(TrainData self, Mat varIdx, int sidx, float *buf)
{
  BEGIN_WRAP
  self.ptr->getSample(*varIdx.ptr, sidx, buf);
  END_WRAP
}
CvStatus TrainData_GetSamples(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getSamples())};
  END_WRAP
}
CvStatus TrainData_GetSampleWeights(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getSampleWeights())};
  END_WRAP
}
CvStatus TrainData_GetTestNormCatResponses(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTestNormCatResponses())};
  END_WRAP
}
CvStatus TrainData_GetTestResponses(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTestResponses())};
  END_WRAP
}
CvStatus TrainData_GetTestSampleIdx(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTestSampleIdx())};
  END_WRAP
}
CvStatus TrainData_GetTestSamples(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTestSamples())};
  END_WRAP
}
CvStatus TrainData_GetTestSampleWeights(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTestSampleWeights())};
  END_WRAP
}
CvStatus TrainData_GetTrainNormCatResponses(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTrainNormCatResponses())};
  END_WRAP
}
CvStatus TrainData_GetTrainResponses(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTrainResponses())};
  END_WRAP
}
CvStatus TrainData_GetTrainSampleIdx(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTrainSampleIdx())};
  END_WRAP
}
CvStatus TrainData_GetTrainSamples(TrainData self, int layout, bool compressSamples, bool compressVars,
                                   Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTrainSamples(layout, compressSamples, compressVars))};
  END_WRAP
}
CvStatus TrainData_GetTrainSampleWeights(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getTrainSampleWeights())};
  END_WRAP
}
CvStatus TrainData_GetValues(TrainData self, int vi, Mat sidx, float *values)
{
  BEGIN_WRAP
  self.ptr->getValues(vi, *sidx.ptr, values);
  END_WRAP
}
CvStatus TrainData_GetVarIdx(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getVarIdx())};
  END_WRAP
}
CvStatus TrainData_GetVarSymbolFlags(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getVarSymbolFlags())};
  END_WRAP
}
CvStatus TrainData_GetVarType(TrainData self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getVarType())};
  END_WRAP
}
CvStatus TrainData_SetTrainTestSplit(TrainData self, int count, bool shuffle)
{
  BEGIN_WRAP
  self.ptr->setTrainTestSplit(count, shuffle);
  END_WRAP
}
CvStatus TrainData_SetTrainTestSplitRatio(TrainData self, double ratio, bool shuffle)
{
  BEGIN_WRAP
  self.ptr->setTrainTestSplitRatio(ratio, shuffle);
  END_WRAP
}
CvStatus TrainData_ShuffleTrainTest(TrainData self)
{
  BEGIN_WRAP
  self.ptr->shuffleTrainTest();
  END_WRAP
}
