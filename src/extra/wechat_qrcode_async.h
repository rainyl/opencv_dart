#pragma once
#include "core/types.h"
#include "wechat_qrcode.h"

#ifdef __cplusplus
extern "C"
{
#endif

    CvStatus *WeChatQRCode_New_Async(CvCallback_1 callback);
    CvStatus *WeChatQRCode_NewWithParams_Async(const char *detector_prototxt_path, const char *detector_caffe_model_path, const char *super_resolution_prototxt_path, const char *super_resolution_caffe_model_path, CvCallback_1 callback);
    CvStatus *WeChatQRCode_DetectAndDecode_Async(WeChatQRCode *self, Mat img, CvCallback_2 callback);
    CvStatus *WeChatQRCode_GetScaleFactor_Async(WeChatQRCode *self, CvCallback_1 callback);
    CvStatus *WeChatQRCode_SetScaleFactor_Async(WeChatQRCode *self, float scale_factor, CvCallback_0 callback);

#ifdef __cplusplus
}
#endif
