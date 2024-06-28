/* Created by Rainyl. Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl. */
#include "photo_async.h"
#include "core/types.h"

// Asynchronous functions for ColorChange
CvStatus *ColorChange_Async(Mat src, Mat mask, Mat dst, float red_mul, float green_mul, float blue_mul, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::colorChange(*src.ptr, *mask.ptr, *dst.ptr, red_mul, green_mul, blue_mul);
    callback();
    END_WRAP
}

// Asynchronous functions for SeamlessClone
CvStatus *SeamlessClone_Async(Mat src, Mat dst, Mat mask, Point p, Mat blend, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::seamlessClone(*src.ptr, *dst.ptr, *mask.ptr, cv::Point(p.x, p.y), *blend.ptr, flags);
    callback();
    END_WRAP
}

// Asynchronous functions for IlluminationChange
CvStatus *IlluminationChange_Async(Mat src, Mat mask, Mat dst, float alpha, float beta, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::illuminationChange(*src.ptr, *mask.ptr, *dst.ptr, alpha, beta);
    callback();
    END_WRAP
}

// Asynchronous functions for TextureFlattening
CvStatus *TextureFlattening_Async(Mat src, Mat mask, Mat dst, float low_threshold, float high_threshold, int kernel_size, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::textureFlattening(*src.ptr, *mask.ptr, *dst.ptr, low_threshold, high_threshold, kernel_size);
    callback();
    END_WRAP
}

// Asynchronous functions for FastNlMeansDenoisingColoredMulti
CvStatus *FastNlMeansDenoisingColoredMulti_Async(VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColoredMulti(*src.ptr, *dst.ptr, imgToDenoiseIndex, temporalWindowSize);
    callback();
    END_WRAP
}

CvStatus *FastNlMeansDenoisingColoredMultiWithParams_Async(VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize, float h, float hColor, int templateWindowSize, int searchWindowSize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColoredMulti(*src.ptr, *dst.ptr, imgToDenoiseIndex, temporalWindowSize, h, hColor, templateWindowSize, searchWindowSize);
    callback();
    END_WRAP
}

// Asynchronous functions for FastNlMeansDenoising
CvStatus *FastNlMeansDenoising_Async(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoising(*src.ptr, *dst.ptr);
    callback();
    END_WRAP
}

CvStatus *FastNlMeansDenoisingWithParams_Async(Mat src, Mat dst, float h, int templateWindowSize, int searchWindowSize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoising(*src.ptr, *dst.ptr, h, templateWindowSize, searchWindowSize);
    callback();
    END_WRAP
}

// Asynchronous functions for FastNlMeansDenoisingColored
CvStatus *FastNlMeansDenoisingColored_Async(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColored(*src.ptr, *dst.ptr);
    callback();
    END_WRAP
}

CvStatus *FastNlMeansDenoisingColoredWithParams_Async(Mat src, Mat dst, float h, float hColor, int templateWindowSize, int searchWindowSize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColored(*src.ptr, *dst.ptr, h, hColor, templateWindowSize, searchWindowSize);
    callback();
    END_WRAP
}

// Asynchronous functions for MergeMertens
CvStatus *MergeMertens_Create_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new MergeMertens{new cv::Ptr<cv::MergeMertens>(cv::createMergeMertens())});
    END_WRAP
}

CvStatus *MergeMertens_CreateWithParams_Async(float contrast_weight, float saturation_weight, float exposure_weight, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new MergeMertens{new cv::Ptr<cv::MergeMertens>(cv::createMergeMertens(contrast_weight, saturation_weight, exposure_weight))});
    END_WRAP
}

CvStatus *MergeMertens_Process_Async(MergeMertens b, VecMat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    (*b.ptr)->process(*src.ptr, *dst.ptr);
    callback();
    END_WRAP
}

// Asynchronous functions for AlignMTB
CvStatus *AlignMTB_Create_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new AlignMTB{new cv::Ptr<cv::AlignMTB>(cv::createAlignMTB())});
    END_WRAP
}

CvStatus *AlignMTB_CreateWithParams_Async(int max_bits, int exclude_range, bool cut, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new AlignMTB{new cv::Ptr<cv::AlignMTB>(cv::createAlignMTB(max_bits, exclude_range, cut))});
    END_WRAP
}

CvStatus *AlignMTB_Process_Async(AlignMTB b, VecMat src, CvCallback_1 callback) {
    BEGIN_WRAP
    auto vec = std::vector<cv::Mat>();
    (*b.ptr)->process(*src.ptr, vec);
    callback(new VecMat{new std::vector<cv::Mat>(vec)});
    END_WRAP
}

// Asynchronous functions for DetailEnhance
CvStatus *DetailEnhance_Async(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::detailEnhance(*src.ptr, *dst.ptr, sigma_s, sigma_r);
    callback();
    END_WRAP
}

// Asynchronous functions for EdgePreservingFilter
CvStatus *EdgePreservingFilter_Async(Mat src, Mat dst, int filter, float sigma_s, float sigma_r, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::edgePreservingFilter(*src.ptr, *dst.ptr, filter, sigma_s, sigma_r);
    callback();
    END_WRAP
}

// Asynchronous functions for PencilSketch
CvStatus *PencilSketch_Async(Mat src, Mat dst1, Mat dst2, float sigma_s, float sigma_r, float shade_factor, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::pencilSketch(*src.ptr, *dst1.ptr, *dst2.ptr, sigma_s, sigma_r, shade_factor);
    callback();
    END_WRAP
}

// Asynchronous functions for Stylization
CvStatus *Stylization_Async(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::stylization(*src.ptr, *dst.ptr, sigma_s, sigma_r);
    callback();
    END_WRAP
}

// Asynchronous functions for PhotoInpaint
CvStatus *PhotoInpaint_Async(Mat src, Mat mask, Mat dst, float inpaint_radius, int algorithm_type, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::inpaint(*src.ptr, *mask.ptr, *dst.ptr, inpaint_radius, algorithm_type);
    callback();
    END_WRAP
}
