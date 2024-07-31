/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_IMGCODECS_ASYNC_H_
#define CVD_IMGCODECS_ASYNC_H_

#include "core/types.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

CvStatus *Image_IMRead_Async(const char *filename, int flags, CvCallback_1 callback);
CvStatus *Image_IMWrite_Async(const char *filename, Mat img, CvCallback_1 callback);
CvStatus *
Image_IMWrite_WithParams_Async(const char *filename, Mat img, VecI32 params, CvCallback_1 callback);
CvStatus *Image_IMEncode_Async(const char *fileExt, Mat img, CvCallback_2 callback);
CvStatus *
Image_IMEncode_WithParams_Async(const char *fileExt, Mat img, VecI32 params, CvCallback_2 callback);
CvStatus *Image_IMDecode_Async(VecUChar buf, int flags, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_IMGCODECS_ASYNC_H_
