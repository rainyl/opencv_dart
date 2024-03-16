/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_VERSION_H_
#define _OPENCV3_VERSION_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C"
{
#endif

#include "core.h"

    const char *openCVVersion();
    const char *getBuildInfo();

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_VERSION_H_
