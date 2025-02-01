/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/stitching/stitching.h"
#include <vector>
#include "dartcv/core/vec.hpp"

CvStatus* cv_Stitcher_create(int mode, Stitcher* rval) {
    BEGIN_WRAP
    const auto ptr = cv::Stitcher::create(static_cast<cv::Stitcher::Mode>(mode));
    rval->ptr = new cv::Ptr<cv::Stitcher>(ptr);
    END_WRAP
}

void cv_Stitcher_close(StitcherPtr stitcher) {
    stitcher->ptr->reset();
    CVD_FREE(stitcher);
}

double cv_Stitcher_get_registrationResol(Stitcher self) {
    return (CVDEREF(self))->registrationResol();
}
void cv_Stitcher_set_registrationResol(Stitcher self, double val) {
    (CVDEREF(self))->setRegistrationResol(val);
}

double cv_Stitcher_get_seamEstimationResol(Stitcher self) {
    return (CVDEREF(self))->seamEstimationResol();
}
void cv_Stitcher_set_seamEstimationResol(Stitcher self, double val) {
    (CVDEREF(self))->setSeamEstimationResol(val);
}

double cv_Stitcher_get_compositingResol(Stitcher self) {
    return (CVDEREF(self))->compositingResol();
}
void cv_Stitcher_set_compositingResol(Stitcher self, double val) {
    (CVDEREF(self))->setCompositingResol(val);
}

double cv_Stitcher_get_panoConfidenceThresh(Stitcher self) {
    return (CVDEREF(self))->panoConfidenceThresh();
}
void cv_Stitcher_set_panoConfidenceThresh(Stitcher self, double val) {
    (CVDEREF(self))->setPanoConfidenceThresh(val);
}

bool cv_Stitcher_get_waveCorrection(Stitcher self) {
    return (CVDEREF(self))->waveCorrection();
}
void cv_Stitcher_set_waveCorrection(Stitcher self, bool val) {
    (CVDEREF(self))->setWaveCorrection(val);
}

int cv_Stitcher_get_interpolationFlags(Stitcher self) {
    return (CVDEREF(self))->interpolationFlags();
}
void cv_Stitcher_set_interpolationFlags(Stitcher self, int val) {
    (CVDEREF(self))->setInterpolationFlags(static_cast<cv::InterpolationFlags>(val));
}

int cv_Stitcher_get_waveCorrectKind(Stitcher self) {
    return (CVDEREF(self))->waveCorrectKind();
}
void cv_Stitcher_set_waveCorrectKind(Stitcher self, int val) {
    (CVDEREF(self))->setWaveCorrectKind(static_cast<cv::detail::WaveCorrectKind>(val));
}

CvStatus* cv_Stitcher_estimateTransform(
    Stitcher self, VecMat mats, VecMat masks, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    if (!masks.ptr->empty()) {
        *rval = static_cast<int>((CVDEREF(self))->estimateTransform(CVDEREF(mats), CVDEREF(masks)));
    } else {
        *rval = static_cast<int>((CVDEREF(self))->estimateTransform(CVDEREF(mats)));
    }
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Stitcher_composePanorama(Stitcher self, Mat rpano, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = static_cast<int>((CVDEREF(self))->composePanorama(CVDEREF(rpano)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_Stitcher_composePanorama_1(
    Stitcher self, VecMat mats, Mat rpano, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = static_cast<int>((CVDEREF(self))->composePanorama(CVDEREF(mats), CVDEREF(rpano)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Stitcher_stitch(
    Stitcher self, VecMat mats, Mat rpano, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = static_cast<int>((CVDEREF(self))->stitch(CVDEREF(mats), CVDEREF(rpano)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_Stitcher_stitch_1(
    Stitcher self, VecMat mats, VecMat masks, Mat rpano, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = static_cast<int>((CVDEREF(self))->stitch(CVDEREF(mats), CVDEREF(masks), CVDEREF(rpano)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Stitcher_component(Stitcher self, VecI32* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    std::vector<int> _rval = (CVDEREF(self))->component();
    *rval = {new std::vector<int32_t>(_rval)};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
