#include "wechat_qrcode.h"
#include "core/core.h"
#include "core/vec.hpp"
#include <vector>

CvStatus *WeChatQRCode_New(WeChatQRCode *qrcode)
{
  BEGIN_WRAP
  *qrcode = {new cv::wechat_qrcode::WeChatQRCode()};
  END_WRAP
}
CvStatus *WeChatQRCode_NewWithParams(const char *detector_prototxt_path,
                                     const char *detector_caffe_model_path,
                                     const char *super_resolution_prototxt_path,
                                     const char *super_resolution_caffe_model_path, WeChatQRCode *qrcode)
{
  BEGIN_WRAP
  *qrcode = {new cv::wechat_qrcode::WeChatQRCode(detector_prototxt_path, detector_caffe_model_path,
                                                 super_resolution_prototxt_path,
                                                 super_resolution_caffe_model_path)};
  END_WRAP
}
void WeChatQRCode_Close(WeChatQRCodePtr self) { CVD_FREE(self); }

CvStatus *WeChatQRCode_DetectAndDecode(WeChatQRCode *self, Mat img, VecMat *points, VecVecChar *rval)
{
  BEGIN_WRAP
  std::vector<cv::Mat> pts;

  auto strings = self->ptr->detectAndDecode(*img.ptr, pts);
  *points = vecmat_cpp2c(pts);

  std::vector<std::vector<char>> cstrings;
  cstrings.reserve(strings.size());
  for (int i = 0; i < strings.size(); i++) {
    auto s = strings.at(i);
    cstrings.push_back(std::vector<char>(s.begin(), s.end()));
  }
  *rval = vecvecchar_cpp2c(cstrings);

  END_WRAP
}
CvStatus *WeChatQRCode_GetScaleFactor(WeChatQRCode *self, float *rval)
{
  BEGIN_WRAP
  *rval = self->ptr->getScaleFactor();
  END_WRAP
}
CvStatus *WeChatQRCode_SetScaleFactor(WeChatQRCode *self, float scale_factor)
{
  BEGIN_WRAP
  self->ptr->setScaleFactor(scale_factor);
  END_WRAP
}
