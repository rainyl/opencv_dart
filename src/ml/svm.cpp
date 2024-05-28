/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "svm.h"

// ParamGrid
CvStatus ParamGrid_Empty(PtrParamGrid *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::ParamGrid::create();
  *rval = {new cv::Ptr<cv::ml::ParamGrid>(p)};
  END_WRAP
}

CvStatus ParamGrid_New(double minVal, double maxVal, double logstep, PtrParamGrid *rval)
{
  BEGIN_WRAP
  auto p = cv::ml::ParamGrid::create(minVal, maxVal, logstep);
  *rval = {new cv::Ptr<cv::ml::ParamGrid>(p)};
  END_WRAP
}

CvStatus ParamGrid_getMinVal(PtrParamGrid self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->minVal;
  END_WRAP
}

CvStatus ParamGrid_GetMaxVal(PtrParamGrid self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->maxVal;
  END_WRAP
}

CvStatus ParamGrid_GetLogStep(PtrParamGrid self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->logStep;
  END_WRAP
}

void ParamGrid_Close(PtrParamGrid *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

// SVM
CvStatus SVM_Create(PtrSVM *rval)
{
  BEGIN_WRAP
  cv::Ptr<cv::ml::SVM> p = cv::ml::SVM::create();
  *rval = {new cv::Ptr<cv::ml::SVM>(p)};
  END_WRAP
}

void SVM_Close(PtrSVM *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

// CvStatus SVM_Get(PtrSVM self, SVM *rval)
// {
//   BEGIN_WRAP
//   *rval = {self.ptr->get()};
//   END_WRAP
// }

CvStatus SVM_GetC(PtrSVM self, double *rval)
{
  BEGIN_WRAP
  auto c = (*self.ptr)->getC();
  std::cout << c << std::endl;
  *rval = (*self.ptr)->getC();
  END_WRAP
}

CvStatus SVM_GetClassWeights(PtrSVM self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getClassWeights())};
  END_WRAP
}

CvStatus SVM_GetCoef0(PtrSVM self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getCoef0();
  END_WRAP
}

CvStatus SVM_GetDecisionFunction(PtrSVM self, int i, Mat alpha, Mat svidx, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getDecisionFunction(i, *alpha.ptr, *svidx.ptr);
  END_WRAP
}

CvStatus SVM_GetDegree(PtrSVM self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getDegree();
  END_WRAP
}

CvStatus SVM_GetGamma(PtrSVM self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getGamma();
  END_WRAP
}

CvStatus SVM_GetKernelType(PtrSVM self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getKernelType();
  END_WRAP
}

CvStatus SVM_GetNu(PtrSVM self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getNu();
  END_WRAP
}

CvStatus SVM_GetP(PtrSVM self, double *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getP();
  END_WRAP
}

CvStatus SVM_GetSupportVectors(PtrSVM self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getSupportVectors())};
  END_WRAP
}

CvStatus SVM_GetTermCriteria(PtrSVM self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = (*self.ptr)->getTermCriteria();
  *rval = {tc.type, tc.maxCount, tc.epsilon};
  END_WRAP
}

CvStatus SVM_GetType(PtrSVM self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getType();
  END_WRAP
}

CvStatus SVM_GetUncompressedSupportVectors(PtrSVM self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*self.ptr)->getUncompressedSupportVectors())};
  END_WRAP
}

CvStatus SVM_SetC(PtrSVM self, double val)
{
  BEGIN_WRAP(*self.ptr)->setC(val);
  END_WRAP
}

CvStatus SVM_SetClassWeights(PtrSVM self, Mat val)
{
  BEGIN_WRAP(*self.ptr)->setClassWeights(*val.ptr);
  END_WRAP
}

CvStatus SVM_SetCoef0(PtrSVM self, double val)
{
  BEGIN_WRAP(*self.ptr)->setCoef0(val);
  END_WRAP
}

CvStatus SVM_SetDegree(PtrSVM self, double val)
{
  BEGIN_WRAP(*self.ptr)->setDegree(val);
  END_WRAP
}

CvStatus SVM_SetGamma(PtrSVM self, double val)
{
  BEGIN_WRAP(*self.ptr)->setGamma(val);
  END_WRAP
}

CvStatus SVM_SetKernel(PtrSVM self, int kernelType)
{
  BEGIN_WRAP(*self.ptr)->setKernel(kernelType);
  END_WRAP
}

CvStatus SVM_SetNu(PtrSVM self, double val)
{
  BEGIN_WRAP(*self.ptr)->setNu(val);
  END_WRAP
}

CvStatus SVM_SetP(PtrSVM self, double val)
{
  BEGIN_WRAP(*self.ptr)->setP(val);
  END_WRAP
}

CvStatus SVM_SetTermCriteria(PtrSVM self, TermCriteria val)
{
  BEGIN_WRAP
  auto tc = cv::TermCriteria(val.type, val.maxCount, val.epsilon);
  (*self.ptr)->setTermCriteria(tc);
  END_WRAP
}

CvStatus SVM_SetType(PtrSVM self, int val)
{
  BEGIN_WRAP(*self.ptr)->setType(val);
  END_WRAP
}

CvStatus SVM_TrainAuto(PtrSVM self, PtrTrainData data, int kFold, PtrParamGrid Cgrid, PtrParamGrid gammaGrid,
                       PtrParamGrid pGrid, PtrParamGrid nuGrid, PtrParamGrid coeffGrid,
                       PtrParamGrid degreeGrid, bool balanced, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->trainAuto(*data.ptr, kFold, **Cgrid.ptr, **gammaGrid.ptr, **pGrid.ptr, **nuGrid.ptr,
                                 **coeffGrid.ptr, **degreeGrid.ptr, balanced);
  END_WRAP
}

CvStatus SVM_TrainAuto_1(PtrSVM self, Mat samples, int layout, Mat responses, int kFold, PtrParamGrid Cgrid,
                         PtrParamGrid gammaGrid, PtrParamGrid pGrid, PtrParamGrid nuGrid,
                         PtrParamGrid coeffGrid, PtrParamGrid degreeGrid, bool balanced, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->trainAuto(*samples.ptr, layout, *responses.ptr, kFold, *Cgrid.ptr, *gammaGrid.ptr,
                                 *pGrid.ptr, *nuGrid.ptr, *coeffGrid.ptr, *degreeGrid.ptr, balanced);
  END_WRAP
}

CvStatus SVM_CalcError(PtrSVM self, PtrTrainData data, bool test, Mat resp, float *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->calcError(*data.ptr, test, *resp.ptr);
  END_WRAP
}

CvStatus SVM_Empty(PtrSVM self, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->empty();
  END_WRAP
}

CvStatus SVM_GetVarCount(PtrSVM self, int *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->getVarCount();
  END_WRAP
}

CvStatus SVM_IsClassifier(PtrSVM self, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->isClassifier();
  END_WRAP
}

CvStatus SVM_IsTrained(PtrSVM self, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->isTrained();
  END_WRAP
}

CvStatus SVM_Predict(PtrSVM self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus SVM_Train(PtrSVM self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus SVM_Train_1(PtrSVM self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = (*self.ptr)->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus SVM_Clear(PtrSVM self)
{
  BEGIN_WRAP(*self.ptr)->clear();
  END_WRAP
}

CvStatus SVM_GetDefaultName(PtrSVM self, char *rval)
{
  BEGIN_WRAP
  std::string name = (*self.ptr)->getDefaultName();
  std::strcpy(rval, name.c_str());
  END_WRAP
}

CvStatus SVM_GetDefaultGridPtr(PtrSVM self, int param_id, PtrParamGrid *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::ParamGrid>((*self.ptr)->getDefaultGridPtr(param_id))};
  END_WRAP
}

CvStatus SVM_Save(PtrSVM self, char *filename)
{
  BEGIN_WRAP(*self.ptr)->save(filename);
  END_WRAP
}

CvStatus SVM_Load(char *filepath, PtrSVM *rval)
{
  BEGIN_WRAP(*rval->ptr) = cv::ml::SVM::load(filepath);
  END_WRAP
}

CvStatus SVM_LoadFromString(const char *strModel, const char *objname, PtrSVM *rval)
{
  BEGIN_WRAP(*rval->ptr) = cv::Algorithm::loadFromString<cv::ml::SVM>(strModel, objname);
  END_WRAP
}
