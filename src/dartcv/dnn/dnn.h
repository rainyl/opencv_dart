/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_DNN_H_
#define CVD_DNN_H_

#ifdef __cplusplus
#include <opencv2/dnn.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"
#include <stdbool.h>

#ifdef __cplusplus
CVD_TYPEDEF(cv::dnn::Net, Net)
CVD_TYPEDEF(cv::Ptr<cv::dnn::Layer>, Layer)
CVD_TYPEDEF(cv::AsyncArray, AsyncArray)
#else
CVD_TYPEDEF(void, Net);
CVD_TYPEDEF(void, Layer);
CVD_TYPEDEF(void, AsyncArray);
#endif

CvStatus* cv_dnn_AsyncArray_new(AsyncArray* rval);
CvStatus* cv_dnn_AsyncArray_get(AsyncArray async_out, Mat out);
CvStatus* cv_dnn_Net_forwardAsync(Net net, const char* outputName, AsyncArray* rval);
void cv_dnn_AsyncArray_close(AsyncArrayPtr a);

CvStatus* cv_dnn_blobFromImage(
    Mat image,
    CVD_OUT Mat blob,
    double scalefactor,
    CvSize size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth,
    CvCallback_0 callback
);
CvStatus* cv_dnn_blobFromImages(
    VecMat images,
    CVD_OUT Mat blob,
    double scalefactor,
    CvSize size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth,
    CvCallback_0 callback
);
void cv_dnn_enableModelDiagnostics(bool isDiagnosticsMode);
// rval: x: backend, y: target
void cv_dnn_getAvailableBackends(VecPoint* rval);
CvStatus* cv_dnn_getAvailableTargets(int be, VecI32* rval);
CvStatus* cv_dnn_imagesFromBlob(Mat blob, CVD_OUT VecMat* rval, CvCallback_0 callback);

CvStatus* cv_dnn_getBlobChannel(
    Mat blob, int imgidx, int chnidx, CVD_OUT Mat* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_getBlobSize(Mat blob, VecI32* rval);

CvStatus* cv_dnn_NMSBoxes(
    VecRect bboxes,
    VecF32 scores,
    float score_threshold,
    float nms_threshold,
    CVD_OUT VecI32* out_indices,
    CvCallback_0 callback
);
CvStatus* cv_dnn_NMSBoxes_1(
    VecRect bboxes,
    VecF32 scores,
    float score_threshold,
    float nms_threshold,
    CVD_OUT VecI32* indices,
    float eta,
    int top_k,
    CvCallback_0 callback
);

// Net
CvStatus* cv_dnn_Net_create(CVD_OUT Net* rval);
CvStatus* cv_dnn_Net_fromNet(Net net, CVD_OUT Net* rval, CvCallback_0 callback);
CvStatus* cv_dnn_Net_readNet(
    const char* model,
    const char* config,
    const char* framework,
    CVD_OUT Net* rval,
    CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetBytes(
    const char* framework, VecUChar model, VecUChar config, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromCaffe(
    const char* prototxt, const char* caffeModel, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromCaffeBytes(
    VecUChar prototxt, VecUChar caffeModel, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromTensorflow(
    const char* model, const char* config, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromTensorflowBytes(
    VecUChar model, VecUChar config, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromTFLite(const char* model, CVD_OUT Net* rval, CvCallback_0 callback);
CvStatus* cv_dnn_Net_readNetFromTFLiteBytes(
    VecUChar bufferModel, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromTorch(
    const char* model, bool isBinary, bool evaluate, CVD_OUT Net* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_readNetFromONNX(const char* model, CVD_OUT Net* rval, CvCallback_0 callback);
CvStatus* cv_dnn_Net_readNetFromONNXBytes(VecUChar model, CVD_OUT Net* rval, CvCallback_0 callback);
void cv_dnn_Net_close(NetPtr net);

bool cv_dnn_Net_empty(Net net);
CvStatus* cv_dnn_Net_dump(Net net, CVD_OUT char** rval);
CvStatus* cv_dnn_Net_setInput(
    Net net, Mat blob, const char* name, double scalefactor, Scalar mean, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_forward(
    Net net, const char* outputName, CVD_OUT Mat* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_forwardLayers(
    Net net, CVD_OUT VecMat* outputBlobs, VecVecChar outBlobNames, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_setPreferableBackend(Net net, int backend);
CvStatus* cv_dnn_Net_setPreferableTarget(Net net, int target);
CvStatus* cv_dnn_Net_getPerfProfile(
    Net net, CVD_OUT int64_t* rval, VecF64* layersTimes, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_getUnconnectedOutLayers(Net net, CVD_OUT VecI32* rval, CvCallback_0 callback);
CvStatus* cv_dnn_Net_getUnconnectedOutLayersNames(
    Net net, CVD_OUT VecVecChar* rval, CvCallback_0 callback
);
CvStatus* cv_dnn_Net_getLayerNames(Net net, CVD_OUT VecVecChar* rval, CvCallback_0 callback);
CvStatus* cv_dnn_Net_getInputDetails(
    Net net, CVD_OUT VecF32* scales, CVD_OUT VecI32* zeropoints, CvCallback_0 callback
);

// Layer
CvStatus* cv_dnn_Net_getLayer(Net net, int layerid, CVD_OUT Layer* rval);
CvStatus* cv_dnn_Layer_inputNameToIndex(Layer layer, const char* name, CVD_OUT int* rval);
CvStatus* cv_dnn_Layer_outputNameToIndex(Layer layer, const char* name, CVD_OUT int* rval);
CvStatus* cv_dnn_Layer_getName(Layer layer, CVD_OUT char** rval);
CvStatus* cv_dnn_Layer_getType(Layer layer, CVD_OUT char** rval);
void cv_dnn_Layer_close(LayerPtr layer);

#ifdef __cplusplus
}
#endif

#endif  //CVD_DNN_H_
