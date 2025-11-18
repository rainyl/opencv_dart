//
// Created by rainy on 2025/8/12.
//

#include "stereo.h"

// StereoBM
CvStatus* cv_StereoBM_create(
    int numDisparities, int blockSize, StereoBM* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::StereoBM>(cv::StereoBM::create(numDisparities, blockSize))};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_StereoBM_close(StereoBMPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

// Gets the current truncation value for prefiltered pixels.
// virtual int  getPreFilterCap () const =0
int cv_StereoBM_getPreFilterCap(StereoBM self) {
    return (CVDEREF(self))->getPreFilterCap();
}

// Gets the current size of the pre-filter kernel.
// virtual int  getPreFilterSize () const =0
int cv_StereoBM_getPreFilterSize(StereoBM self) {
    return (CVDEREF(self))->getPreFilterSize();
}

// Gets the type of pre-filtering currently used in the algorithm.
// virtual int  getPreFilterType () const =0
int cv_StereoBM_getPreFilterType(StereoBM self) {
    return (CVDEREF(self))->getPreFilterType();
}

// Gets the current Region of Interest (ROI) for the left image.
// virtual Rect  getROI1 () const =0
CvRect* cv_StereoBM_getROI1(StereoBM self) {
    auto rect = (CVDEREF(self))->getROI1();
    return new CvRect{rect.x, rect.y, rect.width, rect.height};
}

// Gets the current Region of Interest (ROI) for the right image.
// virtual Rect  getROI2 () const =0
CvRect* cv_StereoBM_getROI2(StereoBM self) {
    auto rect = (CVDEREF(self))->getROI2();
    return new CvRect{rect.x, rect.y, rect.width, rect.height};
}

// Gets the current size of the smaller block used for texture check.
// virtual int  getSmallerBlockSize () const =0
int cv_StereoBM_getSmallerBlockSize(StereoBM self) {
    return (CVDEREF(self))->getSmallerBlockSize();
}

// Gets the current texture threshold value.
// virtual int  getTextureThreshold () const =0
int cv_StereoBM_getTextureThreshold(StereoBM self) {
    return (CVDEREF(self))->getTextureThreshold();
}

// Gets the current uniqueness ratio value.
// virtual int  getUniquenessRatio () const =0
int cv_StereoBM_getUniquenessRatio(StereoBM self) {
    return (CVDEREF(self))->getUniquenessRatio();
}

// Sets the truncation value for prefiltered pixels.
// virtual void  setPreFilterCap (int preFilterCap)=0
void cv_StereoBM_setPreFilterCap(StereoBM self, int preFilterCap) {
    (CVDEREF(self))->setPreFilterCap(preFilterCap);
}

// Sets the size of the pre-filter kernel.
// virtual void  setPreFilterSize (int preFilterSize)=0
void cv_StereoBM_setPreFilterSize(StereoBM self, int preFilterSize) {
    (CVDEREF(self))->setPreFilterSize(preFilterSize);
}

// Sets the type of pre-filtering used in the algorithm.
// virtual void  setPreFilterType (int preFilterType)=0
void cv_StereoBM_setPreFilterType(StereoBM self, int preFilterType) {
    (CVDEREF(self))->setPreFilterType(preFilterType);
}

// Sets the Region of Interest (ROI) for the left image.
// virtual void  setROI1 (Rect roi1)=0
void cv_StereoBM_setROI1(StereoBM self, CvRect roi1) {
    auto rect = cv::Rect(roi1.x, roi1.y, roi1.width, roi1.height);
    (CVDEREF(self))->setROI1(rect);
}

// Sets the Region of Interest (ROI) for the right image.
// virtual void  setROI2 (Rect roi2)=0
void cv_StereoBM_setROI2(StereoBM self, CvRect roi2) {
    auto rect = cv::Rect(roi2.x, roi2.y, roi2.width, roi2.height);
    (CVDEREF(self))->setROI2(rect);
}

// Sets the size of the smaller block used for texture check.
// virtual void  setSmallerBlockSize (int blockSize)=0
void cv_StereoBM_setSmallerBlockSize(StereoBM self, int blockSize) {
    (CVDEREF(self))->setSmallerBlockSize(blockSize);
}

// Sets the threshold for filtering low-texture regions.
// virtual void  setTextureThreshold (int textureThreshold)=0
void cv_StereoBM_setTextureThreshold(StereoBM self, int textureThreshold) {
    (CVDEREF(self))->setTextureThreshold(textureThreshold);
}

// Sets the uniqueness ratio for filtering ambiguous matches.
// virtual void  setUniquenessRatio (int uniquenessRatio)=0
void cv_StereoBM_setUniquenessRatio(StereoBM self, int uniquenessRatio) {
    (CVDEREF(self))->setUniquenessRatio(uniquenessRatio);
}

// Computes disparity map for the specified stereo pair.
// virtual void  compute (InputArray left, InputArray right, OutputArray disparity)=0
CvStatus* cv_StereoBM_compute(StereoBM self, MatIn left, MatIn right, MatOut disparity) {
    BEGIN_WRAP(CVDEREF(self))->compute(CVDEREF(left), CVDEREF(right), CVDEREF(disparity));
    END_WRAP
}

// virtual int  getBlockSize () const =0
int cv_StereoBM_getBlockSize(StereoBM self) {
    return (CVDEREF(self))->getBlockSize();
}

// virtual int  getDisp12MaxDiff () const =0
int cv_StereoBM_getDisp12MaxDiff(StereoBM self) {
    return (CVDEREF(self))->getDisp12MaxDiff();
}

// virtual int  getMinDisparity () const =0
int cv_StereoBM_getMinDisparity(StereoBM self) {
    return (CVDEREF(self))->getMinDisparity();
}

// virtual int  getNumDisparities () const =0
int cv_StereoBM_getNumDisparities(StereoBM self) {
    return (CVDEREF(self))->getNumDisparities();
}

// virtual int  getSpeckleRange () const =0
int cv_StereoBM_getSpeckleRange(StereoBM self) {
    return (CVDEREF(self))->getSpeckleRange();
}

// virtual int  getSpeckleWindowSize () const =0
int cv_StereoBM_getSpeckleWindowSize(StereoBM self) {
    return (CVDEREF(self))->getSpeckleWindowSize();
}

// virtual void  setBlockSize (int blockSize)=0
void cv_StereoBM_setBlockSize(StereoBM self, int blockSize) {
    (CVDEREF(self))->setBlockSize(blockSize);
}

// virtual void  setDisp12MaxDiff (int disp12MaxDiff)=0
void cv_StereoBM_setDisp12MaxDiff(StereoBM self, int disp12MaxDiff) {
    (CVDEREF(self))->setDisp12MaxDiff(disp12MaxDiff);
}

// virtual void  setMinDisparity (int minDisparity)=0
void cv_StereoBM_setMinDisparity(StereoBM self, int minDisparity) {
    (CVDEREF(self))->setMinDisparity(minDisparity);
}

// virtual void  setNumDisparities (int numDisparities)=0
void cv_StereoBM_setNumDisparities(StereoBM self, int numDisparities) {
    (CVDEREF(self))->setNumDisparities(numDisparities);
}

// virtual void  setSpeckleRange (int speckleRange)=0
void cv_StereoBM_setSpeckleRange(StereoBM self, int speckleRange) {
    (CVDEREF(self))->setSpeckleRange(speckleRange);
}

// virtual void  setSpeckleWindowSize (int speckleWindowSize)=0
void cv_StereoBM_setSpeckleWindowSize(StereoBM self, int speckleWindowSize) {
    (CVDEREF(self))->setSpeckleWindowSize(speckleWindowSize);
}

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
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::StereoSGBM>(cv::StereoSGBM::create(
        minDisparity,
        numDisparities,
        blockSize,
        P1,
        P2,
        disp12MaxDiff,
        preFilterCap,
        uniquenessRatio,
        speckleWindowSize,
        speckleRange,
        mode
    ))};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_StereoSGBM_close(StereoSGBMPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

// virtual int getMode () const =0
int cv_StereoSGBM_getMode(StereoSGBM self) {
    return (CVDEREF(self))->getMode();
}

// virtual int getP1 () const =0
int cv_StereoSGBM_getP1(StereoSGBM self) {
    return (CVDEREF(self))->getP1();
}

// virtual int getP2 () const =0
int cv_StereoSGBM_getP2(StereoSGBM self) {
    return (CVDEREF(self))->getP2();
}

// virtual int getPreFilterCap () const =0
int cv_StereoSGBM_getPreFilterCap(StereoSGBM self) {
    return (CVDEREF(self))->getPreFilterCap();
}

// virtual int getUniquenessRatio () const =0
int cv_StereoSGBM_getUniquenessRatio(StereoSGBM self) {
    return (CVDEREF(self))->getUniquenessRatio();
}

// virtual void setMode (int mode)=0
void cv_StereoSGBM_setMode(StereoSGBM self, int mode) {
    (CVDEREF(self))->setMode(mode);
}

// virtual void setP1 (int P1)=0
void cv_StereoSGBM_setP1(StereoSGBM self, int P1) {
    (CVDEREF(self))->setP1(P1);
}

// virtual void setP2 (int P2)=0
void cv_StereoSGBM_setP2(StereoSGBM self, int P2) {
    (CVDEREF(self))->setP2(P2);
}

// virtual void setPreFilterCap (int preFilterCap)=0
void cv_StereoSGBM_setPreFilterCap(StereoSGBM self, int preFilterCap) {
    (CVDEREF(self))->setPreFilterCap(preFilterCap);
}

// virtual void setUniquenessRatio (int uniquenessRatio)=0
void cv_StereoSGBM_setUniquenessRatio(StereoSGBM self, int uniquenessRatio) {
    (CVDEREF(self))->setUniquenessRatio(uniquenessRatio);
}

// Computes disparity map for the specified stereo pair.
// virtual void compute (InputArray left, InputArray right, OutputArray disparity)=0
CvStatus* cv_StereoSGBM_compute(StereoSGBM self, MatIn left, MatIn right, MatOut disparity) {
    BEGIN_WRAP(CVDEREF(self))->compute(CVDEREF(left), CVDEREF(right), CVDEREF(disparity));
    END_WRAP
}

// virtual int getBlockSize () const =0
int cv_StereoSGBM_getBlockSize(StereoSGBM self) {
    return (CVDEREF(self))->getBlockSize();
}

// virtual int getDisp12MaxDiff () const =0
int cv_StereoSGBM_getDisp12MaxDiff(StereoSGBM self) {
    return (CVDEREF(self))->getDisp12MaxDiff();
}

// virtual int getMinDisparity () const =0
int cv_StereoSGBM_getMinDisparity(StereoSGBM self) {
    return (CVDEREF(self))->getMinDisparity();
}

// virtual int getNumDisparities () const =0
int cv_StereoSGBM_getNumDisparities(StereoSGBM self) {
    return (CVDEREF(self))->getNumDisparities();
}

// virtual int getSpeckleRange () const =0
int cv_StereoSGBM_getSpeckleRange(StereoSGBM self) {
    return (CVDEREF(self))->getSpeckleRange();
}

// virtual int getSpeckleWindowSize () const =0
int cv_StereoSGBM_getSpeckleWindowSize(StereoSGBM self) {
    return (CVDEREF(self))->getSpeckleWindowSize();
}

// virtual void setBlockSize (int blockSize)=0
void cv_StereoSGBM_setBlockSize(StereoSGBM self, int blockSize) {
    (CVDEREF(self))->setBlockSize(blockSize);
}

// virtual void setDisp12MaxDiff (int disp12MaxDiff)=0
void cv_StereoSGBM_setDisp12MaxDiff(StereoSGBM self, int disp12MaxDiff) {
    (CVDEREF(self))->setDisp12MaxDiff(disp12MaxDiff);
}

// virtual void setMinDisparity (int minDisparity)=0
void cv_StereoSGBM_setMinDisparity(StereoSGBM self, int minDisparity) {
    (CVDEREF(self))->setMinDisparity(minDisparity);
}

// virtual void setNumDisparities (int numDisparities)=0
void cv_StereoSGBM_setNumDisparities(StereoSGBM self, int numDisparities) {
    (CVDEREF(self))->setNumDisparities(numDisparities);
}

// virtual void setSpeckleRange (int speckleRange)=0
void cv_StereoSGBM_setSpeckleRange(StereoSGBM self, int speckleRange) {
    (CVDEREF(self))->setSpeckleRange(speckleRange);
}

// virtual void setSpeckleWindowSize (int speckleWindowSize)=0
void cv_StereoSGBM_setSpeckleWindowSize(StereoSGBM self, int speckleWindowSize) {
    (CVDEREF(self))->setSpeckleWindowSize(speckleWindowSize);
}
