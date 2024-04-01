/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_OBJDETECT_H_
#define _OPENCV3_OBJDETECT_H_

#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"

#ifdef __cplusplus
CVD_TYPEDEF(cv::CascadeClassifier, CascadeClassifier)
CVD_TYPEDEF(cv::HOGDescriptor, HOGDescriptor)
CVD_TYPEDEF(cv::QRCodeDetector, QRCodeDetector)
#else
CVD_TYPEDEF(void, CascadeClassifier)
CVD_TYPEDEF(void, HOGDescriptor)
CVD_TYPEDEF(void, QRCodeDetector)
#endif

CVD_TYPEDEF_PTR(CascadeClassifier)
CVD_TYPEDEF_PTR(HOGDescriptor)
CVD_TYPEDEF_PTR(QRCodeDetector)

// CascadeClassifier
CvStatus CascadeClassifier_New(CascadeClassifier *rval);
void     CascadeClassifier_Close(CascadeClassifier *cs);
CvStatus CascadeClassifier_Load(CascadeClassifier cs, const char *name, int *rval);
CvStatus CascadeClassifier_DetectMultiScale(CascadeClassifier cs, Mat img, VecRect *rval);
CvStatus CascadeClassifier_DetectMultiScaleWithParams(CascadeClassifier cs, Mat img, double scale,
                                                      int minNeighbors, int flags, Size minSize, Size maxSize,
                                                      VecRect *rval);

CvStatus HOGDescriptor_New(HOGDescriptor *rval);
void     HOGDescriptor_Close(HOGDescriptor *hog);
CvStatus HOGDescriptor_Load(HOGDescriptor hog, const char *name, int *rval);
CvStatus HOGDescriptor_DetectMultiScale(HOGDescriptor hog, Mat img, VecRect *rval);
CvStatus HOGDescriptor_DetectMultiScaleWithParams(HOGDescriptor hog, Mat img, double hitThresh,
                                                  Size winStride, Size padding, double scale,
                                                  double finalThreshold, bool useMeanshiftGrouping,
                                                  VecRect *rval);
CvStatus HOG_GetDefaultPeopleDetector(VecFloat *rval);
CvStatus HOGDescriptor_SetSVMDetector(HOGDescriptor hog, VecFloat det);

CvStatus GroupRectangles(VecRect rects, int groupThreshold, double eps);

CvStatus QRCodeDetector_New(QRCodeDetector *rval);
CvStatus QRCodeDetector_DetectAndDecode(QRCodeDetector qr, Mat input, VecPoint *points, Mat *straight_qrcode,
                                        VecChar *rval);
CvStatus QRCodeDetector_Detect(QRCodeDetector qr, Mat input, VecPoint points, bool *rval);
CvStatus QRCodeDetector_Decode(QRCodeDetector qr, Mat input, VecPoint inputPoints, Mat straight_qrcode,
                               VecChar *rval);
void     QRCodeDetector_Close(QRCodeDetector *qr);
CvStatus QRCodeDetector_DetectMulti(QRCodeDetector qr, Mat input, VecPoint points, bool *rval);
CvStatus QRCodeDetector_DetectAndDecodeMulti(QRCodeDetector qr, Mat input, VecVecChar *decoded,
                                             VecPoint *points, VecMat *straight_code, bool *rval);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_OBJDETECT_H_
