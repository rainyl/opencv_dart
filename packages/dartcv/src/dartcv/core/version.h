/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_VERSION_H_
#define CVD_VERSION_H_

#ifdef __cplusplus
#include <opencv2/core.hpp>
extern "C" {
#endif

#include "dartcv/core/core.h"

char* getCvVersion(void);
char* getBuildInfo(void);

#ifdef __cplusplus
}
#endif

#endif  //CVD_VERSION_H_
