#include "dnn_async.h"
#include "core/types.h"
#include "core/vec.hpp"

// Asynchronous functions for Net
CvStatus *Net_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net()});
  END_WRAP
}

CvStatus *Net_FromNet_Async(Net net, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(*net.ptr)});
  END_WRAP
}

CvStatus *Net_ReadNet_Async(
    const char *model, const char *config, const char *framework, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(cv_dnn::readNet(model, config, framework))});
  END_WRAP
}

CvStatus *Net_ReadNetBytes_Async(
    const char *framework, VecUChar model, VecUChar config, CvCallback_1 callback
) {
  BEGIN_WRAP
  auto _model = vecuchar_c2cpp(model);
  auto _config = vecuchar_c2cpp(config);
  callback(new Net{new cv_dnn::Net(cv_dnn::readNet(framework, _model, _config))});
  END_WRAP
}

CvStatus *
Net_ReadNetFromCaffe_Async(const char *prototxt, const char *caffeModel, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromCaffe(prototxt, caffeModel))});
  END_WRAP
}

CvStatus *
Net_ReadNetFromCaffeBytes_Async(VecUChar prototxt, VecUChar caffeModel, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _prototxt = vecuchar_c2cpp(prototxt);
  auto _Model = vecuchar_c2cpp(caffeModel);
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromCaffe(_prototxt, _Model))});
  END_WRAP
}

CvStatus *
Net_ReadNetFromTensorflow_Async(const char *model, const char *config, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromTensorflow(model, config))});
  END_WRAP
}

CvStatus *
Net_ReadNetFromTensorflowBytes_Async(VecUChar model, VecUChar config, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _model = vecuchar_c2cpp(model);
  auto _config = vecuchar_c2cpp(config);
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromTensorflow(_model, _config))});
  END_WRAP
}

CvStatus *Net_ReadNetFromTFLite_Async(const char *model, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromTFLite(model))});
  END_WRAP
}

CvStatus *Net_ReadNetFromTFLiteBytes_Async(VecUChar bufferModel, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _Model = vecuchar_c2cpp(bufferModel);
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromTFLite(_Model))});
  END_WRAP
}

CvStatus *
Net_ReadNetFromTorch_Async(const char *model, bool isBinary, bool evaluate, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromTorch(model, isBinary, evaluate))});
  END_WRAP
}

CvStatus *Net_ReadNetFromONNX_Async(const char *model, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromONNX(model))});
  END_WRAP
}

CvStatus *Net_ReadNetFromONNXBytes_Async(VecUChar model, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _model = vecuchar_c2cpp(model);
  callback(new Net{new cv_dnn::Net(cv_dnn::readNetFromONNX(_model))});
  END_WRAP
}

void Net_Close_Async(NetPtr net, CvCallback_0 callback) {
  CVD_FREE(net);
  callback();
}

CvStatus *Net_BlobFromImage_Async(
    Mat image,
    double scalefactor,
    Size size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::Scalar cm(mean.val1, mean.val2, mean.val3, mean.val4);
  Mat *blob = new Mat{new cv::Mat()};
  cv_dnn::blobFromImage(*image.ptr, *blob->ptr, scalefactor, sz, cm, swapRB, crop, ddepth);
  callback(blob);
  END_WRAP
}

CvStatus *Net_BlobFromImages_Async(
    VecMat images,
    double scalefactor,
    Size size,
    Scalar mean,
    bool swapRB,
    bool crop,
    int ddepth,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Size sz(size.width, size.height);
  cv::Scalar cm = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
  cv::Mat blob;
  auto _images = vecmat_c2cpp(images);
  cv_dnn::blobFromImages(_images, blob, scalefactor, sz, cm, swapRB, crop, ddepth);
  callback(new Mat{new cv::Mat(blob)});
  END_WRAP
}

CvStatus *Net_ImagesFromBlob_Async(Mat blob, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::Mat> imgs;
  cv_dnn::imagesFromBlob(*blob.ptr, imgs);
  callback(vecmat_cpp2c_p(imgs));
  END_WRAP
}

CvStatus *Net_Empty_Async(Net net, CvCallback_1 callback) {
  BEGIN_WRAP
  bool rval = net.ptr->empty();
  callback(new bool(rval));
  END_WRAP
}

CvStatus *Net_Dump_Async(Net net, CvCallback_1 callback) {
  BEGIN_WRAP
  auto ss = net.ptr->dump();
  callback(new char *(strdup(ss.c_str())));
  END_WRAP
}

CvStatus *Net_SetInput_Async(Net net, Mat blob, const char *name, CvCallback_0 callback) {
  BEGIN_WRAP
  net.ptr->setInput(*blob.ptr, name);
  callback();
  END_WRAP
}

CvStatus *Net_Forward_Async(Net net, const char *outputName, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(net.ptr->forward(outputName))});
  END_WRAP
}

CvStatus *Net_ForwardLayers_Async(Net net, VecVecChar outBlobNames, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::Mat> blobs;
  std::vector<cv::String> names = vecvecchar_c2cpp_s(outBlobNames);
  net.ptr->forward(blobs, names);
  callback(vecmat_cpp2c_p(blobs));
  END_WRAP
}

CvStatus *Net_SetPreferableBackend_Async(Net net, int backend, CvCallback_0 callback) {
  BEGIN_WRAP
  net.ptr->setPreferableBackend(backend);
  callback();
  END_WRAP
}

CvStatus *Net_SetPreferableTarget_Async(Net net, int target, CvCallback_0 callback) {
  BEGIN_WRAP
  net.ptr->setPreferableTarget(target);
  callback();
  END_WRAP
}

CvStatus *Net_GetPerfProfile_Async(Net net, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<double> layersTimes;
  int64_t rval = net.ptr->getPerfProfile(layersTimes);
  callback(new int64_t(rval));
  END_WRAP
}

CvStatus *Net_GetUnconnectedOutLayers_Async(Net net, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<int> layers = net.ptr->getUnconnectedOutLayers();
  callback(vecint_cpp2c_p(layers));
  END_WRAP
}

CvStatus *Net_GetLayerNames_Async(Net net, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::String> cstrs = net.ptr->getLayerNames();
  callback(vecvecchar_cpp2c_s_p(cstrs));
  END_WRAP
}

CvStatus *Net_GetInputDetails_Async(Net net, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<float> sc;
  std::vector<int> zp;
  net.ptr->getInputDetails(sc, zp);
  callback(vecfloat_cpp2c_p(sc), vecint_cpp2c_p(zp));
  END_WRAP
}

CvStatus *Net_GetBlobChannel_Async(Mat blob, int imgidx, int chnidx, CvCallback_1 callback) {
  BEGIN_WRAP
  size_t w = blob.ptr->size[3];
  size_t h = blob.ptr->size[2];
  callback(new Mat{new cv::Mat(h, w, CV_32F, blob.ptr->ptr<float>(imgidx, chnidx))});
  END_WRAP
}

CvStatus *Net_GetBlobSize_Async(Mat blob, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Scalar{
      (double)(blob.ptr->size[0]),
      (double)(blob.ptr->size[1]),
      (double)(blob.ptr->size[2]),
      (double)(blob.ptr->size[3])
  });
  END_WRAP
}

CvStatus *Net_GetLayer_Async(Net net, int layerid, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Layer{new cv::Ptr<cv_dnn::Layer>(net.ptr->getLayer(layerid))});
  END_WRAP
}

CvStatus *Layer_InputNameToIndex_Async(Layer layer, const char *name, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = (*layer.ptr)->inputNameToIndex(name);
  callback(new int(rval));
  END_WRAP
}

CvStatus *Layer_OutputNameToIndex_Async(Layer layer, const char *name, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = (*layer.ptr)->outputNameToIndex(name);
  callback(new int(rval));
  END_WRAP
}

CvStatus *Layer_GetName_Async(Layer layer, CvCallback_1 callback) {
  BEGIN_WRAP
  auto ss = (*layer.ptr)->name;
  callback(new char *(strdup(ss.c_str())));
  END_WRAP
}

CvStatus *Layer_GetType_Async(Layer layer, CvCallback_1 callback) {
  BEGIN_WRAP
  auto ss = (*layer.ptr)->type;
  callback(new char *(strdup(ss.c_str())));
  END_WRAP
}

void Layer_Close_Async(LayerPtr layer, CvCallback_0 callback) {
  layer->ptr->reset();
  CVD_FREE(layer);
  callback();
}

CvStatus *NMSBoxes_Async(
    VecRect bboxes, VecF32 scores, float score_threshold, float nms_threshold, CvCallback_1 callback
) {
  BEGIN_WRAP
  std::vector<int> v;
  auto _bboxes = vecrect_c2cpp(bboxes);
  auto _scores = vecfloat_c2cpp(scores);
  cv_dnn::NMSBoxes(_bboxes, _scores, score_threshold, nms_threshold, v, 1.f, 0);
  callback(vecint_cpp2c_p(v));
  END_WRAP
}

CvStatus *NMSBoxesWithParams_Async(
    VecRect bboxes,
    VecF32 scores,
    const float score_threshold,
    const float nms_threshold,
    const float eta,
    const int top_k,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  std::vector<int> v;
  auto _bboxes = vecrect_c2cpp(bboxes);
  auto _scores = vecfloat_c2cpp(scores);
  cv_dnn::NMSBoxes(_bboxes, _scores, score_threshold, nms_threshold, v, eta, top_k);
  callback(vecint_cpp2c_p(v));
  END_WRAP
}
