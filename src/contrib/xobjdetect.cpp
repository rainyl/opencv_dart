#include "xobjdetect.h"
#include "core/core.h"
#include "core/vec.hpp"

CvStatus *WBDetector_Create(PtrWBDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::xobjdetect::WBDetector>(cv::xobjdetect::WBDetector::create())};
  END_WRAP
}
void WBDetector_Close(PtrWBDetectorPtr self) {
  self->ptr = nullptr;
  CVD_FREE(self);
}
CvStatus *WBDetector_Detect(
    PtrWBDetector *self, Mat img, CVD_OUT VecRect *bbox, CVD_OUT VecF64 *confidences
) {

  BEGIN_WRAP
  std::vector<cv::Rect> _bboxes;
  std::vector<double> _confidences;
  (*self->ptr)->detect(*img.ptr, _bboxes, _confidences);
  *bbox = vecrect_cpp2c(_bboxes);
  *confidences = vecdouble_cpp2c(_confidences);
  END_WRAP
}
CvStatus *WBDetector_Train(PtrWBDetector *self, char *pos_samples, char *neg_imgs) {
  BEGIN_WRAP(*self->ptr)->train(pos_samples, neg_imgs);
  END_WRAP
}
CvStatus *WBDetector_Read(PtrWBDetector *self, char *filename) {
  BEGIN_WRAP
  auto fs = cv::FileStorage(filename, cv::FileStorage::READ);
  (*self->ptr)->read(fs.root());
  END_WRAP
}
CvStatus *WBDetector_Write(PtrWBDetector *self, char *filename) {
  BEGIN_WRAP
  auto fs = cv::FileStorage(filename, cv::FileStorage::WRITE);
  (*self->ptr)->write(fs);
  END_WRAP
}
