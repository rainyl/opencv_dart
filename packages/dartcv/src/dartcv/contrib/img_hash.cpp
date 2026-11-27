//
// Created by Rainyl.
// Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
//

#include "dartcv/contrib/img_hash.h"
#include <vector>
#include "dartcv/core/handle.hpp"

CvStatus* cv_img_hash_pHash_compute(Mat inputArr, Mat outputArr, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(inputArr, outputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::img_hash::pHash(CVDEREF(inputArr), CVDEREF(outputArr));
        END_WRAP
    });
}
CvStatus* cv_img_hash_pHash_compare(Mat a, Mat b, double* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(a, b), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = cv::img_hash::PHash::create()->compare(CVDEREF(a), CVDEREF(b));
        END_WRAP
    });
}

CvStatus* cv_img_hash_averageHash_compute(Mat inputArr, Mat outputArr, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(inputArr, outputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::img_hash::averageHash(CVDEREF(inputArr), CVDEREF(outputArr));
        END_WRAP
    });
}
CvStatus* cv_img_hash_averageHash_compare(Mat a, Mat b, double* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(a, b), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = cv::img_hash::AverageHash::create()->compare(CVDEREF(a), CVDEREF(b));
        END_WRAP
    });
}

CvStatus* cv_img_hash_BlockMeanHash_create(int mode, BlockMeanHash* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(), [=]() -> CvStatus* {
        BEGIN_WRAP
        CVD_SET(rval, new cv::Ptr<cv::img_hash::BlockMeanHash>(cv::img_hash::BlockMeanHash::create(mode)));
        END_WRAP
    });
}
CvStatus* cv_img_hash_BlockMeanHash_getMean(
    BlockMeanHash self, VecF64* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self), [=]() -> CvStatus* {
        BEGIN_WRAP
        auto m = (CVDEREF(self))->getMean();
        CVD_SET(rval, new std::vector<double_t>(m));
        END_WRAP
    });
}
CvStatus* cv_img_hash_BlockMeanHash_setMode(BlockMeanHash self, int mode, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(self), [=]() -> CvStatus* {
        BEGIN_WRAP(CVDEREF(self))->setMode(mode);
        END_WRAP
    });
}

void cv_img_hash_BlockMeanHash_close(BlockMeanHashPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_img_hash_BlockMeanHash_compute(
    BlockMeanHash self, Mat inputArr, Mat outputArr, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, inputArr, outputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        CVDEREF(self).get()->compute(CVDEREF(inputArr), CVDEREF(outputArr));
        END_WRAP
    });
}
CvStatus* cv_img_hash_BlockMeanHash_compare(
    BlockMeanHash self, Mat a, Mat b, double* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, a, b), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = CVDEREF(self).get()->compare(CVDEREF(a), CVDEREF(b));
        END_WRAP
    });
}

CvStatus* cv_img_hash_colorMomentHash_compute(Mat inputArr, Mat outputArr, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(inputArr, outputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::img_hash::colorMomentHash(CVDEREF(inputArr), CVDEREF(outputArr));
        END_WRAP
    });
}
CvStatus* cv_img_hash_colorMomentHash_compare(Mat a, Mat b, double* rval, CvCallback_0 callback) {
    return cvd::dispatch(callback, cvd::hold(a, b), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = cv::img_hash::ColorMomentHash::create()->compare(CVDEREF(a), CVDEREF(b));
        END_WRAP
    });
}

CvStatus* cv_img_hash_marrHildrethHash_compute(
    Mat inputArr, Mat outputArr, float alpha, float scale, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(inputArr, outputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::img_hash::marrHildrethHash(CVDEREF(inputArr), CVDEREF(outputArr), alpha, scale);
        END_WRAP
    });
}
CvStatus* cv_img_hash_marrHildrethHash_compare(
    Mat a, Mat b, float alpha, float scale, double* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(a, b), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval = cv::img_hash::MarrHildrethHash::create(alpha, scale)->compare(CVDEREF(a), CVDEREF(b));
        END_WRAP
    });
}

CvStatus* cv_img_hash_radialVarianceHash_compute(
    Mat inputArr, Mat outputArr, double sigma, int numOfAngleLine, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(inputArr, outputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::img_hash::radialVarianceHash(CVDEREF(inputArr), CVDEREF(outputArr), sigma, numOfAngleLine);
        END_WRAP
    });
}
CvStatus* cv_img_hash_radialVarianceHash_compare(
    Mat a, Mat b, double sigma, int numOfAngleLine, double* rval, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(a, b), [=]() -> CvStatus* {
        BEGIN_WRAP
        *rval =
            cv::img_hash::RadialVarianceHash::create(sigma, numOfAngleLine)->compare(CVDEREF(a), CVDEREF(b));
        END_WRAP
    });
}
