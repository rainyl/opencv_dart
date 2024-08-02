/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_VIDEOIO_H_
#define _OPENCV3_VIDEOIO_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"

#ifdef __cplusplus
CVD_TYPEDEF(cv::VideoCapture, VideoCapture);
CVD_TYPEDEF(cv::VideoWriter, VideoWriter);
#else
CVD_TYPEDEF(void, VideoCapture);
CVD_TYPEDEF(void, VideoWriter);
#endif

// VideoCapture
CvStatus *VideoCapture_New(VideoCapture *rval);
CvStatus *VideoCapture_NewFromFile(const char *filename, int apiPreference, VideoCapture *rval);
CvStatus *VideoCapture_NewFromIndex(int index, int apiPreference, VideoCapture *rval);
void VideoCapture_Close(VideoCapturePtr self);
CvStatus *VideoCapture_Open(VideoCapture self, const char *uri, bool *rval);
CvStatus *
VideoCapture_OpenWithAPI(VideoCapture self, const char *uri, int apiPreference, bool *rval);
CvStatus *VideoCapture_OpenDevice(VideoCapture self, int device, bool *rval);
CvStatus *
VideoCapture_OpenDeviceWithAPI(VideoCapture self, int device, int apiPreference, bool *rval);
CvStatus *VideoCapture_Set(VideoCapture self, int prop, double param);
CvStatus *VideoCapture_Get(VideoCapture self, int prop, double *rval);
CvStatus *VideoCapture_IsOpened(VideoCapture self, int *rval);
CvStatus *VideoCapture_Read(VideoCapture self, Mat buf, int *rval);
CvStatus *VideoCapture_Release(VideoCapture self);
CvStatus *VideoCapture_Grab(VideoCapture self, int skip);
// TODO: add this to dart
CvStatus *VideoCapture_getBackendName(VideoCapture self, char **rval);

// VideoWriter
CvStatus *VideoWriter_New(VideoWriter *rval);
void VideoWriter_Close(VideoWriterPtr self);
CvStatus *VideoWriter_NewFromFile(
    const char *name, int fourcc, double fps, int width, int height, bool isColor, VideoWriter *rval
);
CvStatus *VideoWriter_NewFromFile_1(
    const char *name,
    int apiPreference,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    VideoWriter *rval
);

CvStatus *VideoWriter_Open(
    VideoWriter self, const char *name, int fourcc, double fps, int width, int height, bool isColor
);

CvStatus *VideoWriter_Open_1(
    VideoWriter self,
    const char *name,
    int apiPreference,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor
);

CvStatus *VideoWriter_IsOpened(VideoWriter self, int *rval);
CvStatus *VideoWriter_Write(VideoWriter self, Mat img);
CvStatus *VideoWriter_Release(VideoWriter self);
CvStatus *VideoWriter_Fourcc(char c1, char c2, char c3, char c4, int *rval);
// TODO: add this to dart
CvStatus *VideoWriter_getBackendName(VideoWriter self, char **rval);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_VIDEOIO_H_
