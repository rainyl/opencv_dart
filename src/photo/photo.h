/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_PHOTO_H_
#define _OPENCV3_PHOTO_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/photo.hpp>
extern "C" {
#endif

#include "core/core.h"

#ifdef __cplusplus
/// see : https://docs.opencv.org/3.4/d7/dd6/classcv_1_1MergeMertens.html
CVD_TYPEDEF(cv::Ptr<cv::MergeMertens>, MergeMertens);
/// see : https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
CVD_TYPEDEF(cv::Ptr<cv::AlignMTB>, AlignMTB);
#else
CVD_TYPEDEF(void, MergeMertens);
CVD_TYPEDEF(void, AlignMTB);
#endif

CvStatus *ColorChange(Mat src, Mat mask, Mat dst, float red_mul, float green_mul, float blue_mul);

CvStatus *SeamlessClone(Mat src, Mat dst, Mat mask, Point p, Mat blend, int flags);

CvStatus *IlluminationChange(Mat src, Mat mask, Mat dst, float alpha, float beta);

CvStatus *TextureFlattening(Mat src, Mat mask, Mat dst, float low_threshold, float high_threshold,
                            int kernel_size);

CvStatus *FastNlMeansDenoisingColoredMulti(VecMat src, Mat dst, int imgToDenoiseIndex,
                                           int temporalWindowSize);
CvStatus *FastNlMeansDenoisingColoredMultiWithParams(VecMat src, Mat dst, int imgToDenoiseIndex,
                                                     int temporalWindowSize, float h, float hColor,
                                                     int templateWindowSize, int searchWindowSize);
CvStatus *FastNlMeansDenoising(Mat src, Mat dst);
CvStatus *FastNlMeansDenoisingWithParams(Mat src, Mat dst, float h, int templateWindowSize,
                                         int searchWindowSize);
CvStatus *FastNlMeansDenoisingColored(Mat src, Mat dst);
CvStatus *FastNlMeansDenoisingColoredWithParams(Mat src, Mat dst, float h, float hColor,
                                                int templateWindowSize, int searchWindowSize);

CvStatus *MergeMertens_Create(MergeMertens *rval);
CvStatus *MergeMertens_CreateWithParams(float contrast_weight, float saturation_weight, float exposure_weight,
                                        MergeMertens *rval);
CvStatus *MergeMertens_Process(MergeMertens b, VecMat src, Mat dst);
void      MergeMertens_Close(MergeMertensPtr b);

CvStatus *AlignMTB_Create(AlignMTB *rval);
CvStatus *AlignMTB_CreateWithParams(int max_bits, int exclude_range, bool cut, AlignMTB *rval);
CvStatus *AlignMTB_Process(AlignMTB b, VecMat src, VecMat *dst);
void      AlignMTB_Close(AlignMTBPtr b);

CvStatus *DetailEnhance(Mat src, Mat dst, float sigma_s, float sigma_r);
CvStatus *EdgePreservingFilter(Mat src, Mat dst, int filter, float sigma_s, float sigma_r);
CvStatus *PencilSketch(Mat src, Mat dst1, Mat dst2, float sigma_s, float sigma_r, float shade_factor);
CvStatus *Stylization(Mat src, Mat dst, float sigma_s, float sigma_r);

CvStatus *PhotoInpaint(Mat src, Mat mask, Mat dst, float inpaint_radius, int algorithm_type);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_PHOTO_H
