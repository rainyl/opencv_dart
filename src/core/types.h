/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_CORE_TYPES_H_
#define CVD_CORE_TYPES_H_

// https://developercommunity.visualstudio.com/t/__imp___std_init_once_complete-unresolve/1684365#T-N10041864
#if _MSC_VER >= 1932 // Visual Studio 2022 version 17.2+
#    pragma comment(linker, "/alternatename:__imp___std_init_once_complete=__imp_InitOnceComplete")
#    pragma comment(linker, "/alternatename:__imp___std_init_once_begin_initialize=__imp_InitOnceBeginInitialize")
#endif

#include <math.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
#include <opencv2/core.hpp>
#include <vector>
extern "C" {
#endif

#define CVD_OUT

#define BEGIN_WRAP try {
#define END_WRAP                                                                                   \
  CvStatus *s = new CvStatus{                                                                      \
      .code = 0,                                                                                   \
      .msg = strdup("success"),                                                                    \
      .err = strdup(""),                                                                           \
      .func = strdup(__FUNCTION__),                                                                \
      .file = strdup(__FILE__),                                                                    \
      .line = __LINE__,                                                                            \
  };                                                                                               \
  return s;                                                                                        \
  }                                                                                                \
  catch (cv::Exception & e) {                                                                      \
    CvStatus *s = new CvStatus{                                                                    \
        .code = e.code,                                                                            \
        .msg = strdup(e.msg.c_str()),                                                              \
        .err = strdup(e.err.c_str()),                                                              \
        .func = strdup(e.func.c_str()),                                                            \
        .file = strdup(e.file.c_str()),                                                            \
        .line = e.line,                                                                            \
    };                                                                                             \
    return s;                                                                                      \
  }                                                                                                \
  catch (std::exception & e) {                                                                     \
    CvStatus *s = new CvStatus{                                                                    \
        .code = 1,                                                                                 \
        .msg = strdup(e.what()),                                                                   \
        .err = strdup(e.what()),                                                                   \
        .func = strdup(__FUNCTION__),                                                              \
        .file = strdup(__FILE__),                                                                  \
        .line = __LINE__,                                                                          \
    };                                                                                             \
    return s;                                                                                      \
  }                                                                                                \
  catch (...) {                                                                                    \
    CvStatus *s = new CvStatus{                                                                    \
        .code = 1,                                                                                 \
        .msg = strdup("Unknown error"),                                                            \
        .err = strdup("Unknown error"),                                                            \
        .func = strdup(__FUNCTION__),                                                              \
        .file = strdup(__FILE__),                                                                  \
        .line = __LINE__,                                                                          \
    };                                                                                             \
    return s;                                                                                      \
  }

#define CVD_TYPECAST_C(value) reinterpret_cast<void *>(value)
#define CVD_CALLBACK_DEF(value) typedef void (*value##Callback)(value *)

#define CVD_TYPEDEF_VEC(TYPE, NAME)                                                                \
  typedef struct NAME {                                                                            \
    TYPE *ptr;                                                                                     \
    size_t length;                                                                                 \
  } NAME;                                                                                          \
  typedef NAME *NAME##Ptr;

#ifdef __cplusplus
#define CVD_TYPECAST_CPP(TYPE, value) reinterpret_cast<TYPE##_CPP>(value->ptr)
// for test, value should not be freed here
#ifdef CVD_ENABLE_TEST
#define CVD_FREE(value)                                                                            \
  delete value->ptr;                                                                               \
  value->ptr = nullptr;
#else
// for dart ffi, value should be freed here or a memory leak will occur
#define CVD_FREE(value)                                                                            \
  delete value->ptr;                                                                               \
  value->ptr = nullptr;                                                                            \
  delete value;                                                                                    \
  value = nullptr;
#endif

#define CVD_TYPEDEF(TYPE, NAME)                                                                    \
  typedef TYPE *NAME##_CPP;                                                                        \
  typedef struct NAME {                                                                            \
    TYPE *ptr;                                                                                     \
  } NAME;                                                                                          \
  typedef NAME *NAME##Ptr;                                                                         \
  // CVD_CALLBACK_DEF(NAME)

CVD_TYPEDEF(cv::Mat, Mat);
CVD_TYPEDEF(cv::_InputOutputArray, InputOutputArray);
CVD_TYPEDEF(cv::RNG, RNG);
#else
#define CVD_TYPEDEF(TYPE, NAME)                                                                    \
  typedef struct NAME {                                                                            \
    TYPE *ptr;                                                                                     \
  } NAME;                                                                                          \
  typedef NAME *NAME##Ptr;                                                                         \
  // CVD_CALLBACK_DEF(NAME)

typedef unsigned char uchar;
typedef unsigned short ushort;

CVD_TYPEDEF(void, Mat);
CVD_TYPEDEF(void, InputOutputArray);
CVD_TYPEDEF(void, RNG);
#endif

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

typedef struct Point3i {
  int x;
  int y;
  int z;
} Point3i;

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
  Size2f size;
  double angle;
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
  float x;
  float y;
  float size;
  float angle;
  float response;
  int octave;
  int classID;
} KeyPoint;

// Wrapper for an individual cv::DMatch
typedef struct DMatch {
  int queryIdx;
  int trainIdx;
  int imgIdx;
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
  int code;
  char *msg;
  char *err;
  char *func;
  char *file;
  int line;
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

typedef struct TermCriteria {
  int type;
  int maxCount;
  double epsilon;
} TermCriteria;

typedef union Cv32suf_C {
  int i;
  unsigned u;
  float f;
} Cv32suf_C;

typedef union Cv16suf_C {
  short i;
  ushort u;
} Cv16suf_C;

typedef struct MatStep {
  size_t p[3];
} MatStep;

typedef void (*CvCallback_0)();
typedef void (*CvCallback_1)(void *);
typedef void (*CvCallback_2)(void *, void *);
typedef void (*CvCallback_3)(void *, void *, void *);
typedef void (*CvCallback_4)(void *, void *, void *, void *);
typedef void (*CvCallback_5)(void *, void *, void *, void *, void *);
typedef void (*CvCallback_6)(void *, void *, void *, void *, void *, void *);
typedef void (*CvCallback_7)(void *, void *, void *, void *, void *, void *, void *);
typedef void (*CvCallback_8)(void *, void *, void *, void *, void *, void *, void *, void *);
typedef void (*CvCallback_9)(void *, void *, void *, void *, void *, void *, void *, void *, void *);

CVD_TYPEDEF_VEC(uchar, VecUChar);
CVD_TYPEDEF_VEC(char, VecChar);
CVD_TYPEDEF_VEC(uint8_t, VecU8);
CVD_TYPEDEF_VEC(int8_t, VecI8);
CVD_TYPEDEF_VEC(uint16_t, VecU16);
CVD_TYPEDEF_VEC(int16_t, VecI16);
CVD_TYPEDEF_VEC(int32_t, VecI32);
CVD_TYPEDEF_VEC(float_t, VecF32);
CVD_TYPEDEF_VEC(double_t, VecF64);
CVD_TYPEDEF_VEC(uint16_t, VecF16);
CVD_TYPEDEF_VEC(VecChar, VecVecChar);
CVD_TYPEDEF_VEC(Mat, VecMat);
CVD_TYPEDEF_VEC(Point, VecPoint);
CVD_TYPEDEF_VEC(Point2f, VecPoint2f);
CVD_TYPEDEF_VEC(Point3f, VecPoint3f);
CVD_TYPEDEF_VEC(Point3i, VecPoint3i);
CVD_TYPEDEF_VEC(VecPoint, VecVecPoint);
CVD_TYPEDEF_VEC(VecPoint2f, VecVecPoint2f);
CVD_TYPEDEF_VEC(VecPoint3f, VecVecPoint3f);
CVD_TYPEDEF_VEC(VecPoint3i, VecVecPoint3i);
CVD_TYPEDEF_VEC(Rect, VecRect);
CVD_TYPEDEF_VEC(RotatedRect, VecRotatedRect);
CVD_TYPEDEF_VEC(KeyPoint, VecKeyPoint);
CVD_TYPEDEF_VEC(DMatch, VecDMatch);
CVD_TYPEDEF_VEC(VecDMatch, VecVecDMatch);
CVD_TYPEDEF_VEC(Vec4i, VecVec4i);
CVD_TYPEDEF_VEC(Vec4f, VecVec4f);
CVD_TYPEDEF_VEC(Vec6f, VecVec6f);

// Contour is alias for Points
typedef VecPoint Contour;
typedef VecPoint2f Contour2f;
typedef VecPoint3f Contour3f;
typedef VecVecPoint Contours;
typedef VecVecPoint2f Contours2f;
typedef VecVecPoint3f Contours3f;

#ifdef __cplusplus
}
#endif

#endif // CVD_CORE_TYPES_H_
