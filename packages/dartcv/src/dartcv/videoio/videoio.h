/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_VIDEOIO_H_
#define _OPENCV3_VIDEOIO_H_

#ifdef __cplusplus
#include <opencv2/videoio.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"

#ifdef __cplusplus
CVD_TYPEDEF(cv::VideoCapture, VideoCapture);
CVD_TYPEDEF(cv::VideoWriter, VideoWriter);
#else
CVD_TYPEDEF(void, VideoCapture);
CVD_TYPEDEF(void, VideoWriter);
#endif

// VideoCapture
CvStatus* cv_VideoCapture_create(VideoCapture* rval);
CvStatus* cv_VideoCapture_create_1(
    const char* filename, int apiPreference, VideoCapture* rval, CvCallback_0 callback
);
CvStatus* cv_VideoCapture_create_2(
    int index, int apiPreference, VideoCapture* rval, CvCallback_0 callback
);
void cv_VideoCapture_close(VideoCapturePtr self);
CvStatus* cv_VideoCapture_open(
    VideoCapture self, const char* uri, bool* rval, CvCallback_0 callback
);
CvStatus* cv_VideoCapture_open_1(
    VideoCapture self, const char* uri, int apiPreference, bool* rval, CvCallback_0 callback
);
CvStatus* cv_VideoCapture_open_2(VideoCapture self, int device, bool* rval, CvCallback_0 callback);
CvStatus* cv_VideoCapture_open_3(
    VideoCapture self, int device, int apiPreference, bool* rval, CvCallback_0 callback
);
void cv_VideoCapture_set(VideoCapture self, int prop, double val);
double cv_VideoCapture_get(VideoCapture self, int prop);
bool cv_VideoCapture_isOpened(VideoCapture self);
CvStatus* cv_VideoCapture_read(VideoCapture self, Mat buf, bool* rval, CvCallback_0 callback);
CvStatus* cv_VideoCapture_release(VideoCapture self);
CvStatus* cv_VideoCapture_grab(VideoCapture self, CvCallback_0 callback);
// Decodes and returns the grabbed video frame.
CvStatus* cv_VideoCapture_retrieve(VideoCapture self, Mat image, int flag, bool *rval, CvCallback_0 callback);
const char* cv_VideoCapture_getBackendName(VideoCapture self);

// VideoWriter
CvStatus* cv_VideoWriter_create(VideoWriter* rval);
void cv_VideoWriter_close(VideoWriterPtr self);
CvStatus* cv_VideoWriter_create_1(
    const char* name,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    VideoWriter* rval,
    CvCallback_0 callback
);
CvStatus* cv_VideoWriter_create_2(
    const char* name,
    int apiPreference,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    VideoWriter* rval,
    CvCallback_0 callback
);

CvStatus* cv_VideoWriter_open(
    VideoWriter self,
    const char* name,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    bool* rval,
    CvCallback_0 callback
);

CvStatus* cv_VideoWriter_open_1(
    VideoWriter self,
    const char* name,
    int apiPreference,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    bool* rval,
    CvCallback_0 callback
);

bool cv_VideoWriter_isOpened(VideoWriter self);
CvStatus* cv_VideoWriter_write(VideoWriter self, Mat img, CvCallback_0 callback);
CvStatus* cv_VideoWriter_release(VideoWriter self);
int cv_VideoWriter_fourcc(char c1, char c2, char c3, char c4);
char* cv_VideoWriter_getBackendName(VideoWriter self);
double cv_VideoWriter_get(VideoWriter self, int propId);
void cv_VideoWriter_set(VideoWriter self, int propId, double val);

#ifdef __cplusplus
}
#endif

#endif  //_OPENCV3_VIDEOIO_H_
