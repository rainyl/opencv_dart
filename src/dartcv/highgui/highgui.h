/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_HIGHGUI_H_
#define CVD_HIGHGUI_H_

#ifdef __cplusplus
#include <opencv2/highgui.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"

typedef void (*cv_ButtonCallback)(int state, void* userdata);
typedef void (*cv_MouseCallback)(int event, int x, int y, int flags, void* userdata);
typedef void (*cv_OpenGlDrawCallback)(void* userdata);
typedef void (*cv_TrackbarCallback)(int pos, void* userdata);

char* cv_currentUIFramework(void);
int cv_getMouseWheelDelta(int flags);
int cv_pollKey(void);
int cv_waitKey(int delay);
int cv_waitKeyEx(int delay);

// Window
CvStatus* cv_namedWindow(const char* winname, int flags);
CvStatus* cv_destroyWindow(const char* winname);
CvStatus* cv_destroyAllWindows(void);
CvStatus* cv_imshow(const char* winname, Mat mat);
CvStatus* cv_getWindowImageRect(const char* winname, CvRect* rval);
CvStatus* cv_getWindowProperty(const char* winname, int flag, double* rval);
CvStatus* cv_setMouseCallback(const char* winname, cv_MouseCallback onMouse, void* userdata);
CvStatus* cv_setWindowProperty(const char* winname, int flag, double value);
CvStatus* cv_setWindowTitle(const char* winname, const char* title);
CvStatus* cv_moveWindow(const char* winname, int x, int y);
CvStatus* cv_resizeWindow(const char* winname, int width, int height);
CvStatus* cv_selectROI(
    const char* winname,
    Mat img,
    bool showCrosshair,
    bool fromCenter,
    bool printNotice,
    CvRect* rval
);
CvStatus* cv_selectROI_1(
    Mat img, bool showCrosshair, bool fromCenter, bool printNotice, CvRect* rval
);
CvStatus* cv_selectROIs(
    const char* winname,
    Mat img,
    VecRect* rval,
    bool showCrosshair,
    bool fromCenter,
    bool printNotice
);

// Trackbar
CvStatus* cv_createTrackbar(const char* trackname, const char* winname, int max);
CvStatus* cv_createTrackbar_1(
    const char* trackname,
    const char* winname,
    int* value,
    int max,
    cv_TrackbarCallback onChange,
    void* userdata
);
CvStatus* cv_getTrackbarPos(const char* trackname, const char* winname, int* rval);
CvStatus* cv_setTrackbarPos(const char* trackname, const char* winname, int pos);
CvStatus* cv_setTrackbarMin(const char* trackname, const char* winname, int val);
CvStatus* cv_setTrackbarMax(const char* trackname, const char* winname, int val);

#ifdef __cplusplus
}
#endif

#endif  //CVD_HIGHGUI_H_
