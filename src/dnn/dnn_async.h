#ifndef CVD_DNN_ASYNC_H_
#define CVD_DNN_ASYNC_H_

#include "dnn.h"
#include "core/types.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/dnn.hpp>
extern "C" {
#endif

// Asynchronous functions for Net
CvStatus *Net_Create_Async(CvCallback_1 callback);
CvStatus *Net_FromNet_Async(Net net, CvCallback_1 callback);
CvStatus *Net_ReadNet_Async(const char *model, const char *config, const char *framework, CvCallback_1 callback);
CvStatus *Net_ReadNetBytes_Async(const char *framework, VecUChar model, VecUChar config, CvCallback_1 callback);
CvStatus *Net_ReadNetFromCaffe_Async(const char *prototxt, const char *caffeModel, CvCallback_1 callback);
CvStatus *Net_ReadNetFromCaffeBytes_Async(VecUChar prototxt, VecUChar caffeModel, CvCallback_1 callback);
CvStatus *Net_ReadNetFromTensorflow_Async(const char *model, const char *config, CvCallback_1 callback);
CvStatus *Net_ReadNetFromTensorflowBytes_Async(VecUChar model, VecUChar config, CvCallback_1 callback);
CvStatus *Net_ReadNetFromTFLite_Async(const char *model, CvCallback_1 callback);
CvStatus *Net_ReadNetFromTFLiteBytes_Async(VecUChar bufferModel, CvCallback_1 callback);
CvStatus *Net_ReadNetFromTorch_Async(const char *model, bool isBinary, bool evaluate, CvCallback_1 callback);
CvStatus *Net_ReadNetFromONNX_Async(const char *model, CvCallback_1 callback);
CvStatus *Net_ReadNetFromONNXBytes_Async(VecUChar model, CvCallback_1 callback);
void Net_Close_Async(NetPtr net, CvCallback_0 callback);
CvStatus *Net_BlobFromImage_Async(Mat image, double scalefactor, Size size, Scalar mean, bool swapRB, bool crop, int ddepth, CvCallback_1 callback);
CvStatus *Net_BlobFromImages_Async(VecMat images, double scalefactor, Size size, Scalar mean, bool swapRB, bool crop, int ddepth, CvCallback_1 callback);
CvStatus *Net_ImagesFromBlob_Async(Mat blob, CvCallback_1 callback);
CvStatus *Net_Empty_Async(Net net, CvCallback_1 callback);
CvStatus *Net_Dump_Async(Net net, CvCallback_1 callback);
CvStatus *Net_SetInput_Async(Net net, Mat blob, const char *name, CvCallback_0 callback);
CvStatus *Net_Forward_Async(Net net, const char *outputName, CvCallback_1 callback);
CvStatus *Net_ForwardLayers_Async(Net net, VecVecChar outBlobNames, CvCallback_1 callback);
CvStatus *Net_SetPreferableBackend_Async(Net net, int backend, CvCallback_0 callback);
CvStatus *Net_SetPreferableTarget_Async(Net net, int target, CvCallback_0 callback);
CvStatus *Net_GetPerfProfile_Async(Net net, CvCallback_1 callback);
CvStatus *Net_GetUnconnectedOutLayers_Async(Net net, CvCallback_1 callback);
CvStatus *Net_GetLayerNames_Async(Net net, CvCallback_1 callback);
CvStatus *Net_GetInputDetails_Async(Net net, CvCallback_2 callback);
CvStatus *Net_GetBlobChannel_Async(Mat blob, int imgidx, int chnidx, CvCallback_1 callback);
CvStatus *Net_GetBlobSize_Async(Mat blob, CvCallback_1 callback);
CvStatus *Net_GetLayer_Async(Net net, int layerid, CvCallback_1 callback);
CvStatus *Layer_InputNameToIndex_Async(Layer layer, const char *name, CvCallback_1 callback);
CvStatus *Layer_OutputNameToIndex_Async(Layer layer, const char *name, CvCallback_1 callback);
CvStatus *Layer_GetName_Async(Layer layer, CvCallback_1 callback);
CvStatus *Layer_GetType_Async(Layer layer, CvCallback_1 callback);
void Layer_Close_Async(LayerPtr layer, CvCallback_0 callback);
CvStatus *NMSBoxes_Async(VecRect bboxes, VecF32 scores, float score_threshold, float nms_threshold, CvCallback_1 callback);
CvStatus *NMSBoxesWithParams_Async(VecRect bboxes, VecF32 scores, const float score_threshold, const float nms_threshold, const float eta, const int top_k, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_DNN_ASYNC_H_
