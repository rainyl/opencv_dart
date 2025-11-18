/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_STITCHING_H
#define CVD_STITCHING_H

#include "dartcv/core/types.h"

#ifdef __cplusplus
#include <opencv2/stitching.hpp>
extern "C" {
#endif

enum {
    STITCHING_PANORAMA = 0,
    STITCHING_SCANS = 1
};
enum {
    STITCHING_OK = 0,
    STITCHING_ERR_NEED_MORE_IMGS = 1,
    STITCHING_ERR_HOMOGRAPHY_EST_FAIL = 2,
    STITCHING_ERR_CAMERA_PARAMS_ADJUST_FAIL = 3
};

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::Stitcher>, Stitcher);
#else
CVD_TYPEDEF(void*, Stitcher);
#endif

CvStatus* cv_Stitcher_create(int mode, Stitcher* rval);
void cv_Stitcher_close(StitcherPtr stitcher);

#pragma region getter/setter

double cv_Stitcher_get_registrationResol(Stitcher self);
void cv_Stitcher_set_registrationResol(Stitcher self, double val);

double cv_Stitcher_get_seamEstimationResol(Stitcher self);
void cv_Stitcher_set_seamEstimationResol(Stitcher self, double val);

double cv_Stitcher_get_compositingResol(Stitcher self);
void cv_Stitcher_set_compositingResol(Stitcher self, double val);

double cv_Stitcher_get_panoConfidenceThresh(Stitcher self);
void cv_Stitcher_set_panoConfidenceThresh(Stitcher self, double val);

bool cv_Stitcher_get_waveCorrection(Stitcher self);
void cv_Stitcher_set_waveCorrection(Stitcher self, bool val);

int cv_Stitcher_get_interpolationFlags(Stitcher self);
void cv_Stitcher_set_interpolationFlags(Stitcher self, int val);

int cv_Stitcher_get_waveCorrectKind(Stitcher self);
void cv_Stitcher_set_waveCorrectKind(Stitcher self, int val);
#pragma endregion

#pragma region functions

CvStatus* cv_Stitcher_estimateTransform(
    Stitcher self, VecMat mats, VecMat masks, int* rval, CvCallback_0 callback
);

CvStatus* cv_Stitcher_composePanorama(Stitcher self, Mat rpano, int* rval, CvCallback_0 callback);
CvStatus* cv_Stitcher_composePanorama_1(
    Stitcher self, VecMat mats, Mat rpano, int* rval, CvCallback_0 callback
);

CvStatus* cv_Stitcher_stitch(
    Stitcher self, VecMat mats, Mat rpano, int* rval, CvCallback_0 callback
);
CvStatus* cv_Stitcher_stitch_1(
    Stitcher self, VecMat mats, VecMat masks, Mat rpano, int* rval, CvCallback_0 callback
);

CvStatus* cv_Stitcher_component(Stitcher self, VecI32* rval, CvCallback_0 callback);
#pragma endregion

#ifdef __cplusplus
}
#endif

#endif  // CVD_STITCHING_H
