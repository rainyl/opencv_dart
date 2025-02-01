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

#ifdef __cplusplus
}
#endif

#endif  //CVD_MAT_H
