#include "quality.h"
#include "core/types.h"
#include "opencv2/quality/qualitybrisque.hpp"

CvStatus *QualityBRISQUE_create(char *model_file, char *range_file, QualityBRISQUE *rval) {
  BEGIN_WRAP
  rval->ptr = new cv::Ptr<cv::quality::QualityBRISQUE>(
      cv::quality::QualityBRISQUE::create(model_file, range_file)
  );
  END_WRAP
}

void QualityBRISQUE_close(QualityBRISQUEPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *QualityBRISQUE_compute(QualityBRISQUE self, Mat img, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*img.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualityBRISQUE_compute_static(Mat img, char *model_file, char *range_file, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityBRISQUE::compute(*img.ptr, model_file, range_file);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualityBRISQUE_computeFeatures_static(Mat img, Mat features) {
  BEGIN_WRAP
  cv::quality::QualityBRISQUE::computeFeatures(*img.ptr, *features.ptr);
  END_WRAP
}

CvStatus *QualityGMSD_create(Mat ref, QualityGMSD *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::quality::QualityGMSD>(cv::quality::QualityGMSD::create(*ref.ptr))};
  END_WRAP
}

void QualityGMSD_close(QualityGMSDPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *QualityGMSD_compute(QualityGMSD self, Mat cmp, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmp.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualityGMSD_compute_static(Mat ref, Mat cmp, Mat qualityMap, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityGMSD::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualityMSE_create(Mat ref, QualityMSE *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::quality::QualityMSE>(cv::quality::QualityMSE::create(*ref.ptr))};
  END_WRAP
}

void QualityMSE_close(QualityMSEPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *QualityMSE_compute(QualityMSE self, Mat cmpImgs, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmpImgs.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualityMSE_compute_static(Mat ref, Mat cmp, Mat qualityMap, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityMSE::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualityPSNR_create(Mat ref, double maxPixelValue, QualityPSNR *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::quality::QualityPSNR>(
      cv::quality::QualityPSNR::create(*ref.ptr, maxPixelValue)
  )};
  END_WRAP
}

void QualityPSNR_close(QualityPSNRPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *QualityPSNR_compute(QualityPSNR self, Mat cmp, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmp.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *
QualityPSNR_compute_static(Mat ref, Mat cmp, double maxPixelValue, Mat qualityMap, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityPSNR::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr, maxPixelValue);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

double QualityPSNR_getMaxPixelValue(QualityPSNR self) { return (*self.ptr)->getMaxPixelValue(); }

void QualityPSNR_setMaxPixelValue(QualityPSNR self, double maxPixelValue) {
  (*self.ptr)->setMaxPixelValue(maxPixelValue);
}

CvStatus *QualitySSIM_create(Mat ref, QualitySSIM *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::quality::QualitySSIM>(cv::quality::QualitySSIM::create(*ref.ptr))};
  END_WRAP
}

void QualitySSIM_close(QualitySSIMPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *QualitySSIM_compute(QualitySSIM self, Mat cmp, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmp.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}

CvStatus *QualitySSIM_compute_static(Mat ref, Mat cmp, Mat qualityMap, Scalar *rval) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualitySSIM::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr);
  *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
  END_WRAP
}
