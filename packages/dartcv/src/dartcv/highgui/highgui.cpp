/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#include "dartcv/highgui/highgui.h"
#include "dartcv/core/vec.hpp"

char* cv_currentUIFramework(void) {
    return strdup(cv::currentUIFramework().c_str());
}
int cv_getMouseWheelDelta(int flags) {
    return cv::getMouseWheelDelta(flags);
}
int cv_pollKey(void) {
    return cv::pollKey();
}
int cv_waitKey(int delay) {
    return cv::waitKey(delay);
}
int cv_waitKeyEx(int delay) {
    return cv::waitKeyEx(delay);
}

// Window
CvStatus* cv_namedWindow(const char* winname, int flags) {
    BEGIN_WRAP
    cv::namedWindow(winname, flags);
    END_WRAP
}

CvStatus* cv_destroyWindow(const char* winname) {
    BEGIN_WRAP
    cv::destroyWindow(winname);
    END_WRAP
}

CvStatus* cv_imshow(const char* winname, Mat mat) {
    BEGIN_WRAP
    cv::imshow(winname, CVDEREF(mat));
    END_WRAP
}

CvStatus* cv_getWindowImageRect(const char* winname, CvRect* rval) {
    BEGIN_WRAP
    auto rect = cv::getWindowImageRect(winname);
    *rval = {rect.x, rect.y, rect.width, rect.height};
    END_WRAP
}

CvStatus* cv_getWindowProperty(const char* winname, int flag, double* rval) {
    BEGIN_WRAP
    *rval = cv::getWindowProperty(winname, flag);
    END_WRAP
}

CvStatus* cv_setMouseCallback(const char* winname, cv_MouseCallback onMouse, void* userdata) {
    BEGIN_WRAP
    cv::setMouseCallback(winname, onMouse, userdata);
    END_WRAP
}

CvStatus* cv_setWindowProperty(const char* winname, int flag, double value) {
    BEGIN_WRAP
    cv::setWindowProperty(winname, flag, value);
    END_WRAP
}

CvStatus* cv_setWindowTitle(const char* winname, const char* title) {
    BEGIN_WRAP
    cv::setWindowTitle(winname, title);
    END_WRAP
}

CvStatus* cv_moveWindow(const char* winname, int x, int y) {
    BEGIN_WRAP
    cv::moveWindow(winname, x, y);
    END_WRAP
}

CvStatus* cv_resizeWindow(const char* winname, int width, int height) {
    BEGIN_WRAP
    cv::resizeWindow(winname, width, height);
    END_WRAP
}

CvStatus* cv_selectROI(
    const char* winname,
    Mat img,
    bool showCrosshair,
    bool fromCenter,
    bool printNotice,
    CvRect* rval
) {
    BEGIN_WRAP
    auto rect = cv::selectROI(winname, CVDEREF(img), showCrosshair, fromCenter, printNotice);
    *rval = {rect.x, rect.y, rect.width, rect.height};
    END_WRAP
}

CvStatus* cv_selectROI_1(
    Mat img, bool showCrosshair, bool fromCenter, bool printNotice, CvRect* rval
) {
    BEGIN_WRAP
    auto rect = cv::selectROI(CVDEREF(img), showCrosshair, fromCenter, printNotice);
    *rval = {rect.x, rect.y, rect.width, rect.height};
    END_WRAP
}

CvStatus* cv_selectROIs(
    const char* winname,
    Mat img,
    VecRect* rval,
    bool showCrosshair,
    bool fromCenter,
    bool printNotice
) {
    BEGIN_WRAP
    cv::selectROIs(winname, CVDEREF(img), CVDEREF_P(rval), showCrosshair, fromCenter, printNotice);
    END_WRAP
}

CvStatus* cv_destroyAllWindows(void) {
    BEGIN_WRAP
    cv::destroyAllWindows();
    END_WRAP
}

// Trackbar
CvStatus* cv_createTrackbar(const char* trackname, const char* winname, int max) {
    BEGIN_WRAP
    cv::createTrackbar(trackname, winname, nullptr, max);
    END_WRAP
}

CvStatus* cv_createTrackbar_1(
    const char* trackname,
    const char* winname,
    int* value,
    int max,
    cv_TrackbarCallback onChange,
    void* userdata
) {
    BEGIN_WRAP
    cv::createTrackbar(trackname, winname, value, max, onChange, userdata);
    END_WRAP
}

CvStatus* cv_getTrackbarPos(const char* trackname, const char* winname, int* rval) {
    BEGIN_WRAP
    *rval = cv::getTrackbarPos(trackname, winname);
    END_WRAP
}

CvStatus* cv_setTrackbarPos(const char* trackname, const char* winname, int pos) {
    BEGIN_WRAP
    cv::setTrackbarPos(trackname, winname, pos);
    END_WRAP
}

CvStatus* cv_setTrackbarMin(const char* trackname, const char* winname, int val) {
    BEGIN_WRAP
    cv::setTrackbarMin(trackname, winname, val);
    END_WRAP
}

CvStatus* cv_setTrackbarMax(const char* trackname, const char* winname, int val) {
    BEGIN_WRAP
    cv::setTrackbarMax(trackname, winname, val);
    END_WRAP
}
