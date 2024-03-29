/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "imgcodecs.h"
#include <vector>

CvStatus Image_IMRead(const char *filename, int flags, Mat *rval)
{
  BEGIN_WRAP
  *rval = new cv::Mat(cv::imread(filename, flags));
  END_WRAP
}
CvStatus Image_IMWrite(const char *filename, Mat img, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::imwrite(filename, *img);
  END_WRAP
}
CvStatus Image_IMWrite_WithParams(const char *filename, Mat img, VecInt params, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::imwrite(filename, *img, *params);
  END_WRAP
}
CvStatus Image_IMEncode(const char *fileExt, Mat img, VecUChar *rval)
{
  BEGIN_WRAP
  auto buf = new std::vector<uchar>();
  cv::imencode(fileExt, *img, *buf);
  *rval = buf;
  END_WRAP
}
CvStatus Image_IMEncode_WithParams(const char *fileExt, Mat img, VecInt params, VecUChar *rval)
{
  BEGIN_WRAP
  auto buf = new std::vector<uchar>();
  cv::imencode(fileExt, *img, *buf, *params);
  *rval = buf;
  END_WRAP
}
CvStatus Image_IMDecode(VecUChar buf, int flags, Mat rval)
{
  BEGIN_WRAP
  cv::imdecode(*buf, flags, rval);
  END_WRAP
}
