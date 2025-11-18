#include "dartcv/contrib/wechat_qrcode.h"
#include "dartcv/core/vec.hpp"
#include <vector>

CvStatus* cv_wechat_qrcode_WeChatQRCode_create(WeChatQRCode* qrcode) {
    BEGIN_WRAP
    qrcode->ptr = new cv::wechat_qrcode::WeChatQRCode();
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
    BEGIN_WRAP
    qrcode->ptr = new cv::wechat_qrcode::WeChatQRCode(
        detector_prototxt_path,
        detector_caffe_model_path,
        super_resolution_prototxt_path,
        super_resolution_caffe_model_path
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_wechat_qrcode_WeChatQRCode_close(WeChatQRCodePtr self) {
    CVD_FREE(self);
}

CvStatus* cv_wechat_qrcode_WeChatQRCode_detectAndDecode(
    WeChatQRCode self, Mat img, VecMat* out_points, VecVecChar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto strings = self.ptr->detectAndDecode(*img.ptr, CVDEREF_P(out_points));
    rval->ptr = vecstr_2_vecvecchar(strings);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

float cv_wechat_qrcode_WeChatQRCode_getScaleFactor(WeChatQRCode self) {
    return self.ptr->getScaleFactor();
}

void cv_wechat_qrcode_WeChatQRCode_setScaleFactor(WeChatQRCode self, float scale_factor) {
    self.ptr->setScaleFactor(scale_factor);
}
