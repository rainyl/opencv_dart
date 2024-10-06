/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
#ifndef _OPENCV3_HIGHGUI_H_
#define _OPENCV3_HIGHGUI_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"

// Window
CvStatus *Window_New(const char *winname, int flags);
void      Window_Close(const char *winname);
CvStatus *Window_IMShow(const char *winname, Mat mat);
CvStatus *Window_GetProperty(const char *winname, int flag, double *rval);
CvStatus *Window_SetProperty(const char *winname, int flag, double value);
CvStatus *Window_SetTitle(const char *winname, const char *title);
CvStatus *Window_WaitKey(int delay, int *rval);
CvStatus *Window_Move(const char *winname, int x, int y);
CvStatus *Window_Resize(const char *winname, int width, int height);
CvStatus *Window_SelectROI(const char *winname, Mat img, Rect *rval);
CvStatus *Window_SelectROIs(const char *winname, Mat img, VecRect *rval);
CvStatus *destroyAllWindows();

// Trackbar
CvStatus *Trackbar_Create(const char *winname, const char *trackname, int max);
CvStatus *Trackbar_CreateWithValue(const char *winname, const char *trackname, int *value, int max);
CvStatus *Trackbar_GetPos(const char *winname, const char *trackname, int *rval);
CvStatus *Trackbar_SetPos(const char *winname, const char *trackname, int pos);
CvStatus *Trackbar_SetMin(const char *winname, const char *trackname, int pos);
CvStatus *Trackbar_SetMax(const char *winname, const char *trackname, int pos);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_HIGHGUI_H_
