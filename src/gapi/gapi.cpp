#include "gapi.h"

CvStatus GMat_New_Empty(GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat()};
  END_WRAP
}

/// not available in 4.9.0 stable
// CvStatus GMat_New_FromMat(Mat mat, GMat *rval)
// {
//   BEGIN_WRAP
//   *rval = {new cv::GMat(*mat.ptr)};
//   END_WRAP
// }

void GMat_Close(GMatPtr mat)
{
  delete mat->ptr;
  mat->ptr = nullptr;
}

CvStatus GScalar_New_Empty(GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar()};
  END_WRAP
}
CvStatus GScalar_New_FromScalar(Scalar scalar, GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar(cv::Scalar(scalar.val1, scalar.val2, scalar.val3, scalar.val4))};
  END_WRAP
}
CvStatus GScalar_New_FromDouble(double v0, GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar(cv::Scalar(v0))};
  END_WRAP
}
void GScalar_Close(GScalar *scalar)
{
  delete scalar->ptr;
  scalar->ptr = nullptr;
}
