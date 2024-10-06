#include "ximgproc.h"
#include "core/types.h"
#include "core/vec.hpp"

CvStatus *
ximgproc_anisotropicDiffusion(Mat src, CVD_OUT Mat *dst, float alpha, float K, int niters) {
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::anisotropicDiffusion(*src.ptr, *_dst, alpha, K, niters);
  *dst = {_dst};
  END_WRAP
}
CvStatus *ximgproc_edgePreservingFilter(Mat src, CVD_OUT Mat *dst, int d, double threshold) {
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::edgePreservingFilter(*src.ptr, *_dst, d, threshold);
  *dst = {_dst};
  END_WRAP
}
CvStatus *ximgproc_findEllipses(
    Mat image,
    CVD_OUT Mat *ellipses,
    float scoreThreshold,
    float reliabilityThreshold,
    float centerDistanceThreshold
) {
  BEGIN_WRAP
  cv::Mat *_ellipses = new cv::Mat();
  cv::ximgproc::findEllipses(
      *image.ptr, *_ellipses, scoreThreshold, reliabilityThreshold, centerDistanceThreshold
  );
  *ellipses = {_ellipses};
  END_WRAP
}
CvStatus *ximgproc_niBlackThreshold(
    Mat src,
    CVD_OUT Mat *dst,
    double maxValue,
    int type,
    int blockSize,
    double k,
    int binarizationMethod,
    double r
) {
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::niBlackThreshold(
      *src.ptr, *_dst, maxValue, type, blockSize, k, binarizationMethod, r
  );
  *dst = {_dst};
  END_WRAP
}
CvStatus *ximgproc_PeiLinNormalization(Mat I, CVD_OUT Mat *dst) {
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::PeiLinNormalization(*I.ptr, *_dst);
  *dst = {_dst};
  END_WRAP
}
CvStatus *ximgproc_thinning(Mat src, Mat *dst, int thinningType) {
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::thinning(*src.ptr, *_dst, thinningType);
  *dst = {_dst};
  END_WRAP
}

// RFFeatureGetter
CvStatus *ximgproc_RFFeatureGetter_Create(CVD_OUT RFFeatureGetter *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ximgproc::RFFeatureGetter>(cv::ximgproc::createRFFeatureGetter())};
  END_WRAP
}
void ximgproc_RFFeatureGetter_Close(RFFeatureGetterPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}
CvStatus *ximgproc_RFFeatureGetter_getFeatures(
    RFFeatureGetter self,
    Mat src,
    CVD_OUT Mat *features,
    int gnrmRad,
    int gsmthRad,
    int shrink,
    int outNum,
    int gradNum
) {
  BEGIN_WRAP
  cv::Mat _features;
  (*self.ptr)->getFeatures(*src.ptr, _features, gnrmRad, gsmthRad, shrink, outNum, gradNum);
  *features = {new cv::Mat(_features)};
  END_WRAP
}
CvStatus *ximgproc_RFFeatureGetter_Clear(RFFeatureGetter self) {
  BEGIN_WRAP(*self.ptr)->clear();
  END_WRAP
}
CvStatus *ximgproc_RFFeatureGetter_Empty(RFFeatureGetter self, bool *rval) {
  BEGIN_WRAP
  *rval = (*self.ptr)->empty();
  END_WRAP
}

// StructuredEdgeDetection
CvStatus *
ximgproc_StructuredEdgeDetection_Create(char *model, CVD_OUT StructuredEdgeDetection *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ximgproc::StructuredEdgeDetection>(
      cv::ximgproc::createStructuredEdgeDetection(model)
  )};
  END_WRAP
}
CvStatus *ximgproc_StructuredEdgeDetection_Create_1(
    char *model, RFFeatureGetter howToGetFeatures, CVD_OUT StructuredEdgeDetection *rval
) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ximgproc::StructuredEdgeDetection>(
      cv::ximgproc::createStructuredEdgeDetection(model, *howToGetFeatures.ptr)
  )};
  END_WRAP
}
void ximgproc_StructuredEdgeDetection_Close(StructuredEdgeDetectionPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}
CvStatus *ximgproc_StructuredEdgeDetection_computeOrientation(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat *dst
) {
  BEGIN_WRAP
  cv::Mat _dst;
  (*self.ptr)->computeOrientation(*src.ptr, _dst);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}
CvStatus *ximgproc_StructuredEdgeDetection_detectEdges(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat *dst
) {
  BEGIN_WRAP
  cv::Mat _dst;
  (*self.ptr)->detectEdges(*src.ptr, _dst);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}
CvStatus *ximgproc_StructuredEdgeDetection_edgesNms(
    StructuredEdgeDetection self,
    Mat edge_image,
    Mat orientation_image,
    CVD_OUT Mat *dst,
    int r,
    int s,
    float m,
    bool isParallel
) {
  BEGIN_WRAP
  cv::Mat _dst;
  (*self.ptr)->edgesNms(*edge_image.ptr, *orientation_image.ptr, _dst, r, s, m, isParallel);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}

// EdgeBoxes
CvStatus *ximgproc_EdgeBoxes_getBoundingBoxes(
    EdgeBoxes self,
    Mat edge_map,
    Mat orientation_map,
    CVD_OUT VecRect *boxes,
    CVD_OUT VecF32 *scores
) {
  BEGIN_WRAP
  std::vector<float> _scores;
  std::vector<cv::Rect> _boxes;
  auto _self = cv::ximgproc::createEdgeBoxes(
      self.alpha,
      self.beta,
      self.eta,
      self.minScore,
      self.maxBoxes,
      self.edgeMinMag,
      self.edgeMergeThr,
      self.clusterMinMag,
      self.maxAspectRatio,
      self.minBoxArea,
      self.gamma,
      self.kappa
  );
  _self->getBoundingBoxes(*edge_map.ptr, *orientation_map.ptr, _boxes, _scores);
  *boxes = vecrect_cpp2c(_boxes);
  *scores = vecfloat_cpp2c(_scores);
  END_WRAP
}

// GraphSegmentation
CvStatus *
ximgproc_GraphSegmentation_Create(float sigma, float k, int min_size, GraphSegmentation *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ximgproc::segmentation::GraphSegmentation>(
      cv::ximgproc::segmentation::createGraphSegmentation(sigma, k, min_size)
  )};
  END_WRAP
}
void ximgproc_GraphSegmentation_Close(GraphSegmentationPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}
CvStatus *ximgproc_GraphSegmentation_getK(GraphSegmentation self, float *rval) {
  BEGIN_WRAP
  *rval = (*self.ptr)->getK();
  END_WRAP
}
CvStatus *ximgproc_GraphSegmentation_getMinSize(GraphSegmentation self, int *rval) {
  BEGIN_WRAP
  *rval = (*self.ptr)->getMinSize();
  END_WRAP
}
CvStatus *ximgproc_GraphSegmentation_getSigma(GraphSegmentation self, double *rval) {
  BEGIN_WRAP
  *rval = (*self.ptr)->getSigma();
  END_WRAP
}
CvStatus *
ximgproc_GraphSegmentation_processImage(GraphSegmentation self, Mat src, CVD_OUT Mat *dst) {
  BEGIN_WRAP
  cv::Mat _dst;
  (*self.ptr)->processImage(*src.ptr, _dst);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}
CvStatus *ximgproc_GraphSegmentation_setK(GraphSegmentation self, float val) {
  BEGIN_WRAP(*self.ptr)->setK(val);
  END_WRAP
}
CvStatus *ximgproc_GraphSegmentation_setMinSize(GraphSegmentation self, int val) {
  BEGIN_WRAP(*self.ptr)->setMinSize(val);
  END_WRAP
}
CvStatus *ximgproc_GraphSegmentation_setSigma(GraphSegmentation self, double val) {
  BEGIN_WRAP(*self.ptr)->setSigma(val);
  END_WRAP
}

// EdgeDrawing
CvStatus *ximgproc_EdgeDrawing_Create(EdgeDrawing *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::ximgproc::EdgeDrawing>(cv::ximgproc::createEdgeDrawing())};
  END_WRAP
}
void ximgproc_EdgeDrawing_Close(EdgeDrawingPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}
CvStatus *ximgproc_EdgeDrawing_detectEdges(EdgeDrawing self, Mat src) {
  BEGIN_WRAP(*self.ptr)->detectEdges(*src.ptr);
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_detectEllipses(EdgeDrawing self, Mat *ellipses) {
  BEGIN_WRAP
  cv::Mat _ellipses;
  (*self.ptr)->detectEllipses(_ellipses);
  *ellipses = {new cv::Mat(_ellipses)};
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_detectLines(EdgeDrawing self, Mat *lines) {
  BEGIN_WRAP
  cv::Mat _lines;
  (*self.ptr)->detectLines(_lines);
  *lines = {new cv::Mat(_lines)};
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getEdgeImage(EdgeDrawing self, Mat *dst) {
  BEGIN_WRAP
  cv::Mat _dst;
  (*self.ptr)->getEdgeImage(_dst);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getGradientImage(EdgeDrawing self, Mat *dst) {
  BEGIN_WRAP
  cv::Mat _dst;
  (*self.ptr)->getGradientImage(_dst);
  *dst = {new cv::Mat(_dst)};
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getSegmentIndicesOfLines(EdgeDrawing self, VecI32 *rval) {
  BEGIN_WRAP
  std::vector<int> _rval = (*self.ptr)->getSegmentIndicesOfLines();
  *rval = vecint_cpp2c(_rval);
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getSegments(EdgeDrawing self, VecVecPoint *rval) {
  BEGIN_WRAP
  std::vector<std::vector<cv::Point>> _rval = (*self.ptr)->getSegments();
  *rval = vecvecpoint_cpp2c(_rval);
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_setParams(EdgeDrawing self, EdgeDrawingParams params) {
  BEGIN_WRAP
  cv::ximgproc::EdgeDrawing::Params _params;
  _params.AnchorThresholdValue = params.AnchorThresholdValue;
  _params.EdgeDetectionOperator = params.EdgeDetectionOperator;
  _params.GradientThresholdValue = params.GradientThresholdValue;
  _params.LineFitErrorThreshold = params.LineFitErrorThreshold;
  _params.MaxDistanceBetweenTwoLines = params.MaxDistanceBetweenTwoLines;
  _params.MaxErrorThreshold = params.MaxErrorThreshold;
  _params.MinLineLength = params.MinLineLength;
  _params.MinPathLength = params.MinPathLength;
  _params.NFAValidation = params.NFAValidation;
  _params.PFmode = params.PFmode;
  _params.ScanInterval = params.ScanInterval;
  _params.Sigma = params.Sigma;
  _params.SumFlag = params.SumFlag;
  (*self.ptr)->setParams(_params);
  END_WRAP
}
CvStatus *ximgproc_EdgeDrawing_getParams(EdgeDrawing self, EdgeDrawingParams *params) {
  BEGIN_WRAP
  cv::ximgproc::EdgeDrawing::Params _params = (*self.ptr)->params;
  *params = {
      _params.AnchorThresholdValue,
      _params.EdgeDetectionOperator,
      _params.GradientThresholdValue,
      _params.LineFitErrorThreshold,
      _params.MaxDistanceBetweenTwoLines,
      _params.MaxErrorThreshold,
      _params.MinLineLength,
      _params.MinPathLength,
      _params.NFAValidation,
      _params.PFmode,
      _params.ScanInterval,
      _params.Sigma,
      _params.SumFlag,
  };
  END_WRAP
}

// Binary morphology on run-length encoded image
CvStatus *ximgproc_rl_createRLEImage(const VecPoint3i runs, Mat *res, Size size) {
  BEGIN_WRAP
  cv::Mat _res;
  auto _runs = vecpoint3i_c2cpp(runs);
  cv::ximgproc::rl::createRLEImage(_runs, _res, cv::Size(size.width, size.height));
  *res = {new cv::Mat(_res)};
  END_WRAP
}
CvStatus *ximgproc_rl_dilate(Mat rlSrc, Mat *rlDest, Mat rlKernel, Point anchor) {
  BEGIN_WRAP
  cv::Mat _rlDest;
  cv::ximgproc::rl::dilate(*rlSrc.ptr, _rlDest, *rlKernel.ptr, cv::Point(anchor.x, anchor.y));
  *rlDest = {new cv::Mat(_rlDest)};
  END_WRAP
}
CvStatus *ximgproc_rl_erode(Mat rlSrc, Mat *rlDest, Mat rlKernel, bool bBoundaryOn, Point anchor) {
  BEGIN_WRAP
  cv::Mat _rlDest;
  cv::ximgproc::rl::erode(
      *rlSrc.ptr, _rlDest, *rlKernel.ptr, bBoundaryOn, cv::Point(anchor.x, anchor.y)
  );
  *rlDest = {new cv::Mat(_rlDest)};
  END_WRAP
}
CvStatus *ximgproc_rl_getStructuringElement(int shape, Size ksize, Mat *rval) {
  BEGIN_WRAP
  cv::Mat _rval =
      cv::ximgproc::rl::getStructuringElement(shape, cv::Size(ksize.width, ksize.height));
  *rval = {new cv::Mat(_rval)};
  END_WRAP
}
CvStatus *ximgproc_rl_isRLMorphologyPossible(Mat rlStructuringElement, bool *rval) {
  BEGIN_WRAP
  *rval = cv::ximgproc::rl::isRLMorphologyPossible(*rlStructuringElement.ptr);
  END_WRAP
}
CvStatus *ximgproc_rl_morphologyEx(
    Mat rlSrc, Mat *rlDest, int op, Mat rlKernel, bool bBoundaryOnForErosion, Point anchor
) {
  BEGIN_WRAP
  cv::Mat _rlDest;
  cv::ximgproc::rl::morphologyEx(
      *rlSrc.ptr, _rlDest, op, *rlKernel.ptr, bBoundaryOnForErosion, cv::Point(anchor.x, anchor.y)
  );
  *rlDest = {new cv::Mat(_rlDest)};
  END_WRAP
}
CvStatus *ximgproc_rl_paint(Mat image, Mat rlSrc, const Scalar value) {
  BEGIN_WRAP
  cv::ximgproc::rl::paint(
      *image.ptr, *rlSrc.ptr, cv::Scalar(value.val1, value.val2, value.val3, value.val4)
  );
  END_WRAP
}
CvStatus *ximgproc_rl_threshold(Mat src, Mat *rlDest, double thresh, int type) {
  BEGIN_WRAP
  cv::Mat _rlDest;
  cv::ximgproc::rl::threshold(*src.ptr, _rlDest, thresh, type);
  *rlDest = {new cv::Mat(_rlDest)};
  END_WRAP
}
