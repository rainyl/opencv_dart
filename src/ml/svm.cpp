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
void ParamGrid_Close(PtrParamGrid *self){CVD_FREE(self)}

CvStatus SVM_Create(PtrSVM *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ml::SVM>()};
  END_WRAP
}
void SVM_Close(PtrSVM *self){CVD_FREE(self)}

CvStatus SVM_Get(PtrSVM self, SVM *rval)
{
  BEGIN_WRAP
  *rval = {self.ptr->get()};
  END_WRAP
}
