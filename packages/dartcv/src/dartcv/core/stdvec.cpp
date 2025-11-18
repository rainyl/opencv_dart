//
// Created by rainy on 2024/12/16.
//

#include "stdvec.h"

#include <cstddef>
#include <iostream>
#include <string>
#include <vector>

CVD_STD_VEC_FUNC_IMPL(VecU8, uint8_t);
VecU8* std_VecU8_clone(VecU8* self) {
    return new VecU8{new std::vector<uint8_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecUChar, unsigned char);
VecUChar* std_VecUChar_clone(VecUChar* self) {
    return new VecUChar{new std::vector<unsigned char>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecI8, int8_t);
VecI8* std_VecI8_clone(VecI8* self) {
    return new VecI8{new std::vector<int8_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecChar, char);
VecChar* std_VecChar_clone(VecChar* self) {
    return new VecChar{new std::vector<char>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecU16, uint16_t);
VecU16* std_VecU16_clone(VecU16* self) {
    return new VecU16{new std::vector<uint16_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecI16, int16_t);
VecI16* std_VecI16_clone(VecI16* self) {
    return new VecI16{new std::vector<int16_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecU32, uint32_t);
VecU32* std_VecU32_clone(VecU32* self) {
    return new VecU32{new std::vector<uint32_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecI32, int32_t);
VecI32* std_VecI32_clone(VecI32* self) {
    return new VecI32{new std::vector<int32_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecU64, uint64_t);
VecU64* std_VecU64_clone(VecU64* self) {
    return new VecU64{new std::vector<uint64_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecI64, int64_t);
VecI64* std_VecI64_clone(VecI64* self) {
    return new VecI64{new std::vector<int64_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecF32, float_t);
VecF32* std_VecF32_clone(VecF32* self) {
    return new VecF32{new std::vector<float_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecF64, double_t);
VecF64* std_VecF64_clone(VecF64* self) {
    return new VecF64{new std::vector<double_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL(VecF16, uint16_t);
VecF16* std_VecF16_clone(VecF16* self) {
    return new VecF16{new std::vector<uint16_t>(CVDEREF_P(self))};
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecMat);
VecMat* std_VecMat_new(size_t length) {
    return new VecMat{new std::vector<cv::Mat>(length)};
}

VecMat* std_VecMat_new_1(size_t length, Mat val) {
    return new VecMat{new std::vector<cv::Mat>(length, CVDEREF(val))};
}

VecMat* std_VecMat_new_2(size_t length, Mat* val_ptr) {
    auto ptr = new std::vector<cv::Mat>(length);
    for (int i = 0; i < length; ++i) {
        ptr->at(i) = CVDEREF(val_ptr[i]);
    }
    return new VecMat{ptr};
}

void std_VecMat_push_back(VecMat* self, Mat val) {
    self->ptr->push_back(CVDEREF(val));
}
Mat std_VecMat_get(VecMat* self, size_t index) {
    return Mat{new cv::Mat(self->ptr->at(index))};
}
Mat* std_VecMat_get_p(VecMat* self, int index) {
    return new Mat{new cv::Mat(self->ptr->at(index))};
}
void std_VecMat_set(VecMat* self, size_t index, Mat val) {
    self->ptr->at(index) = CVDEREF(val);
}
Mat* std_VecMat_data(VecMat* self) {
    const auto pdata = self->ptr->data();
    Mat* ptr = new Mat[self->ptr->size()];
    for (int i = 0; i < self->ptr->size(); ++i) {
        ptr[i] = Mat{new cv::Mat(pdata[i])};
    }
    return ptr;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecPoint);
VecPoint* std_VecPoint_new(size_t length) {
    return new VecPoint{new std::vector<cv::Point>(length)};
}

VecPoint* std_VecPoint_new_1(size_t length, CvPoint val) {
    return new VecPoint{new std::vector<cv::Point>(length, cv::Point(val.x, val.y))};
}

VecPoint* std_VecPoint_new_2(size_t length, CvPoint* val_ptr) {
    auto ptr = new std::vector<cv::Point>(length);
    for (int i = 0; i < length; ++i) {
        ptr->at(i) = cv::Point(val_ptr[i].x, val_ptr[i].y);
    }
    return new VecPoint{ptr};
}

void std_VecPoint_push_back(VecPoint* self, CvPoint val) {
    self->ptr->emplace_back(val.x, val.y);
}
CvPoint std_VecPoint_get(VecPoint* self, size_t index) {
    auto p = self->ptr->at(index);
    return {p.x, p.y};
}
CvPoint* std_VecPoint_get_p(VecPoint* self, int index) {
    return new CvPoint{self->ptr->at(index).x, self->ptr->at(index).y};
}

void std_VecPoint_set(VecPoint* self, size_t index, CvPoint val) {
    self->ptr->at(index) = cv::Point(val.x, val.y);
}

CvPoint* std_VecPoint_data(VecPoint* self) {
    auto p = new CvPoint[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = {self->ptr->at(i).x, self->ptr->at(i).y};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecPoint2f);
VecPoint2f* std_VecPoint2f_new(size_t length) {
    return new VecPoint2f{new std::vector<cv::Point2f>(length)};
}

VecPoint2f* std_VecPoint2f_new_1(size_t length, CvPoint2f val) {
    return new VecPoint2f{new std::vector<cv::Point2f>(length, cv::Point2f(val.x, val.y))};
}

VecPoint2f* std_VecPoint2f_new_2(size_t length, CvPoint2f* val_ptr) {
    auto ptr = new std::vector<cv::Point2f>(length);
    for (size_t i = 0; i < length; i++) {
        ptr->at(i) = cv::Point2f(val_ptr[i].x, val_ptr[i].y);
    }
    return new VecPoint2f{ptr};
}

void std_VecPoint2f_push_back(VecPoint2f* self, CvPoint2f val) {
    self->ptr->emplace_back(val.x, val.y);
}
CvPoint2f std_VecPoint2f_get(VecPoint2f* self, size_t index) {
    auto p = self->ptr->at(index);
    return {p.x, p.y};
}
CvPoint2f* std_VecPoint2f_get_p(VecPoint2f* self, int index) {
    return new CvPoint2f{self->ptr->at(index).x, self->ptr->at(index).y};
}

void std_VecPoint2f_set(VecPoint2f* self, size_t index, CvPoint2f val) {
    self->ptr->at(index) = cv::Point2f(val.x, val.y);
}

CvPoint2f* std_VecPoint2f_data(VecPoint2f* self) {
    auto p = new CvPoint2f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = {(*self->ptr)[i].x, (*self->ptr)[i].y};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecPoint3f);
VecPoint3f* std_VecPoint3f_new(size_t length) {
    return new VecPoint3f{new std::vector<cv::Point3f>(length)};
}

VecPoint3f* std_VecPoint3f_new_1(size_t length, CvPoint3f val) {
    return new VecPoint3f{new std::vector<cv::Point3f>(length, cv::Point3f(val.x, val.y, val.z))};
}

VecPoint3f* std_VecPoint3f_new_2(size_t length, CvPoint3f* val_ptr) {
    auto p = new std::vector<cv::Point3f>(length);
    for (size_t i = 0; i < length; i++) {
        p->at(i) = cv::Point3f(val_ptr[i].x, val_ptr[i].y, val_ptr[i].z);
    }
    return new VecPoint3f{p};
}

void std_VecPoint3f_push_back(VecPoint3f* self, CvPoint3f val) {
    self->ptr->emplace_back(val.x, val.y, val.z);
}
CvPoint3f std_VecPoint3f_get(VecPoint3f* self, size_t index) {
    auto p = self->ptr->at(index);
    return {p.x, p.y, p.z};
}
CvPoint3f* std_VecPoint3f_get_p(VecPoint3f* self, int index) {
    return new CvPoint3f{self->ptr->at(index).x, self->ptr->at(index).y, self->ptr->at(index).z};
}

void std_VecPoint3f_set(VecPoint3f* self, size_t index, CvPoint3f val) {
    self->ptr->at(index) = cv::Point3f(val.x, val.y, val.z);
}

CvPoint3f* std_VecPoint3f_data(VecPoint3f* self) {
    auto p = new CvPoint3f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto t = self->ptr->at(i);
        p[i] = {t.x, t.y, t.z};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecPoint3i);
VecPoint3i* std_VecPoint3i_new(size_t length) {
    return new VecPoint3i{new std::vector<cv::Point3i>(length)};
}

VecPoint3i* std_VecPoint3i_new_1(size_t length, CvPoint3i val) {
    return new VecPoint3i{new std::vector<cv::Point3i>(length, cv::Point3i(val.x, val.y, val.z))};
}

VecPoint3i* std_VecPoint3i_new_2(size_t length, CvPoint3i* val_ptr) {
    auto ptr = new std::vector<cv::Point3i>(length);
    for (size_t i = 0; i < length; i++) {
        ptr->at(i) = cv::Point3i(val_ptr[i].x, val_ptr[i].y, val_ptr[i].z);
    }
    return new VecPoint3i{ptr};
}

void std_VecPoint3i_push_back(VecPoint3i* self, CvPoint3i val) {
    self->ptr->emplace_back(val.x, val.y, val.z);
}
CvPoint3i std_VecPoint3i_get(VecPoint3i* self, size_t index) {
    auto p = self->ptr->at(index);
    return {p.x, p.y, p.z};
}
CvPoint3i* std_VecPoint3i_get_p(VecPoint3i* self, int index) {
    auto p = self->ptr->at(index);
    return new CvPoint3i{p.x, p.y, p.z};
}

void std_VecPoint3i_set(VecPoint3i* self, size_t index, CvPoint3i val) {
    self->ptr->at(index) = cv::Point3i(val.x, val.y, val.z);
}

CvPoint3i* std_VecPoint3i_data(VecPoint3i* self) {
    auto p = new CvPoint3i[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = {self->ptr->at(i).x, self->ptr->at(i).y, self->ptr->at(i).z};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecRect);
VecRect* std_VecRect_new(size_t length) {
    return new VecRect{new std::vector<cv::Rect>(length)};
}

VecRect* std_VecRect_new_1(size_t length, CvRect val) {
    return new VecRect{
        new std::vector<cv::Rect>(length, cv::Rect(val.x, val.y, val.width, val.height))
    };
}

VecRect* std_VecRect_new_2(size_t length, CvRect* val_ptr) {
    auto ptr = new std::vector<cv::Rect>(length);
    for (size_t i = 0; i < length; i++) {
        ptr->at(i) = cv::Rect(val_ptr[i].x, val_ptr[i].y, val_ptr[i].width, val_ptr[i].height);
    }
    return new VecRect{ptr};
}

void std_VecRect_push_back(VecRect* self, CvRect val) {
    self->ptr->emplace_back(val.x, val.y, val.width, val.height);
}
CvRect std_VecRect_get(VecRect* self, size_t index) {
    auto r = self->ptr->at(index);
    return {r.x, r.y, r.width, r.height};
}
CvRect* std_VecRect_get_p(VecRect* self, int index) {
    auto val = self->ptr->at(index);
    return new CvRect{val.x, val.y, val.width, val.height};
}

void std_VecRect_set(VecRect* self, size_t index, CvRect val) {
    self->ptr->at(index) = cv::Rect(val.x, val.y, val.width, val.height);
}
CvRect* std_VecRect_data(VecRect* self) {
    auto p = new CvRect[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto r = self->ptr->at(i);
        p[i] = {r.x, r.y, r.width, r.height};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecRect2f);
VecRect2f* std_VecRect2f_new(size_t length) {
    return new VecRect2f{new std::vector<cv::Rect2f>(length)};
}

VecRect2f* std_VecRect2f_new_1(size_t length, CvRect2f val) {
    return new VecRect2f{
        new std::vector<cv::Rect2f>(length, cv::Rect2f(val.x, val.y, val.width, val.height))
    };
}

VecRect2f* std_VecRect2f_new_2(size_t length, CvRect2f* val_ptr) {
    auto ptr = new std::vector<cv::Rect2f>(length);
    for (size_t i = 0; i < length; i++) {
        ptr->at(i) = cv::Rect2f(val_ptr[i].x, val_ptr[i].y, val_ptr[i].width, val_ptr[i].height);
    }
    return new VecRect2f{ptr};
}

void std_VecRect2f_push_back(VecRect2f* self, CvRect2f val) {
    self->ptr->emplace_back(val.x, val.y, val.width, val.height);
}
CvRect2f std_VecRect2f_get(VecRect2f* self, size_t index) {
    auto r = self->ptr->at(index);
    return {r.x, r.y, r.width, r.height};
}
CvRect2f* std_VecRect2f_get_p(VecRect2f* self, int index) {
    auto r = self->ptr->at(index);
    return new CvRect2f{r.x, r.y, r.width, r.height};
}

void std_VecRect2f_set(VecRect2f* self, size_t index, CvRect2f val) {
    self->ptr->at(index) = cv::Rect2f(val.x, val.y, val.width, val.height);
}
CvRect2f* std_VecRect2f_data(VecRect2f* self) {
    auto p = new CvRect2f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto r = self->ptr->at(i);
        p[i] = {r.x, r.y, r.width, r.height};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecRotatedRect);
VecRotatedRect* std_VecRotatedRect_new(size_t length) {
    return new VecRotatedRect{new std::vector<cv::RotatedRect>(length)};
}

VecRotatedRect* std_VecRotatedRect_new_1(size_t length, RotatedRect val) {
    auto r = cv::RotatedRect(
        cv::Point2f(val.center.x, val.center.y),
        cv::Size2f(val.size.width, val.size.height),
        val.angle
    );
    return new VecRotatedRect{new std::vector<cv::RotatedRect>(length, r)};
}

VecRotatedRect* std_VecRotatedRect_new_2(size_t length, RotatedRect* val_ptr) {
    auto ptr = new std::vector<cv::RotatedRect>(length);
    for (size_t i = 0; i < length; i++) {
        auto r = cv::RotatedRect(
            cv::Point2f(val_ptr[i].center.x, val_ptr[i].center.y),
            cv::Size2f(val_ptr[i].size.width, val_ptr[i].size.height),
            val_ptr[i].angle
        );
        ptr->at(i) = r;
    }
    return new VecRotatedRect{ptr};
}

void std_VecRotatedRect_push_back(VecRotatedRect* self, RotatedRect val) {
    self->ptr->emplace_back(
        cv::Point2f(val.center.x, val.center.y),
        cv::Size2f(val.size.width, val.size.height),
        val.angle
    );
}

RotatedRect std_VecRotatedRect_get(VecRotatedRect* self, size_t index) {
    auto r = self->ptr->at(index);
    return {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
}
RotatedRect* std_VecRotatedRect_get_p(VecRotatedRect* self, int index) {
    auto r = self->ptr->at(index);
    return new RotatedRect{{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
}

void std_VecRotatedRect_set(VecRotatedRect* self, size_t index, RotatedRect val) {
    self->ptr->at(index) = cv::RotatedRect(
        cv::Point2f(val.center.x, val.center.y),
        cv::Size2f(val.size.width, val.size.height),
        val.angle
    );
}

RotatedRect* std_VecRotatedRect_data(VecRotatedRect* self) {
    auto p = new RotatedRect[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto r = self->ptr->at(i);
        p[i] = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecKeyPoint);
VecKeyPoint* std_VecKeyPoint_new(size_t length) {
    return new VecKeyPoint{new std::vector<cv::KeyPoint>(length)};
}

VecKeyPoint* std_VecKeyPoint_new_1(size_t length, KeyPoint val) {
    auto p = cv::KeyPoint(val.x, val.y, val.size, val.angle, val.response, val.octave, val.classID);
    return new VecKeyPoint{new std::vector<cv::KeyPoint>(length, p)};
}

VecKeyPoint* std_VecKeyPoint_new_2(size_t length, KeyPoint* val_ptr) {
    auto ptr = new std::vector<cv::KeyPoint>(length);
    for (size_t i = 0; i < length; i++) {
        auto p = cv::KeyPoint(
            val_ptr[i].x,
            val_ptr[i].y,
            val_ptr[i].size,
            val_ptr[i].angle,
            val_ptr[i].response,
            val_ptr[i].octave,
            val_ptr[i].classID
        );
        ptr->at(i) = p;
    }
    return new VecKeyPoint{ptr};
}

void std_VecKeyPoint_push_back(VecKeyPoint* self, KeyPoint val) {
    self->ptr->emplace_back(
        val.x, val.y, val.size, val.angle, val.response, val.octave, val.classID
    );
}
KeyPoint std_VecKeyPoint_get(VecKeyPoint* self, size_t index) {
    auto p = self->ptr->at(index);
    return KeyPoint{
        .x = p.pt.x,
        .y = p.pt.y,
        .size = p.size,
        .angle = p.angle,
        .response = p.response,
        .octave = p.octave,
        .classID = p.class_id
    };
}
KeyPoint* std_VecKeyPoint_get_p(VecKeyPoint* self, int index) {
    auto p = self->ptr->at(index);
    return new KeyPoint{
        .x = p.pt.x,
        .y = p.pt.y,
        .size = p.size,
        .angle = p.angle,
        .response = p.response,
        .octave = p.octave,
        .classID = p.class_id
    };
}

void std_VecKeyPoint_set(VecKeyPoint* self, size_t index, KeyPoint val) {
    self->ptr->at(index) =
        cv::KeyPoint(val.x, val.y, val.size, val.angle, val.response, val.octave, val.classID);
}

KeyPoint* std_VecKeyPoint_data(VecKeyPoint* self) {
    auto p = new KeyPoint[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto kp = self->ptr->at(i);
        p[i] = KeyPoint{
            .x = kp.pt.x,
            .y = kp.pt.y,
            .size = kp.size,
            .angle = kp.angle,
            .response = kp.response,
            .octave = kp.octave,
            .classID = kp.class_id,
        };
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecDMatch);
VecDMatch* std_VecDMatch_new(size_t length) {
    return new VecDMatch{new std::vector<cv::DMatch>(length)};
}

VecDMatch* std_VecDMatch_new_1(size_t length, DMatch val) {
    auto d = cv::DMatch(val.queryIdx, val.trainIdx, val.imgIdx, val.distance);
    return new VecDMatch{new std::vector<cv::DMatch>(length, d)};
}

VecDMatch* std_VecDMatch_new_2(size_t length, DMatch* val_ptr) {
    auto v = new std::vector<cv::DMatch>(length);
    for (size_t i = 0; i < length; i++) {
        v->at(i) = cv::DMatch(
            val_ptr[i].queryIdx, val_ptr[i].trainIdx, val_ptr[i].imgIdx, val_ptr[i].distance
        );
    }
    return new VecDMatch{v};
}

void std_VecDMatch_push_back(VecDMatch* self, DMatch val) {
    self->ptr->emplace_back(val.queryIdx, val.trainIdx, val.imgIdx, val.distance);
}
DMatch std_VecDMatch_get(VecDMatch* self, size_t index) {
    auto d = self->ptr->at(index);
    return DMatch{
        .queryIdx = d.queryIdx, .trainIdx = d.trainIdx, .imgIdx = d.imgIdx, .distance = d.distance
    };
}
DMatch* std_VecDMatch_get_p(VecDMatch* self, int index) {
    auto d = self->ptr->at(index);
    return new DMatch{
        .queryIdx = d.queryIdx, .trainIdx = d.trainIdx, .imgIdx = d.imgIdx, .distance = d.distance
    };
}

void std_VecDMatch_set(VecDMatch* self, size_t index, DMatch val) {
    self->ptr->at(index) = cv::DMatch(val.queryIdx, val.trainIdx, val.imgIdx, val.distance);
}
DMatch* std_VecDMatch_data(VecDMatch* self) {
    auto p = new DMatch[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto t = self->ptr->at(i);
        p[i] = {t.queryIdx, t.trainIdx, t.imgIdx, t.distance};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVec4i);
VecVec4i* std_VecVec4i_new(size_t length) {
    return new VecVec4i{new std::vector<cv::Vec4i>(length)};
}

VecVec4i* std_VecVec4i_new_1(size_t length, Vec4i val) {
    return new VecVec4i{
        new std::vector<cv::Vec4i>(length, cv::Vec4i(val.val1, val.val2, val.val3, val.val4))
    };
}

VecVec4i* std_VecVec4i_new_2(size_t length, Vec4i* val_ptr) {
    auto p = new std::vector<cv::Vec4i>(length);
    for (size_t i = 0; i < length; i++) {
        p->at(i) = cv::Vec4i(val_ptr[i].val1, val_ptr[i].val2, val_ptr[i].val3, val_ptr[i].val4);
    }
    return new VecVec4i{p};
}

void std_VecVec4i_push_back(VecVec4i* self, Vec4i val) {
    self->ptr->emplace_back(val.val1, val.val2, val.val3, val.val4);
}
Vec4i std_VecVec4i_get(VecVec4i* self, size_t index) {
    auto val = self->ptr->at(index);
    return Vec4i{val[0], val[1], val[2], val[3]};
}
Vec4i* std_VecVec4i_get_p(VecVec4i* self, int index) {
    auto v = self->ptr->at(index);
    return new Vec4i{v[0], v[1], v[2], v[3]};
}

void std_VecVec4i_set(VecVec4i* self, size_t index, Vec4i val) {
    self->ptr->at(index) = cv::Vec4i(val.val1, val.val2, val.val3, val.val4);
}
Vec4i* std_VecVec4i_data(VecVec4i* self) {
    auto p = new Vec4i[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto val = self->ptr->at(i);
        p[i] = Vec4i{val[0], val[1], val[2], val[3]};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVec4f);
VecVec4f* std_VecVec4f_new(size_t length) {
    return new VecVec4f{new std::vector<cv::Vec4f>(length)};
}

VecVec4f* std_VecVec4f_new_1(size_t length, Vec4f val) {
    return new VecVec4f{
        new std::vector<cv::Vec4f>(length, cv::Vec4f(val.val1, val.val2, val.val3, val.val4))
    };
}

VecVec4f* std_VecVec4f_new_2(size_t length, Vec4f* val_ptr) {
    auto v = new std::vector<cv::Vec4f>(length);
    for (size_t i = 0; i < length; i++) {
        v->at(i) = cv::Vec4f(val_ptr[i].val1, val_ptr[i].val2, val_ptr[i].val3, val_ptr[i].val4);
    }
    return new VecVec4f{v};
}

void std_VecVec4f_push_back(VecVec4f* self, Vec4f val) {
    self->ptr->emplace_back(val.val1, val.val2, val.val3, val.val4);
}
Vec4f std_VecVec4f_get(VecVec4f* self, size_t index) {
    auto v = self->ptr->at(index);
    return Vec4f{v[0], v[1], v[2], v[3]};
}
Vec4f* std_VecVec4f_get_p(VecVec4f* self, int index) {
    auto v = self->ptr->at(index);
    return new Vec4f{v[0], v[1], v[2], v[3]};
}

void std_VecVec4f_set(VecVec4f* self, size_t index, Vec4f val) {
    self->ptr->at(index) = cv::Vec4f(val.val1, val.val2, val.val3, val.val4);
}
Vec4f* std_VecVec4f_data(VecVec4f* self) {
    auto p = new Vec4f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = Vec4f{
            self->ptr->at(i)[0], self->ptr->at(i)[1], self->ptr->at(i)[2], self->ptr->at(i)[3]
        };
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVec6f);
VecVec6f* std_VecVec6f_new(size_t length) {
    return new VecVec6f{new std::vector<cv::Vec6f>(length)};
}

VecVec6f* std_VecVec6f_new_1(size_t length, Vec6f val) {
    return new VecVec6f{new std::vector<cv::Vec6f>(
        length, cv::Vec6f(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6)
    )};
}

VecVec6f* std_VecVec6f_new_2(size_t length, Vec6f* val_ptr) {
    auto v = new std::vector<cv::Vec6f>(length);
    for (size_t i = 0; i < length; i++) {
        v->at(i) = cv::Vec6f(
            val_ptr[i].val1,
            val_ptr[i].val2,
            val_ptr[i].val3,
            val_ptr[i].val4,
            val_ptr[i].val5,
            val_ptr[i].val6
        );
    }
    return new VecVec6f{v};
}

void std_VecVec6f_push_back(VecVec6f* self, Vec6f val) {
    self->ptr->emplace_back(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6);
}
Vec6f std_VecVec6f_get(VecVec6f* self, size_t index) {
    auto v = self->ptr->at(index);
    return Vec6f{
        .val1 = v[0], .val2 = v[1], .val3 = v[2], .val4 = v[3], .val5 = v[4], .val6 = v[5]
    };
}
Vec6f* std_VecVec6f_get_p(VecVec6f* self, int index) {
    auto v = self->ptr->at(index);
    return new Vec6f{
        .val1 = v[0], .val2 = v[1], .val3 = v[2], .val4 = v[3], .val5 = v[4], .val6 = v[5]
    };
}

void std_VecVec6f_set(VecVec6f* self, size_t index, Vec6f val) {
    self->ptr->at(index) = cv::Vec6f(val.val1, val.val2, val.val3, val.val4, val.val5, val.val6);
}
Vec6f* std_VecVec6f_data(VecVec6f* self) {
    auto p = new Vec6f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        auto v = self->ptr->at(i);
        p[i] = Vec6f{
            .val1 = v[0], .val2 = v[1], .val3 = v[2], .val4 = v[3], .val5 = v[4], .val6 = v[5]
        };
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVecDMatch);
VecVecDMatch* std_VecVecDMatch_new(size_t length) {
    return new VecVecDMatch{new std::vector<std::vector<cv::DMatch>>(length)};
}

VecVecDMatch* std_VecVecDMatch_new_1(size_t length, VecDMatch val) {
    return new VecVecDMatch{new std::vector<std::vector<cv::DMatch>>(length, CVDEREF(val))};
}

VecVecDMatch* std_VecVecDMatch_new_2(size_t length, VecDMatch* val_ptr) {
    auto p = new std::vector<std::vector<cv::DMatch>>(length);
    for (size_t i = 0; i < length; i++) {
        p->at(i) = CVDEREF(val_ptr[i]);
    }
    return new VecVecDMatch{p};
}

void std_VecVecDMatch_push_back(VecVecDMatch* self, VecDMatch val) {
    self->ptr->push_back(CVDEREF(val));
}
VecDMatch std_VecVecDMatch_get(VecVecDMatch* self, size_t index) {
    return VecDMatch{new std::vector<cv::DMatch>(self->ptr->at(index))};
}
VecDMatch* std_VecVecDMatch_get_p(VecVecDMatch* self, int index) {
    auto v = self->ptr->at(index);
    return new VecDMatch{new std::vector<cv::DMatch>(v)};
}

DMatch* std_VecVecDMatch_get_ij(VecVecDMatch* self, size_t i, size_t j) {
    auto dm = self->ptr->at(i).at(j);
    return new DMatch{dm.queryIdx, dm.trainIdx, dm.imgIdx, dm.distance};
}

size_t std_VecVecDMatch_length_i(VecVecDMatch* self, size_t i) {
    return self->ptr->at(i).size();
}

VecVecDMatch* std_VecVecDMatch_clone(VecVecDMatch* self){
    return new VecVecDMatch{new std::vector<std::vector<cv::DMatch>>(*self->ptr)};
}

void std_VecVecDMatch_set(VecVecDMatch* self, size_t index, VecDMatch val) {
    self->ptr->at(index) = CVDEREF(val);
}

VecDMatch* std_VecVecDMatch_data(VecVecDMatch* self) {
    auto p = new VecDMatch[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = VecDMatch{new std::vector<cv::DMatch>(self->ptr->at(i))};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVecPoint);
VecVecPoint* std_VecVecPoint_new(size_t length) {
    return new VecVecPoint{new std::vector<std::vector<cv::Point>>(length)};
}

VecVecPoint* std_VecVecPoint_new_1(size_t length, VecPoint val) {
    return new VecVecPoint{new std::vector<std::vector<cv::Point>>(length, CVDEREF(val))};
}

VecVecPoint* std_VecVecPoint_new_2(size_t length, VecPoint* val_ptr) {
    auto val = new std::vector<std::vector<cv::Point>>(length);
    for (size_t i = 0; i < length; i++) {
        val->at(i) = CVDEREF(val_ptr[i]);
    }
    return new VecVecPoint{val};
}

void std_VecVecPoint_push_back(VecVecPoint* self, VecPoint val) {
    self->ptr->push_back(CVDEREF(val));
}
VecPoint std_VecVecPoint_get(VecVecPoint* self, size_t index) {
    return VecPoint{new std::vector<cv::Point>(self->ptr->at(index))};
}
VecPoint* std_VecVecPoint_get_p(VecVecPoint* self, int index) {
    return new VecPoint{&(self->ptr->at(index))};
}

CvPoint* std_VecVecPoint_get_ij(VecVecPoint* self, size_t i, size_t j) {
    auto p = self->ptr->at(i).at(j);
    return new CvPoint{p.x, p.y};
}

size_t std_VecVecPoint_length_i(VecVecPoint* self, size_t i) {
    return self->ptr->at(i).size();
}

void std_VecVecPoint_set(VecVecPoint* self, size_t index, VecPoint val) {
    self->ptr->at(index) = CVDEREF(val);
}

VecPoint* std_VecVecPoint_data(VecVecPoint* self) {
    auto p = new VecPoint[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = VecPoint{new std::vector<cv::Point>(self->ptr->at(i))};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVecPoint2f);
VecVecPoint2f* std_VecVecPoint2f_new(size_t length) {
    return new VecVecPoint2f{new std::vector<std::vector<cv::Point2f>>(length)};
}

VecVecPoint2f* std_VecVecPoint2f_new_1(size_t length, VecPoint2f val) {
    return new VecVecPoint2f{new std::vector<std::vector<cv::Point2f>>(length, CVDEREF(val))};
}

VecVecPoint2f* std_VecVecPoint2f_new_2(size_t length, VecPoint2f* val_ptr) {
    auto p = new std::vector<std::vector<cv::Point2f>>(length);
    for (size_t i = 0; i < length; i++) {
        p->at(i) = CVDEREF(val_ptr[i]);
    }
    return new VecVecPoint2f{p};
}

void std_VecVecPoint2f_push_back(VecVecPoint2f* self, VecPoint2f val) {
    self->ptr->push_back(CVDEREF(val));
}
VecPoint2f std_VecVecPoint2f_get(VecVecPoint2f* self, size_t index) {
    return VecPoint2f{new std::vector<cv::Point2f>(self->ptr->at(index))};
}
VecPoint2f* std_VecVecPoint2f_get_p(VecVecPoint2f* self, int index) {
    return new VecPoint2f{new std::vector<cv::Point2f>(self->ptr->at(index))};
}

CvPoint2f* std_VecVecPoint2f_get_ij(VecVecPoint2f* self, size_t i, size_t j) {
    auto p = self->ptr->at(i).at(j);
    return new CvPoint2f{p.x, p.y};
}

size_t std_VecVecPoint2f_length_i(VecVecPoint2f* self, size_t i) {
    return self->ptr->at(i).size();
}

void std_VecVecPoint2f_set(VecVecPoint2f* self, size_t index, VecPoint2f val) {
    self->ptr->at(index) = CVDEREF(val);
}

VecPoint2f* std_VecVecPoint2f_data(VecVecPoint2f* self) {
    auto p = new VecPoint2f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = VecPoint2f{new std::vector<cv::Point2f>(self->ptr->at(i))};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVecPoint3f);
VecVecPoint3f* std_VecVecPoint3f_new(size_t length) {
    return new VecVecPoint3f{new std::vector<std::vector<cv::Point3f>>(length)};
}

VecVecPoint3f* std_VecVecPoint3f_new_1(size_t length, VecPoint3f val) {
    return new VecVecPoint3f{new std::vector<std::vector<cv::Point3f>>(length, CVDEREF(val))};
}

VecVecPoint3f* std_VecVecPoint3f_new_2(size_t length, VecPoint3f* val_ptr) {
    auto p = new std::vector<std::vector<cv::Point3f>>(length);
    for (size_t i = 0; i < length; i++) {
        p->at(i) = CVDEREF(val_ptr[i]);
    }
    return new VecVecPoint3f{p};
}

void std_VecVecPoint3f_push_back(VecVecPoint3f* self, VecPoint3f val) {
    self->ptr->push_back(CVDEREF(val));
}
VecPoint3f std_VecVecPoint3f_get(VecVecPoint3f* self, size_t index) {
    auto val = self->ptr->at(index);
    return VecPoint3f{new std::vector<cv::Point3f>(val)};
}
VecPoint3f* std_VecVecPoint3f_get_p(VecVecPoint3f* self, int index) {
    return new VecPoint3f{&(self->ptr->at(index))};
}

CvPoint3f* std_VecVecPoint3f_get_ij(VecVecPoint3f* self, size_t i, size_t j) {
    auto p = self->ptr->at(i).at(j);
    return new CvPoint3f{p.x, p.y, p.z};
}

size_t std_VecVecPoint3f_length_i(VecVecPoint3f* self, size_t i) {
    return self->ptr->at(i).size();
}

void std_VecVecPoint3f_set(VecVecPoint3f* self, size_t index, VecPoint3f val) {
    self->ptr->at(index) = CVDEREF(val);
}

VecPoint3f* std_VecVecPoint3f_data(VecVecPoint3f* self) {
    auto p = new VecPoint3f[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = VecPoint3f{new std::vector<cv::Point3f>(self->ptr->at(i))};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVecPoint3i);
VecVecPoint3i* std_VecVecPoint3i_new(size_t length) {
    return new VecVecPoint3i{new std::vector<std::vector<cv::Point3i>>(length)};
}

VecVecPoint3i* std_VecVecPoint3i_new_1(size_t length, VecPoint3i val) {
    return new VecVecPoint3i{new std::vector<std::vector<cv::Point3i>>(length, CVDEREF(val))};
}

VecVecPoint3i* std_VecVecPoint3i_new_2(size_t length, VecPoint3i* val_ptr) {
    auto p = new std::vector<std::vector<cv::Point3i>>(length);
    for (size_t i = 0; i < length; i++) {
        p->at(i) = CVDEREF(val_ptr[i]);
    }
    return new VecVecPoint3i{p};
}

void std_VecVecPoint3i_push_back(VecVecPoint3i* self, VecPoint3i val) {
    self->ptr->push_back(CVDEREF(val));
}
VecPoint3i std_VecVecPoint3i_get(VecVecPoint3i* self, size_t index) {
    auto v = self->ptr->at(index);
    return VecPoint3i{new std::vector<cv::Point3i>(v)};
}
VecPoint3i* std_VecVecPoint3i_get_p(VecVecPoint3i* self, int index) {
    return new VecPoint3i{&(self->ptr->at(index))};
}

CvPoint3i* std_VecVecPoint3i_get_ij(VecVecPoint3i* self, size_t i, size_t j) {
    auto p = self->ptr->at(i).at(j);
    return new CvPoint3i{p.x, p.y, p.z};
}

size_t std_VecVecPoint3i_length_i(VecVecPoint3i* self, size_t i) {
    return self->ptr->at(i).size();
}

void std_VecVecPoint3i_set(VecVecPoint3i* self, size_t index, VecPoint3i val) {
    self->ptr->at(index) = CVDEREF(val);
}

VecPoint3i* std_VecVecPoint3i_data(VecVecPoint3i* self) {
    auto p = new VecPoint3i[self->ptr->size()];
    for (size_t i = 0; i < self->ptr->size(); i++) {
        p[i] = VecPoint3i{new std::vector<cv::Point3i>(self->ptr->at(i))};
    }
    return p;
}

CVD_STD_VEC_FUNC_IMPL_COMMON(VecVecChar)
VecVecChar* std_VecVecChar_new(size_t length) {
    return new VecVecChar{new std::vector<std::vector<char>>(length)};
}

VecVecChar* std_VecVecChar_new_1(size_t length, VecChar* val) {
    const auto v = static_cast<std::vector<char>*>(val->ptr);
    return new VecVecChar{new std::vector<std::vector<char>>(length, *v)};
}

VecVecChar* std_VecVecChar_new_2(VecVecChar* val_ptr) {
    const auto v = static_cast<std::vector<std::vector<char>>*>(val_ptr->ptr);
    return new VecVecChar{new std::vector<std::vector<char>>(*v)};
}

VecVecChar* std_VecVecChar_new_3(char** val, VecI32 sizes) {
    if (!sizes.ptr || sizes.ptr->empty()) {
        return new VecVecChar{new std::vector<std::vector<char>>()};
    }
    auto rv = new std::vector<std::vector<char>>(sizes.ptr->size());
    for (size_t i = 0; i < sizes.ptr->size(); i++) {
        auto t = std::vector<char>(val[i], val[i] + sizes.ptr->at(i));
        rv->push_back(t);
    }
    return new VecVecChar{rv};
}

void std_VecVecChar_push_back(VecVecChar* self, VecChar val) {
    const auto v = static_cast<std::vector<char>*>(val.ptr);
    self->ptr->push_back(*v);
}

VecChar* std_VecVecChar_get(VecVecChar* self, int index) {
    return new VecChar{new std::vector<char>(self->ptr->at(index))};
}

void std_VecVecChar_set(VecVecChar* self, int index, VecChar* val) {
    self->ptr->at(index) = *(val->ptr);
}

VecChar* std_VecVecChar_data(VecVecChar* self) {
    return new VecChar{self->ptr->data()};
}

VecVecChar* std_VecVecChar_clone(VecVecChar* self) {
    return new VecVecChar{new std::vector<std::vector<char>>(*self->ptr)};
}
