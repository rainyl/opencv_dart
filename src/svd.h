/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_SVD_H_
#define _OPENCV3_SVD_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>

extern "C"
{
#endif

#include "core.h"

    void SVD_Compute(Mat src, Mat w, Mat u, Mat vt, int flags);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_SVD_H