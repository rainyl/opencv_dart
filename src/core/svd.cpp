/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "svd.h"

CvStatus SVD_Compute(Mat src, Mat w, Mat u, Mat vt, int flags)
{
  BEGIN_WRAP
  cv::SVD::compute(*src, *w, *u, *vt, flags);
  END_WRAP
}