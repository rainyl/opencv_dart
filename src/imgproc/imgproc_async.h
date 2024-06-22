/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ASYNC_IMGPROC_H
#define CVD_ASYNC_IMGPROC_H

#include "core/types.h"

#ifdef __cplusplus
extern "C" {
#endif
CvStatus *CvtColor_Async(Mat src, int code, CVD_OUT CvCallback_1 callback);
CvStatus *GaussianBlur_Async(Mat src, Size ps, double sX, double sY, int bt, CVD_OUT CvCallback_1 callback);
#ifdef __cplusplus
}
#endif

#endif // CVD_ASYNC_IMGPROC_H
