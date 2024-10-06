/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright _Async(c) 2024 Rainyl.
*/

#ifndef CVD_VIDEOIO_ASYNC_H_
#define CVD_VIDEOIO_ASYNC_H_

#include "core/core.h"
#include "core/types.h"
#include "videoio.h"

#ifdef __cplusplus
extern "C" {
#endif

// VideoCapture
CvStatus *VideoCapture_New_Async(CvCallback_1 callback);
CvStatus *
VideoCapture_NewFromFile_Async(const char *filename, int apiPreference, CvCallback_1 callback);
CvStatus *VideoCapture_NewFromIndex_Async(int index, int apiPreference, CvCallback_1 callback);
// void VideoCapture_Close_Async(VideoCapturePtr self);
CvStatus *VideoCapture_Open_Async(VideoCapture self, const char *uri, CvCallback_1 callback);
CvStatus *VideoCapture_OpenWithAPI_Async(
    VideoCapture self, const char *uri, int apiPreference, CvCallback_1 callback
);
CvStatus *VideoCapture_OpenDevice_Async(VideoCapture self, int device, CvCallback_1 callback);
CvStatus *VideoCapture_OpenDeviceWithAPI_Async(
    VideoCapture self, int device, int apiPreference, CvCallback_1 callback
);
CvStatus *VideoCapture_Set_Async(VideoCapture self, int prop, double param, CvCallback_1 callback);
CvStatus *VideoCapture_Get_Async(VideoCapture self, int prop, CvCallback_1 callback);
CvStatus *VideoCapture_IsOpened_Async(VideoCapture self, CvCallback_1 callback);
CvStatus *VideoCapture_Read_Async(VideoCapture self, CvCallback_2 callback);
CvStatus *VideoCapture_Release_Async(VideoCapture self, CvCallback_0 callback);
CvStatus *VideoCapture_Grab_Async(VideoCapture self, CvCallback_1 callback);

// VideoWriter
CvStatus *VideoWriter_New_Async(CvCallback_1 callback);
// void VideoWriter_Close_Async(VideoWriterPtr self, CvCallback_0 callback);
CvStatus *VideoWriter_Open_Async(
    VideoWriter self,
    const char *name,
    const char *codec,
    double fps,
    int width,
    int height,
    bool isColor,
    CvCallback_1 callback
);
CvStatus *VideoWriter_IsOpened_Async(VideoWriter self, CvCallback_1 callback);
CvStatus *VideoWriter_Write_Async(VideoWriter self, Mat img, CvCallback_0 callback);
CvStatus *VideoWriter_Release_Async(VideoWriter self, CvCallback_0 callback);
CvStatus *VideoWriter_Fourcc_Async(char c1, char c2, char c3, char c4, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_VIDEOIO_ASYNC_H_
