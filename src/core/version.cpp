/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "version.h"

CvStatus openCVVersion(const char **rval)
{
  BEGIN_WRAP
  *rval = CV_VERSION;
  END_WRAP
}

CvStatus getBuildInfo(const char **rval)
{
  BEGIN_WRAP
  *rval = cv::getBuildInformation().c_str();
  END_WRAP
}
