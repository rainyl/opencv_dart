//
// Created by Rainyl.
// Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
//

#include "dartcv/gapi/gapi.h"
#include "dartcv/core/handle.hpp"

CvStatus *gapi_GMat_New_Empty(GMat *rval)
{
  BEGIN_WRAP
  CVD_SET(rval, new cv::GMat());
  END_WRAP
}

CvStatus *gapi_GMat_New_FromMat(Mat mat, GMat *rval)
{
    CVD_CHECK(mat);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GMat(CVDEREF(mat)));
  END_WRAP
}

void gapi_GMat_Close(GMatPtr mat) { CVD_FREE(mat); }

CvStatus *gapi_GScalar_New_Empty(GScalar *rval)
{
  BEGIN_WRAP
  CVD_SET(rval, new cv::GScalar());
  END_WRAP
}
CvStatus *gapi_GScalar_New_FromScalar(Scalar scalar, GScalar *rval)
{
  BEGIN_WRAP
  CVD_SET(rval, new cv::GScalar(cv::Scalar(scalar.val1, scalar.val2, scalar.val3, scalar.val4)));
  END_WRAP
}
CvStatus *gapi_GScalar_New_FromDouble(double v0, GScalar *rval)
{
  BEGIN_WRAP
  CVD_SET(rval, new cv::GScalar(cv::Scalar(v0)));
  END_WRAP
}
void gapi_GScalar_Close(GScalarPtr scalar) { CVD_FREE(scalar); }

CvStatus *gapi_GComputation_New(GMat in, GMat out, GComputation *rval)
{
    CVD_CHECK(in, out);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GComputation(CVDEREF(in), CVDEREF(out)));
  END_WRAP
}

CvStatus *gapi_GComputation_New_1(GMat in, GScalar out, GComputation *rval)
{
    CVD_CHECK(in, out);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GComputation(CVDEREF(in), CVDEREF(out)));
  END_WRAP
}

CvStatus *gapi_GComputation_New_2(GMat in1, GMat in2, GMat out, GComputation *rval)
{
    CVD_CHECK(in1, in2, out);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GComputation(CVDEREF(in1), CVDEREF(in2), CVDEREF(out)));
  END_WRAP
}

CvStatus *gapi_GComputation_New_3(GMat in1, GMat in2, GScalar out, GComputation *rval)
{
    CVD_CHECK(in1, in2, out);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GComputation(CVDEREF(in1), CVDEREF(in2), CVDEREF(out)));
  END_WRAP
}

void gapi_GComputation_Close(GComputationPtr self) { CVD_FREE(self); }

CvStatus *gapi_GComputation_apply(GComputation self, Mat in,
                                  CvCallback_1 callback /*TODO: GCompileArgs &&args={}*/)
{
  BEGIN_WRAP
  cv::Mat _out;
  (CVDEREF(self)).apply(CVDEREF(in), _out);
  callback(cvd::alloc_handle<Mat>(new cv::Mat(_out)));
  END_WRAP
}

CvStatus *gapi_GComputation_apply_1(GComputation self, Mat in, Scalar *out /*TODO: GCompileArgs &&args={}*/)
{
    CVD_CHECK(self, in);
  BEGIN_WRAP
  cv::Scalar _out;
  (CVDEREF(self)).apply(CVDEREF(in), _out);
  *out = {_out.val[0], _out.val[1], _out.val[2], _out.val[3]};
  END_WRAP
}

CvStatus *gapi_GComputation_apply_2(GComputation self, Mat in1, Mat in2,
                                    Mat *out /*TODO: GCompileArgs &&args={}*/)
{
    CVD_CHECK(self, in1, in2);
  BEGIN_WRAP
  cv::Mat _out;
  (CVDEREF(self)).apply(CVDEREF(in1), CVDEREF(in2), _out);
  CVD_SET(out, new cv::Mat(_out));
  END_WRAP
}

CvStatus *gapi_GComputation_apply_3(GComputation self, Mat in1, Mat in2,
                                    Scalar *out /*TODO: GCompileArgs &&args={}*/)
{
    CVD_CHECK(self, in1, in2);
  BEGIN_WRAP
  cv::Scalar _out;
  (CVDEREF(self)).apply(CVDEREF(in1), CVDEREF(in2), _out);
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
    CVD_CHECK(src1, src2);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GMat(cv::gapi::add(CVDEREF(src1), CVDEREF(src2), ddepth)));
  END_WRAP
}

CvStatus *gapi_addC(GMat src, GScalar c, int ddepth, GMat *rval)
{
    CVD_CHECK(src, c);
  BEGIN_WRAP
  CVD_SET(rval, new cv::GMat(cv::gapi::addC(CVDEREF(src), CVDEREF(c), ddepth)));
  END_WRAP
}
