/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/dnn/dnn.h"
#include "dartcv/core/vec.hpp"
#include <cstdint>
#include <vector>

// AsyncArray_New creates a new empty AsyncArray
CvStatus* cv_dnn_AsyncArray_new(AsyncArray* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::AsyncArray();
    END_WRAP
}

// AsyncArray_Close deletes an existing AsyncArray
void cv_dnn_AsyncArray_close(AsyncArrayPtr a) {
    CVD_FREE(a);
}

CvStatus* cv_dnn_AsyncArray_get(AsyncArray async_out, Mat out) {
    BEGIN_WRAP
    async_out.ptr->get(CVDEREF(out));
    END_WRAP
}

CvStatus* cv_dnn_blobFromImage(
    Mat image,
    Mat blob,
    double scalefactor,
    CvSize size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Size sz(size.width, size.height);
    cv::Scalar cm(mean.val1, mean.val2, mean.val3, mean.val4);
    cv::dnn::blobFromImage(CVDEREF(image), CVDEREF(blob), scalefactor, sz, cm, swapRB, crop, ddepth);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_blobFromImages(
    VecMat images,
    Mat blob,
    double scalefactor,
    CvSize size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Size sz(size.width, size.height);
    cv::Scalar cm = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
    cv::dnn::blobFromImages(CVDEREF(images), CVDEREF(blob), scalefactor, sz, cm, swapRB, crop, ddepth);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_dnn_enableModelDiagnostics(bool isDiagnosticsMode) {
    cv::dnn::enableModelDiagnostics(isDiagnosticsMode);
}
// rval: x: backend, y: target
void cv_dnn_getAvailableBackends(VecPoint* rval) {
    auto _bt = cv::dnn::getAvailableBackends();
    rval->ptr->reserve(_bt.size());
    for (int i = 0; i < _bt.size(); ++i) {
        rval->ptr->at(i) = cv::Point(_bt[i].first, _bt[i].second);
    }
}

CvStatus* cv_dnn_getAvailableTargets(int be, VecI32* rval) {
    BEGIN_WRAP
    std::vector<cv::dnn::Target> _targets =
        cv::dnn::getAvailableTargets(static_cast<cv::dnn::Backend>(be));
    *rval = {new std::vector<int>(_targets.begin(), _targets.end())};
    END_WRAP
}

CvStatus* cv_dnn_imagesFromBlob(Mat blob, VecMat* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::dnn::imagesFromBlob(CVDEREF(blob), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_getBlobChannel(
    Mat blob, int imgidx, int chnidx, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    int w = blob.ptr->size[3];
    int h = blob.ptr->size[2];
    rval->ptr = new cv::Mat(h, w, CV_32F, blob.ptr->ptr<float>(imgidx, chnidx));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_getBlobSize(Mat blob, VecI32* rval) {
    BEGIN_WRAP
    auto size = blob.ptr->size;
    *rval = {new std::vector<int32_t>(size.p, size.p + size.dims())};
    END_WRAP
}

CvStatus* cv_dnn_NMSBoxes(
    VecRect bboxes,
    VecF32 scores,
    float score_threshold,
    float nms_threshold,
    VecI32* out_indices,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::dnn::NMSBoxes(CVDEREF(bboxes), CVDEREF(scores), score_threshold, nms_threshold, CVDEREF_P(out_indices), 1.f, 0);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_NMSBoxes_1(
    VecRect bboxes,
    VecF32 scores,
    const float score_threshold,
    const float nms_threshold,
    VecI32* indices,
    const float eta,
    const int top_k,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::dnn::NMSBoxes(CVDEREF(bboxes), CVDEREF(scores), score_threshold, nms_threshold, CVDEREF_P(indices), eta, top_k);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_forwardAsync(Net net, const char* outputName, AsyncArray* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::AsyncArray(net.ptr->forwardAsync(outputName));
    END_WRAP
}

CvStatus* cv_dnn_Net_create(Net* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net();
    END_WRAP
}
CvStatus* cv_dnn_Net_fromNet(Net net, Net* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(CVDEREF(net));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNet(
    const char* model, const char* config, const char* framework, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNet(model, config, framework));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetBytes(
    const char* framework, VecUChar model, VecUChar config, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNet(framework, CVDEREF(model), CVDEREF(config)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromCaffe(
    const char* prototxt, const char* caffeModel, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromCaffe(prototxt, caffeModel));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromCaffeBytes(
    VecUChar prototxt, VecUChar caffeModel, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromCaffe(CVDEREF(prototxt), CVDEREF(caffeModel)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromTensorflow(
    const char* model, const char* config, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromTensorflow(model, config));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromTensorflowBytes(
    VecUChar model, VecUChar config, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromTensorflow(CVDEREF(model), CVDEREF(config)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromTFLite(const char* model, Net* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromTFLite(model));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromTFLiteBytes(
    VecUChar bufferModel, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromTFLite(CVDEREF(bufferModel)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromTorch(
    const char* model, bool isBinary, bool evaluate, Net* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromTorch(model, isBinary, evaluate));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromONNX(const char* model, Net* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromONNX(model));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dnn_Net_readNetFromONNXBytes(VecUChar model, Net* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    rval->ptr = new cv::dnn::Net(cv::dnn::readNetFromONNX(CVDEREF(model)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_dnn_Net_close(NetPtr net) {
    CVD_FREE(net);
}

bool cv_dnn_Net_empty(Net net) {
    return net.ptr->empty();
}

CvStatus* cv_dnn_Net_dump(Net net, char** rval) {
    BEGIN_WRAP
    auto ss = net.ptr->dump();
    *rval = strdup(ss.c_str());
    END_WRAP
}

CvStatus* cv_dnn_Net_setInput(
    Net net, Mat blob, const char* name, double scalefactor, Scalar mean, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar _mean(mean.val1, mean.val2, mean.val3, mean.val4);
    net.ptr->setInput(CVDEREF(blob), name, scalefactor, _mean);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_forward(Net net, const char* outputName, Mat* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(net.ptr->forward(outputName));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_forwardLayers(
    Net net, VecMat* outputBlobs, VecVecChar outBlobNames, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto names = vecvecchar_c2cpp_s(outBlobNames);
    net.ptr->forward(CVDEREF_P(outputBlobs), names);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_setPreferableBackend(Net net, int backend) {
    BEGIN_WRAP
    net.ptr->setPreferableBackend(backend);
    END_WRAP
}

CvStatus* cv_dnn_Net_setPreferableTarget(Net net, int target) {
    BEGIN_WRAP
    net.ptr->setPreferableTarget(target);
    END_WRAP
}

CvStatus* cv_dnn_Net_getPerfProfile(
    Net net, int64_t* rval, VecF64* layersTimes, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = net.ptr->getPerfProfile(*layersTimes->ptr);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_getUnconnectedOutLayers(Net net, VecI32* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto _rval = net.ptr->getUnconnectedOutLayers();
    if (rval->ptr != nullptr) {
      delete static_cast<std::vector<int32_t>*>(rval->ptr);
    }
    rval->ptr = new std::vector<int32_t>(_rval);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_getUnconnectedOutLayersNames(
    Net net, CVD_OUT VecVecChar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto _rval = net.ptr->getUnconnectedOutLayersNames();
    rval->ptr = vecstr_2_vecvecchar(_rval);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_getLayerNames(Net net, VecVecChar* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    std::vector<cv::String> cstrs = net.ptr->getLayerNames();
    rval->ptr = vecstr_2_vecvecchar(cstrs);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_getInputDetails(
    Net net, VecF32* scales, VecI32* zeropoints, CvCallback_0 callback
) {
    BEGIN_WRAP
    net.ptr->getInputDetails(CVDEREF_P(scales), CVDEREF_P(zeropoints));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dnn_Net_getLayer(Net net, int layerid, Layer* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::dnn::Layer>(net.ptr->getLayer(layerid));
    END_WRAP
}

CvStatus* cv_dnn_Layer_inputNameToIndex(Layer layer, const char* name, int* rval) {
    BEGIN_WRAP
    *rval = (CVDEREF(layer))->inputNameToIndex(name);
    END_WRAP
}

CvStatus* cv_dnn_Layer_outputNameToIndex(Layer layer, const char* name, int* rval) {
    BEGIN_WRAP
    *rval = (CVDEREF(layer))->outputNameToIndex(name);
    END_WRAP
}

CvStatus* cv_dnn_Layer_getName(Layer layer, char** rval) {
    BEGIN_WRAP
    auto ss = (CVDEREF(layer))->name;
    *rval = strdup(ss.c_str());
    END_WRAP
}

CvStatus* cv_dnn_Layer_getType(Layer layer, char** rval) {
    BEGIN_WRAP
    auto ss = (CVDEREF(layer))->type;
    *rval = strdup(ss.c_str());
    END_WRAP
}

void cv_dnn_Layer_close(LayerPtr layer) {
    layer->ptr->reset();
    CVD_FREE(layer);
}
