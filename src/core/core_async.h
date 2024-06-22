/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ASYNC_CORE_H
#define CVD_ASYNC_CORE_H

#include "core/types.h"
#ifdef __cplusplus
extern "C" {
#endif
// CvStatus *RotatedRect_Points_Async(RotatedRect rect, CvCallback1 callback);
// CvStatus *RotatedRect_BoundingRect_Async(RotatedRect rect, CvCallback1 callback);
// CvStatus *RotatedRect_BoundingRect2f_Async(RotatedRect rect, CvCallback1 callback);

CvStatus *Mat_New_Async(CvCallback_1 callback);
CvStatus *Mat_NewWithSize_Async(int rows, int cols, int type, CvCallback_1 callback);
CvStatus *Mat_NewWithSizes_Async(VecInt sizes, int type, CvCallback_1 callback);
CvStatus *Mat_NewWithSizesFromScalar_Async(VecInt sizes, int type, Scalar ar, CvCallback_1 callback);
CvStatus *Mat_NewWithSizesFromBytes_Async(VecInt sizes, int type, VecChar buf, CvCallback_1 callback);
CvStatus *Mat_NewFromScalar_Async(const Scalar ar, int type, CvCallback_1 callback);
CvStatus *Mat_NewWithSizeFromScalar_Async(const Scalar ar, int rows, int cols, int type,
                                          CvCallback_1 callback);
CvStatus *Mat_NewFromBytes_Async(int rows, int cols, int type, void *buf, int step, CvCallback_1 callback);
CvStatus *Mat_NewFromVecPoint_Async(VecPoint vec, CvCallback_1 callback);
CvStatus *Mat_NewFromVecPoint2f_Async(VecPoint2f vec, CvCallback_1 callback);
CvStatus *Mat_NewFromVecPoint3f_Async(VecPoint3f vec, CvCallback_1 callback);
CvStatus *Mat_FromPtr_Async(Mat m, int rows, int cols, int type, int prows, int pcols, CvCallback_1 callback);
CvStatus *Mat_FromCMat_Async(Mat m, CvCallback_1 callback);

// functions without return values shouldn't have callbacks?
void Mat_Close_Async(MatPtr m, CvCallback_0 callback);
// TODO
CvStatus *Mat_Release_Async(Mat *m);
CvStatus *Mat_Empty_Async(Mat m, bool *rval);
CvStatus *Mat_IsContinuous_Async(Mat m, bool *rval);
CvStatus *Mat_Clone_Async(Mat m, CvCallback_1 callback);
CvStatus *Mat_CopyTo_Async(Mat m, Mat dst);
CvStatus *Mat_CopyToWithMask_Async(Mat m, Mat dst, Mat mask);
CvStatus *Mat_ConvertTo_Async(Mat m, Mat dst, int type);
CvStatus *Mat_ConvertToWithParams_Async(Mat m, Mat dst, int type, float alpha, float beta);
CvStatus *Mat_ToVecUChar_Async(Mat m, VecUChar *rval);
CvStatus *Mat_ToVecChar_Async(Mat m, VecChar *rval);
CvStatus *Mat_Region_Async(Mat m, Rect r, CvCallback_1 callback);
CvStatus *Mat_Reshape_Async(Mat m, int cn, int rows, CvCallback_1 callback);
CvStatus *Mat_PatchNaNs_Async(Mat m, double val);
CvStatus *Mat_ConvertFp16_Async(Mat m, CvCallback_1 callback);
CvStatus *Mat_Mean_Async(Mat m, Scalar *rval);
CvStatus *Mat_MeanWithMask_Async(Mat m, Mat mask, Scalar *rval);
CvStatus *Mat_Sqrt_Async(Mat m, CvCallback_1 callback);
CvStatus *Mat_Rows_Async(Mat m, int *rval);
CvStatus *Mat_Cols_Async(Mat m, int *rval);
CvStatus *Mat_Channels_Async(Mat m, int *rval);
CvStatus *Mat_Type_Async(Mat m, int *rval);
CvStatus *Mat_Step_Async(Mat m, int *rval);
CvStatus *Mat_Total_Async(Mat m, int *rval);
CvStatus *Mat_Size_Async(Mat m, VecInt *rval);
CvStatus *Mat_ElemSize_Async(Mat m, int *rval);
CvStatus *Mat_Data_Async(Mat m, VecUChar *rval);
CvStatus *Mat_DataPtr_Async(Mat m, uchar **data, int *length);
CvStatus *Eye_Async(int rows, int cols, int type, CvCallback_1 callback);
CvStatus *Zeros_Async(int rows, int cols, int type, CvCallback_1 callback);
CvStatus *Ones_Async(int rows, int cols, int type, CvCallback_1 callback);

CvStatus *Mat_Ptr_u8_1_Async(Mat m, int i, uchar **rval);
CvStatus *Mat_Ptr_u8_2_Async(Mat m, int i, int j, uchar **rval);
CvStatus *Mat_Ptr_u8_3_Async(Mat m, int i, int j, int k, uchar **rval);
CvStatus *Mat_Ptr_i8_1_Async(Mat m, int i, char **rval);
CvStatus *Mat_Ptr_i8_2_Async(Mat m, int i, int j, char **rval);
CvStatus *Mat_Ptr_i8_3_Async(Mat m, int i, int j, int k, char **rval);
CvStatus *Mat_Ptr_u16_1_Async(Mat m, int i, ushort **rval);
CvStatus *Mat_Ptr_u16_2_Async(Mat m, int i, int j, ushort **rval);
CvStatus *Mat_Ptr_u16_3_Async(Mat m, int i, int j, int k, ushort **rval);
CvStatus *Mat_Ptr_i16_1_Async(Mat m, int i, short **rval);
CvStatus *Mat_Ptr_i16_2_Async(Mat m, int i, int j, short **rval);
CvStatus *Mat_Ptr_i16_3_Async(Mat m, int i, int j, int k, short **rval);
CvStatus *Mat_Ptr_i32_1_Async(Mat m, int i, int **rval);
CvStatus *Mat_Ptr_i32_2_Async(Mat m, int i, int j, int **rval);
CvStatus *Mat_Ptr_i32_3_Async(Mat m, int i, int j, int k, int **rval);
CvStatus *Mat_Ptr_f32_1_Async(Mat m, int i, float **rval);
CvStatus *Mat_Ptr_f32_2_Async(Mat m, int i, int j, float **rval);
CvStatus *Mat_Ptr_f32_3_Async(Mat m, int i, int j, int k, float **rval);
CvStatus *Mat_Ptr_f64_1_Async(Mat m, int i, double **rval);
CvStatus *Mat_Ptr_f64_2_Async(Mat m, int i, int j, double **rval);
CvStatus *Mat_Ptr_f64_3_Async(Mat m, int i, int j, int k, double **rval);

#pragma region Mat_getter

CvStatus *Mat_GetUChar_Async(Mat m, int row, int col, uint8_t *rval);
CvStatus *Mat_GetUChar3_Async(Mat m, int x, int y, int z, uint8_t *rval);
CvStatus *Mat_GetSChar_Async(Mat m, int row, int col, int8_t *rval);
CvStatus *Mat_GetSChar3_Async(Mat m, int x, int y, int z, int8_t *rval);
CvStatus *Mat_GetUShort_Async(Mat m, int row, int col, uint16_t *rval);
CvStatus *Mat_GetUShort3_Async(Mat m, int x, int y, int z, uint16_t *rval);
CvStatus *Mat_GetShort_Async(Mat m, int row, int col, int16_t *rval);
CvStatus *Mat_GetShort3_Async(Mat m, int x, int y, int z, int16_t *rval);
CvStatus *Mat_GetInt_Async(Mat m, int row, int col, int32_t *rval);
CvStatus *Mat_GetInt3_Async(Mat m, int x, int y, int z, int32_t *rval);
CvStatus *Mat_GetFloat_Async(Mat m, int row, int col, float *rval);
CvStatus *Mat_GetFloat3_Async(Mat m, int x, int y, int z, float *rval);
CvStatus *Mat_GetDouble_Async(Mat m, int row, int col, double *rval);
CvStatus *Mat_GetDouble3_Async(Mat m, int x, int y, int z, double *rval);

CvStatus *Mat_GetVec2b_Async(Mat m, int row, int col, Vec2b *rval);
CvStatus *Mat_GetVec3b_Async(Mat m, int row, int col, Vec3b *rval);
CvStatus *Mat_GetVec4b_Async(Mat m, int row, int col, Vec4b *rval);
CvStatus *Mat_GetVec2s_Async(Mat m, int row, int col, Vec2s *rval);
CvStatus *Mat_GetVec3s_Async(Mat m, int row, int col, Vec3s *rval);
CvStatus *Mat_GetVec4s_Async(Mat m, int row, int col, Vec4s *rval);
CvStatus *Mat_GetVec2w_Async(Mat m, int row, int col, Vec2w *rval);
CvStatus *Mat_GetVec3w_Async(Mat m, int row, int col, Vec3w *rval);
CvStatus *Mat_GetVec4w_Async(Mat m, int row, int col, Vec4w *rval);
CvStatus *Mat_GetVec2i_Async(Mat m, int row, int col, Vec2i *rval);
CvStatus *Mat_GetVec3i_Async(Mat m, int row, int col, Vec3i *rval);
CvStatus *Mat_GetVec4i_Async(Mat m, int row, int col, Vec4i *rval);
CvStatus *Mat_GetVec6i_Async(Mat m, int row, int col, Vec6i *rval);
CvStatus *Mat_GetVec8i_Async(Mat m, int row, int col, Vec8i *rval);
CvStatus *Mat_GetVec2f_Async(Mat m, int row, int col, Vec2f *rval);
CvStatus *Mat_GetVec3f_Async(Mat m, int row, int col, Vec3f *rval);
CvStatus *Mat_GetVec4f_Async(Mat m, int row, int col, Vec4f *rval);
CvStatus *Mat_GetVec6f_Async(Mat m, int row, int col, Vec6f *rval);
CvStatus *Mat_GetVec2d_Async(Mat m, int row, int col, Vec2d *rval);
CvStatus *Mat_GetVec3d_Async(Mat m, int row, int col, Vec3d *rval);
CvStatus *Mat_GetVec4d_Async(Mat m, int row, int col, Vec4d *rval);
CvStatus *Mat_GetVec6d_Async(Mat m, int row, int col, Vec6d *rval);

#pragma endregion

#pragma region Mat_setter

CvStatus *Mat_SetTo_Async(Mat m, Scalar value);
CvStatus *Mat_SetUChar_Async(Mat m, int row, int col, uint8_t val);
CvStatus *Mat_SetUChar3_Async(Mat m, int x, int y, int z, uint8_t val);
CvStatus *Mat_SetSChar_Async(Mat m, int row, int col, int8_t val);
CvStatus *Mat_SetSChar3_Async(Mat m, int x, int y, int z, int8_t val);
CvStatus *Mat_SetShort_Async(Mat m, int row, int col, int16_t val);
CvStatus *Mat_SetShort3_Async(Mat m, int x, int y, int z, int16_t val);
CvStatus *Mat_SetUShort_Async(Mat m, int row, int col, uint16_t val);
CvStatus *Mat_SetUShort3_Async(Mat m, int x, int y, int z, uint16_t val);
CvStatus *Mat_SetInt_Async(Mat m, int row, int col, int32_t val);
CvStatus *Mat_SetInt3_Async(Mat m, int x, int y, int z, int32_t val);
CvStatus *Mat_SetFloat_Async(Mat m, int row, int col, float val);
CvStatus *Mat_SetFloat3_Async(Mat m, int x, int y, int z, float val);
CvStatus *Mat_SetDouble_Async(Mat m, int row, int col, double val);
CvStatus *Mat_SetDouble3_Async(Mat m, int x, int y, int z, double val);

CvStatus *Mat_SetVec2b_Async(Mat m, int row, int col, Vec2b val);
CvStatus *Mat_SetVec3b_Async(Mat m, int row, int col, Vec3b val);
CvStatus *Mat_SetVec4b_Async(Mat m, int row, int col, Vec4b val);
CvStatus *Mat_SetVec2s_Async(Mat m, int row, int col, Vec2s val);
CvStatus *Mat_SetVec3s_Async(Mat m, int row, int col, Vec3s val);
CvStatus *Mat_SetVec4s_Async(Mat m, int row, int col, Vec4s val);
CvStatus *Mat_SetVec2w_Async(Mat m, int row, int col, Vec2w val);
CvStatus *Mat_SetVec3w_Async(Mat m, int row, int col, Vec3w val);
CvStatus *Mat_SetVec4w_Async(Mat m, int row, int col, Vec4w val);
CvStatus *Mat_SetVec2i_Async(Mat m, int row, int col, Vec2i val);
CvStatus *Mat_SetVec3i_Async(Mat m, int row, int col, Vec3i val);
CvStatus *Mat_SetVec4i_Async(Mat m, int row, int col, Vec4i val);
CvStatus *Mat_SetVec6i_Async(Mat m, int row, int col, Vec6i val);
CvStatus *Mat_SetVec8i_Async(Mat m, int row, int col, Vec8i val);
CvStatus *Mat_SetVec2f_Async(Mat m, int row, int col, Vec2f val);
CvStatus *Mat_SetVec3f_Async(Mat m, int row, int col, Vec3f val);
CvStatus *Mat_SetVec4f_Async(Mat m, int row, int col, Vec4f val);
CvStatus *Mat_SetVec6f_Async(Mat m, int row, int col, Vec6f val);
CvStatus *Mat_SetVec2d_Async(Mat m, int row, int col, Vec2d val);
CvStatus *Mat_SetVec3d_Async(Mat m, int row, int col, Vec3d val);
CvStatus *Mat_SetVec4d_Async(Mat m, int row, int col, Vec4d val);
CvStatus *Mat_SetVec6d_Async(Mat m, int row, int col, Vec6d val);

#pragma endregion Mat_setter

#pragma region Mat_operation

CvStatus *Mat_AddUChar_Async(Mat m, uint8_t val);
CvStatus *Mat_SubtractUChar_Async(Mat m, uint8_t val);
CvStatus *Mat_MultiplyUChar_Async(Mat m, uint8_t val);
CvStatus *Mat_DivideUChar_Async(Mat m, uint8_t val);

CvStatus *Mat_AddSChar_Async(Mat m, int8_t val);
CvStatus *Mat_SubtractSChar_Async(Mat m, int8_t val);
CvStatus *Mat_MultiplySChar_Async(Mat m, int8_t val);
CvStatus *Mat_DivideSChar_Async(Mat m, int8_t val);

CvStatus *Mat_AddI32_Async(Mat m, int32_t val);
CvStatus *Mat_SubtractI32_Async(Mat m, int32_t val);
CvStatus *Mat_MultiplyI32_Async(Mat m, int32_t val);
CvStatus *Mat_DivideI32_Async(Mat m, int32_t val);

CvStatus *Mat_AddFloat_Async(Mat m, float_t val);
CvStatus *Mat_SubtractFloat_Async(Mat m, float_t val);
CvStatus *Mat_MultiplyFloat_Async(Mat m, float_t val);
CvStatus *Mat_DivideFloat_Async(Mat m, float_t val);

CvStatus *Mat_AddF64_Async(Mat m, double_t val);
CvStatus *Mat_SubtractF64_Async(Mat m, double_t val);
CvStatus *Mat_MultiplyF64_Async(Mat m, double_t val);
CvStatus *Mat_DivideF64_Async(Mat m, double_t val);
CvStatus *Mat_MultiplyMatrix_Async(Mat x, Mat y, CvCallback_1 callback);

CvStatus *Mat_AbsDiff_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Add_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_AddWeighted_Async(Mat src1, double alpha, Mat src2, double beta, double gamma, Mat dst);
CvStatus *Mat_BitwiseAnd_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_BitwiseAndWithMask_Async(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_BitwiseNot_Async(Mat src1, Mat dst);
CvStatus *Mat_BitwiseNotWithMask_Async(Mat src1, Mat dst, Mat mask);
CvStatus *Mat_BitwiseOr_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_BitwiseOrWithMask_Async(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_BitwiseXor_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_BitwiseXorWithMask_Async(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_Compare_Async(Mat src1, Mat src2, Mat dst, int ct);
CvStatus *Mat_BatchDistance_Async(Mat src1, Mat src2, Mat dist, int dtype, Mat nidx, int normType, int K,
                                  Mat mask, int update, bool crosscheck);
CvStatus *Mat_BorderInterpolate_Async(int p, int len, int borderType, int *rval);
CvStatus *Mat_CalcCovarMatrix_Async(Mat samples, Mat covar, Mat mean, int flags, int ctype);
CvStatus *Mat_CartToPolar_Async(Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees);
CvStatus *Mat_CheckRange_Async(Mat m, bool quiet, Point *pos, double minVal, double maxVal, bool *rval);
CvStatus *Mat_CompleteSymm_Async(Mat m, bool lowerToUpper);
CvStatus *Mat_ConvertScaleAbs_Async(Mat src, Mat dst, double alpha, double beta);
CvStatus *Mat_CopyMakeBorder_Async(Mat src, Mat dst, int top, int bottom, int left, int right, int borderType,
                                   Scalar value);
CvStatus *Mat_CountNonZero_Async(Mat src, int *rval);
CvStatus *Mat_DCT_Async(Mat src, Mat dst, int flags);
CvStatus *Mat_Determinant_Async(Mat m, double *rval);
CvStatus *Mat_DFT_Async(Mat m, Mat dst, int flags);
CvStatus *Mat_Divide_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Eigen_Async(Mat src, Mat eigenvalues, Mat eigenvectors, bool *rval);
CvStatus *Mat_EigenNonSymmetric_Async(Mat src, Mat eigenvalues, Mat eigenvectors);
CvStatus *Mat_PCACompute_Async(Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents);
CvStatus *Mat_Exp_Async(Mat src, Mat dst);
CvStatus *Mat_ExtractChannel_Async(Mat src, Mat dst, int coi);
CvStatus *Mat_FindNonZero_Async(Mat src, Mat idx);
CvStatus *Mat_Flip_Async(Mat src, Mat dst, int flipCode);
CvStatus *Mat_Gemm_Async(Mat src1, Mat src2, double alpha, Mat src3, double beta, Mat dst, int flags);
CvStatus *Mat_GetOptimalDFTSize_Async(int vecsize, int *rval);
CvStatus *Mat_Hconcat_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Vconcat_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_Idct_Async(Mat src, Mat dst, int flags);
CvStatus *Mat_Idft_Async(Mat src, Mat dst, int flags, int nonzeroRows);
CvStatus *Mat_InRange_Async(Mat src, Mat lowerb, Mat upperb, Mat dst);
CvStatus *Mat_InRangeWithScalar_Async(Mat src, const Scalar lowerb, const Scalar upperb, Mat dst);
CvStatus *Mat_InsertChannel_Async(Mat src, Mat dst, int coi);
CvStatus *Mat_Invert_Async(Mat src, Mat dst, int flags, double *rval);
CvStatus *Mat_Log_Async(Mat src, Mat dst);
CvStatus *Mat_Magnitude_Async(Mat x, Mat y, Mat magnitude);
CvStatus *Mat_Max_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_MeanStdDev_Async(Mat src, Scalar *dstMean, Scalar *dstStdDev);
CvStatus *Mat_MeanStdDevWithMask_Async(Mat src, Scalar *dstMean, Scalar *dstStdDev, Mat mask);
CvStatus *Mat_Merge_Async(VecMat mats, Mat dst);
CvStatus *Mat_Min_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_MinMaxIdx_Async(Mat m, double *minVal, double *maxVal, int *minIdx, int *maxIdx);
CvStatus *Mat_MinMaxLoc_Async(Mat m, double *minVal, double *maxVal, Point *minLoc, Point *maxLoc);
CvStatus *Mat_MixChannels_Async(VecMat src, VecMat dst, VecInt fromTo);
CvStatus *Mat_MulSpectrums_Async(Mat a, Mat b, Mat c, int flags);
CvStatus *Mat_Multiply_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_MultiplyWithParams_Async(Mat src1, Mat src2, Mat dst, double scale, int dtype);
CvStatus *Mat_Normalize_Async(Mat src, Mat dst, double alpha, double beta, int typ);
CvStatus *Mat_PerspectiveTransform_Async(Mat src, Mat dst, Mat tm);
CvStatus *Mat_Solve_Async(Mat src1, Mat src2, Mat dst, int flags, bool *rval);
CvStatus *Mat_SolveCubic_Async(Mat coeffs, Mat roots, int *rval);
CvStatus *Mat_SolvePoly_Async(Mat coeffs, Mat roots, int maxIters, double *rval);
CvStatus *Mat_Reduce_Async(Mat src, Mat dst, int dim, int rType, int dType);
CvStatus *Mat_ReduceArgMax_Async(Mat src, Mat dst, int axis, bool lastIndex);
CvStatus *Mat_ReduceArgMin_Async(Mat src, Mat dst, int axis, bool lastIndex);
CvStatus *Mat_Repeat_Async(Mat src, int nY, int nX, Mat dst);
CvStatus *Mat_ScaleAdd_Async(Mat src1, double alpha, Mat src2, Mat dst);
CvStatus *Mat_SetIdentity_Async(Mat src, double scalar);
CvStatus *Mat_Sort_Async(Mat src, Mat dst, int flags);
CvStatus *Mat_SortIdx_Async(Mat src, Mat dst, int flags);
CvStatus *Mat_Split_Async(Mat src, VecMat *rval);
CvStatus *Mat_Subtract_Async(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_T_Async(Mat x, CvCallback_1 callback);
CvStatus *Mat_Trace_Async(Mat src, Scalar *rval);
CvStatus *Mat_Transform_Async(Mat src, Mat dst, Mat tm);
CvStatus *Mat_Transpose_Async(Mat src, Mat dst);
CvStatus *Mat_PolarToCart_Async(Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees);
CvStatus *Mat_Pow_Async(Mat src, double power, Mat dst);
CvStatus *Mat_Phase_Async(Mat x, Mat y, Mat angle, bool angleInDegrees);
CvStatus *Mat_Sum_Async(Mat src, Scalar *rval);
CvStatus *Mat_rowRange_Async(Mat m, int start, int end, CvCallback_1 callback);
CvStatus *Mat_colRange_Async(Mat m, int start, int end, CvCallback_1 callback);
CvStatus *LUT_Async(Mat src, Mat lut, Mat dst);
CvStatus *KMeans_Async(Mat data, int k, Mat bestLabels, TermCriteria criteria, int attempts, int flags,
                       Mat centers, double *rval);
CvStatus *KMeansPoints_Async(VecPoint2f pts, int k, Mat bestLabels, TermCriteria criteria, int attempts,
                             int flags, Mat centers, double *rval);
CvStatus *Rotate_Async(Mat src, Mat dst, int rotateCode);
CvStatus *Norm_Async(Mat src1, int normType, double *rval);
CvStatus *NormWithMats_Async(Mat src1, Mat src2, int normType, double *rval);
#pragma endregion

#pragma region RNG

CvStatus *Rng_New_Async(RNG *rval);
CvStatus *Rng_NewWithState_Async(uint64_t state, RNG *rval);
void Rng_Close_Async(RNGPtr rng);
CvStatus *TheRNG_Async(RNG *rval);
CvStatus *SetRNGSeed_Async(int seed);
CvStatus *RNG_Fill_Async(RNG rng, Mat mat, int distType, double a, double b, bool saturateRange);
CvStatus *RNG_Gaussian_Async(RNG rng, double sigma, double *rval);
CvStatus *RNG_Uniform_Async(RNG rng, int a, int b, int *rval);
CvStatus *RNG_UniformDouble_Async(RNG rng, double a, double b, double *rval);
CvStatus *RNG_Next_Async(RNG rng, uint32_t *rval);
CvStatus *RandN_Async(Mat mat, Scalar mean, Scalar stddev);
CvStatus *RandShuffle_Async(Mat mat);
CvStatus *RandShuffleWithParams_Async(Mat mat, double iterFactor, RNG rng);
CvStatus *RandU_Async(Mat mat, Scalar low, Scalar high);
#pragma endregion

CvStatus *GetCVTickCount_Async(int64_t *rval);
CvStatus *GetTickFrequency_Async(double *rval);
CvStatus *SetNumThreads_Async(int n);
CvStatus *GetNumThreads_Async(int *rval);

#ifdef __cplusplus
}
#endif

#endif
