#pragma once
#include "core/types.h"
#include "img_hash.h"

#ifdef __cplusplus
extern "C" {
#endif

CvStatus *pHashCompute_Async(Mat inputArr,  CvCallback_1 callback);
CvStatus *pHashCompare_Async(Mat a, Mat b, CvCallback_1 callback);
CvStatus *averageHashCompute_Async(Mat inputArr,  CvCallback_1 callback);
CvStatus *averageHashCompare_Async(Mat a, Mat b, CvCallback_1 callback);

CvStatus *BlockMeanHash_Create_Async(int mode, CvCallback_1 callback);
CvStatus *BlockMeanHash_GetMean_Async(BlockMeanHash self, CvCallback_1 callback);
CvStatus *BlockMeanHash_SetMode_Async(BlockMeanHash self, int mode, CvCallback_0 callback);
CvStatus *BlockMeanHash_Compute_Async(BlockMeanHash self, Mat inputArr,  CvCallback_1 callback);
CvStatus *BlockMeanHash_Compare_Async(BlockMeanHash self, Mat hashOne, Mat hashTwo, CvCallback_1 callback);

CvStatus *colorMomentHashCompute_Async(Mat inputArr,  CvCallback_1 callback);
CvStatus *colorMomentHashCompare_Async(Mat a, Mat b, CvCallback_1 callback);
CvStatus *marrHildrethHashCompute_Async(Mat inputArr,  float alpha, float scale, CvCallback_1 callback);
CvStatus *marrHildrethHashCompare_Async(Mat a, Mat b, float alpha, float scale, CvCallback_1 callback);
CvStatus *radialVarianceHashCompute_Async(Mat inputArr,  double sigma, int numOfAngleLine, CvCallback_1 callback);
CvStatus *radialVarianceHashCompare_Async(Mat a, Mat b, double sigma, int numOfAngleLine, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif
