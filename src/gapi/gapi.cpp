#include "gapi.h"
#include "core/types.h"

CvStatus *gapi_GMat_New_Empty(GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat()};
  END_WRAP
}

CvStatus *gapi_GMat_New_FromMat(Mat mat, GMat *rval)
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

CvStatus *gapi_GScalar_New_Empty(GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar()};
  END_WRAP
}
CvStatus *gapi_GScalar_New_FromScalar(Scalar scalar, GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar(cv::Scalar(scalar.val1, scalar.val2, scalar.val3, scalar.val4))};
  END_WRAP
}
CvStatus *gapi_GScalar_New_FromDouble(double v0, GScalar *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GScalar(cv::Scalar(v0))};
  END_WRAP
}
void gapi_GScalar_Close(GScalarPtr scalar)
{
  delete scalar->ptr;
  scalar->ptr = nullptr;
}

CvStatus *gapi_GComputation_New(GMat in, GMat out, GComputation *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GComputation(*in.ptr, *out.ptr)};
  END_WRAP
}

CvStatus *gapi_GComputation_New_1(GMat in, GScalar out, GComputation *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GComputation(*in.ptr, *out.ptr)};
  END_WRAP
}

CvStatus *gapi_GComputation_New_2(GMat in1, GMat in2, GMat out, GComputation *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GComputation(*in1.ptr, *in2.ptr, *out.ptr)};
  END_WRAP
}

CvStatus *gapi_GComputation_New_3(GMat in1, GMat in2, GScalar out, GComputation *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GComputation(*in1.ptr, *in2.ptr, *out.ptr)};
  END_WRAP
}

void gapi_GComputation_Close(GComputationPtr self) { CVD_FREE(self); }

CvStatus *gapi_GComputation_apply(GComputation self, Mat in,
                                  CvCallback_1 callback /*TODO: GCompileArgs &&args={}*/)
{
  BEGIN_WRAP
  cv::Mat _out;
  (*self.ptr).apply(*in.ptr, _out);
  callback(new Mat{new cv::Mat(_out)});
  END_WRAP
}

CvStatus *gapi_GComputation_apply_1(GComputation self, Mat in, Scalar *out /*TODO: GCompileArgs &&args={}*/)
{
  BEGIN_WRAP
  cv::Scalar _out;
  (*self.ptr).apply(*in.ptr, _out);
  *out = {_out.val[0], _out.val[1], _out.val[2], _out.val[3]};
  END_WRAP
}

CvStatus *gapi_GComputation_apply_2(GComputation self, Mat in1, Mat in2,
                                    Mat *out /*TODO: GCompileArgs &&args={}*/)
{
  BEGIN_WRAP
  cv::Mat _out;
  (*self.ptr).apply(*in1.ptr, *in2.ptr, _out);
  *out = {new cv::Mat(_out)};
  END_WRAP
}

CvStatus *gapi_GComputation_apply_3(GComputation self, Mat in1, Mat in2,
                                    Scalar *out /*TODO: GCompileArgs &&args={}*/)
{
  BEGIN_WRAP
  cv::Scalar _out;
  (*self.ptr).apply(*in1.ptr, *in2.ptr, _out);
  *out = {_out.val[0], _out.val[1], _out.val[2], _out.val[3]};
  END_WRAP
}

// CvStatus *VecGMat_NewFromVec(VecMat vec, VecGMat *rval)
// {
//   BEGIN_WRAP
//   auto v = std::vector<cv::GMat>(*vec.ptr);
//   *rval = {new};
//   END_WRAP
// }

CvStatus *gapi_add(GMat src1, GMat src2, int ddepth, GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat(cv::gapi::add(*src1.ptr, *src2.ptr, ddepth))};
  END_WRAP
}

CvStatus *gapi_addC(GMat src, GScalar c, int ddepth, GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat(cv::gapi::addC(*src.ptr, *c.ptr, ddepth))};
  END_WRAP
}
