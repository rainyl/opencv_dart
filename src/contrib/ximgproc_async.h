/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef CVD_XIMGPROC_ASYNC_H
#define CVD_XIMGPROC_ASYNC_H

#include "../core/types.h"
#include "ximgproc.h"
#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/ximgproc.hpp>
extern "C" {
#endif

CvStatus *ximgproc_anisotropicDiffusion_Async(
    Mat src, float alpha, float K, int niters, CvCallback_1 callback
);
CvStatus *
ximgproc_edgePreservingFilter_Async(Mat src, int d, double threshold, CvCallback_1 callback);
CvStatus *ximgproc_findEllipses_Async(
    Mat image,
    float scoreThreshold,
    float reliabilityThreshold,
    float centerDistanceThreshold,
    CvCallback_1 callback
);
CvStatus *ximgproc_niBlackThreshold_Async(
    Mat src,
    double maxValue,
    int type,
    int blockSize,
    double k,
    int binarizationMethod,
    double r,
    CvCallback_1 callback
);
CvStatus *ximgproc_PeiLinNormalization_Async(Mat I, CvCallback_1 callback);
CvStatus *ximgproc_thinning_Async(Mat src, int thinningType, CvCallback_1 callback);

// RFFeatureGetter
CvStatus *ximgproc_RFFeatureGetter_Create_Async(CvCallback_1 callback);
// void ximgproc_RFFeatureGetter_Close_Async(RFFeatureGetterPtr self);
CvStatus *ximgproc_RFFeatureGetter_getFeatures_Async(
    RFFeatureGetter self,
    Mat src,
    int gnrmRad,
    int gsmthRad,
    int shrink,
    int outNum,
    int gradNum,
    CvCallback_1 callback
);

// StructuredEdgeDetection
CvStatus *ximgproc_StructuredEdgeDetection_Create_Async(
    char *model, RFFeatureGetter howToGetFeatures, CvCallback_1 callback
);
// void ximgproc_StructuredEdgeDetection_Close_Async(StructuredEdgeDetectionPtr self);
CvStatus *ximgproc_StructuredEdgeDetection_computeOrientation_Async(
    StructuredEdgeDetection self, Mat src, CvCallback_1 callback
);
CvStatus *ximgproc_StructuredEdgeDetection_detectEdges_Async(
    StructuredEdgeDetection self, Mat src, CvCallback_1 callback
);
CvStatus *ximgproc_StructuredEdgeDetection_edgesNms_Async(
    StructuredEdgeDetection self,
    Mat edge_image,
    Mat orientation_image,
    int r,
    int s,
    float m,
    bool isParallel,
    CvCallback_1 callback
);

// GraphSegmentation
CvStatus *
ximgproc_GraphSegmentation_Create_Async(float sigma, float k, int min_size, CvCallback_1 callback);
// void ximgproc_GraphSegmentation_Close_Async(GraphSegmentationPtr self);
CvStatus *ximgproc_GraphSegmentation_processImage_Async(
    GraphSegmentation self, Mat src, CvCallback_1 callback
);

// EdgeDrawing
CvStatus *ximgproc_EdgeDrawing_Create_Async(CvCallback_1 callback);
// void ximgproc_EdgeDrawing_Close_Async(EdgeDrawingPtr self);
CvStatus *ximgproc_EdgeDrawing_detectEdges_Async(EdgeDrawing self, Mat src, CvCallback_0 callback);
CvStatus *ximgproc_EdgeDrawing_detectEllipses_Async(EdgeDrawing self, CvCallback_1 callback);
CvStatus *ximgproc_EdgeDrawing_detectLines_Async(EdgeDrawing self, CvCallback_1 callback);
CvStatus *ximgproc_EdgeDrawing_getEdgeImage_Async(EdgeDrawing self, CvCallback_1 callback);
CvStatus *ximgproc_EdgeDrawing_getGradientImage_Async(EdgeDrawing self, CvCallback_1 callback);
CvStatus *
ximgproc_EdgeDrawing_getSegmentIndicesOfLines_Async(EdgeDrawing self, CvCallback_1 callback);
CvStatus *ximgproc_EdgeDrawing_getSegments_Async(EdgeDrawing self, CvCallback_1 callback);

// Binary morphology on run-length encoded image
CvStatus *ximgproc_rl_createRLEImage_Async(const VecPoint3i runs, Size size, CvCallback_1 callback);
CvStatus *ximgproc_rl_dilate_Async(Mat rlSrc, Mat rlKernel, Point anchor, CvCallback_1 callback);
CvStatus *ximgproc_rl_erode_Async(
    Mat rlSrc, Mat rlKernel, bool bBoundaryOn, Point anchor, CvCallback_1 callback
);
CvStatus *ximgproc_rl_getStructuringElement_Async(int shape, Size ksize, CvCallback_1 callback);
CvStatus *ximgproc_rl_isRLMorphologyPossible_Async(Mat rlStructuringElement, CvCallback_1 callback);
CvStatus *ximgproc_rl_morphologyEx_Async(
    Mat rlSrc, int op, Mat rlKernel, bool bBoundaryOnForErosion, Point anchor, CvCallback_1 callback
);
CvStatus *ximgproc_rl_paint_Async(Mat image, Mat rlSrc, const Scalar value, CvCallback_0 callback);
CvStatus *ximgproc_rl_threshold_Async(Mat src, double thresh, int type, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_XIMGPROC_ASYNC_H
