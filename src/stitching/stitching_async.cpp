/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#include "stitching_async.h"
#include "core/types.h"

// Asynchronous functions for Stitcher_Create
CvStatus *Stitcher_Create_Async(int mode, CvCallback_1 callback)
{
    BEGIN_WRAP
    const auto ptr = cv::Stitcher::create(static_cast<cv::Stitcher::Mode>(mode));
    callback(new Stitcher{new cv::Ptr<cv::Stitcher>(ptr)});
    END_WRAP
}

// Asynchronous getter/setter functions
CvStatus *Stitcher_GetRegistrationResol_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new double((*self.ptr)->registrationResol()));
    END_WRAP
}

CvStatus *Stitcher_SetRegistrationResol_Async(Stitcher self, double inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setRegistrationResol(inval);
    callback();
    END_WRAP
}

CvStatus *Stitcher_GetSeamEstimationResol_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new double((*self.ptr)->seamEstimationResol()));
    END_WRAP
}

CvStatus *Stitcher_SetSeamEstimationResol_Async(Stitcher self, double inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setSeamEstimationResol(inval);
    callback();
    END_WRAP
}

CvStatus *Stitcher_GetCompositingResol_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new double((*self.ptr)->compositingResol()));
    END_WRAP
}

CvStatus *Stitcher_SetCompositingResol_Async(Stitcher self, double inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setCompositingResol(inval);
    callback();
    END_WRAP
}

CvStatus *Stitcher_GetPanoConfidenceThresh_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new double((*self.ptr)->panoConfidenceThresh()));
    END_WRAP
}

CvStatus *Stitcher_SetPanoConfidenceThresh_Async(Stitcher self, double inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setPanoConfidenceThresh(inval);
    callback();
    END_WRAP
}

CvStatus *Stitcher_GetWaveCorrection_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new bool((*self.ptr)->waveCorrection()));
    END_WRAP
}

CvStatus *Stitcher_SetWaveCorrection_Async(Stitcher self, bool inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setWaveCorrection(inval);
    callback();
    END_WRAP
}

CvStatus *Stitcher_GetInterpolationFlags_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new int(static_cast<int>((*self.ptr)->interpolationFlags())));
    END_WRAP
}

CvStatus *Stitcher_SetInterpolationFlags_Async(Stitcher self, int inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setInterpolationFlags(static_cast<cv::InterpolationFlags>(inval));
    callback();
    END_WRAP
}

CvStatus *Stitcher_GetWaveCorrectKind_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    callback(new int(static_cast<int>((*self.ptr)->waveCorrectKind())));
    END_WRAP
}

CvStatus *Stitcher_SetWaveCorrectKind_Async(Stitcher self, int inval, CvCallback_0 callback)
{
    BEGIN_WRAP
    (*self.ptr)->setWaveCorrectKind(static_cast<cv::detail::WaveCorrectKind>(inval));
    callback();
    END_WRAP
}

// Asynchronous functions
CvStatus *Stitcher_EstimateTransform_Async(Stitcher self, VecMat mats, VecMat masks, CvCallback_1 callback)
{
    BEGIN_WRAP
    int rval;
    if (masks.ptr->size() > 0)
    {
        rval = static_cast<int>((*self.ptr)->estimateTransform(*mats.ptr, *masks.ptr));
    }
    else
    {
        rval = static_cast<int>((*self.ptr)->estimateTransform(*mats.ptr));
    }
    callback(new int(rval));
    END_WRAP
}

CvStatus *Stitcher_ComposePanorama_Async(Stitcher self, CvCallback_2 callback)
{
    BEGIN_WRAP
        cv::Mat ـrpano;

    int rval = static_cast<int>((*self.ptr)->composePanorama(ـrpano));
    callback(new int(rval), new Mat{new cv::Mat(ـrpano)});
    END_WRAP
}

CvStatus *Stitcher_ComposePanorama_1_Async(Stitcher self, VecMat mats, CvCallback_2 callback)
{
    BEGIN_WRAP
        cv::Mat ـrpano;

    int rval = static_cast<int>((*self.ptr)->composePanorama(*mats.ptr, ـrpano));
    callback(new int(rval), new Mat{new cv::Mat(ـrpano)});
    END_WRAP
}

CvStatus *Stitcher_Stitch_Async(Stitcher self, VecMat mats, CvCallback_2 callback)
{
    BEGIN_WRAP
    cv::Mat ـrpano;

    int rval = static_cast<int>((*self.ptr)->stitch(*mats.ptr, ـrpano));
    callback(new int(rval), new Mat{new cv::Mat(ـrpano)});
    END_WRAP
}

CvStatus *Stitcher_Stitch_1_Async(Stitcher self, VecMat mats, VecMat masks, CvCallback_2 callback)
{
    BEGIN_WRAP
    cv::Mat ـrpano;
    int rval = static_cast<int>((*self.ptr)->stitch(*mats.ptr, *masks.ptr, ـrpano));
    callback(new int(rval), new Mat{new cv::Mat(ـrpano)});
    END_WRAP
}

CvStatus *Stitcher_Component_Async(Stitcher self, CvCallback_1 callback)
{
    BEGIN_WRAP
    std::vector<int> _rval = (*self.ptr)->component();
    callback(new VecInt{new std::vector<int>(_rval)});
    END_WRAP
}
