/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef OPENCV_DART_LIBRARY_STITCHING_H
#define OPENCV_DART_LIBRARY_STITCHING_H

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
CVD_TYPEDEF(cv::Ptr<cv::Stitcher>, Stitcher);
#else
CVD_TYPEDEF(void *, Stitcher);
#endif

CvStatus *Stitcher_Create(int mode, Stitcher *rval);
void      Stitcher_Close(StitcherPtr stitcher);
CvStatus *Stitcher_Get(Stitcher self, Stitcher *rval);

#pragma region getter/setter

CvStatus *Stitcher_GetRegistrationResol(Stitcher self, double *rval);
CvStatus *Stitcher_SetRegistrationResol(Stitcher self, double inval);

CvStatus *Stitcher_GetSeamEstimationResol(Stitcher self, double *rval);
CvStatus *Stitcher_SetSeamEstimationResol(Stitcher self, double inval);

CvStatus *Stitcher_GetCompositingResol(Stitcher self, double *rval);
CvStatus *Stitcher_SetCompositingResol(Stitcher self, double inval);

CvStatus *Stitcher_GetPanoConfidenceThresh(Stitcher self, double *rval);
CvStatus *Stitcher_SetPanoConfidenceThresh(Stitcher self, double inval);

CvStatus *Stitcher_GetWaveCorrection(Stitcher self, bool *rval);
CvStatus *Stitcher_SetWaveCorrection(Stitcher self, bool inval);

CvStatus *Stitcher_GetInterpolationFlags(Stitcher self, int *rval);
CvStatus *Stitcher_SetInterpolationFlags(Stitcher self, int inval);

CvStatus *Stitcher_GetWaveCorrectKind(Stitcher self, int *rval);
CvStatus *Stitcher_SetWaveCorrectKind(Stitcher self, int inval);
#pragma endregion

#pragma region functions

CvStatus *Stitcher_EstimateTransform(Stitcher self, VecMat mats, VecMat masks, int *rval);

CvStatus *Stitcher_ComposePanorama(Stitcher self, Mat rpano, int *rval);
CvStatus *Stitcher_ComposePanorama_1(Stitcher self, VecMat mats, Mat rpano, int *rval);

CvStatus *Stitcher_Stitch(Stitcher self, VecMat mats, Mat rpano, int *rval);
CvStatus *Stitcher_Stitch_1(Stitcher self, VecMat mats, VecMat masks, Mat rpano, int *rval);

CvStatus *Stitcher_Component(Stitcher self, VecI32 *rval);
#pragma endregion

#ifdef __cplusplus
}
#endif

#endif // OPENCV_DART_LIBRARY_STITCHING_H
