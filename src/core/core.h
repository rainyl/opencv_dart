/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
#pragma warning(disable : 4996)
#ifndef _OPENCV3_CORE_H_
#define _OPENCV3_CORE_H_

#include <math.h>
#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
#include <opencv2/core.hpp>
#include <vector>
extern "C" {
#endif

#define CVD_OUT

#define BEGIN_WRAP try {
#define END_WRAP                                                                                             \
  CvStatus s = {.code = 0, .msg = strdup("success")};                                                        \
  return s;                                                                                                  \
  }                                                                                                          \
  catch (cv::Exception & e)                                                                                  \
  {                                                                                                          \
    CvStatus s = {                                                                                           \
        .code = e.code,                                                                                      \
        .msg = strdup(e.msg.c_str()),                                                                        \
        .err = strdup(e.err.c_str()),                                                                        \
        .func = strdup(e.func.c_str()),                                                                      \
        .file = strdup(e.file.c_str()),                                                                      \
        .line = e.line,                                                                                      \
    };                                                                                                       \
    return s;                                                                                                \
  }                                                                                                          \
  catch (std::exception & e)                                                                                 \
  {                                                                                                          \
    CvStatus s = {                                                                                           \
        .code = 1,                                                                                           \
        .msg = strdup(e.what()),                                                                             \
        .err = strdup(e.what()),                                                                             \
        .func = strdup(__FUNCTION__),                                                                        \
        .file = strdup(__FILE__),                                                                            \
        .line = __LINE__,                                                                                    \
    };                                                                                                       \
    return s;                                                                                                \
  }                                                                                                          \
  catch (...)                                                                                                \
  {                                                                                                          \
    CvStatus s = {                                                                                           \
        .code = 1,                                                                                           \
        .msg = strdup("Unknown error"),                                                                      \
        .err = strdup("Unknown error"),                                                                      \
        .func = strdup(__FUNCTION__),                                                                        \
        .file = strdup(__FILE__),                                                                            \
        .line = __LINE__,                                                                                    \
    };                                                                                                       \
    return s;                                                                                                \
  }

#define CVD_TYPECAST_C(value) reinterpret_cast<void *>(value);

#define CVD_TYPEDEF_PTR(TYPE)                                                                                \
  typedef TYPE *TYPE##Ptr;                                                                                   \
  /**                                                                                                        \
   * Dart ffigen will not generate typedefs if not referred                                                  \
   * so here we confirm they are included                                                                    \
   */                                                                                                        \
  typedef struct {                                                                                           \
    TYPE##Ptr *p;                                                                                            \
  } NO_USE_##TYPE##Ptr;

#ifdef __cplusplus
#define CVD_TYPECAST_CPP(TYPE, value) reinterpret_cast<TYPE##_CPP>(value->ptr)
#define CVD_FREE(value)                                                                                      \
  delete value->ptr;                                                                                         \
  value->ptr = nullptr;                                                                                      \
  delete value;                                                                                              \
  value = nullptr;

#define CVD_TYPEDEF(TYPE, NAME)                                                                              \
  typedef TYPE *NAME##_CPP;                                                                                  \
  typedef struct NAME {                                                                                      \
    TYPE *ptr;                                                                                               \
  } NAME;

CVD_TYPEDEF(cv::Mat, Mat)
CVD_TYPEDEF(cv::_InputOutputArray, InputOutputArray)
CVD_TYPEDEF(cv::RNG, RNG)
CVD_TYPEDEF(std::vector<cv::Point>, VecPoint)
CVD_TYPEDEF(std::vector<std::vector<cv::Point>>, VecVecPoint)
CVD_TYPEDEF(std::vector<cv::Point2f>, VecPoint2f)
CVD_TYPEDEF(std::vector<std::vector<cv::Point2f>>, VecVecPoint2f)
CVD_TYPEDEF(std::vector<cv::Point3f>, VecPoint3f)
CVD_TYPEDEF(std::vector<std::vector<cv::Point3f>>, VecVecPoint3f)
CVD_TYPEDEF(std::vector<uchar>, VecUChar)
CVD_TYPEDEF(std::vector<char>, VecChar)
CVD_TYPEDEF(std::vector<int>, VecInt)
CVD_TYPEDEF(std::vector<float>, VecFloat)
CVD_TYPEDEF(std::vector<double>, VecDouble)
CVD_TYPEDEF(std::vector<std::vector<char>>, VecVecChar)
CVD_TYPEDEF(std::vector<cv::Mat>, VecMat)
CVD_TYPEDEF(std::vector<cv::Rect>, VecRect)
CVD_TYPEDEF(std::vector<cv::KeyPoint>, VecKeyPoint)
CVD_TYPEDEF(std::vector<cv::DMatch>, VecDMatch)
CVD_TYPEDEF(std::vector<std::vector<cv::DMatch>>, VecVecDMatch)
#else
#define CVD_TYPEDEF(TYPE, NAME)                                                                              \
  typedef struct NAME {                                                                                      \
    TYPE *ptr;                                                                                               \
  } NAME;

typedef unsigned char  uchar;
typedef unsigned short ushort;

CVD_TYPEDEF(void, Mat)
CVD_TYPEDEF(void, InputOutputArray)
CVD_TYPEDEF(void, RNG)
CVD_TYPEDEF(void, VecPoint)
CVD_TYPEDEF(void, VecVecPoint)
CVD_TYPEDEF(void, VecPoint2f)
CVD_TYPEDEF(void, VecVecPoint2f)
CVD_TYPEDEF(void, VecPoint3f)
CVD_TYPEDEF(void, VecVecPoint3f)
CVD_TYPEDEF(void, VecUChar)
CVD_TYPEDEF(void, VecChar)
CVD_TYPEDEF(void, VecInt)
CVD_TYPEDEF(void, VecFloat)
CVD_TYPEDEF(void, VecDouble)
CVD_TYPEDEF(void, VecVecChar)
CVD_TYPEDEF(void, VecMat)
CVD_TYPEDEF(void, VecRect)
CVD_TYPEDEF(void, VecKeyPoint)
CVD_TYPEDEF(void, VecDMatch)
CVD_TYPEDEF(void, VecVecDMatch)
#endif

CVD_TYPEDEF_PTR(Mat)
CVD_TYPEDEF_PTR(InputOutputArray)
CVD_TYPEDEF_PTR(RNG)

// Wrapper for an individual cv::cvPoint
typedef struct Point {
  int x;
  int y;
} Point;

// Wrapper for an individual cv::Point2f
typedef struct Point2f {
  float x;
  float y;
} Point2f;

typedef struct Point3f {
  float x;
  float y;
  float z;
} Point3f;

// Wrapper for an individual cv::cvRect
typedef struct Rect {
  int x;
  int y;
  int width;
  int height;
} Rect;

typedef struct Rect2f {
  float x;
  float y;
  float width;
  float height;
} Rect2f;

// Wrapper for an individual cv::cvSize
typedef struct Size {
  int width;
  int height;
} Size;

typedef struct Size2f {
  float width;
  float height;
} Size2f;

// Wrapper for an individual cv::RotatedRect
typedef struct RotatedRect {
  Point2f center;
  Size2f  size;
  double  angle;
} RotatedRect;

// Wrapper for an individual cv::cvScalar
typedef struct Scalar {
  double val1;
  double val2;
  double val3;
  double val4;
} Scalar;

// Wrapper for a individual cv::KeyPoint
typedef struct KeyPoint {
  double x;
  double y;
  double size;
  double angle;
  double response;
  int    octave;
  int    classID;
} KeyPoint;

// Wrapper for an individual cv::DMatch
typedef struct DMatch {
  int   queryIdx;
  int   trainIdx;
  int   imgIdx;
  float distance;
} DMatch;

// Wrapper for an individual cv::Moment
typedef struct Moment {
  double m00;
  double m10;
  double m01;
  double m20;
  double m11;
  double m02;
  double m30;
  double m21;
  double m12;
  double m03;

  double mu20;
  double mu11;
  double mu02;
  double mu30;
  double mu21;
  double mu12;
  double mu03;

  double nu20;
  double nu11;
  double nu02;
  double nu30;
  double nu21;
  double nu12;
  double nu03;
} Moment;

typedef struct CvStatus {
  int   code;
  char *msg;
  char *err;
  char *func;
  char *file;
  int   line;
} CvStatus;

typedef struct Vec2b {
  uchar val1;
  uchar val2;
} Vec2b;
typedef struct Vec3b {
  uchar val1;
  uchar val2;
  uchar val3;
} Vec3b;
typedef struct Vec4b {
  uchar val1;
  uchar val2;
  uchar val3;
  uchar val4;
} Vec4b;
typedef struct Vec2s {
  short val1;
  short val2;
} Vec2s;
typedef struct Vec3s {
  short val1;
  short val2;
  short val3;
} Vec3s;
typedef struct Vec4s {
  short val1;
  short val2;
  short val3;
  short val4;
} Vec4s;
typedef struct Vec2w {
  ushort val1;
  ushort val2;
} Vec2w;
typedef struct Vec3w {
  ushort val1;
  ushort val2;
  ushort val3;
} Vec3w;
typedef struct Vec4w {
  ushort val1;
  ushort val2;
  ushort val3;
  ushort val4;
} Vec4w;
typedef struct Vec2i {
  int val1;
  int val2;
} Vec2i;
typedef struct Vec3i {
  int val1;
  int val2;
  int val3;
} Vec3i;
typedef struct Vec4i {
  int val1;
  int val2;
  int val3;
  int val4;
} Vec4i;
typedef struct Vec6i {
  int val1;
  int val2;
  int val3;
  int val4;
  int val5;
  int val6;
} Vec6i;
typedef struct Vec8i {
  int val1;
  int val2;
  int val3;
  int val4;
  int val5;
  int val6;
  int val7;
  int val8;
} Vec8i;
typedef struct Vec2f {
  float val1;
  float val2;
} Vec2f;
typedef struct Vec3f {
  float val1;
  float val2;
  float val3;
} Vec3f;
typedef struct Vec4f {
  float val1;
  float val2;
  float val3;
  float val4;
} Vec4f;
typedef struct Vec6f {
  float val1;
  float val2;
  float val3;
  float val4;
  float val5;
  float val6;
} Vec6f;
typedef struct Vec2d {
  double val1;
  double val2;
} Vec2d;
typedef struct Vec3d {
  double val1;
  double val2;
  double val3;
} Vec3d;
typedef struct Vec4d {
  double val1;
  double val2;
  double val3;
  double val4;
} Vec4d;
typedef struct Vec6d {
  double val1;
  double val2;
  double val3;
  double val4;
  double val5;
  double val6;
} Vec6d;

// Contour is alias for Points
typedef VecPoint      Contour;
typedef VecPoint2f    Contour2f;
typedef VecPoint3f    Contour3f;
typedef VecVecPoint   Contours;
typedef VecVecPoint2f Contours2f;
typedef VecVecPoint3f Contours3f;

CvStatus RotatedRect_Points(RotatedRect rect, VecPoint2f *pts);
CvStatus RotatedRect_BoundingRect(RotatedRect rect, Rect *rval);
CvStatus RotatedRect_BoundingRect2f(RotatedRect rect, Rect2f *rval);
// CvStatus noArray(InputOutputArray *rval);

// internal use
// VecPoint2f vecPointToVecPoint2f(VecPoint src);
typedef struct TermCriteria {
  int type;
  int maxCount;
  double epsilon;
} TermCriteria;

/**
 * @brief Create empty Mat

 * ALL return values with a type of `Pointer of Struct`,
 * e.g., Mat, the internal pointer (Mat.ptr) MUST be NULL
 * otherwise the memory of mat.ptr pointed to will NOT be freed correctly.
 * Mat* mat = (Mat*)malloc(sizeof(Mat));
 * CvStatus status = Mat_New(mat);
 * Mat_Close(mat);
 *
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus Mat_New(Mat *rval);
CvStatus Mat_NewWithSize(int rows, int cols, int type, Mat *rval);
CvStatus Mat_NewWithSizes(VecInt sizes, int type, Mat *rval);
CvStatus Mat_NewWithSizesFromScalar(VecInt sizes, int type, Scalar ar, Mat *rval);
CvStatus Mat_NewWithSizesFromBytes(VecInt sizes, int type, VecChar buf, Mat *rval);
CvStatus Mat_NewFromScalar(const Scalar ar, int type, Mat *rval);
CvStatus Mat_NewWithSizeFromScalar(const Scalar ar, int rows, int cols, int type, Mat *rval);
CvStatus Mat_NewFromBytes(int rows, int cols, int type, void *buf, int step, Mat *rval);
CvStatus Mat_NewFromVecPoint(VecPoint vec, Mat *rval);
CvStatus Mat_NewFromVecPoint2f(VecPoint2f vec, Mat *rval);
CvStatus Mat_NewFromVecPoint3f(VecPoint3f vec, Mat *rval);
CvStatus Mat_FromPtr(Mat m, int rows, int cols, int type, int prows, int pcols, Mat *rval);
CvStatus Mat_FromCMat(Mat m, Mat *rval);
void     Mat_Close(Mat *m);
void     Mat_CloseVoid(void *m);
CvStatus Mat_Release(Mat *m);
CvStatus Mat_Empty(Mat m, bool *rval);
CvStatus Mat_IsContinuous(Mat m, bool *rval);
CvStatus Mat_Clone(Mat m, Mat *rval);
CvStatus Mat_CopyTo(Mat m, Mat dst);
CvStatus Mat_CopyToWithMask(Mat m, Mat dst, Mat mask);
CvStatus Mat_ConvertTo(Mat m, Mat dst, int type);
CvStatus Mat_ConvertToWithParams(Mat m, Mat dst, int type, float alpha, float beta);
CvStatus Mat_ToVecUChar(Mat m, VecUChar *rval);
CvStatus Mat_ToVecChar(Mat m, VecChar *rval);
CvStatus Mat_Region(Mat m, Rect r, Mat *rval);
CvStatus Mat_Reshape(Mat m, int cn, int rows, Mat *rval);
CvStatus Mat_PatchNaNs(Mat m, double val);
CvStatus Mat_ConvertFp16(Mat m, Mat *rval);
CvStatus Mat_Mean(Mat m, Scalar *rval);
CvStatus Mat_MeanWithMask(Mat m, Mat mask, Scalar *rval);
CvStatus Mat_Sqrt(Mat m, Mat *rval);
CvStatus Mat_Rows(Mat m, int *rval);
CvStatus Mat_Cols(Mat m, int *rval);
CvStatus Mat_Channels(Mat m, int *rval);
CvStatus Mat_Type(Mat m, int *rval);
CvStatus Mat_Step(Mat m, int *rval);
CvStatus Mat_Total(Mat m, int *rval);
CvStatus Mat_Size(Mat m, VecInt *rval);
CvStatus Mat_ElemSize(Mat m, int *rval);
CvStatus Mat_Data(Mat m, VecUChar *rval);
CvStatus Mat_DataPtr(Mat m, uchar **data, int *length);
CvStatus Eye(int rows, int cols, int type, Mat *rval);
CvStatus Zeros(int rows, int cols, int type, Mat *rval);
CvStatus Ones(int rows, int cols, int type, Mat *rval);

CvStatus Mat_Ptr_u8_1(Mat m, int i, uchar **rval);
CvStatus Mat_Ptr_u8_2(Mat m, int i, int j, uchar **rval);
CvStatus Mat_Ptr_u8_3(Mat m, int i, int j, int k, uchar **rval);
CvStatus Mat_Ptr_i8_1(Mat m, int i, char **rval);
CvStatus Mat_Ptr_i8_2(Mat m, int i, int j, char **rval);
CvStatus Mat_Ptr_i8_3(Mat m, int i, int j, int k, char **rval);
CvStatus Mat_Ptr_u16_1(Mat m, int i, ushort **rval);
CvStatus Mat_Ptr_u16_2(Mat m, int i, int j, ushort **rval);
CvStatus Mat_Ptr_u16_3(Mat m, int i, int j, int k, ushort **rval);
CvStatus Mat_Ptr_i16_1(Mat m, int i, short **rval);
CvStatus Mat_Ptr_i16_2(Mat m, int i, int j, short **rval);
CvStatus Mat_Ptr_i16_3(Mat m, int i, int j, int k, short **rval);
CvStatus Mat_Ptr_i32_1(Mat m, int i, int **rval);
CvStatus Mat_Ptr_i32_2(Mat m, int i, int j, int **rval);
CvStatus Mat_Ptr_i32_3(Mat m, int i, int j, int k, int **rval);
CvStatus Mat_Ptr_f32_1(Mat m, int i, float **rval);
CvStatus Mat_Ptr_f32_2(Mat m, int i, int j, float **rval);
CvStatus Mat_Ptr_f32_3(Mat m, int i, int j, int k, float **rval);
CvStatus Mat_Ptr_f64_1(Mat m, int i, double **rval);
CvStatus Mat_Ptr_f64_2(Mat m, int i, int j, double **rval);
CvStatus Mat_Ptr_f64_3(Mat m, int i, int j, int k, double **rval);

#pragma region Mat_getter

CvStatus Mat_GetUChar(Mat m, int row, int col, uint8_t *rval);
CvStatus Mat_GetUChar3(Mat m, int x, int y, int z, uint8_t *rval);
CvStatus Mat_GetSChar(Mat m, int row, int col, int8_t *rval);
CvStatus Mat_GetSChar3(Mat m, int x, int y, int z, int8_t *rval);
CvStatus Mat_GetUShort(Mat m, int row, int col, uint16_t *rval);
CvStatus Mat_GetUShort3(Mat m, int x, int y, int z, uint16_t *rval);
CvStatus Mat_GetShort(Mat m, int row, int col, int16_t *rval);
CvStatus Mat_GetShort3(Mat m, int x, int y, int z, int16_t *rval);
CvStatus Mat_GetInt(Mat m, int row, int col, int32_t *rval);
CvStatus Mat_GetInt3(Mat m, int x, int y, int z, int32_t *rval);
CvStatus Mat_GetFloat(Mat m, int row, int col, float *rval);
CvStatus Mat_GetFloat3(Mat m, int x, int y, int z, float *rval);
CvStatus Mat_GetDouble(Mat m, int row, int col, double *rval);
CvStatus Mat_GetDouble3(Mat m, int x, int y, int z, double *rval);

CvStatus Mat_GetVec2b(Mat m, int row, int col, Vec2b *rval);
CvStatus Mat_GetVec3b(Mat m, int row, int col, Vec3b *rval);
CvStatus Mat_GetVec4b(Mat m, int row, int col, Vec4b *rval);
CvStatus Mat_GetVec2s(Mat m, int row, int col, Vec2s *rval);
CvStatus Mat_GetVec3s(Mat m, int row, int col, Vec3s *rval);
CvStatus Mat_GetVec4s(Mat m, int row, int col, Vec4s *rval);
CvStatus Mat_GetVec2w(Mat m, int row, int col, Vec2w *rval);
CvStatus Mat_GetVec3w(Mat m, int row, int col, Vec3w *rval);
CvStatus Mat_GetVec4w(Mat m, int row, int col, Vec4w *rval);
CvStatus Mat_GetVec2i(Mat m, int row, int col, Vec2i *rval);
CvStatus Mat_GetVec3i(Mat m, int row, int col, Vec3i *rval);
CvStatus Mat_GetVec4i(Mat m, int row, int col, Vec4i *rval);
CvStatus Mat_GetVec6i(Mat m, int row, int col, Vec6i *rval);
CvStatus Mat_GetVec8i(Mat m, int row, int col, Vec8i *rval);
CvStatus Mat_GetVec2f(Mat m, int row, int col, Vec2f *rval);
CvStatus Mat_GetVec3f(Mat m, int row, int col, Vec3f *rval);
CvStatus Mat_GetVec4f(Mat m, int row, int col, Vec4f *rval);
CvStatus Mat_GetVec6f(Mat m, int row, int col, Vec6f *rval);
CvStatus Mat_GetVec2d(Mat m, int row, int col, Vec2d *rval);
CvStatus Mat_GetVec3d(Mat m, int row, int col, Vec3d *rval);
CvStatus Mat_GetVec4d(Mat m, int row, int col, Vec4d *rval);
CvStatus Mat_GetVec6d(Mat m, int row, int col, Vec6d *rval);

#pragma endregion

#pragma region Mat_setter

CvStatus Mat_SetTo(Mat m, Scalar value);
CvStatus Mat_SetUChar(Mat m, int row, int col, uint8_t val);
CvStatus Mat_SetUChar3(Mat m, int x, int y, int z, uint8_t val);
CvStatus Mat_SetSChar(Mat m, int row, int col, int8_t val);
CvStatus Mat_SetSChar3(Mat m, int x, int y, int z, int8_t val);
CvStatus Mat_SetShort(Mat m, int row, int col, int16_t val);
CvStatus Mat_SetShort3(Mat m, int x, int y, int z, int16_t val);
CvStatus Mat_SetUShort(Mat m, int row, int col, uint16_t val);
CvStatus Mat_SetUShort3(Mat m, int x, int y, int z, uint16_t val);
CvStatus Mat_SetInt(Mat m, int row, int col, int32_t val);
CvStatus Mat_SetInt3(Mat m, int x, int y, int z, int32_t val);
CvStatus Mat_SetFloat(Mat m, int row, int col, float val);
CvStatus Mat_SetFloat3(Mat m, int x, int y, int z, float val);
CvStatus Mat_SetDouble(Mat m, int row, int col, double val);
CvStatus Mat_SetDouble3(Mat m, int x, int y, int z, double val);

CvStatus Mat_SetVec2b(Mat m, int row, int col, Vec2b val);
CvStatus Mat_SetVec3b(Mat m, int row, int col, Vec3b val);
CvStatus Mat_SetVec4b(Mat m, int row, int col, Vec4b val);
CvStatus Mat_SetVec2s(Mat m, int row, int col, Vec2s val);
CvStatus Mat_SetVec3s(Mat m, int row, int col, Vec3s val);
CvStatus Mat_SetVec4s(Mat m, int row, int col, Vec4s val);
CvStatus Mat_SetVec2w(Mat m, int row, int col, Vec2w val);
CvStatus Mat_SetVec3w(Mat m, int row, int col, Vec3w val);
CvStatus Mat_SetVec4w(Mat m, int row, int col, Vec4w val);
CvStatus Mat_SetVec2i(Mat m, int row, int col, Vec2i val);
CvStatus Mat_SetVec3i(Mat m, int row, int col, Vec3i val);
CvStatus Mat_SetVec4i(Mat m, int row, int col, Vec4i val);
CvStatus Mat_SetVec6i(Mat m, int row, int col, Vec6i val);
CvStatus Mat_SetVec8i(Mat m, int row, int col, Vec8i val);
CvStatus Mat_SetVec2f(Mat m, int row, int col, Vec2f val);
CvStatus Mat_SetVec3f(Mat m, int row, int col, Vec3f val);
CvStatus Mat_SetVec4f(Mat m, int row, int col, Vec4f val);
CvStatus Mat_SetVec6f(Mat m, int row, int col, Vec6f val);
CvStatus Mat_SetVec2d(Mat m, int row, int col, Vec2d val);
CvStatus Mat_SetVec3d(Mat m, int row, int col, Vec3d val);
CvStatus Mat_SetVec4d(Mat m, int row, int col, Vec4d val);
CvStatus Mat_SetVec6d(Mat m, int row, int col, Vec6d val);

#pragma endregion Mat_setter

#pragma region Mat_operation

CvStatus Mat_AddUChar(Mat m, uint8_t val);
CvStatus Mat_SubtractUChar(Mat m, uint8_t val);
CvStatus Mat_MultiplyUChar(Mat m, uint8_t val);
CvStatus Mat_DivideUChar(Mat m, uint8_t val);

CvStatus Mat_AddSChar(Mat m, int8_t val);
CvStatus Mat_SubtractSChar(Mat m, int8_t val);
CvStatus Mat_MultiplySChar(Mat m, int8_t val);
CvStatus Mat_DivideSChar(Mat m, int8_t val);

CvStatus Mat_AddI32(Mat m, int32_t val);
CvStatus Mat_SubtractI32(Mat m, int32_t val);
CvStatus Mat_MultiplyI32(Mat m, int32_t val);
CvStatus Mat_DivideI32(Mat m, int32_t val);

CvStatus Mat_AddFloat(Mat m, float_t val);
CvStatus Mat_SubtractFloat(Mat m, float_t val);
CvStatus Mat_MultiplyFloat(Mat m, float_t val);
CvStatus Mat_DivideFloat(Mat m, float_t val);

CvStatus Mat_AddF64(Mat m, double_t val);
CvStatus Mat_SubtractF64(Mat m, double_t val);
CvStatus Mat_MultiplyF64(Mat m, double_t val);
CvStatus Mat_DivideF64(Mat m, double_t val);
CvStatus Mat_MultiplyMatrix(Mat x, Mat y, Mat *rval);

CvStatus Mat_AbsDiff(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Add(Mat src1, Mat src2, Mat dst);
CvStatus Mat_AddWeighted(Mat src1, double alpha, Mat src2, double beta, double gamma, Mat dst);
CvStatus Mat_BitwiseAnd(Mat src1, Mat src2, Mat dst);
CvStatus Mat_BitwiseAndWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus Mat_BitwiseNot(Mat src1, Mat dst);
CvStatus Mat_BitwiseNotWithMask(Mat src1, Mat dst, Mat mask);
CvStatus Mat_BitwiseOr(Mat src1, Mat src2, Mat dst);
CvStatus Mat_BitwiseOrWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus Mat_BitwiseXor(Mat src1, Mat src2, Mat dst);
CvStatus Mat_BitwiseXorWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus Mat_Compare(Mat src1, Mat src2, Mat dst, int ct);
CvStatus Mat_BatchDistance(Mat src1, Mat src2, Mat dist, int dtype, Mat nidx, int normType, int K, Mat mask,
                           int update, bool crosscheck);
CvStatus Mat_BorderInterpolate(int p, int len, int borderType, int *rval);
CvStatus Mat_CalcCovarMatrix(Mat samples, Mat covar, Mat mean, int flags, int ctype);
CvStatus Mat_CartToPolar(Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees);
CvStatus Mat_CheckRange(Mat m, bool quiet, Point *pos, double minVal, double maxVal, bool *rval);
CvStatus Mat_CompleteSymm(Mat m, bool lowerToUpper);
CvStatus Mat_ConvertScaleAbs(Mat src, Mat dst, double alpha, double beta);
CvStatus Mat_CopyMakeBorder(Mat src, Mat dst, int top, int bottom, int left, int right, int borderType,
                            Scalar value);
CvStatus Mat_CountNonZero(Mat src, int *rval);
CvStatus Mat_DCT(Mat src, Mat dst, int flags);
CvStatus Mat_Determinant(Mat m, double *rval);
CvStatus Mat_DFT(Mat m, Mat dst, int flags);
CvStatus Mat_Divide(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool *rval);
CvStatus Mat_EigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors);
CvStatus Mat_PCACompute(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents);
CvStatus Mat_Exp(Mat src, Mat dst);
CvStatus Mat_ExtractChannel(Mat src, Mat dst, int coi);
CvStatus Mat_FindNonZero(Mat src, Mat idx);
CvStatus Mat_Flip(Mat src, Mat dst, int flipCode);
CvStatus Mat_Gemm(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst, int flags);
CvStatus Mat_GetOptimalDFTSize(int vecsize, int *rval);
CvStatus Mat_Hconcat(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Vconcat(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Idct(Mat src, Mat dst, int flags);
CvStatus Mat_Idft(Mat src, Mat dst, int flags, int nonzeroRows);
CvStatus Mat_InRange(Mat src, Mat lowerb, Mat upperb, Mat dst);
CvStatus Mat_InRangeWithScalar(Mat src, const Scalar lowerb, const Scalar upperb, Mat dst);
CvStatus Mat_InsertChannel(Mat src, Mat dst, int coi);
CvStatus Mat_Invert(Mat src, Mat dst, int flags, double *rval);
CvStatus Mat_Log(Mat src, Mat dst);
CvStatus Mat_Magnitude(Mat x, Mat y, Mat magnitude);
CvStatus Mat_Max(Mat src1, Mat src2, Mat dst);
CvStatus Mat_MeanStdDev(Mat src, Scalar *dstMean, Scalar *dstStdDev);
CvStatus Mat_MeanStdDevWithMask(Mat src, Scalar *dstMean, Scalar *dstStdDev, Mat mask);
CvStatus Mat_Merge(VecMat mats, Mat dst);
CvStatus Mat_Min(Mat src1, Mat src2, Mat dst);
CvStatus Mat_MinMaxIdx(Mat m, double *minVal, double *maxVal, int *minIdx, int *maxIdx);
CvStatus Mat_MinMaxLoc(Mat m, double *minVal, double *maxVal, Point *minLoc, Point *maxLoc);
CvStatus Mat_MixChannels(VecMat src, VecMat dst, VecInt fromTo);
CvStatus Mat_MulSpectrums(Mat a, Mat b, Mat c, int flags);
CvStatus Mat_Multiply(Mat src1, Mat src2, Mat dst);
CvStatus Mat_MultiplyWithParams(Mat src1, Mat src2, Mat dst, double scale, int dtype);
CvStatus Mat_Normalize(Mat src, Mat dst, double alpha, double beta, int typ);
CvStatus Mat_PerspectiveTransform(Mat src, Mat dst, Mat tm);
CvStatus Mat_Solve(Mat src1, Mat src2, Mat dst, int flags, bool *rval);
CvStatus Mat_SolveCubic(Mat coeffs, Mat roots, int *rval);
CvStatus Mat_SolvePoly(Mat coeffs, Mat roots, int maxIters, double *rval);
CvStatus Mat_Reduce(Mat src, Mat dst, int dim, int rType, int dType);
CvStatus Mat_ReduceArgMax(Mat src, Mat dst, int axis, bool lastIndex);
CvStatus Mat_ReduceArgMin(Mat src, Mat dst, int axis, bool lastIndex);
CvStatus Mat_Repeat(Mat src, int nY, int nX, Mat dst);
CvStatus Mat_ScaleAdd(Mat src1, double alpha, Mat src2, Mat dst);
CvStatus Mat_SetIdentity(Mat src, double scalar);
CvStatus Mat_Sort(Mat src, Mat dst, int flags);
CvStatus Mat_SortIdx(Mat src, Mat dst, int flags);
CvStatus Mat_Split(Mat src, VecMat *rval);
CvStatus Mat_Subtract(Mat src1, Mat src2, Mat dst);
CvStatus Mat_T(Mat x, Mat *rval);
CvStatus Mat_Trace(Mat src, Scalar *rval);
CvStatus Mat_Transform(Mat src, Mat dst, Mat tm);
CvStatus Mat_Transpose(Mat src, Mat dst);
CvStatus Mat_PolarToCart(Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees);
CvStatus Mat_Pow(Mat src, double power, Mat dst);
CvStatus Mat_Phase(Mat x, Mat y, Mat angle, bool angleInDegrees);
CvStatus Mat_Sum(Mat src, Scalar *rval);
CvStatus Mat_rowRange(Mat m, int start, int end, Mat *rval);
CvStatus Mat_colRange(Mat m, int start, int end, Mat *rval);
CvStatus LUT(Mat src, Mat lut, Mat dst);
CvStatus KMeans(Mat data, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags, Mat centers,
                double *rval);
CvStatus KMeansPoints(VecPoint2f pts, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags,
                      Mat centers, double *rval);
CvStatus Rotate(Mat src, Mat dst, int rotateCode);
CvStatus Norm(Mat src1, int normType, double *rval);
CvStatus NormWithMats(Mat src1, Mat src2, int normType, double *rval);
#pragma endregion

#pragma region RNG

CvStatus Rng_New(RNG *rval);
CvStatus Rng_NewWithState(uint64_t state, RNG *rval);
void     Rng_Close(RNG *rng);
CvStatus TheRNG(RNG *rval);
CvStatus SetRNGSeed(int seed);
CvStatus RNG_Fill(RNG rng, Mat mat, int distType, double a, double b, bool saturateRange);
CvStatus RNG_Gaussian(RNG rng, double sigma, double *rval);
CvStatus RNG_Uniform(RNG rng, int a, int b, int *rval);
CvStatus RNG_UniformDouble(RNG rng, double a, double b, double *rval);
CvStatus RNG_Next(RNG rng, uint32_t *rval);
CvStatus RandN(Mat mat, Scalar mean, Scalar stddev);
CvStatus RandShuffle(Mat mat);
CvStatus RandShuffleWithParams(Mat mat, double iterFactor, RNG rng);
CvStatus RandU(Mat mat, Scalar low, Scalar high);
#pragma endregion

CvStatus GetCVTickCount(int64_t *rval);
CvStatus GetTickFrequency(double *rval);
CvStatus SetNumThreads(int n);
CvStatus GetNumThreads(int *rval);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_CORE_H_
