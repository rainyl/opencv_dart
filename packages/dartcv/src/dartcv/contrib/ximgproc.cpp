#include <vector>
#include "dartcv/contrib/ximgproc.h"
#include "dartcv/core/vec.hpp"

CvStatus* cv_ximgproc_anisotropicDiffusion(
    Mat src, CVD_OUT Mat dst, float alpha, float K, int niters, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::anisotropicDiffusion(CVDEREF(src), CVDEREF(dst), alpha, K, niters);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_edgePreservingFilter(
    Mat src, CVD_OUT Mat dst, int d, double threshold, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::edgePreservingFilter(CVDEREF(src), CVDEREF(dst), d, threshold);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_findEllipses(
    Mat image,
    CVD_OUT Mat ellipses,
    float scoreThreshold,
    float reliabilityThreshold,
    float centerDistanceThreshold,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::findEllipses(
        CVDEREF(image),
        CVDEREF(ellipses),
        scoreThreshold,
        reliabilityThreshold,
        centerDistanceThreshold
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

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
) {
    BEGIN_WRAP
    cv::ximgproc::niBlackThreshold(
        CVDEREF(src), CVDEREF(dst), maxValue, type, blockSize, k, binarizationMethod, r
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_ximgproc_PeiLinNormalization(Mat I, CVD_OUT Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::ximgproc::PeiLinNormalization(CVDEREF(I), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_thinning(Mat src, Mat dst, int thinningType, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::ximgproc::thinning(CVDEREF(src), CVDEREF(dst), thinningType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

// RFFeatureGetter
CvStatus* cv_ximgproc_RFFeatureGetter_create(CVD_OUT RFFeatureGetter* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::ximgproc::RFFeatureGetter>(cv::ximgproc::createRFFeatureGetter())};
    END_WRAP
}

void cv_ximgproc_RFFeatureGetter_close(RFFeatureGetterPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

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
) {
    BEGIN_WRAP(CVDEREF(self))
        ->getFeatures(CVDEREF(src), CVDEREF(features), gnrmRad, gsmthRad, shrink, outNum, gradNum);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_RFFeatureGetter_clear(RFFeatureGetter self) {
    BEGIN_WRAP(CVDEREF(self))->clear();
    END_WRAP
}

bool cv_ximgproc_RFFeatureGetter_empty(RFFeatureGetter self) {
    return (CVDEREF(self))->empty();
}

// StructuredEdgeDetection
CvStatus* cv_ximgproc_StructuredEdgeDetection_create(
    const char* model, CVD_OUT StructuredEdgeDetection* rval
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::ximgproc::StructuredEdgeDetection>(
        cv::ximgproc::createStructuredEdgeDetection(model)
    )};
    END_WRAP
}

CvStatus* cv_ximgproc_StructuredEdgeDetection_create_1(
    const char* model, RFFeatureGetter* howToGetFeatures, CVD_OUT StructuredEdgeDetection* rval
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::ximgproc::StructuredEdgeDetection>(
        cv::ximgproc::createStructuredEdgeDetection(model, *howToGetFeatures->ptr)
    )};
    END_WRAP
}

void cv_ximgproc_StructuredEdgeDetection_close(StructuredEdgeDetectionPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_ximgproc_StructuredEdgeDetection_computeOrientation(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->computeOrientation(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_StructuredEdgeDetection_detectEdges(
    StructuredEdgeDetection self, Mat src, CVD_OUT Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detectEdges(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

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
) {
    BEGIN_WRAP(CVDEREF(self))
        ->edgesNms(
            CVDEREF(edge_image), CVDEREF(orientation_image), CVDEREF(dst), r, s_, m, isParallel
        );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

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
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::ximgproc::EdgeBoxes>(cv::ximgproc::createEdgeBoxes(
        alpha,
        beta,
        eta,
        minScore,
        maxBoxes,
        edgeMinMag,
        edgeMergeThr,
        clusterMinMag,
        maxAspectRatio,
        minBoxArea,
        gamma,
        kappa
    ));
    END_WRAP
}

void cv_ximgproc_EdgeBoxes_close(EdgeBoxesPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

// Returns the step size of sliding window search.
float cv_ximgproc_EdgeBoxes_getAlpha(EdgeBoxes self) {
    return self.ptr->get()->getAlpha();
}

// Returns the nms threshold for object proposals.
float cv_ximgproc_EdgeBoxes_getBeta(EdgeBoxes self) {
    return self.ptr->get()->getBeta();
}

// Returns the cluster min magnitude.
float cv_ximgproc_EdgeBoxes_getClusterMinMag(EdgeBoxes self) {
    return self.ptr->get()->getClusterMinMag();
}

// Returns the edge merge threshold.
float cv_ximgproc_EdgeBoxes_getEdgeMergeThr(EdgeBoxes self) {
    return self.ptr->get()->getEdgeMergeThr();
}

// Returns the edge min magnitude.
float cv_ximgproc_EdgeBoxes_getEdgeMinMag(EdgeBoxes self) {
    return self.ptr->get()->getEdgeMinMag();
}

// Returns adaptation rate for nms threshold.
float cv_ximgproc_EdgeBoxes_getEta(EdgeBoxes self) {
    return self.ptr->get()->getEta();
}

// Returns the affinity sensitivity.
float cv_ximgproc_EdgeBoxes_getGamma(EdgeBoxes self) {
    return self.ptr->get()->getGamma();
}

// Returns the scale sensitivity.
float cv_ximgproc_EdgeBoxes_getKappa(EdgeBoxes self) {
    return self.ptr->get()->getKappa();
}

// Returns the max aspect ratio of boxes.
float cv_ximgproc_EdgeBoxes_getMaxAspectRatio(EdgeBoxes self) {
    return self.ptr->get()->getMaxAspectRatio();
}

// Returns the max number of boxes to detect.
int cv_ximgproc_EdgeBoxes_getMaxBoxes(EdgeBoxes self) {
    return self.ptr->get()->getMaxBoxes();
}

// Returns the minimum area of boxes.
float cv_ximgproc_EdgeBoxes_getMinBoxArea(EdgeBoxes self) {
    return self.ptr->get()->getMinBoxArea();
}

// Returns the min score of boxes to detect.
float cv_ximgproc_EdgeBoxes_getMinScore(EdgeBoxes self) {
    return self.ptr->get()->getMinScore();
}

// Sets the step size of sliding window search.
void cv_ximgproc_EdgeBoxes_setAlpha(EdgeBoxes self, float value) {
    self.ptr->get()->setAlpha(value);
}

// Sets the nms threshold for object proposals.
void cv_ximgproc_EdgeBoxes_setBeta(EdgeBoxes self, float value) {
    self.ptr->get()->setBeta(value);
}

// Sets the cluster min magnitude.
void cv_ximgproc_EdgeBoxes_setClusterMinMag(EdgeBoxes self, float value) {
    self.ptr->get()->setClusterMinMag(value);
}

// Sets the edge merge threshold.
void cv_ximgproc_EdgeBoxes_setEdgeMergeThr(EdgeBoxes self, float value) {
    self.ptr->get()->setEdgeMergeThr(value);
}

// Sets the edge min magnitude.
void cv_ximgproc_EdgeBoxes_setEdgeMinMag(EdgeBoxes self, float value) {
    self.ptr->get()->setEdgeMinMag(value);
}

// Sets the adaptation rate for nms threshold.
void cv_ximgproc_EdgeBoxes_setEta(EdgeBoxes self, float value) {
    self.ptr->get()->setEta(value);
}

// Sets the affinity sensitivity.
void cv_ximgproc_EdgeBoxes_setGamma(EdgeBoxes self, float value) {
    self.ptr->get()->setGamma(value);
}

// Sets the scale sensitivity.
void cv_ximgproc_EdgeBoxes_setKappa(EdgeBoxes self, float value) {
    self.ptr->get()->setKappa(value);
}

// Sets the max aspect ratio of boxes.
void cv_ximgproc_EdgeBoxes_setMaxAspectRatio(EdgeBoxes self, float value) {
    self.ptr->get()->setMaxAspectRatio(value);
}

// Sets max number of boxes to detect.
void cv_ximgproc_EdgeBoxes_setMaxBoxes(EdgeBoxes self, int value) {
    self.ptr->get()->setMaxBoxes(value);
}

// Sets the minimum area of boxes.
void cv_ximgproc_EdgeBoxes_setMinBoxArea(EdgeBoxes self, float value) {
    self.ptr->get()->setMinBoxArea(value);
}

// Sets the min score of boxes to detect.
void cv_ximgproc_EdgeBoxes_setMinScore(EdgeBoxes self, float value) {
    self.ptr->get()->setMinScore(value);
}

// EdgeBoxes
CvStatus* cv_ximgproc_EdgeBoxes_getBoundingBoxes(
    EdgeBoxes self,
    Mat edge_map,
    Mat orientation_map,
    CVD_OUT VecRect* out_boxes,
    CVD_OUT VecF32* scores,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    (CVDEREF(self))
        ->getBoundingBoxes(CVDEREF(edge_map), CVDEREF(orientation_map), CVDEREF_P(out_boxes), CVDEREF_P(scores));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

// GraphSegmentation
CvStatus* cv_ximgproc_GraphSegmentation_create(
    float sigma, float k, int min_size, GraphSegmentation* rval
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::ximgproc::segmentation::GraphSegmentation>(cv::ximgproc::segmentation::createGraphSegmentation(sigma, k, min_size))};
    END_WRAP
}

void cv_ximgproc_GraphSegmentation_close(GraphSegmentationPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

float cv_ximgproc_GraphSegmentation_getK(GraphSegmentation self) {
    return (CVDEREF(self))->getK();
}

int cv_ximgproc_GraphSegmentation_getMinSize(GraphSegmentation self) {
    return (CVDEREF(self))->getMinSize();
}

double cv_ximgproc_GraphSegmentation_getSigma(GraphSegmentation self) {
    return (CVDEREF(self))->getSigma();
}

CvStatus* cv_ximgproc_GraphSegmentation_processImage(
    GraphSegmentation self, Mat src, CVD_OUT Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->processImage(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_ximgproc_GraphSegmentation_setK(GraphSegmentation self, float val) {
    (CVDEREF(self))->setK(val);
}

void cv_ximgproc_GraphSegmentation_setMinSize(GraphSegmentation self, int val) {
    (CVDEREF(self))->setMinSize(val);
}

void cv_ximgproc_GraphSegmentation_setSigma(GraphSegmentation self, double val) {
    (CVDEREF(self))->setSigma(val);
}

// EdgeDrawing
CvStatus* cv_ximgproc_EdgeDrawing_create(EdgeDrawing* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::ximgproc::EdgeDrawing>(cv::ximgproc::createEdgeDrawing())};
    END_WRAP
}

void cv_ximgproc_EdgeDrawing_close(EdgeDrawingPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_ximgproc_EdgeDrawing_detectEdges(EdgeDrawing self, Mat src, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detectEdges(CVDEREF(src));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_detectEllipses(
    EdgeDrawing self, Mat ellipses, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->detectEllipses(CVDEREF(ellipses));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_detectLines(EdgeDrawing self, Mat lines, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->detectLines(CVDEREF(lines));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_getEdgeImage(EdgeDrawing self, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->getEdgeImage(CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_getGradientImage(
    EdgeDrawing self, Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP(CVDEREF(self))->getGradientImage(CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_getSegmentIndicesOfLines(
    EdgeDrawing self, VecI32* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    std::vector<int32_t> _rval = (CVDEREF(self))->getSegmentIndicesOfLines();
    *rval = {new std::vector<int32_t>(_rval)};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_getSegments(
    EdgeDrawing self, VecVecPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto _rval = (CVDEREF(self))->getSegments();
    rval->ptr->reserve(_rval.size());
    for (auto & i : _rval) {
        rval->ptr->emplace_back(i);
    }
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_setParams(
    EdgeDrawing self, EdgeDrawingParams params, CvCallback_0 callback
) {
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
    (CVDEREF(self))->setParams(_params);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_EdgeDrawing_getParams(
    EdgeDrawing self, EdgeDrawingParams* params, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::EdgeDrawing::Params _params = (CVDEREF(self))->params;
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
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

// Binary morphology on run-length encoded image
CvStatus* cv_ximgproc_rl_createRLEImage(
    const VecPoint3i runs, Mat res, CvSize size, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::rl::createRLEImage(CVDEREF(runs), CVDEREF(res), cv::Size(size.width, size.height));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_rl_dilate(
    Mat rlSrc, Mat rlDest, Mat rlKernel, CvPoint anchor, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::rl::dilate(
        CVDEREF(rlSrc), CVDEREF(rlDest), CVDEREF(rlKernel), cv::Point(anchor.x, anchor.y)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_rl_erode(
    Mat rlSrc, Mat rlDest, Mat rlKernel, bool bBoundaryOn, CvPoint anchor, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::rl::erode(
        CVDEREF(rlSrc),
        CVDEREF(rlDest),
        CVDEREF(rlKernel),
        bBoundaryOn,
        cv::Point(anchor.x, anchor.y)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_rl_getStructuringElement(
    int shape, CvSize ksize, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Mat _rval =
        cv::ximgproc::rl::getStructuringElement(shape, cv::Size(ksize.width, ksize.height));
    rval->ptr = new cv::Mat(_rval);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_ximgproc_rl_isRLMorphologyPossible(Mat rlStructuringElement) {
    BEGIN_WRAP
    return cv::ximgproc::rl::isRLMorphologyPossible(CVDEREF(rlStructuringElement));
    END_WRAP
}

CvStatus* cv_ximgproc_rl_morphologyEx(
    Mat rlSrc,
    Mat rlDest,
    int op,
    Mat rlKernel,
    bool bBoundaryOnForErosion,
    CvPoint anchor,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::rl::morphologyEx(
        CVDEREF(rlSrc),
        CVDEREF(rlDest),
        op,
        CVDEREF(rlKernel),
        bBoundaryOnForErosion,
        cv::Point(anchor.x, anchor.y)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_rl_paint(Mat image, Mat rlSrc, const Scalar value, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::ximgproc::rl::paint(
        CVDEREF(image), CVDEREF(rlSrc), cv::Scalar(value.val1, value.val2, value.val3, value.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ximgproc_rl_threshold(
    Mat src, Mat rlDest, double thresh, int type, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ximgproc::rl::threshold(CVDEREF(src), CVDEREF(rlDest), thresh, type);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
