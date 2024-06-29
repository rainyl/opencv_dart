/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#ifndef OPENCV_DART_LIBRARY_STITCHING_ASYNC_H
#define OPENCV_DART_LIBRARY_STITCHING_ASYNC_H

#include "core/types.h"
#include "stitching.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

// Asynchronous functions for Stitcher_Create
CvStatus *Stitcher_Create_Async(int mode, CvCallback_1 callback);

// Asynchronous functions for Stitcher_Close
void Stitcher_Close_Async(StitcherPtr stitcher, CvCallback_0 callback);

// Asynchronous getter/setter functions
CvStatus *Stitcher_GetRegistrationResol_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetRegistrationResol_Async(Stitcher self, double inval, CvCallback_0 callback);
CvStatus *Stitcher_GetSeamEstimationResol_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetSeamEstimationResol_Async(Stitcher self, double inval, CvCallback_0 callback);
CvStatus *Stitcher_GetCompositingResol_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetCompositingResol_Async(Stitcher self, double inval, CvCallback_0 callback);
CvStatus *Stitcher_GetPanoConfidenceThresh_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetPanoConfidenceThresh_Async(Stitcher self, double inval, CvCallback_0 callback);
CvStatus *Stitcher_GetWaveCorrection_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetWaveCorrection_Async(Stitcher self, bool inval, CvCallback_0 callback);
CvStatus *Stitcher_GetInterpolationFlags_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetInterpolationFlags_Async(Stitcher self, int inval, CvCallback_0 callback);
CvStatus *Stitcher_GetWaveCorrectKind_Async(Stitcher self, CvCallback_1 callback);
CvStatus *Stitcher_SetWaveCorrectKind_Async(Stitcher self, int inval, CvCallback_0 callback);

// Asynchronous functions
CvStatus *Stitcher_EstimateTransform_Async(Stitcher self, VecMat mats, VecMat masks, CvCallback_1 callback);
CvStatus *Stitcher_ComposePanorama_Async(Stitcher self, CvCallback_2 callback);
CvStatus *Stitcher_ComposePanorama_1_Async(Stitcher self, VecMat mats, CvCallback_2 callback);
CvStatus *Stitcher_Stitch_Async(Stitcher self, VecMat mats, CvCallback_2 callback);
CvStatus *Stitcher_Stitch_1_Async(Stitcher self, VecMat mats, VecMat masks, CvCallback_2 callback);
CvStatus *Stitcher_Component_Async(Stitcher self, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // OPENCV_DART_LIBRARY_STITCHING_ASYNC_H
