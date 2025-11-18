//
// Created by Rainyl.
// Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
//

#ifndef CVD_MAT_H
#define CVD_MAT_H

#include "dartcv/core/types.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Create empty Mat

* ALL return values with a type of `Pointer of Struct`,
    * e.g.,
    * Mat, the internal pointer (Mat.ptr) MUST be NULL
    * otherwise the memory of mat.ptr pointed to will NOT be freed correctly.
    * Mat* mat = (Mat*)malloc(sizeof(Mat));
* CvStatus *status = cv_Mat_create(mat);
* Mat_close(mat);
*
* @param rval Mat*
* @return CvStatus
*/
CvStatus* cv_Mat_create(Mat* rval);

/**
 * @brief Create Mat with specified size and type
 *
 * @param rows number of rows
 * @param cols number of columns
 * @param type type of the created matrix
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_1(int rows, int cols, int type, Mat* rval, CvCallback_0 callback);

/**
 * @brief Create Mat with specified sizes and type
 *
 * @param sizes array of integers, each describing a dimension
 * @param type type of the created matrix
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_2(VecI32 sizes, int type, Mat* rval, CvCallback_0 callback);

/**
 * @brief Create Mat with specified sizes and type
 *
 * @param sizes array of integers, each describing a dimension
 * @param type type of the created matrix
 * @param ar array of values to initialize the matrix with
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_3(VecI32 sizes, int type, Scalar ar, Mat* rval, CvCallback_0 callback);

/**
 * @brief Create Mat with specified sizes, type and data buffer
 *
 * @param sizes array of integers, each describing a dimension
 * @param type type of the created matrix
 * @param buf buffer to initialize the matrix with, will be copied
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_4(VecI32 sizes, int type, void* buf, Mat* rval, CvCallback_0 callback);

/**
 * @brief Create Mat with Scalar values
 *
 * @param scalar array of values to initialize the matrix with
 * @param rows number of rows
 * @param cols number of columns
 * @param type type of the created matrix
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_5(
    const Scalar scalar, int rows, int cols, int type, Mat* rval, CvCallback_0 callback
);

/**
 * @brief Create Mat with rows, cols, type and data buffer
 *
 * @param sizes array of integers, each describing a dimension
 * @param type type of the created matrix
 * @param buf buffer to initialize the matrix with, will be copied
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_6(
    int rows, int cols, int type, void* buf, Mat* rval, CvCallback_0 callback
);

CvStatus* cv_Mat_create_6_no_copy(
    int rows, int cols, int type, void* buf, Mat* rval, CvCallback_0 callback
);

/**
 * @brief Create Mat with specified vector of points
 *
 * @param vec array of points
 * @param rval Mat*
 * @return CvStatus
 */
CvStatus* cv_Mat_create_7(VecPoint vec, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_create_8(VecPoint2f vec, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_create_9(VecPoint3f vec, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_create_10(VecPoint3i vec, Mat* rval, CvCallback_0 callback);

/**
 * @brief Create Mat with Mat::ptr
 */
CvStatus* cv_Mat_create_11(
    Mat self, int rows, int cols, int type, int prows, int pcols, Mat* rval, CvCallback_0 callback
);

/*
 * @brief Create Mat from a range
 */
CvStatus* cv_Mat_create_12(
    Mat self, int rowStart, int rowEnd, int colStart, int colEnd, Mat* rval, CvCallback_0 callback
);

CvStatus* cv_Mat_create_13(Mat self, CvRect roi, Mat* rval, CvCallback_0 callback);

CvStatus* cv_Mat_eye(int rows, int cols, int type, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_zeros(int rows, int cols, int type, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_ones(int rows, int cols, int type, Mat* rval, CvCallback_0 callback);

CvStatus* cv_Mat_toVecPoint(Mat self, VecPoint* vec, CvCallback_0 callback);
CvStatus* cv_Mat_toVecPoint2f(Mat self, VecPoint2f* vec, CvCallback_0 callback);
CvStatus* cv_Mat_toVecPoint3f(Mat self, VecPoint3f* vec, CvCallback_0 callback);
CvStatus* cv_Mat_toVecPoint3i(Mat self, VecPoint3i* vec, CvCallback_0 callback);

CvStatus* cv_Mat_toFmtString(
    Mat self,
    int fmtType,
    int f16Precision,
    int f32Precision,
    int f64Precision,
    bool multiLine,
    char** rval
);

void cv_Mat_close(MatPtr self);
void cv_Mat_closeVoid(void* self);
CvStatus* cv_Mat_release(Mat self);

int cv_Mat_flags(Mat self);
bool cv_Mat_empty(Mat self);
bool cv_Mat_isContinuous(Mat self);
bool cv_Mat_isSubmatrix(Mat self);
int cv_Mat_rows(Mat self);
int cv_Mat_cols(Mat self);
int cv_Mat_channels(Mat self);
int cv_Mat_type(Mat self);
MatStep cv_Mat_step(Mat self);
size_t cv_Mat_total(Mat self);
VecI32* cv_Mat_size(Mat self);
size_t cv_Mat_elemSize(Mat self);
size_t cv_Mat_elemSize1(Mat self);
int cv_Mat_dims(Mat self);
uchar* cv_Mat_data(Mat self);
// CvStatus* cv_Mat_dataPtr(Mat self, uchar **data, int *length);

CvStatus* cv_Mat_adjustROI(
    Mat self, int dtop, int dbottom, int dleft, int dright, Mat* rval, CvCallback_0 callback
);
CvStatus* cv_Mat_locateROI(Mat self, CvSize* wholeSize, CvPoint* ofs, CvCallback_0 callback);
CvStatus* cv_Mat_clone(Mat self, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_col(Mat self, int x, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_row(Mat self, int y, Mat* rval, CvCallback_0 callback);
CvStatus* cv_rowRange(Mat self, int start, int end, Mat* rval, CvCallback_0 callback);
CvStatus* cv_colRange(Mat self, int start, int end, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_copyTo(Mat self, Mat dst, CvCallback_0 callback);
CvStatus* cv_Mat_copyTo_1(Mat self, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus* cv_Mat_convertTo(Mat self, Mat dst, int type, CvCallback_0 callback);
CvStatus* cv_Mat_convertTo_1(
    Mat self, Mat dst, int type, float alpha, float beta, CvCallback_0 callback
);
CvStatus* cv_Mat_setTo(Mat self, Scalar value, Mat mask, CvCallback_0 callback);
CvStatus* cv_Mat_toVecUChar(Mat self, VecUChar* rval, CvCallback_0 callback);
CvStatus* cv_Mat_toVecChar(Mat self, VecChar* rval, CvCallback_0 callback);
CvStatus* cv_Mat_region(Mat self, CvRect r, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_reshape(Mat self, int cn, int rows, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_reshape_1(Mat self, int cn, VecI32 newshape, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_patchNaNs(Mat self, double val, CvCallback_0 callback);
CvStatus* cv_Mat_convertFp16(Mat self, Mat rval, CvCallback_0 callback);
CvStatus* cv_Mat_mean(Mat self, Scalar* rval, CvCallback_0 callback);
CvStatus* cv_Mat_mean_1(Mat self, Mat mask, Scalar* rval, CvCallback_0 callback);
CvStatus* cv_Mat_sqrt(Mat self, Mat rval, CvCallback_0 callback);
CvStatus* cv_Mat_t(Mat self, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_reinterpret(Mat self, int type, Mat* rval, CvCallback_0 callback);
CvStatus* cv_Mat_getUMat(
    Mat self, int accessFlags, int usageFlags, UMat* rval, CvCallback_0 callback
);

uchar* cv_Mat_ptr_uchar_1(Mat self, int i);
uchar* cv_Mat_ptr_uchar_2(Mat self, int i, int j);
uchar* cv_Mat_ptr_uchar_3(Mat self, int i, int j, int k);

uint8_t cv_Mat_get_u8_1(Mat self, int i0);
uint8_t cv_Mat_get_u8_2(Mat self, int i0, int i1);
uint8_t cv_Mat_get_u8_3(Mat self, int i0, int i1, int i2);
int8_t cv_Mat_get_i8_1(Mat self, int i0);
int8_t cv_Mat_get_i8_2(Mat self, int i0, int i1);
int8_t cv_Mat_get_i8_3(Mat self, int i0, int i1, int i2);
uint16_t cv_Mat_get_u16_1(Mat self, int i0);
uint16_t cv_Mat_get_u16_2(Mat self, int i0, int i1);
uint16_t cv_Mat_get_u16_3(Mat self, int i0, int i1, int i2);
int16_t cv_Mat_get_i16_1(Mat self, int i0);
int16_t cv_Mat_get_i16_2(Mat self, int i0, int i1);
int16_t cv_Mat_get_i16_3(Mat self, int i0, int i1, int i2);
int32_t cv_Mat_get_i32_1(Mat self, int i0);
int32_t cv_Mat_get_i32_2(Mat self, int i0, int i1);
int32_t cv_Mat_get_i32_3(Mat self, int i0, int i1, int i2);
float_t cv_Mat_get_f32_1(Mat self, int i0);
float_t cv_Mat_get_f32_2(Mat self, int i0, int i1);
float_t cv_Mat_get_f32_3(Mat self, int i0, int i1, int i2);
double_t cv_Mat_get_f64_1(Mat self, int i0);
double_t cv_Mat_get_f64_2(Mat self, int i0, int i1);
double_t cv_Mat_get_f64_3(Mat self, int i0, int i1, int i2);

void cv_Mat_set_u8_1(Mat self, int i0, uint8_t val);
void cv_Mat_set_u8_2(Mat self, int i0, int i1, uint8_t val);
void cv_Mat_set_u8_3(Mat self, int i0, int i1, int i2, uint8_t val);
void cv_Mat_set_i8_1(Mat self, int i0, int8_t val);
void cv_Mat_set_i8_2(Mat self, int i0, int i1, int8_t val);
void cv_Mat_set_i8_3(Mat self, int i0, int i1, int i2, int8_t val);
void cv_Mat_set_i16_1(Mat self, int i0, int16_t val);
void cv_Mat_set_i16_2(Mat self, int i0, int i1, int16_t val);
void cv_Mat_set_i16_3(Mat self, int i0, int i1, int i2, int16_t val);
void cv_Mat_set_u16_1(Mat self, int i0, uint16_t val);
void cv_Mat_set_u16_2(Mat self, int i0, int i1, uint16_t val);
void cv_Mat_set_u16_3(Mat self, int i0, int i1, int i2, uint16_t val);
void cv_Mat_set_i32_1(Mat self, int i0, int32_t val);
void cv_Mat_set_i32_2(Mat self, int i0, int i1, int32_t val);
void cv_Mat_set_i32_3(Mat self, int i0, int i1, int i2, int32_t val);
void cv_Mat_set_f32_1(Mat self, int i0, float_t val);
void cv_Mat_set_f32_2(Mat self, int i0, int i1, float_t val);
void cv_Mat_set_f32_3(Mat self, int i0, int i1, int i2, float_t val);
void cv_Mat_set_f64_1(Mat self, int i0, double_t val);
void cv_Mat_set_f64_2(Mat self, int i0, int i1, double_t val);
void cv_Mat_set_f64_3(Mat self, int i0, int i1, int i2, double_t val);

Vec2b* cv_Mat_get_Vec2b(Mat self, int i0, int i1);
Vec3b* cv_Mat_get_Vec3b(Mat self, int i0, int i1);
Vec4b* cv_Mat_get_Vec4b(Mat self, int i0, int i1);
Vec2s* cv_Mat_get_Vec2s(Mat self, int i0, int i1);
Vec3s* cv_Mat_get_Vec3s(Mat self, int i0, int i1);
Vec4s* cv_Mat_get_Vec4s(Mat self, int i0, int i1);
Vec2w* cv_Mat_get_Vec2w(Mat self, int i0, int i1);
Vec3w* cv_Mat_get_Vec3w(Mat self, int i0, int i1);
Vec4w* cv_Mat_get_Vec4w(Mat self, int i0, int i1);
Vec2i* cv_Mat_get_Vec2i(Mat self, int i0, int i1);
Vec3i* cv_Mat_get_Vec3i(Mat self, int i0, int i1);
Vec4i* cv_Mat_get_Vec4i(Mat self, int i0, int i1);
Vec6i* cv_Mat_get_Vec6i(Mat self, int i0, int i1);
Vec8i* cv_Mat_get_Vec8i(Mat self, int i0, int i1);
Vec2f* cv_Mat_get_Vec2f(Mat self, int i0, int i1);
Vec3f* cv_Mat_get_Vec3f(Mat self, int i0, int i1);
Vec4f* cv_Mat_get_Vec4f(Mat self, int i0, int i1);
Vec6f* cv_Mat_get_Vec6f(Mat self, int i0, int i1);
Vec2d* cv_Mat_get_Vec2d(Mat self, int i0, int i1);
Vec3d* cv_Mat_get_Vec3d(Mat self, int i0, int i1);
Vec4d* cv_Mat_get_Vec4d(Mat self, int i0, int i1);
Vec6d* cv_Mat_get_Vec6d(Mat self, int i0, int i1);

void cv_Mat_set_Vec2b(Mat self, int i0, int i1, Vec2b val);
void cv_Mat_set_Vec3b(Mat self, int i0, int i1, Vec3b val);
void cv_Mat_set_Vec4b(Mat self, int i0, int i1, Vec4b val);
void cv_Mat_set_Vec2s(Mat self, int i0, int i1, Vec2s val);
void cv_Mat_set_Vec3s(Mat self, int i0, int i1, Vec3s val);
void cv_Mat_set_Vec4s(Mat self, int i0, int i1, Vec4s val);
void cv_Mat_set_Vec2w(Mat self, int i0, int i1, Vec2w val);
void cv_Mat_set_Vec3w(Mat self, int i0, int i1, Vec3w val);
void cv_Mat_set_Vec4w(Mat self, int i0, int i1, Vec4w val);
void cv_Mat_set_Vec2i(Mat self, int i0, int i1, Vec2i val);
void cv_Mat_set_Vec3i(Mat self, int i0, int i1, Vec3i val);
void cv_Mat_set_Vec4i(Mat self, int i0, int i1, Vec4i val);
void cv_Mat_set_Vec6i(Mat self, int i0, int i1, Vec6i val);
void cv_Mat_set_Vec8i(Mat self, int i0, int i1, Vec8i val);
void cv_Mat_set_Vec2f(Mat self, int i0, int i1, Vec2f val);
void cv_Mat_set_Vec3f(Mat self, int i0, int i1, Vec3f val);
void cv_Mat_set_Vec4f(Mat self, int i0, int i1, Vec4f val);
void cv_Mat_set_Vec6f(Mat self, int i0, int i1, Vec6f val);
void cv_Mat_set_Vec2d(Mat self, int i0, int i1, Vec2d val);
void cv_Mat_set_Vec3d(Mat self, int i0, int i1, Vec3d val);
void cv_Mat_set_Vec4d(Mat self, int i0, int i1, Vec4d val);
void cv_Mat_set_Vec6d(Mat self, int i0, int i1, Vec6d val);

CvStatus* cv_Mat_op_add_mat(Mat self, Mat val);
CvStatus* cv_Mat_op_sub_mat(Mat self, Mat val);
CvStatus* cv_Mat_op_mul_mat(Mat self, Mat val);
CvStatus* cv_Mat_op_div_mat(Mat self, Mat val);

CvStatus* cv_Mat_op_add_u8(Mat self, uint8_t val);
CvStatus* cv_Mat_op_sub_u8(Mat self, uint8_t val);
CvStatus* cv_Mat_op_mul_u8(Mat self, uint8_t val);
CvStatus* cv_Mat_op_div_u8(Mat self, uint8_t val);

CvStatus* cv_Mat_op_add_i8(Mat self, int8_t val);
CvStatus* cv_Mat_op_sub_i8(Mat self, int8_t val);
CvStatus* cv_Mat_op_mul_i8(Mat self, int8_t val);
CvStatus* cv_Mat_op_div_i8(Mat self, int8_t val);

CvStatus* cv_Mat_op_add_i16(Mat self, int16_t val);
CvStatus* cv_Mat_op_sub_i16(Mat self, int16_t val);
CvStatus* cv_Mat_op_mul_i16(Mat self, int16_t val);
CvStatus* cv_Mat_op_div_i16(Mat self, int16_t val);

CvStatus* cv_Mat_op_add_u16(Mat self, uint16_t val);
CvStatus* cv_Mat_op_sub_u16(Mat self, uint16_t val);
CvStatus* cv_Mat_op_mul_u16(Mat self, uint16_t val);
CvStatus* cv_Mat_op_div_u16(Mat self, uint16_t val);

CvStatus* cv_Mat_op_add_i32(Mat self, int32_t val);
CvStatus* cv_Mat_op_sub_i32(Mat self, int32_t val);
CvStatus* cv_Mat_op_mul_i32(Mat self, int32_t val);
CvStatus* cv_Mat_op_div_i32(Mat self, int32_t val);

CvStatus* cv_Mat_op_add_f32(Mat self, float_t val);
CvStatus* cv_Mat_op_sub_f32(Mat self, float_t val);
CvStatus* cv_Mat_op_mul_f32(Mat self, float_t val);
CvStatus* cv_Mat_op_div_f32(Mat self, float_t val);

CvStatus* cv_Mat_op_add_f64(Mat self, double_t val);
CvStatus* cv_Mat_op_sub_f64(Mat self, double_t val);
CvStatus* cv_Mat_op_mul_f64(Mat self, double_t val);
CvStatus* cv_Mat_op_div_f64(Mat self, double_t val);

/*
 * element-wise
 */
CvStatus* cv_Mat_mul(Mat self, Mat val, Mat* dst, double scale);

/*
 * UMat
 */

// UMat(UMatUsageFlags usageFlags = USAGE_DEFAULT) CV_NOEXCEPT;
CvStatus* cv_UMat_create_1(int usageFlags, UMat* rval);

// (_type is CV_8UC1, CV_64FC3, CV_32SC(12) etc.)
// UMat(int rows, int cols, int type, UMatUsageFlags usageFlags = USAGE_DEFAULT);
// UMat(Size size, int type, UMatUsageFlags usageFlags = USAGE_DEFAULT);
CvStatus* cv_UMat_create_2(int rows, int cols, int type, int usageFlags, UMat* rval);

//! constructs 2D matrix and fills it with the specified value _s.
// UMat(int rows, int cols, int type, const Scalar& s, UMatUsageFlags usageFlags = USAGE_DEFAULT);
// UMat(Size size, int type, const Scalar& s, UMatUsageFlags usageFlags = USAGE_DEFAULT);
CvStatus* cv_UMat_create_3(int rows, int cols, int type, Scalar s, int usageFlags, UMat* rval);

//! constructs n-dimensional matrix
// UMat(int ndims, const int* sizes, int type, UMatUsageFlags usageFlags = USAGE_DEFAULT);
// UMat(int ndims, const int* sizes, int type, const Scalar& s, UMatUsageFlags usageFlags = USAGE_DEFAULT);
CvStatus* cv_UMat_create_4(int ndims, const int* sizes, int type, int usageFlags, UMat* rval);
CvStatus* cv_UMat_create_5(
    int ndims, const int* sizes, int type, Scalar value, int usageFlags, UMat* rval
);

//! copy constructor
// UMat(const UMat& m);
CvStatus* cv_UMat_create_6(UMat self, UMat* rval);

//! creates a matrix header for a part of the bigger matrix
// UMat(const UMat& m, const Range& rowRange, const Range& colRange=Range::all());
CvStatus* cv_UMat_create_7(
    UMat self, int rowStart, int rowEnd, int colStart, int colEnd, UMat* rval
);
// UMat(const UMat& m, const Rect& roi);
CvStatus* cv_UMat_create_8(UMat self, int x, int y, int width, int height, UMat* rval);
CvStatus* cv_UMat_create_9(UMat self, CvRect roi, UMat* rval);
// UMat(const UMat& m, const Range* ranges);
// UMat(const UMat& m, const std::vector<Range>& ranges);
CvStatus* cv_UMat_create_zeros(int rows, int cols, int type, int usageFlags, UMat* rval);
CvStatus* cv_UMat_create_zeros_1(int ndims, const int* sizes, int type, int usageFlags, UMat* rval);
CvStatus* cv_UMat_create_ones(int rows, int cols, int type, int usageFlags, UMat* rval);
CvStatus* cv_UMat_create_ones_1(int ndims, const int* sizes, int type, int usageFlags, UMat* rval);
CvStatus* cv_UMat_create_eye(int rows, int cols, int type, int usageFlags, UMat* rval);
CvStatus* cv_UMat_create_diag(UMat d, int usageFlags, UMat* rval);
void cv_UMat_close(UMatPtr self);

CvStatus* cv_UMat_getMat(UMat self, int accessFlags, Mat* rval, CvCallback_0 callback);

CvStatus* cv_UMat_row(UMat self, int y, UMat* rval, CvCallback_0 callback);
CvStatus* cv_UMat_col(UMat self, int x, UMat* rval, CvCallback_0 callback);

CvStatus* cv_UMat_rowRange(UMat self, int startrow, int endrow, UMat* rval, CvCallback_0 callback);
CvStatus* cv_UMat_colRange(UMat self, int startcol, int endcol, UMat* rval, CvCallback_0 callback);

CvStatus* cv_UMat_diag(UMat self, int d, UMat* rval, CvCallback_0 callback);

CvStatus* cv_UMat_clone(UMat self, UMat* rval, CvCallback_0 callback);
CvStatus* cv_UMat_copyTo(UMat self, UMat dst, CvCallback_0 callback);
CvStatus* cv_UMat_copyTo_2(UMat self, UMat mask, UMat dst, CvCallback_0 callback);
CvStatus* cv_UMat_convertTo(
    UMat self, int rtype, double alpha, double beta, UMat dst, CvCallback_0 callback
);

//! sets some of the matrix elements to s, according to the mask
// UMat& setTo(InputArray value, InputArray mask=noArray());
CvStatus* cv_UMat_setTo(UMat self, Scalar s, UMat mask, CvCallback_0 callback);

//! creates alternative matrix header for the same data, with different
// number of channels and/or different number of rows. see cvReshape.
// UMat reshape(int cn, int rows=0) const;
// UMat reshape(int cn, int newndims, const int* newsz) const;
CvStatus* cv_UMat_reshape(UMat self, int cn, int rows, UMat* rval, CvCallback_0 callback);
CvStatus* cv_UMat_reshape_2(
    UMat self, int cn, int newndims, const int* newsz, UMat* rval, CvCallback_0 callback
);

//! matrix transposition by means of matrix expressions
// UMat t() const;
CvStatus* cv_UMat_t(UMat self, UMat* rval, CvCallback_0 callback);

CvStatus* cv_UMat_inv(UMat self, int method, UMat* rval, CvCallback_0 callback);
//! per-element matrix multiplication by means of matrix expressions
// UMat mul(InputArray m, double scale=1) const;
CvStatus* cv_UMat_mul(UMat self, UMat m, double scale, UMat* rval, CvCallback_0 callback);
CvStatus* cv_UMat_dot(UMat self, UMat m, double* rval, CvCallback_0 callback);

CvStatus* cv_UMat_createFunc(
    UMat self, int rows, int cols, int type, int usageFlags, CvCallback_0 callback
);
CvStatus* cv_UMat_createFunc_2(
    UMat self, int ndims, const int* sizes, int type, int usageFlags, CvCallback_0 callback
);

//! decreases reference counter;
// deallocates the data when reference counter reaches 0.
// void release();
void cv_UMat_release(UMat self);

// locates matrix header within a parent matrix. See below
// void locateROI (Size &wholeSize, Point &ofs) const

bool cv_UMat_isContinuous(UMat self);
bool cv_UMat_isSubmatrix(UMat self);
int cv_UMat_elemSize(UMat self);
int cv_UMat_elemSize1(UMat self);
int cv_UMat_type(UMat self);
int cv_UMat_depth(UMat self);
int cv_UMat_channels(UMat self);
size_t cv_UMat_step1(UMat self, int i);
bool cv_UMat_empty(UMat self);
size_t cv_UMat_total(UMat self);
int cv_UMat_checkVector(UMat self, int elemChannels, int depth, bool requireContinuous);
int cv_UMat_flags(UMat self);
int cv_UMat_dims(UMat self);
int cv_UMat_rows(UMat self);
int cv_UMat_cols(UMat self);
int cv_UMat_usageFlags(UMat self);
size_t cv_UMat_offset(UMat self);
VecI32* cv_UMat_size(UMat self);
MatStep cv_UMat_step(UMat self);

void cv_UMat_deallocate(UMat self);
void cv_UMat_addref(UMat self);
void* cv_UMat_handle(UMat self, int accessFlags);

#ifdef __cplusplus
}
#endif

#endif  //CVD_MAT_H
