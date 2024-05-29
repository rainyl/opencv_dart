#include "core.h"
#include "lut.hpp"
#include <vector>

CvStatus RotatedRect_Points(RotatedRect rect, VecPoint2f *pts)
{
  BEGIN_WRAP
  auto r = cv::RotatedRect(cv::Point2f(rect.center.x, rect.center.y),
                           cv::Size2f(rect.size.width, rect.size.height), rect.angle);
  auto pts_ = new std::vector<cv::Point2f>();
  r.points(*pts_);
  *pts = {pts_};
  END_WRAP
}
CvStatus RotatedRect_BoundingRect(RotatedRect rect, Rect *rval)
{
  BEGIN_WRAP
  auto r = cv::RotatedRect(cv::Point2f(rect.center.x, rect.center.y),
                           cv::Size2f(rect.size.width, rect.size.height), rect.angle);
  auto rr = r.boundingRect();
  *rval = {rr.x, rr.y, rr.width, rr.height};
  END_WRAP
}

CvStatus RotatedRect_BoundingRect2f(RotatedRect rect, Rect2f *rval)
{
  BEGIN_WRAP
  auto r = cv::RotatedRect(cv::Point2f(rect.center.x, rect.center.y),
                           cv::Size2f(rect.size.width, rect.size.height), rect.angle);
  auto rr = r.boundingRect2f();
  *rval = {rr.x, rr.y, rr.width, rr.height};
  END_WRAP
}

CvStatus Mat_New(Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat()};
  END_WRAP
}
CvStatus Mat_NewWithSize(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(rows, cols, type, 0.0)};
  END_WRAP
}
CvStatus Mat_NewWithSizes(VecInt sizes, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(*sizes.ptr, type)};
  END_WRAP
}
CvStatus Mat_NewWithSizesFromScalar(VecInt sizes, int type, Scalar ar, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = {new cv::Mat(*sizes.ptr, type, c)};
  END_WRAP
}
CvStatus Mat_NewWithSizesFromBytes(VecInt sizes, int type, VecChar buf, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(*sizes.ptr, type, buf.ptr)};
  END_WRAP
}
CvStatus Mat_NewFromScalar(const Scalar ar, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = {new cv::Mat(1, 1, type, c)};
  END_WRAP
}
CvStatus Mat_NewWithSizeFromScalar(const Scalar ar, int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(ar.val1, ar.val2, ar.val3, ar.val4);
  *rval = {new cv::Mat(rows, cols, type, c)};
  END_WRAP
}
CvStatus Mat_NewFromBytes(int rows, int cols, int type, void *buf, int step, Mat *rval)
{
  BEGIN_WRAP
  auto p = reinterpret_cast<uchar *>(buf);
  *rval = {new cv::Mat(rows, cols, type, buf, step)};
  END_WRAP
}
CvStatus Mat_NewFromVecPoint(VecPoint vec, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(*vec.ptr)};
  END_WRAP
}
CvStatus Mat_NewFromVecPoint2f(VecPoint2f vec, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(*vec.ptr)};
  END_WRAP
}
CvStatus Mat_NewFromVecPoint3f(VecPoint3f vec, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(*vec.ptr)};
  END_WRAP
}
CvStatus Mat_FromPtr(Mat m, int rows, int cols, int type, int prows, int pcols, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(rows, cols, type, m.ptr->ptr(prows, pcols))};
  END_WRAP
}
CvStatus Mat_FromCMat(Mat m, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(m.ptr->clone())};
  END_WRAP
}
void Mat_Close(Mat *m)
{
  m->ptr->release();
  CVD_FREE(m)
}
void Mat_CloseVoid(void *m)
{
  auto p = reinterpret_cast<Mat *>(m);
  p->ptr->release();
  CVD_FREE(p)
}
CvStatus Mat_Release(Mat *m)
{
  BEGIN_WRAP
  m->ptr->release();
  END_WRAP
}

CvStatus Mat_Empty(Mat m, bool *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->empty();
  END_WRAP
}
CvStatus Mat_IsContinuous(Mat m, bool *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->isContinuous();
  END_WRAP
}
CvStatus Mat_Clone(Mat m, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(m.ptr->clone())};
  END_WRAP
}
CvStatus Mat_CopyTo(Mat m, Mat dst)
{
  BEGIN_WRAP
  m.ptr->copyTo(*dst.ptr);
  END_WRAP
}
CvStatus Mat_CopyToWithMask(Mat m, Mat dst, Mat mask)
{
  BEGIN_WRAP
  m.ptr->copyTo(*dst.ptr, *mask.ptr);
  END_WRAP
}
CvStatus Mat_ConvertTo(Mat m, Mat dst, int type)
{
  BEGIN_WRAP
  m.ptr->convertTo(*dst.ptr, type);
  END_WRAP
}
CvStatus Mat_ConvertToWithParams(Mat m, Mat dst, int type, float alpha, float beta)
{
  BEGIN_WRAP
  m.ptr->convertTo(*dst.ptr, type, alpha, beta);
  END_WRAP
}
CvStatus Mat_ToVecUChar(Mat m, VecUChar *rval)
{
  BEGIN_WRAP
  *rval = {new std::vector<uchar>(m.ptr->begin<uchar>(), m.ptr->end<uchar>())};
  END_WRAP
}
CvStatus Mat_ToVecChar(Mat m, VecChar *rval)
{
  BEGIN_WRAP
  *rval = {new std::vector<char>(m.ptr->begin<char>(), m.ptr->end<char>())};
  END_WRAP
}
CvStatus Mat_Region(Mat m, Rect r, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(*m.ptr, cv::Rect(r.x, r.y, r.width, r.height))};
  END_WRAP
}
CvStatus Mat_Reshape(Mat m, int cn, int rows, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(m.ptr->reshape(cn, rows))};
  END_WRAP
}
CvStatus Mat_PatchNaNs(Mat m, double val)
{
  BEGIN_WRAP
  cv::patchNaNs(*m.ptr, val);
  END_WRAP
}
CvStatus Mat_ConvertFp16(Mat m, Mat *rval)
{
  BEGIN_WRAP
  auto dst = cv::Mat();
  cv::convertFp16(*m.ptr, dst);
  *rval = {new cv::Mat(dst)};
  END_WRAP
}
CvStatus Mat_Mean(Mat m, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*m.ptr);
  *rval = Scalar{c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_MeanWithMask(Mat m, Mat mask, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*m.ptr, *mask.ptr);
  *rval = Scalar{c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_Sqrt(Mat m, Mat *rval)
{
  BEGIN_WRAP
  auto dst = cv::Mat();
  cv::sqrt(*m.ptr, dst);
  *rval = {new cv::Mat(dst)};
  END_WRAP
}
CvStatus Mat_Rows(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->rows;
  END_WRAP
}
CvStatus Mat_Cols(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->cols;
  END_WRAP
}
CvStatus Mat_Channels(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->channels();
  END_WRAP
}
CvStatus Mat_Type(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->type();
  END_WRAP
}
CvStatus Mat_Step(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->step;
  END_WRAP
}
CvStatus Mat_Total(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->total();
  END_WRAP
}
CvStatus Mat_Size(Mat m, VecInt *rval)
{
  BEGIN_WRAP
  std::vector<int> v;

  auto size = m.ptr->size;
  for (int i = 0; i < size.dims(); i++) {
    v.push_back(size[i]);
  }
  *rval = {new std::vector<int>(v)};
  END_WRAP
}
CvStatus Mat_ElemSize(Mat m, int *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->elemSize();
  END_WRAP
}
CvStatus Mat_Data(Mat m, VecUChar *rval)
{
  BEGIN_WRAP
  *rval = {new std::vector<uchar>(*m.ptr->data)};
  END_WRAP
}

CvStatus Mat_DataPtr(Mat m, uchar **data, int *length)
{
  BEGIN_WRAP
  *data = m.ptr->data;
  *length = static_cast<int>(m.ptr->total() * m.ptr->elemSize());
  END_WRAP
}

CvStatus Eye(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::Mat::eye(rows, cols, type))};
  END_WRAP
}
CvStatus Zeros(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::Mat::zeros(rows, cols, type))};
  END_WRAP
}
CvStatus Ones(int rows, int cols, int type, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::Mat::ones(rows, cols, type))};
  END_WRAP
}

CvStatus Mat_Ptr_u8_1(Mat m, int i, uchar **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr(i);
  END_WRAP
}

CvStatus Mat_Ptr_u8_2(Mat m, int i, int j, uchar **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr(i, j);
  END_WRAP
}

CvStatus Mat_Ptr_u8_3(Mat m, int i, int j, int k, uchar **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr(i, j, k);
  END_WRAP
}

CvStatus Mat_Ptr_i8_1(Mat m, int i, char **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<char>(i);
  END_WRAP
}
CvStatus Mat_Ptr_i8_2(Mat m, int i, int j, char **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<char>(i, j);
  END_WRAP
}
CvStatus Mat_Ptr_i8_3(Mat m, int i, int j, int k, char **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<char>(i, j, k);
  END_WRAP
}
CvStatus Mat_Ptr_u16_1(Mat m, int i, ushort **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<ushort>(i);
  END_WRAP
}
CvStatus Mat_Ptr_u16_2(Mat m, int i, int j, ushort **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<ushort>(i, j);
  END_WRAP
}
CvStatus Mat_Ptr_u16_3(Mat m, int i, int j, int k, ushort **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<ushort>(i, j, k);
  END_WRAP
}
CvStatus Mat_Ptr_i16_1(Mat m, int i, short **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<short>(i);
  END_WRAP
}
CvStatus Mat_Ptr_i16_2(Mat m, int i, int j, short **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<short>(i, j);
  END_WRAP
}
CvStatus Mat_Ptr_i16_3(Mat m, int i, int j, int k, short **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<short>(i, j, k);
  END_WRAP
}
CvStatus Mat_Ptr_i32_1(Mat m, int i, int **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<int>(i);
  END_WRAP
}
CvStatus Mat_Ptr_i32_2(Mat m, int i, int j, int **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<int>(i, j);
  END_WRAP
}
CvStatus Mat_Ptr_i32_3(Mat m, int i, int j, int k, int **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<int>(i, j, k);
  END_WRAP
}
CvStatus Mat_Ptr_f32_1(Mat m, int i, float **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<float>(i);
  END_WRAP
}
CvStatus Mat_Ptr_f32_2(Mat m, int i, int j, float **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<float>(i, j);
  END_WRAP
}
CvStatus Mat_Ptr_f32_3(Mat m, int i, int j, int k, float **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<float>(i, j, k);
  END_WRAP
}
CvStatus Mat_Ptr_f64_1(Mat m, int i, double **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<double>(i);
  END_WRAP
}
CvStatus Mat_Ptr_f64_2(Mat m, int i, int j, double **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<double>(i, j);
  END_WRAP
}
CvStatus Mat_Ptr_f64_3(Mat m, int i, int j, int k, double **rval)
{
  BEGIN_WRAP
  *rval = m.ptr->ptr<double>(i, j, k);
  END_WRAP
}

#pragma region Mat_getter

CvStatus Mat_GetUChar(Mat m, int row, int col, uint8_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<uchar>(row, col);
  END_WRAP
}
CvStatus Mat_GetUChar3(Mat m, int x, int y, int z, uint8_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<uchar>(x, y, z);
  END_WRAP
}
CvStatus Mat_GetSChar(Mat m, int row, int col, int8_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<schar>(row, col);
  END_WRAP
}
CvStatus Mat_GetSChar3(Mat m, int x, int y, int z, int8_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<schar>(x, y, z);
  END_WRAP
}
CvStatus Mat_GetUShort(Mat m, int row, int col, uint16_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<ushort>(row, col);
  END_WRAP
}
CvStatus Mat_GetUShort3(Mat m, int x, int y, int z, uint16_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<ushort>(x, y, z);
  END_WRAP
}
CvStatus Mat_GetShort(Mat m, int row, int col, int16_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<short>(row, col);
  END_WRAP
}
CvStatus Mat_GetShort3(Mat m, int x, int y, int z, int16_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<short>(x, y, z);
  END_WRAP
}
CvStatus Mat_GetInt(Mat m, int row, int col, int32_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<int>(row, col);
  END_WRAP
}
CvStatus Mat_GetInt3(Mat m, int x, int y, int z, int32_t *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<int>(x, y, z);
  END_WRAP
}
CvStatus Mat_GetFloat(Mat m, int row, int col, float *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<float>(row, col);
  END_WRAP
}
CvStatus Mat_GetFloat3(Mat m, int x, int y, int z, float *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<float>(x, y, z);
  END_WRAP
}
CvStatus Mat_GetDouble(Mat m, int row, int col, double *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<double>(row, col);
  END_WRAP
}
CvStatus Mat_GetDouble3(Mat m, int x, int y, int z, double *rval)
{
  BEGIN_WRAP
  *rval = m.ptr->at<double>(x, y, z);
  END_WRAP
}

CvStatus Mat_GetVec2b(Mat m, int row, int col, Vec2b *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec2b>(row, col);
  *rval = {v.val[0], v.val[1]};
  END_WRAP
}
CvStatus Mat_GetVec3b(Mat m, int row, int col, Vec3b *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec3b>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2]};
  END_WRAP
}
CvStatus Mat_GetVec4b(Mat m, int row, int col, Vec4b *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec4b>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3]};
  END_WRAP
}
CvStatus Mat_GetVec2s(Mat m, int row, int col, Vec2s *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec2s>(row, col);
  *rval = {v.val[0], v.val[1]};
  END_WRAP
}
CvStatus Mat_GetVec3s(Mat m, int row, int col, Vec3s *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec3s>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2]};
  END_WRAP
}
CvStatus Mat_GetVec4s(Mat m, int row, int col, Vec4s *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec4s>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3]};
  END_WRAP
}
CvStatus Mat_GetVec2w(Mat m, int row, int col, Vec2w *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec2w>(row, col);
  *rval = {v.val[0], v.val[1]};
  END_WRAP
}
CvStatus Mat_GetVec3w(Mat m, int row, int col, Vec3w *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec3w>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2]};
  END_WRAP
}
CvStatus Mat_GetVec4w(Mat m, int row, int col, Vec4w *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec4w>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3]};
  END_WRAP
}
CvStatus Mat_GetVec2i(Mat m, int row, int col, Vec2i *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec2i>(row, col);
  *rval = {v.val[0], v.val[1]};
  END_WRAP
}
CvStatus Mat_GetVec3i(Mat m, int row, int col, Vec3i *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec3i>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2]};
  END_WRAP
}
CvStatus Mat_GetVec4i(Mat m, int row, int col, Vec4i *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec4i>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3]};
  END_WRAP
}
CvStatus Mat_GetVec6i(Mat m, int row, int col, Vec6i *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec6i>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3], v.val[4], v.val[5]};
  END_WRAP
}
CvStatus Mat_GetVec8i(Mat m, int row, int col, Vec8i *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec8i>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3], v.val[4], v.val[5], v.val[6], v.val[7]};
  END_WRAP
}
CvStatus Mat_GetVec2f(Mat m, int row, int col, Vec2f *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec2f>(row, col);
  *rval = {v.val[0], v.val[1]};
  END_WRAP
}
CvStatus Mat_GetVec3f(Mat m, int row, int col, Vec3f *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec3f>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2]};
  END_WRAP
}
CvStatus Mat_GetVec4f(Mat m, int row, int col, Vec4f *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec4f>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3]};
  END_WRAP
}
CvStatus Mat_GetVec6f(Mat m, int row, int col, Vec6f *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec6f>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3], v.val[4], v.val[5]};
  END_WRAP
}
CvStatus Mat_GetVec2d(Mat m, int row, int col, Vec2d *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec2d>(row, col);
  *rval = {v.val[0], v.val[1]};
  END_WRAP
}
CvStatus Mat_GetVec3d(Mat m, int row, int col, Vec3d *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec3d>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2]};
  END_WRAP
}
CvStatus Mat_GetVec4d(Mat m, int row, int col, Vec4d *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec4d>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3]};
  END_WRAP
}
CvStatus Mat_GetVec6d(Mat m, int row, int col, Vec6d *rval)
{
  BEGIN_WRAP
  auto v = m.ptr->at<cv::Vec6d>(row, col);
  *rval = {v.val[0], v.val[1], v.val[2], v.val[3], v.val[4], v.val[5]};
  END_WRAP
}

#pragma endregion

#pragma region Mat_setter

CvStatus Mat_SetTo(Mat m, Scalar value)
{
  BEGIN_WRAP
  cv::Scalar c_value(value.val1, value.val2, value.val3, value.val4);
  m.ptr->setTo(c_value);
  END_WRAP
}
CvStatus Mat_SetUChar(Mat m, int row, int col, uint8_t val)
{
  BEGIN_WRAP
  m.ptr->at<uchar>(row, col) = val;
  END_WRAP
}
CvStatus Mat_SetUChar3(Mat m, int x, int y, int z, uint8_t val)
{
  BEGIN_WRAP
  m.ptr->at<uchar>(x, y, z) = val;
  END_WRAP
}
CvStatus Mat_SetSChar(Mat m, int row, int col, int8_t val)
{
  BEGIN_WRAP
  m.ptr->at<schar>(row, col) = val;
  END_WRAP
}
CvStatus Mat_SetSChar3(Mat m, int x, int y, int z, int8_t val)
{
  BEGIN_WRAP
  m.ptr->at<schar>(x, y, z) = val;
  END_WRAP
}
// Mat_SetShort set a specific row/col value from this Mat expecting
// each element to contain a short aka CV_16S.
CvStatus Mat_SetShort(Mat m, int row, int col, int16_t val)
{
  BEGIN_WRAP
  m.ptr->at<short>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetShort3(Mat m, int x, int y, int z, int16_t val)
{
  BEGIN_WRAP
  m.ptr->at<short>(x, y, z) = val;
  END_WRAP
}

CvStatus Mat_SetUShort(Mat m, int row, int col, uint16_t val)
{
  BEGIN_WRAP
  m.ptr->at<ushort>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetUShort3(Mat m, int x, int y, int z, uint16_t val)
{
  BEGIN_WRAP
  m.ptr->at<ushort>(x, y, z) = val;
  END_WRAP
}

// Mat_SetInt set a specific row/col value from this Mat expecting
// each element to contain an int aka CV_32S.
CvStatus Mat_SetInt(Mat m, int row, int col, int32_t val)
{
  BEGIN_WRAP
  m.ptr->at<int>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetInt3(Mat m, int x, int y, int z, int32_t val)
{
  BEGIN_WRAP
  m.ptr->at<int>(x, y, z) = val;
  END_WRAP
}

// Mat_SetFloat set a specific row/col value from this Mat expecting
// each element to contain a float aka CV_32F.
CvStatus Mat_SetFloat(Mat m, int row, int col, float val)
{
  BEGIN_WRAP
  m.ptr->at<float>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetFloat3(Mat m, int x, int y, int z, float val)
{
  BEGIN_WRAP
  m.ptr->at<float>(x, y, z) = val;
  END_WRAP
}

// Mat_SetDouble set a specific row/col value from this Mat expecting
// each element to contain a double aka CV_64F.
CvStatus Mat_SetDouble(Mat m, int row, int col, double val)
{
  BEGIN_WRAP
  m.ptr->at<double>(row, col) = val;
  END_WRAP
}

CvStatus Mat_SetDouble3(Mat m, int x, int y, int z, double val)
{
  BEGIN_WRAP
  m.ptr->at<double>(x, y, z) = val;
  END_WRAP
}

CvStatus Mat_SetVec2b(Mat m, int row, int col, Vec2b val)
{
  BEGIN_WRAP
  auto v = cv::Vec2b(val.val1, val.val2);
  m.ptr->at<cv::Vec2b>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec3b(Mat m, int row, int col, Vec3b val)
{
  BEGIN_WRAP
  auto v = cv::Vec3b(val.val1, val.val2, val.val3);
  m.ptr->at<cv::Vec3b>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec4b(Mat m, int row, int col, Vec4b val)
{
  BEGIN_WRAP
  auto v = cv::Vec4b(val.val1, val.val2, val.val3, val.val4);
  m.ptr->at<cv::Vec4b>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec2s(Mat m, int row, int col, Vec2s val)
{
  BEGIN_WRAP
  auto v = cv::Vec2s(val.val1, val.val2);
  m.ptr->at<cv::Vec2s>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec3s(Mat m, int row, int col, Vec3s val)
{
  BEGIN_WRAP
  auto v = cv::Vec3s(val.val1, val.val2, val.val3);
  m.ptr->at<cv::Vec3s>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec4s(Mat m, int row, int col, Vec4s val)
{
  BEGIN_WRAP
  auto v = cv::Vec4s(val.val1, val.val2, val.val3, val.val4);
  m.ptr->at<cv::Vec4s>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec2w(Mat m, int row, int col, Vec2w val)
{
  BEGIN_WRAP
  auto v = cv::Vec2w(val.val1, val.val2);
  m.ptr->at<cv::Vec2w>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec3w(Mat m, int row, int col, Vec3w val)
{
  BEGIN_WRAP
  auto v = cv::Vec3w(val.val1, val.val2, val.val3);
  m.ptr->at<cv::Vec3w>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec4w(Mat m, int row, int col, Vec4w val)
{
  BEGIN_WRAP
  auto v = cv::Vec4w(val.val1, val.val2, val.val3, val.val4);
  m.ptr->at<cv::Vec4w>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec2i(Mat m, int row, int col, Vec2i val)
{
  BEGIN_WRAP
  auto v = cv::Vec2i(val.val1, val.val2);
  m.ptr->at<cv::Vec2i>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec3i(Mat m, int row, int col, Vec3i val)
{
  BEGIN_WRAP
  auto v = cv::Vec3i(val.val1, val.val2, val.val3);
  m.ptr->at<cv::Vec3i>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec4i(Mat m, int row, int col, Vec4i val)
{
  BEGIN_WRAP
  auto v = cv::Vec4i(val.val1, val.val2, val.val3, val.val4);
  m.ptr->at<cv::Vec4i>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec6i(Mat m, int row, int col, Vec6i val)
{
  BEGIN_WRAP
  auto v = cv::Vec6i(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6);
  m.ptr->at<cv::Vec6i>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec8i(Mat m, int row, int col, Vec8i val)
{
  BEGIN_WRAP
  auto v = cv::Vec8i(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6, val.val7, val.val8);
  m.ptr->at<cv::Vec8i>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec2f(Mat m, int row, int col, Vec2f val)
{
  BEGIN_WRAP
  auto v = cv::Vec2f(val.val1, val.val2);
  m.ptr->at<cv::Vec2f>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec3f(Mat m, int row, int col, Vec3f val)
{
  BEGIN_WRAP
  auto v = cv::Vec3f(val.val1, val.val2, val.val3);
  m.ptr->at<cv::Vec3f>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec4f(Mat m, int row, int col, Vec4f val)
{
  BEGIN_WRAP
  auto v = cv::Vec4f(val.val1, val.val2, val.val3, val.val4);
  m.ptr->at<cv::Vec4f>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec6f(Mat m, int row, int col, Vec6f val)
{
  BEGIN_WRAP
  auto v = cv::Vec6f(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6);
  m.ptr->at<cv::Vec6f>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec2d(Mat m, int row, int col, Vec2d val)
{
  BEGIN_WRAP
  auto v = cv::Vec2d(val.val1, val.val2);
  m.ptr->at<cv::Vec2d>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec3d(Mat m, int row, int col, Vec3d val)
{
  BEGIN_WRAP
  auto v = cv::Vec3d(val.val1, val.val2, val.val3);
  m.ptr->at<cv::Vec3d>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec4d(Mat m, int row, int col, Vec4d val)
{
  BEGIN_WRAP
  auto v = cv::Vec4d(val.val1, val.val2, val.val3, val.val4);
  m.ptr->at<cv::Vec4d>(row, col) = v;
  END_WRAP
}
CvStatus Mat_SetVec6d(Mat m, int row, int col, Vec6d val)
{
  BEGIN_WRAP
  auto v = cv::Vec6d(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6);
  m.ptr->at<cv::Vec6d>(row, col) = v;
  END_WRAP
}

#pragma endregion Mat_setter

#pragma region Mat_operation

CvStatus Mat_AddUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m.ptr += val;
  END_WRAP
}

CvStatus Mat_SubtractUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m.ptr -= val;
  END_WRAP
}

CvStatus Mat_MultiplyUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m.ptr *= val;
  END_WRAP
}

CvStatus Mat_DivideUChar(Mat m, uint8_t val)
{
  BEGIN_WRAP
  *m.ptr /= val;
  END_WRAP
}

CvStatus Mat_AddSChar(Mat m, int8_t val)
{
  BEGIN_WRAP
  *m.ptr += val;
  END_WRAP
}
CvStatus Mat_SubtractSChar(Mat m, int8_t val)
{
  BEGIN_WRAP
  *m.ptr -= val;
  END_WRAP
}
CvStatus Mat_MultiplySChar(Mat m, int8_t val)
{
  BEGIN_WRAP
  *m.ptr *= val;
  END_WRAP
}
CvStatus Mat_DivideSChar(Mat m, int8_t val)
{
  BEGIN_WRAP
  *m.ptr /= val;
  END_WRAP
}

CvStatus Mat_AddI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m.ptr += val;
  END_WRAP
}

CvStatus Mat_SubtractI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m.ptr -= val;
  END_WRAP
}

CvStatus Mat_MultiplyI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m.ptr *= val;
  END_WRAP
}

CvStatus Mat_DivideI32(Mat m, int32_t val)
{
  BEGIN_WRAP
  *m.ptr /= val;
  END_WRAP
}

CvStatus Mat_AddFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m.ptr += val;
  END_WRAP
}

CvStatus Mat_SubtractFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m.ptr -= val;
  END_WRAP
}

CvStatus Mat_MultiplyFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m.ptr *= val;
  END_WRAP
}

CvStatus Mat_DivideFloat(Mat m, float val)
{
  BEGIN_WRAP
  *m.ptr /= val;
  END_WRAP
}

CvStatus Mat_AddF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m.ptr += val;
  END_WRAP
}

CvStatus Mat_SubtractF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m.ptr -= val;
  END_WRAP
}

CvStatus Mat_MultiplyF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m.ptr *= val;
  END_WRAP
}

CvStatus Mat_DivideF64(Mat m, double_t val)
{
  BEGIN_WRAP
  *m.ptr /= val;
  END_WRAP
}
CvStatus Mat_MultiplyMatrix(Mat x, Mat y, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat((*x.ptr) * (*y.ptr))};
  END_WRAP
}

CvStatus Mat_AbsDiff(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::absdiff(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_Add(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::add(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_AddWeighted(Mat src1, double alpha, Mat src2, double beta, double gamma, Mat dst)
{
  BEGIN_WRAP
  cv::addWeighted(*src1.ptr, alpha, *src2.ptr, beta, gamma, *dst.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseAnd(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_and(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseAndWithMask(Mat src1, Mat src2, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_and(*src1.ptr, *src2.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseNot(Mat src1, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_not(*src1.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseNotWithMask(Mat src1, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_not(*src1.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseOr(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_or(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseOrWithMask(Mat src1, Mat src2, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_or(*src1.ptr, *src2.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseXor(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::bitwise_xor(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_BitwiseXorWithMask(Mat src1, Mat src2, Mat dst, Mat mask)
{
  BEGIN_WRAP
  cv::bitwise_xor(*src1.ptr, *src2.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}
CvStatus Mat_Compare(Mat src1, Mat src2, Mat dst, int ct)
{
  BEGIN_WRAP
  cv::compare(*src1.ptr, *src2.ptr, *dst.ptr, ct);
  END_WRAP
}
CvStatus Mat_BatchDistance(Mat src1, Mat src2, Mat dist, int dtype, Mat nidx, int normType, int K, Mat mask,
                           int update, bool crosscheck)
{
  BEGIN_WRAP
  cv::batchDistance(*src1.ptr, *src2.ptr, *dist.ptr, dtype, *nidx.ptr, normType, K, *mask.ptr, update,
                    crosscheck);
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
  cv::calcCovarMatrix(*samples.ptr, *covar.ptr, *mean.ptr, flags, ctype);
  END_WRAP
}

CvStatus Mat_CartToPolar(Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees)
{
  BEGIN_WRAP
  cv::cartToPolar(*x.ptr, *y.ptr, *magnitude.ptr, *angle.ptr, angleInDegrees);
  END_WRAP
}

CvStatus Mat_CheckRange(Mat m, bool quiet, Point *pos, double minVal, double maxVal, bool *rval)
{
  BEGIN_WRAP
  cv::Point pos1;
  *rval = cv::checkRange(*m.ptr, quiet, &pos1, minVal, maxVal);
  pos->x = pos1.x;
  pos->y = pos1.y;
  END_WRAP
}
CvStatus Mat_CompleteSymm(Mat m, bool lowerToUpper)
{
  BEGIN_WRAP
  cv::completeSymm(*m.ptr, lowerToUpper);
  END_WRAP
}
CvStatus Mat_ConvertScaleAbs(Mat src, Mat dst, double alpha, double beta)
{
  BEGIN_WRAP
  cv::convertScaleAbs(*src.ptr, *dst.ptr, alpha, beta);
  END_WRAP
}
CvStatus Mat_CopyMakeBorder(Mat src, Mat dst, int top, int bottom, int left, int right, int borderType,
                            Scalar value)
{
  BEGIN_WRAP
  cv::Scalar c_value(value.val1, value.val2, value.val3, value.val4);
  cv::copyMakeBorder(*src.ptr, *dst.ptr, top, bottom, left, right, borderType, c_value);
  END_WRAP
}

CvStatus Mat_CountNonZero(Mat src, int *rval)
{
  BEGIN_WRAP
  *rval = cv::countNonZero(*src.ptr);
  END_WRAP
}

CvStatus Mat_DCT(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::dct(*src.ptr, *dst.ptr, flags);
  END_WRAP
}

CvStatus Mat_Determinant(Mat m, double *rval)
{
  BEGIN_WRAP
  *rval = cv::determinant(*m.ptr);
  END_WRAP
}

CvStatus Mat_DFT(Mat m, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::dft(*m.ptr, *dst.ptr, flags);
  END_WRAP
}

CvStatus Mat_Divide(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::divide(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_Eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::eigen(*src.ptr, *eigenvalues.ptr, *eigenvectors.ptr);
  END_WRAP
}

CvStatus Mat_EigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors)
{
  BEGIN_WRAP
  cv::eigenNonSymmetric(*src.ptr, *eigenvalues.ptr, *eigenvectors.ptr);
  END_WRAP
}

CvStatus Mat_PCACompute(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents)
{
  BEGIN_WRAP
  cv::PCACompute(*src.ptr, *mean.ptr, *eigenvectors.ptr, *eigenvalues.ptr, maxComponents);
  END_WRAP
}

CvStatus Mat_Exp(Mat src, Mat dst)
{
  BEGIN_WRAP
  cv::exp(*src.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_ExtractChannel(Mat src, Mat dst, int coi)
{
  BEGIN_WRAP
  cv::extractChannel(*src.ptr, *dst.ptr, coi);
  END_WRAP
}

CvStatus Mat_FindNonZero(Mat src, Mat idx)
{
  BEGIN_WRAP
  cv::findNonZero(*src.ptr, *idx.ptr);
  END_WRAP
}

CvStatus Mat_Flip(Mat src, Mat dst, int flipCode)
{
  BEGIN_WRAP
  cv::flip(*src.ptr, *dst.ptr, flipCode);
  END_WRAP
}

CvStatus Mat_Gemm(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::gemm(*src1.ptr, *src2.ptr, alpha, *src3.ptr, beta, *dst.ptr, flags);
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
  cv::hconcat(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_Vconcat(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::vconcat(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}
CvStatus Mat_Idct(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::idct(*src.ptr, *dst.ptr, flags);
  END_WRAP
}

CvStatus Mat_Idft(Mat src, Mat dst, int flags, int nonzeroRows)
{
  BEGIN_WRAP
  cv::idft(*src.ptr, *dst.ptr, flags, nonzeroRows);
  END_WRAP
}

CvStatus Mat_InRange(Mat src, Mat lowerb, Mat upperb, Mat dst)
{
  BEGIN_WRAP
  cv::inRange(*src.ptr, *lowerb.ptr, *upperb.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_InRangeWithScalar(Mat src, Scalar lowerb, Scalar upperb, Mat dst)
{
  BEGIN_WRAP
  cv::Scalar lb = cv::Scalar(lowerb.val1, lowerb.val2, lowerb.val3, lowerb.val4);
  cv::Scalar ub = cv::Scalar(upperb.val1, upperb.val2, upperb.val3, upperb.val4);
  cv::inRange(*src.ptr, lb, ub, *dst.ptr);
  END_WRAP
}

CvStatus Mat_InsertChannel(Mat src, Mat dst, int coi)
{
  BEGIN_WRAP
  cv::insertChannel(*src.ptr, *dst.ptr, coi);
  END_WRAP
}

CvStatus Mat_Invert(Mat src, Mat dst, int flags, double *rval)
{
  BEGIN_WRAP
  *rval = cv::invert(*src.ptr, *dst.ptr, flags);
  END_WRAP
}
CvStatus Mat_Log(Mat src, Mat dst)
{
  BEGIN_WRAP
  cv::log(*src.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_Magnitude(Mat x, Mat y, Mat magnitude)
{
  BEGIN_WRAP
  cv::magnitude(*x.ptr, *y.ptr, *magnitude.ptr);
  END_WRAP
}

CvStatus Mat_Max(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::max(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_MeanStdDev(Mat src, Scalar *dstMean, Scalar *dstStdDev)
{
  BEGIN_WRAP
  cv::Scalar mean, sd;
  cv::meanStdDev(*src.ptr, mean, sd);
  *dstMean = {mean.val[0], mean.val[1], mean.val[2], mean.val[3]};
  *dstStdDev = {sd.val[0], sd.val[1], sd.val[2], sd.val[3]};
  END_WRAP
}

CvStatus Mat_MeanStdDevWithMask(Mat src, Scalar *dstMean, Scalar *dstStdDev, Mat mask)
{
  BEGIN_WRAP
  cv::Scalar mean, sd;
  cv::meanStdDev(*src.ptr, mean, sd, *mask.ptr);
  *dstMean = {mean.val[0], mean.val[1], mean.val[2], mean.val[3]};
  *dstStdDev = {sd.val[0], sd.val[1], sd.val[2], sd.val[3]};
  END_WRAP
}

CvStatus Mat_Merge(VecMat vec, Mat dst)
{
  BEGIN_WRAP
  cv::merge(*vec.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_Min(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::min(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_MinMaxIdx(Mat m, double *minVal, double *maxVal, int *minIdx, int *maxIdx)
{
  BEGIN_WRAP
  cv::minMaxIdx(*m.ptr, minVal, maxVal, minIdx, maxIdx);
  END_WRAP
}

CvStatus Mat_MinMaxLoc(Mat m, double *minVal, double *maxVal, Point *minLoc, Point *maxLoc)
{
  BEGIN_WRAP
  cv::Point cMinLoc, cMaxLoc;
  cv::minMaxLoc(*m.ptr, minVal, maxVal, &cMinLoc, &cMaxLoc);

  *minLoc = {cMinLoc.x, cMinLoc.y};
  *maxLoc = {cMaxLoc.x, cMaxLoc.y};
  END_WRAP
}

CvStatus Mat_MixChannels(VecMat src, VecMat dst, VecInt fromTo)
{
  BEGIN_WRAP
  cv::mixChannels(*src.ptr, *dst.ptr, *fromTo.ptr);
  END_WRAP
}

CvStatus Mat_MulSpectrums(Mat a, Mat b, Mat c, int flags)
{
  BEGIN_WRAP
  cv::mulSpectrums(*a.ptr, *b.ptr, *c.ptr, flags);
  END_WRAP
}

CvStatus Mat_Multiply(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::multiply(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_MultiplyWithParams(Mat src1, Mat src2, Mat dst, double scale, int dtype)
{
  BEGIN_WRAP
  cv::multiply(*src1.ptr, *src2.ptr, *dst.ptr, scale, dtype);
  END_WRAP
}

CvStatus Mat_Normalize(Mat src, Mat dst, double alpha, double beta, int typ)
{
  BEGIN_WRAP
  cv::normalize(*src.ptr, *dst.ptr, alpha, beta, typ);
  END_WRAP
}
CvStatus Mat_PerspectiveTransform(Mat src, Mat dst, Mat tm)
{
  BEGIN_WRAP
  cv::perspectiveTransform(*src.ptr, *dst.ptr, *tm.ptr);
  END_WRAP
}

CvStatus Mat_Solve(Mat src1, Mat src2, Mat dst, int flags, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::solve(*src1.ptr, *src2.ptr, *dst.ptr, flags);
  END_WRAP
}

CvStatus Mat_SolveCubic(Mat coeffs, Mat roots, int *rval)
{
  BEGIN_WRAP
  *rval = cv::solveCubic(*coeffs.ptr, *roots.ptr);
  END_WRAP
}

CvStatus Mat_SolvePoly(Mat coeffs, Mat roots, int maxIters, double *rval)
{
  BEGIN_WRAP
  *rval = cv::solvePoly(*coeffs.ptr, *roots.ptr, maxIters);
  END_WRAP
}

CvStatus Mat_Reduce(Mat src, Mat dst, int dim, int rType, int dType)
{
  BEGIN_WRAP
  cv::reduce(*src.ptr, *dst.ptr, dim, rType, dType);
  END_WRAP
}

CvStatus Mat_ReduceArgMax(Mat src, Mat dst, int axis, bool lastIndex)
{
  BEGIN_WRAP
  cv::reduceArgMax(*src.ptr, *dst.ptr, axis, lastIndex);
  END_WRAP
}

CvStatus Mat_ReduceArgMin(Mat src, Mat dst, int axis, bool lastIndex)
{
  BEGIN_WRAP
  cv::reduceArgMin(*src.ptr, *dst.ptr, axis, lastIndex);
  END_WRAP
}

CvStatus Mat_Repeat(Mat src, int nY, int nX, Mat dst)
{
  BEGIN_WRAP
  cv::repeat(*src.ptr, nY, nX, *dst.ptr);
  END_WRAP
}

CvStatus Mat_ScaleAdd(Mat src1, double alpha, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::scaleAdd(*src1.ptr, alpha, *src2.ptr, *dst.ptr);
  END_WRAP
}

CvStatus Mat_SetIdentity(Mat src, double scalar)
{
  BEGIN_WRAP
  cv::setIdentity(*src.ptr, scalar);
  END_WRAP
}

CvStatus Mat_Sort(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::sort(*src.ptr, *dst.ptr, flags);
  END_WRAP
}

CvStatus Mat_SortIdx(Mat src, Mat dst, int flags)
{
  BEGIN_WRAP
  cv::sortIdx(*src.ptr, *dst.ptr, flags);
  END_WRAP
}

CvStatus Mat_Split(Mat src, VecMat *rval)
{
  BEGIN_WRAP
  std::vector<cv::Mat> *channels = new std::vector<cv::Mat>();
  cv::split(*src.ptr, *channels);
  *rval = {channels};
  END_WRAP
}

CvStatus Mat_Subtract(Mat src1, Mat src2, Mat dst)
{
  BEGIN_WRAP
  cv::subtract(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}
CvStatus Mat_T(Mat x, Mat *rval);
CvStatus Mat_Trace(Mat src, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::trace(*src.ptr);
  Scalar     scal = Scalar();
  *rval = {c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_Transform(Mat src, Mat dst, Mat tm)
{
  BEGIN_WRAP
  cv::transform(*src.ptr, *dst.ptr, *tm.ptr);
  END_WRAP
}
CvStatus Mat_Transpose(Mat src, Mat dst)
{
  BEGIN_WRAP
  cv::transpose(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus Mat_PolarToCart(Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees)
{
  BEGIN_WRAP
  cv::polarToCart(*magnitude.ptr, *degree.ptr, *x.ptr, *y.ptr, angleInDegrees);
  END_WRAP
}
CvStatus Mat_Pow(Mat src, double power, Mat dst)
{
  BEGIN_WRAP
  cv::pow(*src.ptr, power, *dst.ptr);
  END_WRAP
}
CvStatus Mat_Phase(Mat x, Mat y, Mat angle, bool angleInDegrees)
{
  BEGIN_WRAP
  cv::phase(*x.ptr, *y.ptr, *angle.ptr, angleInDegrees);
  END_WRAP
}
CvStatus Mat_Sum(Mat src, Scalar *rval)
{
  BEGIN_WRAP
  cv::Scalar c = cv::sum(*src.ptr);
  *rval = {c.val[0], c.val[1], c.val[2], c.val[3]};
  END_WRAP
}
CvStatus Mat_rowRange(Mat m, int start, int end, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(m.ptr->rowRange(start, end))};
  END_WRAP
}
CvStatus Mat_colRange(Mat m, int start, int end, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(m.ptr->colRange(start, end))};
  END_WRAP
}

// https://docs.opencv.org/4.x/db/da5/tutorial_how_to_scan_images.html#:~:text=Goal
CvStatus LUT(Mat src, Mat lut, Mat dst)
{
  BEGIN_WRAP
  auto cn = src.ptr->channels(), depth = src.ptr->depth();
  if (depth == CV_8U || depth == CV_8S) {
    cv::LUT(*src.ptr, *lut.ptr, *dst.ptr);
  } else {
    int    lutcn = lut.ptr->channels(), lut_depth = lut.ptr->depth();
    size_t lut_total = lut.ptr->total(), expect_total = 0;
    switch (depth) {
    case CV_8U:
    case CV_8S:
      expect_total = 256;
    case CV_16U:
    case CV_16S:
      expect_total = 65536;
      break;
    // TODO: can't create a mat with 4294967296 rows, maybe use vector instead
    // case CV_32S:
    //   expect_total = 4294967296;
    //   break;
    default:
      throw cv::Exception(cv::Error::StsNotImplemented, "source Mat Type not supported", __func__, __FILE__,
                          __LINE__);
    }

    CV_Assert((lutcn == cn || lutcn == 1) && lut_total == expect_total && lut.ptr->isContinuous());
    dst.ptr->create(src.ptr->dims, src.ptr->size, CV_MAKETYPE(lut.ptr->depth(), cn));

    const cv::Mat      *arrays[] = {src.ptr, dst.ptr, 0};
    uchar              *ptrs[2] = {};
    cv::NAryMatIterator it(arrays, ptrs);
    int                 len = (int)it.size;
    if (depth == CV_16U && lut_depth == CV_8U)
      cvd::LUT16u_8u(src.ptr->ptr<ushort>(), lut.ptr->ptr<uchar>(), dst.ptr->ptr<uchar>(), len, cn, lutcn);
    else if (depth == CV_16U && lut_depth == CV_8S)
      cvd::LUT16u_8s(src.ptr->ptr<ushort>(), lut.ptr->ptr<char>(), dst.ptr->ptr<char>(), len, cn, lutcn);
    else if (depth == CV_16U && lut_depth == CV_16U)
      cvd::LUT16u_16u(src.ptr->ptr<ushort>(), lut.ptr->ptr<ushort>(), dst.ptr->ptr<ushort>(), len, cn, lutcn);
    else if (depth == CV_16U && lut_depth == CV_16S)
      cvd::LUT16u_16s(src.ptr->ptr<ushort>(), lut.ptr->ptr<short>(), dst.ptr->ptr<short>(), len, cn, lutcn);
    else if (depth == CV_16U && lut_depth == CV_32S)
      cvd::LUT16u_32s(src.ptr->ptr<ushort>(), lut.ptr->ptr<int>(), dst.ptr->ptr<int>(), len, cn, lutcn);
    else if (depth == CV_16U && lut_depth == CV_32F)
      cvd::LUT16u_32f(src.ptr->ptr<ushort>(), lut.ptr->ptr<float>(), dst.ptr->ptr<float>(), len, cn, lutcn);
    else if (depth == CV_16U && lut_depth == CV_64F)
      cvd::LUT16u_64f(src.ptr->ptr<ushort>(), lut.ptr->ptr<double>(), dst.ptr->ptr<double>(), len, cn, lutcn);
    // 16s
    else if (depth == CV_16S && lut_depth == CV_8U)
      cvd::LUT16s_8u(src.ptr->ptr<short>(), lut.ptr->ptr<uchar>(), dst.ptr->ptr<uchar>(), len, cn, lutcn);
    else if (depth == CV_16S && lut_depth == CV_8S)
      cvd::LUT16s_8s(src.ptr->ptr<short>(), lut.ptr->ptr<char>(), dst.ptr->ptr<char>(), len, cn, lutcn);
    else if (depth == CV_16S && lut_depth == CV_16U)
      cvd::LUT16s_16u(src.ptr->ptr<short>(), lut.ptr->ptr<ushort>(), dst.ptr->ptr<ushort>(), len, cn, lutcn);
    else if (depth == CV_16S && lut_depth == CV_16S)
      cvd::LUT16s_16s(src.ptr->ptr<short>(), lut.ptr->ptr<short>(), dst.ptr->ptr<short>(), len, cn, lutcn);
    else if (depth == CV_16S && lut_depth == CV_32S)
      cvd::LUT16s_32s(src.ptr->ptr<short>(), lut.ptr->ptr<int>(), dst.ptr->ptr<int>(), len, cn, lutcn);
    else if (depth == CV_16S && lut_depth == CV_32F)
      cvd::LUT16s_32f(src.ptr->ptr<short>(), lut.ptr->ptr<float>(), dst.ptr->ptr<float>(), len, cn, lutcn);
    else if (depth == CV_16S && lut_depth == CV_64F)
      cvd::LUT16s_64f(src.ptr->ptr<short>(), lut.ptr->ptr<double>(), dst.ptr->ptr<double>(), len, cn, lutcn);
    // 32s
    else if (depth == CV_32S && lut_depth == CV_32S)
      cvd::LUT32s_32s(src.ptr->ptr<int>(), lut.ptr->ptr<int>(), dst.ptr->ptr<int>(), len, cn, lutcn);
    else if (depth == CV_32S && lut_depth == CV_32F)
      cvd::LUT32s_32f(src.ptr->ptr<int>(), lut.ptr->ptr<float>(), dst.ptr->ptr<float>(), len, cn, lutcn);
    else if (depth == CV_32S && lut_depth == CV_64F)
      cvd::LUT32s_64f(src.ptr->ptr<int>(), lut.ptr->ptr<double>(), dst.ptr->ptr<double>(), len, cn, lutcn);
    else
      throw cv::Exception(cv::Error::StsNotImplemented,
                          "Unsupported combination of source and destination types", __func__, __FILE__,
                          __LINE__);
  }
  END_WRAP
}

CvStatus KMeans(Mat data, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags, Mat centers,
                double *rval)
{
  BEGIN_WRAP
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  *rval = cv::kmeans(*data.ptr, k, *bestLabels.ptr, tc, attempts, flags, *centers.ptr);
  END_WRAP
}
CvStatus KMeansPoints(VecPoint2f pts, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags,
                      Mat centers, double *rval)
{
  BEGIN_WRAP
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  *rval = cv::kmeans(*pts.ptr, k, *bestLabels.ptr, tc, attempts, flags, *centers.ptr);
  END_WRAP
}
CvStatus Rotate(Mat src, Mat dst, int rotateCode)
{
  BEGIN_WRAP
  cv::rotate(*src.ptr, *dst.ptr, rotateCode);
  END_WRAP
}
CvStatus Norm(Mat src1, int normType, double *rval)
{
  BEGIN_WRAP
  *rval = cv::norm(*src1.ptr, normType);
  END_WRAP
}
CvStatus NormWithMats(Mat src1, Mat src2, int normType, double *rval)
{
  BEGIN_WRAP
  *rval = cv::norm(*src1.ptr, *src2.ptr, normType);
  END_WRAP
}
#pragma endregion

#pragma region RNG

CvStatus Rng_New(RNG *rval)
{
  BEGIN_WRAP
  *rval = {new cv::RNG()};
  END_WRAP
}
CvStatus Rng_NewWithState(uint64_t state, RNG *rval)
{
  BEGIN_WRAP
  *rval = {new cv::RNG(state)};
  END_WRAP
}
void Rng_Close(RNG *rng){CVD_FREE(rng)}

CvStatus TheRNG(RNG *rval)
{
  BEGIN_WRAP
  *rval = {new cv::RNG(cv::theRNG())};
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
  rng.ptr->fill(*mat.ptr, distType, a, b, saturateRange);
  END_WRAP
}
CvStatus RNG_Gaussian(RNG rng, double sigma, double *rval)
{
  BEGIN_WRAP
  *rval = rng.ptr->gaussian(sigma);
  END_WRAP
}
CvStatus RNG_Uniform(RNG rng, int a, int b, int *rval)
{
  BEGIN_WRAP
  *rval = rng.ptr->uniform(a, b);
  END_WRAP
}
CvStatus RNG_UniformDouble(RNG rng, double a, double b, double *rval)
{
  BEGIN_WRAP
  *rval = rng.ptr->uniform(a, b);
  END_WRAP
}
CvStatus RNG_Next(RNG rng, uint32_t *rval)
{
  BEGIN_WRAP
  *rval = rng.ptr->next();
  END_WRAP
}
CvStatus RandN(Mat mat, Scalar mean, Scalar stddev)
{
  BEGIN_WRAP
  auto c_mean = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
  auto c_stddev = cv::Scalar(stddev.val1, stddev.val2, stddev.val3, stddev.val4);
  cv::randn(*mat.ptr, c_mean, c_stddev);
  END_WRAP
}
CvStatus RandShuffle(Mat mat)
{
  BEGIN_WRAP
  cv::randShuffle(*mat.ptr);
  END_WRAP
}
CvStatus RandShuffleWithParams(Mat mat, double iterFactor, RNG rng)
{
  BEGIN_WRAP
  cv::randShuffle(*mat.ptr, iterFactor, rng.ptr);
  END_WRAP
}
CvStatus RandU(Mat mat, Scalar low, Scalar high)
{
  BEGIN_WRAP
  auto c_low = cv::Scalar(low.val1, low.val2, low.val3, low.val4);
  auto c_high = cv::Scalar(high.val1, high.val2, high.val3, high.val4);
  cv::randu(*mat.ptr, c_low, c_high);
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
