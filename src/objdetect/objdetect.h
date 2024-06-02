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
CvStatus CascadeClassifier_NewFromFile(char *filename, CascadeClassifier *rval);
void     CascadeClassifier_Close(CascadeClassifier *self);
CvStatus CascadeClassifier_Load(CascadeClassifier self, const char *name, int *rval);
CvStatus CascadeClassifier_DetectMultiScale(CascadeClassifier self, Mat img, VecRect *rval);
CvStatus CascadeClassifier_DetectMultiScaleWithParams(CascadeClassifier self, Mat img, VecRect *objects,
                                                      double scale, int minNeighbors, int flags, Size minSize,
                                                      Size maxSize);
CvStatus CascadeClassifier_DetectMultiScale2(CascadeClassifier self, Mat img, VecRect *objects,
                                             VecInt *numDetections, double scaleFactor, int minNeighbors,
                                             int flags, Size minSize, Size maxSize);
CvStatus CascadeClassifier_DetectMultiScale3(CascadeClassifier self, Mat img, VecRect *objects,
                                             VecInt *rejectLevels, VecDouble *levelWeights,
                                             double scaleFactor, int minNeighbors, int flags, Size minSize,
                                             Size maxSize, bool outputRejectLevels);
CvStatus CascadeClassifier_Empty(CascadeClassifier self, bool *rval);
CvStatus CascadeClassifier_getFeatureType(CascadeClassifier self, int *rval);
CvStatus CascadeClassifier_getOriginalWindowSize(CascadeClassifier self, Size *rval);
CvStatus CascadeClassifier_isOldFormatCascade(CascadeClassifier self, bool *rval);

// HOGDescriptor
// struct for detection region of interest (ROI)
// typedef struct DetectionROI {
//   VecDouble confidences;
//   VecPoint  locations;
//   double    scale;
// } DetectionROI;

CvStatus HOGDescriptor_New(HOGDescriptor *rval);
CvStatus HOGDescriptor_NewFromFile(char *filename, HOGDescriptor *rval);
void     HOGDescriptor_Close(HOGDescriptor *self);
CvStatus HOGDescriptor_Load(HOGDescriptor self, char *name, bool *rval);
CvStatus HOGDescriptor_Detect(HOGDescriptor self, Mat img, VecPoint *foundLocations, VecDouble *weights,
                              double hitThresh, Size winStride, Size padding, VecPoint *searchLocations);
CvStatus HOGDescriptor_Detect2(HOGDescriptor self, Mat img, VecPoint *foundLocations, double hitThresh,
                               Size winStride, Size padding, VecPoint *searchLocations);
CvStatus HOGDescriptor_DetectMultiScale(HOGDescriptor self, Mat img, VecRect *rval);
CvStatus HOGDescriptor_DetectMultiScaleWithParams(HOGDescriptor self, Mat img, double hitThresh,
                                                  Size winStride, Size padding, double scale,
                                                  double finalThreshold, bool useMeanshiftGrouping,
                                                  VecRect *rval);
CvStatus HOG_GetDefaultPeopleDetector(VecFloat *rval);
CvStatus HOGDescriptor_SetSVMDetector(HOGDescriptor self, VecFloat det);
CvStatus HOGDescriptor_Compute(HOGDescriptor self, Mat img, VecFloat *descriptors, Size winStride,
                               Size padding, VecPoint *locations);
CvStatus HOGDescriptor_computeGradient(HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL,
                                       Size paddingBR);
// CvStatus HOGDescriptor_detectMultiScaleROI(HOGDescriptor self, Mat img, VecRect *foundLocations,
//                                            DetectionROI *locations, int *lenLocations, double hitThreshold,
//                                            int groupThreshold);
// CvStatus HOGDescriptor_detectROI(HOGDescriptor self, Mat img, VecPoint *locations, VecPoint
// *foundLocations,
//                                  VecDouble *confidences, double hitThreshold, Size winStride, Size
//                                  padding);
CvStatus HOGDescriptor_getDaimlerPeopleDetector(VecFloat *rval);
CvStatus HOGDescriptor_getDescriptorSize(HOGDescriptor self, size_t *rval);
CvStatus HOGDescriptor_getWinSigma(HOGDescriptor self, double *rval);
CvStatus HOGDescriptor_groupRectangles(HOGDescriptor self, VecRect rectList, VecDouble weights,
                                       int groupThreshold, double eps);

CvStatus GroupRectangles(VecRect rects, int groupThreshold, double eps);

// QRCodeDetector
CvStatus QRCodeDetector_New(QRCodeDetector *rval);
void     QRCodeDetector_Close(QRCodeDetector *self);
CvStatus QRCodeDetector_DetectAndDecode(QRCodeDetector self, Mat input, VecPoint *points,
                                        Mat *straight_qrcode, VecChar *rval);
CvStatus QRCodeDetector_Detect(QRCodeDetector self, Mat input, VecPoint *points, bool *rval);
CvStatus QRCodeDetector_Decode(QRCodeDetector self, Mat input, VecPoint inputPoints, Mat straight_qrcode,
                               VecChar *rval);
CvStatus QRCodeDetector_decodeCurved(QRCodeDetector self, Mat img, VecPoint points,
                                     CVD_OUT Mat *straight_qrcode, char **rval);
CvStatus QRCodeDetector_detectAndDecodeCurved(QRCodeDetector self, Mat img, VecPoint *points,
                                              CVD_OUT Mat *straight_qrcode, char **rval);
CvStatus QRCodeDetector_DetectMulti(QRCodeDetector self, Mat input, VecPoint points, bool *rval);
CvStatus QRCodeDetector_DetectAndDecodeMulti(QRCodeDetector self, Mat input, VecVecChar *decoded,
                                             VecPoint *points, VecMat *straight_code, bool *rval);
CvStatus QRCodeDetector_setEpsX(QRCodeDetector self, double epsX);
CvStatus QRCodeDetector_setEpsY(QRCodeDetector self, double epsY);
CvStatus QRCodeDetector_setUseAlignmentMarkers(QRCodeDetector self, bool useAlignmentMarkers);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_OBJDETECT_H_
