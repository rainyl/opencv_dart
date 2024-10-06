/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef CVD_XIMGPROC_H
#define CVD_XIMGPROC_H

#include "../core/core.h"
#include "core/types.h"
#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/ximgproc.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::RFFeatureGetter>, RFFeatureGetter)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::StructuredEdgeDetection>, StructuredEdgeDetection)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::segmentation::GraphSegmentation>, GraphSegmentation)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::EdgeDrawing>, EdgeDrawing)

#else
CVD_TYPEDEF(void *, RFFeatureGetter)
CVD_TYPEDEF(void *, StructuredEdgeDetection)
CVD_TYPEDEF(void *, GraphSegmentation)
CVD_TYPEDEF(void *, EdgeDrawing)
#endif

CvStatus *
ximgproc_anisotropicDiffusion(Mat src, CVD_OUT Mat *dst, float alpha, float K, int niters);
CvStatus *ximgproc_edgePreservingFilter(Mat src, CVD_OUT Mat *dst, int d, double threshold);
CvStatus *ximgproc_findEllipses(
    Mat image,
    CVD_OUT Mat *ellipses,
    float scoreThreshold,
    float reliabilityThreshold,
    float centerDistanceThreshold
);
CvStatus *ximgproc_niBlackThreshold(
    Mat src,
    CVD_OUT Mat *dst,
    double maxValue,
    int type,
    int blockSize,
    double k,
    int binarizationMethod,
    double r
);
CvStatus *ximgproc_PeiLinNormalization(Mat I, CVD_OUT Mat *dst);
CvStatus *ximgproc_thinning(Mat src, Mat *dst, int thinningType);

// RFFeatureGetter
CvStatus *ximgproc_RFFeatureGetter_Create(CVD_OUT RFFeatureGetter *rval);
void ximgproc_RFFeatureGetter_Close(RFFeatureGetterPtr self);
CvStatus *ximgproc_RFFeatureGetter_getFeatures(
    RFFeatureGetter self,
    Mat src,
    CVD_OUT Mat *features,
    int gnrmRad,
    int gsmthRad,
    int shrink,
    int outNum,
    int gradNum
);
CvStatus *ximgproc_RFFeatureGetter_Clear(RFFeatureGetter self);
CvStatus *ximgproc_RFFeatureGetter_Empty(RFFeatureGetter self, bool *rval);

// StructuredEdgeDetection
CvStatus *
ximgproc_StructuredEdgeDetection_Create(char *model, CVD_OUT StructuredEdgeDetection *rval);
CvStatus *ximgproc_StructuredEdgeDetection_Create_1(
    char *model, RFFeatureGetter howToGetFeatures, CVD_OUT StructuredEdgeDetection *rval
);
void ximgproc_StructuredEdgeDetection_Close(StructuredEdgeDetectionPtr self);
CvStatus *ximgproc_StructuredEdgeDetection_computeOrientation(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat *dst
);
CvStatus *ximgproc_StructuredEdgeDetection_detectEdges(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat *dst
);
CvStatus *ximgproc_StructuredEdgeDetection_edgesNms(
    StructuredEdgeDetection self,
    Mat edge_image,
    Mat orientation_image,
    CVD_OUT Mat *dst,
    int r,
    int s,
    float m,
    bool isParallel
);

// Box, EdgeBoxes
typedef struct Box {
  int h;
  float score;
  int w;
  int x;
  int y;
} Box;

typedef struct EdgeBoxes {
  float alpha;
  float beta;
  float eta;
  float minScore;
  int maxBoxes;
  float edgeMinMag;
  float edgeMergeThr;
  float clusterMinMag;
  float maxAspectRatio;
  float minBoxArea;
  float gamma;
  float kappa;
} EdgeBoxes;

CvStatus *ximgproc_EdgeBoxes_getBoundingBoxes(
    EdgeBoxes self,
    Mat edge_map,
    Mat orientation_map,
    CVD_OUT VecRect *boxes,
    CVD_OUT VecF32 *scores
);

// GraphSegmentation
CvStatus *
ximgproc_GraphSegmentation_Create(float sigma, float k, int min_size, GraphSegmentation *rval);
void ximgproc_GraphSegmentation_Close(GraphSegmentationPtr self);
CvStatus *ximgproc_GraphSegmentation_getK(GraphSegmentation self, float *rval);
CvStatus *ximgproc_GraphSegmentation_getMinSize(GraphSegmentation self, int *rval);
CvStatus *ximgproc_GraphSegmentation_getSigma(GraphSegmentation self, double *rval);
CvStatus *
ximgproc_GraphSegmentation_processImage(GraphSegmentation self, Mat src, CVD_OUT Mat *dst);
CvStatus *ximgproc_GraphSegmentation_setK(GraphSegmentation self, float val);
CvStatus *ximgproc_GraphSegmentation_setMinSize(GraphSegmentation self, int val);
CvStatus *ximgproc_GraphSegmentation_setSigma(GraphSegmentation self, double val);

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

CvStatus *ximgproc_EdgeDrawing_Create(EdgeDrawing *rval);
void ximgproc_EdgeDrawing_Close(EdgeDrawingPtr self);
CvStatus *ximgproc_EdgeDrawing_detectEdges(EdgeDrawing self, Mat src);
CvStatus *ximgproc_EdgeDrawing_detectEllipses(EdgeDrawing self, Mat *ellipses);
CvStatus *ximgproc_EdgeDrawing_detectLines(EdgeDrawing self, Mat *lines);
CvStatus *ximgproc_EdgeDrawing_getEdgeImage(EdgeDrawing self, Mat *dst);
CvStatus *ximgproc_EdgeDrawing_getGradientImage(EdgeDrawing self, Mat *dst);
CvStatus *ximgproc_EdgeDrawing_getSegmentIndicesOfLines(EdgeDrawing self, VecI32 *rval);
CvStatus *ximgproc_EdgeDrawing_getSegments(EdgeDrawing self, VecVecPoint *rval);
CvStatus *ximgproc_EdgeDrawing_setParams(EdgeDrawing self, EdgeDrawingParams params);
CvStatus *ximgproc_EdgeDrawing_getParams(EdgeDrawing self, EdgeDrawingParams *params);

// Binary morphology on run-length encoded image
CvStatus *ximgproc_rl_createRLEImage(const VecPoint3i runs, Mat *res, Size size);
CvStatus *ximgproc_rl_dilate(Mat rlSrc, Mat *rlDest, Mat rlKernel, Point anchor);
CvStatus *ximgproc_rl_erode(Mat rlSrc, Mat *rlDest, Mat rlKernel, bool bBoundaryOn, Point anchor);
CvStatus *ximgproc_rl_getStructuringElement(int shape, Size ksize, Mat *rval);
CvStatus *ximgproc_rl_isRLMorphologyPossible(Mat rlStructuringElement, bool *rval);
CvStatus *ximgproc_rl_morphologyEx(
    Mat rlSrc, Mat *rlDest, int op, Mat rlKernel, bool bBoundaryOnForErosion, Point anchor
);
CvStatus *ximgproc_rl_paint(Mat image, Mat rlSrc, const Scalar value);
CvStatus *ximgproc_rl_threshold(Mat src, Mat *rlDest, double thresh, int type);

#ifdef __cplusplus
}
#endif

#endif // CVD_XIMGPROC_H
