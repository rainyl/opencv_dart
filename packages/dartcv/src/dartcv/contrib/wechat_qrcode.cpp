//
// Created by Rainyl.
// Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
//

#include "dartcv/contrib/wechat_qrcode.h"
#include "dartcv/core/vec.hpp"
#include <vector>
#include "dartcv/core/handle.hpp"

CvStatus* cv_wechat_qrcode_WeChatQRCode_create(WeChatQRCode* qrcode) {
    BEGIN_WRAP
    CVD_SET(qrcode, new cv::wechat_qrcode::WeChatQRCode());
    END_WRAP
}

CvStatus* cv_wechat_qrcode_WeChatQRCode_create_1(
    const char* detector_prototxt_path,
    const char* detector_caffe_model_path,
    const char* super_resolution_prototxt_path,
    const char* super_resolution_caffe_model_path,
    WeChatQRCode* qrcode,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(), [=]() -> CvStatus* {
        BEGIN_WRAP
        CVD_SET(qrcode, new cv::wechat_qrcode::WeChatQRCode(
            detector_prototxt_path,
            detector_caffe_model_path,
            super_resolution_prototxt_path,
            super_resolution_caffe_model_path
        ));
        END_WRAP
    });
}

void cv_wechat_qrcode_WeChatQRCode_close(WeChatQRCodePtr self) {
    CVD_FREE(self);
}

CvStatus* cv_wechat_qrcode_WeChatQRCode_detectAndDecode(
    WeChatQRCode self, Mat img, VecMat* out_points, VecVecChar* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, img), [=]() -> CvStatus* {
        BEGIN_WRAP
        auto strings = (*self.ptr)->detectAndDecode(CVDEREF(img), CVDEREF_P(out_points));
        CVD_SET(rval, vecstr_2_vecvecchar(strings));
        END_WRAP
    });
}

float cv_wechat_qrcode_WeChatQRCode_getScaleFactor(WeChatQRCode self) {
    return (*self.ptr)->getScaleFactor();
}

void cv_wechat_qrcode_WeChatQRCode_setScaleFactor(WeChatQRCode self, float scale_factor) {
    (*self.ptr)->setScaleFactor(scale_factor);
}
