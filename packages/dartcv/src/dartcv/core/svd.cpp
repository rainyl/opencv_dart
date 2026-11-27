/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/core/svd.h"
#include "dartcv/core/handle.hpp"

CvStatus* cv_SVD_Compute(Mat src, Mat w_r, Mat u_r, Mat vt_r, int flags, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(src, w_r, u_r, vt_r), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::SVD::compute(CVDEREF(src), CVDEREF(w_r), CVDEREF(u_r), CVDEREF(vt_r), flags);
        END_WRAP
    });
}

CvStatus* cv_SVD_backSubst(Mat w, Mat u, Mat vt, Mat rhs, Mat dst, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(w, u, vt, rhs, dst), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::SVD::backSubst(CVDEREF(w), CVDEREF(u), CVDEREF(vt), CVDEREF(rhs), CVDEREF(dst));
        END_WRAP
    });
}
