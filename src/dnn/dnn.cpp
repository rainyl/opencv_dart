/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dnn.h"
#include "core/vec.hpp"
#include <string.h>
#include <vector>

CvStatus *Net_Create(Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net()};
  END_WRAP
}
CvStatus *Net_FromNet(Net net, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(*net.ptr)};
  END_WRAP
}
CvStatus *Net_ReadNet(const char *model, const char *config, const char *framework, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNet(model, config, framework))};
  END_WRAP
}
CvStatus *Net_ReadNetBytes(const char *framework, VecUChar model, VecUChar config, Net *rval) {
  BEGIN_WRAP
  auto _model = vecuchar_c2cpp(model);
  auto _config = vecuchar_c2cpp(config);
  *rval = {new cv_dnn::Net(cv_dnn::readNet(framework, _model, _config))};
  END_WRAP
}
CvStatus *Net_ReadNetFromCaffe(const char *prototxt, const char *caffeModel, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromCaffe(prototxt, caffeModel))};
  END_WRAP
}
CvStatus *Net_ReadNetFromCaffeBytes(VecUChar prototxt, VecUChar caffeModel, Net *rval) {
  BEGIN_WRAP
  auto _prototxt = vecuchar_c2cpp(prototxt);
  auto _caffeModel = vecuchar_c2cpp(caffeModel);
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromCaffe(_prototxt, _caffeModel))};
  END_WRAP
}
CvStatus *Net_ReadNetFromTensorflow(const char *model, const char *config, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromTensorflow(model, config))};
  END_WRAP
}
CvStatus *Net_ReadNetFromTensorflowBytes(VecUChar model, VecUChar config, Net *rval) {
  BEGIN_WRAP
  auto _model = vecuchar_c2cpp(model);
  auto _config = vecuchar_c2cpp(config);
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromTensorflow(_model, _config))};
  END_WRAP
}
CvStatus *Net_ReadNetFromTFLite(const char *model, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromTFLite(model))};
  END_WRAP
}
CvStatus *Net_ReadNetFromTFLiteBytes(VecUChar bufferModel, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromTFLite((char *)bufferModel.ptr, bufferModel.length))};
  END_WRAP
}
CvStatus *Net_ReadNetFromTorch(const char *model, bool isBinary, bool evaluate, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromTorch(model, isBinary, evaluate))};
  END_WRAP
}
CvStatus *Net_ReadNetFromONNX(const char *model, Net *rval) {
  BEGIN_WRAP
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromONNX(model))};
  END_WRAP
}
CvStatus *Net_ReadNetFromONNXBytes(VecUChar model, Net *rval) {
  BEGIN_WRAP
  auto _model = vecuchar_c2cpp(model);
  *rval = {new cv_dnn::Net(cv_dnn::readNetFromONNX(_model))};
  END_WRAP
}

void Net_Close(NetPtr net) { CVD_FREE(net); }

CvStatus *Net_BlobFromImage(
    Mat image,
    Mat blob,
    double scalefactor,
    Size size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth
) {
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::Scalar cm(mean.val1, mean.val2, mean.val3, mean.val4);
  cv_dnn::blobFromImage(*image.ptr, *blob.ptr, scalefactor, sz, cm, swapRB, crop, ddepth);
  END_WRAP
}

CvStatus *Net_BlobFromImages(
    VecMat images,
    Mat blob,
    double scalefactor,
    Size size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth
) {
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::Scalar cm = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
  auto _images = vecmat_c2cpp(images);
  cv_dnn::blobFromImages(_images, *blob.ptr, scalefactor, sz, cm, swapRB, crop, ddepth);
  END_WRAP
}

CvStatus *Net_ImagesFromBlob(Mat blob, VecMat *rval) {
  BEGIN_WRAP
  std::vector<cv::Mat> imgs;
  cv_dnn::imagesFromBlob(*blob.ptr, imgs);
  *rval = vecmat_cpp2c(imgs);
  END_WRAP
}

CvStatus *Net_Empty(Net net, bool *rval) {
  BEGIN_WRAP
  *rval = net.ptr->empty();
  END_WRAP
}

CvStatus *Net_Dump(Net net, char **rval) {
  BEGIN_WRAP
  auto ss = net.ptr->dump();
  *rval = strdup(ss.c_str());
  END_WRAP
}

CvStatus *Net_SetInput(Net net, Mat blob, const char *name) {
  BEGIN_WRAP
  net.ptr->setInput(*blob.ptr, name);
  END_WRAP
}

CvStatus *Net_Forward(Net net, const char *outputName, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(net.ptr->forward(outputName))};
  END_WRAP
}

CvStatus *Net_ForwardLayers(Net net, VecMat *outputBlobs, VecVecChar outBlobNames) {
  BEGIN_WRAP
  std::vector<cv::Mat> blobs;

  auto names = vecvecchar_c2cpp_s(outBlobNames);
  net.ptr->forward(blobs, names);
  *outputBlobs = vecmat_cpp2c(blobs);
  END_WRAP
}

CvStatus *Net_SetPreferableBackend(Net net, int backend) {
  BEGIN_WRAP
  net.ptr->setPreferableBackend(backend);
  END_WRAP
}

CvStatus *Net_SetPreferableTarget(Net net, int target) {
  BEGIN_WRAP
  net.ptr->setPreferableTarget(target);
  END_WRAP
}

CvStatus *Net_GetPerfProfile(Net net, int64_t *rval) {
  BEGIN_WRAP
  std::vector<double> layersTimes;
  *rval = net.ptr->getPerfProfile(layersTimes);
  END_WRAP
}

CvStatus *Net_GetUnconnectedOutLayers(Net net, VecI32 *rval) {
  BEGIN_WRAP
  *rval = vecint_cpp2c(net.ptr->getUnconnectedOutLayers());
  END_WRAP
}

CvStatus *Net_GetLayerNames(Net net, VecVecChar *rval) {
  BEGIN_WRAP
  std::vector<cv::String> cstrs = net.ptr->getLayerNames();
  *rval = vecvecchar_cpp2c_s(cstrs);
  END_WRAP
}

CvStatus *Net_GetInputDetails(Net net, VecF32 *scales, VecI32 *zeropoints) {
  BEGIN_WRAP
  std::vector<float> sc;
  std::vector<int> zp;
  net.ptr->getInputDetails(sc, zp);
  *scales = vecfloat_cpp2c(sc);
  *zeropoints = vecint_cpp2c(zp);
  END_WRAP
}

CvStatus *Net_GetBlobChannel(Mat blob, int imgidx, int chnidx, Mat *rval) {
  BEGIN_WRAP
  size_t w = blob.ptr->size[3];
  size_t h = blob.ptr->size[2];
  *rval = {new cv::Mat(h, w, CV_32F, blob.ptr->ptr<float>(imgidx, chnidx))};
  END_WRAP
}

CvStatus *Net_GetBlobSize(Mat blob, Scalar *rval) {
  BEGIN_WRAP
  *rval = {
      (double)(blob.ptr->size[0]),
      (double)(blob.ptr->size[1]),
      (double)(blob.ptr->size[2]),
      (double)(blob.ptr->size[3]),
  };
  END_WRAP
}

CvStatus *Net_GetLayer(Net net, int layerid, Layer *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv_dnn::Layer>(net.ptr->getLayer(layerid))};
  END_WRAP
}

CvStatus *Layer_InputNameToIndex(Layer layer, const char *name, int *rval) {
  BEGIN_WRAP
  *rval = (*layer.ptr)->inputNameToIndex(name);
  END_WRAP
}

CvStatus *Layer_OutputNameToIndex(Layer layer, const char *name, int *rval) {
  BEGIN_WRAP
  *rval = (*layer.ptr)->outputNameToIndex(name);
  END_WRAP
}

CvStatus *Layer_GetName(Layer layer, char **rval) {
  BEGIN_WRAP
  auto ss = (*layer.ptr)->name;
  *rval = strdup(ss.c_str());
  END_WRAP
}

CvStatus *Layer_GetType(Layer layer, char **rval) {
  BEGIN_WRAP
  auto ss = (*layer.ptr)->type;
  *rval = strdup(ss.c_str());
  END_WRAP
}

void Layer_Close(LayerPtr layer) {
  layer->ptr->reset();
  CVD_FREE(layer);
}

CvStatus *NMSBoxes(
    VecRect bboxes, VecF32 scores, float score_threshold, float nms_threshold, VecI32 *indices
) {
  BEGIN_WRAP
  std::vector<int> v;
  auto _bboxes = vecrect_c2cpp(bboxes);
  auto _scores = vecfloat_c2cpp(scores);
  cv_dnn::NMSBoxes(_bboxes, _scores, score_threshold, nms_threshold, v, 1.f, 0);
  *indices = vecint_cpp2c(v);
  END_WRAP
}

CvStatus *NMSBoxesWithParams(
    VecRect bboxes,
    VecF32 scores,
    const float score_threshold,
    const float nms_threshold,
    VecI32 *indices,
    const float eta,
    const int top_k
) {
  BEGIN_WRAP
  std::vector<int> v;
  auto _bboxes = vecrect_c2cpp(bboxes);
  auto _scores = vecfloat_c2cpp(scores);
  cv_dnn::NMSBoxes(_bboxes, _scores, score_threshold, nms_threshold, v, eta, top_k);
  *indices = vecint_cpp2c(v);
  END_WRAP
}
