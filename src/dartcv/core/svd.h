/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_SVD_H_
#define CVD_SVD_H_

#ifdef __cplusplus
#include <opencv2/core.hpp>

extern "C" {
#endif

#include "dartcv/core/core.h"

CvStatus* cv_SVD_Compute(Mat src, Mat w_r, Mat u_r, Mat vt_r, int flags, CvCallback_0 callback);
CvStatus* cv_SVD_backSubst(Mat w, Mat u, Mat vt, Mat rhs, Mat dst, CvCallback_0 callback);

#ifdef __cplusplus
}
#endif

#endif  //CVD_SVD_H_
