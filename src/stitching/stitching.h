/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef OCV_STITCHING_H
#define OCV_STITCHING_H

#include "core/core.h"
#include "core/exception.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

enum { STITCHING_PANORAMA = 0, STITCHING_SCANS = 1 };
enum {
  STITCHING_OK = 0,
  STITCHING_ERR_NEED_MORE_IMGS = 1,
  STITCHING_ERR_HOMOGRAPHY_EST_FAIL = 2,
  STITCHING_ERR_CAMERA_PARAMS_ADJUST_FAIL = 3
};

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::Stitcher>, PtrStitcher)
#else
CVD_TYPEDEF(void *, PtrStitcher)
#endif

CVD_TYPEDEF_PTR(PtrStitcher)

CvStatus Stitcher_Create(int mode, PtrStitcher *rval);
void     Stitcher_Close(PtrStitcher *stitcher);

#pragma region getter/setter

CvStatus Stitcher_GetRegistrationResol(PtrStitcher self, double *rval);
CvStatus Stitcher_SetRegistrationResol(PtrStitcher self, double inval);

CvStatus Stitcher_GetSeamEstimationResol(PtrStitcher self, double *rval);
CvStatus Stitcher_SetSeamEstimationResol(PtrStitcher self, double inval);

CvStatus Stitcher_GetCompositingResol(PtrStitcher self, double *rval);
CvStatus Stitcher_SetCompositingResol(PtrStitcher self, double inval);

CvStatus Stitcher_GetPanoConfidenceThresh(PtrStitcher self, double *rval);
CvStatus Stitcher_SetPanoConfidenceThresh(PtrStitcher self, double inval);

CvStatus Stitcher_GetWaveCorrection(PtrStitcher self, bool *rval);
CvStatus Stitcher_SetWaveCorrection(PtrStitcher self, bool inval);

CvStatus Stitcher_GetInterpolationFlags(PtrStitcher self, int *rval);
CvStatus Stitcher_SetInterpolationFlags(PtrStitcher self, int inval);

CvStatus Stitcher_GetWaveCorrectKind(PtrStitcher self, int *rval);
CvStatus Stitcher_SetWaveCorrectKind(PtrStitcher self, int inval);
#pragma endregion

#pragma region functions

CvStatus Stitcher_EstimateTransform(PtrStitcher self, VecMat mats, VecMat masks, int *rval);

CvStatus Stitcher_ComposePanorama(PtrStitcher self, Mat rpano, int *rval);
CvStatus Stitcher_ComposePanorama_1(PtrStitcher self, VecMat mats, Mat rpano, int *rval);

CvStatus Stitcher_Stitch(PtrStitcher self, VecMat mats, Mat rpano, int *rval);
CvStatus Stitcher_Stitch_1(PtrStitcher self, VecMat mats, VecMat masks, Mat rpano, int *rval);

CvStatus Stitcher_Component(PtrStitcher self, VecInt *rval);
#pragma endregion

#ifdef __cplusplus
}
#endif

#endif // OCV_STITCHING_H
