/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#include "highgui.h"
#include "core/vec.hpp"

// Window
CvStatus *Window_New(const char *winname, int flags) {
  BEGIN_WRAP
  cv::namedWindow(winname, flags);
  END_WRAP
}

void Window_Close(const char *winname) { cv::destroyWindow(winname); }

CvStatus *Window_IMShow(const char *winname, Mat mat) {
  BEGIN_WRAP
  cv::imshow(winname, *mat.ptr);
  END_WRAP
}

CvStatus *Window_GetProperty(const char *winname, int flag, double *rval) {
  BEGIN_WRAP
  *rval = cv::getWindowProperty(winname, flag);
  END_WRAP
}

CvStatus *Window_SetProperty(const char *winname, int flag, double value) {
  BEGIN_WRAP
  cv::setWindowProperty(winname, flag, value);
  END_WRAP
}

CvStatus *Window_SetTitle(const char *winname, const char *title) {
  BEGIN_WRAP
  cv::setWindowTitle(winname, title);
  END_WRAP
}

CvStatus *Window_WaitKey(int delay, int *rval) {
  BEGIN_WRAP
  *rval = cv::waitKey(delay);
  END_WRAP
}

CvStatus *Window_Move(const char *winname, int x, int y) {
  BEGIN_WRAP
  cv::moveWindow(winname, x, y);
  END_WRAP
}

CvStatus *Window_Resize(const char *winname, int width, int height) {
  BEGIN_WRAP
  cv::resizeWindow(winname, width, height);
  END_WRAP
}

CvStatus *Window_SelectROI(const char *winname, Mat img, Rect *rval) {
  BEGIN_WRAP
  auto rect = cv::selectROI(winname, *img.ptr);
  *rval = {rect.x, rect.y, rect.width, rect.height};
  END_WRAP
}

CvStatus *Window_SelectROIs(const char *winname, Mat img, VecRect *rval) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  cv::selectROIs(winname, *img.ptr, rects);
  *rval = vecrect_cpp2c(rects);
  END_WRAP
}

CvStatus *destroyAllWindows() {
  BEGIN_WRAP
  cv::destroyAllWindows();
  END_WRAP
}

// Trackbar
CvStatus *Trackbar_Create(const char *winname, const char *trackname, int max) {
  BEGIN_WRAP
  cv::createTrackbar(trackname, winname, nullptr, max);
  END_WRAP
}

CvStatus *
Trackbar_CreateWithValue(const char *winname, const char *trackname, int *value, int max) {
  BEGIN_WRAP
  cv::createTrackbar(trackname, winname, value, max);
  END_WRAP
}

CvStatus *Trackbar_GetPos(const char *winname, const char *trackname, int *rval) {
  BEGIN_WRAP
  *rval = cv::getTrackbarPos(trackname, winname);
  END_WRAP
}

CvStatus *Trackbar_SetPos(const char *winname, const char *trackname, int pos) {
  BEGIN_WRAP
  cv::setTrackbarPos(trackname, winname, pos);
  END_WRAP
}

CvStatus *Trackbar_SetMin(const char *winname, const char *trackname, int pos) {
  BEGIN_WRAP
  cv::setTrackbarMin(trackname, winname, pos);
  END_WRAP
}

CvStatus *Trackbar_SetMax(const char *winname, const char *trackname, int pos) {
  BEGIN_WRAP
  cv::setTrackbarMax(trackname, winname, pos);
  END_WRAP
}
