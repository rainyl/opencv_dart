/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "dnn.h"

#ifdef __cplusplus
CVD_TYPEDEF(cv::AsyncArray, AsyncArray);
#else
CVD_TYPEDEF(void, AsyncArray);
#endif

CvStatus *AsyncArray_New(AsyncArray *rval);
CvStatus *AsyncArray_Get(AsyncArray async_out, Mat out);
CvStatus *Net_forwardAsync(Net net, const char *outputName, AsyncArray *rval);
void      AsyncArray_Close(AsyncArrayPtr a);

#ifdef __cplusplus
}
#endif
