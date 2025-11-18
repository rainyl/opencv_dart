/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_OBJDETECT_H_
#define CVD_OBJDETECT_H_

#include <stdbool.h>
#ifdef __cplusplus
#include <opencv2/objdetect.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"
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
CVD_TYPEDEF(void*, FaceDetectorYN);
CVD_TYPEDEF(void*, FaceRecognizerSF);
#endif

// CascadeClassifier
CvStatus* cv_CascadeClassifier_create(CascadeClassifier* rval);
CvStatus* cv_CascadeClassifier_create_1(const char* filename, CascadeClassifier* rval);
void cv_CascadeClassifier_close(CascadeClassifierPtr self);
CvStatus* cv_CascadeClassifier_load(CascadeClassifier self, const char* name, int* rval);
CvStatus* cv_CascadeClassifier_detectMultiScale(
    CascadeClassifier self, Mat img, VecRect* rval, CvCallback_0 callback
);
CvStatus* cv_CascadeClassifier_detectMultiScale_1(
    CascadeClassifier self,
    Mat img,
    VecRect* objects,
    double scale,
    int minNeighbors,
    int flags,
    CvSize minSize,
    CvSize maxSize,
    CvCallback_0 callback
);
CvStatus* cv_CascadeClassifier_detectMultiScale_2(
    CascadeClassifier self,
    Mat img,
    VecRect* objects,
    VecI32* numDetections,
    double scaleFactor,
    int minNeighbors,
    int flags,
    CvSize minSize,
    CvSize maxSize,
    CvCallback_0 callback
);
CvStatus* cv_CascadeClassifier_detectMultiScale_3(
    CascadeClassifier self,
    Mat img,
    VecRect* objects,
    VecI32* rejectLevels,
    VecF64* levelWeights,
    double scaleFactor,
    int minNeighbors,
    int flags,
    CvSize minSize,
    CvSize maxSize,
    bool outputRejectLevels,
    CvCallback_0 callback
);
bool cv_CascadeClassifier_empty(CascadeClassifier self);
int cv_CascadeClassifier_getFeatureType(CascadeClassifier self);
CvSize cv_CascadeClassifier_getOriginalWindowSize(CascadeClassifier self);
bool cv_CascadeClassifier_isOldFormatCascade(CascadeClassifier self);

// HOGDescriptor
// struct for detection region of interest (ROI)
// typedef struct DetectionROI {
//   VecF64 confidences;
//   VecPoint  locations;
//   double    scale;
// } DetectionROI;
CvStatus* cv_HOGDescriptor_create(HOGDescriptor* rval);
CvStatus* cv_HOGDescriptor_create_1(const char* filename, HOGDescriptor* rval);
void cv_HOGDescriptor_close(HOGDescriptorPtr self);
CvStatus* cv_HOGDescriptor_load(HOGDescriptor self, const char* name, bool* rval);
CvStatus* cv_HOGDescriptor_detect(
    HOGDescriptor self,
    Mat img,
    VecPoint* foundLocations,
    VecF64* weights,
    double hitThresh,
    CvSize winStride,
    CvSize padding,
    VecPoint* searchLocations,
    CvCallback_0 callback
);
CvStatus* cv_HOGDescriptor_detect2(
    HOGDescriptor self,
    Mat img,
    VecPoint* foundLocations,
    double hitThresh,
    CvSize winStride,
    CvSize padding,
    VecPoint* searchLocations,
    CvCallback_0 callback
);
CvStatus* cv_HOGDescriptor_detectMultiScale(
    HOGDescriptor self, Mat img, VecRect* rval, CvCallback_0 callback
);
CvStatus* cv_HOGDescriptor_detectMultiScale_1(
    HOGDescriptor self,
    Mat img,
    double hitThresh,
    CvSize winStride,
    CvSize padding,
    double scale,
    double finalThreshold,
    bool useMeanshiftGrouping,
    VecRect* rval,
    CvCallback_0 callback
);
CvStatus* cv_HOGDescriptor_getDefaultPeopleDetector(VecF32* rval);
CvStatus* cv_HOGDescriptor_setSVMDetector(HOGDescriptor self, VecF32 det);
CvStatus* cv_HOGDescriptor_compute(
    HOGDescriptor self,
    Mat img,
    VecF32* descriptors,
    CvSize winStride,
    CvSize padding,
    VecPoint* locations,
    CvCallback_0 callback
);
CvStatus* cv_HOGDescriptor_computeGradient(
    HOGDescriptor self,
    Mat img,
    Mat grad,
    Mat angleOfs,
    CvSize paddingTL,
    CvSize paddingBR,
    CvCallback_0 callback
);
// CvStatus *HOGDescriptor_detectMultiScaleROI(HOGDescriptor self, Mat img, VecRect *foundLocations,
//                                            DetectionROI *locations, int *lenLocations, double hitThreshold,
//                                            int groupThreshold);
// CvStatus *HOGDescriptor_detectROI(HOGDescriptor self, Mat img, VecPoint *locations, VecPoint
// *foundLocations,
//                                  VecF64 *confidences, double hitThreshold, CvSize winStride, CvSize
//                                  padding);
CvStatus* cv_HOGDescriptor_getDaimlerPeopleDetector(VecF32* rval);
size_t cv_HOGDescriptor_getDescriptorSize(HOGDescriptor self);
double cv_HOGDescriptor_getWinSigma(HOGDescriptor self);
CvStatus* cv_HOGDescriptor_groupRectangles(
    HOGDescriptor self,
    VecRect* rectList,
    VecF64* weights,
    int groupThreshold,
    double eps,
    CvCallback_0 callback
);
CvStatus* cv_groupRectangles(VecRect* rects, int groupThreshold, double eps, CvCallback_0 callback);

// QRCodeDetector
CvStatus* cv_QRCodeDetector_create(QRCodeDetector* rval);
void cv_QRCodeDetector_close(QRCodeDetectorPtr self);
CvStatus* cv_QRCodeDetector_detectAndDecode(
    QRCodeDetector self,
    Mat input,
    VecPoint* points,
    Mat* straight_qrcode,
    char** rval,
    CvCallback_0 callback
);
CvStatus* cv_QRCodeDetector_detect(
    QRCodeDetector self, Mat input, VecPoint* points, bool* rval, CvCallback_0 callback
);
CvStatus* cv_QRCodeDetector_decode(
    QRCodeDetector self,
    Mat input,
    VecPoint* points,
    Mat straight_qrcode,
    char** rval,
    CvCallback_0 callback
);
CvStatus* cv_QRCodeDetector_decodeCurved(
    QRCodeDetector self,
    Mat img,
    VecPoint points,
    CVD_OUT Mat* straight_qrcode,
    char** rval,
    CvCallback_0 callback
);
CvStatus* cv_QRCodeDetector_detectAndDecodeCurved(
    QRCodeDetector self,
    Mat img,
    VecPoint* points,
    CVD_OUT Mat* straight_qrcode,
    char** rval,
    CvCallback_0 callback
);
CvStatus* cv_QRCodeDetector_detectMulti(
    QRCodeDetector self, Mat input, VecPoint* points, bool* rval, CvCallback_0 callback
);
CvStatus* cv_QRCodeDetector_detectAndDecodeMulti(
    QRCodeDetector self,
    Mat input,
    VecVecChar* decoded,
    VecPoint* points,
    VecMat* straight_code,
    bool* rval,
    CvCallback_0 callback
);
void cv_QRCodeDetector_setEpsX(QRCodeDetector self, double epsX);
void cv_QRCodeDetector_setEpsY(QRCodeDetector self, double epsY);
void cv_QRCodeDetector_setUseAlignmentMarkers(QRCodeDetector self, bool useAlignmentMarkers);

// FaceDetectorYN
CvStatus* cv_FaceDetectorYN_create(
    const char* model,
    const char* config,
    CvSize input_size,
    float score_threshold,
    float nms_threshold,
    int top_k,
    int backend_id,
    int target_id,
    FaceDetectorYN* rval
);
CvStatus* cv_FaceDetectorYN_create_1(
    const char* framework,
    VecUChar buffer,
    VecUChar buffer_config,
    CvSize input_size,
    float score_threshold,
    float nms_threshold,
    int top_k,
    int backend_id,
    int target_id,
    FaceDetectorYN* rval
);
void cv_FaceDetectorYN_close(FaceDetectorYNPtr self);
CvStatus* cv_FaceDetectorYN_detect(FaceDetectorYN self, Mat img, Mat* faces, CvCallback_0 callback);
void cv_FaceDetectorYN_setInputSize(FaceDetectorYN self, CvSize input_size);
void cv_FaceDetectorYN_setScoreThreshold(FaceDetectorYN self, float score_threshold);
void cv_FaceDetectorYN_setNMSThreshold(FaceDetectorYN self, float nms_threshold);
void cv_FaceDetectorYN_setTopK(FaceDetectorYN self, int top_k);
CvSize cv_FaceDetectorYN_getInputSize(FaceDetectorYN self);
float cv_FaceDetectorYN_getScoreThreshold(FaceDetectorYN self);
float cv_FaceDetectorYN_getNMSThreshold(FaceDetectorYN self);
int cv_FaceDetectorYN_getTopK(FaceDetectorYN self);

// FaceRecognizerSF
CvStatus* cv_FaceRecognizerSF_create(
    const char* model, const char* config, int backend_id, int target_id, FaceRecognizerSF* rval
);
void cv_FaceRecognizerSF_close(FaceRecognizerSFPtr self);
CvStatus* cv_FaceRecognizerSF_alignCrop(
    FaceRecognizerSF self, Mat src_img, Mat face_box, Mat* aligned_img, CvCallback_0 callback
);
CvStatus* cv_FaceRecognizerSF_feature(
    FaceRecognizerSF self, Mat aligned_img, bool clone, Mat* face_feature, CvCallback_0 callback
);
CvStatus* cv_FaceRecognizerSF_match(
    FaceRecognizerSF self,
    Mat face_feature1,
    Mat face_feature2,
    int dis_type,
    double* distance,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  //CVD_OBJDETECT_H_
