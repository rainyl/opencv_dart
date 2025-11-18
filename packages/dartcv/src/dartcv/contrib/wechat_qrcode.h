/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef WECHAT_QRCODE_H
#define WECHAT_QRCODE_H

#include "dartcv/core/types.h"

#ifdef __cplusplus
#include <opencv2/wechat_qrcode.hpp>
extern "C" {
#endif

// Main Content Start
#ifdef __cplusplus
CVD_TYPEDEF(cv::wechat_qrcode::WeChatQRCode, WeChatQRCode);
#else
CVD_TYPEDEF(void, WeChatQRCode);
#endif

CvStatus* cv_wechat_qrcode_WeChatQRCode_create(WeChatQRCode* qrcode);
CvStatus* cv_wechat_qrcode_WeChatQRCode_create_1(
    const char* detector_prototxt_path,
    const char* detector_caffe_model_path,
    const char* super_resolution_prototxt_path,
    const char* super_resolution_caffe_model_path,
    WeChatQRCode* qrcode,
    CvCallback_0 callback
);
void cv_wechat_qrcode_WeChatQRCode_close(WeChatQRCodePtr self);
CvStatus* cv_wechat_qrcode_WeChatQRCode_detectAndDecode(
    WeChatQRCode self, Mat img, VecMat* out_points, VecVecChar* rval, CvCallback_0 callback
);
float cv_wechat_qrcode_WeChatQRCode_getScaleFactor(WeChatQRCode self);
void cv_wechat_qrcode_WeChatQRCode_setScaleFactor(WeChatQRCode self, float scale_factor);

// Main Content End

#ifdef __cplusplus
}
#endif

#endif
