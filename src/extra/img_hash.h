/*
    Created by mdeleau.
    Licensed: Apache 2.0 license. Copyright (c) 2024 mdeleau.

    Modified by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef OCV_DART_IMG_HASH_H
#define OCV_DART_IMG_HASH_H

#include "../core/core.h"
#ifdef __cplusplus
#include <opencv2/img_hash.hpp>
#include <opencv2/opencv.hpp>
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

CvStatus *pHashCompute(Mat inputArr, Mat *outputArr);
CvStatus *pHashCompare(Mat a, Mat b, double *rval);

CvStatus *averageHashCompute(Mat inputArr, Mat *outputArr);
CvStatus *averageHashCompare(Mat a, Mat b, double *rval);

CvStatus *BlockMeanHash_Create(int mode, BlockMeanHash *rval);
CvStatus *BlockMeanHash_GetMean(BlockMeanHash self, double **rval, int *length);
CvStatus *BlockMeanHash_SetMode(BlockMeanHash self, int mode);
void BlockMeanHash_Close(BlockMeanHashPtr self);
CvStatus *BlockMeanHash_Compute(BlockMeanHash self, Mat inputArr, Mat *outputArr);
CvStatus *BlockMeanHash_Compare(BlockMeanHash self, Mat hashOne, Mat hashTwo, double *rval);

CvStatus *colorMomentHashCompute(Mat inputArr, Mat *outputArr);
CvStatus *colorMomentHashCompare(Mat a, Mat b, double *rval);

CvStatus *marrHildrethHashCompute(Mat inputArr, Mat *outputArr, float alpha, float scale);
CvStatus *marrHildrethHashCompare(Mat a, Mat b, float alpha, float scale, double *rval);

CvStatus *radialVarianceHashCompute(Mat inputArr, Mat *outputArr, double sigma, int numOfAngleLine);
CvStatus *radialVarianceHashCompare(Mat a, Mat b, double sigma, int numOfAngleLine, double *rval);

#ifdef __cplusplus
}
#endif

#endif // OCV_DART_IMG_HASH_H
