/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/features2d/features2d.h"
#include <opencv2/core/cvstd_wrapper.hpp>
#include <opencv2/features2d.hpp>
#include "dartcv/core/vec.hpp"
#include "dartcv/features2d/utils.hpp"

CvStatus* cv_AKAZE_create(AKAZE* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::AKAZE>(cv::AKAZE::create());
    END_WRAP
}

CvStatus* cv_AKAZE_create_1(
    int descriptor_type,
    int descriptor_size,
    int descriptor_channels,
    float threshold,
    int nOctaves,
    int nOctaveLayers,
    int diffusivity,
    int max_points,
    AKAZE* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::AKAZE>(cv::AKAZE::create(
        static_cast<cv::AKAZE::DescriptorType>(descriptor_type),
        descriptor_size,
        descriptor_channels,
        threshold,
        nOctaves,
        nOctaveLayers,
        static_cast<cv::KAZE::DiffusivityType>(diffusivity),
        max_points
    ));
    END_WRAP
}

void cv_AKAZE_close(AKAZEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_AKAZE_detect(AKAZE self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_AKAZE_detectAndCompute(
    AKAZE self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );

    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_AKAZE_empty(AKAZE self) {
    return CVDEREF(self)->empty();
}

char* cv_AKAZE_getDefaultName(AKAZE self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
// virtual int 	getDescriptorChannels () const =0
int cv_AKAZE_getDescriptorChannels(AKAZE self) {
    return CVDEREF(self)->getDescriptorChannels();
}
// virtual int 	getDescriptorSize () const =0
int cv_AKAZE_getDescriptorSize(AKAZE self) {
    return CVDEREF(self)->getDescriptorSize();
}
// virtual AKAZE::DescriptorType 	getDescriptorType () const =0
int cv_AKAZE_getDescriptorType(AKAZE self) {
    return CVDEREF(self)->getDescriptorType();
}
// virtual KAZE::DiffusivityType 	getDiffusivity () const =0
int cv_AKAZE_getDiffusivity(AKAZE self) {
    return CVDEREF(self)->getDiffusivity();
}
// virtual int 	getMaxPoints () const =0
int cv_AKAZE_getMaxPoints(AKAZE self) {
    return CVDEREF(self)->getMaxPoints();
}
// virtual int 	getNOctaveLayers () const =0
int cv_AKAZE_getNOctaveLayers(AKAZE self) {
    return CVDEREF(self)->getNOctaveLayers();
}
// virtual int 	getNOctaves () const =0
int cv_AKAZE_getNOctaves(AKAZE self) {
    return CVDEREF(self)->getNOctaves();
}
// virtual double 	getThreshold () const =0
double cv_AKAZE_getThreshold(AKAZE self) {
    return CVDEREF(self)->getThreshold();
}
// virtual void 	setDescriptorChannels (int dch)=0
void cv_AKAZE_setDescriptorChannels(AKAZE self, int dch) {
    CVDEREF(self)->setDescriptorChannels(dch);
}
// virtual void 	setDescriptorSize (int dsize)=0
void cv_AKAZE_setDescriptorSize(AKAZE self, int dsize) {
    CVDEREF(self)->setDescriptorSize(dsize);
}
// virtual void 	setDescriptorType (AKAZE::DescriptorType dtype)=0
void cv_AKAZE_setDescriptorType(AKAZE self, int dtype) {
    CVDEREF(self)->setDescriptorType(static_cast<cv::AKAZE::DescriptorType>(dtype));
}
// virtual void 	setDiffusivity (KAZE::DiffusivityType diff)=0
void cv_AKAZE_setDiffusivity(AKAZE self, int diff) {
    CVDEREF(self)->setDiffusivity(static_cast<cv::KAZE::DiffusivityType>(diff));
}
// virtual void 	setMaxPoints (int max_points)=0
void cv_AKAZE_setMaxPoints(AKAZE self, int max_points) {
    CVDEREF(self)->setMaxPoints(max_points);
}
// virtual void 	setNOctaveLayers (int octaveLayers)=0
void cv_AKAZE_setNOctaveLayers(AKAZE self, int octaveLayers) {
    CVDEREF(self)->setNOctaveLayers(octaveLayers);
}
// virtual void 	setNOctaves (int octaves)=0
void cv_AKAZE_setNOctaves(AKAZE self, int octaves) {
    CVDEREF(self)->setNOctaves(octaves);
}
// virtual void 	setThreshold (double threshold)=0
void cv_AKAZE_setThreshold(AKAZE self, double threshold) {
    CVDEREF(self)->setThreshold(threshold);
}

CvStatus* cv_AgastFeatureDetector_create(AgastFeatureDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create());
    END_WRAP
}

CvStatus* cv_AgastFeatureDetector_create_1(
    int threshold, bool nonmaxSuppression, int type, AgastFeatureDetector* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::AgastFeatureDetector>(cv::AgastFeatureDetector::create(
        threshold, nonmaxSuppression, static_cast<cv::AgastFeatureDetector::DetectorType>(type)
    ));
    END_WRAP
}

void cv_AgastFeatureDetector_close(AgastFeatureDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_AgastFeatureDetector_detect(
    AgastFeatureDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

// detectAndCompute (InputArray image, InputArray mask, std::vector< KeyPoint > &keypoints, OutputArray descriptors, bool useProvidedKeypoints=false)
CvStatus* cv_AgastFeatureDetector_detectAndCompute(
    AgastFeatureDetector self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );

    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_AgastFeatureDetector_empty(AgastFeatureDetector self) {
    return CVDEREF(self)->empty();
}

// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_AgastFeatureDetector_getDefaultName(AgastFeatureDetector self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
// virtual bool 	getNonmaxSuppression () const =0
bool cv_AgastFeatureDetector_getNonmaxSuppression(AgastFeatureDetector self) {
    return CVDEREF(self)->getNonmaxSuppression();
}
// virtual int 	getThreshold () const =0
int cv_AgastFeatureDetector_getThreshold(AgastFeatureDetector self) {
    return CVDEREF(self)->getThreshold();
}
// virtual AgastFeatureDetector::DetectorType 	getType () const =0
int cv_AgastFeatureDetector_getType(AgastFeatureDetector self) {
    return CVDEREF(self)->getType();
}
// virtual void 	setNonmaxSuppression (bool f)=0
void cv_AgastFeatureDetector_setNonmaxSuppression(AgastFeatureDetector self, bool f) {
    CVDEREF(self)->setNonmaxSuppression(f);
}
// virtual void 	setThreshold (int threshold)=0
void cv_AgastFeatureDetector_setThreshold(AgastFeatureDetector self, int threshold) {
    CVDEREF(self)->setThreshold(threshold);
}
// virtual void 	setType (AgastFeatureDetector::DetectorType type)=0
void cv_AgastFeatureDetector_setType(AgastFeatureDetector self, int type) {
    CVDEREF(self)->setType(static_cast<cv::AgastFeatureDetector::DetectorType>(type));
}

CvStatus* cv_BRISK_create(BRISK* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BRISK>(cv::BRISK::create());
    END_WRAP
}

CvStatus* cv_BRISK_create_1(
    VecF32 radiusList, VecI32 numberList, float dMax, float dMin, VecI32 indexChange, BRISK* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BRISK>(cv::BRISK::create(
        CVDEREF(radiusList), CVDEREF(numberList), dMax, dMin, CVDEREF(indexChange)
    ));
    END_WRAP
}

CvStatus* cv_BRISK_create_2(
    int thresh,
    int octaves,
    VecF32 radiusList,
    VecI32 numberList,
    float dMax,
    float dMin,
    VecI32 indexChange,
    BRISK* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BRISK>(cv::BRISK::create(
        thresh, octaves, CVDEREF(radiusList), CVDEREF(numberList), dMax, dMin, CVDEREF(indexChange)
    ));
    END_WRAP
}

CvStatus* cv_BRISK_create_3(int thresh, int octaves, float patternScale, BRISK* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BRISK>(cv::BRISK::create(thresh, octaves, patternScale));
    END_WRAP
}

void cv_BRISK_close(BRISKPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_BRISK_detect(BRISK self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_BRISK_detectAndCompute(
    BRISK self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_BRISK_empty(BRISK self) {
    return CVDEREF(self)->empty();
}

char* cv_BRISK_getDefaultName(BRISK self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
int cv_BRISK_getOctaves(BRISK self) {
    return CVDEREF(self)->getOctaves();
}
float cv_BRISK_getPatternScale(BRISK self) {
    return CVDEREF(self)->getPatternScale();
}
int cv_BRISK_getThreshold(BRISK self) {
    return CVDEREF(self)->getThreshold();
}
void cv_BRISK_setOctaves(BRISK self, int octaves) {
    CVDEREF(self)->setOctaves(octaves);
}
void cv_BRISK_setPatternScale(BRISK self, float patternScale) {
    CVDEREF(self)->setPatternScale(patternScale);
}
void cv_BRISK_setThreshold(BRISK self, int threshold) {
    CVDEREF(self)->setThreshold(threshold);
}

CvStatus* cv_FastFeatureDetector_create(FastFeatureDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::FastFeatureDetector>(cv::FastFeatureDetector::create());
    END_WRAP
}

CvStatus* cv_FastFeatureDetector_create_1(
    int threshold, bool nonmaxSuppression, int type, FastFeatureDetector* rval
) {
    BEGIN_WRAP
    auto type_ = static_cast<cv::FastFeatureDetector::DetectorType>(type);
    rval->ptr = new cv::Ptr<cv::FastFeatureDetector>(
        cv::FastFeatureDetector::create(threshold, nonmaxSuppression, type_)
    );
    END_WRAP
}

void cv_FastFeatureDetector_close(FastFeatureDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_FastFeatureDetector_detect(
    FastFeatureDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_FastFeatureDetector_detectAndCompute(
    FastFeatureDetector self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_FastFeatureDetector_empty(FastFeatureDetector self) {
    return CVDEREF(self)->empty();
}

char* cv_FastFeatureDetector_getDefaultName(FastFeatureDetector self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}

bool cv_FastFeatureDetector_getNonmaxSuppression(FastFeatureDetector self) {
    return CVDEREF(self)->getNonmaxSuppression();
}

int cv_FastFeatureDetector_getThreshold(FastFeatureDetector self) {
    return CVDEREF(self)->getThreshold();
}

int cv_FastFeatureDetector_getType(FastFeatureDetector self) {
    return CVDEREF(self)->getType();
}

void cv_FastFeatureDetector_setNonmaxSuppression(FastFeatureDetector self, bool f) {
    CVDEREF(self)->setNonmaxSuppression(f);
}

void cv_FastFeatureDetector_setThreshold(FastFeatureDetector self, int threshold) {
    CVDEREF(self)->setThreshold(threshold);
}

void cv_FastFeatureDetector_setType(FastFeatureDetector self, int type) {
    CVDEREF(self)->setType(static_cast<cv::FastFeatureDetector::DetectorType>(type));
}

CvStatus* cv_GFTTDetector_create(GFTTDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create());
    END_WRAP
}

CvStatus* cv_GFTTDetector_create_1(
    int maxCorners,
    double qualityLevel,
    double minDistance,
    int blockSize,
    int gradiantSize,
    bool useHarrisDetector,
    double k,
    GFTTDetector* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create(
        maxCorners, qualityLevel, minDistance, blockSize, gradiantSize, useHarrisDetector, k
    ));
    END_WRAP
}

CvStatus* cv_GFTTDetector_create_2(
    int maxCorners,
    double qualityLevel,
    double minDistance,
    int blockSize,
    bool useHarrisDetector,
    double k,
    GFTTDetector* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::GFTTDetector>(cv::GFTTDetector::create(
        maxCorners, qualityLevel, minDistance, blockSize, useHarrisDetector, k
    ));
    END_WRAP
}

void cv_GFTTDetector_close(GFTTDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_GFTTDetector_detect(
    GFTTDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_GFTTDetector_detectAndCompute(
    GFTTDetector self,
    Mat src,
    Mat mask,
    Mat descriptors,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(descriptors), useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_GFTTDetector_empty(GFTTDetector self) {
    return CVDEREF(self)->empty();
}

int cv_GFTTDetector_getBlockSize(GFTTDetector self) {
    return CVDEREF(self)->getBlockSize();
}
char* cv_GFTTDetector_getDefaultName(GFTTDetector self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
int cv_GFTTDetector_getGradientSize(GFTTDetector self) {
    return CVDEREF(self)->getGradientSize();
}
bool cv_GFTTDetector_getHarrisDetector(GFTTDetector self) {
    return CVDEREF(self)->getHarrisDetector();
}
double cv_GFTTDetector_getK(GFTTDetector self) {
    return CVDEREF(self)->getK();
}
int cv_GFTTDetector_getMaxFeatures(GFTTDetector self) {
    return CVDEREF(self)->getMaxFeatures();
}
double cv_GFTTDetector_getMinDistance(GFTTDetector self) {
    return CVDEREF(self)->getMinDistance();
}
double cv_GFTTDetector_getQualityLevel(GFTTDetector self) {
    return CVDEREF(self)->getQualityLevel();
}
void cv_GFTTDetector_setBlockSize(GFTTDetector self, int blockSize) {
    CVDEREF(self)->setBlockSize(blockSize);
}
void cv_GFTTDetector_setGradientSize(GFTTDetector self, int gradientSize_) {
    CVDEREF(self)->setGradientSize(gradientSize_);
}
void cv_GFTTDetector_setHarrisDetector(GFTTDetector self, bool val) {
    CVDEREF(self)->setHarrisDetector(val);
}
void cv_GFTTDetector_setK(GFTTDetector self, double k) {
    CVDEREF(self)->setK(k);
}
void cv_GFTTDetector_setMaxFeatures(GFTTDetector self, int maxFeatures) {
    CVDEREF(self)->setMaxFeatures(maxFeatures);
}
void cv_GFTTDetector_setMinDistance(GFTTDetector self, double minDistance) {
    CVDEREF(self)->setMinDistance(minDistance);
}
void cv_GFTTDetector_setQualityLevel(GFTTDetector self, double qlevel) {
    CVDEREF(self)->setQualityLevel(qlevel);
}

CvStatus* cv_KAZE_create(KAZE* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::KAZE>(cv::KAZE::create());
    END_WRAP
}

CvStatus* cv_KAZE_create_1(
    bool extended,
    bool upright,
    float threshold,
    int nOctaves,
    int nOctaveLayers,
    int diffusivity,
    KAZE* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::KAZE>(cv::KAZE::create(
        extended,
        upright,
        threshold,
        nOctaves,
        nOctaveLayers,
        static_cast<cv::KAZE::DiffusivityType>(diffusivity)
    ));
    END_WRAP
}

void cv_KAZE_close(KAZEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_KAZE_detect(KAZE self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_KAZE_detectAndCompute(
    KAZE self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_KAZE_empty(KAZE self) {
    return CVDEREF(self)->empty();
}

char* cv_KAZE_getDefaultName(KAZE self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}

int cv_KAZE_getDiffusivity(KAZE self) {
    return CVDEREF(self)->getDiffusivity();
}

bool cv_KAZE_getExtended(KAZE self) {
    return CVDEREF(self)->getExtended();
}

int cv_KAZE_getNOctaveLayers(KAZE self) {
    return CVDEREF(self)->getNOctaveLayers();
}

int cv_KAZE_getNOctaves(KAZE self) {
    return CVDEREF(self)->getNOctaves();
}

double cv_KAZE_getThreshold(KAZE self) {
    return CVDEREF(self)->getThreshold();
}

bool cv_KAZE_getUpright(KAZE self) {
    return CVDEREF(self)->getUpright();
}

void cv_KAZE_setDiffusivity(KAZE self, int diff) {
    CVDEREF(self)->setDiffusivity(static_cast<cv::KAZE::DiffusivityType>(diff));
}

void cv_KAZE_setExtended(KAZE self, bool extended) {
    CVDEREF(self)->setExtended(extended);
}

void cv_KAZE_setNOctaveLayers(KAZE self, int octaveLayers) {
    CVDEREF(self)->setNOctaveLayers(octaveLayers);
}

void cv_KAZE_setNOctaves(KAZE self, int octaves) {
    CVDEREF(self)->setNOctaves(octaves);
}

void cv_KAZE_setThreshold(KAZE self, double threshold) {
    CVDEREF(self)->setThreshold(threshold);
}

void cv_KAZE_setUpright(KAZE self, bool upright) {
    CVDEREF(self)->setUpright(upright);
}

CvStatus* cv_MSER_create(MSER* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::MSER>(cv::MSER::create());
    END_WRAP
}

CvStatus* cv_MSER_create_1(
    int delta,
    int min_area,
    int max_area,
    double max_variation,
    double min_diversity,
    int max_evolution,
    double area_threshold,
    double min_margin,
    int edge_blur_size,
    MSER* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::MSER>(cv::MSER::create(
        delta,
        min_area,
        max_area,
        max_variation,
        min_diversity,
        max_evolution,
        area_threshold,
        min_margin,
        edge_blur_size
    ));
    END_WRAP
}

void cv_MSER_close(MSERPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_MSER_detect(MSER self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_MSER_detectAndCompute(
    MSER self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );
    if (callback) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_MSER_detectRegions(
    MSER self, Mat image, VecVecPoint* rval, VecRect* bboxes, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detectRegions(CVDEREF(image), CVDEREF_P(rval), CVDEREF_P(bboxes));
    if (callback) {
        callback();
    }
    END_WRAP
}

bool cv_MSER_empty(MSER self) {
    return CVDEREF(self)->empty();
}

double cv_MSER_getAreaThreshold(MSER self) {
    return (CVDEREF(self))->getAreaThreshold();
}
char* cv_MSER_getDefaultName(MSER self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
int cv_MSER_getDelta(MSER self) {
    return (CVDEREF(self))->getDelta();
}
int cv_MSER_getEdgeBlurSize(MSER self) {
    return (CVDEREF(self))->getEdgeBlurSize();
}
int cv_MSER_getMaxArea(MSER self) {
    return (CVDEREF(self))->getMaxArea();
}
int cv_MSER_getMaxEvolution(MSER self) {
    return (CVDEREF(self))->getMaxEvolution();
}
double cv_MSER_getMaxVariation(MSER self) {
    return (CVDEREF(self))->getMaxVariation();
}
int cv_MSER_getMinArea(MSER self) {
    return (CVDEREF(self))->getMinArea();
}
double cv_MSER_getMinDiversity(MSER self) {
    return (CVDEREF(self))->getMinDiversity();
}
double cv_MSER_getMinMargin(MSER self) {
    return (CVDEREF(self))->getMinMargin();
}
bool cv_MSER_getPass2Only(MSER self) {
    return (CVDEREF(self))->getPass2Only();
}
void cv_MSER_setAreaThreshold(MSER self, double areaThreshold) {
    (CVDEREF(self))->setAreaThreshold(areaThreshold);
}
void cv_MSER_setDelta(MSER self, int delta) {
    (CVDEREF(self))->setDelta(delta);
}
void cv_MSER_setEdgeBlurSize(MSER self, int edge_blur_size) {
    (CVDEREF(self))->setEdgeBlurSize(edge_blur_size);
}
void cv_MSER_setMaxArea(MSER self, int maxArea) {
    (CVDEREF(self))->setMaxArea(maxArea);
}
void cv_MSER_setMaxEvolution(MSER self, int maxEvolution) {
    (CVDEREF(self))->setMaxEvolution(maxEvolution);
}
void cv_MSER_setMaxVariation(MSER self, double maxVariation) {
    (CVDEREF(self))->setMaxVariation(maxVariation);
}
void cv_MSER_setMinArea(MSER self, int minArea) {
    (CVDEREF(self))->setMinArea(minArea);
}
void cv_MSER_setMinDiversity(MSER self, double minDiversity) {
    (CVDEREF(self))->setMinDiversity(minDiversity);
}
void cv_MSER_setMinMargin(MSER self, double min_margin) {
    (CVDEREF(self))->setMinMargin(min_margin);
}
void cv_MSER_setPass2Only(MSER self, bool f) {
    (CVDEREF(self))->setPass2Only(f);
}

CvStatus* cv_ORB_create(ORB* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::ORB>(cv::ORB::create());
    END_WRAP
}

CvStatus* cv_ORB_create_1(
    int nfeatures,
    float scaleFactor,
    int nlevels,
    int edgeThreshold,
    int firstLevel,
    int WTA_K,
    int scoreType,
    int patchSize,
    int fastThreshold,
    ORB* rval
) {
    BEGIN_WRAP
    auto type = static_cast<cv::ORB::ScoreType>(scoreType);
    rval->ptr = new cv::Ptr<cv::ORB>(cv::ORB::create(
        nfeatures,
        scaleFactor,
        nlevels,
        edgeThreshold,
        firstLevel,
        WTA_K,
        type,
        patchSize,
        fastThreshold
    ));
    END_WRAP
}

void cv_ORB_close(ORBPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_ORB_detect(ORB self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP(*self.ptr)->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ORB_detectAndCompute(
    ORB self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* out_keypoints,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src),
            CVDEREF(mask),
            CVDEREF_P(out_keypoints),
            CVDEREF(desc),
            useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_ORB_empty(ORB self) {
    return CVDEREF(self)->empty();
}

char* cv_ORB_getDefaultName(ORB self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
int cv_ORB_getEdgeThreshold(ORB self) {
    return CVDEREF(self)->getEdgeThreshold();
}
int cv_ORB_getFastThreshold(ORB self) {
    return CVDEREF(self)->getFastThreshold();
}
int cv_ORB_getFirstLevel(ORB self) {
    return CVDEREF(self)->getFirstLevel();
}
int cv_ORB_getMaxFeatures(ORB self) {
    return CVDEREF(self)->getMaxFeatures();
}
int cv_ORB_getNLevels(ORB self) {
    return CVDEREF(self)->getNLevels();
}
int cv_ORB_getPatchSize(ORB self) {
    return CVDEREF(self)->getPatchSize();
}
double cv_ORB_getScaleFactor(ORB self) {
    return CVDEREF(self)->getScaleFactor();
}
int cv_ORB_getScoreType(ORB self) {
    return CVDEREF(self)->getScoreType();
}
int cv_ORB_getWTA_K(ORB self) {
    return CVDEREF(self)->getWTA_K();
}
void cv_ORB_setEdgeThreshold(ORB self, int edgeThreshold) {
    CVDEREF(self)->setEdgeThreshold(edgeThreshold);
}
void cv_ORB_setFastThreshold(ORB self, int fastThreshold) {
    CVDEREF(self)->setFastThreshold(fastThreshold);
}
void cv_ORB_setFirstLevel(ORB self, int firstLevel) {
    CVDEREF(self)->setFirstLevel(firstLevel);
}
void cv_ORB_setMaxFeatures(ORB self, int maxFeatures) {
    CVDEREF(self)->setMaxFeatures(maxFeatures);
}
void cv_ORB_setNLevels(ORB self, int nlevels) {
    CVDEREF(self)->setNLevels(nlevels);
}
void cv_ORB_setPatchSize(ORB self, int patchSize) {
    CVDEREF(self)->setPatchSize(patchSize);
}
void cv_ORB_setScaleFactor(ORB self, double scaleFactor) {
    CVDEREF(self)->setScaleFactor(scaleFactor);
}
void cv_ORB_setScoreType(ORB self, int scoreType) {
    CVDEREF(self)->setScoreType(static_cast<cv::ORB::ScoreType>(scoreType));
}
void cv_ORB_setWTA_K(ORB self, int wta_k) {
    CVDEREF(self)->setWTA_K(wta_k);
}

CvStatus* cv_SimpleBlobDetector_create(SimpleBlobDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SimpleBlobDetector>(cv::SimpleBlobDetector::create());
    END_WRAP
}

CvStatus* cv_SimpleBlobDetector_create_1(
    SimpleBlobDetectorParams params, SimpleBlobDetector* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SimpleBlobDetector>(
        cv::SimpleBlobDetector::create(SimpleBlobDetectorParams_c2cpp(params))
    );
    END_WRAP
}

void cv_SimpleBlobDetector_close(SimpleBlobDetectorPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_SimpleBlobDetector_detect(
    SimpleBlobDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SimpleBlobDetector_detectAndCompute(
    SimpleBlobDetector self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_SimpleBlobDetector_empty(SimpleBlobDetector self) {
    return CVDEREF(self)->empty();
}

VecVecPoint* cv_SimpleBlobDetector_getBlobContours(SimpleBlobDetector self) {
    return new VecVecPoint{new std::vector<std::vector<cv::Point>>(CVDEREF(self)->getBlobContours())};
}

char* cv_SimpleBlobDetector_getDefaultName(SimpleBlobDetector self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}

SimpleBlobDetectorParams* cv_SimpleBlobDetector_getParams(SimpleBlobDetector self) {
    auto params = CVDEREF(self)->getParams();
    return new SimpleBlobDetectorParams{SimpleBlobDetectorParams_cpp2c(params)};
}

void cv_SimpleBlobDetector_setParams(SimpleBlobDetector self, SimpleBlobDetectorParams params) {
    CVDEREF(self)->setParams(SimpleBlobDetectorParams_c2cpp(params));
}

CvStatus* cv_SimpleBlobDetectorParams_create(SimpleBlobDetectorParams* rval) {
    BEGIN_WRAP
    *rval = SimpleBlobDetectorParams_cpp2c(cv::SimpleBlobDetector::Params());
    END_WRAP
}

CvStatus* cv_BFMatcher_create(BFMatcher* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create());
    END_WRAP
}

CvStatus* cv_BFMatcher_create_1(int normType, bool crossCheck, BFMatcher* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::BFMatcher>(cv::BFMatcher::create(normType, crossCheck));
    END_WRAP
}

void cv_BFMatcher_close(BFMatcherPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_BFMatcher_match(
    BFMatcher self, Mat query, Mat train, VecDMatch* rval, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->match(CVDEREF(query), CVDEREF(train), CVDEREF_P(rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_BFMatcher_knnMatch(
    BFMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->knnMatch(CVDEREF(query), CVDEREF(train), CVDEREF_P(rval), k);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_flann_IndexParams_create(FlannIndexParams* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::flann::IndexParams>(new cv::flann::IndexParams());
    END_WRAP
}

void cv_flann_IndexParams_close(FlannIndexParamsPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

void cv_flann_IndexParams_setString(FlannIndexParams self, const char* key, const char* value) {
    (CVDEREF(self))->setString(key, value);
}

void cv_flann_IndexParams_setInt(FlannIndexParams self, const char* key, int value) {
    (CVDEREF(self))->setInt(key, value);
}

void cv_flann_IndexParams_setDouble(FlannIndexParams self, const char* key, double value) {
    (CVDEREF(self))->setDouble(key, value);
}

void cv_flann_IndexParams_setFloat(FlannIndexParams self, const char* key, float value) {
    (CVDEREF(self))->setFloat(key, value);
}

void cv_flann_IndexParams_setBool(FlannIndexParams self, const char* key, bool value) {
    (CVDEREF(self))->setBool(key, value);
}

void cv_flann_IndexParams_setAlgorithm(FlannIndexParams self, int value) {
    (CVDEREF(self))->setAlgorithm(value);
}

void cv_flann_IndexParams_getString(
    FlannIndexParams self, const char* key, const char* defaultValue, char** rval
) {
    std::string rval_cpp = (CVDEREF(self))->getString(key, defaultValue);
    *rval = strdup(rval_cpp.c_str());
}

void cv_flann_IndexParams_getInt(
    FlannIndexParams self, const char* key, int defaultValue, int* rval
) {
    *rval = (CVDEREF(self))->getInt(key, defaultValue);
}

void cv_flann_IndexParams_getDouble(
    FlannIndexParams self, const char* key, double defaultValue, double* rval
) {
    *rval = (CVDEREF(self))->getDouble(key, defaultValue);
}

// void cv_flann_IndexParams_getBool(
//     FlannIndexParams self, const char* key, bool defaultValue, bool* rval
// ){
//     auto val = (CVDEREF(self))->getInt(key, defaultValue);
//     *rval = (val != 0);
// }

void cv_flann_IndexParams_getAll(
    FlannIndexParams self,
    VecVecChar* names,
    VecI32* types,
    VecVecChar* strValues,
    VecF64* numValues
) {
    std::vector<cv::String> names_cpp;
    std::vector<cv::flann::FlannIndexType> types_cpp;
    std::vector<cv::String> strValues_cpp;
    (CVDEREF(self))->getAll(names_cpp, types_cpp, strValues_cpp, CVDEREF_P(numValues));

    names->ptr = vecstr_2_vecvecchar(names_cpp);
    strValues->ptr = vecstr_2_vecvecchar(strValues_cpp);

    types->ptr->clear();
    types->ptr->reserve(types_cpp.size());
    for (const auto& type : types_cpp) {
        types->ptr->push_back(static_cast<int>(type));
    }
}

void* cv_flann_IndexParams_params_ptr(FlannIndexParams self) {
    return (CVDEREF(self))->params;
}

CvStatus* cv_FlannBasedMatcher_create(FlannBasedMatcher* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::FlannBasedMatcher>(cv::FlannBasedMatcher::create());
    END_WRAP
}

CvStatus* cv_FlannBasedMatcher_create_1(
    FlannBasedMatcher* rval, FlannIndexParams indexParams, FlannIndexParams searchParams
) {
    BEGIN_WRAP
    int checks = (CVDEREF(searchParams))->getInt("checks", 32);
    float eps = (CVDEREF(searchParams))->getDouble("eps", 0.0);
    bool sorted = (CVDEREF(searchParams))->getInt("sorted", true);
    bool explore_all_trees = (CVDEREF(searchParams))->getInt("explore_all_trees", false);

    auto _searchParams =
        cv::makePtr<cv::flann::SearchParams>(checks, eps, sorted, explore_all_trees);

    rval->ptr = new cv::Ptr<cv::FlannBasedMatcher>(
        cv::makePtr<cv::FlannBasedMatcher>(CVDEREF(indexParams), _searchParams)
    );
    END_WRAP
}

void cv_FlannBasedMatcher_close(FlannBasedMatcherPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_FlannBasedMatcher_knnMatch(
    FlannBasedMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->knnMatch(CVDEREF(query), CVDEREF(train), CVDEREF_P(rval), k);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_drawKeyPoints(
    Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto color_ = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
    cv::drawKeypoints(
        CVDEREF(src), CVDEREF(kp), CVDEREF(dst), color_, static_cast<cv::DrawMatchesFlags>(flags)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SIFT_create(SIFT* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SIFT>(cv::SIFT::create());
    END_WRAP
}

CvStatus* cv_SIFT_create_1(
    int nfeatures,
    int nOctaveLayers,
    double contrastThreshold,
    double edgeThreshold,
    double sigma,
    int descriptorType,
    bool enable_precise_upscale,
    SIFT* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SIFT>(cv::SIFT::create(
        nfeatures,
        nOctaveLayers,
        contrastThreshold,
        edgeThreshold,
        sigma,
        descriptorType,
        enable_precise_upscale
    ));
    END_WRAP
}

CvStatus* cv_SIFT_create_2(
    int nfeatures,
    int nOctaveLayers,
    double contrastThreshold,
    double edgeThreshold,
    double sigma,
    bool enable_precise_upscale,
    SIFT* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::SIFT>(cv::SIFT::create(
        nfeatures, nOctaveLayers, contrastThreshold, edgeThreshold, sigma, enable_precise_upscale
    ));
    END_WRAP
}

void cv_SIFT_close(SIFTPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_SIFT_detect(SIFT self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detect(CVDEREF(src), CVDEREF_P(rval), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SIFT_detectAndCompute(
    SIFT self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))
        ->detectAndCompute(
            CVDEREF(src), CVDEREF(mask), CVDEREF_P(rval), CVDEREF(desc), useProvidedKeypoints
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

double cv_SIFT_getContrastThreshold(SIFT self) {
    return CVDEREF(self)->getContrastThreshold();
}
char* cv_SIFT_getDefaultName(SIFT self) {
    return strdup(CVDEREF(self)->getDefaultName().c_str());
}
double cv_SIFT_getEdgeThreshold(SIFT self) {
    return CVDEREF(self)->getEdgeThreshold();
}
int cv_SIFT_getNFeatures(SIFT self) {
    return CVDEREF(self)->getNFeatures();
}
int cv_SIFT_getNOctaveLayers(SIFT self) {
    return CVDEREF(self)->getNOctaveLayers();
}
double cv_SIFT_getSigma(SIFT self) {
    return CVDEREF(self)->getSigma();
}
void cv_SIFT_setContrastThreshold(SIFT self, double contrastThreshold) {
    CVDEREF(self)->setContrastThreshold(contrastThreshold);
}
void cv_SIFT_setEdgeThreshold(SIFT self, double edgeThreshold) {
    CVDEREF(self)->setEdgeThreshold(edgeThreshold);
}
void cv_SIFT_setNFeatures(SIFT self, int maxFeatures) {
    CVDEREF(self)->setNFeatures(maxFeatures);
}
void cv_SIFT_setNOctaveLayers(SIFT self, int nOctaveLayers) {
    CVDEREF(self)->setNOctaveLayers(nOctaveLayers);
}
void cv_SIFT_setSigma(SIFT self, double sigma) {
    CVDEREF(self)->setSigma(sigma);
}
bool cv_SIFT_empty(SIFT self) {
    return CVDEREF(self)->empty();
}

CvStatus* cv_drawMatches(
    Mat img1,
    VecKeyPoint kp1,
    Mat img2,
    VecKeyPoint kp2,
    VecDMatch matches1to2,
    Mat outImg,
    const Scalar matchesColor,
    const Scalar pointColor,
    VecChar matchesMask,
    int flags,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    auto mColor =
        cv::Scalar(matchesColor.val1, matchesColor.val2, matchesColor.val3, matchesColor.val4);
    auto pColor = cv::Scalar(pointColor.val1, pointColor.val2, pointColor.val3, pointColor.val4);
    cv::drawMatches(
        CVDEREF(img1),
        CVDEREF(kp1),
        CVDEREF(img2),
        CVDEREF(kp2),
        CVDEREF(matches1to2),
        CVDEREF(outImg),
        mColor,
        pColor,
        CVDEREF(matchesMask),
        static_cast<cv::DrawMatchesFlags>(flags)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
