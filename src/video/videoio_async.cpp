/*
    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "videoio_async.h"

// VideoCapture
CvStatus *VideoCapture_New_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new VideoCapture{new cv::VideoCapture()});
  END_WRAP
}
CvStatus *
VideoCapture_NewFromFile_Async(const char *filename, int apiPreference, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new VideoCapture{new cv::VideoCapture(filename, apiPreference)});
  END_WRAP
}
CvStatus *VideoCapture_NewFromIndex_Async(int index, int apiPreference, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new VideoCapture{new cv::VideoCapture(index, apiPreference)});
  END_WRAP
}
// void VideoCapture_Close(VideoCapturePtr self) { CVD_FREE(self); }

CvStatus *VideoCapture_Open_Async(VideoCapture self, const char *uri, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(self.ptr->open(uri)));
  END_WRAP
}
CvStatus *VideoCapture_OpenWithAPI_Async(
    VideoCapture self, const char *uri, int apiPreference, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new bool(self.ptr->open(uri, apiPreference)));
  END_WRAP
}
CvStatus *VideoCapture_OpenDevice_Async(VideoCapture self, int device, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(self.ptr->open(device)));
  END_WRAP
}
CvStatus *VideoCapture_OpenDeviceWithAPI_Async(
    VideoCapture self, int device, int apiPreference, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new bool(self.ptr->open(device, apiPreference)));
  END_WRAP
}
CvStatus *VideoCapture_Set_Async(VideoCapture self, int prop, double param, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(self.ptr->set(prop, param)));
  END_WRAP
}
CvStatus *VideoCapture_Get_Async(VideoCapture self, int prop, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new double(self.ptr->get(prop)));
  END_WRAP
}
CvStatus *VideoCapture_IsOpened_Async(VideoCapture self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(self.ptr->isOpened()));
  END_WRAP
}
CvStatus *VideoCapture_Read_Async(VideoCapture self, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  bool rval = self.ptr->read(dst);
  callback(new bool(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *VideoCapture_Release_Async(VideoCapture self, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->release();
  callback();
  END_WRAP
}
CvStatus *VideoCapture_Grab_Async(VideoCapture self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(self.ptr->grab()));
  END_WRAP
}

// VideoWriter
CvStatus *VideoWriter_New_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new VideoWriter{new cv::VideoWriter()});
  END_WRAP
}
// void VideoWriter_Close_Async(VideoWriterPtr self) { CVD_FREE(self); }

CvStatus *VideoWriter_Open_Async(
    VideoWriter self,
    const char *name,
    const char *codec,
    double fps,
    int width,
    int height,
    bool isColor,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  int codecCode = cv::VideoWriter::fourcc(codec[0], codec[1], codec[2], codec[3]);
  bool rval = self.ptr->open(name, codecCode, fps, cv::Size(width, height), isColor);
  callback(new bool(rval));
  END_WRAP
}
CvStatus *VideoWriter_IsOpened_Async(VideoWriter self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(self.ptr->isOpened()));
  END_WRAP
}
CvStatus *VideoWriter_Write_Async(VideoWriter self, Mat img, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->write(*img.ptr);
  callback();
  END_WRAP
}
CvStatus *VideoWriter_Release_Async(VideoWriter self, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->release();
  callback();
  END_WRAP
}
CvStatus *VideoWriter_Fourcc_Async(char c1, char c2, char c3, char c4, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = cv::VideoWriter::fourcc(c1, c2, c3, c4);
  callback(new int(rval));
  END_WRAP
}
