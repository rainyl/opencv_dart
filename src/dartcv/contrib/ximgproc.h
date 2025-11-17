/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef CVD_XIMGPROC_H
#define CVD_XIMGPROC_H

#include "dartcv/core/types.h"
#ifdef __cplusplus
#include <opencv2/ximgproc.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::RFFeatureGetter>, RFFeatureGetter)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::StructuredEdgeDetection>, StructuredEdgeDetection)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::segmentation::GraphSegmentation>, GraphSegmentation)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::EdgeDrawing>, EdgeDrawing)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::EdgeBoxes>, EdgeBoxes)

#else
CVD_TYPEDEF(void*, RFFeatureGetter)
CVD_TYPEDEF(void*, StructuredEdgeDetection)
CVD_TYPEDEF(void*, GraphSegmentation)
CVD_TYPEDEF(void*, EdgeDrawing)
CVD_TYPEDEF(void*, EdgeBoxes)
#endif

CvStatus* cv_ximgproc_anisotropicDiffusion(
    Mat src, CVD_OUT Mat dst, float alpha, float K, int niters, CvCallback_0 callback
);
CvStatus* cv_ximgproc_edgePreservingFilter(
    Mat src, CVD_OUT Mat dst, int d, double threshold, CvCallback_0 callback
);
CvStatus* cv_ximgproc_findEllipses(
    Mat image,
    CVD_OUT Mat ellipses,
    float scoreThreshold,
    float reliabilityThreshold,
    float centerDistanceThreshold,
    CvCallback_0 callback
);
CvStatus* cv_ximgproc_niBlackThreshold(
    Mat src,
    CVD_OUT Mat dst,
    double maxValue,
    int type,
    int blockSize,
    double k,
    int binarizationMethod,
    double r,
    CvCallback_0 callback
);
CvStatus* cv_ximgproc_PeiLinNormalization(Mat I, CVD_OUT Mat dst, CvCallback_0 callback);
CvStatus* cv_ximgproc_thinning(Mat src, Mat dst, int thinningType, CvCallback_0 callback);

// RFFeatureGetter
CvStatus* cv_ximgproc_RFFeatureGetter_create(CVD_OUT RFFeatureGetter* rval);
void cv_ximgproc_RFFeatureGetter_close(RFFeatureGetterPtr self);
CvStatus* cv_ximgproc_RFFeatureGetter_getFeatures(
    RFFeatureGetter self,
    Mat src,
    CVD_OUT Mat features,
    int gnrmRad,
    int gsmthRad,
    int shrink,
    int outNum,
    int gradNum,
    CvCallback_0 callback
);
CvStatus* cv_ximgproc_RFFeatureGetter_clear(RFFeatureGetter self);
bool cv_ximgproc_RFFeatureGetter_empty(RFFeatureGetter self);

// StructuredEdgeDetection
CvStatus* cv_ximgproc_StructuredEdgeDetection_create(
    const char* model, CVD_OUT StructuredEdgeDetection* rval
);
CvStatus* cv_ximgproc_StructuredEdgeDetection_create_1(
    const char* model, RFFeatureGetter* howToGetFeatures, CVD_OUT StructuredEdgeDetection* rval
);
void cv_ximgproc_StructuredEdgeDetection_close(StructuredEdgeDetectionPtr self);
CvStatus* cv_ximgproc_StructuredEdgeDetection_computeOrientation(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat dst, CvCallback_0 callback
);
CvStatus* cv_ximgproc_StructuredEdgeDetection_detectEdges(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat dst, CvCallback_0 callback
);
CvStatus* cv_ximgproc_StructuredEdgeDetection_edgesNms(
    StructuredEdgeDetection self,
    Mat edge_image,
    Mat orientation_image,
    CVD_OUT Mat dst,
    int r,
    int s_,
    float m,
    bool isParallel,
    CvCallback_0 callback
);

// Box, EdgeBoxes
typedef struct Box {
    int h;
    float score;
    int w;
    int x;
    int y;
} Box;

CvStatus* cv_ximgproc_EdgeBoxes_create(
    float alpha,
    float beta,
    float eta,
    float minScore,
    int maxBoxes,
    float edgeMinMag,
    float edgeMergeThr,
    float clusterMinMag,
    float maxAspectRatio,
    float minBoxArea,
    float gamma,
    float kappa,
    EdgeBoxes* rval
);

void cv_ximgproc_EdgeBoxes_close(EdgeBoxesPtr self);

// Returns the step size of sliding window search.
float cv_ximgproc_EdgeBoxes_getAlpha(EdgeBoxes self);

// Returns the nms threshold for object proposals.
float cv_ximgproc_EdgeBoxes_getBeta(EdgeBoxes self);

// Returns the cluster min magnitude.
float cv_ximgproc_EdgeBoxes_getClusterMinMag(EdgeBoxes self);

// Returns the edge merge threshold.
float cv_ximgproc_EdgeBoxes_getEdgeMergeThr(EdgeBoxes self);

// Returns the edge min magnitude.
float cv_ximgproc_EdgeBoxes_getEdgeMinMag(EdgeBoxes self);

// Returns adaptation rate for nms threshold.
float cv_ximgproc_EdgeBoxes_getEta(EdgeBoxes self);

// Returns the affinity sensitivity.
float cv_ximgproc_EdgeBoxes_getGamma(EdgeBoxes self);

// Returns the scale sensitivity.
float cv_ximgproc_EdgeBoxes_getKappa(EdgeBoxes self);

// Returns the max aspect ratio of boxes.
float cv_ximgproc_EdgeBoxes_getMaxAspectRatio(EdgeBoxes self);

// Returns the max number of boxes to detect.
int cv_ximgproc_EdgeBoxes_getMaxBoxes(EdgeBoxes self);

// Returns the minimum area of boxes.
float cv_ximgproc_EdgeBoxes_getMinBoxArea(EdgeBoxes self);

// Returns the min score of boxes to detect.
float cv_ximgproc_EdgeBoxes_getMinScore(EdgeBoxes self);

// Sets the step size of sliding window search.
void cv_ximgproc_EdgeBoxes_setAlpha(EdgeBoxes self, float value);

// Sets the nms threshold for object proposals.
void cv_ximgproc_EdgeBoxes_setBeta(EdgeBoxes self, float value);

// Sets the cluster min magnitude.
void cv_ximgproc_EdgeBoxes_setClusterMinMag(EdgeBoxes self, float value);

// Sets the edge merge threshold.
void cv_ximgproc_EdgeBoxes_setEdgeMergeThr(EdgeBoxes self, float value);

// Sets the edge min magnitude.
void cv_ximgproc_EdgeBoxes_setEdgeMinMag(EdgeBoxes self, float value);

// Sets the adaptation rate for nms threshold.
void cv_ximgproc_EdgeBoxes_setEta(EdgeBoxes self, float value);

// Sets the affinity sensitivity.
void cv_ximgproc_EdgeBoxes_setGamma(EdgeBoxes self, float value);

// Sets the scale sensitivity.
void cv_ximgproc_EdgeBoxes_setKappa(EdgeBoxes self, float value);

// Sets the max aspect ratio of boxes.
void cv_ximgproc_EdgeBoxes_setMaxAspectRatio(EdgeBoxes self, float value);

// Sets max number of boxes to detect.
void cv_ximgproc_EdgeBoxes_setMaxBoxes(EdgeBoxes self, int value);

// Sets the minimum area of boxes.
void cv_ximgproc_EdgeBoxes_setMinBoxArea(EdgeBoxes self, float value);

// Sets the min score of boxes to detect.
void cv_ximgproc_EdgeBoxes_setMinScore(EdgeBoxes self, float value);

CvStatus* cv_ximgproc_EdgeBoxes_getBoundingBoxes(
    EdgeBoxes self,
    Mat edge_map,
    Mat orientation_map,
    CVD_OUT VecRect* out_boxes,
    CVD_OUT VecF32* scores,
    CvCallback_0 callback
);

// GraphSegmentation
CvStatus* cv_ximgproc_GraphSegmentation_create(
    float sigma, float k, int min_size, GraphSegmentation* rval
);
void cv_ximgproc_GraphSegmentation_close(GraphSegmentationPtr self);
float cv_ximgproc_GraphSegmentation_getK(GraphSegmentation self);
int cv_ximgproc_GraphSegmentation_getMinSize(GraphSegmentation self);
double cv_ximgproc_GraphSegmentation_getSigma(GraphSegmentation self);
CvStatus* cv_ximgproc_GraphSegmentation_processImage(
    GraphSegmentation self, Mat src, CVD_OUT Mat dst, CvCallback_0 callback
);
void cv_ximgproc_GraphSegmentation_setK(GraphSegmentation self, float val);
void cv_ximgproc_GraphSegmentation_setMinSize(GraphSegmentation self, int val);
void cv_ximgproc_GraphSegmentation_setSigma(GraphSegmentation self, double val);

// EdgeDrawing
typedef struct EdgeDrawingParams {
    int AnchorThresholdValue;
    int EdgeDetectionOperator;
    int GradientThresholdValue;
    double LineFitErrorThreshold;
    double MaxDistanceBetweenTwoLines;
    double MaxErrorThreshold;
    int MinLineLength;
    int MinPathLength;
    bool NFAValidation;
    bool PFmode;
    int ScanInterval;
    float Sigma;
    bool SumFlag;
} EdgeDrawingParams;

CvStatus* cv_ximgproc_EdgeDrawing_create(EdgeDrawing* rval);
void cv_ximgproc_EdgeDrawing_close(EdgeDrawingPtr self);
CvStatus* cv_ximgproc_EdgeDrawing_detectEdges(EdgeDrawing self, Mat src, CvCallback_0 callback);
CvStatus* cv_ximgproc_EdgeDrawing_detectEllipses(
    EdgeDrawing self, Mat ellipses, CvCallback_0 callback
);
CvStatus* cv_ximgproc_EdgeDrawing_detectLines(EdgeDrawing self, Mat lines, CvCallback_0 callback);
CvStatus* cv_ximgproc_EdgeDrawing_getEdgeImage(EdgeDrawing self, Mat dst, CvCallback_0 callback);
CvStatus* cv_ximgproc_EdgeDrawing_getGradientImage(
    EdgeDrawing self, Mat dst, CvCallback_0 callback
);
CvStatus* cv_ximgproc_EdgeDrawing_getSegmentIndicesOfLines(
    EdgeDrawing self, VecI32* rval, CvCallback_0 callback
);
CvStatus* cv_ximgproc_EdgeDrawing_getSegments(
    EdgeDrawing self, VecVecPoint* rval, CvCallback_0 callback
);
CvStatus* cv_ximgproc_EdgeDrawing_setParams(
    EdgeDrawing self, EdgeDrawingParams params, CvCallback_0 callback
);
CvStatus* cv_ximgproc_EdgeDrawing_getParams(
    EdgeDrawing self, EdgeDrawingParams* params, CvCallback_0 callback
);

// Binary morphology on run-length encoded image
CvStatus* cv_ximgproc_rl_createRLEImage(
    VecPoint3i runs, Mat res, CvSize size, CvCallback_0 callback
);
CvStatus* cv_ximgproc_rl_dilate(
    Mat rlSrc, Mat rlDest, Mat rlKernel, CvPoint anchor, CvCallback_0 callback
);
CvStatus* cv_ximgproc_rl_erode(
    Mat rlSrc, Mat rlDest, Mat rlKernel, bool bBoundaryOn, CvPoint anchor, CvCallback_0 callback
);
CvStatus* cv_ximgproc_rl_getStructuringElement(
    int shape, CvSize ksize, Mat* rval, CvCallback_0 callback
);
bool cv_ximgproc_rl_isRLMorphologyPossible(Mat rlStructuringElement);
CvStatus* cv_ximgproc_rl_morphologyEx(
    Mat rlSrc,
    Mat rlDest,
    int op,
    Mat rlKernel,
    bool bBoundaryOnForErosion,
    CvPoint anchor,
    CvCallback_0 callback
);
CvStatus* cv_ximgproc_rl_paint(Mat image, Mat rlSrc, Scalar value, CvCallback_0 callback);
CvStatus* cv_ximgproc_rl_threshold(
    Mat src, Mat rlDest, double thresh, int type, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // CVD_XIMGPROC_H
