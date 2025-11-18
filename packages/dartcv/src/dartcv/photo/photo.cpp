/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/photo/photo.h"
#include "dartcv/core/vec.hpp"

CvStatus* cv_colorChange(
    Mat src,
    Mat mask,
    Mat dst,
    float red_mul,
    float green_mul,
    float blue_mul,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::colorChange(CVDEREF(src), CVDEREF(mask), CVDEREF(dst), red_mul, green_mul, blue_mul);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_seamlessClone(
    Mat src, Mat dst, Mat mask, CvPoint p, Mat blend, int flags, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::seamlessClone(
        CVDEREF(src), CVDEREF(dst), CVDEREF(mask), cv::Point(p.x, p.y), CVDEREF(blend), flags
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_illuminationChange(
    Mat src, Mat mask, Mat dst, float alpha, float beta, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::illuminationChange(CVDEREF(src), CVDEREF(mask), CVDEREF(dst), alpha, beta);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_textureFlattening(
    Mat src,
    Mat mask,
    Mat dst,
    float low_threshold,
    float high_threshold,
    int kernel_size,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::textureFlattening(
        CVDEREF(src), CVDEREF(mask), CVDEREF(dst), low_threshold, high_threshold, kernel_size
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fastNlMeansDenoisingColoredMulti(
    VecMat src, Mat dst, int imgToDenoiseIndex, int temporalWindowSize, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColoredMulti(CVDEREF(src), CVDEREF(dst), imgToDenoiseIndex, temporalWindowSize);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
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
) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColoredMulti(
        CVDEREF(src),
        CVDEREF(dst),
        imgToDenoiseIndex,
        temporalWindowSize,
        h,
        hColor,
        templateWindowSize,
        searchWindowSize
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_fastNlMeansDenoising(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoising(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_fastNlMeansDenoising_1(
    Mat src, Mat dst, float h, int templateWindowSize, int searchWindowSize, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::fastNlMeansDenoising(CVDEREF(src), CVDEREF(dst), h, templateWindowSize, searchWindowSize);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_fastNlMeansDenoisingColored(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColored(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_fastNlMeansDenoisingColored_1(
    Mat src,
    Mat dst,
    float h,
    float hColor,
    int templateWindowSize,
    int searchWindowSize,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::fastNlMeansDenoisingColored(
        CVDEREF(src), CVDEREF(dst), h, hColor, templateWindowSize, searchWindowSize
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_createMergeMertens(MergeMertens* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::MergeMertens>(cv::createMergeMertens())};
    END_WRAP
}
CvStatus* cv_createMergeMertens_1(
    float contrast_weight, float saturation_weight, float exposure_weight, MergeMertens* rval
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::MergeMertens>(
        cv::createMergeMertens(contrast_weight, saturation_weight, exposure_weight)
    )};
    END_WRAP
}
CvStatus* cv_MergeMertens_process(MergeMertens b, VecMat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(b))->process(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
void cv_MergeMertens_close(MergeMertensPtr b) {
    b->ptr->reset();
    CVD_FREE(b);
}

CvStatus* cv_createAlignMTB(AlignMTB* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::AlignMTB>(cv::createAlignMTB())};
    END_WRAP
}
CvStatus* cv_createAlignMTB_1(int max_bits, int exclude_range, bool cut, AlignMTB* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::AlignMTB>(cv::createAlignMTB(max_bits, exclude_range, cut))};
    END_WRAP
}
CvStatus* cv_AlignMTB_process(AlignMTB b, VecMat src, const VecMat* dst, CvCallback_0 callback) {
    BEGIN_WRAP
    (CVDEREF(b))->process(CVDEREF(src), CVDEREF_P(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
void cv_AlignMTB_close(AlignMTBPtr b) {
    b->ptr->reset();
    CVD_FREE(b);
}

CvStatus* cv_detailEnhance(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::detailEnhance(CVDEREF(src), CVDEREF(dst), sigma_s, sigma_r);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_edgePreservingFilter(
    Mat src, Mat dst, int filter, float sigma_s, float sigma_r, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::edgePreservingFilter(CVDEREF(src), CVDEREF(dst), filter, sigma_s, sigma_r);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_pencilSketch(
    Mat src,
    Mat dst1,
    Mat dst2,
    float sigma_s,
    float sigma_r,
    float shade_factor,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::pencilSketch(CVDEREF(src), CVDEREF(dst1), CVDEREF(dst2), sigma_s, sigma_r, shade_factor);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_stylization(Mat src, Mat dst, float sigma_s, float sigma_r, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::stylization(CVDEREF(src), CVDEREF(dst), sigma_s, sigma_r);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_inpaint(
    Mat src, Mat mask, Mat dst, float inpaint_radius, int algorithm_type, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::inpaint(CVDEREF(src), CVDEREF(mask), CVDEREF(dst), inpaint_radius, algorithm_type);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
