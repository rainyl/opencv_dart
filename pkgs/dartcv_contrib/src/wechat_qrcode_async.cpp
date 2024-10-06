#include "wechat_qrcode_async.h"
#include "core/types.h"
#include "core/vec.hpp"

CvStatus *WeChatQRCode_New_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  auto qrcode = new cv::wechat_qrcode::WeChatQRCode();
  callback(new WeChatQRCode{qrcode});
  END_WRAP
}

CvStatus *WeChatQRCode_NewWithParams_Async(
    const char *detector_prototxt_path,
    const char *detector_caffe_model_path,
    const char *super_resolution_prototxt_path,
    const char *super_resolution_caffe_model_path,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  auto qrcode = new cv::wechat_qrcode::WeChatQRCode(
      detector_prototxt_path,
      detector_caffe_model_path,
      super_resolution_prototxt_path,
      super_resolution_caffe_model_path
  );
  callback(new WeChatQRCode{qrcode});
  END_WRAP
}

CvStatus *WeChatQRCode_DetectAndDecode_Async(WeChatQRCode *self, Mat img, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<cv::Mat> points;
  auto strings = self->ptr->detectAndDecode(*img.ptr, points);
  std::vector<std::vector<char>> cstrings;
  cstrings.reserve(strings.size());
  for (const auto &s : strings) { cstrings.push_back(std::vector<char>(s.begin(), s.end())); }
  callback(vecvecchar_cpp2c_p(cstrings), vecmat_cpp2c_p(points));
  END_WRAP
}

CvStatus *WeChatQRCode_GetScaleFactor_Async(WeChatQRCode *self, CvCallback_1 callback) {
  BEGIN_WRAP
  float value = self->ptr->getScaleFactor();
  callback(&value);
  END_WRAP
}

CvStatus *
WeChatQRCode_SetScaleFactor_Async(WeChatQRCode *self, float scale_factor, CvCallback_0 callback) {
  BEGIN_WRAP
  self->ptr->setScaleFactor(scale_factor);
  callback();
  END_WRAP
}
