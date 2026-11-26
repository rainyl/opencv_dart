/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include <vector>
#include "dartcv/imgcodecs/imgcodecs.h"
#include "dartcv/core/handle.hpp"

bool cv_haveImageReader(const char* filename) {
    return cv::haveImageReader(filename);
}

bool cv_haveImageWriter(const char* filename) {
    return cv::haveImageWriter(filename);
}

size_t cv_imcount(const char* filename, int flags) {
    return cv::imcount(filename, flags);
}

CvStatus* cv_imdecode(VecUChar buf, int flags, Mat* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(buf), [=]() -> CvStatus* {
        BEGIN_WRAP
        auto m = cv::imdecode(CVDEREF(buf), flags);
        CVD_SET(rval, new cv::Mat(m));
        END_WRAP
    });
}

CvStatus* cv_imencode(
    const char* fileExt, Mat img, bool* success, VecUChar* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(img), [=]() -> CvStatus* {
        BEGIN_WRAP
        *success = cv::imencode(fileExt, CVDEREF(img), CVDEREF_P(rval));
        END_WRAP
    });
}

CvStatus* cv_imencode_1(
    const char* fileExt,
    Mat img,
    VecI32 params,
    bool* success,
    VecUChar* rval,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(img, params), [=]() -> CvStatus* {
        BEGIN_WRAP
        *success = cv::imencode(fileExt, CVDEREF(img), CVDEREF_P(rval), CVDEREF(params));
        END_WRAP
    });
}

CvStatus* cv_imread(const char* filename, int flags, Mat* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(), [=]() -> CvStatus* {
        BEGIN_WRAP
        CVD_SET(rval, new cv::Mat(cv::imread(filename, flags)));
        END_WRAP
    });
}

CvStatus* cv_imwrite(const char* filename, Mat img, bool* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(img), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = cv::imwrite(filename, CVDEREF(img));
        END_WRAP
    });
}

CvStatus* cv_imwrite_1(
    const char* filename, Mat img, VecI32 params, bool* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(img, params), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = cv::imwrite(filename, CVDEREF(img), CVDEREF(params));
        END_WRAP
    });
}
