/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C"
{
#endif

#include "core.h"
#include "dnn.h"

#ifdef __cplusplus
    typedef cv::AsyncArray *AsyncArray;
#else
typedef void *AsyncArray;
#endif

    AsyncArray AsyncArray_New();
    const char *AsyncArray_GetAsync(AsyncArray async_out, Mat out);
    void AsyncArray_Close(AsyncArray a);
    AsyncArray Net_forwardAsync(Net net, const char *outputName);

#ifdef __cplusplus
}
#endif
