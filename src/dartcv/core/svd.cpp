/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/core/svd.h"

CvStatus* cv_SVD_Compute(Mat src, Mat w_r, Mat u_r, Mat vt_r, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::SVD::compute(*src.ptr, CVDEREF(w_r), CVDEREF(u_r), CVDEREF(vt_r), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SVD_backSubst(Mat w, Mat u, Mat vt, Mat rhs, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::SVD::backSubst(*w.ptr, *u.ptr, *vt.ptr, *rhs.ptr, CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
