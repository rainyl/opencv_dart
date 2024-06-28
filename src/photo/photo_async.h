/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#ifndef CVD_PHOTO_ASYNC_H_
#define CVD_PHOTO_ASYNC_H_

#include "core/types.h"
#include "photo.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

// Asynchronous functions for ColorChange
CvStatus *ColorChange_Async(Mat src, Mat mask, Mat dst, float red_mul, float green_mul, float blue_mul, CvCallback_0 callback);

// Asynchronous functions for SeamlessClone
CvStatus *SeamlessClone_Async(Mat src, Mat dst, Mat mask, Point p, Mat blend, int flags, CvCallback_0 callback);

// Asynchronous functions for IlluminationChange
CvStatus *IlluminationChange_Async(Mat src, Mat mask, Mat dst, float alpha, float beta, CvCallback_0 callback);

// Asynchronous functions for TextureFlattening
CvStatus *TextureFlattening_Async(Mat src, Mat mask, Mat dst, float low_threshold, float high_threshold, int kernel_size, CvCallback_0 callback);

// Asynchronous functions for FastNlMeansDenoisingColoredMulti
CvStatus *FastNlMeansDenoisingColoredMulti_Async(VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize, CvCallback_0 callback);
CvStatus *FastNlMeansDenoisingColoredMultiWithParams_Async(VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize, float h, float hColor, int templateWindowSize, int searchWindowSize, CvCallback_0 callback);

// Asynchronous functions for FastNlMeansDenoising
CvStatus *FastNlMeansDenoising_Async(Mat src, Mat dst, CvCallback_0 callback);
CvStatus *FastNlMeansDenoisingWithParams_Async(Mat src, Mat dst, float h, int templateWindowSize, int searchWindowSize, CvCallback_0 callback);

// Asynchronous functions for FastNlMeansDenoisingColored
CvStatus *FastNlMeansDenoisingColored_Async(Mat src, Mat dst, CvCallback_0 callback);
CvStatus *FastNlMeansDenoisingColoredWithParams_Async(Mat src, Mat dst, float h, float hColor, int templateWindowSize, int searchWindowSize, CvCallback_0 callback);

// Asynchronous functions for MergeMertens
CvStatus *MergeMertens_Create_Async(CvCallback_1 callback);
CvStatus *MergeMertens_CreateWithParams_Async(float contrast_weight, float saturation_weight, float exposure_weight, CvCallback_1 callback);
CvStatus *MergeMertens_Process_Async(MergeMertens b, VecMat src, Mat dst, CvCallback_0 callback);

// Asynchronous functions for AlignMTB
CvStatus *AlignMTB_Create_Async(CvCallback_1 callback);
CvStatus *AlignMTB_CreateWithParams_Async(int max_bits, int exclude_range, bool cut, CvCallback_1 callback);
CvStatus *AlignMTB_Process_Async(AlignMTB b, VecMat src, CvCallback_1 callback);

// Asynchronous functions for DetailEnhance
CvStatus *DetailEnhance_Async(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback);

// Asynchronous functions for EdgePreservingFilter
CvStatus *EdgePreservingFilter_Async(Mat src, Mat dst, int filter, float sigma_s, float sigma_r, CvCallback_0 callback);

// Asynchronous functions for PencilSketch
CvStatus *PencilSketch_Async(Mat src, Mat dst1, Mat dst2, float sigma_s, float sigma_r, float shade_factor, CvCallback_0 callback);

// Asynchronous functions for Stylization
CvStatus *Stylization_Async(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback);

// Asynchronous functions for PhotoInpaint
CvStatus *PhotoInpaint_Async(Mat src, Mat mask, Mat dst, float inpaint_radius, int algorithm_type, CvCallback_0 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_PHOTO_ASYNC_H_
