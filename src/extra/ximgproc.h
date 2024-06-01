/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef CVD_XIMGPROC_H
#define CVD_XIMGPROC_H

#include "../core/core.h"
#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/ximgproc.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::RFFeatureGetter>, PtrRFFeatureGetter)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::StructuredEdgeDetection>, PtrStructuredEdgeDetection)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::EdgeBoxes>, PtrEdgeBoxes)
CVD_TYPEDEF(cv::Ptr<cv::ximgproc::segmentation::GraphSegmentation>, PtrGraphSegmentation)
#else
CVD_TYPEDEF(void *, PtrRFFeatureGetter)
CVD_TYPEDEF(void *, PtrStructuredEdgeDetection)
CVD_TYPEDEF(void *, PtrEdgeBoxes)
CVD_TYPEDEF(void *, PtrGraphSegmentation)
#endif

CVD_TYPEDEF_PTR(PtrRFFeatureGetter)
CVD_TYPEDEF_PTR(PtrStructuredEdgeDetection)
CVD_TYPEDEF_PTR(PtrEdgeBoxes)
CVD_TYPEDEF_PTR(PtrGraphSegmentation)

CvStatus ximgproc_anisotropicDiffusion(Mat src, CVD_OUT Mat *dst, float alpha, float K, int niters);
CvStatus ximgproc_edgePreservingFilter(Mat src, CVD_OUT Mat *dst, int d, double threshold);
CvStatus ximgproc_findEllipses(Mat image, CVD_OUT Mat *ellipses, float scoreThreshold,
                               float reliabilityThreshold, float centerDistanceThreshold);
CvStatus ximgproc_niBlackThreshold(Mat src, CVD_OUT Mat *dst, double maxValue, int type, int blockSize,
                                   double k, int binarizationMethod, double r);
CvStatus ximgproc_PeiLinNormalization(Mat I, CVD_OUT Mat *dst);
CvStatus ximgproc_thinning(Mat src, Mat *dst, int thinningType);

// RFFeatureGetter
CvStatus ximgproc_RFFeatureGetter_Create(CVD_OUT PtrRFFeatureGetter *rval);
void     ximgproc_RFFeatureGetter_Close(PtrRFFeatureGetter *self);
CvStatus ximgproc_RFFeatureGetter_getFeatures(PtrRFFeatureGetter self, Mat src, CVD_OUT Mat features,
                                              int gnrmRad, int gsmthRad, int shrink, int outNum, int gradNum);
CvStatus ximgproc_RFFeatureGetter_Clear(PtrRFFeatureGetter self);
CvStatus ximgproc_RFFeatureGetter_Empty(PtrRFFeatureGetter self, bool *rval);

// StructuredEdgeDetection
CvStatus ximgproc_StructuredEdgeDetection_Create(char *model, PtrRFFeatureGetter howToGetFeatures,
                                                 CVD_OUT PtrStructuredEdgeDetection *rval);
void     ximgproc_StructuredEdgeDetection_Close(PtrStructuredEdgeDetection *self);
CvStatus ximgproc_StructuredEdgeDetection_computeOrientation(PtrStructuredEdgeDetection self, Mat src,
                                                             CVD_OUT Mat dst);
CvStatus ximgproc_StructuredEdgeDetection_detectEdges(PtrStructuredEdgeDetection self, Mat src,
                                                      CVD_OUT Mat dst);
CvStatus ximgproc_StructuredEdgeDetection_edgesNms(PtrStructuredEdgeDetection self, Mat edge_image,
                                                   Mat orientation_image, CVD_OUT Mat dst, int r, int s,
                                                   float m, bool isParallel);

// Box, EdgeBoxes
typedef struct Box {
  int   h;
  float score;
  int   w;
  int   x;
  int   y;
} Box;
typedef struct Boxes {
  Box *ptr;
  int  length;
} Boxes;

CvStatus ximgproc_EdgeBoxes_Create(float alpha, float beta, float eta, float minScore, int maxBoxes,
                                   float edgeMinMag, float edgeMergeThr, float clusterMinMag,
                                   float maxAspectRatio, float minBoxArea, float gamma, float kappa,
                                   PtrEdgeBoxes *rval);
CvStatus ximgproc_EdgeBoxes_Close(PtrEdgeBoxes *self);
CvStatus ximgproc_EdgeBoxes_getAlpha(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getBeta(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getBoundingBoxes(PtrEdgeBoxes self, Mat edge_map, Mat orientation_map,
                                             VecRect boxes, CVD_OUT VecFloat *scores);
CvStatus ximgproc_EdgeBoxes_getClusterMinMag(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getEdgeMergeThr(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getEdgeMinMag(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getEta(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getGamma(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getKappa(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getMaxAspectRatio(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getMaxBoxes(PtrEdgeBoxes self, int *rval);
CvStatus ximgproc_EdgeBoxes_getMinBoxArea(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_getMinScore(PtrEdgeBoxes self, float *rval);
CvStatus ximgproc_EdgeBoxes_setAlpha(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setBeta(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setClusterMinMag(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setEdgeMergeThr(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setEdgeMinMag(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setEta(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setGamma(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setKappa(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setMaxAspectRatio(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setMaxBoxes(PtrEdgeBoxes self, int val);
CvStatus ximgproc_EdgeBoxes_setMinBoxArea(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_setMinScore(PtrEdgeBoxes self, float val);
CvStatus ximgproc_EdgeBoxes_clear(PtrEdgeBoxes self);
CvStatus ximgproc_EdgeBoxes_empty(PtrEdgeBoxes self, bool *val);

// GraphSegmentation
CvStatus ximgproc_GraphSegmentation_Create(float sigma, float k, int min_size, PtrGraphSegmentation *rval);
void     ximgproc_GraphSegmentation_Close(PtrGraphSegmentation *self);
CvStatus ximgproc_GraphSegmentation_getK(PtrGraphSegmentation self, float *rval);
CvStatus ximgproc_GraphSegmentation_getMinSize(PtrGraphSegmentation self, int *rval);
CvStatus ximgproc_GraphSegmentation_getSigma(PtrGraphSegmentation self, double *rval);
CvStatus ximgproc_GraphSegmentation_processImage(PtrGraphSegmentation self, Mat src, CVD_OUT Mat *dst);
CvStatus ximgproc_GraphSegmentation_setK(PtrGraphSegmentation self, float val);
CvStatus ximgproc_GraphSegmentation_setMinSize(PtrGraphSegmentation self, int val);
CvStatus ximgproc_GraphSegmentation_setSigma(PtrGraphSegmentation self, double val);

#ifdef __cplusplus
}
#endif

#endif // CVD_XIMGPROC_H
