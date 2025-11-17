/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_FEATURES2D_H_
#define CVD_FEATURES2D_H_

#ifdef __cplusplus
#include <opencv2/features2d.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"
#include <stddef.h>
#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::AKAZE>, AKAZE);
CVD_TYPEDEF(cv::Ptr<cv::AgastFeatureDetector>, AgastFeatureDetector);
CVD_TYPEDEF(cv::Ptr<cv::BRISK>, BRISK);
CVD_TYPEDEF(cv::Ptr<cv::FastFeatureDetector>, FastFeatureDetector);
CVD_TYPEDEF(cv::Ptr<cv::GFTTDetector>, GFTTDetector);
CVD_TYPEDEF(cv::Ptr<cv::KAZE>, KAZE);
CVD_TYPEDEF(cv::Ptr<cv::MSER>, MSER);
CVD_TYPEDEF(cv::Ptr<cv::ORB>, ORB);
CVD_TYPEDEF(cv::Ptr<cv::SimpleBlobDetector>, SimpleBlobDetector);
CVD_TYPEDEF(cv::Ptr<cv::BFMatcher>, BFMatcher);
CVD_TYPEDEF(cv::Ptr<cv::FlannBasedMatcher>, FlannBasedMatcher);
CVD_TYPEDEF(cv::Ptr<cv::SIFT>, SIFT);
CVD_TYPEDEF(cv::Ptr<cv::flann::IndexParams>, FlannIndexParams)
#else
CVD_TYPEDEF(void, AKAZE);
CVD_TYPEDEF(void, AgastFeatureDetector);
CVD_TYPEDEF(void, BRISK);
CVD_TYPEDEF(void, FastFeatureDetector);
CVD_TYPEDEF(void, GFTTDetector);
CVD_TYPEDEF(void, KAZE);
CVD_TYPEDEF(void, MSER);
CVD_TYPEDEF(void, ORB);
CVD_TYPEDEF(void, SimpleBlobDetector);
CVD_TYPEDEF(void, BFMatcher);
CVD_TYPEDEF(void, FlannBasedMatcher);
CVD_TYPEDEF(void, SIFT);
CVD_TYPEDEF(void, FlannIndexParams);
#endif

// Wrapper for SimpleBlobDetectorParams aka SimpleBlobDetector::Params
typedef struct SimpleBlobDetectorParams {
    unsigned char blobColor;
    bool filterByArea;
    bool filterByCircularity;
    bool filterByColor;
    bool filterByConvexity;
    bool filterByInertia;
    float maxArea;
    float maxCircularity;
    float maxConvexity;
    float maxInertiaRatio;
    float maxThreshold;
    float minArea;
    float minCircularity;
    float minConvexity;
    float minDistBetweenBlobs;
    float minInertiaRatio;
    size_t minRepeatability;
    float minThreshold;
    float thresholdStep;
} SimpleBlobDetectorParams;

enum FlannIndexType {
    FLANN_INDEX_TYPE_8U = 0,
    FLANN_INDEX_TYPE_8S = 1,
    FLANN_INDEX_TYPE_16U = 2,
    FLANN_INDEX_TYPE_16S = 3,
    FLANN_INDEX_TYPE_32S = 4,
    FLANN_INDEX_TYPE_32F = 5,
    FLANN_INDEX_TYPE_64F = 6,
    FLANN_INDEX_TYPE_STRING = 7,
    FLANN_INDEX_TYPE_BOOL,
    FLANN_INDEX_TYPE_ALGORITHM,
    LAST_VALUE_FLANN_INDEX_TYPE = FLANN_INDEX_TYPE_ALGORITHM
};

enum FlannAlgorithm {
    FLANN_INDEX_LINEAR = 0,
    FLANN_INDEX_KDTREE = 1,
    FLANN_INDEX_KMEANS = 2,
    FLANN_INDEX_COMPOSITE = 3,
    FLANN_INDEX_KDTREE_SINGLE = 4,
    FLANN_INDEX_HIERARCHICAL = 5,
    FLANN_INDEX_LSH = 6,
    FLANN_INDEX_SAVED = 254,
    FLANN_INDEX_AUTOTUNED = 255
};

enum FlannDistance {
    FLANN_DIST_EUCLIDEAN = 1,
    FLANN_DIST_L2 = 1,
    FLANN_DIST_MANHATTAN = 2,
    FLANN_DIST_L1 = 2,
    FLANN_DIST_MINKOWSKI = 3,
    FLANN_DIST_MAX = 4,
    FLANN_DIST_HIST_INTERSECT = 5,
    FLANN_DIST_HELLINGER = 6,
    FLANN_DIST_CHI_SQUARE = 7,
    FLANN_DIST_CS = 7,
    FLANN_DIST_KULLBACK_LEIBLER = 8,
    FLANN_DIST_KL = 8,
    FLANN_DIST_HAMMING = 9,
    FLANN_DIST_DNAMMING = 10
};

// AKAZE
CvStatus* cv_AKAZE_create(AKAZE* rval);
// The AKAZE constructor.
// create (AKAZE::DescriptorType descriptor_type=AKAZE::DESCRIPTOR_MLDB, int descriptor_size=0, int descriptor_channels=3, float threshold=0.001f, int nOctaves=4, int nOctaveLayers=4, KAZE::DiffusivityType diffusivity=KAZE::DIFF_PM_G2, int max_points=-1)
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
);
void cv_AKAZE_close(AKAZEPtr self);
CvStatus* cv_AKAZE_detect(AKAZE self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback);
CvStatus* cv_AKAZE_detectAndCompute(
    AKAZE self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_AKAZE_empty(AKAZE self);
char* cv_AKAZE_getDefaultName(AKAZE self);
// virtual int 	getDescriptorChannels () const =0
int cv_AKAZE_getDescriptorChannels(AKAZE self);
// virtual int 	getDescriptorSize () const =0
int cv_AKAZE_getDescriptorSize(AKAZE self);
// virtual AKAZE::DescriptorType 	getDescriptorType () const =0
int cv_AKAZE_getDescriptorType(AKAZE self);
// virtual KAZE::DiffusivityType 	getDiffusivity () const =0
int cv_AKAZE_getDiffusivity(AKAZE self);
// virtual int 	getMaxPoints () const =0
int cv_AKAZE_getMaxPoints(AKAZE self);
// virtual int 	getNOctaveLayers () const =0
int cv_AKAZE_getNOctaveLayers(AKAZE self);
// virtual int 	getNOctaves () const =0
int cv_AKAZE_getNOctaves(AKAZE self);
// virtual double 	getThreshold () const =0
double cv_AKAZE_getThreshold(AKAZE self);
// virtual void 	setDescriptorChannels (int dch)=0
void cv_AKAZE_setDescriptorChannels(AKAZE self, int dch);
// virtual void 	setDescriptorSize (int dsize)=0
void cv_AKAZE_setDescriptorSize(AKAZE self, int dsize);
// virtual void 	setDescriptorType (AKAZE::DescriptorType dtype)=0
void cv_AKAZE_setDescriptorType(AKAZE self, int dtype);
// virtual void 	setDiffusivity (KAZE::DiffusivityType diff)=0
void cv_AKAZE_setDiffusivity(AKAZE self, int diff);
// virtual void 	setMaxPoints (int max_points)=0
void cv_AKAZE_setMaxPoints(AKAZE self, int max_points);
// virtual void 	setNOctaveLayers (int octaveLayers)=0
void cv_AKAZE_setNOctaveLayers(AKAZE self, int octaveLayers);
// virtual void 	setNOctaves (int octaves)=0
void cv_AKAZE_setNOctaves(AKAZE self, int octaves);
// virtual void 	setThreshold (double threshold)=0
void cv_AKAZE_setThreshold(AKAZE self, double threshold);

// AgastFeatureDetector
CvStatus* cv_AgastFeatureDetector_create(AgastFeatureDetector* rval);
// create (int threshold=10, bool nonmaxSuppression=true, AgastFeatureDetector::DetectorType type=AgastFeatureDetector::OAST_9_16)
CvStatus* cv_AgastFeatureDetector_create_1(
    int threshold, bool nonmaxSuppression, int type, AgastFeatureDetector* rval
);
void cv_AgastFeatureDetector_close(AgastFeatureDetectorPtr self);
CvStatus* cv_AgastFeatureDetector_detect(
    AgastFeatureDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
);
// detectAndCompute (InputArray image, InputArray mask, std::vector< KeyPoint > &keypoints, OutputArray descriptors, bool useProvidedKeypoints=false)
CvStatus* cv_AgastFeatureDetector_detectAndCompute(
    AgastFeatureDetector self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_AgastFeatureDetector_empty(AgastFeatureDetector self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_AgastFeatureDetector_getDefaultName(AgastFeatureDetector self);
// virtual bool 	getNonmaxSuppression () const =0
bool cv_AgastFeatureDetector_getNonmaxSuppression(AgastFeatureDetector self);
// virtual int 	getThreshold () const =0
int cv_AgastFeatureDetector_getThreshold(AgastFeatureDetector self);
// virtual AgastFeatureDetector::DetectorType 	getType () const =0
int cv_AgastFeatureDetector_getType(AgastFeatureDetector self);
// virtual void 	setNonmaxSuppression (bool f)=0
void cv_AgastFeatureDetector_setNonmaxSuppression(AgastFeatureDetector self, bool f);
// virtual void 	setThreshold (int threshold)=0
void cv_AgastFeatureDetector_setThreshold(AgastFeatureDetector self, int threshold);
// virtual void 	setType (AgastFeatureDetector::DetectorType type)=0
void cv_AgastFeatureDetector_setType(AgastFeatureDetector self, int type);

// BRISK
CvStatus* cv_BRISK_create(BRISK* rval);
// The BRISK constructor for a custom pattern.
// static Ptr< BRISK > create (const std::vector< float > &radiusList, const std::vector< int > &numberList, float dMax=5.85f, float dMin=8.2f, const std::vector< int > &indexChange=std::vector< int >())
CvStatus* cv_BRISK_create_1(
    VecF32 radiusList, VecI32 numberList, float dMax, float dMin, VecI32 indexChange, BRISK* rval
);

// The BRISK constructor for a custom pattern, detection threshold and octaves.
// static Ptr< BRISK > create (int thresh, int octaves, const std::vector< float > &radiusList, const std::vector< int > &numberList, float dMax=5.85f, float dMin=8.2f, const std::vector< int > &indexChange=std::vector< int >())
CvStatus* cv_BRISK_create_2(
    int thresh,
    int octaves,
    VecF32 radiusList,
    VecI32 numberList,
    float dMax,
    float dMin,
    VecI32 indexChange,
    BRISK* rval
);
// The BRISK constructor.
// static Ptr< BRISK > create (int thresh=30, int octaves=3, float patternScale=1.0f)
CvStatus* cv_BRISK_create_3(int thresh, int octaves, float patternScale, BRISK* rval);
void cv_BRISK_close(BRISKPtr self);
CvStatus* cv_BRISK_detect(BRISK self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback);
CvStatus* cv_BRISK_detectAndCompute(
    BRISK self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);

bool cv_BRISK_empty(BRISK self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_BRISK_getDefaultName(BRISK self);
// virtual int 	getOctaves () const =0
int cv_BRISK_getOctaves(BRISK self);
// virtual float 	getPatternScale () const =0
float cv_BRISK_getPatternScale(BRISK self);
// virtual int 	getThreshold () const =0
int cv_BRISK_getThreshold(BRISK self);
// Set detection octaves.
// virtual void 	setOctaves (int octaves)=0
void cv_BRISK_setOctaves(BRISK self, int octaves);
// Set detection patternScale.
// virtual void 	setPatternScale (float patternScale)=0
void cv_BRISK_setPatternScale(BRISK self, float patternScale);
// Set detection threshold.
// virtual void 	setThreshold (int threshold)=0
void cv_BRISK_setThreshold(BRISK self, int threshold);

// FastFeatureDetector
CvStatus* cv_FastFeatureDetector_create(FastFeatureDetector* rval);
CvStatus* cv_FastFeatureDetector_create_1(
    int threshold, bool nonmaxSuppression, int type, FastFeatureDetector* rval
);
void cv_FastFeatureDetector_close(FastFeatureDetectorPtr self);
CvStatus* cv_FastFeatureDetector_detect(
    FastFeatureDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
);
CvStatus* cv_FastFeatureDetector_detectAndCompute(
    FastFeatureDetector self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);

bool cv_FastFeatureDetector_empty(FastFeatureDetector self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_FastFeatureDetector_getDefaultName(FastFeatureDetector self);
// virtual bool 	getNonmaxSuppression () const =0
bool cv_FastFeatureDetector_getNonmaxSuppression(FastFeatureDetector self);
// virtual int 	getThreshold () const =0
int cv_FastFeatureDetector_getThreshold(FastFeatureDetector self);
// virtual FastFeatureDetector::DetectorType 	getType () const =0
int cv_FastFeatureDetector_getType(FastFeatureDetector self);
// virtual void 	setNonmaxSuppression (bool f)=0
void cv_FastFeatureDetector_setNonmaxSuppression(FastFeatureDetector self, bool f);
// virtual void 	setThreshold (int threshold)=0
void cv_FastFeatureDetector_setThreshold(FastFeatureDetector self, int threshold);
// virtual void 	setType (FastFeatureDetector::DetectorType type)=0
void cv_FastFeatureDetector_setType(FastFeatureDetector self, int type);

// GFTTDetector
CvStatus* cv_GFTTDetector_create(GFTTDetector* rval);
// static Ptr< GFTTDetector > 	create (int maxCorners, double qualityLevel, double minDistance, int blockSize, int gradiantSize, bool useHarrisDetector=false, double k=0.04)
CvStatus* cv_GFTTDetector_create_1(
    int maxCorners,
    double qualityLevel,
    double minDistance,
    int blockSize,
    int gradiantSize,
    bool useHarrisDetector,
    double k,
    GFTTDetector* rval
);

// static Ptr< GFTTDetector > 	create (int maxCorners=1000, double qualityLevel=0.01, double minDistance=1, int blockSize=3, bool useHarrisDetector=false, double k=0.04)
CvStatus* cv_GFTTDetector_create_2(
    int maxCorners,
    double qualityLevel,
    double minDistance,
    int blockSize,
    bool useHarrisDetector,
    double k,
    GFTTDetector* rval
);
void cv_GFTTDetector_close(GFTTDetectorPtr self);
CvStatus* cv_GFTTDetector_detect(
    GFTTDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
);
CvStatus* cv_GFTTDetector_detectAndCompute(
    GFTTDetector self,
    Mat src,
    Mat mask,
    Mat descriptors,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_GFTTDetector_empty(GFTTDetector self);
// virtual int 	getBlockSize () const =0
int cv_GFTTDetector_getBlockSize(GFTTDetector self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_GFTTDetector_getDefaultName(GFTTDetector self);
// virtual int 	getGradientSize ()=0
int cv_GFTTDetector_getGradientSize(GFTTDetector self);
// virtual bool 	getHarrisDetector () const =0
bool cv_GFTTDetector_getHarrisDetector(GFTTDetector self);
// virtual double 	getK () const =0
double cv_GFTTDetector_getK(GFTTDetector self);
// virtual int 	getMaxFeatures () const =0
int cv_GFTTDetector_getMaxFeatures(GFTTDetector self);
// virtual double 	getMinDistance () const =0
double cv_GFTTDetector_getMinDistance(GFTTDetector self);
// virtual double 	getQualityLevel () const =0
double cv_GFTTDetector_getQualityLevel(GFTTDetector self);
// virtual void 	setBlockSize (int blockSize)=0
void cv_GFTTDetector_setBlockSize(GFTTDetector self, int blockSize);
// virtual void 	setGradientSize (int gradientSize_)=0
void cv_GFTTDetector_setGradientSize(GFTTDetector self, int gradientSize_);
// virtual void 	setHarrisDetector (bool val)=0
void cv_GFTTDetector_setHarrisDetector(GFTTDetector self, bool val);
// virtual void 	setK (double k)=0
void cv_GFTTDetector_setK(GFTTDetector self, double k);
// virtual void 	setMaxFeatures (int maxFeatures)=0
void cv_GFTTDetector_setMaxFeatures(GFTTDetector self, int maxFeatures);
// virtual void 	setMinDistance (double minDistance)=0
void cv_GFTTDetector_setMinDistance(GFTTDetector self, double minDistance);
// virtual void 	setQualityLevel (double qlevel)=0
void cv_GFTTDetector_setQualityLevel(GFTTDetector self, double qlevel);

// KAZE
CvStatus* cv_KAZE_create(KAZE* rval);
// create (bool extended=false, bool upright=false, float threshold=0.001f, int nOctaves=4, int nOctaveLayers=4, KAZE::DiffusivityType diffusivity=KAZE::DIFF_PM_G2)
CvStatus* cv_KAZE_create_1(
    bool extended,
    bool upright,
    float threshold,
    int nOctaves,
    int nOctaveLayers,
    int diffusivity,
    KAZE* rval
);
void cv_KAZE_close(KAZEPtr self);
CvStatus* cv_KAZE_detect(KAZE self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback);
CvStatus* cv_KAZE_detectAndCompute(
    KAZE self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_KAZE_empty(KAZE self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_KAZE_getDefaultName(KAZE self);
// virtual KAZE::DiffusivityType 	getDiffusivity () const =0
int cv_KAZE_getDiffusivity(KAZE self);
// virtual bool 	getExtended () const =0
bool cv_KAZE_getExtended(KAZE self);
// virtual int 	getNOctaveLayers () const =0
int cv_KAZE_getNOctaveLayers(KAZE self);
// virtual int 	getNOctaves () const =0
int cv_KAZE_getNOctaves(KAZE self);
// virtual double 	getThreshold () const =0
double cv_KAZE_getThreshold(KAZE self);
// virtual bool 	getUpright () const =0
bool cv_KAZE_getUpright(KAZE self);
// virtual void 	setDiffusivity (KAZE::DiffusivityType diff)=0
void cv_KAZE_setDiffusivity(KAZE self, int diff);
// virtual void 	setExtended (bool extended)=0
void cv_KAZE_setExtended(KAZE self, bool extended);
// virtual void 	setNOctaveLayers (int octaveLayers)=0
void cv_KAZE_setNOctaveLayers(KAZE self, int octaveLayers);
// virtual void 	setNOctaves (int octaves)=0
void cv_KAZE_setNOctaves(KAZE self, int octaves);
// virtual void 	setThreshold (double threshold)=0
void cv_KAZE_setThreshold(KAZE self, double threshold);
// virtual void 	setUpright (bool upright)=0
void cv_KAZE_setUpright(KAZE self, bool upright);

// MSER
CvStatus* cv_MSER_create(MSER* rval);
// create (int delta=5, int min_area=60, int max_area=14400, double max_variation=0.25, double min_diversity=.2, int max_evolution=200, double area_threshold=1.01, double min_margin=0.003, int edge_blur_size=5)
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
);
void cv_MSER_close(MSERPtr self);
CvStatus* cv_MSER_detect(MSER self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback);
CvStatus* cv_MSER_detectAndCompute(
    MSER self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
// Detect MSER regions.
// virtual void 	detectRegions (InputArray image, std::vector< std::vector< Point > > &msers, std::vector< Rect > &bboxes)=0
CvStatus* cv_MSER_detectRegions(
    MSER self, Mat image, VecVecPoint* rval, VecRect* bboxes, CvCallback_0 callback
);
bool cv_MSER_empty(MSER self);
// virtual double 	getAreaThreshold () const =0
double cv_MSER_getAreaThreshold(MSER self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_MSER_getDefaultName(MSER self);
// virtual int 	getDelta () const =0
int cv_MSER_getDelta(MSER self);
// virtual int 	getEdgeBlurSize () const =0
int cv_MSER_getEdgeBlurSize(MSER self);
// virtual int 	getMaxArea () const =0
int cv_MSER_getMaxArea(MSER self);
// virtual int 	getMaxEvolution () const =0
int cv_MSER_getMaxEvolution(MSER self);
// virtual double 	getMaxVariation () const =0
double cv_MSER_getMaxVariation(MSER self);
// virtual int 	getMinArea () const =0
int cv_MSER_getMinArea(MSER self);
// virtual double 	getMinDiversity () const =0
double cv_MSER_getMinDiversity(MSER self);
// virtual double 	getMinMargin () const =0
double cv_MSER_getMinMargin(MSER self);
// virtual bool 	getPass2Only () const =0
bool cv_MSER_getPass2Only(MSER self);
// virtual void 	setAreaThreshold (double areaThreshold)=0
void cv_MSER_setAreaThreshold(MSER self, double areaThreshold);
// virtual void 	setDelta (int delta)=0
void cv_MSER_setDelta(MSER self, int delta);
// virtual void 	setEdgeBlurSize (int edge_blur_size)=0
void cv_MSER_setEdgeBlurSize(MSER self, int edge_blur_size);
// virtual void 	setMaxArea (int maxArea)=0
void cv_MSER_setMaxArea(MSER self, int maxArea);
// virtual void 	setMaxEvolution (int maxEvolution)=0
void cv_MSER_setMaxEvolution(MSER self, int maxEvolution);
// virtual void 	setMaxVariation (double maxVariation)=0
void cv_MSER_setMaxVariation(MSER self, double maxVariation);
// virtual void 	setMinArea (int minArea)=0
void cv_MSER_setMinArea(MSER self, int minArea);
// virtual void 	setMinDiversity (double minDiversity)=0
void cv_MSER_setMinDiversity(MSER self, double minDiversity);
// virtual void 	setMinMargin (double min_margin)=0
void cv_MSER_setMinMargin(MSER self, double min_margin);
// virtual void 	setPass2Only (bool f)=0
void cv_MSER_setPass2Only(MSER self, bool f);

// ORB
CvStatus* cv_ORB_create(ORB* rval);
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
);
void cv_ORB_close(ORBPtr self);
CvStatus* cv_ORB_detect(ORB self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback);
CvStatus* cv_ORB_detectAndCompute(
    ORB self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* out_keypoints,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_ORB_empty(ORB self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_ORB_getDefaultName(ORB self);
// virtual int 	getEdgeThreshold () const =0
int cv_ORB_getEdgeThreshold(ORB self);
// virtual int 	getFastThreshold () const =0
int cv_ORB_getFastThreshold(ORB self);
// virtual int 	getFirstLevel () const =0
int cv_ORB_getFirstLevel(ORB self);
// virtual int 	getMaxFeatures () const =0
int cv_ORB_getMaxFeatures(ORB self);
// virtual int 	getNLevels () const =0
int cv_ORB_getNLevels(ORB self);
// virtual int 	getPatchSize () const =0
int cv_ORB_getPatchSize(ORB self);
// virtual double 	getScaleFactor () const =0
double cv_ORB_getScaleFactor(ORB self);
// virtual ORB::ScoreType 	getScoreType () const =0
int cv_ORB_getScoreType(ORB self);
// virtual int 	getWTA_K () const =0
int cv_ORB_getWTA_K(ORB self);
// virtual void 	setEdgeThreshold (int edgeThreshold)=0
void cv_ORB_setEdgeThreshold(ORB self, int edgeThreshold);
// virtual void 	setFastThreshold (int fastThreshold)=0
void cv_ORB_setFastThreshold(ORB self, int fastThreshold);
// virtual void 	setFirstLevel (int firstLevel)=0
void cv_ORB_setFirstLevel(ORB self, int firstLevel);
// virtual void 	setMaxFeatures (int maxFeatures)=0
void cv_ORB_setMaxFeatures(ORB self, int maxFeatures);
// virtual void 	setNLevels (int nlevels)=0
void cv_ORB_setNLevels(ORB self, int nlevels);
// virtual void 	setPatchSize (int patchSize)=0
void cv_ORB_setPatchSize(ORB self, int patchSize);
// virtual void 	setScaleFactor (double scaleFactor)=0
void cv_ORB_setScaleFactor(ORB self, double scaleFactor);
// virtual void 	setScoreType (ORB::ScoreType scoreType)=0
void cv_ORB_setScoreType(ORB self, int scoreType);
// virtual void 	setWTA_K (int wta_k)=0
void cv_ORB_setWTA_K(ORB self, int wta_k);

// SimpleBlobDetector
CvStatus* cv_SimpleBlobDetectorParams_create(SimpleBlobDetectorParams* rval);
CvStatus* cv_SimpleBlobDetector_create(SimpleBlobDetector* rval);
CvStatus* cv_SimpleBlobDetector_create_1(SimpleBlobDetectorParams params, SimpleBlobDetector* rval);
void cv_SimpleBlobDetector_close(SimpleBlobDetectorPtr self);
CvStatus* cv_SimpleBlobDetector_detect(
    SimpleBlobDetector self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback
);
CvStatus* cv_SimpleBlobDetector_detectAndCompute(
    SimpleBlobDetector self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_SimpleBlobDetector_empty(SimpleBlobDetector self);
// virtual const std::vector< std::vector< cv::Point > > & 	getBlobContours () const
VecVecPoint* cv_SimpleBlobDetector_getBlobContours(SimpleBlobDetector self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_SimpleBlobDetector_getDefaultName(SimpleBlobDetector self);
// virtual SimpleBlobDetector::Params 	getParams () const =0
SimpleBlobDetectorParams* cv_SimpleBlobDetector_getParams(SimpleBlobDetector self);
// virtual void 	setParams (const SimpleBlobDetector::Params &params)=0
void cv_SimpleBlobDetector_setParams(SimpleBlobDetector self, SimpleBlobDetectorParams params);

// BFMatcher
CvStatus* cv_BFMatcher_create(BFMatcher* rval);
CvStatus* cv_BFMatcher_create_1(int normType, bool crossCheck, BFMatcher* rval);
void cv_BFMatcher_close(BFMatcherPtr self);
CvStatus* cv_BFMatcher_match(
    BFMatcher self, Mat query, Mat train, VecDMatch* rval, CvCallback_0 callback
);
CvStatus* cv_BFMatcher_knnMatch(
    BFMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
);

// flann
CvStatus* cv_flann_IndexParams_create(FlannIndexParams* rval);
void cv_flann_IndexParams_close(FlannIndexParamsPtr self);
void cv_flann_IndexParams_setString(FlannIndexParams self, const char* key, const char* value);
void cv_flann_IndexParams_setInt(FlannIndexParams self, const char* key, int value);
void cv_flann_IndexParams_setDouble(FlannIndexParams self, const char* key, double value);
void cv_flann_IndexParams_setFloat(FlannIndexParams self, const char* key, float value);
void cv_flann_IndexParams_setBool(FlannIndexParams self, const char* key, bool value);
void cv_flann_IndexParams_setAlgorithm(FlannIndexParams self, int value);
void cv_flann_IndexParams_getString(
    FlannIndexParams self, const char* key, const char* defaultValue, char** rval
);
void cv_flann_IndexParams_getInt(
    FlannIndexParams self, const char* key, int defaultValue, int* rval
);
void cv_flann_IndexParams_getDouble(
    FlannIndexParams self, const char* key, double defaultValue, double* rval
);
// void cv_flann_IndexParams_getBool(
//     FlannIndexParams self, const char* key, bool defaultValue, bool* rval
// );
void cv_flann_IndexParams_getAll(
    FlannIndexParams self,
    VecVecChar* names,
    VecI32* types,
    VecVecChar* strValues,
    VecF64* numValues
);
void* cv_flann_IndexParams_params_ptr(FlannIndexParams self);

CvStatus* cv_FlannBasedMatcher_create(FlannBasedMatcher* rval);
CvStatus* cv_FlannBasedMatcher_create_1(
    FlannBasedMatcher* rval, FlannIndexParams indexParams, FlannIndexParams searchParams
);
void cv_FlannBasedMatcher_close(FlannBasedMatcherPtr self);
CvStatus* cv_FlannBasedMatcher_knnMatch(
    FlannBasedMatcher self, Mat query, Mat train, int k, VecVecDMatch* rval, CvCallback_0 callback
);

// SIFT
CvStatus* cv_SIFT_create(SIFT* rval);
// create (int nfeatures, int nOctaveLayers, double contrastThreshold, double edgeThreshold, double sigma, int descriptorType, bool enable_precise_upscale=false)
CvStatus* cv_SIFT_create_1(
    int nfeatures,
    int nOctaveLayers,
    double contrastThreshold,
    double edgeThreshold,
    double sigma,
    int descriptorType,
    bool enable_precise_upscale,
    SIFT* rval
);
// create (int nfeatures=0, int nOctaveLayers=3, double contrastThreshold=0.04, double edgeThreshold=10, double sigma=1.6, bool enable_precise_upscale=false)
CvStatus* cv_SIFT_create_2(
    int nfeatures,
    int nOctaveLayers,
    double contrastThreshold,
    double edgeThreshold,
    double sigma,
    bool enable_precise_upscale,
    SIFT* rval
);
void cv_SIFT_close(SIFTPtr self);
CvStatus* cv_SIFT_detect(SIFT self, Mat src, VecKeyPoint* rval, Mat mask, CvCallback_0 callback);
CvStatus* cv_SIFT_detectAndCompute(
    SIFT self,
    Mat src,
    Mat mask,
    Mat desc,
    VecKeyPoint* rval,
    bool useProvidedKeypoints,
    CvCallback_0 callback
);
bool cv_SIFT_empty(SIFT self);
// virtual double 	getContrastThreshold () const =0
double cv_SIFT_getContrastThreshold(SIFT self);
// virtual String 	getDefaultName () const CV_OVERRIDE
char* cv_SIFT_getDefaultName(SIFT self);
// virtual double 	getEdgeThreshold () const =0
double cv_SIFT_getEdgeThreshold(SIFT self);
// virtual int 	getNFeatures () const =0
int cv_SIFT_getNFeatures(SIFT self);
// virtual int 	getNOctaveLayers () const =0
int cv_SIFT_getNOctaveLayers(SIFT self);
// virtual double 	getSigma () const =0
double cv_SIFT_getSigma(SIFT self);
// virtual void 	setContrastThreshold (double contrastThreshold)=0
void cv_SIFT_setContrastThreshold(SIFT self, double contrastThreshold);
// virtual void 	setEdgeThreshold (double edgeThreshold)=0
void cv_SIFT_setEdgeThreshold(SIFT self, double edgeThreshold);
// virtual void 	setNFeatures (int maxFeatures)=0
void cv_SIFT_setNFeatures(SIFT self, int maxFeatures);
// virtual void 	setNOctaveLayers (int nOctaveLayers)=0
void cv_SIFT_setNOctaveLayers(SIFT self, int nOctaveLayers);
// virtual void 	setSigma (double sigma)=0
void cv_SIFT_setSigma(SIFT self, double sigma);

// others
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
);

CvStatus* cv_drawKeyPoints(
    Mat src, VecKeyPoint kp, Mat dst, const Scalar color, int flags, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  //CVD_FEATURES2D_H_
