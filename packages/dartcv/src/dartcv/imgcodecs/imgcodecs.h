/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_IMGCODECS_H_
#define CVD_IMGCODECS_H_

#ifdef __cplusplus
#include <opencv2/imgcodecs.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"
#include <stdbool.h>

bool cv_haveImageReader(const char* filename);
bool cv_haveImageWriter(const char* filename);
size_t cv_imcount(const char* filename, int flags);
CvStatus* cv_imdecode(VecUChar buf, int flags, CVD_OUT Mat* rval, CvCallback_0 callback);
CvStatus* cv_imencode(
    const char* fileExt,
    Mat img,
    CVD_OUT bool* success,
    VecUChar* rval,
    CvCallback_0 callback
);
CvStatus* cv_imencode_1(
    const char* fileExt,
    Mat img,
    VecI32 params,
    CVD_OUT bool* success,
    VecUChar* rval,
    CvCallback_0 callback
);
CvStatus* cv_imread(const char* filename, int flags, CVD_OUT Mat* rval, CvCallback_0 callback);
CvStatus* cv_imwrite(const char* filename, Mat img, CVD_OUT bool* rval, CvCallback_0 callback);
CvStatus* cv_imwrite_1(
    const char* filename, Mat img, VecI32 params, CVD_OUT bool* rval, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  //CVD_IMGCODECS_H_
