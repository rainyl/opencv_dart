/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "svd.h"

CvStatus *SVD_Compute(Mat src, Mat *w, Mat *u, Mat *vt, int flags) {
  BEGIN_WRAP
  cv::Mat _w, _u, _vt;
  cv::SVD::compute(*src.ptr, _w, _u, _vt, flags);
  *w = {new cv::Mat(_w)};
  *u = {new cv::Mat(_u)};
  *vt = {new cv::Mat(_vt)};
  END_WRAP
}

CvStatus *SVD_backSubst(Mat w, Mat u, Mat vt, Mat rhs, Mat *dst) {
  BEGIN_WRAP
  cv::Mat _dst;
  cv::SVD::backSubst(*w.ptr, *u.ptr, *vt.ptr, *rhs.ptr, _dst);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}
