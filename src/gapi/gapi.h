/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef OPENCV_DART_GAPI_H
#define OPENCV_DART_GAPI_H

#include "core/core.h"

#ifdef __cplusplus
#include <opencv2/gapi.hpp>
#include <opencv2/gapi/core.hpp>
#include <opencv2/gapi/imgproc.hpp>
extern "C"
{
#endif

#ifdef __cplusplus
    typedef cv::GMat *GMat;
#else
typedef void *GMat;
#endif

    CvStatus GMat_New_Empty(GMat *rval);
    CvStatus GMat_New_FromMat(Mat mat, GMat *rval);
    CvStatus GMat_Close(GMat mat);

#ifdef __cplusplus
}
#endif

#endif // OPENCV_DART_GAPI_H