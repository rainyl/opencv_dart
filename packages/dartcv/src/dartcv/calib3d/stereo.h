//
// Created by rainy on 2025/8/12.
//

#ifndef DARTCV_LIBRARY_STEREO_H
#define DARTCV_LIBRARY_STEREO_H

#ifdef __cplusplus
#include <opencv2/calib3d.hpp>

extern "C" {
#endif
#include "dartcv/core/types.h"
#include <stddef.h>

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::StereoBM>, StereoBM);
CVD_TYPEDEF(cv::Ptr<cv::StereoSGBM>, StereoSGBM);
#else
CVD_TYPEDEF(void, StereoBM);
CVD_TYPEDEF(void, StereoSGBM);
#endif

// StereoBM
CvStatus* cv_StereoBM_create(
    int numDisparities, int blockSize, StereoBM* rval, CvCallback_0 callback
);

void cv_StereoBM_close(StereoBMPtr self);

// Gets the current truncation value for prefiltered pixels.
// virtual int  getPreFilterCap () const =0
int cv_StereoBM_getPreFilterCap(StereoBM self);

// Gets the current size of the pre-filter kernel.
// virtual int  getPreFilterSize () const =0
int cv_StereoBM_getPreFilterSize(StereoBM self);

// Gets the type of pre-filtering currently used in the algorithm.
// virtual int  getPreFilterType () const =0
int cv_StereoBM_getPreFilterType(StereoBM self);

// Gets the current Region of Interest (ROI) for the left image.
// virtual Rect  getROI1 () const =0
CvRect* cv_StereoBM_getROI1(StereoBM self);

// Gets the current Region of Interest (ROI) for the right image.
// virtual Rect  getROI2 () const =0
CvRect* cv_StereoBM_getROI2(StereoBM self);

// Gets the current size of the smaller block used for texture check.
// virtual int  getSmallerBlockSize () const =0
int cv_StereoBM_getSmallerBlockSize(StereoBM self);

// Gets the current texture threshold value.
// virtual int  getTextureThreshold () const =0
int cv_StereoBM_getTextureThreshold(StereoBM self);

// Gets the current uniqueness ratio value.
// virtual int  getUniquenessRatio () const =0
int cv_StereoBM_getUniquenessRatio(StereoBM self);

// Sets the truncation value for prefiltered pixels.
// virtual void  setPreFilterCap (int preFilterCap)=0
void cv_StereoBM_setPreFilterCap(StereoBM self, int preFilterCap);

// Sets the size of the pre-filter kernel.
// virtual void  setPreFilterSize (int preFilterSize)=0
void cv_StereoBM_setPreFilterSize(StereoBM self, int preFilterSize);

// Sets the type of pre-filtering used in the algorithm.
// virtual void  setPreFilterType (int preFilterType)=0
void cv_StereoBM_setPreFilterType(StereoBM self, int preFilterType);

// Sets the Region of Interest (ROI) for the left image.
// virtual void  setROI1 (Rect roi1)=0
void cv_StereoBM_setROI1(StereoBM self, CvRect roi1);

// Sets the Region of Interest (ROI) for the right image.
// virtual void  setROI2 (Rect roi2)=0
void cv_StereoBM_setROI2(StereoBM self, CvRect roi2);

// Sets the size of the smaller block used for texture check.
// virtual void  setSmallerBlockSize (int blockSize)=0
void cv_StereoBM_setSmallerBlockSize(StereoBM self, int blockSize);

// Sets the threshold for filtering low-texture regions.
// virtual void  setTextureThreshold (int textureThreshold)=0
void cv_StereoBM_setTextureThreshold(StereoBM self, int textureThreshold);

// Sets the uniqueness ratio for filtering ambiguous matches.
// virtual void  setUniquenessRatio (int uniquenessRatio)=0
void cv_StereoBM_setUniquenessRatio(StereoBM self, int uniquenessRatio);

// Computes disparity map for the specified stereo pair.
// virtual void  compute (InputArray left, InputArray right, OutputArray disparity)=0
CvStatus* cv_StereoBM_compute(StereoBM self, MatIn left, MatIn right, MatOut disparity);

// virtual int  getBlockSize () const =0
int cv_StereoBM_getBlockSize(StereoBM self);

// virtual int  getDisp12MaxDiff () const =0
int cv_StereoBM_getDisp12MaxDiff(StereoBM self);

// virtual int  getMinDisparity () const =0
int cv_StereoBM_getMinDisparity(StereoBM self);

// virtual int  getNumDisparities () const =0
int cv_StereoBM_getNumDisparities(StereoBM self);

// virtual int  getSpeckleRange () const =0
int cv_StereoBM_getSpeckleRange(StereoBM self);

// virtual int  getSpeckleWindowSize () const =0
int cv_StereoBM_getSpeckleWindowSize(StereoBM self);

// virtual void  setBlockSize (int blockSize)=0
void cv_StereoBM_setBlockSize(StereoBM self, int blockSize);

// virtual void  setDisp12MaxDiff (int disp12MaxDiff)=0
void cv_StereoBM_setDisp12MaxDiff(StereoBM self, int disp12MaxDiff);

// virtual void  setMinDisparity (int minDisparity)=0
void cv_StereoBM_setMinDisparity(StereoBM self, int minDisparity);

// virtual void  setNumDisparities (int numDisparities)=0
void cv_StereoBM_setNumDisparities(StereoBM self, int numDisparities);

// virtual void  setSpeckleRange (int speckleRange)=0
void cv_StereoBM_setSpeckleRange(StereoBM self, int speckleRange);

// virtual void  setSpeckleWindowSize (int speckleWindowSize)=0
void cv_StereoBM_setSpeckleWindowSize(StereoBM self, int speckleWindowSize);

// StereoSGBM
CvStatus* cv_StereoSGBM_create(
    int minDisparity,
    int numDisparities,
    int blockSize,
    int P1,
    int P2,
    int disp12MaxDiff,
    int preFilterCap,
    int uniquenessRatio,
    int speckleWindowSize,
    int speckleRange,
    int mode,
    StereoSGBM* rval,
    CvCallback_0 callback
);

void cv_StereoSGBM_close(StereoSGBMPtr self);

// virtual int getMode () const =0
int cv_StereoSGBM_getMode(StereoSGBM self);

// virtual int getP1 () const =0
int cv_StereoSGBM_getP1(StereoSGBM self);

// virtual int getP2 () const =0
int cv_StereoSGBM_getP2(StereoSGBM self);

// virtual int getPreFilterCap () const =0
int cv_StereoSGBM_getPreFilterCap(StereoSGBM self);

// virtual int getUniquenessRatio () const =0
int cv_StereoSGBM_getUniquenessRatio(StereoSGBM self);

// virtual void setMode (int mode)=0
void cv_StereoSGBM_setMode(StereoSGBM self, int mode);

// virtual void setP1 (int P1)=0
void cv_StereoSGBM_setP1(StereoSGBM self, int P1);

// virtual void setP2 (int P2)=0
void cv_StereoSGBM_setP2(StereoSGBM self, int P2);

// virtual void setPreFilterCap (int preFilterCap)=0
void cv_StereoSGBM_setPreFilterCap(StereoSGBM self, int preFilterCap);

// virtual void setUniquenessRatio (int uniquenessRatio)=0
void cv_StereoSGBM_setUniquenessRatio(StereoSGBM self, int uniquenessRatio);

// Computes disparity map for the specified stereo pair.
// virtual void compute (InputArray left, InputArray right, OutputArray disparity)=0
CvStatus* cv_StereoSGBM_compute(StereoSGBM self, MatIn left, MatIn right, MatOut disparity);

// virtual int getBlockSize () const =0
int cv_StereoSGBM_getBlockSize(StereoSGBM self);

// virtual int getDisp12MaxDiff () const =0
int cv_StereoSGBM_getDisp12MaxDiff(StereoSGBM self);

// virtual int getMinDisparity () const =0
int cv_StereoSGBM_getMinDisparity(StereoSGBM self);

// virtual int getNumDisparities () const =0
int cv_StereoSGBM_getNumDisparities(StereoSGBM self);

// virtual int getSpeckleRange () const =0
int cv_StereoSGBM_getSpeckleRange(StereoSGBM self);

// virtual int getSpeckleWindowSize () const =0
int cv_StereoSGBM_getSpeckleWindowSize(StereoSGBM self);

// virtual void setBlockSize (int blockSize)=0
void cv_StereoSGBM_setBlockSize(StereoSGBM self, int blockSize);

// virtual void setDisp12MaxDiff (int disp12MaxDiff)=0
void cv_StereoSGBM_setDisp12MaxDiff(StereoSGBM self, int disp12MaxDiff);

// virtual void setMinDisparity (int minDisparity)=0
void cv_StereoSGBM_setMinDisparity(StereoSGBM self, int minDisparity);

// virtual void setNumDisparities (int numDisparities)=0
void cv_StereoSGBM_setNumDisparities(StereoSGBM self, int numDisparities);

// virtual void setSpeckleRange (int speckleRange)=0
void cv_StereoSGBM_setSpeckleRange(StereoSGBM self, int speckleRange);

// virtual void setSpeckleWindowSize (int speckleWindowSize)=0
void cv_StereoSGBM_setSpeckleWindowSize(StereoSGBM self, int speckleWindowSize);

#ifdef __cplusplus
}
#endif

#endif  //DARTCV_LIBRARY_STEREO_H
