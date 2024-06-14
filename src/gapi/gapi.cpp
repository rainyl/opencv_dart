#include "gapi.h"

CvStatus gapi_GMat_New_Empty(GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat()};
  END_WRAP
}

CvStatus gapi_GMat_New_FromMat(Mat mat, GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat(*mat.ptr)};
  END_WRAP
}

void gapi_GMat_Close(GMatPtr mat)
{
  delete mat->ptr;
  mat->ptr = nullptr;
}

CvStatus gapi_GScalar_New_Empty(GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar()};
  END_WRAP
}
CvStatus gapi_GScalar_New_FromScalar(Scalar scalar, GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar(cv::Scalar(scalar.val1, scalar.val2, scalar.val3, scalar.val4))};
  END_WRAP
}
CvStatus gapi_GScalar_New_FromDouble(double v0, GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar(cv::Scalar(v0))};
  END_WRAP
}
void gapi_GScalar_Close(GScalar *scalar)
{
  delete scalar->ptr;
  scalar->ptr = nullptr;
}
