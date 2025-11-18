/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_PHOTO_H_
#define CVD_PHOTO_H_

#ifdef __cplusplus
#include <opencv2/photo.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"

#ifdef __cplusplus
/// see : https://docs.opencv.org/3.4/d7/dd6/classcv_1_1MergeMertens.html
CVD_TYPEDEF(cv::Ptr<cv::MergeMertens>, MergeMertens);
/// see : https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
CVD_TYPEDEF(cv::Ptr<cv::AlignMTB>, AlignMTB);
#else
CVD_TYPEDEF(void, MergeMertens);
CVD_TYPEDEF(void, AlignMTB);
#endif

CvStatus* cv_colorChange(
    Mat src,
    Mat mask,
    Mat dst,
    float red_mul,
    float green_mul,
    float blue_mul,
    CvCallback_0 callback
);

CvStatus* cv_seamlessClone(
    Mat src, Mat dst, Mat mask, CvPoint p, Mat blend, int flags, CvCallback_0 callback
);

CvStatus* cv_illuminationChange(
    Mat src, Mat mask, Mat dst, float alpha, float beta, CvCallback_0 callback
);

CvStatus* cv_textureFlattening(
    Mat src,
    Mat mask,
    Mat dst,
    float low_threshold,
    float high_threshold,
    int kernel_size,
    CvCallback_0 callback
);

CvStatus* cv_fastNlMeansDenoisingColoredMulti(
    VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize, CvCallback_0 callback
);
CvStatus* cv_fastNlMeansDenoisingColoredMulti_1(
    VecMat src,
    Mat dst,
    int imgToDenoiseIndex,
    int temporalWindowSize,
    float h,
    float hColor,
    int templateWindowSize,
    int searchWindowSize,
    CvCallback_0 callback
);
CvStatus* cv_fastNlMeansDenoising(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_fastNlMeansDenoising_1(
    Mat src, Mat dst, float h, int templateWindowSize, int searchWindowSize, CvCallback_0 callback
);
CvStatus* cv_fastNlMeansDenoisingColored(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_fastNlMeansDenoisingColored_1(
    Mat src,
    Mat dst,
    float h,
    float hColor,
    int templateWindowSize,
    int searchWindowSize,
    CvCallback_0 callback
);

CvStatus* cv_createMergeMertens(MergeMertens* rval);
CvStatus* cv_createMergeMertens_1(
    float contrast_weight, float saturation_weight, float exposure_weight, MergeMertens* rval
);
CvStatus* cv_MergeMertens_process(MergeMertens b, VecMat src, Mat dst, CvCallback_0 callback);
void cv_MergeMertens_close(MergeMertensPtr b);

CvStatus* cv_createAlignMTB(AlignMTB* rval);
CvStatus* cv_createAlignMTB_1(int max_bits, int exclude_range, bool cut, AlignMTB* rval);
CvStatus* cv_AlignMTB_process(AlignMTB b, VecMat src, const VecMat* dst, CvCallback_0 callback);
void cv_AlignMTB_close(AlignMTBPtr b);

CvStatus* cv_detailEnhance(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback);
CvStatus* cv_edgePreservingFilter(
    Mat src, Mat dst, int filter, float sigma_s, float sigma_r, CvCallback_0 callback
);
CvStatus* cv_pencilSketch(
    Mat src,
    Mat dst1,
    Mat dst2,
    float sigma_s,
    float sigma_r,
    float shade_factor,
    CvCallback_0 callback
);
CvStatus* cv_stylization(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback);

CvStatus* cv_inpaint(
    Mat src, Mat mask, Mat dst, float inpaint_radius, int algorithm_type, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  //CVD_PHOTO_H_
