#include "core.h"
#include <vector>

VecPoint2f vecPointToVecPoint2f(VecPoint src);

CvStatus TermCriteria_New(int typ, int maxCount, double epsilon, TermCriteria *rval)
{
  BEGIN_WRAP
  *rval = new cv::TermCriteria(typ, maxCount, epsilon);
  END_WRAP
}
CvStatus TermCriteria_Type(TermCriteria tc, int *rval)
{
  BEGIN_WRAP
  *rval = tc->type;
  END_WRAP
}
CvStatus TermCriteria_MaxCount(TermCriteria tc, int *rval)
{
  BEGIN_WRAP
  *rval = tc->maxCount;
  END_WRAP
}
CvStatus TermCriteria_Epsilon(TermCriteria tc, double *rval)
{
  BEGIN_WRAP
  *rval = tc->epsilon;
  END_WRAP
}
void TermCriteria_Close(TermCriteria tc)
{
  delete tc;
  tc = nullptr;
}

CvStatus Mat_New(Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat();
  END_WRAP
}
CvStatus Mat_NewWithSize(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(rows, cols, type, 0.0);
  END_WRAP
}
CvStatus Mat_NewWithSizes(VecInt sizes, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(*sizes, type);
  END_WRAP
}
CvStatus Mat_NewWithSizesFromScalar(VecInt sizes, int type, Scalar ar, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = new cv::Mat(*sizes, type, c);
  END_WRAP
}
CvStatus Mat_NewWithSizesFromBytes(VecInt sizes, int type, VecChar buf, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(*sizes, type, buf);
  END_WRAP
}
CvStatus Mat_NewFromScalar(const Scalar ar, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = new cv::Mat(1, 1, type, c);
  END_WRAP
}
CvStatus Mat_NewWithSizeFromScalar(const Scalar ar, int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = new cv::Mat(rows, cols, type, c);
  END_WRAP
}
CvStatus Mat_NewFromBytes(int rows, int cols, int type, VecChar buf, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(rows, cols, type, buf);
  END_WRAP
}
CvStatus Mat_NewFromVecPoint(VecPoint vec, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(*vec);
  END_WRAP
}
CvStatus Mat_NewFromVecPoint2f(VecPoint2f vec, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(*vec);
  END_WRAP
}
CvStatus Mat_NewFromVecPoint3f(VecPoint3f vec, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(*vec);
  END_WRAP
}
CvStatus Mat_FromPtr(Mat m, int rows, int cols, int type, int prows, int pcols, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(rows, cols, type, m->ptr(prows, pcols));
  END_WRAP
}
void Mat_Close(Mat m)
{
  delete m;
  m = nullptr;
}
CvStatus Mat_Empty(Mat m, bool *rval)
{
  BEGIN_WRAP
  *rval = m->empty();
  END_WRAP
}
CvStatus Mat_IsContinuous(Mat m, bool *rval)
{
  BEGIN_WRAP
  *rval = m->isContinuous();
  END_WRAP
}
CvStatus Mat_Clone(Mat m, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(m->clone());
  END_WRAP
}
CvStatus Mat_CopyTo(Mat m, Mat dst)
{
  BEGIN_WRAP
  m->copyTo(*dst);
  END_WRAP
}
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
CvStatus Mat_ConvertToWithParams(Mat m, Mat dst, int type, float alpha, float beta)
{
  BEGIN_WRAP
  m->convertTo(*dst, type, alpha, beta);
  END_WRAP
}
CvStatus Mat_ToVecUChar(Mat m, VecUChar rval)
{
  BEGIN_WRAP
  *rval = std::vector<uchar>(m->begin<uchar>(), m->end<uchar>());
  END_WRAP
}
CvStatus Mat_ToVecChar(Mat m, VecChar rval)
{
  BEGIN_WRAP
  *rval = std::vector<char>(m->begin<char>(), m->end<char>());
  END_WRAP
}
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
  auto dst = cv::Mat();
  cv::convertFp16(*m, dst);
  *rval = new cv::Mat(dst);
  END_WRAP
}
CvStatus Mat_Mean(Mat m, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*m);
  *rval = Scalar{c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_MeanWithMask(Mat m, Mat mask, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*m, *mask);
  *rval = Scalar{c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_Sqrt(Mat m, Mat *rval)
{
  BEGIN_WRAP
  auto dst = cv::Mat();
  cv::sqrt(*m, dst);
  *rval = new cv::Mat(dst);
  END_WRAP
}
CvStatus Mat_Rows(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->rows;
  END_WRAP
}
CvStatus Mat_Cols(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->cols;
  END_WRAP
}
CvStatus Mat_Channels(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->channels();
  END_WRAP
}
CvStatus Mat_Type(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m->type();
  END_WRAP
}
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
CvStatus Mat_Size(Mat m, VecInt rval)
{
  BEGIN_WRAP
  std::vector<int> v;

  auto size = m->size;
  for (int i = 0; i < size.dims(); i++) {
    v.push_back(size[i]);
  }
  *rval = v;
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
  *rval = new cv::Mat(cv::Mat::eye(rows, cols, type));
  END_WRAP
}
CvStatus Zeros(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(cv::Mat::zeros(rows, cols, type));
  END_WRAP
}
CvStatus Ones(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(cv::Mat::ones(rows, cols, type));
  END_WRAP
}

#pragma region Mat_getter

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

#pragma endregion

#pragma region Mat_setter

CvStatus Mat_SetTo(Mat m, Scalar value)
{
  BEGIN_WRAP
  cv::Scalar c_value(value.val1, value.val2, value.val3, value.val4);
  m->setTo(c_value);
  END_WRAP
}
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

#pragma endregion Mat_setter

#pragma region Mat_operation

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

CvStatus Mat_AddWeighted(Mat src1, double alpha, Mat src2, double beta, double gamma, Mat dst)
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
CvStatus Mat_Compare(Mat src1, Mat src2, Mat dst, int ct)
{
  BEGIN_WRAP
  cv::compare(*src1, *src2, *dst, ct);
  END_WRAP
}
CvStatus Mat_BatchDistance(Mat src1, Mat src2, Mat dist, int dtype, Mat nidx, int normType, int K, Mat mask, int update, bool crosscheck)
{
  BEGIN_WRAP
  cv::batchDistance(*src1, *src2, *dist, dtype, *nidx, normType, K, *mask, update, crosscheck);
  END_WRAP
}

CvStatus Mat_BorderInterpolate(int p, int len, int borderType, int *rval)
{
  BEGIN_WRAP
  *rval = cv::borderInterpolate(p, len, borderType);
  END_WRAP
}

CvStatus Mat_CalcCovarMatrix(Mat samples, Mat covar, Mat mean, int flags, int ctype)
{
  BEGIN_WRAP
  cv::calcCovarMatrix(*samples, *covar, *mean, flags, ctype);
  END_WRAP
}

CvStatus Mat_CartToPolar(Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees)
{
  BEGIN_WRAP
  cv::cartToPolar(*x, *y, *magnitude, *angle, angleInDegrees);
  END_WRAP
}

CvStatus Mat_CheckRange(Mat m, bool quiet, Point *pos, double minVal, double maxVal, bool *rval)
{
  BEGIN_WRAP
  cv::Point pos1;
  *rval = cv::checkRange(*m, quiet, &pos1, minVal, maxVal);
  pos->x = pos1.x;
  pos->y = pos1.y;
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
CvStatus Mat_CopyMakeBorder(Mat src, Mat dst, int top, int bottom, int left, int right, int borderType, Scalar value)
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

CvStatus Mat_PCACompute(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents)
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

CvStatus Mat_Gemm(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst, int flags)
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

CvStatus Mat_Merge(VecMat vec, Mat dst)
{
  BEGIN_WRAP
  cv::merge(*vec, *dst);
  END_WRAP
}

CvStatus Mat_Min(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::min(*src1, *src2, *dst);
  END_WRAP
}

CvStatus Mat_MinMaxIdx(Mat m, double *minVal, double *maxVal, int *minIdx, int *maxIdx)
{
  BEGIN_WRAP
  cv::minMaxIdx(*m, minVal, maxVal, minIdx, maxIdx);
  END_WRAP
}

CvStatus Mat_MinMaxLoc(Mat m, double *minVal, double *maxVal, Point *minLoc, Point *maxLoc)
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

CvStatus Mat_MixChannels(VecMat src, VecMat dst, VecInt fromTo)
{
  BEGIN_WRAP
  cv::mixChannels(*src, *dst, *fromTo);
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

CvStatus Mat_MultiplyWithParams(Mat src1, Mat src2, Mat dst, double scale, int dtype)
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

CvStatus Mat_Split(Mat src, VecMat rval)
{
  BEGIN_WRAP
  std::vector<cv::Mat> channels;
  cv::split(*src, channels);
  *rval = channels;
  END_WRAP
}

CvStatus Mat_Subtract(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::subtract(*src1, *src2, *dst);
  END_WRAP
}
CvStatus Mat_T(Mat x, Mat *rval);
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
CvStatus Mat_PolarToCart(Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees)
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
  *rval = {c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_rowRange(Mat m, int start, int end, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(m->rowRange(start, end));
  END_WRAP
}
CvStatus Mat_colRange(Mat m, int start, int end, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(m->colRange(start, end));
  END_WRAP
}
CvStatus LUT(Mat src, Mat lut, Mat dst)
{
  BEGIN_WRAP
  cv::LUT(*src, *lut, *dst);
  END_WRAP
}
CvStatus KMeans(Mat data, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags, Mat centers, double *rval)
{
  BEGIN_WRAP
  *rval = cv::kmeans(*data, k, *bestLabels, *criteria, attempts, flags, *centers);
  END_WRAP
}
CvStatus KMeansPoints(VecPoint2f pts, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags, Mat centers, double *rval)
{
  BEGIN_WRAP
  *rval = cv::kmeans(*pts, k, *bestLabels, *criteria, attempts, flags, *centers);
  END_WRAP
}
CvStatus Rotate(Mat src, Mat dst, int rotateCode)
{
  BEGIN_WRAP
  cv::rotate(*src, *dst, rotateCode);
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
#pragma endregion

#pragma region RNG

CvStatus Rng_New(RNG *rval)
{
  BEGIN_WRAP
  *rval = new cv::RNG();
  END_WRAP
}
CvStatus Rng_NewWithState(uint64_t state, RNG *rval)
{
  BEGIN_WRAP
  *rval = new cv::RNG(state);
  END_WRAP
}
void Rng_Close(RNG rng)
{
  delete rng;
  rng = nullptr;
}
CvStatus TheRNG(RNG *rval)
{
  BEGIN_WRAP
  *rval = &cv::theRNG();
  END_WRAP
}
CvStatus SetRNGSeed(int seed)
{
  BEGIN_WRAP
  cv::setRNGSeed(seed);
  END_WRAP
}
CvStatus RNG_Fill(RNG rng, Mat mat, int distType, double a, double b, bool saturateRange)
{
  BEGIN_WRAP
  rng->fill(*mat, distType, a, b, saturateRange);
  END_WRAP
}
CvStatus RNG_Gaussian(RNG rng, double sigma, double *rval)
{
  BEGIN_WRAP
  *rval = rng->gaussian(sigma);
  END_WRAP
}
CvStatus RNG_Uniform(RNG rng, int a, int b, int *rval)
{
  BEGIN_WRAP
  *rval = rng->uniform(a, b);
  END_WRAP
}
CvStatus RNG_UniformDouble(RNG rng, double a, double b, double *rval)
{
  BEGIN_WRAP
  *rval = rng->uniform(a, b);
  END_WRAP
}
CvStatus RNG_Next(RNG rng, uint32_t *rval)
{
  BEGIN_WRAP
  *rval = rng->next();
  END_WRAP
}
CvStatus RandN(Mat mat, Scalar mean, Scalar stddev)
{
  BEGIN_WRAP
  auto c_mean = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
  auto c_stddev = cv::Scalar(stddev.val1, stddev.val2, stddev.val3, stddev.val4);
  cv::randn(*mat, c_mean, c_stddev);
  END_WRAP
}
CvStatus RandShuffle(Mat mat)
{
  BEGIN_WRAP
  cv::randShuffle(*mat);
  END_WRAP
}
CvStatus RandShuffleWithParams(Mat mat, double iterFactor, RNG rng)
{
  BEGIN_WRAP
  cv::randShuffle(*mat, iterFactor, rng);
  END_WRAP
}
CvStatus RandU(Mat mat, Scalar low, Scalar high)
{
  BEGIN_WRAP
  auto c_low = cv::Scalar(low.val1, low.val2, low.val3, low.val4);
  auto c_high = cv::Scalar(high.val1, high.val2, high.val3, high.val4);
  cv::randu(*mat, c_low, c_high);
  END_WRAP
}
#pragma endregion

CvStatus GetCVTickCount(int64_t *rval)
{
  BEGIN_WRAP
  *rval = cv::getTickCount();
  END_WRAP
}
CvStatus GetTickFrequency(double *rval)
{
  BEGIN_WRAP
  *rval = cv::getTickFrequency();
  END_WRAP
}
CvStatus SetNumThreads(int n)
{
  BEGIN_WRAP
  cv::setNumThreads(n);
  END_WRAP
}
CvStatus GetNumThreads(int *rval)
{
  BEGIN_WRAP
  *rval = cv::getNumThreads();
  END_WRAP
}
