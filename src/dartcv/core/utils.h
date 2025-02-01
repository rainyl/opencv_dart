/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_UTILS_H_
#define CVD_UTILS_H_

#ifdef __cplusplus
#include <opencv2/core.hpp>

extern "C" {
#endif

#include "dartcv/core/core.h"

VecU8* cv_yuv420_888_to_nv21(VecU8 y, VecU8 u, VecU8 v, size_t width, size_t height);

#ifdef __cplusplus
}
#endif

#endif  //CVD_UTILS_H_
