/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#include "ximgproc_async.h"
#include "core/types.h"
#include "core/vec.hpp"
#include "opencv2/core/types.hpp"
#include "opencv2/ximgproc.hpp"
#include "opencv2/ximgproc/structured_edge_detection.hpp"

CvStatus *ximgproc_anisotropicDiffusion_Async(
    Mat src, float alpha, float K, int niters, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::anisotropicDiffusion(*src.ptr, dst, alpha, K, niters);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *
ximgproc_edgePreservingFilter_Async(Mat src, int d, double threshold, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::edgePreservingFilter(*src.ptr, dst, d, threshold);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_findEllipses_Async(
    Mat image,
    float scoreThreshold,
    float reliabilityThreshold,
    float centerDistanceThreshold,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::findEllipses(*image.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_niBlackThreshold_Async(
    Mat src,
    double maxValue,
    int type,
    int blockSize,
    double k,
    int binarizationMethod,
    double r,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::niBlackThreshold(
      *src.ptr, dst, maxValue, type, blockSize, k, binarizationMethod, r
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_PeiLinNormalization_Async(Mat I, CvCallback_1 callback) {
  BEGIN_WRAP
  auto dst = cv::ximgproc::PeiLinNormalization(*I.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_thinning_Async(Mat src, int thinningType, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::thinning(*src.ptr, dst, thinningType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

// RFFeatureGetter
CvStatus *ximgproc_RFFeatureGetter_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new RFFeatureGetter{
      new cv::Ptr<cv::ximgproc::RFFeatureGetter>(cv::ximgproc::createRFFeatureGetter())
  });
  END_WRAP
}
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
) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->getFeatures(*src.ptr, dst, gnrmRad, gsmthRad, shrink, outNum, gradNum);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

// StructuredEdgeDetection
CvStatus *ximgproc_StructuredEdgeDetection_Create_Async(
    char *model, RFFeatureGetter howToGetFeatures, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new StructuredEdgeDetection{new cv::Ptr<cv::ximgproc::StructuredEdgeDetection>(
      cv::ximgproc::createStructuredEdgeDetection(model, *howToGetFeatures.ptr)
  )});
  END_WRAP
}
// void ximgproc_StructuredEdgeDetection_Close_Async(StructuredEdgeDetectionPtr self);
CvStatus *ximgproc_StructuredEdgeDetection_computeOrientation_Async(
    StructuredEdgeDetection self, Mat src, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->computeOrientation(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_StructuredEdgeDetection_detectEdges_Async(
    StructuredEdgeDetection self, Mat src, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->detectEdges(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_StructuredEdgeDetection_edgesNms_Async(
    StructuredEdgeDetection self,
    Mat edge_image,
    Mat orientation_image,
    int r,
    int s,
    float m,
    bool isParallel,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->edgesNms(*edge_image.ptr, *orientation_image.ptr, dst, r, s, m, isParallel);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

// GraphSegmentation
CvStatus *
ximgproc_GraphSegmentation_Create_Async(float sigma, float k, int min_size, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new GraphSegmentation{new cv::Ptr<cv::ximgproc::segmentation::GraphSegmentation>(
      cv::ximgproc::segmentation::createGraphSegmentation(sigma, k, min_size)
  )});
  END_WRAP
}
// void ximgproc_GraphSegmentation_Close_Async(GraphSegmentationPtr self);
CvStatus *ximgproc_GraphSegmentation_processImage_Async(
    GraphSegmentation self, Mat src, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->processImage(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

// EdgeDrawing
CvStatus *ximgproc_EdgeDrawing_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new EdgeDrawing{new cv::Ptr<cv::ximgproc::EdgeDrawing>(cv::ximgproc::createEdgeDrawing())
  });
  END_WRAP
}
// void ximgproc_EdgeDrawing_Close_Async(EdgeDrawingPtr self);
CvStatus *ximgproc_EdgeDrawing_detectEdges_Async(EdgeDrawing self, Mat src, CvCallback_0 callback) {
  BEGIN_WRAP(*self.ptr)->detectEdges(*src.ptr);
  callback();
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_detectEllipses_Async(EdgeDrawing self, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->detectEllipses(dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_detectLines_Async(EdgeDrawing self, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->detectLines(dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getEdgeImage_Async(EdgeDrawing self, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->getEdgeImage(dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getGradientImage_Async(EdgeDrawing self, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->getGradientImage(dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *
ximgproc_EdgeDrawing_getSegmentIndicesOfLines_Async(EdgeDrawing self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto dst = (*self.ptr)->getSegmentIndicesOfLines();
  callback(vecint_cpp2c_p(dst));
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getSegments_Async(EdgeDrawing self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto dst = (*self.ptr)->getSegments();
  callback(vecvecpoint_cpp2c_p(dst));
  END_WRAP
}

// Binary morphology on run-length encoded image
CvStatus *
ximgproc_rl_createRLEImage_Async(const VecPoint3i runs, Size size, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  auto _runs = vecpoint3i_c2cpp(runs);
  cv::ximgproc::rl::createRLEImage(_runs, dst, cv::Size(size.width, size.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_rl_dilate_Async(Mat rlSrc, Mat rlKernel, Point anchor, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::rl::dilate(*rlSrc.ptr, dst, *rlKernel.ptr, cv::Point(anchor.x, anchor.y));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_rl_erode_Async(
    Mat rlSrc, Mat rlKernel, bool bBoundaryOn, Point anchor, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::rl::erode(
      *rlSrc.ptr, dst, *rlKernel.ptr, bBoundaryOn, cv::Point(anchor.x, anchor.y)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_rl_getStructuringElement_Async(int shape, Size ksize, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst = cv::ximgproc::rl::getStructuringElement(shape, cv::Size(ksize.width, ksize.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *
ximgproc_rl_isRLMorphologyPossible_Async(Mat rlStructuringElement, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool{cv::ximgproc::rl::isRLMorphologyPossible(*rlStructuringElement.ptr)});
  END_WRAP
}
CvStatus *ximgproc_rl_morphologyEx_Async(
    Mat rlSrc, int op, Mat rlKernel, bool bBoundaryOnForErosion, Point anchor, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::rl::morphologyEx(
      *rlSrc.ptr, dst, op, *rlKernel.ptr, bBoundaryOnForErosion, cv::Point(anchor.x, anchor.y)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
CvStatus *ximgproc_rl_paint_Async(Mat image, Mat rlSrc, const Scalar value, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::Scalar val = cv::Scalar(value.val1, value.val2, value.val3, value.val4);
  cv::ximgproc::rl::paint(*image.ptr, *rlSrc.ptr, val);
  callback();
  END_WRAP
}
CvStatus *ximgproc_rl_threshold_Async(Mat src, double thresh, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::ximgproc::rl::threshold(*src.ptr, dst, thresh, type);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
