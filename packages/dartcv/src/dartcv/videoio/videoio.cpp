/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/videoio/videoio.h"

#include <iostream>

// VideoCapture
CvStatus* cv_VideoCapture_create(VideoCapture* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::VideoCapture();
    END_WRAP
}
CvStatus* cv_VideoCapture_create_1(
    const char* filename, int apiPreference, VideoCapture* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::VideoCapture(filename, apiPreference);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_VideoCapture_create_2(
    int index, int apiPreference, VideoCapture* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::VideoCapture(index, apiPreference);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
void cv_VideoCapture_close(VideoCapturePtr self) {
    CVD_FREE(self);
}

CvStatus* cv_VideoCapture_open(
    VideoCapture self, const char* uri, bool* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->open(uri);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_VideoCapture_open_1(
    VideoCapture self, const char* uri, int apiPreference, bool* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->open(uri, apiPreference);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_VideoCapture_open_2(VideoCapture self, int device, bool* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = self.ptr->open(device);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_VideoCapture_open_3(
    VideoCapture self, int device, int apiPreference, bool* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->open(device, apiPreference);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
void cv_VideoCapture_set(VideoCapture self, int prop, double val) {
    self.ptr->set(prop, val);
}
double cv_VideoCapture_get(VideoCapture self, int prop) {
    return self.ptr->get(prop);
}
bool cv_VideoCapture_isOpened(VideoCapture self) {
    return self.ptr->isOpened();
}
CvStatus* cv_VideoCapture_read(VideoCapture self, Mat buf, bool* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = self.ptr->read(CVDEREF(buf));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_VideoCapture_release(VideoCapture self) {
    BEGIN_WRAP
    self.ptr->release();
    END_WRAP
}
CvStatus* cv_VideoCapture_grab(VideoCapture self, CvCallback_0 callback) {
    BEGIN_WRAP
    self.ptr->grab();
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_VideoCapture_retrieve(
    VideoCapture self, Mat image, int flag, bool* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->retrieve(CVDEREF(image), flag);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

const char* cv_VideoCapture_getBackendName(VideoCapture self) {
    return strdup(self.ptr->getBackendName().c_str());
}

// VideoWriter
CvStatus* cv_VideoWriter_create(VideoWriter* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::VideoWriter();
    END_WRAP
}
CvStatus* cv_VideoWriter_create_1(
    const char* name,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    VideoWriter* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::VideoWriter(name, fourcc, fps, cv::Size(width, height), isColor);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

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
) {
    BEGIN_WRAP
    rval->ptr =
        new cv::VideoWriter(name, apiPreference, fourcc, fps, cv::Size(width, height), isColor);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_VideoWriter_close(VideoWriterPtr self) {
    CVD_FREE(self);
}

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
) {
    BEGIN_WRAP
    *rval = self.ptr->open(name, fourcc, fps, cv::Size(width, height), isColor);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

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
) {
    BEGIN_WRAP
    *rval = self.ptr->open(name, apiPreference, fourcc, fps, cv::Size(width, height), isColor);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_VideoWriter_isOpened(VideoWriter self) {
    return self.ptr->isOpened();
}
CvStatus* cv_VideoWriter_write(VideoWriter self, Mat img, CvCallback_0 callback) {
    BEGIN_WRAP
    self.ptr->write(CVDEREF(img));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_VideoWriter_release(VideoWriter self) {
    BEGIN_WRAP
    self.ptr->release();
    END_WRAP
}
int cv_VideoWriter_fourcc(char c1, char c2, char c3, char c4) {
    return cv::VideoWriter::fourcc(c1, c2, c3, c4);
}

char* cv_VideoWriter_getBackendName(VideoWriter self) {
    return strdup(self.ptr->getBackendName().c_str());
}

double cv_VideoWriter_get(VideoWriter self, int propId) {
    return self.ptr->get(propId);
}

void cv_VideoWriter_set(VideoWriter self, int propId, double val) {
    self.ptr->set(propId, val);
}
