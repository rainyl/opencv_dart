/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
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
namespace cv_dnn = cv::dnn::dnn4_v20240521;
CVD_TYPEDEF(cv_dnn::Net, Net);
CVD_TYPEDEF(cv::Ptr<cv_dnn::Layer>, Layer);
#else
CVD_TYPEDEF(void, Net);
CVD_TYPEDEF(void, Layer);
#endif

CvStatus *Net_Create(CVD_OUT Net *rval);
CvStatus *Net_FromNet(Net net, CVD_OUT Net *rval);
CvStatus *Net_ReadNet(const char *model, const char *config, const char *framework, CVD_OUT Net *rval);
CvStatus *Net_ReadNetBytes(const char *framework, VecUChar model, VecUChar config, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromCaffe(const char *prototxt, const char *caffeModel, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromCaffeBytes(VecUChar prototxt, VecUChar caffeModel, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromTensorflow(const char *model, const char *config, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromTensorflowBytes(VecUChar model, VecUChar config, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromTFLite(const char *model, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromTFLiteBytes(VecUChar bufferModel, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromTorch(const char *model, bool isBinary, bool evaluate, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromONNX(const char *model, CVD_OUT Net *rval);
CvStatus *Net_ReadNetFromONNXBytes(VecUChar model, CVD_OUT Net *rval);
void      Net_Close(NetPtr net);

CvStatus *Net_BlobFromImage(Mat image, CVD_OUT Mat blob, double scalefactor, Size size, Scalar mean,
                            bool swapRB, bool crop, int ddepth);
CvStatus *Net_BlobFromImages(VecMat images, CVD_OUT Mat blob, double scalefactor, Size size, Scalar mean,
                             bool swapRB, bool crop, int ddepth);
CvStatus *Net_ImagesFromBlob(Mat blob, CVD_OUT VecMat *rval);
CvStatus *Net_Empty(Net net, CVD_OUT bool *rval);
CvStatus *Net_Dump(Net net, CVD_OUT char **rval);
CvStatus *Net_SetInput(Net net, Mat blob, const char *name);
CvStatus *Net_Forward(Net net, const char *outputName, CVD_OUT Mat *rval);
CvStatus *Net_ForwardLayers(Net net, CVD_OUT VecMat *outputBlobs, VecVecChar outBlobNames);
CvStatus *Net_SetPreferableBackend(Net net, int backend);
CvStatus *Net_SetPreferableTarget(Net net, int target);
CvStatus *Net_GetPerfProfile(Net net, CVD_OUT int64_t *rval);
CvStatus *Net_GetUnconnectedOutLayers(Net net, CVD_OUT VecI32 *rval);
CvStatus *Net_GetLayerNames(Net net, CVD_OUT VecVecChar *rval);
CvStatus *Net_GetInputDetails(Net net, CVD_OUT VecF32 *scales, CVD_OUT VecI32 *zeropoints);

CvStatus *Net_GetBlobChannel(Mat blob, int imgidx, int chnidx, CVD_OUT Mat *rval);
CvStatus *Net_GetBlobSize(Mat blob, CVD_OUT Scalar *rval);

CvStatus *Net_GetLayer(Net net, int layerid, CVD_OUT Layer *rval);
CvStatus *Layer_InputNameToIndex(Layer layer, const char *name, CVD_OUT int *rval);
CvStatus *Layer_OutputNameToIndex(Layer layer, const char *name, CVD_OUT int *rval);
CvStatus *Layer_GetName(Layer layer, CVD_OUT char **rval);
CvStatus *Layer_GetType(Layer layer, CVD_OUT char **rval);
void      Layer_Close(LayerPtr layer);

CvStatus *NMSBoxes(VecRect bboxes, VecF32 scores, float score_threshold, float nms_threshold,
                   CVD_OUT VecI32 *indices);
CvStatus *NMSBoxesWithParams(VecRect bboxes, VecF32 scores, const float score_threshold,
                             const float nms_threshold, CVD_OUT VecI32 *indices, const float eta,
                             const int top_k);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_DNN_H_
