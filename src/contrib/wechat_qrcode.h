/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
#ifndef WECHAT_QRCODE_H
#define WECHAT_QRCODE_H

#include "core/core.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/wechat_qrcode.hpp>
extern "C" {
#endif

// Main Content Start
#ifdef __cplusplus
CVD_TYPEDEF(cv::wechat_qrcode::WeChatQRCode, WeChatQRCode);
#else
CVD_TYPEDEF(void, WeChatQRCode);
#endif

CvStatus *WeChatQRCode_New(WeChatQRCode *qrcode);
CvStatus *WeChatQRCode_NewWithParams(const char *detector_prototxt_path,
                                     const char *detector_caffe_model_path,
                                     const char *super_resolution_prototxt_path,
                                     const char *super_resolution_caffe_model_path, WeChatQRCode *qrcode);
void      WeChatQRCode_Close(WeChatQRCodePtr self);
CvStatus *WeChatQRCode_DetectAndDecode(WeChatQRCode *self, Mat img, VecMat *points, VecVecChar *rval);
CvStatus *WeChatQRCode_GetScaleFactor(WeChatQRCode *self, float *rval);
CvStatus *WeChatQRCode_SetScaleFactor(WeChatQRCode *self, float scale_factor);

// Main Content End

#ifdef __cplusplus
}
#endif

#endif
