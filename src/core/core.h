/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma warning(disable : 4996)
#ifndef _OPENCV3_CORE_H_
#define _OPENCV3_CORE_H_

#include "types.h"

#ifdef __cplusplus
extern "C" {
#endif

CvStatus *RotatedRect_Points(RotatedRect rect, VecPoint2f *pts);
CvStatus *RotatedRect_BoundingRect(RotatedRect rect, Rect *rval);
CvStatus *RotatedRect_BoundingRect2f(RotatedRect rect, Rect2f *rval);
// CvStatus *noArray(InputOutputArray *rval);

// internal use
// VecPoint2f vecPointToVecPoint2f(VecPoint src);

void CvStatus_Close(CvStatus *self);

/**
 * @brief Create empty Mat

 * ALL return values with a type of `Pointer of Struct`,
 * e.g., Mat, the internal pointer (Mat.ptr) MUST be NULL
 * otherwise the memory of mat.ptr pointed to will NOT be freed correctly.
 * Mat* mat = (Mat*)malloc(sizeof(Mat));
 * CvStatus *status = Mat_New(mat);
 * Mat_Close(mat);
 *
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus *Mat_New(Mat *rval);
CvStatus *Mat_NewWithSize(int rows, int cols, int type, Mat *rval);
CvStatus *Mat_NewWithSizes(VecI32 sizes, int type, Mat *rval);
CvStatus *Mat_NewWithSizesFromScalar(VecI32 sizes, int type, Scalar ar, Mat *rval);
CvStatus *Mat_NewWithSizesFromBytes(VecI32 sizes, int type, void *buf, Mat *rval);
CvStatus *Mat_NewFromScalar(const Scalar ar, int rows, int cols, int type, Mat *rval);
CvStatus *Mat_NewFromBytes(int rows, int cols, int type, void *buf, Mat *rval);
CvStatus *Mat_NewFromVecPoint(VecPoint vec, Mat *rval);
CvStatus *Mat_NewFromVecPoint2f(VecPoint2f vec, Mat *rval);
CvStatus *Mat_NewFromVecPoint3f(VecPoint3f vec, Mat *rval);
CvStatus *Mat_NewFromVecPoint3i(VecPoint3i vec, Mat *rval);

CvStatus *Mat_toVecPoint(Mat self, VecPoint *vec);
CvStatus *Mat_toVecPoint2f(Mat self, VecPoint2f *vec);
CvStatus *Mat_toVecPoint3f(Mat self, VecPoint3f *vec);
CvStatus *Mat_toVecPoint3i(Mat self, VecPoint3i *vec);

CvStatus *Mat_toString(
    Mat self,
    int fmtType,
    int f16Precision,
    int f32Precision,
    int f64Precision,
    bool multiLine,
    char **rval
);

CvStatus *Mat_FromPtr(Mat m, int rows, int cols, int type, int prows, int pcols, Mat *rval);
CvStatus *Mat_FromCMat(Mat m, Mat *rval);
CvStatus *Mat_FromRange(Mat m, int rowStart, int rowEnd, int colStart, int colEnd, Mat *rval);
void Mat_Close(MatPtr m);
void Mat_CloseVoid(void *m);
CvStatus *Mat_Release(Mat *m);

int Mat_Flags(Mat m);
bool Mat_Empty(Mat m);
bool Mat_IsContinuous(Mat m);
bool Mat_IsSubmatrix(Mat m);
int Mat_Rows(Mat m);
int Mat_Cols(Mat m);
int Mat_Channels(Mat m);
int Mat_Type(Mat m);
MatStep Mat_Step(Mat m);
size_t Mat_Total(Mat m);
VecI32 *Mat_Size(Mat m);
size_t Mat_ElemSize(Mat m);
size_t Mat_ElemSize1(Mat m);
int Mat_Dims(Mat m);
uchar *Mat_Data(Mat m);
// CvStatus *Mat_DataPtr(Mat m, uchar **data, int *length);

CvStatus *Mat_AdjustROI(Mat m, int dtop, int dbottom, int dleft, int dright, Mat *rval);
CvStatus *Mat_LocateROI(Mat m, Size *wholeSize, Point *ofs);
CvStatus *Mat_Clone(Mat m, Mat *rval);
CvStatus *Mat_Col(Mat m, int x, Mat *rval);
CvStatus *Mat_Row(Mat m, int y, Mat *rval);
CvStatus *Mat_CopyTo(Mat m, Mat dst);
CvStatus *Mat_CopyToWithMask(Mat m, Mat dst, Mat mask);
CvStatus *Mat_ConvertTo(Mat m, Mat dst, int type);
CvStatus *Mat_ConvertToWithParams(Mat m, Mat dst, int type, float alpha, float beta);
CvStatus *Mat_ToVecUChar(Mat m, VecUChar *rval);
CvStatus *Mat_ToVecChar(Mat m, VecChar *rval);
CvStatus *Mat_Region(Mat m, Rect r, Mat *rval);
CvStatus *Mat_Reshape(Mat m, int cn, int rows, Mat *rval);
CvStatus *Mat_ReshapeByVec(Mat m, int cn, VecI32 newshape, Mat *rval);
CvStatus *Mat_PatchNaNs(Mat m, double val);
CvStatus *Mat_ConvertFp16(Mat m, Mat *rval);
CvStatus *Mat_Mean(Mat m, Scalar *rval);
CvStatus *Mat_MeanWithMask(Mat m, Mat mask, Scalar *rval);
CvStatus *Mat_Sqrt(Mat m, Mat *rval);

CvStatus *Eye(int rows, int cols, int type, Mat *rval);
CvStatus *Zeros(int rows, int cols, int type, Mat *rval);
CvStatus *Ones(int rows, int cols, int type, Mat *rval);

uchar *Mat_Ptr_u8_1(Mat m, int i);
uchar *Mat_Ptr_u8_2(Mat m, int i, int j);
uchar *Mat_Ptr_u8_3(Mat m, int i, int j, int k);

#pragma region Mat_getter

CvStatus *Mat_GetUChar(Mat m, int row, int col, uint8_t *rval);
CvStatus *Mat_GetUChar3(Mat m, int x, int y, int z, uint8_t *rval);
CvStatus *Mat_GetSChar(Mat m, int row, int col, int8_t *rval);
CvStatus *Mat_GetSChar3(Mat m, int x, int y, int z, int8_t *rval);
CvStatus *Mat_GetUShort(Mat m, int row, int col, uint16_t *rval);
CvStatus *Mat_GetUShort3(Mat m, int x, int y, int z, uint16_t *rval);
CvStatus *Mat_GetShort(Mat m, int row, int col, int16_t *rval);
CvStatus *Mat_GetShort3(Mat m, int x, int y, int z, int16_t *rval);
CvStatus *Mat_GetInt(Mat m, int row, int col, int32_t *rval);
CvStatus *Mat_GetInt3(Mat m, int x, int y, int z, int32_t *rval);
CvStatus *Mat_GetFloat(Mat m, int row, int col, float *rval);
CvStatus *Mat_GetFloat3(Mat m, int x, int y, int z, float *rval);
CvStatus *Mat_GetDouble(Mat m, int row, int col, double *rval);
CvStatus *Mat_GetDouble3(Mat m, int x, int y, int z, double *rval);

Vec2b *Mat_GetVec2b(Mat m, int row, int col);
Vec3b *Mat_GetVec3b(Mat m, int row, int col);
Vec4b *Mat_GetVec4b(Mat m, int row, int col);
Vec2s *Mat_GetVec2s(Mat m, int row, int col);
Vec3s *Mat_GetVec3s(Mat m, int row, int col);
Vec4s *Mat_GetVec4s(Mat m, int row, int col);
Vec2w *Mat_GetVec2w(Mat m, int row, int col);
Vec3w *Mat_GetVec3w(Mat m, int row, int col);
Vec4w *Mat_GetVec4w(Mat m, int row, int col);
Vec2i *Mat_GetVec2i(Mat m, int row, int col);
Vec3i *Mat_GetVec3i(Mat m, int row, int col);
Vec4i *Mat_GetVec4i(Mat m, int row, int col);
Vec6i *Mat_GetVec6i(Mat m, int row, int col);
Vec8i *Mat_GetVec8i(Mat m, int row, int col);
Vec2f *Mat_GetVec2f(Mat m, int row, int col);
Vec3f *Mat_GetVec3f(Mat m, int row, int col);
Vec4f *Mat_GetVec4f(Mat m, int row, int col);
Vec6f *Mat_GetVec6f(Mat m, int row, int col);
Vec2d *Mat_GetVec2d(Mat m, int row, int col);
Vec3d *Mat_GetVec3d(Mat m, int row, int col);
Vec4d *Mat_GetVec4d(Mat m, int row, int col);
Vec6d *Mat_GetVec6d(Mat m, int row, int col);

#pragma endregion

#pragma region Mat_setter

CvStatus *Mat_SetTo(Mat m, Scalar value, Mat mask);
CvStatus *Mat_SetUChar(Mat m, int row, int col, uint8_t val);
CvStatus *Mat_SetUChar3(Mat m, int x, int y, int z, uint8_t val);
CvStatus *Mat_SetSChar(Mat m, int row, int col, int8_t val);
CvStatus *Mat_SetSChar3(Mat m, int x, int y, int z, int8_t val);
CvStatus *Mat_SetShort(Mat m, int row, int col, int16_t val);
CvStatus *Mat_SetShort3(Mat m, int x, int y, int z, int16_t val);
CvStatus *Mat_SetUShort(Mat m, int row, int col, uint16_t val);
CvStatus *Mat_SetUShort3(Mat m, int x, int y, int z, uint16_t val);
CvStatus *Mat_SetInt(Mat m, int row, int col, int32_t val);
CvStatus *Mat_SetInt3(Mat m, int x, int y, int z, int32_t val);
CvStatus *Mat_SetFloat(Mat m, int row, int col, float val);
CvStatus *Mat_SetFloat3(Mat m, int x, int y, int z, float val);
CvStatus *Mat_SetDouble(Mat m, int row, int col, double val);
CvStatus *Mat_SetDouble3(Mat m, int x, int y, int z, double val);

CvStatus *Mat_SetVec2b(Mat m, int row, int col, Vec2b val);
CvStatus *Mat_SetVec3b(Mat m, int row, int col, Vec3b val);
CvStatus *Mat_SetVec4b(Mat m, int row, int col, Vec4b val);
CvStatus *Mat_SetVec2s(Mat m, int row, int col, Vec2s val);
CvStatus *Mat_SetVec3s(Mat m, int row, int col, Vec3s val);
CvStatus *Mat_SetVec4s(Mat m, int row, int col, Vec4s val);
CvStatus *Mat_SetVec2w(Mat m, int row, int col, Vec2w val);
CvStatus *Mat_SetVec3w(Mat m, int row, int col, Vec3w val);
CvStatus *Mat_SetVec4w(Mat m, int row, int col, Vec4w val);
CvStatus *Mat_SetVec2i(Mat m, int row, int col, Vec2i val);
CvStatus *Mat_SetVec3i(Mat m, int row, int col, Vec3i val);
CvStatus *Mat_SetVec4i(Mat m, int row, int col, Vec4i val);
CvStatus *Mat_SetVec6i(Mat m, int row, int col, Vec6i val);
CvStatus *Mat_SetVec8i(Mat m, int row, int col, Vec8i val);
CvStatus *Mat_SetVec2f(Mat m, int row, int col, Vec2f val);
CvStatus *Mat_SetVec3f(Mat m, int row, int col, Vec3f val);
CvStatus *Mat_SetVec4f(Mat m, int row, int col, Vec4f val);
CvStatus *Mat_SetVec6f(Mat m, int row, int col, Vec6f val);
CvStatus *Mat_SetVec2d(Mat m, int row, int col, Vec2d val);
CvStatus *Mat_SetVec3d(Mat m, int row, int col, Vec3d val);
CvStatus *Mat_SetVec4d(Mat m, int row, int col, Vec4d val);
CvStatus *Mat_SetVec6d(Mat m, int row, int col, Vec6d val);

#pragma endregion Mat_setter

#pragma region Mat_operation

CvStatus *Mat_AddMat(Mat m, Mat val);
CvStatus *Mat_SubtractMat(Mat m, Mat val);
CvStatus *Mat_MultiplyMat(Mat m, Mat val);
CvStatus *Mat_Mul(Mat m, Mat val, Mat *dst, double scale);
CvStatus *Mat_DivideMat(Mat m, Mat val);

CvStatus *Mat_AddUChar(Mat m, uint8_t val);
CvStatus *Mat_SubtractUChar(Mat m, uint8_t val);
CvStatus *Mat_MultiplyUChar(Mat m, uint8_t val);
CvStatus *Mat_DivideUChar(Mat m, uint8_t val);

CvStatus *Mat_AddSChar(Mat m, int8_t val);
CvStatus *Mat_SubtractSChar(Mat m, int8_t val);
CvStatus *Mat_MultiplySChar(Mat m, int8_t val);
CvStatus *Mat_DivideSChar(Mat m, int8_t val);

CvStatus *Mat_AddI16(Mat m, int16_t val);
CvStatus *Mat_SubtractI16(Mat m, int16_t val);
CvStatus *Mat_MultiplyI16(Mat m, int16_t val);
CvStatus *Mat_DivideI16(Mat m, int16_t val);

CvStatus *Mat_AddU16(Mat m, uint16_t val);
CvStatus *Mat_SubtractU16(Mat m, uint16_t val);
CvStatus *Mat_MultiplyU16(Mat m, uint16_t val);
CvStatus *Mat_DivideU16(Mat m, uint16_t val);

CvStatus *Mat_AddI32(Mat m, int32_t val);
CvStatus *Mat_SubtractI32(Mat m, int32_t val);
CvStatus *Mat_MultiplyI32(Mat m, int32_t val);
CvStatus *Mat_DivideI32(Mat m, int32_t val);

CvStatus *Mat_AddFloat(Mat m, float_t val);
CvStatus *Mat_SubtractFloat(Mat m, float_t val);
CvStatus *Mat_MultiplyFloat(Mat m, float_t val);
CvStatus *Mat_DivideFloat(Mat m, float_t val);

CvStatus *Mat_AddF64(Mat m, double_t val);
CvStatus *Mat_SubtractF64(Mat m, double_t val);
CvStatus *Mat_MultiplyF64(Mat m, double_t val);
CvStatus *Mat_DivideF64(Mat m, double_t val);
CvStatus *Mat_MultiplyMatrix(Mat x, Mat y, Mat *rval);

CvStatus *Mat_AbsDiff(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Add(Mat src1, Mat src2, Mat dst, Mat mask, int dtype);
CvStatus *
Mat_AddWeighted(Mat src1, double alpha, Mat src2, double beta, double gamma, Mat dst, int dtype);
CvStatus *Mat_BitwiseAnd(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_BitwiseAndWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_BitwiseNot(Mat src1, Mat dst);
CvStatus *Mat_BitwiseNotWithMask(Mat src1, Mat dst, Mat mask);
CvStatus *Mat_BitwiseOr(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_BitwiseOrWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_BitwiseXor(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_BitwiseXorWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_Compare(Mat src1, Mat src2, Mat dst, int ct);
CvStatus *Mat_BatchDistance(
    Mat src1,
    Mat src2,
    Mat dist,
    int dtype,
    Mat nidx,
    int normType,
    int K,
    Mat mask,
    int update,
    bool crosscheck
);
CvStatus *Mat_BorderInterpolate(int p, int len, int borderType, int *rval);
CvStatus *Mat_CalcCovarMatrix(Mat samples, Mat covar, Mat mean, int flags, int ctype);
CvStatus *Mat_CartToPolar(Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees);
CvStatus *Mat_CheckRange(Mat m, bool quiet, Point *pos, double minVal, double maxVal, bool *rval);
CvStatus *Mat_CompleteSymm(Mat m, bool lowerToUpper);
CvStatus *Mat_ConvertScaleAbs(Mat src, Mat dst, double alpha, double beta);
CvStatus *Mat_CopyMakeBorder(
    Mat src, Mat dst, int top, int bottom, int left, int right, int borderType, Scalar value
);
int  Mat_CountNonZero(Mat src);
CvStatus *Mat_DCT(Mat src, Mat dst, int flags);
CvStatus *Mat_Determinant(Mat m, double *rval);
CvStatus *Mat_DFT(Mat src, Mat dst, int flags, int nonzeroRows);
CvStatus *Mat_Divide(Mat src1, Mat src2, Mat dst, double scale, int dtype);
CvStatus *Mat_Eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool *rval);
CvStatus *Mat_EigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors);
CvStatus *Mat_PCACompute(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents);
CvStatus *Mat_Exp(Mat src, Mat dst);
CvStatus *Mat_ExtractChannel(Mat src, Mat dst, int coi);
CvStatus *Mat_FindNonZero(Mat src, Mat idx);
CvStatus *Mat_Flip(Mat src, Mat dst, int flipCode);
CvStatus *Mat_Gemm(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst, int flags);
CvStatus *Mat_GetOptimalDFTSize(int vecsize, int *rval);
CvStatus *Mat_Hconcat(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Vconcat(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Idct(Mat src, Mat dst, int flags);
CvStatus *Mat_Idft(Mat src, Mat dst, int flags, int nonzeroRows);
CvStatus *Mat_InRange(Mat src, Mat lowerb, Mat upperb, Mat dst);
CvStatus *Mat_InRangeWithScalar(Mat src, const Scalar lowerb, const Scalar upperb, Mat dst);
CvStatus *Mat_InsertChannel(Mat src, Mat dst, int coi);
CvStatus *Mat_Invert(Mat src, Mat dst, int flags, double *rval);
CvStatus *Mat_Log(Mat src, Mat dst);
CvStatus *Mat_Magnitude(Mat x, Mat y, Mat magnitude);
CvStatus *Mat_Max(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_MeanStdDev(Mat src, Scalar *dstMean, Scalar *dstStdDev);
CvStatus *Mat_MeanStdDevWithMask(Mat src, Scalar *dstMean, Scalar *dstStdDev, Mat mask);
CvStatus *Mat_Merge(VecMat mats, Mat *dst);
CvStatus *Mat_Min(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_MinMaxIdx(Mat m, double *minVal, double *maxVal, int *minIdx, int *maxIdx);
CvStatus *Mat_MinMaxLoc(Mat m, double *minVal, double *maxVal, Point *minLoc, Point *maxLoc);
CvStatus *Mat_MixChannels(VecMat src, VecMat dst, VecI32 fromTo);
CvStatus *Mat_MulSpectrums(Mat a, Mat b, Mat c, int flags, bool conjB);
CvStatus *Mat_Multiply(Mat src1, Mat src2, Mat dst, double scale, int dtype);
CvStatus *Mat_Normalize(Mat src, Mat dst, double alpha, double beta, int typ, int dtype, Mat mask);
CvStatus *Mat_PerspectiveTransform(Mat src, Mat dst, Mat tm);
CvStatus *Mat_Solve(Mat src1, Mat src2, Mat dst, int flags, bool *rval);
CvStatus *Mat_SolveCubic(Mat coeffs, Mat roots, int *rval);
CvStatus *Mat_SolvePoly(Mat coeffs, Mat roots, int maxIters, double *rval);
CvStatus *Mat_Reduce(Mat src, Mat dst, int dim, int rType, int dType);
CvStatus *Mat_ReduceArgMax(Mat src, Mat dst, int axis, bool lastIndex);
CvStatus *Mat_ReduceArgMin(Mat src, Mat dst, int axis, bool lastIndex);
CvStatus *Mat_Repeat(Mat src, int nY, int nX, Mat dst);
CvStatus *Mat_ScaleAdd(Mat src1, double alpha, Mat src2, Mat dst);
CvStatus *Mat_SetIdentity(Mat src, double scalar);
CvStatus *Mat_Sort(Mat src, Mat dst, int flags);
CvStatus *Mat_SortIdx(Mat src, Mat dst, int flags);
CvStatus *Mat_Split(Mat src, VecMat *rval);
CvStatus *Mat_Subtract(Mat src1, Mat src2, Mat dst, Mat mask, int dtype);
CvStatus *Mat_T(Mat x, Mat *rval);
CvStatus *Mat_Trace(Mat src, Scalar *rval);
CvStatus *Mat_Transform(Mat src, Mat dst, Mat tm);
CvStatus *Mat_Transpose(Mat src, Mat dst);
CvStatus *Mat_PolarToCart(Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees);
CvStatus *Mat_Pow(Mat src, double power, Mat dst);
CvStatus *Mat_Phase(Mat x, Mat y, Mat angle, bool angleInDegrees);
CvStatus *Mat_Sum(Mat src, Scalar *rval);
CvStatus *Mat_rowRange(Mat m, int start, int end, Mat *rval);
CvStatus *Mat_colRange(Mat m, int start, int end, Mat *rval);
CvStatus *LUT(Mat src, Mat lut, Mat dst);
CvStatus *KMeans(
    Mat data,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    Mat centers,
    double *rval
);
CvStatus *KMeansPoints(
    VecPoint2f pts,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    Mat centers,
    double *rval
);
CvStatus *Rotate(Mat src, Mat dst, int rotateCode);
CvStatus *Norm(Mat src1, int normType, Mat mask, double *rval);
CvStatus *NormWithMats(Mat src1, Mat src2, int normType, Mat mask, double *rval);
#pragma endregion

#pragma region RNG

CvStatus *Rng_New(RNG *rval);
CvStatus *Rng_NewWithState(uint64_t state, RNG *rval);
void Rng_Close(RNGPtr rng);
CvStatus *TheRNG(RNG *rval);
CvStatus *SetRNGSeed(int seed);
CvStatus *RNG_Fill(RNG rng, Mat mat, int distType, double a, double b, bool saturateRange);
CvStatus *RNG_Gaussian(RNG rng, double sigma, double *rval);
CvStatus *RNG_Uniform(RNG rng, int a, int b, int *rval);
CvStatus *RNG_UniformDouble(RNG rng, double a, double b, double *rval);
CvStatus *RNG_Next(RNG rng, uint32_t *rval);
CvStatus *RandN(Mat mat, Scalar mean, Scalar stddev);
CvStatus *RandShuffle(Mat mat);
CvStatus *RandShuffleWithParams(Mat mat, double iterFactor, RNG rng);
CvStatus *RandU(Mat mat, Scalar low, Scalar high);
#pragma endregion

CvStatus *GetCVTickCount(int64_t *rval);
CvStatus *GetTickFrequency(double *rval);
CvStatus *SetNumThreads(int n);
CvStatus *GetNumThreads(int *rval);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_CORE_H_
