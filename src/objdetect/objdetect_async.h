/* Created by Rainyl. Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl. */
#ifndef CVD_OBJDETECT_ASYNC_H_
#define CVD_OBJDETECT_ASYNC_H_

#include "core/types.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>

extern "C" {
#endif
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
CvStatus *CascadeClassifier_DetectMultiScale_Async(CascadeClassifier self, Mat img, CvCallback_1 callback);
CvStatus *CascadeClassifier_DetectMultiScaleWithParams_Async(CascadeClassifier self, Mat img, double scale, int minNeighbors, int flags, Size minSize, Size maxSize, CvCallback_1 callback);
CvStatus *CascadeClassifier_DetectMultiScale2_Async(CascadeClassifier self, Mat img, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize, CvCallback_2 callback);
CvStatus *CascadeClassifier_DetectMultiScale3_Async(CascadeClassifier self, Mat img, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize, bool outputRejectLevels, CvCallback_3 callback);
CvStatus *CascadeClassifier_Empty_Async(CascadeClassifier self, CvCallback_1 callback);
CvStatus *CascadeClassifier_getFeatureType_Async(CascadeClassifier self, CvCallback_1 callback);
CvStatus *CascadeClassifier_getOriginalWindowSize_Async(CascadeClassifier self, CvCallback_1 callback);
CvStatus *CascadeClassifier_isOldFormatCascade_Async(CascadeClassifier self, CvCallback_1 callback);

// HOGDescriptor
CvStatus *HOGDescriptor_Detect_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, CvCallback_1 callback);
CvStatus *HOGDescriptor_Detect2_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, CvCallback_1 callback);
CvStatus *HOGDescriptor_DetectMultiScale_Async(HOGDescriptor self, Mat img, CvCallback_1 callback);
CvStatus *HOGDescriptor_DetectMultiScaleWithParams_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, double scale, double finalThreshold, bool useMeanshiftGrouping, CvCallback_1 callback);
CvStatus *HOGDescriptor_Compute_Async(HOGDescriptor self, Mat img, Size winStride, Size padding, CvCallback_1 callback);
CvStatus *HOGDescriptor_computeGradient_Async(HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL, Size paddingBR, CvCallback_1 callback);
CvStatus *HOGDescriptor_getDaimlerPeopleDetector_Async(CvCallback_1 callback);
CvStatus *HOGDescriptor_getDescriptorSize_Async(HOGDescriptor self, CvCallback_1 callback);
CvStatus *HOGDescriptor_getWinSigma_Async(HOGDescriptor self, CvCallback_1 callback);
CvStatus *HOGDescriptor_groupRectangles_Async(HOGDescriptor self, VecRect rectList, VecDouble weights, int groupThreshold, double eps, CvCallback_1 callback);
CvStatus *GroupRectangles_Async(VecRect rects, int groupThreshold, double eps, CvCallback_1 callback);

// QRCodeDetector
CvStatus *QRCodeDetector_DetectAndDecode_Async(QRCodeDetector self, Mat input, CvCallback_3 callback);
CvStatus *QRCodeDetector_Detect_Async(QRCodeDetector self, Mat input, CvCallback_1 callback);
CvStatus *QRCodeDetector_Decode_Async(QRCodeDetector self, Mat input, CvCallback_2 callback);
CvStatus *QRCodeDetector_decodeCurved_Async(QRCodeDetector self, Mat img, VecPoint points, CvCallback_2 callback);
CvStatus *QRCodeDetector_detectAndDecodeCurved_Async(QRCodeDetector self, Mat img, CvCallback_3 callback);
CvStatus *QRCodeDetector_DetectMulti_Async(QRCodeDetector self, Mat input, CvCallback_1 callback);
CvStatus *QRCodeDetector_DetectAndDecodeMulti_Async(QRCodeDetector self, Mat input, CvCallback_4 callback);
CvStatus *QRCodeDetector_setEpsX_Async(QRCodeDetector self, double epsX, CvCallback_1 callback);
CvStatus *QRCodeDetector_setEpsY_Async(QRCodeDetector self, double epsY, CvCallback_1 callback);
CvStatus *QRCodeDetector_setUseAlignmentMarkers_Async(QRCodeDetector self, bool useAlignmentMarkers, CvCallback_1 callback);

// FaceDetectorYN
CvStatus *FaceDetectorYN_Detect_Async(FaceDetectorYN self, Mat img, CvCallback_1 callback);

// FaceRecognizerSF
CvStatus *FaceRecognizerSF_AlignCrop_Async(FaceRecognizerSF self, Mat src_img, Mat face_box, CvCallback_1 callback);
CvStatus *FaceRecognizerSF_Feature_Async(FaceRecognizerSF self, Mat aligned_img, bool clone, CvCallback_1 callback);
CvStatus *FaceRecognizerSF_Match_Async(FaceRecognizerSF self, Mat face_feature1, Mat face_feature2, int dis_type, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_OBJDETECT_ASYNC_H_
