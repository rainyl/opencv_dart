/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/core/version.h"
#include <cstring>

char *getCvVersion(void) { return strdup(CV_VERSION); }

char *getBuildInfo(void) { return strdup(cv::getBuildInformation().c_str()); }
