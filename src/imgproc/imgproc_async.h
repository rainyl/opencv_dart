/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_ASYNC_IMGPROC_H
#define CVD_ASYNC_IMGPROC_H

#include "core/types.h"
#include "imgproc.h"

#ifdef __cplusplus
extern "C" {
#endif

CvStatus *ArcLength_Async(VecPoint curve, bool is_closed, CVD_OUT CvCallback_1 callback);
CvStatus *ApproxPolyDP_Async(VecPoint curve, double epsilon, bool closed, CvCallback_1 callback);
CvStatus *BilateralFilter_Async(Mat src, int d, double sc, double ss, CvCallback_1 callback);
CvStatus *Blur_Async(Mat src, Size ps, CvCallback_1 callback);
CvStatus *BoxFilter_Async(Mat src, int ddepth, Size ps, CvCallback_1 callback);
CvStatus *CvtColor_Async(Mat src, int code, CVD_OUT CvCallback_1 callback);
CvStatus *CalcHist_Async(
    VecMat mats, VecI32 chans, Mat mask, VecI32 sz, VecF32 rng, bool acc, CvCallback_1 callback
);
CvStatus *CalcBackProject_Async(
    VecMat mats, VecI32 chans, Mat backProject, VecF32 rng, double scale, CvCallback_1 callback
);
CvStatus *CompareHist_Async(Mat hist1, Mat hist2, int method, CVD_OUT CvCallback_1 callback);
CvStatus *
ConvexHull_Async(VecPoint points, bool clockwise, bool returnPoints, CvCallback_1 callback);
CvStatus *ConvexityDefects_Async(VecPoint points, Mat hull, CvCallback_1 callback);

CvStatus *SqBoxFilter_Async(Mat src, int ddepth, Size ps, CvCallback_1 callback);
CvStatus *Dilate_Async(Mat src, Mat kernel, CvCallback_1 callback);
CvStatus *DilateWithParams_Async(
    Mat src,
    Mat kernel,
    Point anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_1 callback
);
CvStatus *DistanceTransform_Async(
    Mat src, int distanceType, int maskSize, int labelType, CvCallback_2 callback
);
CvStatus *FloodFill_Async(Mat src, Mat mask, Point seedPoint, Scalar newVal, Scalar loDiff, Scalar upDiff, int flags, CvCallback_2 callback);

CvStatus *EqualizeHist_Async(Mat src, CVD_OUT CvCallback_1 callback);
CvStatus *Erode_Async(Mat src, Mat kernel, CvCallback_1 callback);
CvStatus *ErodeWithParams_Async(
    Mat src,
    Mat kernel,
    Point anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_1 callback
);
CvStatus *MatchTemplate_Async(Mat image, Mat templ, int method, Mat mask, CvCallback_1 callback);
CvStatus *Moments_Async(Mat src, bool binaryImage, CvCallback_1 callback);
CvStatus *PyrDown_Async(Mat src, Size dstsize, int borderType, CvCallback_1 callback);
CvStatus *PyrUp_Async(Mat src, Size dstsize, int borderType, CvCallback_1 callback);
CvStatus *BoundingRect_Async(VecPoint pts, CvCallback_1 callback);
CvStatus *BoxPoints_Async(RotatedRect rect, CvCallback_1 callback);
CvStatus *ContourArea_Async(VecPoint pts, CvCallback_1 callback);
CvStatus *MinAreaRect_Async(VecPoint pts, CvCallback_1 callback);
CvStatus *FitEllipse_Async(VecPoint pts, CvCallback_1 callback);
CvStatus *MinEnclosingCircle_Async(VecPoint pts, CvCallback_2 callback);
CvStatus *FindContours_Async(Mat src, int mode, int method, CvCallback_2 callback);
CvStatus *PointPolygonTest_Async(VecPoint pts, Point2f pt, bool measureDist, CvCallback_1 callback);
CvStatus *
ConnectedComponents_Async(Mat src, int connectivity, int ltype, int ccltype, CvCallback_2 callback);
CvStatus *ConnectedComponentsWithStats_Async(
    Mat src, int connectivity, int ltype, int ccltype, CvCallback_4 callback
);

CvStatus *GaussianBlur_Async(Mat src, Size ps, double sX, double sY, int bt, CvCallback_1 callback);
CvStatus *GetGaussianKernel_Async(int ksize, double sigma, int ktype, CvCallback_1 callback);
CvStatus *Laplacian_Async(
    Mat src,
    int dDepth,
    int kSize,
    double scale,
    double delta,
    int borderType,
    CvCallback_1 callback
);
CvStatus *Scharr_Async(
    Mat src,
    int dDepth,
    int dx,
    int dy,
    double scale,
    double delta,
    int borderType,
    CvCallback_1 callback
);
CvStatus *GetStructuringElement_Async(int shape, Size ksize, Point anchor, CvCallback_1 callback);
CvStatus *MorphologyDefaultBorderValue_Async(CvCallback_1 callback);
CvStatus *MorphologyEx_Async(Mat src, int op, Mat kernel, CvCallback_1 callback);
CvStatus *MorphologyExWithParams_Async(
    Mat src,
    int op,
    Mat kernel,
    Point pt,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_1 callback
);
CvStatus *MedianBlur_Async(Mat src, int ksize, CvCallback_1 callback);

CvStatus *Canny_Async(
    Mat src, double t1, double t2, int apertureSize, bool l2gradient, CvCallback_1 callback
);
CvStatus *CornerSubPix_Async(
    Mat img,
    VecPoint2f corners,
    Size winSize,
    Size zeroZone,
    TermCriteria criteria,
    CvCallback_0 callback
);
CvStatus *GoodFeaturesToTrack_Async(
    Mat img,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    bool useHarrisDetector,
    double k,
    CvCallback_1 callback
);
CvStatus *GoodFeaturesToTrackWithGradient_Async(
    Mat img,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    int gradientSize,
    bool useHarrisDetector,
    double k,
    CvCallback_1 callback
);
CvStatus *GrabCut_Async(
    Mat img,
    Mat mask,
    Rect rect,
    Mat bgdModel,
    Mat fgdModel,
    int iterCount,
    int mode,
    CvCallback_0 callback
);
CvStatus *HoughCircles_Async(Mat src, int method, double dp, double minDist, CvCallback_1 callback);
CvStatus *HoughCirclesWithParams_Async(
    Mat src,
    int method,
    double dp,
    double minDist,
    double param1,
    double param2,
    int minRadius,
    int maxRadius,
    CvCallback_1 callback
);
CvStatus *HoughLines_Async(
    Mat src,
    double rho,
    double theta,
    int threshold,
    double srn,
    double stn,
    double min_theta,
    double max_theta,
    CvCallback_1 callback
);
CvStatus *
HoughLinesP_Async(Mat src, double rho, double theta, int threshold, CvCallback_1 callback);
CvStatus *HoughLinesPWithParams_Async(
    Mat src,
    double rho,
    double theta,
    int threshold,
    double minLineLength,
    double maxLineGap,
    CvCallback_1 callback
);
CvStatus *HoughLinesPointSet_Async(
    Mat points,
    int lines_max,
    int threshold,
    double min_rho,
    double max_rho,
    double rho_step,
    double min_theta,
    double max_theta,
    double theta_step,
    CvCallback_1 callback
);
CvStatus *Integral_Async(Mat src, int sdepth, int sqdepth, CvCallback_3 callback);
CvStatus *Threshold_Async(Mat src, double thresh, double maxvalue, int typ, CvCallback_2 callback);
CvStatus *AdaptiveThreshold_Async(
    Mat src,
    double maxValue,
    int adaptiveTyp,
    int typ,
    int blockSize,
    double c,
    CvCallback_1 callback
);

CvStatus *ArrowedLine_Async(
    Mat img,
    Point pt1,
    Point pt2,
    Scalar color,
    int thickness,
    int line_type,
    int shift,
    double tipLength,
    CvCallback_0 callback
);
CvStatus *
Circle_Async(Mat img, Point center, int radius, Scalar color, int thickness, CvCallback_0 callback);
CvStatus *CircleWithParams_Async(
    Mat img,
    Point center,
    int radius,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);
CvStatus *Ellipse_Async(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    CvCallback_0 callback
);
CvStatus *EllipseWithParams_Async(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);
CvStatus *Line_Async(
    Mat img,
    Point pt1,
    Point pt2,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);
CvStatus *Rectangle_Async(Mat img, Rect rect, Scalar color, int thickness, CvCallback_0 callback);
CvStatus *RectangleWithParams_Async(
    Mat img, Rect rect, Scalar color, int thickness, int lineType, int shift, CvCallback_0 callback
);
CvStatus *FillPoly_Async(Mat img, VecVecPoint points, Scalar color, CvCallback_0 callback);
CvStatus *FillPolyWithParams_Async(
    Mat img,
    VecVecPoint points,
    Scalar color,
    int lineType,
    int shift,
    Point offset,
    CvCallback_0 callback
);
CvStatus *Polylines_Async(
    Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness, CvCallback_0 callback
);
CvStatus *GetTextSizeWithBaseline_Async(
    const char *text, int fontFace, double fontScale, int thickness, CvCallback_2 callback
);
CvStatus *PutText_Async(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    CvCallback_0 callback
);
CvStatus *PutTextWithParams_Async(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    int lineType,
    bool bottomLeftOrigin,
    CvCallback_0 callback
);
CvStatus *Resize_Async(Mat src, Size sz, double fx, double fy, int interp, CvCallback_1 callback);
CvStatus *GetRectSubPix_Async(Mat src, Size patchSize, Point2f center, CvCallback_1 callback);
CvStatus *
GetRotationMatrix2D_Async(Point2f center, double angle, double scale, CvCallback_1 callback);
CvStatus *WarpAffine_Async(Mat src, Mat rot_mat, Size dsize, CvCallback_1 callback);
CvStatus *WarpAffineWithParams_Async(
    Mat src,
    Mat rot_mat,
    Size dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_1 callback
);
CvStatus *WarpPerspective_Async(Mat src, Mat m, Size dsize, CvCallback_1 callback);
CvStatus *WarpPerspectiveWithParams_Async(
    Mat src,
    Mat rot_mat,
    Size dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_1 callback
);
CvStatus *Watershed_Async(Mat image, Mat markers, CvCallback_0 callback);
CvStatus *ApplyColorMap_Async(Mat src, int colormap, CvCallback_1 callback);
CvStatus *ApplyCustomColorMap_Async(Mat src, Mat colormap, CvCallback_1 callback);
CvStatus *
GetPerspectiveTransform_Async(VecPoint src, VecPoint dst, int solveMethod, CvCallback_1 callback);
CvStatus *GetPerspectiveTransform2f_Async(
    VecPoint2f src, VecPoint2f dst, int solveMethod, CvCallback_1 callback
);
CvStatus *GetAffineTransform_Async(VecPoint src, VecPoint dst, CvCallback_1 callback);
CvStatus *GetAffineTransform2f_Async(VecPoint2f src, VecPoint2f dst, CvCallback_1 callback);

CvStatus *DrawContours_Async(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    CvCallback_0 callback
);
CvStatus *DrawContoursWithParams_Async(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    int lineType,
    Mat hierarchy,
    int maxLevel,
    Point offset,
    CvCallback_0 callback
);
CvStatus *Sobel_Async(
    Mat src,
    int ddepth,
    int dx,
    int dy,
    int ksize,
    double scale,
    double delta,
    int borderType,
    CvCallback_1 callback
);
CvStatus *SpatialGradient_Async(Mat src, int ksize, int borderType, CvCallback_2 callback);
CvStatus *Remap_Async(
    Mat src,
    Mat map1,
    Mat map2,
    int interpolation,
    int borderMode,
    Scalar borderValue,
    CvCallback_1 callback
);
CvStatus *Filter2D_Async(
    Mat src,
    int ddepth,
    Mat kernel,
    Point anchor,
    double delta,
    int borderType,
    CvCallback_1 callback
);
CvStatus *SepFilter2D_Async(
    Mat src,
    int ddepth,
    Mat kernelX,
    Mat kernelY,
    Point anchor,
    double delta,
    int borderType,
    CvCallback_1 callback
);
CvStatus *LogPolar_Async(Mat src, Point2f center, double m, int flags, CvCallback_1 callback);
CvStatus *FitLine_Async(
    VecPoint pts, int distType, double param, double reps, double aeps, CvCallback_1 callback
);
CvStatus *
LinearPolar_Async(Mat src, Point2f center, double maxRadius, int flags, CvCallback_1 callback);
CvStatus *MatchShapes_Async(
    VecPoint contour1, VecPoint contour2, int method, double parameter, CvCallback_1 callback
);
CvStatus *ClipLine_Async(Rect imgRect, Point pt1, Point pt2, CvCallback_1 callback);

CvStatus *CLAHE_Create_Async(CvCallback_1 callback);
CvStatus *CLAHE_CreateWithParams_Async(double clipLimit, Size tileGridSize, CvCallback_1 callback);
void CLAHE_Close_Async(CLAHEPtr self, CvCallback_0 callback);
CvStatus *CLAHE_Apply_Async(CLAHE self, Mat src, CvCallback_1 callback);
CvStatus *CLAHE_CollectGarbage_Async(CLAHE self, CvCallback_0 callback);
CvStatus *CLAHE_GetClipLimit_Async(CLAHE self, CvCallback_1 callback);
CvStatus *CLAHE_SetClipLimit_Async(CLAHE self, double clipLimit, CvCallback_0 callback);
CvStatus *CLAHE_GetTilesGridSize_Async(CLAHE self, CvCallback_1 callback);
CvStatus *CLAHE_SetTilesGridSize_Async(CLAHE self, Size size, CvCallback_0 callback);

CvStatus *Subdiv2D_NewEmpty_Async(CvCallback_1 callback);
CvStatus *Subdiv2D_NewWithRect_Async(Rect rect, CvCallback_1 callback);
void Subdiv2D_Close_Async(Subdiv2DPtr self, CvCallback_0 callback);
CvStatus *Subdiv2D_EdgeDst_Async(Subdiv2D self, int edge, CvCallback_2 callback);
CvStatus *Subdiv2D_EdgeOrg_Async(Subdiv2D self, int edge, CvCallback_2 callback);
CvStatus *Subdiv2D_FindNearest_Async(Subdiv2D self, Point2f pt, CvCallback_2 callback);
CvStatus *Subdiv2D_GetEdge_Async(Subdiv2D self, int edge, int nextEdgeType, CvCallback_1 callback);
CvStatus *Subdiv2D_GetEdgeList_Async(Subdiv2D self, CvCallback_1 callback);
CvStatus *Subdiv2D_GetLeadingEdgeList_Async(Subdiv2D self, CvCallback_1 callback);
CvStatus *Subdiv2D_GetTriangleList_Async(Subdiv2D self, CvCallback_1 callback);
CvStatus *Subdiv2D_GetVertex_Async(Subdiv2D self, int vertex, CvCallback_2 callback);
CvStatus *Subdiv2D_GetVoronoiFacetList_Async(Subdiv2D self, VecI32 idx, CvCallback_2 callback);
CvStatus *Subdiv2D_InitDelaunay_Async(Subdiv2D self, Rect rect, CvCallback_0 callback);
CvStatus *Subdiv2D_Insert_Async(Subdiv2D self, Point2f pt, CvCallback_1 callback);
CvStatus *Subdiv2D_InsertVec_Async(Subdiv2D self, VecPoint2f ptvec, CvCallback_0 callback);
CvStatus *Subdiv2D_Locate_Async(Subdiv2D self, Point2f pt, CvCallback_3 callback);
CvStatus *Subdiv2D_NextEdge_Async(Subdiv2D self, int edge, CvCallback_1 callback);
CvStatus *Subdiv2D_RotateEdge_Async(Subdiv2D self, int edge, int rotate, CvCallback_1 callback);
CvStatus *Subdiv2D_SymEdge_Async(Subdiv2D self, int edge, CvCallback_1 callback);

CvStatus *InvertAffineTransform_Async(Mat src, CvCallback_1 callback);
CvStatus *PhaseCorrelate_Async(Mat src1, Mat src2, Mat window, CvCallback_2 callback);

CvStatus *Mat_Accumulate_Async(Mat src, Mat dst, CvCallback_0 callback);
CvStatus *Mat_AccumulateWithMask_Async(Mat src, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus *Mat_AccumulateSquare_Async(Mat src, Mat dst, CvCallback_0 callback);
CvStatus *Mat_AccumulateSquareWithMask_Async(Mat src, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus *Mat_AccumulateProduct_Async(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus *
Mat_AccumulateProductWithMask_Async(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus *Mat_AccumulatedWeighted_Async(Mat src, Mat dst, double alpha, CvCallback_0 callback);
CvStatus *Mat_AccumulatedWeightedWithMask_Async(
    Mat src, Mat dst, double alpha, Mat mask, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif // CVD_ASYNC_IMGPROC_H
