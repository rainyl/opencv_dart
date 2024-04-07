/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "videoio.h"

// VideoCapture
CvStatus VideoCapture_New(VideoCapture *rval)
{
  BEGIN_WRAP
  *rval = {new cv::VideoCapture()};
  END_WRAP
}
CvStatus VideoCapture_Close(VideoCapture *self)
{
  BEGIN_WRAP
  CVD_FREE(self)
  END_WRAP
}
CvStatus VideoCapture_Open(VideoCapture self, const char *uri, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->open(uri);
  END_WRAP
}
CvStatus VideoCapture_OpenWithAPI(VideoCapture self, const char *uri, int apiPreference, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->open(uri, apiPreference);
  END_WRAP
}
CvStatus VideoCapture_OpenDevice(VideoCapture self, int device, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->open(device);
  END_WRAP
}
CvStatus VideoCapture_OpenDeviceWithAPI(VideoCapture self, int device, int apiPreference, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->open(device, apiPreference);
  END_WRAP
}
CvStatus VideoCapture_Set(VideoCapture self, int prop, double param)
{
  BEGIN_WRAP
  self.ptr->set(prop, param);
  END_WRAP
}
CvStatus VideoCapture_Get(VideoCapture self, int prop, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->get(prop);
  END_WRAP
}
CvStatus VideoCapture_IsOpened(VideoCapture self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->isOpened();
  END_WRAP
}
CvStatus VideoCapture_Read(VideoCapture self, Mat buf, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->read(*buf.ptr);
  END_WRAP
}
CvStatus VideoCapture_Release(VideoCapture self)
{
  BEGIN_WRAP
  self.ptr->release();
  END_WRAP
}
CvStatus VideoCapture_Grab(VideoCapture self, int skip)
{
  BEGIN_WRAP
  self.ptr->grab();
  END_WRAP
}

// VideoWriter
CvStatus VideoWriter_New(VideoWriter *rval)
{
  BEGIN_WRAP
  *rval = {new cv::VideoWriter()};
  END_WRAP
}
CvStatus VideoWriter_Close(VideoWriter *self)
{
  BEGIN_WRAP
  CVD_FREE(self)
  END_WRAP
}
CvStatus VideoWriter_Open(VideoWriter self, const char *name, const char *codec, double fps, int width,
                          int height, bool isColor)
{
  BEGIN_WRAP
  int codecCode = cv::VideoWriter::fourcc(codec[0], codec[1], codec[2], codec[3]);
  self.ptr->open(name, codecCode, fps, cv::Size(width, height), isColor);
  END_WRAP
}
CvStatus VideoWriter_IsOpened(VideoWriter self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->isOpened();
  END_WRAP
}
CvStatus VideoWriter_Write(VideoWriter self, Mat img)
{
  BEGIN_WRAP
  self.ptr->write(*img.ptr);
  END_WRAP
}
CvStatus VideoWriter_Release(VideoWriter self)
{
  BEGIN_WRAP
  self.ptr->release();
  END_WRAP
}
CvStatus VideoWriter_Fourcc(char c1, char c2, char c3, char c4, int *rval)
{
  BEGIN_WRAP
  *rval = cv::VideoWriter::fourcc(c1, c2, c3, c4);
  END_WRAP
}
