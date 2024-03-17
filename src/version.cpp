/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "version.h"

const char *openCVVersion()
{
    return CV_VERSION;
}

const char *getBuildInfo()
{
    return cv::getBuildInformation().c_str();
}
