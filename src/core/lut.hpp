/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include <opencv2/opencv.hpp>

namespace cvd
{
#define LUT_BODY                                                                                             \
  if (lutcn == 1) {                                                                                          \
    for (int i = 0; i < len * cn; i++)                                                                       \
      dst[i] = lut[src[i]];                                                                                  \
  } else {                                                                                                   \
    for (int i = 0; i < len * cn; i += cn)                                                                   \
      for (int k = 0; k < cn; k++)                                                                           \
        dst[i + k] = lut[src[i + k] * cn + k];                                                               \
  }

// NOTE: opencv doesn't support LUT from CV_8U or CV_8S to CV_16F now
static void LUT8u_16f(const uchar *src, const cv::hfloat *lut, cv::hfloat *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT8s_16f(const char *src, const cv::hfloat *lut, cv::hfloat *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

// 16u
static void LUT16u_8u(const ushort *src, const uchar *lut, uchar *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}
static void LUT16u_8s(const ushort *src, const char *lut, char *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}
static void LUT16u_16u(const ushort *src, const ushort *lut, ushort *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16u_16s(const ushort *src, const short *lut, short *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16u_32s(const ushort *src, const int *lut, int *dst, int len, int cn, int lutcn) { LUT_BODY }

static void LUT16u_32f(const ushort *src, const float *lut, float *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16u_64f(const ushort *src, const double *lut, double *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16u_16f(const ushort *src, const cv::hfloat *lut, cv::hfloat *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

// 16s
static void LUT16s_8u(const short *src, const uchar *lut, uchar *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}
static void LUT16s_8s(const short *src, const char *lut, char *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}
static void LUT16s_16u(const short *src, const ushort *lut, ushort *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16s_16s(const short *src, const short *lut, short *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16s_32s(const short *src, const int *lut, int *dst, int len, int cn, int lutcn) { LUT_BODY }

static void LUT16s_32f(const short *src, const float *lut, float *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16s_64f(const short *src, const double *lut, double *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

static void LUT16s_16f(const short *src, const cv::hfloat *lut, cv::hfloat *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

// 32s
static void LUT32s_32s(const int *src, const int *lut, int *dst, int len, int cn, int lutcn) { LUT_BODY }

static void LUT32s_32f(const int *src, const float *lut, float *dst, int len, int cn, int lutcn) { LUT_BODY }

static void LUT32s_64f(const int *src, const double *lut, double *dst, int len, int cn, int lutcn)
{
  LUT_BODY
}

} // namespace cvd
