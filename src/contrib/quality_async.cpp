#include "quality_async.h"

CvStatus *QualityBRISQUE_compute_async(QualityBRISQUE self, Mat img, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*img.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *QualityBRISQUE_compute_static_async(
    Mat img, char *model_file, char *range_file, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityBRISQUE::compute(*img.ptr, model_file, range_file);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *
QualityBRISQUE_computeFeatures_static_async(Mat img, Mat features, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::quality::QualityBRISQUE::computeFeatures(*img.ptr, *features.ptr);
  callback();
  END_WRAP
}

CvStatus *QualityGMSD_compute_async(QualityGMSD self, Mat cmp, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmp.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *
QualityGMSD_compute_static_async(Mat ref, Mat cmp, Mat qualityMap, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityGMSD::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *QualityMSE_compute_async(QualityMSE self, Mat cmpImgs, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmpImgs.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *QualityMSE_compute_static_async(Mat ref, Mat cmp, Mat qualityMap, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualityMSE::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *QualityPSNR_compute_async(QualityPSNR self, Mat cmp, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmp.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *QualityPSNR_compute_static_async(
    Mat ref, Mat cmp, double maxPixelValue, Mat qualityMap, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Scalar r =
      cv::quality::QualityPSNR::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr, maxPixelValue);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *QualitySSIM_compute_async(QualitySSIM self, Mat cmp, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = (*self.ptr)->compute(*cmp.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}

CvStatus *
QualitySSIM_compute_static_async(Mat ref, Mat cmp, Mat qualityMap, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar r = cv::quality::QualitySSIM::compute(*ref.ptr, *cmp.ptr, *qualityMap.ptr);
  callback(new Scalar{r.val[0], r.val[1], r.val[2], r.val[3]});
  END_WRAP
}
