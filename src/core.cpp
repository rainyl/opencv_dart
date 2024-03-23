/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "core.h"
#include <stdint.h>
#include <string.h>

// cv::noArray()
InputOutputArray noArray()
{
  return new cv::_InputOutputArray();
}

// Mat_New creates a new empty Mat
CvStatus Mat_New(Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat();
  END_WRAP
}

// Mat_NewWithSize creates a new Mat with a specific size dimension and number
// of channels.
CvStatus Mat_NewWithSize(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(rows, cols, type, 0.0);
  END_WRAP
}

// Mat_NewWithSizes creates a new Mat with specific dimension sizes and number
// of channels.
CvStatus Mat_NewWithSizes(IntVector sizes, int type, Mat *rval)
{
  BEGIN_WRAP
  std::vector<int> sizess;
  for (int i = 0; i < sizes.length; ++i) {
    sizess.push_back(sizes.val[i]);
  }
  *rval = new cv::Mat(sizess, type);
  END_WRAP
}

// Mat_NewFromScalar creates a new Mat from a Scalar. Intended to be used
// for Mat comparison operation such as InRange.
CvStatus Mat_NewFromScalar(const Scalar ar, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = new cv::Mat(1, 1, type, c);
  END_WRAP
}

// Mat_NewWithSizeFromScalar creates a new Mat from a Scalar with a specific
// size dimension and number of channels
CvStatus Mat_NewWithSizeFromScalar(const Scalar ar, int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = new cv::Mat(rows, cols, type, c);
  END_WRAP
}

CvStatus Mat_NewFromBytes(int rows, int cols, int type, ByteArray buf, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(rows, cols, type, buf.data);
  END_WRAP
}

// Mat_NewWithSizesFromScalar creates multidimensional Mat from a scalar
CvStatus Mat_NewWithSizesFromScalar(IntVector sizes, int type, Scalar ar, Mat *rval)
{
  BEGIN_WRAP
  std::vector<int> _sizes;
  for (int i = 0, *v = sizes.val; i < sizes.length; ++v, ++i) {
    _sizes.push_back(*v);
  }

  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = new cv::Mat(_sizes, type, c);
  END_WRAP
}

// Mat_NewWithSizesFromBytes creates multidimensional Mat from a bytes
CvStatus Mat_NewWithSizesFromBytes(IntVector sizes, int type, ByteArray buf, Mat *rval)
{
  BEGIN_WRAP
  std::vector<int> _sizes;
  for (int i = 0, *v = sizes.val; i < sizes.length; ++v, ++i) {
    _sizes.push_back(*v);
  }

  *rval = new cv::Mat(_sizes, type, buf.data);
  END_WRAP
}

CvStatus Mat_FromPtr(Mat m, int rows, int cols, int type, int prows, int pcols, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(rows, cols, type, m->ptr(prows, pcols));
  END_WRAP
}

// Mat_Close deletes an existing Mat
void Mat_Close(Mat m)
{
  delete m;
}

// Mat_Empty tests if a Mat is empty
CvStatus Mat_Empty(Mat m, bool *rval)
{
  BEGIN_WRAP
  *rval = m->empty();
  END_WRAP
}

// Mat_IsContinuous tests if a Mat is continuous
CvStatus Mat_IsContinuous(Mat m, bool *rval)
{
  BEGIN_WRAP
  *rval = m->isContinuous();
  END_WRAP
}

// Mat_Clone returns a clone of this Mat
CvStatus Mat_Clone(Mat m, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(m->clone());
  END_WRAP
}

// Mat_CopyTo copies this Mat to another Mat.
CvStatus Mat_CopyTo(Mat m, Mat dst)
{
  BEGIN_WRAP
  m->copyTo(*dst);
  END_WRAP
}

// Mat_CopyToWithMask copies this Mat to another Mat while applying the mask
CvStatus Mat_CopyToWithMask(Mat m, Mat dst, Mat mask)
{
  BEGIN_WRAP
  m->copyTo(*dst, *mask);
  END_WRAP
}

CvStatus Mat_ConvertTo(Mat m, Mat dst, int type)
{
  BEGIN_WRAP
  m->convertTo(*dst, type);
  END_WRAP
}

CvStatus Mat_ConvertToWithParams(Mat m, Mat dst, int type, float alpha,
                                 float beta)
{
  BEGIN_WRAP
  m->convertTo(*dst, type, alpha, beta);
  END_WRAP
}

// Mat_ToBytes returns the bytes representation of the underlying data.
CvStatus Mat_ToBytes(Mat m, ByteArray *rval)
{
  BEGIN_WRAP
  *rval = toByteArray(reinterpret_cast<const char *>(m->data),
                      m->total() * m->elemSize());
  END_WRAP
}

CvStatus Mat_DataPtr(Mat m, ByteArray *rval)
{
  BEGIN_WRAP
  *rval = ByteArray{reinterpret_cast<char *>(m->data),
                    static_cast<int>(m->total() * m->elemSize())};
  END_WRAP
}

// Mat_Region returns a Mat of a region of another Mat
CvStatus Mat_Region(Mat m, Rect r, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(*m, cv::Rect(r.x, r.y, r.width, r.height));
  END_WRAP
}

CvStatus Mat_Reshape(Mat m, int cn, int rows, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(m->reshape(cn, rows));
  END_WRAP
}

CvStatus Mat_PatchNaNs(Mat m, double val)
{
  BEGIN_WRAP
  cv::patchNaNs(*m, val);
  END_WRAP
}

CvStatus Mat_ConvertFp16(Mat m, Mat *rval)
{
  BEGIN_WRAP
  Mat dst = new cv::Mat();
  cv::convertFp16(*m, *dst);
  *rval = dst;
  END_WRAP
}

CvStatus Mat_Sqrt(Mat m, Mat *rval)
{
  BEGIN_WRAP
  Mat dst = new cv::Mat();
  cv::sqrt(*m, *dst);
  *rval = dst;
  END_WRAP
}

// Mat_Mean calculates the mean value M of array elements, independently for
// each channel, and return it as Scalar vector
CvStatus Mat_Mean(Mat m, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*m);
  Scalar     scal = Scalar();
  scal.val1 = c.val[0];
  scal.val2 = c.val[1];
  scal.val3 = c.val[2];
  scal.val4 = c.val[3];
  *rval = scal;
  END_WRAP
}

// Mat_MeanWithMask calculates the mean value M of array elements,
// independently for each channel, and returns it as Scalar vector
// while applying the mask.

CvStatus Mat_MeanWithMask(Mat m, Mat mask, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*m, *mask);
  Scalar     scal = Scalar();
  scal.val1 = c.val[0];
  scal.val2 = c.val[1];
  scal.val3 = c.val[2];
  scal.val4 = c.val[3];
  *rval = scal;
  END_WRAP
}

// Mat_Rows returns how many rows in this Mat.
CvStatus Mat_Rows(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->rows;
  END_WRAP
}

// Mat_Cols returns how many columns in this Mat.
CvStatus Mat_Cols(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->cols;
  END_WRAP
}

// Mat_Channels returns how many channels in this Mat.
CvStatus Mat_Channels(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->channels();
  END_WRAP
}

// Mat_Type returns the type from this Mat.
CvStatus Mat_Type(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->type();
  END_WRAP
}

// Mat_Step returns the number of bytes each matrix row occupies.
CvStatus Mat_Step(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->step;
  END_WRAP
}

CvStatus Mat_Total(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->total();
  END_WRAP
}

CvStatus Mat_ElemSize(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->elemSize();
  END_WRAP
}

CvStatus Eye(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Mat *mat = new cv::Mat(rows, cols, type);
  *mat = cv::Mat::eye(rows, cols, type);
  *rval = mat;
  END_WRAP
}

CvStatus Zeros(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Mat *mat = new cv::Mat(rows, cols, type);
  *mat = cv::Mat::zeros(rows, cols, type);
  *rval = mat;
  END_WRAP
}

CvStatus Ones(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Mat *mat = new cv::Mat(rows, cols, type);
  *mat = cv::Mat::ones(rows, cols, type);
  *rval = mat;
  END_WRAP
}

// Mat_GetUChar returns a specific row/col value from this Mat expecting
// each element to contain a schar aka CV_8U.
CvStatus Mat_GetUChar(Mat m, int row, int col, uint8_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<uchar>(row, col);
  END_WRAP
}

CvStatus Mat_GetUChar3(Mat m, int x, int y, int z, uint8_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<uchar>(x, y, z);
  END_WRAP
}

// Mat_GetSChar returns a specific row/col value from this Mat expecting
// each element to contain a schar aka CV_8S.
CvStatus Mat_GetSChar(Mat m, int row, int col, int8_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<schar>(row, col);
  END_WRAP
}

CvStatus Mat_GetSChar3(Mat m, int x, int y, int z, int8_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<schar>(x, y, z);
  END_WRAP
}

// Mat_GetUShort returns a specific row/col value from this Mat expecting
// each element to contain a short aka CV_16U.
CvStatus Mat_GetUShort(Mat m, int row, int col, uint16_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<ushort>(row, col);
  END_WRAP
}

CvStatus Mat_GetUShort3(Mat m, int x, int y, int z, uint16_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<ushort>(x, y, z);
  END_WRAP
}

// Mat_GetShort returns a specific row/col value from this Mat expecting
// each element to contain a short aka CV_16S.
CvStatus Mat_GetShort(Mat m, int row, int col, int16_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<short>(row, col);
  END_WRAP
}

CvStatus Mat_GetShort3(Mat m, int x, int y, int z, int16_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<short>(x, y, z);
  END_WRAP
}

// Mat_GetInt returns a specific row/col value from this Mat expecting
// each element to contain an int aka CV_32S.
CvStatus Mat_GetInt(Mat m, int row, int col, int32_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<int>(row, col);
  END_WRAP
}

CvStatus Mat_GetInt3(Mat m, int x, int y, int z, int32_t *rval)
{
  BEGIN_WRAP
  *rval = m->at<int>(x, y, z);
  END_WRAP
}

// Mat_GetFloat returns a specific row/col value from this Mat expecting
// each element to contain a float aka CV_32F.
CvStatus Mat_GetFloat(Mat m, int row, int col, float *rval)
{
  BEGIN_WRAP
  *rval = m->at<float>(row, col);
  END_WRAP
}

CvStatus Mat_GetFloat3(Mat m, int x, int y, int z, float *rval)
{
  BEGIN_WRAP
  *rval = m->at<float>(x, y, z);
  END_WRAP
}

// Mat_GetDouble returns a specific row/col value from this Mat expecting
// each element to contain a double aka CV_64F.
CvStatus Mat_GetDouble(Mat m, int row, int col, double *rval)
{
  BEGIN_WRAP
  *rval = m->at<double>(row, col);
  END_WRAP
}

CvStatus Mat_GetDouble3(Mat m, int x, int y, int z, double *rval)
{
  BEGIN_WRAP
  *rval = m->at<double>(x, y, z);
  END_WRAP
}

CvStatus Mat_SetTo(Mat m, Scalar value)
{
  BEGIN_WRAP
  cv::Scalar c_value(value.val1, value.val2, value.val3, value.val4);
  m->setTo(c_value);
  END_WRAP
}

// Mat_SetUChar set a specific row/col value from this Mat expecting
// each element to contain a schar aka CV_8U.
CvStatus Mat_SetUChar(Mat m, int row, int col, uint8_t val)
{
  BEGIN_WRAP
  m->at<uchar>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetUChar3(Mat m, int x, int y, int z, uint8_t val)
{
  BEGIN_WRAP
  m->at<uchar>(x, y, z) = val;
  END_WRAP
}

// Mat_SetSChar set a specific row/col value from this Mat expecting
// each element to contain a schar aka CV_8S.
CvStatus Mat_SetSChar(Mat m, int row, int col, int8_t val)
{
  BEGIN_WRAP
  m->at<schar>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetSChar3(Mat m, int x, int y, int z, int8_t val)
{
  BEGIN_WRAP
  m->at<schar>(x, y, z) = val;
  END_WRAP
}

// Mat_SetShort set a specific row/col value from this Mat expecting
// each element to contain a short aka CV_16S.
CvStatus Mat_SetShort(Mat m, int row, int col, int16_t val)
{
  BEGIN_WRAP
  m->at<short>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetShort3(Mat m, int x, int y, int z, int16_t val)
{
  BEGIN_WRAP
  m->at<short>(x, y, z) = val;
  END_WRAP
}

CvStatus Mat_SetUShort(Mat m, int row, int col, uint16_t val)
{
  BEGIN_WRAP
  m->at<ushort>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetUShort3(Mat m, int x, int y, int z, uint16_t val)
{
  BEGIN_WRAP
  m->at<ushort>(x, y, z) = val;
  END_WRAP
}

// Mat_SetInt set a specific row/col value from this Mat expecting
// each element to contain an int aka CV_32S.
CvStatus Mat_SetInt(Mat m, int row, int col, int32_t val)
{
  BEGIN_WRAP
  m->at<int>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetInt3(Mat m, int x, int y, int z, int32_t val)
{
  BEGIN_WRAP
  m->at<int>(x, y, z) = val;
  END_WRAP
}

// Mat_SetFloat set a specific row/col value from this Mat expecting
// each element to contain a float aka CV_32F.
CvStatus Mat_SetFloat(Mat m, int row, int col, float val)
{
  BEGIN_WRAP
  m->at<float>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetFloat3(Mat m, int x, int y, int z, float val)
{
  BEGIN_WRAP
  m->at<float>(x, y, z) = val;
  END_WRAP
}

// Mat_SetDouble set a specific row/col value from this Mat expecting
// each element to contain a double aka CV_64F.
CvStatus Mat_SetDouble(Mat m, int row, int col, double val)
{
  BEGIN_WRAP
  m->at<double>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetDouble3(Mat m, int x, int y, int z, double val)
{
  BEGIN_WRAP
  m->at<double>(x, y, z) = val;
  END_WRAP
}

CvStatus Mat_AddUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m += val;
  END_WRAP
}

CvStatus Mat_SubtractUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m -= val;
  END_WRAP
}

CvStatus Mat_MultiplyUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m *= val;
  END_WRAP
}

CvStatus Mat_DivideUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m /= val;
  END_WRAP
}

CvStatus Mat_AddI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m += val;
  END_WRAP
}

CvStatus Mat_SubtractI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m -= val;
  END_WRAP
}

CvStatus Mat_MultiplyI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m *= val;
  END_WRAP
}

CvStatus Mat_DivideI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m /= val;
  END_WRAP
}

CvStatus Mat_AddFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m += val;
  END_WRAP
}

CvStatus Mat_SubtractFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m -= val;
  END_WRAP
}

CvStatus Mat_MultiplyFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m *= val;
  END_WRAP
}

CvStatus Mat_DivideFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m /= val;
  END_WRAP
}

CvStatus Mat_AddF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m += val;
  END_WRAP
}

CvStatus Mat_SubtractF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m -= val;
  END_WRAP
}

CvStatus Mat_MultiplyF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m *= val;
  END_WRAP
}

CvStatus Mat_DivideF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m /= val;
  END_WRAP
}

CvStatus Mat_MultiplyMatrix(Mat x, Mat y, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat((*x) * (*y));
  END_WRAP
}

CvStatus Mat_T(Mat x, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(x->t());
  END_WRAP
}

CvStatus LUT(Mat src, Mat lut, Mat dst)
{
  BEGIN_WRAP
  cv::LUT(*src, *lut, *dst);
  END_WRAP
}

CvStatus Mat_AbsDiff(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::absdiff(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_Add(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::add(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_AddWeighted(Mat src1, double alpha, Mat src2, double beta,
                         double gamma, Mat dst)
{
  BEGIN_WRAP
  cv::addWeighted(*src1, alpha, *src2, beta, gamma, *dst);
  END_WRAP
}

CvStatus Mat_BitwiseAnd(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_and(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_BitwiseAndWithMask(Mat src1, Mat src2, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_and(*src1, *src2, *dst, *mask);
  END_WRAP
}

CvStatus Mat_BitwiseNot(Mat src1, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_not(*src1, *dst);
  END_WRAP
}

CvStatus Mat_BitwiseNotWithMask(Mat src1, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_not(*src1, *dst, *mask);
  END_WRAP
}

CvStatus Mat_BitwiseOr(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_or(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_BitwiseOrWithMask(Mat src1, Mat src2, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_or(*src1, *src2, *dst, *mask);
  END_WRAP
}

CvStatus Mat_BitwiseXor(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_xor(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_BitwiseXorWithMask(Mat src1, Mat src2, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_xor(*src1, *src2, *dst, *mask);
  END_WRAP
}

CvStatus Mat_BatchDistance(Mat src1, Mat src2, Mat dist, int dtype, Mat nidx,
                           int normType, int K, Mat mask, int update,
                           bool crosscheck)
{
  BEGIN_WRAP
  cv::batchDistance(*src1, *src2, *dist, dtype, *nidx, normType, K, *mask,
                    update, crosscheck);
  END_WRAP
}

CvStatus Mat_BorderInterpolate(int p, int len, int borderType, int *rval)
{
  BEGIN_WRAP
  *rval = cv::borderInterpolate(p, len, borderType);
  END_WRAP
}

CvStatus Mat_CalcCovarMatrix(Mat samples, Mat covar, Mat mean, int flags,
                             int ctype)
{
  BEGIN_WRAP
  cv::calcCovarMatrix(*samples, *covar, *mean, flags, ctype);
  END_WRAP
}

CvStatus Mat_CartToPolar(Mat x, Mat y, Mat magnitude, Mat angle,
                         bool angleInDegrees)
{
  BEGIN_WRAP
  cv::cartToPolar(*x, *y, *magnitude, *angle, angleInDegrees);
  END_WRAP
}

CvStatus Mat_CheckRange(Mat m, bool quiet, Point *pos, double minVal,
                        double maxVal, bool *rval)
{
  BEGIN_WRAP
  cv::Point pos1;
  *rval = cv::checkRange(*m, quiet, &pos1, minVal, maxVal);
  pos->x = pos1.x;
  pos->y = pos1.y;
  END_WRAP
}

CvStatus Mat_Compare(Mat src1, Mat src2, Mat dst, int ct)
{
  BEGIN_WRAP
  cv::compare(*src1, *src2, *dst, ct);
  END_WRAP
}

CvStatus Mat_CompleteSymm(Mat m, bool lowerToUpper)
{
  BEGIN_WRAP
  cv::completeSymm(*m, lowerToUpper);
  END_WRAP
}

CvStatus Mat_ConvertScaleAbs(Mat src, Mat dst, double alpha, double beta)
{
  BEGIN_WRAP
  cv::convertScaleAbs(*src, *dst, alpha, beta);
  END_WRAP
}

CvStatus Mat_CopyMakeBorder(Mat src, Mat dst, int top, int bottom, int left,
                            int right, int borderType, Scalar value)
{
  BEGIN_WRAP
  cv::Scalar c_value(value.val1, value.val2, value.val3, value.val4);
  cv::copyMakeBorder(*src, *dst, top, bottom, left, right, borderType, c_value);
  END_WRAP
}

CvStatus Mat_CountNonZero(Mat src, int *rval)
{
  BEGIN_WRAP
  *rval = cv::countNonZero(*src);
  END_WRAP
}

CvStatus Mat_DCT(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::dct(*src, *dst, flags);
  END_WRAP
}

CvStatus Mat_Determinant(Mat m, double *rval)
{
  BEGIN_WRAP
  *rval = cv::determinant(*m);
  END_WRAP
}

CvStatus Mat_DFT(Mat m, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::dft(*m, *dst, flags);
  END_WRAP
}

CvStatus Mat_Divide(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::divide(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_Eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::eigen(*src, *eigenvalues, *eigenvectors);
  END_WRAP
}

CvStatus Mat_EigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors)
{
  BEGIN_WRAP
  cv::eigenNonSymmetric(*src, *eigenvalues, *eigenvectors);
  END_WRAP
}

CvStatus Mat_PCACompute(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues,
                        int maxComponents)
{
  BEGIN_WRAP
  cv::PCACompute(*src, *mean, *eigenvectors, *eigenvalues, maxComponents);
  END_WRAP
}

CvStatus Mat_Exp(Mat src, Mat dst)
{
  BEGIN_WRAP
  cv::exp(*src, *dst);
  END_WRAP
}

CvStatus Mat_ExtractChannel(Mat src, Mat dst, int coi)
{
  BEGIN_WRAP
  cv::extractChannel(*src, *dst, coi);
  END_WRAP
}

CvStatus Mat_FindNonZero(Mat src, Mat idx)
{
  BEGIN_WRAP
  cv::findNonZero(*src, *idx);
  END_WRAP
}

CvStatus Mat_Flip(Mat src, Mat dst, int flipCode)
{
  BEGIN_WRAP
  cv::flip(*src, *dst, flipCode);
  END_WRAP
}

CvStatus Mat_Gemm(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst,
                  int flags)
{
  BEGIN_WRAP
  cv::gemm(*src1, *src2, alpha, *src3, beta, *dst, flags);
  END_WRAP
}

CvStatus Mat_GetOptimalDFTSize(int vecsize, int *rval)
{
  BEGIN_WRAP
  *rval = cv::getOptimalDFTSize(vecsize);
  END_WRAP
}

CvStatus Mat_Hconcat(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::hconcat(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_Vconcat(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::vconcat(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Rotate(Mat src, Mat dst, int rotateCode)
{
  BEGIN_WRAP
  cv::rotate(*src, *dst, rotateCode);
  END_WRAP
}

CvStatus Mat_Idct(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::idct(*src, *dst, flags);
  END_WRAP
}

CvStatus Mat_Idft(Mat src, Mat dst, int flags, int nonzeroRows)
{
  BEGIN_WRAP
  cv::idft(*src, *dst, flags, nonzeroRows);
  END_WRAP
}

CvStatus Mat_InRange(Mat src, Mat lowerb, Mat upperb, Mat dst)
{
  BEGIN_WRAP
  cv::inRange(*src, *lowerb, *upperb, *dst);
  END_WRAP
}

CvStatus Mat_InRangeWithScalar(Mat src, Scalar lowerb, Scalar upperb, Mat dst)
{
  BEGIN_WRAP
  cv::Scalar lb =
      cv::Scalar(lowerb.val1, lowerb.val2, lowerb.val3, lowerb.val4);
  cv::Scalar ub =
      cv::Scalar(upperb.val1, upperb.val2, upperb.val3, upperb.val4);
  cv::inRange(*src, lb, ub, *dst);
  END_WRAP
}

CvStatus Mat_InsertChannel(Mat src, Mat dst, int coi)
{
  BEGIN_WRAP
  cv::insertChannel(*src, *dst, coi);
  END_WRAP
}

CvStatus Mat_Invert(Mat src, Mat dst, int flags, double *rval)
{
  BEGIN_WRAP
  *rval = cv::invert(*src, *dst, flags);
  END_WRAP
}

CvStatus KMeans(Mat data, int k, Mat bestLabels, TermCriteria criteria,
                int attempts, int flags, Mat centers, double *rval)
{
  BEGIN_WRAP
  END_WRAP
  *rval = cv::kmeans(*data, k, *bestLabels, *criteria, attempts, flags, *centers);
}

CvStatus KMeansPoints(PointVector points, int k, Mat bestLabels,
                      TermCriteria criteria, int attempts, int flags,
                      Mat centers, double *rval)
{
  BEGIN_WRAP
  std::vector<cv::Point2f> pts;
  copyPointVectorToPoint2fVector(points, &pts);
  *rval =
      cv::kmeans(pts, k, *bestLabels, *criteria, attempts, flags, *centers);
  END_WRAP
}

CvStatus Mat_Log(Mat src, Mat dst)
{
  BEGIN_WRAP
  cv::log(*src, *dst);
  END_WRAP
}

CvStatus Mat_Magnitude(Mat x, Mat y, Mat magnitude)
{
  BEGIN_WRAP
  cv::magnitude(*x, *y, *magnitude);
  END_WRAP
}

CvStatus Mat_Max(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::max(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_MeanStdDev(Mat src, Mat dstMean, Mat dstStdDev)
{
  BEGIN_WRAP
  cv::meanStdDev(*src, *dstMean, *dstStdDev);
  END_WRAP
}

CvStatus Mat_Merge(Mats mats, Mat dst)
{
  BEGIN_WRAP
  std::vector<cv::Mat> images;

  for (int i = 0; i < mats.length; ++i) {
    images.push_back(*mats.mats[i]);
  }

  cv::merge(images, *dst);
  END_WRAP
}

CvStatus Mat_Min(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::min(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_MinMaxIdx(Mat m, double *minVal, double *maxVal, int *minIdx,
                       int *maxIdx)
{
  BEGIN_WRAP
  cv::minMaxIdx(*m, minVal, maxVal, minIdx, maxIdx);
  END_WRAP
}

CvStatus Mat_MinMaxLoc(Mat m, double *minVal, double *maxVal, Point *minLoc,
                       Point *maxLoc)
{
  BEGIN_WRAP
  cv::Point cMinLoc;
  cv::Point cMaxLoc;
  cv::minMaxLoc(*m, minVal, maxVal, &cMinLoc, &cMaxLoc);

  minLoc->x = cMinLoc.x;
  minLoc->y = cMinLoc.y;
  maxLoc->x = cMaxLoc.x;
  maxLoc->y = cMaxLoc.y;
  END_WRAP
}

CvStatus Mat_MixChannels(Mats src, Mats dst, IntVector fromTo)
{
  BEGIN_WRAP
  std::vector<cv::Mat> srcMats;

  for (int i = 0; i < src.length; ++i) {
    srcMats.push_back(*src.mats[i]);
  }

  std::vector<cv::Mat> dstMats;

  for (int i = 0; i < dst.length; ++i) {
    dstMats.push_back(*dst.mats[i]);
  }

  std::vector<int> fromTos;

  for (int i = 0; i < fromTo.length; ++i) {
    fromTos.push_back(fromTo.val[i]);
  }

  cv::mixChannels(srcMats, dstMats, fromTos);
  END_WRAP
}

CvStatus Mat_MulSpectrums(Mat a, Mat b, Mat c, int flags)
{
  BEGIN_WRAP
  cv::mulSpectrums(*a, *b, *c, flags);
  END_WRAP
}

CvStatus Mat_Multiply(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::multiply(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_MultiplyWithParams(Mat src1, Mat src2, Mat dst, double scale,
                                int dtype)
{
  BEGIN_WRAP
  cv::multiply(*src1, *src2, *dst, scale, dtype);
  END_WRAP
}

CvStatus Mat_Normalize(Mat src, Mat dst, double alpha, double beta, int typ)
{
  BEGIN_WRAP
  cv::normalize(*src, *dst, alpha, beta, typ);
  END_WRAP
}

CvStatus Norm(Mat src1, int normType, double *rval)
{
  BEGIN_WRAP
  *rval = cv::norm(*src1, normType);
  END_WRAP
}

CvStatus NormWithMats(Mat src1, Mat src2, int normType, double *rval)
{
  BEGIN_WRAP
  *rval = cv::norm(*src1, *src2, normType);
  END_WRAP
}

CvStatus Mat_PerspectiveTransform(Mat src, Mat dst, Mat tm)
{
  BEGIN_WRAP
  cv::perspectiveTransform(*src, *dst, *tm);
  END_WRAP
}

CvStatus Mat_Solve(Mat src1, Mat src2, Mat dst, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::solve(*src1, *src2, *dst, flags);
  END_WRAP
}

CvStatus Mat_SolveCubic(Mat coeffs, Mat roots, int *rval)
{
  BEGIN_WRAP
  *rval = cv::solveCubic(*coeffs, *roots);
  END_WRAP
}

CvStatus Mat_SolvePoly(Mat coeffs, Mat roots, int maxIters, double *rval)
{
  BEGIN_WRAP
  *rval = cv::solvePoly(*coeffs, *roots, maxIters);
  END_WRAP
}

CvStatus Mat_Reduce(Mat src, Mat dst, int dim, int rType, int dType)
{
  BEGIN_WRAP
  cv::reduce(*src, *dst, dim, rType, dType);
  END_WRAP
}

CvStatus Mat_ReduceArgMax(Mat src, Mat dst, int axis, bool lastIndex)
{
  BEGIN_WRAP
  cv::reduceArgMax(*src, *dst, axis, lastIndex);
  END_WRAP
}

CvStatus Mat_ReduceArgMin(Mat src, Mat dst, int axis, bool lastIndex)
{
  BEGIN_WRAP
  cv::reduceArgMin(*src, *dst, axis, lastIndex);
  END_WRAP
}

CvStatus Mat_Repeat(Mat src, int nY, int nX, Mat dst)
{
  BEGIN_WRAP
  cv::repeat(*src, nY, nX, *dst);
  END_WRAP
}

CvStatus Mat_ScaleAdd(Mat src1, double alpha, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::scaleAdd(*src1, alpha, *src2, *dst);
  END_WRAP
}

CvStatus Mat_SetIdentity(Mat src, double scalar)
{
  BEGIN_WRAP
  cv::setIdentity(*src, scalar);
  END_WRAP
}

CvStatus Mat_Sort(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::sort(*src, *dst, flags);
  END_WRAP
}

CvStatus Mat_SortIdx(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::sortIdx(*src, *dst, flags);
  END_WRAP
}

CvStatus Mat_Split(Mat src, Mats *mats)
{
  BEGIN_WRAP
  std::vector<cv::Mat> channels;
  cv::split(*src, channels);
  mats->mats = new Mat[channels.size()];

  for (size_t i = 0; i < channels.size(); ++i) {
    mats->mats[i] = new cv::Mat(channels[i]);
  }

  mats->length = (int)channels.size();
  END_WRAP
}

CvStatus Mat_Subtract(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::subtract(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_Trace(Mat src, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::trace(*src);
  Scalar     scal = Scalar();
  scal.val1 = c.val[0];
  scal.val2 = c.val[1];
  scal.val3 = c.val[2];
  scal.val4 = c.val[3];
  *rval = scal;
  END_WRAP
}

CvStatus Mat_Transform(Mat src, Mat dst, Mat tm)
{
  BEGIN_WRAP
  cv::transform(*src, *dst, *tm);
  END_WRAP
}

CvStatus Mat_Transpose(Mat src, Mat dst)
{
  BEGIN_WRAP
  cv::transpose(*src, *dst);
  END_WRAP
}

CvStatus Mat_PolarToCart(Mat magnitude, Mat degree, Mat x, Mat y,
                         bool angleInDegrees)
{
  BEGIN_WRAP
  cv::polarToCart(*magnitude, *degree, *x, *y, angleInDegrees);
  END_WRAP
}

CvStatus Mat_Pow(Mat src, double power, Mat dst)
{
  BEGIN_WRAP
  cv::pow(*src, power, *dst);
  END_WRAP
}

CvStatus Mat_Phase(Mat x, Mat y, Mat angle, bool angleInDegrees)
{
  BEGIN_WRAP
  cv::phase(*x, *y, *angle, angleInDegrees);
  END_WRAP
}

CvStatus Mat_Sum(Mat src, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::sum(*src);
  Scalar     scal = Scalar();
  scal.val1 = c.val[0];
  scal.val2 = c.val[1];
  scal.val3 = c.val[2];
  scal.val4 = c.val[3];
  *rval = scal;
  END_WRAP
}

// TermCriteria_New creates a new TermCriteria
TermCriteria TermCriteria_New(int typ, int maxCount, double epsilon)
{
  return new cv::TermCriteria(typ, maxCount, epsilon);
}

void Contours_Close(Contours cs)
{
  for (int i = 0; i < cs.length; i++) {
    Points_Close(cs.contours[i]);
  }

  delete[] cs.contours;
}

void CStrings_Close(CStrings cstrs)
{
  for (int i = 0; i < cstrs.length; i++) {
    delete[] cstrs.strs[i];
  }
  delete[] cstrs.strs;
}

void KeyPoints_Close(KeyPoints ks)
{
  delete[] ks.keypoints;
}

void Points_Close(Points ps)
{
  for (size_t i = 0; i < ps.length; i++) {
    Point_Close(ps.points[i]);
  }

  delete[] ps.points;
}

void Point_Close(Point p)
{
}

void Point2f_Close(Point2f p)
{
}

void Point3f_Close(Point3f p)
{
}

void Rects_Close(Rects rs)
{
  delete[] rs.rects;
}

void DMatches_Close(DMatches ds)
{
  delete[] ds.dmatches;
}

void MultiDMatches_Close(MultiDMatches mds)
{
  for (size_t i = 0; i < mds.length; i++) {
    DMatches_Close(mds.dmatches[i]);
  }

  delete[] mds.dmatches;
}

CvStatus MultiDMatches_get(MultiDMatches mds, int index, DMatches *rval)
{
  BEGIN_WRAP
  *rval = mds.dmatches[index];
  END_WRAP
}

// since it is next to impossible to iterate over mats.mats on the cgo side
CvStatus Mats_get(Mats mats, int i, Mat *rval)
{
  BEGIN_WRAP
  *rval = mats.mats[i];
  END_WRAP
}

void Mats_Close(Mats mats)
{
  delete[] mats.mats;
}

void ByteArray_Release(ByteArray buf)
{
  delete[] buf.data;
}

ByteArray toByteArray(const char *buf, int len)
{
  ByteArray ret = {new char[len], len};
  memcpy(ret.data, buf, len);
  return ret;
}

int64 GetCVTickCount()
{
  return cv::getTickCount();
}

double GetTickFrequency()
{
  return cv::getTickFrequency();
}

Mat Mat_rowRange(Mat m, int startrow, int endrow)
{
  return new cv::Mat(m->rowRange(startrow, endrow));
}

Mat Mat_colRange(Mat m, int startrow, int endrow)
{
  return new cv::Mat(m->colRange(startrow, endrow));
}

PointVector PointVector_New()
{
  return new std::vector<cv::Point>;
}

PointVector PointVector_NewFromPoints(Contour points)
{
  std::vector<cv::Point> *cntr = new std::vector<cv::Point>;

  for (size_t i = 0; i < points.length; i++) {
    cntr->push_back(cv::Point(points.points[i].x, points.points[i].y));
  }

  return cntr;
}

PointVector PointVector_NewFromMat(Mat mat)
{
  std::vector<cv::Point> *pts = new std::vector<cv::Point>;
  *pts = (std::vector<cv::Point>)*mat;
  return pts;
}

Point PointVector_At(PointVector pv, int idx)
{
  cv::Point p = pv->at(idx);
  return Point{.x = p.x, .y = p.y};
}

void PointVector_Append(PointVector pv, Point p)
{
  pv->push_back(cv::Point(p.x, p.y));
}

int PointVector_Size(PointVector p)
{
  return p->size();
}

void PointVector_Close(PointVector p)
{
  p->clear();
  delete p;
}

PointsVector PointsVector_New()
{
  return new std::vector<std::vector<cv::Point>>;
}

PointsVector PointsVector_NewFromPoints(Contours points)
{
  std::vector<std::vector<cv::Point>> *pv =
      new std::vector<std::vector<cv::Point>>;

  for (size_t i = 0; i < points.length; i++) {
    Contour contour = points.contours[i];

    std::vector<cv::Point> cntr;

    for (size_t i = 0; i < contour.length; i++) {
      cntr.push_back(cv::Point(contour.points[i].x, contour.points[i].y));
    }

    pv->push_back(cntr);
  }

  return pv;
}

int PointsVector_Size(PointsVector ps)
{
  return ps->size();
}

PointVector PointsVector_At(PointsVector ps, int idx)
{
  std::vector<cv::Point> *p = &(ps->at(idx));
  return p;
}

void PointsVector_Append(PointsVector psv, PointVector pv)
{
  psv->push_back(*pv);
}

void PointsVector_Close(PointsVector ps)
{
  ps->clear();
  delete ps;
}

Point2fVector Point2fVector_New()
{
  return new std::vector<cv::Point2f>;
}

Point2fVector Point2fVector_NewFromPoints(Contour2f points)
{
  std::vector<cv::Point2f> *cntr = new std::vector<cv::Point2f>;

  for (size_t i = 0; i < points.length; i++) {
    cntr->push_back(cv::Point2f(points.points[i].x, points.points[i].y));
  }

  return cntr;
}

Point2fVector Point2fVector_NewFromMat(Mat mat)
{
  std::vector<cv::Point2f> *pts = new std::vector<cv::Point2f>;
  *pts = (std::vector<cv::Point2f>)*mat;
  return pts;
}

Point2f Point2fVector_At(Point2fVector pfv, int idx)
{
  cv::Point2f p = pfv->at(idx);
  return Point2f{.x = p.x, .y = p.y};
}

int Point2fVector_Size(Point2fVector pfv)
{
  return pfv->size();
}

void Point2fVector_Close(Point2fVector pv)
{
  pv->clear();
  delete pv;
}

// IntVector* IntVector_New(){
//     auto vec = new std::vector<int>();
//     return new IntVector {.val=vec->data(), .length=(int)vec->size()};
// }

void IntVector_Close(IntVector ivec)
{
  delete[] ivec.val;
}

// FloatVector* FloatVector_New(){
//     auto vec = new std::vector<float>();
//     return new FloatVector {.val=vec->data(), .length=(int)vec->size()};
// }

void FloatVector_Close(FloatVector fvec)
{
  delete[] fvec.val;
}

RNG Rng_New()
{
  return new cv::RNG();
}

RNG Rng_NewWithState(uint64_t state)
{
  return new cv::RNG(state);
}

void Rng_Close(RNG rng)
{
  delete rng;
}

RNG TheRNG()
{
  return &cv::theRNG();
}

void SetRNGSeed(int seed)
{
  cv::setRNGSeed(seed);
}

void RNG_Fill(RNG rng, Mat mat, int distType, double a, double b,
              bool saturateRange)
{
  rng->fill(*mat, distType, a, b, saturateRange);
}

double RNG_Gaussian(RNG rng, double sigma)
{
  return rng->gaussian(sigma);
}

int RNG_Uniform(RNG rng, int a, int b)
{
  return rng->uniform(a, b);
}

double RNG_UniformDouble(RNG rng, double a, double b)
{
  return rng->uniform(a, b);
}

unsigned int RNG_Next(RNG rng)
{
  return rng->next();
}

void RandN(Mat mat, Scalar mean, Scalar stddev)
{
  cv::Scalar m = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
  cv::Scalar s = cv::Scalar(stddev.val1, stddev.val2, stddev.val3, stddev.val4);
  cv::randn(*mat, m, s);
}

void RandShuffle(Mat mat)
{
  cv::randShuffle(*mat);
}

void RandShuffleWithParams(Mat mat, double iterFactor, RNG rng)
{
  cv::randShuffle(*mat, iterFactor, rng);
}

void RandU(Mat mat, Scalar low, Scalar high)
{
  cv::Scalar l = cv::Scalar(low.val1, low.val2, low.val3, low.val4);
  cv::Scalar h = cv::Scalar(high.val1, high.val2, high.val3, high.val4);
  cv::randu(*mat, l, h);
}

void copyPointVectorToPoint2fVector(PointVector src, Point2fVector dest)
{
  for (size_t i = 0; i < src->size(); i++) {
    dest->push_back(cv::Point2f(src->at(i).x, src->at(i).y));
  }
}

void StdByteVectorInitialize(void *data)
{
  new (data) std::vector<uchar>();
}

void StdByteVectorFree(void *data)
{
  reinterpret_cast<std::vector<uchar> *>(data)->~vector<uchar>();
}

size_t StdByteVectorLen(void *data)
{
  return reinterpret_cast<std::vector<uchar> *>(data)->size();
}

uint8_t *StdByteVectorData(void *data)
{
  return reinterpret_cast<std::vector<uchar> *>(data)->data();
}

UCharVector UCharVector_New()
{
  return new std::vector<uchar>();
}

void UCharVector_Free(UCharVector vec)
{
  if (vec != nullptr) {
    vec->clear();
    delete vec;
  }
}

int UCharVector_Size(UCharVector vec)
{
  return vec->size();
}

void UCharVector_Append(UCharVector vec, uchar c)
{
  vec->push_back(c);
}

uchar UCharVector_At(UCharVector vec, int idx)
{
  return vec->at(idx);
}

Points2fVector Points2fVector_New()
{
  return new std::vector<std::vector<cv::Point2f>>;
}

Points2fVector Points2fVector_NewFromPoints(Contours2f points)
{
  Points2fVector pv = Points2fVector_New();
  for (size_t i = 0; i < points.length; i++) {
    Contour2f     contour2f = points.contours[i];
    Point2fVector cntr = Point2fVector_NewFromPoints(contour2f);
    Points2fVector_Append(pv, cntr);
  }

  return pv;
}

int Points2fVector_Size(Points2fVector ps)
{
  return ps->size();
}

Point2fVector Points2fVector_At(Points2fVector ps, int idx)
{
  return &(ps->at(idx));
}

void Points2fVector_Append(Points2fVector psv, Point2fVector pv)
{
  psv->push_back(*pv);
}

void Points2fVector_Close(Points2fVector ps)
{
  ps->clear();
  delete ps;
}

Point3fVector Point3fVector_New()
{
  return new std::vector<cv::Point3f>;
}

Point3fVector Point3fVector_NewFromPoints(Contour3f points)
{
  std::vector<cv::Point3f> *cntr = new std::vector<cv::Point3f>;
  for (size_t i = 0; i < points.length; i++) {
    cntr->push_back(cv::Point3f(points.points[i].x, points.points[i].y,
                                points.points[i].z));
  }

  return cntr;
}

Point3fVector Point3fVector_NewFromMat(Mat mat)
{
  std::vector<cv::Point3f> *pts = new std::vector<cv::Point3f>;
  *pts = (std::vector<cv::Point3f>)*mat;
  return pts;
}

Point3f Point3fVector_At(Point3fVector pfv, int idx)
{
  cv::Point3f p = pfv->at(idx);
  Point3f     pp = Point3f{.x = p.x, .y = p.y, .z = p.z};
  return pp;
}

void Point3fVector_Append(Point3fVector pfv, Point3f point)
{
  pfv->push_back(cv::Point3f(point.x, point.y, point.z));
}

int Point3fVector_Size(Point3fVector pfv)
{
  return pfv->size();
}

void Point3fVector_Close(Point3fVector pv)
{
  pv->clear();
  delete pv;
}

Points3fVector Points3fVector_New()
{
  return new std::vector<std::vector<cv::Point3f>>;
}

Points3fVector Points3fVector_NewFromPoints(Contours3f points)
{
  Points3fVector pv = Points3fVector_New();
  for (size_t i = 0; i < points.length; i++) {
    Contour3f     contour3f = points.contours[i];
    Point3fVector cntr = Point3fVector_NewFromPoints(contour3f);
    Points3fVector_Append(pv, cntr);
  }

  return pv;
}

int Points3fVector_Size(Points3fVector ps)
{
  return ps->size();
}

Point3fVector Points3fVector_At(Points3fVector ps, int idx)
{
  return &(ps->at(idx));
}

void Points3fVector_Append(Points3fVector psv, Point3fVector pv)
{
  psv->push_back(*pv);
}

void Points3fVector_Close(Points3fVector ps)
{
  ps->clear();
  delete ps;
}

void SetNumThreads(int n)
{
  cv::setNumThreads(n);
}

int GetNumThreads()
{
  return cv::getNumThreads();
}

void Point2fVector_Append(Point2fVector pv, Point2f p)
{
  pv->push_back(cv::Point2f(p.x, p.y));
}

CvStatus Mats_New(Mats *rval)
{
  BEGIN_WRAP
  std::vector<cv::Mat> v;
  *rval = {
      (Mat *)v.data(),
      (int)v.size(),
  };
  END_WRAP
}

// void Mats_Append(Mats mats, Mat mat) {
//     int n = sizeof(mats.mats) / sizeof(mats.mats[0]);
//     std::vector<Mat> v(mats.mats, mats.mats + n);
//     v.push_back(mat);
//     mats.mats = v.data();
//     mats.length = (int)v.size();
// }
