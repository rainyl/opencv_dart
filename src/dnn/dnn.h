/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_DNN_H_
#define _OPENCV3_DNN_H_

#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/dnn.hpp>
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"

#ifdef __cplusplus
typedef cv::dnn::Net            *Net;
typedef cv::Ptr<cv::dnn::Layer> *Layer;
#else
typedef void *Net;
typedef void *Layer;
#endif

CvStatus Net_Create(Net *rval);
CvStatus Net_ReadNet(const char *model, const char *config, const char *framework, Net *rval);
CvStatus Net_ReadNetBytes(const char *framework, VecUChar model, VecUChar config, Net *rval);
CvStatus Net_ReadNetFromCaffe(const char *prototxt, const char *caffeModel, Net *rval);
CvStatus Net_ReadNetFromCaffeBytes(VecUChar prototxt, VecUChar caffeModel, Net *rval);
CvStatus Net_ReadNetFromTensorflow(const char *model, const char *config, Net *rval);
CvStatus Net_ReadNetFromTensorflowBytes(VecUChar model, VecUChar config, Net *rval);
CvStatus Net_ReadNetFromTFLite(const char *model, Net *rval);
CvStatus Net_ReadNetFromTFLiteBytes(VecUChar bufferModel, Net *rval);
CvStatus Net_ReadNetFromTorch(const char *model, bool isBinary, bool evaluate, Net *rval);
CvStatus Net_ReadNetFromONNX(const char *model, Net *rval);
CvStatus Net_ReadNetFromONNXBytes(VecUChar model, Net *rval);
void     Net_Close(Net net);

CvStatus Net_BlobFromImage(Mat image, Mat blob, double scalefactor, Size size, Scalar mean, bool swapRB, bool crop, int ddepth);
CvStatus Net_BlobFromImages(VecMat images, Mat blob, double scalefactor, Size size, Scalar mean, bool swapRB, bool crop, int ddepth);
CvStatus Net_ImagesFromBlob(Mat blob, VecMat rval);
CvStatus Net_Empty(Net net, bool *rval);
CvStatus Net_SetInput(Net net, Mat blob, const char *name);
CvStatus Net_Forward(Net net, const char *outputName, Mat rval);
CvStatus Net_ForwardLayers(Net net, VecMat *outputBlobs, VecVecChar outBlobNames);
CvStatus Net_SetPreferableBackend(Net net, int backend);
CvStatus Net_SetPreferableTarget(Net net, int target);
CvStatus Net_GetPerfProfile(Net net, int64_t *rval);
CvStatus Net_GetUnconnectedOutLayers(Net net, VecInt rval);
CvStatus Net_GetLayerNames(Net net, VecVecChar rval);
CvStatus Net_GetInputDetails(Net net, VecFloat scales, VecInt zeropoints);

CvStatus Net_GetBlobChannel(Mat blob, int imgidx, int chnidx, Mat rval);
CvStatus Net_GetBlobSize(Mat blob, Scalar *rval);

CvStatus Net_GetLayer(Net net, int layerid, Layer *rval);
CvStatus Layer_InputNameToIndex(Layer layer, const char *name, int *rval);
CvStatus Layer_OutputNameToIndex(Layer layer, const char *name, int *rval);
CvStatus Layer_GetName(Layer layer, char *rval);
CvStatus Layer_GetType(Layer layer, char *rval);
void     Layer_Close(Layer layer);

CvStatus NMSBoxes(VecRect bboxes, VecFloat scores, float score_threshold, float nms_threshold, VecInt indices);
CvStatus NMSBoxesWithParams(VecRect bboxes, VecFloat scores, const float score_threshold, const float nms_threshold, VecInt indices, const float eta, const int top_k);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_DNN_H_
