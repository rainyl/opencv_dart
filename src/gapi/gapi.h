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
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::GMat, GMat)
CVD_TYPEDEF(cv::GScalar, GScalar)
#else
CVD_TYPEDEF(void, GMat)
CVD_TYPEDEF(void, GScalar)
#endif

CvStatus GMat_New_Empty(GMat *rval);
// CvStatus GMat_New_FromMat(Mat mat, GMat *rval);
void GMat_Close(GMatPtr mat);

CvStatus GScalar_New_Empty(GScalar *rval);
CvStatus GScalar_New_FromScalar(Scalar scalar, GScalar *rval);
CvStatus GScalar_New_FromDouble(double v0, GScalar *rval);
void     GScalar_Close(GScalar *scalar);

#ifdef __cplusplus
}
#endif

#endif // OPENCV_DART_GAPI_H
