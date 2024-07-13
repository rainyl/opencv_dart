/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "photo.h"
#include "core/vec.hpp"

CvStatus *ColorChange(Mat src, Mat mask, Mat dst, float red_mul, float green_mul, float blue_mul) {
  BEGIN_WRAP
  cv::colorChange(*src.ptr, *mask.ptr, *dst.ptr, red_mul, green_mul, blue_mul);
  END_WRAP
}

CvStatus *SeamlessClone(Mat src, Mat dst, Mat mask, Point p, Mat blend, int flags) {
  BEGIN_WRAP
  cv::seamlessClone(*src.ptr, *dst.ptr, *mask.ptr, cv::Point(p.x, p.y), *blend.ptr, flags);
  END_WRAP
}

CvStatus *IlluminationChange(Mat src, Mat mask, Mat dst, float alpha, float beta) {
  BEGIN_WRAP
  cv::illuminationChange(*src.ptr, *mask.ptr, *dst.ptr, alpha, beta);
  END_WRAP
}

CvStatus *TextureFlattening(
    Mat src, Mat mask, Mat dst, float low_threshold, float high_threshold, int kernel_size
) {
  BEGIN_WRAP
  cv::textureFlattening(*src.ptr, *mask.ptr, *dst.ptr, low_threshold, high_threshold, kernel_size);
  END_WRAP
}

CvStatus *FastNlMeansDenoisingColoredMulti(
    VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize
) {
  BEGIN_WRAP
  auto _src = vecmat_c2cpp(src);
  cv::fastNlMeansDenoisingColoredMulti(_src, *dst.ptr, imgToDenoiseIndex, temporalWindowSize);
  END_WRAP
}
CvStatus *FastNlMeansDenoisingColoredMultiWithParams(
    VecMat src,
    Mat dst,
    int imgToDenoiseIndex,
    int temporalWindowSize,
    float h,
    float hColor,
    int templateWindowSize,
    int searchWindowSize
) {
  BEGIN_WRAP
  auto _src = vecmat_c2cpp(src);
  cv::fastNlMeansDenoisingColoredMulti(
      _src,
      *dst.ptr,
      imgToDenoiseIndex,
      temporalWindowSize,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize
  );
  END_WRAP
}
CvStatus *FastNlMeansDenoising(Mat src, Mat dst) {
  BEGIN_WRAP
  cv::fastNlMeansDenoising(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *FastNlMeansDenoisingWithParams(
    Mat src, Mat dst, float h, int templateWindowSize, int searchWindowSize
) {
  BEGIN_WRAP
  cv::fastNlMeansDenoising(*src.ptr, *dst.ptr, h, templateWindowSize, searchWindowSize);
  END_WRAP
}
CvStatus *FastNlMeansDenoisingColored(Mat src, Mat dst) {
  BEGIN_WRAP
  cv::fastNlMeansDenoisingColored(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *FastNlMeansDenoisingColoredWithParams(
    Mat src, Mat dst, float h, float hColor, int templateWindowSize, int searchWindowSize
) {
  BEGIN_WRAP
  cv::fastNlMeansDenoisingColored(
      *src.ptr, *dst.ptr, h, hColor, templateWindowSize, searchWindowSize
  );
  END_WRAP
}

CvStatus *MergeMertens_Create(MergeMertens *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::MergeMertens>(cv::createMergeMertens())};
  END_WRAP
}
CvStatus *MergeMertens_CreateWithParams(
    float contrast_weight, float saturation_weight, float exposure_weight, MergeMertens *rval
) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::MergeMertens>(
      cv::createMergeMertens(contrast_weight, saturation_weight, exposure_weight)
  )};
  END_WRAP
}
CvStatus *MergeMertens_Process(MergeMertens b, VecMat src, Mat dst) {
  BEGIN_WRAP
  auto _src = vecmat_c2cpp(src);
  (*b.ptr)->process(_src, *dst.ptr);
  END_WRAP
}
void MergeMertens_Close(MergeMertensPtr b) {
  b->ptr->reset();
  CVD_FREE(b);
}

CvStatus *AlignMTB_Create(AlignMTB *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::AlignMTB>(cv::createAlignMTB())};
  END_WRAP
}
CvStatus *AlignMTB_CreateWithParams(int max_bits, int exclude_range, bool cut, AlignMTB *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::AlignMTB>(cv::createAlignMTB(max_bits, exclude_range, cut))};
  END_WRAP
}
CvStatus *AlignMTB_Process(AlignMTB b, VecMat src, VecMat *dst) {
  BEGIN_WRAP
  auto vec = std::vector<cv::Mat>();
  auto _src = vecmat_c2cpp(src);
  (*b.ptr)->process(_src, vec);
  *dst = vecmat_cpp2c(vec);
  END_WRAP
}
void AlignMTB_Close(AlignMTBPtr b) {
  b->ptr->reset();
  CVD_FREE(b);
}

CvStatus *DetailEnhance(Mat src, Mat dst, float sigma_s, float sigma_r) {
  BEGIN_WRAP
  cv::detailEnhance(*src.ptr, *dst.ptr, sigma_s, sigma_r);
  END_WRAP
}
CvStatus *EdgePreservingFilter(Mat src, Mat dst, int filter, float sigma_s, float sigma_r) {
  BEGIN_WRAP
  cv::edgePreservingFilter(*src.ptr, *dst.ptr, filter, sigma_s, sigma_r);
  END_WRAP
}
CvStatus *
PencilSketch(Mat src, Mat dst1, Mat dst2, float sigma_s, float sigma_r, float shade_factor) {
  BEGIN_WRAP
  cv::pencilSketch(*src.ptr, *dst1.ptr, *dst2.ptr, sigma_s, sigma_r, shade_factor);
  END_WRAP
}
CvStatus *Stylization(Mat src, Mat dst, float sigma_s, float sigma_r) {
  BEGIN_WRAP
  cv::stylization(*src.ptr, *dst.ptr, sigma_s, sigma_r);
  END_WRAP
}

CvStatus *PhotoInpaint(Mat src, Mat mask, Mat dst, float inpaint_radius, int algorithm_type) {
  BEGIN_WRAP
  cv::inpaint(*src.ptr, *mask.ptr, *dst.ptr, inpaint_radius, algorithm_type);
  END_WRAP
}
