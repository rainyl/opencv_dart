/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef _OPENCV3_IMGPROC_H_
#define _OPENCV3_IMGPROC_H_

#include "core/core.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::CLAHE>, CLAHE);
CVD_TYPEDEF(cv::Subdiv2D, Subdiv2D);
#else
CVD_TYPEDEF(void, CLAHE);
CVD_TYPEDEF(void, Subdiv2D);
#endif

CvStatus *ArcLength(VecPoint curve, bool is_closed, CVD_OUT double *rval);
CvStatus *ApproxPolyDP(VecPoint curve, double epsilon, bool closed, CVD_OUT VecPoint *rval);
CvStatus *CvtColor(Mat src, CVD_OUT Mat dst, int code);
CvStatus *EqualizeHist(Mat src, CVD_OUT Mat dst);
CvStatus *
CalcHist(VecMat mats, VecI32 chans, Mat mask, CVD_OUT Mat hist, VecI32 sz, VecF32 rng, bool acc);
CvStatus *CalcBackProject(
    VecMat mats, VecI32 chans, Mat hist, CVD_OUT Mat *backProject, VecF32 rng, double scale
);
CvStatus *CompareHist(Mat hist1, Mat hist2, int method, CVD_OUT double *rval);
CvStatus *ConvexHull(VecPoint points, CVD_OUT Mat hull, bool clockwise, bool returnPoints);
CvStatus *ConvexityDefects(VecPoint points, Mat hull, Mat result);
CvStatus *BilateralFilter(Mat src, Mat dst, int d, double sc, double ss);
CvStatus *Blur(Mat src, Mat dst, Size ps);
CvStatus *
BoxFilter(Mat src, Mat dst, int ddepth, Size ps, Point anchor, bool normalize, int borderType);
CvStatus *
SqBoxFilter(Mat src, Mat dst, int ddepth, Size ps, Point anchor, bool normalize, int borderType);
CvStatus *Dilate(Mat src, Mat dst, Mat kernel);
CvStatus *DilateWithParams(
    Mat src, Mat dst, Mat kernel, Point anchor, int iterations, int borderType, Scalar borderValue
);
CvStatus *
DistanceTransform(Mat src, Mat dst, Mat labels, int distanceType, int maskSize, int labelType);
CvStatus *Erode(Mat src, Mat dst, Mat kernel);
CvStatus *ErodeWithParams(
    Mat src, Mat dst, Mat kernel, Point anchor, int iterations, int borderType, Scalar borderValue
);
CvStatus *MatchTemplate(Mat image, Mat templ, Mat result, int method, Mat mask);
CvStatus *Moments(Mat src, bool binaryImage, Moment *rval);
CvStatus *PyrDown(Mat src, Mat dst, Size dstsize, int borderType);
CvStatus *PyrUp(Mat src, Mat dst, Size dstsize, int borderType);
CvStatus *BoundingRect(VecPoint pts, Rect *rval);
CvStatus *BoxPoints(RotatedRect rect, VecPoint2f *boxPts);
CvStatus *ContourArea(VecPoint pts, double *rval);
CvStatus *MinAreaRect(VecPoint pts, RotatedRect *rval);
CvStatus *FitEllipse(VecPoint pts, RotatedRect *rval);
CvStatus *MinEnclosingCircle(VecPoint pts, Point2f *center, float *radius);
CvStatus *FindContours(Mat src, Mat hierarchy, int mode, int method, VecVecPoint *rval);
CvStatus *PointPolygonTest(VecPoint pts, Point2f pt, bool measureDist, double *rval);
CvStatus *
ConnectedComponents(Mat src, Mat dst, int connectivity, int ltype, int ccltype, int *rval);
CvStatus *ConnectedComponentsWithStats(
    Mat src,
    Mat labels,
    Mat stats,
    Mat centroids,
    int connectivity,
    int ltype,
    int ccltype,
    int *rval
);

CvStatus *GaussianBlur(Mat src, Mat dst, Size ps, double sX, double sY, int bt);
CvStatus *GetGaussianKernel(int ksize, double sigma, int ktype, Mat *rval);
CvStatus *
Laplacian(Mat src, Mat dst, int dDepth, int kSize, double scale, double delta, int borderType);
CvStatus *
Scharr(Mat src, Mat dst, int dDepth, int dx, int dy, double scale, double delta, int borderType);
CvStatus *GetStructuringElement(int shape, Size ksize, Mat *rval);
CvStatus *MorphologyDefaultBorderValue(Scalar *rval);
CvStatus *MorphologyEx(Mat src, Mat dst, int op, Mat kernel);
CvStatus *MorphologyExWithParams(
    Mat src,
    Mat dst,
    int op,
    Mat kernel,
    Point pt,
    int iterations,
    int borderType,
    Scalar borderValue
);
CvStatus *MedianBlur(Mat src, Mat dst, int ksize);

CvStatus *Canny(Mat src, Mat edges, double t1, double t2, int apertureSize, bool l2gradient);
CvStatus *
CornerSubPix(Mat img, VecPoint2f corners, Size winSize, Size zeroZone, TermCriteria criteria);
CvStatus *GoodFeaturesToTrack(
    Mat img,
    VecPoint2f *corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    bool useHarrisDetector,
    double k
);
CvStatus *GoodFeaturesToTrackWithGradient(
    Mat img,
    VecPoint2f *corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    int gradientSize,
    bool useHarrisDetector,
    double k
);
CvStatus *
GrabCut(Mat img, Mat mask, Rect rect, Mat bgdModel, Mat fgdModel, int iterCount, int mode);
CvStatus *HoughCircles(Mat src, Mat circles, int method, double dp, double minDist);
CvStatus *HoughCirclesWithParams(
    Mat src,
    Mat circles,
    int method,
    double dp,
    double minDist,
    double param1,
    double param2,
    int minRadius,
    int maxRadius
);
CvStatus *HoughLines(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double srn,
    double stn,
    double min_theta,
    double max_theta
);
CvStatus *HoughLinesP(Mat src, Mat lines, double rho, double theta, int threshold);
CvStatus *HoughLinesPWithParams(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double minLineLength,
    double maxLineGap
);
CvStatus *HoughLinesPointSet(
    Mat points,
    Mat lines,
    int lines_max,
    int threshold,
    double min_rho,
    double max_rho,
    double rho_step,
    double min_theta,
    double max_theta,
    double theta_step
);
CvStatus *Integral(Mat src, Mat sum, Mat sqsum, Mat tilted, int sdepth, int sqdepth);
CvStatus *Threshold(Mat src, Mat dst, double thresh, double maxvalue, int typ, double *rval);
CvStatus *AdaptiveThreshold(
    Mat src, Mat dst, double maxValue, int adaptiveTyp, int typ, int blockSize, double c
);

CvStatus *ArrowedLine(
    Mat img,
    Point pt1,
    Point pt2,
    Scalar color,
    int thickness,
    int line_type,
    int shift,
    double tipLength
);
CvStatus *Circle(Mat img, Point center, int radius, Scalar color, int thickness);
CvStatus *CircleWithParams(
    Mat img, Point center, int radius, Scalar color, int thickness, int lineType, int shift
);
CvStatus *Ellipse(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness
);
CvStatus *EllipseWithParams(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    int lineType,
    int shift
);
CvStatus *Line(Mat img, Point pt1, Point pt2, Scalar color, int thickness, int lineType, int shift);
CvStatus *Rectangle(Mat img, Rect rect, Scalar color, int thickness);
CvStatus *
RectangleWithParams(Mat img, Rect rect, Scalar color, int thickness, int lineType, int shift);
CvStatus *FillPoly(Mat img, VecVecPoint points, Scalar color);
CvStatus *FillPolyWithParams(
    Mat img, VecVecPoint points, Scalar color, int lineType, int shift, Point offset
);
CvStatus *Polylines(Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness);
CvStatus *GetTextSizeWithBaseline(
    const char *text, int fontFace, double fontScale, int thickness, int *baseline, Size *rval
);
CvStatus *PutText(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness
);
CvStatus *PutTextWithParams(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    int lineType,
    bool bottomLeftOrigin
);
CvStatus *Resize(Mat src, Mat dst, Size sz, double fx, double fy, int interp);
CvStatus *GetRectSubPix(Mat src, Size patchSize, Point2f center, Mat dst);
CvStatus *GetRotationMatrix2D(Point2f center, double angle, double scale, Mat *rval);
CvStatus *WarpAffine(Mat src, Mat dst, Mat rot_mat, Size dsize);
CvStatus *WarpAffineWithParams(
    Mat src, Mat dst, Mat rot_mat, Size dsize, int flags, int borderMode, Scalar borderValue
);
CvStatus *WarpPerspective(Mat src, Mat dst, Mat m, Size dsize);
CvStatus *WarpPerspectiveWithParams(
    Mat src, Mat dst, Mat rot_mat, Size dsize, int flags, int borderMode, Scalar borderValue
);
CvStatus *Watershed(Mat image, Mat markers);
CvStatus *ApplyColorMap(Mat src, Mat dst, int colormap);
CvStatus *ApplyCustomColorMap(Mat src, Mat dst, Mat colormap);
CvStatus *GetPerspectiveTransform(VecPoint src, VecPoint dst, Mat *rval, int solveMethod);
CvStatus *GetPerspectiveTransform2f(VecPoint2f src, VecPoint2f dst, Mat *rval, int solveMethod);
CvStatus *GetAffineTransform(VecPoint src, VecPoint dst, Mat *rval);
CvStatus *GetAffineTransform2f(VecPoint2f src, VecPoint2f dst, Mat *rval);
CvStatus *FindHomography(
    Mat src,
    Mat dst,
    int method,
    double ransacReprojThreshold,
    Mat mask,
    const int maxIters,
    const double confidence,
    Mat *rval
);
CvStatus *DrawContours(Mat src, VecVecPoint contours, int contourIdx, Scalar color, int thickness);
CvStatus *DrawContoursWithParams(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    int lineType,
    Mat hierarchy,
    int maxLevel,
    Point offset
);
CvStatus *Sobel(
    Mat src,
    Mat dst,
    int ddepth,
    int dx,
    int dy,
    int ksize,
    double scale,
    double delta,
    int borderType
);
CvStatus *SpatialGradient(Mat src, Mat dx, Mat dy, int ksize, int borderType);
CvStatus *
Remap(Mat src, Mat dst, Mat map1, Mat map2, int interpolation, int borderMode, Scalar borderValue);
CvStatus *
Filter2D(Mat src, Mat dst, int ddepth, Mat kernel, Point anchor, double delta, int borderType);
CvStatus *SepFilter2D(
    Mat src,
    Mat dst,
    int ddepth,
    Mat kernelX,
    Mat kernelY,
    Point anchor,
    double delta,
    int borderType
);
CvStatus *LogPolar(Mat src, Mat dst, Point2f center, double m, int flags);
CvStatus *FitLine(VecPoint pts, Mat line, int distType, double param, double reps, double aeps);
CvStatus *LinearPolar(Mat src, Mat dst, Point2f center, double maxRadius, int flags);
CvStatus *
MatchShapes(VecPoint contour1, VecPoint contour2, int method, double parameter, double *rval);
CvStatus *ClipLine(Rect imgRect, Point pt1, Point pt2, bool *rval);

CvStatus *CLAHE_Create(CLAHE *rval);
CvStatus *CLAHE_CreateWithParams(double clipLimit, Size tileGridSize, CLAHE *rval);
void CLAHE_Close(CLAHEPtr c);
CvStatus *CLAHE_Apply(CLAHE c, Mat src, Mat dst);
CvStatus *CLAHE_CollectGarbage(CLAHE c);
CvStatus *CLAHE_GetClipLimit(CLAHE c, double *rval);
CvStatus *CLAHE_SetClipLimit(CLAHE c, double clipLimit);
CvStatus *CLAHE_GetTilesGridSize(CLAHE c, Size *rval);
CvStatus *CLAHE_SetTilesGridSize(CLAHE c, Size size);

CvStatus *Subdiv2D_NewEmpty(Subdiv2D *rval);
CvStatus *Subdiv2D_NewWithRect(Rect rect, Subdiv2D *rval);
void Subdiv2D_Close(Subdiv2DPtr self);
CvStatus *Subdiv2D_EdgeDst(Subdiv2D self, int edge, Point2f *dstpt, int *rval);
CvStatus *Subdiv2D_EdgeOrg(Subdiv2D self, int edge, Point2f *orgpt, int *rval);
CvStatus *Subdiv2D_FindNearest(Subdiv2D self, Point2f pt, Point2f *nearestPt, int *rval);
CvStatus *Subdiv2D_GetEdge(Subdiv2D self, int edge, int nextEdgeType, int *rval);
CvStatus *Subdiv2D_GetEdgeList(Subdiv2D self, Vec4f **rval, int *size);
CvStatus *Subdiv2D_GetLeadingEdgeList(Subdiv2D self, VecI32 *leadingEdgeList);
CvStatus *Subdiv2D_GetTriangleList(Subdiv2D self, Vec6f **rval, int *size);
CvStatus *Subdiv2D_GetVertex(Subdiv2D self, int vertex, int *firstEdge, Point2f *rval);
CvStatus *Subdiv2D_GetVoronoiFacetList(
    Subdiv2D self, VecI32 idx, VecVecPoint2f *facetList, VecPoint2f *facetCenters
);
CvStatus *Subdiv2D_InitDelaunay(Subdiv2D self, Rect rect);
CvStatus *Subdiv2D_Insert(Subdiv2D self, Point2f pt, int *rval);
CvStatus *Subdiv2D_InsertVec(Subdiv2D self, VecPoint2f ptvec);
CvStatus *Subdiv2D_Locate(Subdiv2D self, Point2f pt, int *edge, int *vertex, int *rval);
CvStatus *Subdiv2D_NextEdge(Subdiv2D self, int edge, int *rval);
CvStatus *Subdiv2D_RotateEdge(Subdiv2D self, int edge, int rotate, int *rval);
CvStatus *Subdiv2D_SymEdge(Subdiv2D self, int edge, int *rval);

CvStatus *InvertAffineTransform(Mat src, Mat dst);
CvStatus *PhaseCorrelate(Mat src1, Mat src2, Mat window, double *response, Point2f *rval);

CvStatus *Mat_Accumulate(Mat src, Mat dst);
CvStatus *Mat_AccumulateWithMask(Mat src, Mat dst, Mat mask);
CvStatus *Mat_AccumulateSquare(Mat src, Mat dst);
CvStatus *Mat_AccumulateSquareWithMask(Mat src, Mat dst, Mat mask);
CvStatus *Mat_AccumulateProduct(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_AccumulateProductWithMask(Mat src1, Mat src2, Mat dst, Mat mask);
CvStatus *Mat_AccumulatedWeighted(Mat src, Mat dst, double alpha);
CvStatus *Mat_AccumulatedWeightedWithMask(Mat src, Mat dst, double alpha, Mat mask);
#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_IMGPROC_H_
