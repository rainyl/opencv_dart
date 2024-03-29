/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_IMGCODECS_H_
#define _OPENCV3_IMGCODECS_H_

#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"

CvStatus Image_IMRead(const char *filename, int flags, Mat *rval);
CvStatus Image_IMWrite(const char *filename, Mat img, bool *rval);
CvStatus Image_IMWrite_WithParams(const char *filename, Mat img, VecInt params, bool *rval);
CvStatus Image_IMEncode(const char *fileExt, Mat img, VecUChar *rval);
CvStatus Image_IMEncode_WithParams(const char *fileExt, Mat img, VecInt params, VecUChar *rval);
CvStatus Image_IMDecode(VecUChar buf, int flags, Mat rval);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_IMGCODECS_H_
