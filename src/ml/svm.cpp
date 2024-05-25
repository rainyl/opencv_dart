/*
    Created by Abdelaziz Mahdy.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy.
*/

#include "svm.h"

// ParamGrid
CvStatus ParamGrid_Empty(ParamGrid *rval)
{
  BEGIN_WRAP
  *rval = {new cv::ml::ParamGrid()};
  END_WRAP
}

CvStatus ParamGrid_New(double minVal, double maxVal, double logstep, ParamGrid *rval)
{
  BEGIN_WRAP
  *rval = {new cv::ml::ParamGrid(minVal, maxVal, logstep)};
  END_WRAP
}

CvStatus ParamGrid_getMinVal(ParamGrid self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->minVal;
  END_WRAP
}

CvStatus ParamGrid_GetMaxVal(ParamGrid self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->maxVal;
  END_WRAP
}

CvStatus ParamGrid_GetLogStep(ParamGrid self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->logStep;
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
  *rval = {new cv::Ptr<cv::ml::SVM>()};
  END_WRAP
}

void SVM_Close(PtrSVM *self)
{
  *self->ptr = nullptr;
  CVD_FREE(self)
}

CvStatus SVM_Get(PtrSVM self, SVM *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}

CvStatus SVM_GetC(SVM self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getC();
  END_WRAP
}

CvStatus SVM_GetClassWeights(SVM self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getClassWeights())};
  END_WRAP
}

CvStatus SVM_GetCoef0(SVM self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getCoef0();
  END_WRAP
}

CvStatus SVM_GetDecisionFunction(SVM self, int i, Mat alpha, Mat svidx, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getDecisionFunction(i, *alpha.ptr, *svidx.ptr);
  END_WRAP
}

CvStatus SVM_GetDegree(SVM self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getDegree();
  END_WRAP
}

CvStatus SVM_GetGamma(SVM self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getGamma();
  END_WRAP
}

CvStatus SVM_GetKernelType(SVM self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getKernelType();
  END_WRAP
}

CvStatus SVM_GetNu(SVM self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getNu();
  END_WRAP
}

CvStatus SVM_GetP(SVM self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getP();
  END_WRAP
}

CvStatus SVM_GetSupportVectors(SVM self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getSupportVectors())};
  END_WRAP
}

CvStatus SVM_GetTermCriteria(SVM self, TermCriteria *rval)
{
  BEGIN_WRAP
  auto tc = self.ptr->getTermCriteria();
  *rval = {new cv::TermCriteria(tc.type, tc.maxCount, tc.epsilon)};
  END_WRAP
}

CvStatus SVM_GetType(SVM self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getType();
  END_WRAP
}

CvStatus SVM_GetUncompressedSupportVectors(SVM self, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(self.ptr->getUncompressedSupportVectors())};
  END_WRAP
}

CvStatus SVM_SetC(SVM self, double val)
{
  BEGIN_WRAP
  self.ptr->setC(val);
  END_WRAP
}

CvStatus SVM_SetClassWeights(SVM self, Mat val)
{
  BEGIN_WRAP
  self.ptr->setClassWeights(*val.ptr);
  END_WRAP
}

CvStatus SVM_SetCoef0(SVM self, double val)
{
  BEGIN_WRAP
  self.ptr->setCoef0(val);
  END_WRAP
}

CvStatus SVM_SetDegree(SVM self, double val)
{
  BEGIN_WRAP
  self.ptr->setDegree(val);
  END_WRAP
}

CvStatus SVM_SetGamma(SVM self, double val)
{
  BEGIN_WRAP
  self.ptr->setGamma(val);
  END_WRAP
}

CvStatus SVM_SetKernel(SVM self, int kernelType)
{
  BEGIN_WRAP
  self.ptr->setKernel(kernelType);
  END_WRAP
}

CvStatus SVM_SetNu(SVM self, double val)
{
  BEGIN_WRAP
  self.ptr->setNu(val);
  END_WRAP
}

CvStatus SVM_SetP(SVM self, double val)
{
  BEGIN_WRAP
  self.ptr->setP(val);
  END_WRAP
}

CvStatus SVM_SetTermCriteria(SVM self, TermCriteria val)
{
  BEGIN_WRAP
  self.ptr->setTermCriteria(*val.ptr);
  END_WRAP
}

CvStatus SVM_SetType(SVM self, int val)
{
  BEGIN_WRAP
  self.ptr->setType(val);
  END_WRAP
}

CvStatus SVM_TrainAuto(SVM self, PtrTrainData data, int kFold, ParamGrid Cgrid, ParamGrid gammaGrid,
                       ParamGrid pGrid, ParamGrid nuGrid, ParamGrid coeffGrid, ParamGrid degreeGrid,
                       bool balanced, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->trainAuto(*data.ptr, kFold, *Cgrid.ptr, *gammaGrid.ptr, *pGrid.ptr, *nuGrid.ptr,
                              *coeffGrid.ptr, *degreeGrid.ptr, balanced);
  END_WRAP
}

CvStatus SVM_TrainAuto_1(SVM self, Mat samples, int layout, Mat responses, int kFold, PtrParamGrid Cgrid,
                         PtrParamGrid gammaGrid, PtrParamGrid pGrid, PtrParamGrid nuGrid,
                         PtrParamGrid coeffGrid, PtrParamGrid degreeGrid, bool balanced, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->trainAuto(*samples.ptr, layout, *responses.ptr, kFold, *Cgrid.ptr, *gammaGrid.ptr,
                              *pGrid.ptr, *nuGrid.ptr, *coeffGrid.ptr, *degreeGrid.ptr, balanced);
  END_WRAP
}

CvStatus SVM_CalcError(SVM self, PtrTrainData data, bool test, Mat resp, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->calcError(*data.ptr, test, *resp.ptr);
  END_WRAP
}

CvStatus SVM_Empty(SVM self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->empty();
  END_WRAP
}

CvStatus SVM_GetVarCount(SVM self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getVarCount();
  END_WRAP
}

CvStatus SVM_IsClassifier(SVM self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->isClassifier();
  END_WRAP
}

CvStatus SVM_IsTrained(SVM self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->isTrained();
  END_WRAP
}

CvStatus SVM_Predict(SVM self, Mat samples, Mat results, int flags, float *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->predict(*samples.ptr, *results.ptr, flags);
  END_WRAP
}

CvStatus SVM_Train(SVM self, PtrTrainData trainData, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*trainData.ptr, flags);
  END_WRAP
}

CvStatus SVM_Train_1(SVM self, Mat samples, int layout, Mat responses, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->train(*samples.ptr, layout, *responses.ptr);
  END_WRAP
}

CvStatus SVM_Clear(SVM self)
{
  BEGIN_WRAP
  self.ptr->clear();
  END_WRAP
}

CvStatus SVM_GetDefaultName(SVM self, char *rval)
{
  BEGIN_WRAP
  std::string name = self.ptr->getDefaultName();
  std::strcpy(rval, name.c_str());
  END_WRAP
}

CvStatus SVM_GetDefaultGrid(SVM self, int param_id, ParamGrid *rval)
{
  BEGIN_WRAP
  *rval = {new cv::ml::ParamGrid(self.ptr->getDefaultGrid(param_id))};
  END_WRAP
}

CvStatus SVM_GetDefaultGridPtr(SVM self, int param_id, PtrParamGrid *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::ParamGrid>(self.ptr->getDefaultGridPtr(param_id))};
  END_WRAP
}

CvStatus SVM_Save(SVM self, char *filename)
{
  BEGIN_WRAP
  self.ptr->save(filename);
  END_WRAP
}

CvStatus SVM_Load(SVM self, char *filepath)
{
  BEGIN_WRAP
  self.ptr = cv::ml::SVM::load(filepath);
  END_WRAP
}

CvStatus SVM_LoadFromString(SVM self, const char *strModel, const char *objname)
{
  BEGIN_WRAP
  self.ptr = cv::Algorithm::loadFromString<cv::ml::SVM>(strModel, objname);
  END_WRAP
}
