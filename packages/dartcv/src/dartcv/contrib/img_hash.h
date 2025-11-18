/*
    Created by mdeleau.
    Licensed: Apache 2.0 license. Copyright (c) 2024 mdeleau.

    Modified by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef OCV_DART_IMG_HASH_H
#define OCV_DART_IMG_HASH_H

#include "dartcv/core/types.h"
#ifdef __cplusplus
#include <opencv2/img_hash.hpp>
extern "C" {
#endif

#ifdef __cplusplus
// typedef cv::Ptr<cv::img_hash::PHash>              *PHash;
// typedef cv::Ptr<cv::img_hash::AverageHash>        *AverageHash;
CVD_TYPEDEF(cv::Ptr<cv::img_hash::BlockMeanHash>, BlockMeanHash);
// typedef cv::Ptr<cv::img_hash::ColorMomentHash>    *ColorMomentHash;
// typedef cv::Ptr<cv::img_hash::MarrHildrethHash>   *MarrHildrethHash;
// typedef cv::Ptr<cv::img_hash::RadialVarianceHash> *RadialVarianceHash;
#else
// typedef void *PHash;
// typedef void *AverageHash;
CVD_TYPEDEF(void, BlockMeanHash);
// typedef void *ColorMomentHash;
// typedef void *MarrHildrethHash;
// typedef void *RadialVarianceHash;
#endif

enum {
    /** use fewer block and generate 16*16/8 uchar hash value */
    BLOCK_MEAN_HASH_MODE_0 = 0,
    /** use block blocks(step sizes/2), generate 31*31/8 + 1 uchar hash value */
    BLOCK_MEAN_HASH_MODE_1 = 1
};

CvStatus* cv_img_hash_pHash_compute(Mat inputArr, Mat outputArr, CvCallback_0 callback);
CvStatus* cv_img_hash_pHash_compare(Mat a, Mat b, double* rval, CvCallback_0 callback);

CvStatus* cv_img_hash_averageHash_compute(Mat inputArr, Mat outputArr, CvCallback_0 callback);
CvStatus* cv_img_hash_averageHash_compare(Mat a, Mat b, double* rval, CvCallback_0 callback);

CvStatus* cv_img_hash_BlockMeanHash_create(int mode, BlockMeanHash* rval, CvCallback_0 callback);
CvStatus* cv_img_hash_BlockMeanHash_getMean(
    BlockMeanHash self, VecF64* rval, CvCallback_0 callback
);
CvStatus* cv_img_hash_BlockMeanHash_setMode(BlockMeanHash self, int mode, CvCallback_0 callback);
void cv_img_hash_BlockMeanHash_close(BlockMeanHashPtr self);
CvStatus* cv_img_hash_BlockMeanHash_compute(
    BlockMeanHash self, Mat inputArr, Mat outputArr, CvCallback_0 callback
);
CvStatus* cv_img_hash_BlockMeanHash_compare(
    BlockMeanHash self, Mat hashOne, Mat hashTwo, double* rval, CvCallback_0 callback
);

CvStatus* cv_img_hash_colorMomentHash_compute(Mat inputArr, Mat outputArr, CvCallback_0 callback);
CvStatus* cv_img_hash_colorMomentHash_compare(Mat a, Mat b, double* rval, CvCallback_0 callback);

CvStatus* cv_img_hash_marrHildrethHash_compute(
    Mat inputArr, Mat outputArr, float alpha, float scale, CvCallback_0 callback
);
CvStatus* cv_img_hash_marrHildrethHash_compare(
    Mat a, Mat b, float alpha, float scale, double* rval, CvCallback_0 callback
);

CvStatus* cv_img_hash_radialVarianceHash_compute(
    Mat inputArr, Mat outputArr, double sigma, int numOfAngleLine, CvCallback_0 callback
);
CvStatus* cv_img_hash_radialVarianceHash_compare(
    Mat a, Mat b, double sigma, int numOfAngleLine, double* rval, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // OCV_DART_IMG_HASH_H
