/* Created by Rainyl. Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl. */
#ifndef CVD_OBJDETECT_ASYNC_H_
#define CVD_OBJDETECT_ASYNC_H_

#include "core/types.h"
#include "objdetect.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

// CascadeClassifier
CvStatus *CascadeClassifier_New_Async(CvCallback_1 callback);
CvStatus *CascadeClassifier_NewFromFile_Async(const char *filename, CvCallback_1 callback);
CvStatus *CascadeClassifier_Load_Async(CascadeClassifier self, const char *name, CvCallback_1 callback);
CvStatus *CascadeClassifier_DetectMultiScale_Async(CascadeClassifier self, Mat img, CvCallback_1 callback);
CvStatus *CascadeClassifier_DetectMultiScaleWithParams_Async(CascadeClassifier self, Mat img, double scale, int minNeighbors, int flags, Size minSize, Size maxSize, CvCallback_1 callback);
CvStatus *CascadeClassifier_DetectMultiScale2_Async(CascadeClassifier self, Mat img, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize, CvCallback_2 callback);
CvStatus *CascadeClassifier_DetectMultiScale3_Async(CascadeClassifier self, Mat img, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize, bool outputRejectLevels, CvCallback_3 callback);
CvStatus *CascadeClassifier_Empty_Async(CascadeClassifier self, CvCallback_1 callback);
CvStatus *CascadeClassifier_getFeatureType_Async(CascadeClassifier self, CvCallback_1 callback);
CvStatus *CascadeClassifier_getOriginalWindowSize_Async(CascadeClassifier self, CvCallback_1 callback);
CvStatus *CascadeClassifier_isOldFormatCascade_Async(CascadeClassifier self, CvCallback_1 callback);

// HOGDescriptor
CvStatus *HOGDescriptor_New_Async(CvCallback_1 callback);
CvStatus *HOGDescriptor_NewFromFile_Async(const char *filename, CvCallback_1 callback);
CvStatus *HOGDescriptor_Load_Async(HOGDescriptor self, const char *name, CvCallback_1 callback);
CvStatus *HOGDescriptor_Detect_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, CvCallback_3 callback);
CvStatus *HOGDescriptor_Detect2_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, CvCallback_2 callback);
CvStatus *HOGDescriptor_DetectMultiScale_Async(HOGDescriptor self, Mat img, CvCallback_1 callback);
CvStatus *HOGDescriptor_DetectMultiScaleWithParams_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, double scale, double finalThreshold, bool useMeanshiftGrouping, CvCallback_1 callback);
CvStatus *HOGDescriptor_Compute_Async(HOGDescriptor self, Mat img, Size winStride, Size padding, CvCallback_2 callback);
CvStatus *HOGDescriptor_computeGradient_Async(HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL, Size paddingBR, CvCallback_0 callback);
CvStatus *HOG_GetDefaultPeopleDetector_Async(CvCallback_1 callback);
CvStatus *HOGDescriptor_SetSVMDetector_Async(HOGDescriptor self, VecF32 det, CvCallback_0 callback);
CvStatus *HOGDescriptor_getDaimlerPeopleDetector_Async(CvCallback_1 callback);
CvStatus *HOGDescriptor_getDescriptorSize_Async(HOGDescriptor self, CvCallback_1 callback);
CvStatus *HOGDescriptor_getWinSigma_Async(HOGDescriptor self, CvCallback_1 callback);
CvStatus *HOGDescriptor_groupRectangles_Async(HOGDescriptor self, VecRect *rectList, VecF64 *weights, int groupThreshold, double eps, CvCallback_0 callback);
CvStatus *GroupRectangles_Async(VecRect *rects, int groupThreshold, double eps, CvCallback_0 callback);

// QRCodeDetector
CvStatus *QRCodeDetector_New_Async(CvCallback_1 callback);
CvStatus *QRCodeDetector_DetectAndDecode_Async(QRCodeDetector self, Mat input, CvCallback_3 callback);
CvStatus *QRCodeDetector_Detect_Async(QRCodeDetector self, Mat input, CvCallback_2 callback);
CvStatus *QRCodeDetector_Decode_Async(QRCodeDetector self, Mat input, CvCallback_3 callback);
CvStatus *QRCodeDetector_decodeCurved_Async(QRCodeDetector self, Mat img, VecPoint points, CvCallback_2 callback);
CvStatus *QRCodeDetector_detectAndDecodeCurved_Async(QRCodeDetector self, Mat img, CvCallback_3 callback);
CvStatus *QRCodeDetector_DetectMulti_Async(QRCodeDetector self, Mat input, CvCallback_2 callback);
CvStatus *QRCodeDetector_DetectAndDecodeMulti_Async(QRCodeDetector self, Mat input, CvCallback_4 callback);
CvStatus *QRCodeDetector_setEpsX_Async(QRCodeDetector self, double epsX, CvCallback_0 callback);
CvStatus *QRCodeDetector_setEpsY_Async(QRCodeDetector self, double epsY, CvCallback_0 callback);
CvStatus *QRCodeDetector_setUseAlignmentMarkers_Async(QRCodeDetector self, bool useAlignmentMarkers, CvCallback_0 callback);

// FaceDetectorYN
CvStatus *FaceDetectorYN_New_Async(const char *model, const char *config, Size input_size, float score_threshold, float nms_threshold, int top_k, int backend_id, int target_id, CvCallback_1 callback);
CvStatus *FaceDetectorYN_NewFromBuffer_Async(const char *framework, VecUChar buffer, VecUChar buffer_config, Size input_size, float score_threshold, float nms_threshold, int top_k, int backend_id, int target_id, CvCallback_1 callback);
CvStatus *FaceDetectorYN_Detect_Async(FaceDetectorYN self, Mat img, CvCallback_1 callback);
CvStatus *FaceDetectorYN_SetInputSize_Async(FaceDetectorYN self, Size input_size, CvCallback_0 callback);
CvStatus *FaceDetectorYN_GetInputSize_Async(FaceDetectorYN self, CvCallback_1 callback);
CvStatus *FaceDetectorYN_SetScoreThreshold_Async(FaceDetectorYN self, float score_threshold, CvCallback_0 callback);
CvStatus *FaceDetectorYN_GetScoreThreshold_Async(FaceDetectorYN self, CvCallback_1 callback);
CvStatus *FaceDetectorYN_SetNMSThreshold_Async(FaceDetectorYN self, float nms_threshold, CvCallback_0 callback);
CvStatus *FaceDetectorYN_GetNMSThreshold_Async(FaceDetectorYN self, CvCallback_1 callback);
CvStatus *FaceDetectorYN_SetTopK_Async(FaceDetectorYN self, int top_k, CvCallback_0 callback);
CvStatus *FaceDetectorYN_GetTopK_Async(FaceDetectorYN self, CvCallback_1 callback);

// FaceRecognizerSF
CvStatus *FaceRecognizerSF_New_Async(const char *model, const char *config, int backend_id, int target_id, CvCallback_1 callback);
CvStatus *FaceRecognizerSF_AlignCrop_Async(FaceRecognizerSF self, Mat src_img, Mat face_box, CvCallback_1 callback);
CvStatus *FaceRecognizerSF_Feature_Async(FaceRecognizerSF self, Mat aligned_img, bool clone, CvCallback_1 callback);
CvStatus *FaceRecognizerSF_Match_Async(FaceRecognizerSF self, Mat face_feature1, Mat face_feature2, int dis_type, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_OBJDETECT_ASYNC_H_
