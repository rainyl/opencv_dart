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

#pragma region Mat_Constructors
CvStatus *Mat_New_Async(CvCallback_1 callback);
CvStatus *Mat_NewWithSize_Async(int rows, int cols, int type, CvCallback_1 callback);
CvStatus *Mat_NewWithSizes_Async(VecI32 sizes, int type, CvCallback_1 callback);
CvStatus *Mat_NewWithSizesScalar_Async(VecI32 sizes, int type, Scalar s, CvCallback_1 callback);
CvStatus *
Mat_NewWithSizesFromBytes_Async(VecI32 sizes, int type, VecChar buf, CvCallback_1 callback);
CvStatus *
Mat_NewFromScalar_Async(const Scalar s, int rows, int cols, int type, CvCallback_1 callback);
CvStatus *
Mat_NewFromBytes_Async(int rows, int cols, int type, void *buf, int step, CvCallback_1 callback);
CvStatus *Mat_NewFromVecPoint_Async(VecPoint vec, CvCallback_1 callback);
CvStatus *Mat_NewFromVecPoint2f_Async(VecPoint2f vec, CvCallback_1 callback);
CvStatus *Mat_NewFromVecPoint3f_Async(VecPoint3f vec, CvCallback_1 callback);

CvStatus *Mat_Eye_Async(int rows, int cols, int type, CvCallback_1 callback);
CvStatus *Mat_Zeros_Async(int rows, int cols, int type, CvCallback_1 callback);
CvStatus *Mat_Ones_Async(int rows, int cols, int type, CvCallback_1 callback);

#pragma endregion

#pragma region Mat_functions
// CvStatus *Mat_Release_Async(MatPtr self, CvCallback_0 callback);
// CvStatus *Mat_Empty_Async(Mat self, CvCallback_1 callback);        // bool *rval
// CvStatus *Mat_IsContinuous_Async(Mat self, CvCallback_1 callback); // bool *rval
CvStatus *Mat_Clone_Async(Mat self, CvCallback_1 callback);        // Mat *dst
CvStatus *Mat_CopyTo_Async(Mat self, Mat dst, CvCallback_0 callback);
CvStatus *Mat_CopyToWithMask_Async(Mat self, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus *Mat_ConvertTo_Async(Mat self, int type, CvCallback_1 callback); // Mat dst
CvStatus *Mat_ConvertToWithParams_Async(
    Mat self, int type, float alpha, float beta, CvCallback_1 callback
);                                                               // Mat dst
CvStatus *Mat_ToVecUChar_Async(Mat self, CvCallback_1 callback); // VecUChar *rval
CvStatus *Mat_ToVecChar_Async(Mat self, CvCallback_1 callback);  // VecChar *rval
CvStatus *Mat_Region_Async(Mat self, Rect r, CvCallback_1 callback);
CvStatus *Mat_Reshape_Async(Mat self, int cn, int rows, CvCallback_1 callback);
#pragma endregion

// properties, use sync
// CvStatus *Mat_Rows_Async(Mat self, CvCallback_1 callback); // int *rval
// CvStatus *Mat_Cols_Async(Mat self, CvCallback_1 callback);
// CvStatus *Mat_Channels_Async(Mat self, CvCallback_1 callback);
// CvStatus *Mat_Type_Async(Mat self, CvCallback_1 callback);
// CvStatus *Mat_Step_Async(Mat self, int *rval);
// CvStatus *Mat_Total_Async(Mat self, int *rval);
// CvStatus *Mat_Size_Async(Mat self, VecI32 *rval);
// CvStatus *Mat_ElemSize_Async(Mat self, int *rval);
// CvStatus *Mat_Data_Async(Mat self, VecUChar *rval);
// CvStatus *Mat_DataPtr_Async(Mat self, uchar **data, int *length);

// CvStatus *Mat_Ptr_u8_1_Async(Mat self, int i, uchar **rval);
// CvStatus *Mat_Ptr_u8_2_Async(Mat self, int i, int j, uchar **rval);
// CvStatus *Mat_Ptr_u8_3_Async(Mat self, int i, int j, int k, uchar **rval);
// CvStatus *Mat_Ptr_i8_1_Async(Mat self, int i, char **rval);
// CvStatus *Mat_Ptr_i8_2_Async(Mat self, int i, int j, char **rval);
// CvStatus *Mat_Ptr_i8_3_Async(Mat self, int i, int j, int k, char **rval);
// CvStatus *Mat_Ptr_u16_1_Async(Mat self, int i, ushort **rval);
// CvStatus *Mat_Ptr_u16_2_Async(Mat self, int i, int j, ushort **rval);
// CvStatus *Mat_Ptr_u16_3_Async(Mat self, int i, int j, int k, ushort **rval);
// CvStatus *Mat_Ptr_i16_1_Async(Mat self, int i, short **rval);
// CvStatus *Mat_Ptr_i16_2_Async(Mat self, int i, int j, short **rval);
// CvStatus *Mat_Ptr_i16_3_Async(Mat self, int i, int j, int k, short **rval);
// CvStatus *Mat_Ptr_i32_1_Async(Mat self, int i, int **rval);
// CvStatus *Mat_Ptr_i32_2_Async(Mat self, int i, int j, int **rval);
// CvStatus *Mat_Ptr_i32_3_Async(Mat self, int i, int j, int k, int **rval);
// CvStatus *Mat_Ptr_f32_1_Async(Mat self, int i, float **rval);
// CvStatus *Mat_Ptr_f32_2_Async(Mat self, int i, int j, float **rval);
// CvStatus *Mat_Ptr_f32_3_Async(Mat self, int i, int j, int k, float **rval);
// CvStatus *Mat_Ptr_f64_1_Async(Mat self, int i, double **rval);
// CvStatus *Mat_Ptr_f64_2_Async(Mat self, int i, int j, double **rval);
// CvStatus *Mat_Ptr_f64_3_Async(Mat self, int i, int j, int k, double **rval);

// #pragma region Mat_getter

// CvStatus *Mat_GetUChar_Async(Mat self, int row, int col, uint8_t *rval);
// CvStatus *Mat_GetUChar3_Async(Mat self, int x, int y, int z, uint8_t *rval);
// CvStatus *Mat_GetSChar_Async(Mat self, int row, int col, int8_t *rval);
// CvStatus *Mat_GetSChar3_Async(Mat self, int x, int y, int z, int8_t *rval);
// CvStatus *Mat_GetUShort_Async(Mat self, int row, int col, uint16_t *rval);
// CvStatus *Mat_GetUShort3_Async(Mat self, int x, int y, int z, uint16_t *rval);
// CvStatus *Mat_GetShort_Async(Mat self, int row, int col, int16_t *rval);
// CvStatus *Mat_GetShort3_Async(Mat self, int x, int y, int z, int16_t *rval);
// CvStatus *Mat_GetInt_Async(Mat self, int row, int col, int32_t *rval);
// CvStatus *Mat_GetInt3_Async(Mat self, int x, int y, int z, int32_t *rval);
// CvStatus *Mat_GetFloat_Async(Mat self, int row, int col, float *rval);
// CvStatus *Mat_GetFloat3_Async(Mat self, int x, int y, int z, float *rval);
// CvStatus *Mat_GetDouble_Async(Mat self, int row, int col, double *rval);
// CvStatus *Mat_GetDouble3_Async(Mat self, int x, int y, int z, double *rval);

// CvStatus *Mat_GetVec2b_Async(Mat self, int row, int col, Vec2b *rval);
// CvStatus *Mat_GetVec3b_Async(Mat self, int row, int col, Vec3b *rval);
// CvStatus *Mat_GetVec4b_Async(Mat self, int row, int col, Vec4b *rval);
// CvStatus *Mat_GetVec2s_Async(Mat self, int row, int col, Vec2s *rval);
// CvStatus *Mat_GetVec3s_Async(Mat self, int row, int col, Vec3s *rval);
// CvStatus *Mat_GetVec4s_Async(Mat self, int row, int col, Vec4s *rval);
// CvStatus *Mat_GetVec2w_Async(Mat self, int row, int col, Vec2w *rval);
// CvStatus *Mat_GetVec3w_Async(Mat self, int row, int col, Vec3w *rval);
// CvStatus *Mat_GetVec4w_Async(Mat self, int row, int col, Vec4w *rval);
// CvStatus *Mat_GetVec2i_Async(Mat self, int row, int col, Vec2i *rval);
// CvStatus *Mat_GetVec3i_Async(Mat self, int row, int col, Vec3i *rval);
// CvStatus *Mat_GetVec4i_Async(Mat self, int row, int col, Vec4i *rval);
// CvStatus *Mat_GetVec6i_Async(Mat self, int row, int col, Vec6i *rval);
// CvStatus *Mat_GetVec8i_Async(Mat self, int row, int col, Vec8i *rval);
// CvStatus *Mat_GetVec2f_Async(Mat self, int row, int col, Vec2f *rval);
// CvStatus *Mat_GetVec3f_Async(Mat self, int row, int col, Vec3f *rval);
// CvStatus *Mat_GetVec4f_Async(Mat self, int row, int col, Vec4f *rval);
// CvStatus *Mat_GetVec6f_Async(Mat self, int row, int col, Vec6f *rval);
// CvStatus *Mat_GetVec2d_Async(Mat self, int row, int col, Vec2d *rval);
// CvStatus *Mat_GetVec3d_Async(Mat self, int row, int col, Vec3d *rval);
// CvStatus *Mat_GetVec4d_Async(Mat self, int row, int col, Vec4d *rval);
// CvStatus *Mat_GetVec6d_Async(Mat self, int row, int col, Vec6d *rval);

// #pragma endregion

// #pragma region Mat_setter

// CvStatus *Mat_SetTo_Async(Mat self, Scalar value);
// CvStatus *Mat_SetUChar_Async(Mat self, int row, int col, uint8_t val);
// CvStatus *Mat_SetUChar3_Async(Mat self, int x, int y, int z, uint8_t val);
// CvStatus *Mat_SetSChar_Async(Mat self, int row, int col, int8_t val);
// CvStatus *Mat_SetSChar3_Async(Mat self, int x, int y, int z, int8_t val);
// CvStatus *Mat_SetShort_Async(Mat self, int row, int col, int16_t val);
// CvStatus *Mat_SetShort3_Async(Mat self, int x, int y, int z, int16_t val);
// CvStatus *Mat_SetUShort_Async(Mat self, int row, int col, uint16_t val);
// CvStatus *Mat_SetUShort3_Async(Mat self, int x, int y, int z, uint16_t val);
// CvStatus *Mat_SetInt_Async(Mat self, int row, int col, int32_t val);
// CvStatus *Mat_SetInt3_Async(Mat self, int x, int y, int z, int32_t val);
// CvStatus *Mat_SetFloat_Async(Mat self, int row, int col, float val);
// CvStatus *Mat_SetFloat3_Async(Mat self, int x, int y, int z, float val);
// CvStatus *Mat_SetDouble_Async(Mat self, int row, int col, double val);
// CvStatus *Mat_SetDouble3_Async(Mat self, int x, int y, int z, double val);

// CvStatus *Mat_SetVec2b_Async(Mat self, int row, int col, Vec2b val);
// CvStatus *Mat_SetVec3b_Async(Mat self, int row, int col, Vec3b val);
// CvStatus *Mat_SetVec4b_Async(Mat self, int row, int col, Vec4b val);
// CvStatus *Mat_SetVec2s_Async(Mat self, int row, int col, Vec2s val);
// CvStatus *Mat_SetVec3s_Async(Mat self, int row, int col, Vec3s val);
// CvStatus *Mat_SetVec4s_Async(Mat self, int row, int col, Vec4s val);
// CvStatus *Mat_SetVec2w_Async(Mat self, int row, int col, Vec2w val);
// CvStatus *Mat_SetVec3w_Async(Mat self, int row, int col, Vec3w val);
// CvStatus *Mat_SetVec4w_Async(Mat self, int row, int col, Vec4w val);
// CvStatus *Mat_SetVec2i_Async(Mat self, int row, int col, Vec2i val);
// CvStatus *Mat_SetVec3i_Async(Mat self, int row, int col, Vec3i val);
// CvStatus *Mat_SetVec4i_Async(Mat self, int row, int col, Vec4i val);
// CvStatus *Mat_SetVec6i_Async(Mat self, int row, int col, Vec6i val);
// CvStatus *Mat_SetVec8i_Async(Mat self, int row, int col, Vec8i val);
// CvStatus *Mat_SetVec2f_Async(Mat self, int row, int col, Vec2f val);
// CvStatus *Mat_SetVec3f_Async(Mat self, int row, int col, Vec3f val);
// CvStatus *Mat_SetVec4f_Async(Mat self, int row, int col, Vec4f val);
// CvStatus *Mat_SetVec6f_Async(Mat self, int row, int col, Vec6f val);
// CvStatus *Mat_SetVec2d_Async(Mat self, int row, int col, Vec2d val);
// CvStatus *Mat_SetVec3d_Async(Mat self, int row, int col, Vec3d val);
// CvStatus *Mat_SetVec4d_Async(Mat self, int row, int col, Vec4d val);
// CvStatus *Mat_SetVec6d_Async(Mat self, int row, int col, Vec6d val);

// #pragma endregion Mat_setter

#pragma region Mat_operation

// CvStatus *Mat_AddUChar_Async(Mat self, uint8_t val);
// CvStatus *Mat_SubtractUChar_Async(Mat self, uint8_t val);
// CvStatus *Mat_MultiplyUChar_Async(Mat self, uint8_t val);
// CvStatus *Mat_DivideUChar_Async(Mat self, uint8_t val);

// CvStatus *Mat_AddSChar_Async(Mat self, int8_t val);
// CvStatus *Mat_SubtractSChar_Async(Mat self, int8_t val);
// CvStatus *Mat_MultiplySChar_Async(Mat self, int8_t val);
// CvStatus *Mat_DivideSChar_Async(Mat self, int8_t val);

// CvStatus *Mat_AddI32_Async(Mat self, int32_t val);
// CvStatus *Mat_SubtractI32_Async(Mat self, int32_t val);
// CvStatus *Mat_MultiplyI32_Async(Mat self, int32_t val);
// CvStatus *Mat_DivideI32_Async(Mat self, int32_t val);

// CvStatus *Mat_AddFloat_Async(Mat self, float_t val);
// CvStatus *Mat_SubtractFloat_Async(Mat self, float_t val);
// CvStatus *Mat_MultiplyFloat_Async(Mat self, float_t val);
// CvStatus *Mat_DivideFloat_Async(Mat self, float_t val);

// CvStatus *Mat_AddF64_Async(Mat self, double_t val);
// CvStatus *Mat_SubtractF64_Async(Mat self, double_t val);
// CvStatus *Mat_MultiplyF64_Async(Mat self, double_t val);
// CvStatus *Mat_DivideF64_Async(Mat self, double_t val);
// CvStatus *Mat_MultiplyMatrix_Async(Mat x, Mat y, CvCallback_1 callback);

CvStatus *core_PatchNaNs_Async(Mat self, double val, CvCallback_0 callback);
// Deprecated:
// Use Mat::convertTo with CV_16F instead.
// CvStatus *Mat_ConvertFp16_Async(Mat self, CvCallback_1 callback);
CvStatus *core_Mean_Async(Mat self, CvCallback_1 callback);                   // Scalar *rval
CvStatus *core_MeanWithMask_Async(Mat self, Mat mask, CvCallback_1 callback); // Scalar *rval
CvStatus *core_Sqrt_Async(Mat self, CvCallback_1 callback);
CvStatus *core_AbsDiff_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_Add_Async(Mat src1, Mat src2, Mat mask, int dtype, CvCallback_1 callback);
CvStatus *core_AddWeighted_Async(
    Mat src1, double alpha, Mat src2, double beta, double gamma, int dtype, CvCallback_1 callback
);
CvStatus *core_BitwiseAnd_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_BitwiseAndWithMask_Async(Mat src1, Mat src2, Mat mask, CvCallback_1 callback);
CvStatus *core_BitwiseNot_Async(Mat src1, CvCallback_1 callback);
CvStatus *core_BitwiseNotWithMask_Async(Mat src1, Mat mask, CvCallback_1 callback);
CvStatus *core_BitwiseOr_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_BitwiseOrWithMask_Async(Mat src1, Mat src2, Mat mask, CvCallback_1 callback);
CvStatus *core_BitwiseXor_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_BitwiseXorWithMask_Async(Mat src1, Mat src2, Mat mask, CvCallback_1 callback);
CvStatus *core_Compare_Async(Mat src1, Mat src2, int ct, CvCallback_1 callback);
CvStatus *core_BatchDistance_Async(
    Mat src1,
    Mat src2,
    int dtype,
    int normType,
    int K,
    Mat mask,
    int update,
    bool crosscheck,
    CvCallback_2 callback
); // Mat dist,Mat nidx,
CvStatus *
core_BorderInterpolate_Async(int p, int len, int borderType, CvCallback_1 callback); // int *rval
CvStatus *core_CalcCovarMatrix_Async(
    Mat samples, Mat mean, int flags, int ctype, CvCallback_1 callback
); // Mat covar
CvStatus *core_CartToPolar_Async(
    Mat x, Mat y, bool angleInDegrees, CvCallback_2 callback
); // Mat magnitude, Mat angle
CvStatus *core_CheckRange_Async(
    Mat self, bool quiet, double minVal, double maxVal, CvCallback_2 callback
); // bool *rval, Point *pos
CvStatus *core_CompleteSymm_Async(Mat self, bool lowerToUpper, CvCallback_0 callback);
CvStatus *core_ConvertScaleAbs_Async(Mat src, double alpha, double beta, CvCallback_1 callback);
CvStatus *core_CopyMakeBorder_Async(
    Mat src,
    int top,
    int bottom,
    int left,
    int right,
    int borderType,
    Scalar value,
    CvCallback_1 callback
);
CvStatus *core_CountNonZero_Async(Mat src, CvCallback_1 callback); // int *rval
CvStatus *core_DCT_Async(Mat src, int flags, CvCallback_1 callback);
CvStatus *core_Determinant_Async(Mat self, CvCallback_1 callback);
CvStatus *core_DFT_Async(Mat self, int flags, int nonzeroRows, CvCallback_1 callback);
CvStatus *core_Divide_Async(Mat src1, Mat src2, double scale, int dtype, CvCallback_1 callback);
CvStatus *
core_Eigen_Async(Mat src, CvCallback_3 callback); // Mat eigenvalues, Mat eigenvectors, bool *rval
CvStatus *
core_EigenNonSymmetric_Async(Mat src, CvCallback_2 callback); // Mat eigenvalues, Mat eigenvectors

CvStatus *core_PCABackProject_Async(Mat src, Mat mean, Mat eigenvectors, CvCallback_1 callback);
CvStatus *
core_PCACompute_3_Async(Mat src, Mat mean, double retainedVariance, CvCallback_1 callback);
CvStatus *core_PCACompute_1_Async(Mat src, Mat mean, int maxComponents, CvCallback_1 callback);
CvStatus *
core_PCACompute_2_Async(Mat src, Mat mean, double retainedVariance, CvCallback_2 callback);
CvStatus *core_PCACompute_Async(Mat src, Mat mean, int maxComponents, CvCallback_2 callback);
CvStatus *core_PCAProject_Async(Mat src, Mat mean, Mat eigenvectors, CvCallback_1 callback);

CvStatus *core_Exp_Async(Mat src, CvCallback_1 callback);
CvStatus *core_ExtractChannel_Async(Mat src, int coi, CvCallback_1 callback);
CvStatus *core_FindNonZero_Async(Mat src, CvCallback_1 callback);
CvStatus *core_Flip_Async(Mat src, int flipCode, CvCallback_1 callback);
CvStatus *core_Gemm_Async(
    Mat src1, Mat src2, double alpha, Mat src3, double beta, int flags, CvCallback_1 callback
);
CvStatus *core_GetOptimalDFTSize_Async(int vecsize, CvCallback_1 callback);
CvStatus *core_Hconcat_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_Vconcat_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_Idct_Async(Mat src, int flags, CvCallback_1 callback);
CvStatus *core_Idft_Async(Mat src, int flags, int nonzeroRows, CvCallback_1 callback);
CvStatus *core_InRange_Async(Mat src, Mat lowerb, Mat upperb, CvCallback_1 callback);
CvStatus *core_InRangeWithScalar_Async(
    Mat src, const Scalar lowerb, const Scalar upperb, CvCallback_1 callback
);
CvStatus *core_InsertChannel_Async(Mat src, Mat dst, int coi, CvCallback_0 callback);
CvStatus *core_Invert_Async(Mat src, int flags, CvCallback_2 callback);
CvStatus *core_Log_Async(Mat src, CvCallback_1 callback);
CvStatus *core_Magnitude_Async(Mat x, Mat y, CvCallback_1 callback);
CvStatus *core_Max_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_MeanStdDev_Async(Mat src, CvCallback_2 callback); // Scalar *dstMean, Scalar
                                                                 // *dstStdDev
CvStatus *core_MeanStdDevWithMask_Async(
    Mat src, Mat mask, CvCallback_2 callback
); // Scalar *dstMean, Scalar *dstStdDev
CvStatus *core_Merge_Async(VecMat mats, CvCallback_1 callback);
CvStatus *core_Min_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *core_MinMaxIdx_Async(
    Mat self, CvCallback_4 callback
); // double *minVal, double *maxVal, int *minIdx, int *maxIdx
CvStatus *core_MinMaxIdx_Mask_Async(Mat self, Mat mask, CvCallback_4 callback);
CvStatus *core_MinMaxLoc_Async(
    Mat self, CvCallback_4 callback
); // double *minVal, double *maxVal, Point *minLoc, Point *maxLoc
CvStatus *core_MinMaxLoc_Mask_Async(Mat self, Mat mask, CvCallback_4 callback);
CvStatus *core_MixChannels_Async(VecMat src, VecMat dst, VecI32 fromTo, CvCallback_0 callback);
CvStatus *core_MulSpectrums_Async(Mat a, Mat b, int flags, bool conjB, CvCallback_1 callback);
CvStatus *core_Multiply_Async(Mat src1, Mat src2, CvCallback_1 callback);
CvStatus *
core_MultiplyWithParams_Async(Mat src1, Mat src2, double scale, int dtype, CvCallback_1 callback);
CvStatus *
core_Normalize_Async(Mat src, Mat dst, double alpha, double beta, int typ, int dtype, CvCallback_0 callback);
CvStatus *core_Normalize_Mask_Async(
    Mat src, Mat dst, double alpha, double beta, int typ, int dtype, Mat mask, CvCallback_0 callback
);
CvStatus *core_PerspectiveTransform_Async(Mat src, Mat tm, CvCallback_1 callback);
CvStatus *
core_Solve_Async(Mat src1, Mat src2, int flags, CvCallback_2 callback); // bool *rval, Mat dst
CvStatus *core_SolveCubic_Async(Mat coeffs, CvCallback_2 callback);     // int *rval, Mat roots
CvStatus *
core_SolvePoly_Async(Mat coeffs, int maxIters, CvCallback_2 callback); // double *rval, Mat roots
CvStatus *core_Reduce_Async(Mat src, int dim, int rType, int dType, CvCallback_1 callback);
CvStatus *core_ReduceArgMax_Async(Mat src, int axis, bool lastIndex, CvCallback_1 callback);
CvStatus *core_ReduceArgMin_Async(Mat src, int axis, bool lastIndex, CvCallback_1 callback);
CvStatus *core_Repeat_Async(Mat src, int nY, int nX, CvCallback_1 callback);
CvStatus *core_ScaleAdd_Async(Mat src1, double alpha, Mat src2, CvCallback_1 callback);
CvStatus *core_SetIdentity_Async(Mat src, Scalar scalar, CvCallback_0 callback);
CvStatus *core_Sort_Async(Mat src, int flags, CvCallback_1 callback);
CvStatus *core_SortIdx_Async(Mat src, int flags, CvCallback_1 callback);
CvStatus *core_Split_Async(Mat src, CvCallback_1 callback); // VecMat *rval
CvStatus *core_Subtract_Async(Mat src1, Mat src2, Mat mask, int dtype, CvCallback_1 callback);
CvStatus *core_T_Async(Mat x, CvCallback_1 callback);
CvStatus *core_Trace_Async(Mat src, CvCallback_1 callback);
CvStatus *core_Transform_Async(Mat src, Mat tm, CvCallback_1 callback);
CvStatus *core_Transpose_Async(Mat src, CvCallback_1 callback);
CvStatus *core_PolarToCart_Async(
    Mat magnitude, Mat degree, bool angleInDegrees, CvCallback_2 callback
); // Mat x, Mat y
CvStatus *core_Pow_Async(Mat src, double power, CvCallback_1 callback);
CvStatus *core_Phase_Async(Mat x, Mat y, bool angleInDegrees, CvCallback_1 callback); // Mat angle
CvStatus *core_Sum_Async(Mat src, CvCallback_1 callback);
CvStatus *core_rowRange_Async(Mat self, int start, int end, CvCallback_1 callback);
CvStatus *core_colRange_Async(Mat self, int start, int end, CvCallback_1 callback);

CvStatus *core_LUT_Async(Mat src, Mat lut, CvCallback_1 callback);
CvStatus *core_KMeans_Async(
    Mat data,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    CvCallback_2 callback
); // double *rval, Mat centers
CvStatus *core_KMeans_Points_Async(
    VecPoint2f pts,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    CvCallback_2 callback
); // double *rval, Mat centers
CvStatus *core_Rotate_Async(Mat src, int rotateCode, CvCallback_1 callback);
CvStatus *core_Norm_Async(Mat src1, int normType, CvCallback_1 callback);
CvStatus *core_Norm_Mask_Async(Mat src1, int normType, Mat mask, CvCallback_1 callback);
CvStatus *core_NormWithMats_Async(Mat src1, Mat src2, int normType, CvCallback_1 callback);
#pragma endregion

#pragma region RNG

CvStatus *Rng_New_Async(CvCallback_1 callback);
CvStatus *Rng_NewWithState_Async(uint64_t state, CvCallback_1 callback);
CvStatus *RNG_Fill_Async(RNG rng, Mat mat, int distType, double a, double b, bool saturateRange, CvCallback_0 callback);
CvStatus *RNG_Gaussian_Async(RNG rng, double sigma, CvCallback_1 callback);
CvStatus *RNG_Uniform_Async(RNG rng, int a, int b, CvCallback_1 callback);
CvStatus *RNG_UniformDouble_Async(RNG rng, double a, double b, CvCallback_1 callback);
CvStatus *RNG_Next_Async(RNG rng, CvCallback_1 callback); // uint32_t *rval

CvStatus *RandN_Async(Mat mat, Scalar mean, Scalar stddev, CvCallback_0 callback);
CvStatus *RandShuffle_Async(Mat mat, CvCallback_0 callback);
CvStatus *RandShuffleWithParams_Async(Mat mat, double iterFactor, RNG rng, CvCallback_0 callback);
CvStatus *RandU_Async(Mat mat, Scalar low, Scalar high, CvCallback_0 callback);
#pragma endregion

#ifdef __cplusplus
}
#endif

#endif
