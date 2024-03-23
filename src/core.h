/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#pragma warning(disable : 4996)
#ifndef _OPENCV3_CORE_H_
#define _OPENCV3_CORE_H_

#include "math.h"
#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

// #if 0 || defined WIN32 || defined _WIN32
// #define BEGIN_WRAP
// #define END_WRAP              \
//     CvStatus s = {.code = 0}; \
//     return s;
// #else
#define BEGIN_WRAP \
  try {
#define END_WRAP                                      \
  CvStatus s = {.code = 0, .msg = strdup("success")}; \
  return s;                                           \
  }                                                   \
  catch (cv::Exception & e)                           \
  {                                                   \
    CvStatus s = {                                    \
        .code = e.code,                               \
        .msg = strdup(e.msg.c_str()),                 \
        .err = strdup(e.err.c_str()),                 \
        .func = strdup(e.func.c_str()),               \
        .file = strdup(e.file.c_str()),               \
        .line = e.line,                               \
    };                                                \
    return s;                                         \
  }                                                   \
  catch (std::exception & e)                          \
  {                                                   \
    CvStatus s = {                                    \
        .code = 1,                                    \
        .msg = strdup(e.what()),                      \
        .err = strdup(e.what()),                      \
        .func = strdup(__FUNCTION__),                 \
        .file = strdup(__FILE__),                     \
        .line = __LINE__,                             \
    };                                                \
    return s;                                         \
  }                                                   \
  catch (...)                                         \
  {                                                   \
    CvStatus s = {                                    \
        .code = 1,                                    \
        .msg = strdup("Unknown error"),               \
        .err = strdup("Unknown error"),               \
        .func = strdup(__FUNCTION__),                 \
        .file = strdup(__FILE__),                     \
        .line = __LINE__,                             \
    };                                                \
    return s;                                         \
  }
// #endif

typedef int CV_STATUS;

// Wrapper for std::vector<string>
typedef struct CStrings {
  char **strs;
  int    length;
} CStrings;

typedef struct ByteArray {
  char *data;
  int   length;
} ByteArray;

// Wrapper for std::vector<int>
typedef struct IntVector {
  int *val;
  int  length;
} IntVector;

// Wrapper for std::vector<float>
typedef struct FloatVector {
  float *val;
  int    length;
} FloatVector;

typedef struct RawData {
  int       width;
  int       height;
  ByteArray data;
} RawData;

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

// Wrapper for an individual cv::cvPoint
typedef struct Point {
  int x;
  int y;
} Point;

// Wrapper for the vector of Point structs aka std::vector<Point>
typedef struct Points {
  Point *points;
  int    length;
} Points;

// Wrapper for the vector of Point2f structs aka std::vector<Point2f>
typedef struct Points2f {
  Point2f *points;
  int      length;
} Points2f;

typedef struct Points3f {
  Point3f *points;
  int      length;
} Points3f;

// Contour is alias for Points
typedef Points Contour;

// Contour2f is alias for Points2f
typedef Points2f Contour2f;

typedef struct Contours2f {
  Contour2f *contours;
  int        length;
} Contours2f;

// Contour3f is alias for Points3f
typedef Points3f Contour3f;

// Wrapper for the vector of Points3f vectors aka std::vector<
// std::vector<Point3f> >
typedef struct Contours3f {
  Contour3f *contours;
  int        length;
} Contours3f;

// Wrapper for the vector of Points vectors aka std::vector< std::vector<Point>
// >
typedef struct Contours {
  Contour *contours;
  int      length;
} Contours;

// Wrapper for an individual cv::cvRect
typedef struct Rect {
  int x;
  int y;
  int width;
  int height;
} Rect;

// Wrapper for the vector of Rect struct aka std::vector<Rect>
typedef struct Rects {
  Rect *rects;
  int   length;
} Rects;

// Wrapper for an individual cv::cvSize
typedef struct Size {
  int width;
  int height;
} Size;

// Wrapper for an individual cv::RotatedRect
typedef struct RotatedRect {
  Points pts;
  Rect   boundingRect;
  Point  center;
  Size   size;
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
  double x;
  double y;
  double size;
  double angle;
  double response;
  int    octave;
  int    classID;
} KeyPoint;

// Wrapper for the vector of KeyPoint struct aka std::vector<KeyPoint>
typedef struct KeyPoints {
  KeyPoint *keypoints;
  int       length;
} KeyPoints;

// Wrapper for SimpleBlobDetectorParams aka SimpleBlobDetector::Params
typedef struct SimpleBlobDetectorParams {
  unsigned char blobColor;
  bool          filterByArea;
  bool          filterByCircularity;
  bool          filterByColor;
  bool          filterByConvexity;
  bool          filterByInertia;
  float         maxArea;
  float         maxCircularity;
  float         maxConvexity;
  float         maxInertiaRatio;
  float         maxThreshold;
  float         minArea;
  float         minCircularity;
  float         minConvexity;
  float         minDistBetweenBlobs;
  float         minInertiaRatio;
  size_t        minRepeatability;
  float         minThreshold;
  float         thresholdStep;
} SimpleBlobDetectorParams;

// Wrapper for an individual cv::DMatch
typedef struct DMatch {
  int   queryIdx;
  int   trainIdx;
  int   imgIdx;
  float distance;
} DMatch;

// Wrapper for the vector of DMatch struct aka std::vector<DMatch>
typedef struct DMatches {
  DMatch *dmatches;
  int     length;
} DMatches;

// Wrapper for the vector vector of DMatch struct aka
// std::vector<std::vector<DMatch>>
typedef struct MultiDMatches {
  DMatches *dmatches;
  int       length;
} MultiDMatches;

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

#ifdef __cplusplus
typedef cv::Mat                               *Mat;
typedef cv::_InputOutputArray                 *InputOutputArray;
typedef cv::TermCriteria                      *TermCriteria;
typedef cv::RNG                               *RNG;
typedef std::vector<cv::Point>                *PointVector;
typedef std::vector<std::vector<cv::Point>>   *PointsVector;
typedef std::vector<cv::Point2f>              *Point2fVector;
typedef std::vector<std::vector<cv::Point2f>> *Points2fVector;
typedef std::vector<cv::Point3f>              *Point3fVector;
typedef std::vector<std::vector<cv::Point3f>> *Points3fVector;
typedef std::vector<uchar>                    *UCharVector;
typedef cv::Exception                         *CvException;
#else
typedef void         *Mat;
typedef void         *InputOutputArray;
typedef void         *TermCriteria;
typedef void         *RNG;
typedef void         *PointVector;
typedef void         *PointsVector;
typedef void         *Point2fVector;
typedef void         *Points2fVector;
typedef void         *Point3fVector;
typedef void         *Points3fVector;
typedef void         *UCharVector;
typedef unsigned char uchar;
typedef void         *CvException;
#endif

typedef struct CvStatus {
  int   code;
  char *msg;
  char *err;
  char *func;
  char *file;
  int   line;
} CvStatus;

InputOutputArray noArray();
// Wrapper for the vector of Mat aka std::vector<Mat>
typedef struct Mats {
  Mat *mats;
  int  length;
} Mats;

CvStatus Mats_New(Mats *rval);
// void Mats_Append(Mats mats, Mat mat);
CvStatus Mats_get(Mats mats, int i, Mat *rval);
CvStatus MultiDMatches_get(MultiDMatches mds, int index, DMatches *rval);

ByteArray toByteArray(const char *buf, int len);
void      ByteArray_Release(ByteArray buf);

void Contours_Close(Contours cs);
void KeyPoints_Close(KeyPoints ks);
void Rects_Close(Rects rs);
void Mats_Close(Mats mats);
void Point_Close(Point p);
void Point2f_Close(Point2f p);
void Point3f_Close(Point3f p);
void Points_Close(Points ps);
void DMatches_Close(DMatches ds);
void MultiDMatches_Close(MultiDMatches mds);

CvStatus Mat_New(Mat *rval);
CvStatus Mat_NewWithSize(int rows, int cols, int type, Mat *rval);
CvStatus Mat_NewWithSizes(IntVector sizes, int type, Mat *rval);
CvStatus Mat_NewWithSizesFromScalar(IntVector sizes, int type, Scalar ar, Mat *rval);
CvStatus Mat_NewWithSizesFromBytes(IntVector sizes, int type, ByteArray buf, Mat *rval);
CvStatus Mat_NewFromScalar(const Scalar ar, int type, Mat *rval);
CvStatus Mat_NewWithSizeFromScalar(const Scalar ar, int rows, int cols, int type, Mat *rval);
CvStatus Mat_NewFromBytes(int rows, int cols, int type, ByteArray buf, Mat *rval);
CvStatus Mat_FromPtr(Mat m, int rows, int cols, int type, int prows, int pcols, Mat *rval);
void     Mat_Close(Mat m);
CvStatus Mat_Empty(Mat m, bool *rval);
CvStatus Mat_IsContinuous(Mat m, bool *rval);
CvStatus Mat_Clone(Mat m, Mat *rval);
CvStatus Mat_CopyTo(Mat m, Mat dst);
CvStatus Mat_CopyToWithMask(Mat m, Mat dst, Mat mask);
CvStatus Mat_ConvertTo(Mat m, Mat dst, int type);
CvStatus Mat_ConvertToWithParams(Mat m, Mat dst, int type, float alpha, float beta);
CvStatus Mat_ToBytes(Mat m, ByteArray *rval);
CvStatus Mat_DataPtr(Mat m, ByteArray *rval);
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
CvStatus Mat_Size(Mat m, IntVector *rval);
CvStatus Mat_ElemSize(Mat m, int *rval);
CvStatus Eye(int rows, int cols, int type, Mat *rval);
CvStatus Zeros(int rows, int cols, int type, Mat *rval);
CvStatus Ones(int rows, int cols, int type, Mat *rval);

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
CvStatus Mat_GetFloat(Mat m, int row, int col);
CvStatus Mat_GetFloat3(Mat m, int x, int y, int z);
CvStatus Mat_GetDouble(Mat m, int row, int col);
CvStatus Mat_GetDouble3(Mat m, int x, int y, int z);

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

#pragma endregion Mat_setter

#pragma region Mat_operation

CvStatus Mat_AddUChar(Mat m, uint8_t val);
CvStatus Mat_SubtractUChar(Mat m, uint8_t val);
CvStatus Mat_MultiplyUChar(Mat m, uint8_t val);
CvStatus Mat_DivideUChar(Mat m, uint8_t val);

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
CvStatus Mat_MultiplyMatrix(Mat x, Mat y, Mat rval);

CvStatus Mat_T(Mat x, Mat *rval);
CvStatus LUT(Mat src, Mat lut, Mat dst);

CvStatus Mat_AbsDiff(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Add(Mat src1, Mat src2, Mat dst);
CvStatus Mat_AddWeighted(Mat src1, double alpha, Mat src2, double beta,
                         double gamma, Mat dst);
CvStatus Mat_BitwiseAnd(Mat src1, Mat src2, Mat dst);
CvStatus Mat_BitwiseAndWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus Mat_BitwiseNot(Mat src1, Mat dst);
CvStatus Mat_BitwiseNotWithMask(Mat src1, Mat dst, Mat mask);
CvStatus Mat_BitwiseOr(Mat src1, Mat src2, Mat dst);
CvStatus Mat_BitwiseOrWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus Mat_BitwiseXor(Mat src1, Mat src2, Mat dst);
CvStatus Mat_BitwiseXorWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus Mat_Compare(Mat src1, Mat src2, Mat dst, int ct);
CvStatus Mat_BatchDistance(Mat src1, Mat src2, Mat dist, int dtype, Mat nidx,
                           int normType, int K, Mat mask, int update,
                           bool crosscheck);
CvStatus Mat_BorderInterpolate(int p, int len, int borderType, int *rval);
CvStatus Mat_CalcCovarMatrix(Mat samples, Mat covar, Mat mean, int flags,
                             int ctype);
CvStatus Mat_CartToPolar(Mat x, Mat y, Mat magnitude, Mat angle,
                         bool angleInDegrees);
CvStatus Mat_CheckRange(Mat m, bool quiet, Point *pos, double minVal,
                        double maxVal, bool *rval);
CvStatus Mat_CompleteSymm(Mat m, bool lowerToUpper);
CvStatus Mat_ConvertScaleAbs(Mat src, Mat dst, double alpha, double beta);
CvStatus Mat_CopyMakeBorder(Mat src, Mat dst, int top, int bottom, int left,
                            int right, int borderType, Scalar value);
CvStatus Mat_CountNonZero(Mat src, int *rval);
CvStatus Mat_DCT(Mat src, Mat dst, int flags);
CvStatus Mat_Determinant(Mat m, double *rval);
CvStatus Mat_DFT(Mat m, Mat dst, int flags);
CvStatus Mat_Divide(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool *rval);
CvStatus Mat_EigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors);
CvStatus Mat_PCACompute(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues,
                        int maxComponents);
CvStatus Mat_Exp(Mat src, Mat dst);
CvStatus Mat_ExtractChannel(Mat src, Mat dst, int coi);
CvStatus Mat_FindNonZero(Mat src, Mat idx);
CvStatus Mat_Flip(Mat src, Mat dst, int flipCode);
CvStatus Mat_Gemm(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst,
                  int flags);
CvStatus Mat_GetOptimalDFTSize(int vecsize, int *rval);
CvStatus Mat_Hconcat(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Vconcat(Mat src1, Mat src2, Mat dst);
CvStatus Rotate(Mat src, Mat dst, int rotationCode);
CvStatus Mat_Idct(Mat src, Mat dst, int flags);
CvStatus Mat_Idft(Mat src, Mat dst, int flags, int nonzeroRows);
CvStatus Mat_InRange(Mat src, Mat lowerb, Mat upperb, Mat dst);
CvStatus Mat_InRangeWithScalar(Mat src, const Scalar lowerb, const Scalar upperb,
                               Mat dst);
CvStatus Mat_InsertChannel(Mat src, Mat dst, int coi);
CvStatus Mat_Invert(Mat src, Mat dst, int flags, double *rval);
CvStatus KMeans(Mat data, int k, Mat bestLabels, TermCriteria criteria,
                int attempts, int flags, Mat centers, double *rval);
CvStatus KMeansPoints(PointVector pts, int k, Mat bestLabels,
                      TermCriteria criteria, int attempts, int flags,
                      Mat centers, double *rval);
CvStatus Mat_Log(Mat src, Mat dst);
CvStatus Mat_Magnitude(Mat x, Mat y, Mat magnitude);
CvStatus Mat_Max(Mat src1, Mat src2, Mat dst);
CvStatus Mat_MeanStdDev(Mat src, Mat dstMean, Mat dstStdDev);
CvStatus Mat_Merge(Mats mats, Mat dst);
CvStatus Mat_Min(Mat src1, Mat src2, Mat dst);
CvStatus Mat_MinMaxIdx(Mat m, double *minVal, double *maxVal, int *minIdx,
                       int *maxIdx);
CvStatus Mat_MinMaxLoc(Mat m, double *minVal, double *maxVal, Point *minLoc,
                       Point *maxLoc);
CvStatus Mat_MixChannels(Mats src, Mats dst, IntVector fromTo);
CvStatus Mat_MulSpectrums(Mat a, Mat b, Mat c, int flags);
CvStatus Mat_Multiply(Mat src1, Mat src2, Mat dst);
CvStatus Mat_MultiplyWithParams(Mat src1, Mat src2, Mat dst, double scale,
                                int dtype);
CvStatus Mat_Normalize(Mat src, Mat dst, double alpha, double beta, int typ);
CvStatus Norm(Mat src1, int normType, double *rval);
CvStatus NormWithMats(Mat src1, Mat src2, int normType, double *rval);
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
CvStatus Mat_Split(Mat src, Mats *mats);
CvStatus Mat_Subtract(Mat src1, Mat src2, Mat dst);
CvStatus Mat_Trace(Mat src, Scalar *rval);
CvStatus Mat_Transform(Mat src, Mat dst, Mat tm);
CvStatus Mat_Transpose(Mat src, Mat dst);
CvStatus Mat_PolarToCart(Mat magnitude, Mat degree, Mat x, Mat y,
                         bool angleInDegrees);
CvStatus Mat_Pow(Mat src, double power, Mat dst);
CvStatus Mat_Phase(Mat x, Mat y, Mat angle, bool angleInDegrees);
CvStatus Mat_Sum(Mat src1, Scalar *rval);

#pragma endregion

TermCriteria TermCriteria_New(int typ, int maxCount, double epsilon);

int64_t GetCVTickCount();
double  GetTickFrequency();

Mat Mat_rowRange(Mat m, int startrow, int endrow);
Mat Mat_colRange(Mat m, int startrow, int endrow);

PointVector PointVector_New();
PointVector PointVector_NewFromPoints(Contour points);
PointVector PointVector_NewFromMat(Mat mat);
Point       PointVector_At(PointVector pv, int idx);
void        PointVector_Append(PointVector pv, Point p);
int         PointVector_Size(PointVector pv);
void        PointVector_Close(PointVector pv);

PointsVector PointsVector_New();
PointsVector PointsVector_NewFromPoints(Contours points);
PointVector  PointsVector_At(PointsVector psv, int idx);
void         PointsVector_Append(PointsVector psv, PointVector pv);
int          PointsVector_Size(PointsVector psv);
void         PointsVector_Close(PointsVector psv);

Point2fVector Point2fVector_New();
void          Point2fVector_Close(Point2fVector pfv);
Point2fVector Point2fVector_NewFromPoints(Contour2f pts);
Point2fVector Point2fVector_NewFromMat(Mat mat);
void          Point2fVector_Append(Point2fVector pv, Point2f p);
Point2f       Point2fVector_At(Point2fVector pfv, int idx);
int           Point2fVector_Size(Point2fVector pfv);

// IntVector* IntVector_New();
void IntVector_Close(IntVector ivec);

// FloatVector* FloatVector_New();
void FloatVector_Close(FloatVector ivec);

void CStrings_Close(CStrings cstrs);

RNG  Rng_New();
RNG  Rng_NewWithState(uint64_t state);
void Rng_Close(RNG rng);
RNG  TheRNG();

void SetRNGSeed(int seed);

void RNG_Fill(RNG rng, Mat mat, int distType, double a, double b,
              bool saturateRange);

double RNG_Gaussian(RNG rng, double sigma);
int    RNG_Uniform(RNG rng, int a, int b);
double RNG_UniformDouble(RNG rng, double a, double b);

unsigned int RNG_Next(RNG rng);

void RandN(Mat mat, Scalar mean, Scalar stddev);

void RandShuffle(Mat mat);

void RandShuffleWithParams(Mat mat, double iterFactor, RNG rng);

void RandU(Mat mat, Scalar low, Scalar high);

void copyPointVectorToPoint2fVector(PointVector src, Point2fVector dest);

void     StdByteVectorInitialize(void *data);
void     StdByteVectorFree(void *data);
size_t   StdByteVectorLen(void *data);
uint8_t *StdByteVectorData(void *data);

UCharVector UCharVector_New();
void        UCharVector_Free(UCharVector vec);
int         UCharVector_Size(UCharVector vec);
void        UCharVector_Append(UCharVector vec, uchar c);
uchar       UCharVector_At(UCharVector vec, int idx);
// uchar UCharVector_GetData(UCharVector vec);

Points2fVector Points2fVector_New();
Points2fVector Points2fVector_NewFromPoints(Contours2f points);
int            Points2fVector_Size(Points2fVector ps);
Point2fVector  Points2fVector_At(Points2fVector ps, int idx);
void           Points2fVector_Append(Points2fVector psv, Point2fVector pv);
void           Points2fVector_Close(Points2fVector ps);

Point3fVector  Point3fVector_New();
Point3fVector  Point3fVector_NewFromPoints(Contour3f points);
Point3fVector  Point3fVector_NewFromMat(Mat mat);
void           Point3fVector_Append(Point3fVector pfv, Point3f point);
Point3f        Point3fVector_At(Point3fVector pfv, int idx);
int            Point3fVector_Size(Point3fVector pfv);
void           Point3fVector_Close(Point3fVector pv);
Points3fVector Points3fVector_New();
Points3fVector Points3fVector_NewFromPoints(Contours3f points);
int            Points3fVector_Size(Points3fVector ps);
Point3fVector  Points3fVector_At(Points3fVector ps, int idx);
void           Points3fVector_Append(Points3fVector psv, Point3fVector pv);
void           Points3fVector_Close(Points3fVector ps);

void SetNumThreads(int n);
int  GetNumThreads();

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_CORE_H_
