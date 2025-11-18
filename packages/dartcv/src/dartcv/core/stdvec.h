//
// Created by rainy on 2024/12/16.
//

#ifndef STDVEC_H
#define STDVEC_H

#include <stdint.h>
#include <stddef.h>
#include "types.h"

#ifdef __cplusplus
extern "C" {

#define CVD_STD_VEC_FUNC_IMPL(TYPE, ELEM)                                  \
    CVD_STD_VEC_FUNC_IMPL_COMMON(TYPE);                                    \
    TYPE* std_##TYPE##_new(size_t length) {                                \
        return new TYPE{new std::vector<ELEM>(length)};                    \
    }                                                                      \
    TYPE* std_##TYPE##_new_1(size_t length, ELEM val) {                    \
        return new TYPE{new std::vector<ELEM>(length, val)};               \
    }                                                                      \
    TYPE* std_##TYPE##_new_2(size_t length, ELEM* val_ptr) {               \
        return new TYPE{new std::vector<ELEM>(val_ptr, val_ptr + length)}; \
    }                                                                      \
    void std_##TYPE##_push_back(TYPE* self, ELEM val) {                    \
        self->ptr->push_back(val);                                         \
    }                                                                      \
    ELEM std_##TYPE##_get(TYPE* self, size_t index) {                      \
        return self->ptr->at(index);                                       \
    }                                                                      \
    void std_##TYPE##_set(TYPE* self, size_t index, ELEM val) {            \
        self->ptr->at(index) = val;                                        \
    }                                                                      \
    ELEM* std_##TYPE##_data(TYPE* self) {                                  \
        return self->ptr->data();                                          \
    }

#define CVD_STD_VEC_FUNC_IMPL_COMMON(TYPE)                                           \
    void std_##TYPE##_free(TYPE##Ptr self) {                                         \
        delete self->ptr;                                                            \
        delete self;                                                                 \
    }                                                                                \
    size_t std_##TYPE##_length(TYPE* self) {                                         \
        return self->ptr->size();                                                    \
    }                                                                                \
    void std_##TYPE##_resize(TYPE* self, size_t new_len) {                           \
        self->ptr->resize(new_len);                                                  \
    }                                                                                \
    void std_##TYPE##_reserve(TYPE* self, size_t new_len) {                          \
        self->ptr->reserve(new_len);                                                 \
    }                                                                                \
    void std_##TYPE##_clear(TYPE* self) {                                            \
        self->ptr->clear();                                                          \
    }                                                                                \
    void std_##TYPE##_shrink_to_fit(TYPE* self) {                                    \
        self->ptr->shrink_to_fit();                                                  \
    }                                                                                \
    void std_##TYPE##_extend(TYPE* self, TYPE* other) {                              \
        self->ptr->insert(self->ptr->end(), other->ptr->begin(), other->ptr->end()); \
    }
#endif

#define CVD_STD_VEC_FUNC_DEF(TYPE, ELEM)                       \
    TYPE* std_##TYPE##_new(size_t length);                     \
    TYPE* std_##TYPE##_new_1(size_t length, ELEM val);         \
    TYPE* std_##TYPE##_new_2(size_t length, ELEM* val_ptr);    \
    void std_##TYPE##_free(TYPE##Ptr self);                    \
    void std_##TYPE##_push_back(TYPE* self, ELEM val);         \
    ELEM std_##TYPE##_get(TYPE* self, size_t index);           \
    void std_##TYPE##_set(TYPE* self, size_t index, ELEM val); \
    size_t std_##TYPE##_length(TYPE* self);                    \
    ELEM* std_##TYPE##_data(TYPE* self);                       \
    void std_##TYPE##_resize(TYPE* self, size_t new_len);      \
    void std_##TYPE##_reserve(TYPE* self, size_t new_len);     \
    void std_##TYPE##_clear(TYPE* self);                       \
    void std_##TYPE##_shrink_to_fit(TYPE* self);               \
    void std_##TYPE##_extend(TYPE* self, TYPE* other)

CVD_STD_VEC_FUNC_DEF(VecU8, uint8_t);
VecU8* std_VecU8_clone(VecU8* self);
CVD_STD_VEC_FUNC_DEF(VecUChar, unsigned char);
VecUChar* std_VecUChar_clone(VecUChar* self);
CVD_STD_VEC_FUNC_DEF(VecI8, int8_t);
VecI8* std_VecI8_clone(VecI8* self);
CVD_STD_VEC_FUNC_DEF(VecChar, char);
VecChar* std_VecChar_clone(VecChar* self);
CVD_STD_VEC_FUNC_DEF(VecU16, uint16_t);
VecU16* std_VecU16_clone(VecU16* self);
CVD_STD_VEC_FUNC_DEF(VecI16, int16_t);
VecI16* std_VecI16_clone(VecI16* self);
CVD_STD_VEC_FUNC_DEF(VecU32, uint32_t);
VecU32* std_VecU32_clone(VecU32* self);
CVD_STD_VEC_FUNC_DEF(VecI32, int32_t);
VecI32* std_VecI32_clone(VecI32* self);
CVD_STD_VEC_FUNC_DEF(VecU64, uint64_t);
VecU64* std_VecU64_clone(VecU64* self);
CVD_STD_VEC_FUNC_DEF(VecI64, int64_t);
VecI64* std_VecI64_clone(VecI64* self);
CVD_STD_VEC_FUNC_DEF(VecF32, float_t);
VecF32* std_VecF32_clone(VecF32* self);
CVD_STD_VEC_FUNC_DEF(VecF64, double_t);
VecF64* std_VecF64_clone(VecF64* self);
CVD_STD_VEC_FUNC_DEF(VecF16, uint16_t);
VecF16* std_VecF16_clone(VecF16* self);

// CVD_STD_VEC_FUNC_DEF(VecVecChar, VecChar);
VecVecChar* std_VecVecChar_new(size_t length);
VecVecChar* std_VecVecChar_new_1(size_t length, VecChar* val);
VecVecChar* std_VecVecChar_new_2(VecVecChar* val_ptr);
VecVecChar* std_VecVecChar_new_3(char** val, VecI32 sizes);
void std_VecVecChar_free(VecVecChar* self);
size_t std_VecVecChar_length(VecVecChar* self);
void std_VecVecChar_push_back(VecVecChar* self, VecChar val);
VecChar* std_VecVecChar_get(VecVecChar* self, int index);
void std_VecVecChar_set(VecVecChar* self, int index, VecChar* val);
VecChar* std_VecVecChar_data(VecVecChar* self);
void std_VecVecChar_reserve(VecVecChar* self, size_t size);
void std_VecVecChar_resize(VecVecChar* self, size_t size);
void std_VecVecChar_clear(VecVecChar* self);
void std_VecVecChar_shrink_to_fit(VecVecChar* self);
VecVecChar* std_VecVecChar_clone(VecVecChar* self);

CVD_STD_VEC_FUNC_DEF(VecMat, Mat);
Mat* std_VecMat_get_p(VecMat* self, int index);

CVD_STD_VEC_FUNC_DEF(VecPoint, CvPoint);
CvPoint* std_VecPoint_get_p(VecPoint* self, int index);

CVD_STD_VEC_FUNC_DEF(VecPoint2f, CvPoint2f);
CvPoint2f* std_VecPoint2f_get_p(VecPoint2f* self, int index);

CVD_STD_VEC_FUNC_DEF(VecPoint3f, CvPoint3f);
CvPoint3f* std_VecPoint3f_get_p(VecPoint3f* self, int index);

CVD_STD_VEC_FUNC_DEF(VecPoint3i, CvPoint3i);
CvPoint3i* std_VecPoint3i_get_p(VecPoint3i* self, int index);

CVD_STD_VEC_FUNC_DEF(VecRect, CvRect);
CvRect* std_VecRect_get_p(VecRect* self, int index);

CVD_STD_VEC_FUNC_DEF(VecRect2f, CvRect2f);
CvRect2f* std_VecRect2f_get_p(VecRect2f* self, int index);

CVD_STD_VEC_FUNC_DEF(VecRotatedRect, RotatedRect);
RotatedRect* std_VecRotatedRect_get_p(VecRotatedRect* self, int index);

CVD_STD_VEC_FUNC_DEF(VecKeyPoint, KeyPoint);
KeyPoint* std_VecKeyPoint_get_p(VecKeyPoint* self, int index);

CVD_STD_VEC_FUNC_DEF(VecDMatch, DMatch);
DMatch* std_VecDMatch_get_p(VecDMatch* self, int index);

CVD_STD_VEC_FUNC_DEF(VecVec4i, Vec4i);
Vec4i* std_VecVec4i_get_p(VecVec4i* self, int index);

CVD_STD_VEC_FUNC_DEF(VecVec4f, Vec4f);
Vec4f* std_VecVec4f_get_p(VecVec4f* self, int index);

CVD_STD_VEC_FUNC_DEF(VecVec6f, Vec6f);
Vec6f* std_VecVec6f_get_p(VecVec6f* self, int index);

CVD_STD_VEC_FUNC_DEF(VecVecDMatch, VecDMatch);
VecDMatch* std_VecVecDMatch_get_p(VecVecDMatch* self, int index);
DMatch* std_VecVecDMatch_get_ij(VecVecDMatch* self, size_t i, size_t j);
size_t std_VecVecDMatch_length_i(VecVecDMatch* self, size_t i);
VecVecDMatch* std_VecVecDMatch_clone(VecVecDMatch* self);

CVD_STD_VEC_FUNC_DEF(VecVecPoint, VecPoint);
VecPoint* std_VecVecPoint_get_p(VecVecPoint* self, int index);
CvPoint* std_VecVecPoint_get_ij(VecVecPoint* self, size_t i, size_t j);
size_t std_VecVecPoint_length_i(VecVecPoint* self, size_t i);

CVD_STD_VEC_FUNC_DEF(VecVecPoint2f, VecPoint2f);
VecPoint2f* std_VecVecPoint2f_get_p(VecVecPoint2f* self, int index);
CvPoint2f* std_VecVecPoint2f_get_ij(VecVecPoint2f* self, size_t i, size_t j);
size_t std_VecVecPoint2f_length_i(VecVecPoint2f* self, size_t i);

CVD_STD_VEC_FUNC_DEF(VecVecPoint3f, VecPoint3f);
VecPoint3f* std_VecVecPoint3f_get_p(VecVecPoint3f* self, int index);
CvPoint3f* std_VecVecPoint3f_get_ij(VecVecPoint3f* self, size_t i, size_t j);
size_t std_VecVecPoint3f_length_i(VecVecPoint3f* self, size_t i);

CVD_STD_VEC_FUNC_DEF(VecVecPoint3i, VecPoint3i);
VecPoint3i* std_VecVecPoint3i_get_p(VecVecPoint3i* self, int index);
CvPoint3i* std_VecVecPoint3i_get_ij(VecVecPoint3i* self, size_t i, size_t j);
size_t std_VecVecPoint3i_length_i(VecVecPoint3i* self, size_t i);

#ifdef __cplusplus
}
#endif

#endif  //STDVEC_H
