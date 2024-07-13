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
#include <stddef.h>

#ifdef __cplusplus
// Define types for the C++ classes used
CVD_TYPEDEF(cv::CascadeClassifier, CascadeClassifier);
CVD_TYPEDEF(cv::HOGDescriptor, HOGDescriptor);
CVD_TYPEDEF(cv::QRCodeDetector, QRCodeDetector);
CVD_TYPEDEF(cv::Ptr<cv::FaceDetectorYN>, FaceDetectorYN);
CVD_TYPEDEF(cv::Ptr<cv::FaceRecognizerSF>, FaceRecognizerSF);
#else
// Define types for the C-compatible interface
CVD_TYPEDEF(void, CascadeClassifier);
CVD_TYPEDEF(void, HOGDescriptor);
CVD_TYPEDEF(void, QRCodeDetector);
CVD_TYPEDEF(void *, FaceDetectorYN);
CVD_TYPEDEF(void *, FaceRecognizerSF);
#endif

// CascadeClassifier
CvStatus *CascadeClassifier_New(CascadeClassifier *rval);
CvStatus *CascadeClassifier_NewFromFile(char *filename, CascadeClassifier *rval);
void      CascadeClassifier_Close(CascadeClassifierPtr self);
CvStatus *CascadeClassifier_Load(CascadeClassifier self, const char *name, int *rval);
CvStatus *CascadeClassifier_DetectMultiScale(CascadeClassifier self, Mat img, VecRect *rval);
CvStatus *CascadeClassifier_DetectMultiScaleWithParams(CascadeClassifier self, Mat img, VecRect *objects,
                                                       double scale, int minNeighbors, int flags,
                                                       Size minSize, Size maxSize);
CvStatus *CascadeClassifier_DetectMultiScale2(CascadeClassifier self, Mat img, VecRect *objects,
                                              VecI32 *numDetections, double scaleFactor, int minNeighbors,
                                              int flags, Size minSize, Size maxSize);
CvStatus *CascadeClassifier_DetectMultiScale3(CascadeClassifier self, Mat img, VecRect *objects,
                                              VecI32 *rejectLevels, VecF64 *levelWeights,
                                              double scaleFactor, int minNeighbors, int flags, Size minSize,
                                              Size maxSize, bool outputRejectLevels);
CvStatus *CascadeClassifier_Empty(CascadeClassifier self, bool *rval);
CvStatus *CascadeClassifier_getFeatureType(CascadeClassifier self, int *rval);
CvStatus *CascadeClassifier_getOriginalWindowSize(CascadeClassifier self, Size *rval);
CvStatus *CascadeClassifier_isOldFormatCascade(CascadeClassifier self, bool *rval);

// HOGDescriptor
// struct for detection region of interest (ROI)
// typedef struct DetectionROI {
//   VecF64 confidences;
//   VecPoint  locations;
//   double    scale;
// } DetectionROI;
CvStatus *HOGDescriptor_New(HOGDescriptor *rval);
CvStatus *HOGDescriptor_NewFromFile(char *filename, HOGDescriptor *rval);
void      HOGDescriptor_Close(HOGDescriptorPtr self);
CvStatus *HOGDescriptor_Load(HOGDescriptor self, char *name, bool *rval);
CvStatus *HOGDescriptor_Detect(HOGDescriptor self, Mat img, VecPoint *foundLocations, VecF64 *weights,
                               double hitThresh, Size winStride, Size padding, VecPoint *searchLocations);
CvStatus *HOGDescriptor_Detect2(HOGDescriptor self, Mat img, VecPoint *foundLocations, double hitThresh,
                                Size winStride, Size padding, VecPoint *searchLocations);
CvStatus *HOGDescriptor_DetectMultiScale(HOGDescriptor self, Mat img, VecRect *rval);
CvStatus *HOGDescriptor_DetectMultiScaleWithParams(HOGDescriptor self, Mat img, double hitThresh,
                                                   Size winStride, Size padding, double scale,
                                                   double finalThreshold, bool useMeanshiftGrouping,
                                                   VecRect *rval);
CvStatus *HOG_GetDefaultPeopleDetector(VecF32 *rval);
CvStatus *HOGDescriptor_SetSVMDetector(HOGDescriptor self, VecF32 det);
CvStatus *HOGDescriptor_Compute(HOGDescriptor self, Mat img, VecF32 *descriptors, Size winStride,
                                Size padding, VecPoint *locations);
CvStatus *HOGDescriptor_computeGradient(HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL,
                                        Size paddingBR);
// CvStatus *HOGDescriptor_detectMultiScaleROI(HOGDescriptor self, Mat img, VecRect *foundLocations,
//                                            DetectionROI *locations, int *lenLocations, double hitThreshold,
//                                            int groupThreshold);
// CvStatus *HOGDescriptor_detectROI(HOGDescriptor self, Mat img, VecPoint *locations, VecPoint
// *foundLocations,
//                                  VecF64 *confidences, double hitThreshold, Size winStride, Size
//                                  padding);
CvStatus *HOGDescriptor_getDaimlerPeopleDetector(VecF32 *rval);
CvStatus *HOGDescriptor_getDescriptorSize(HOGDescriptor self, size_t *rval);
CvStatus *HOGDescriptor_getWinSigma(HOGDescriptor self, double *rval);
CvStatus *HOGDescriptor_groupRectangles(HOGDescriptor self, VecRect *rectList, VecF64 *weights,
                                        int groupThreshold, double eps);
CvStatus *GroupRectangles(VecRect *rects, int groupThreshold, double eps);

// QRCodeDetector
CvStatus *QRCodeDetector_New(QRCodeDetector *rval);
void      QRCodeDetector_Close(QRCodeDetectorPtr self);
CvStatus *QRCodeDetector_DetectAndDecode(QRCodeDetector self, Mat input, VecPoint *points,
                                         Mat *straight_qrcode, char **rval);
CvStatus *QRCodeDetector_Detect(QRCodeDetector self, Mat input, VecPoint *points, bool *rval);
CvStatus *QRCodeDetector_Decode(QRCodeDetector self, Mat input, VecPoint *points, Mat straight_qrcode,
                                char **rval);
CvStatus *QRCodeDetector_decodeCurved(QRCodeDetector self, Mat img, VecPoint points,
                                      CVD_OUT Mat *straight_qrcode, char **rval);
CvStatus *QRCodeDetector_detectAndDecodeCurved(QRCodeDetector self, Mat img, VecPoint *points,
                                               CVD_OUT Mat *straight_qrcode, char **rval);
CvStatus *QRCodeDetector_DetectMulti(QRCodeDetector self, Mat input, VecPoint *points, bool *rval);
CvStatus *QRCodeDetector_DetectAndDecodeMulti(QRCodeDetector self, Mat input, VecVecChar *decoded,
                                              VecPoint *points, VecMat *straight_code, bool *rval);
CvStatus *QRCodeDetector_setEpsX(QRCodeDetector self, double epsX);
CvStatus *QRCodeDetector_setEpsY(QRCodeDetector self, double epsY);
CvStatus *QRCodeDetector_setUseAlignmentMarkers(QRCodeDetector self, bool useAlignmentMarkers);

// FaceDetectorYN
CvStatus *FaceDetectorYN_New(const char *model, const char *config, Size input_size, float score_threshold,
                             float nms_threshold, int top_k, int backend_id, int target_id,
                             FaceDetectorYN *rval);
CvStatus *FaceDetectorYN_NewFromBuffer(const char *framework, VecUChar buffer, VecUChar buffer_config,
                                       Size input_size, float score_threshold, float nms_threshold, int top_k,
                                       int backend_id, int target_id, FaceDetectorYN *rval);
void      FaceDetectorYN_Close(FaceDetectorYNPtr self);
CvStatus *FaceDetectorYN_Detect(FaceDetectorYN self, Mat img, Mat *faces);
CvStatus *FaceDetectorYN_SetInputSize(FaceDetectorYN self, Size input_size);
CvStatus *FaceDetectorYN_SetScoreThreshold(FaceDetectorYN self, float score_threshold);
CvStatus *FaceDetectorYN_SetNMSThreshold(FaceDetectorYN self, float nms_threshold);
CvStatus *FaceDetectorYN_SetTopK(FaceDetectorYN self, int top_k);
CvStatus *FaceDetectorYN_GetInputSize(FaceDetectorYN self, Size *input_size);
CvStatus *FaceDetectorYN_GetScoreThreshold(FaceDetectorYN self, float *score_threshold);
CvStatus *FaceDetectorYN_GetNMSThreshold(FaceDetectorYN self, float *nms_threshold);
CvStatus *FaceDetectorYN_GetTopK(FaceDetectorYN self, int *top_k);

// FaceRecognizerSF
CvStatus *FaceRecognizerSF_New(const char *model, const char *config, int backend_id, int target_id,
                               FaceRecognizerSF *rval);
void      FaceRecognizerSF_Close(FaceRecognizerSFPtr self);
CvStatus *FaceRecognizerSF_AlignCrop(FaceRecognizerSF self, Mat src_img, Mat face_box, Mat *aligned_img);
CvStatus *FaceRecognizerSF_Feature(FaceRecognizerSF self, Mat aligned_img, bool clone, Mat *face_feature);
CvStatus *FaceRecognizerSF_Match(FaceRecognizerSF self, Mat face_feature1, Mat face_feature2, int dis_type,
                                 double *distance);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_OBJDETECT_H_
