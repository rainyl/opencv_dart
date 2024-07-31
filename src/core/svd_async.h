/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
#ifndef CVD_SVD_ASYNC_H_
#define CVD_SVD_ASYNC_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>

extern "C" {
#endif

#include "types.h"

CvStatus *SVD_Compute_Async(Mat src, int flags, CvCallback_3 callback);
CvStatus *SVD_backSubst_Async(Mat w, Mat u, Mat vt, Mat rhs, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_SVD_ASYNC_H_
