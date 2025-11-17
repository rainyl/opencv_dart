/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_IMGPROC_H_
#define CVD_IMGPROC_H_
#pragma warning(disable : 4996)

#include "dartcv/core/types.h"
#include <stdbool.h>

#ifdef __cplusplus
#include <opencv2/imgproc.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::CLAHE>, CLAHE);
CVD_TYPEDEF(cv::Subdiv2D, Subdiv2D);
#else
CVD_TYPEDEF(void, CLAHE);
CVD_TYPEDEF(void, Subdiv2D);
#endif

// SECTION - Image Filtering
// Applies the bilateral filter to an image.
// void cv::bilateralFilter (InputArray src, OutputArray dst, int d, double sigmaColor, double sigmaSpace, int borderType=BORDER_DEFAULT)
CvStatus* cv_bilateralFilter(Mat src, Mat dst, int d, double sc, double ss, CvCallback_0 callback);

// Blurs an image using the normalized box filter.
// void cv::blur (InputArray src, OutputArray dst, CvSize ksize, CvPoint anchor=CvPoint(-1,-1), int borderType=BORDER_DEFAULT)
CvStatus* cv_blur(Mat src, Mat dst, CvSize ps, CvCallback_0 callback);

// Blurs an image using the box filter.
// void cv::boxFilter (InputArray src, OutputArray dst, int ddepth, CvSize ksize, CvPoint anchor=CvPoint(-1,-1), bool normalize=true, int borderType=BORDER_DEFAULT)
CvStatus* cv_boxFilter(
    Mat src,
    Mat dst,
    int ddepth,
    CvSize ps,
    CvPoint anchor,
    bool normalize,
    int borderType,
    CvCallback_0 callback
);

// TODO
// Constructs the Gaussian pyramid for an image.
// void cv::buildPyramid (InputArray src, OutputArrayOfArrays dst, int maxlevel, int borderType=BORDER_DEFAULT)

// Dilates an image by using a specific structuring element.
// void cv::dilate (InputArray src, OutputArray dst, InputArray kernel, CvPoint anchor=CvPoint(-1,-1), int iterations=1, int borderType=BORDER_CONSTANT, const Scalar &borderValue=morphologyDefaultBorderValue())
CvStatus* cv_dilate(Mat src, Mat dst, Mat kernel, CvCallback_0 callback);
CvStatus* cv_dilate_1(
    Mat src,
    Mat dst,
    Mat kernel,
    CvPoint anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_0 callback
);

// Erodes an image by using a specific structuring element.
// void cv::erode (InputArray src, OutputArray dst, InputArray kernel, CvPoint anchor=CvPoint(-1,-1), int iterations=1, int borderType=BORDER_CONSTANT, const Scalar &borderValue=morphologyDefaultBorderValue())
CvStatus* cv_erode(Mat src, Mat dst, Mat kernel, CvCallback_0 callback);
CvStatus* cv_erode_1(
    Mat src,
    Mat dst,
    Mat kernel,
    CvPoint anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_0 callback
);

// Convolves an image with the kernel.
// void cv::filter2D (InputArray src, OutputArray dst, int ddepth, InputArray kernel, CvPoint anchor=CvPoint(-1,-1), double delta=0, int borderType=BORDER_DEFAULT)
CvStatus* cv_filter2D(
    Mat src,
    Mat dst,
    int ddepth,
    Mat kernel,
    CvPoint anchor,
    double delta,
    int borderType,
    CvCallback_0 callback
);

// Blurs an image using a Gaussian filter.
// void cv::cv_GaussianBlur (InputArray src, OutputArray dst, CvSize ksize, double sigmaX, double sigmaY=0, int borderType=BORDER_DEFAULT, AlgorithmHint hint=cv::ALGO_HINT_DEFAULT)
CvStatus* cv_GaussianBlur(
    Mat src, Mat dst, CvSize ps, double sX, double sY, int bt, CvCallback_0 callback
);

// TODO
// Returns filter coefficients for computing spatial image derivatives.
// void cv::getDerivKernels (OutputArray kx, OutputArray ky, int dx, int dy, int ksize, bool normalize=false, int ktype=CV_32F)

// TODO
// Returns Gabor filter coefficients.
// Mat cv::getGaborKernel (CvSize ksize, double sigma, double theta, double lambd, double gamma, double psi=CV_PI *0.5, int ktype=CV_64F)

// Returns Gaussian filter coefficients.
// Mat cv::getGaussianKernel (int ksize, double sigma, int ktype=CV_64F)
CvStatus* cv_getGaussianKernel(
    int ksize, double sigma, int ktype, Mat* rval, CvCallback_0 callback
);

// Returns a structuring element of the specified size and shape for morphological operations.
// Mat cv::getStructuringElement (int shape, CvSize ksize, CvPoint anchor=CvPoint(-1,-1))
CvStatus* cv_getStructuringElement(int shape, CvSize ksize, Mat* rval, CvCallback_0 callback);

// Calculates the cv_Laplacian of an image.
// void cv::cv_Laplacian (InputArray src, OutputArray dst, int ddepth, int ksize=1, double scale=1, double delta=0, int borderType=BORDER_DEFAULT)
CvStatus* cv_Laplacian(
    Mat src,
    Mat dst,
    int dDepth,
    int kSize,
    double scale,
    double delta,
    int borderType,
    CvCallback_0 callback
);

// Blurs an image using the median filter.
// void cv::medianBlur (InputArray src, OutputArray dst, int ksize)
CvStatus* cv_medianBlur(Mat src, Mat dst, int ksize, CvCallback_0 callback);

// returns "magic" border value for erosion and dilation. It is automatically transformed to Scalar::all(-DBL_MAX) for dilation.
// static Scalar cv::morphologyDefaultBorderValue ()
CvStatus* cv_morphologyDefaultBorderValue(Scalar* rval, CvCallback_0 callback);

// Performs advanced morphological transformations.
// void cv::morphologyEx (InputArray src, OutputArray dst, int op, InputArray kernel, CvPoint anchor=CvPoint(-1,-1), int iterations=1, int borderType=BORDER_CONSTANT, const Scalar &borderValue=morphologyDefaultBorderValue())
CvStatus* cv_morphologyEx(Mat src, Mat dst, int op, Mat kernel, CvCallback_0 callback);
CvStatus* cv_morphologyEx_1(
    Mat src,
    Mat dst,
    int op,
    Mat kernel,
    CvPoint pt,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_0 callback
);

// Blurs an image and downsamples it.
// void cv::pyrDown (InputArray src, OutputArray dst, const CvSize &dstsize=CvSize(), int borderType=BORDER_DEFAULT)
CvStatus* cv_pyrDown(Mat src, Mat dst, CvSize dstsize, int borderType, CvCallback_0 callback);

// TODO
// Performs initial step of meanshift segmentation of an image.
// void cv::pyrMeanShiftFiltering (InputArray src, OutputArray dst, double sp, double sr, int maxLevel=1, TermCriteria termcrit=TermCriteria(TermCriteria::MAX_ITER+TermCriteria::EPS, 5, 1))

// Upsamples an image and then blurs it.
// void cv::pyrUp (InputArray src, OutputArray dst, const CvSize &dstsize=CvSize(), int borderType=BORDER_DEFAULT)
CvStatus* cv_pyrUp(Mat src, Mat dst, CvSize dstsize, int borderType, CvCallback_0 callback);

// Calculates the first x- or y- image derivative using cv_Scharr operator.
// void cv::Scharr (InputArray src, OutputArray dst, int ddepth, int dx, int dy, double scale=1, double delta=0, int borderType=BORDER_DEFAULT)
CvStatus* cv_Scharr(
    Mat src,
    Mat dst,
    int dDepth,
    int dx,
    int dy,
    double scale,
    double delta,
    int borderType,
    CvCallback_0 callback
);

// Applies a separable linear filter to an image.
// void cv::sepFilter2D (InputArray src, OutputArray dst, int ddepth, InputArray kernelX, InputArray kernelY, CvPoint anchor=CvPoint(-1,-1), double delta=0, int borderType=BORDER_DEFAULT)
CvStatus* cv_sepFilter2D(
    Mat src,
    Mat dst,
    int ddepth,
    Mat kernelX,
    Mat kernelY,
    CvPoint anchor,
    double delta,
    int borderType,
    CvCallback_0 callback
);

// Calculates the first, second, third, or mixed image derivatives using an extended cv_Sobel operator.
// void cv::Sobel (InputArray src, OutputArray dst, int ddepth, int dx, int dy, int ksize=3, double scale=1, double delta=0, int borderType=BORDER_DEFAULT)
CvStatus* cv_Sobel(
    Mat src,
    Mat dst,
    int ddepth,
    int dx,
    int dy,
    int ksize,
    double scale,
    double delta,
    int borderType,
    CvCallback_0 callback
);

// Calculates the first order image derivative in both x and y using a cv_Sobel operator.
// void cv::spatialGradient (InputArray src, OutputArray dx, OutputArray dy, int ksize=3, int borderType=BORDER_DEFAULT)
CvStatus* cv_spatialGradient(
    Mat src, Mat dx, Mat dy, int ksize, int borderType, CvCallback_0 callback
);

// Calculates the normalized sum of squares of the pixel values overlapping the filter.
// void cv::sqrBoxFilter (InputArray src, OutputArray dst, int ddepth, CvSize ksize, CvPoint anchor=CvPoint(-1, -1), bool normalize=true, int borderType=BORDER_DEFAULT)
CvStatus* cv_sqrBoxFilter(
    Mat src,
    Mat dst,
    int ddepth,
    CvSize ps,
    CvPoint anchor,
    bool normalize,
    int borderType,
    CvCallback_0 callback
);

// TODO
// Blurs an image using the stackBlur.
// void cv::stackBlur (InputArray src, OutputArray dst, CvSize ksize)

// SECTION - Geometric Image Transformations

// TODO
// Converts image transformation maps from one representation to another.
// void cv::convertMaps (InputArray map1, InputArray map2, OutputArray dstmap1, OutputArray dstmap2, int dstmap1type, bool nninterpolation=false)

// Calculates an affine transform from three pairs of the corresponding points.
// Mat cv::getAffineTransform (const CvPoint2f src[], const CvPoint2f dst[])
// Mat cv::getAffineTransform (InputArray src, InputArray dst)
CvStatus* cv_getAffineTransform(VecPoint src, VecPoint dst, Mat* rval, CvCallback_0 callback);
CvStatus* cv_getAffineTransform2f(VecPoint2f src, VecPoint2f dst, Mat* rval, CvCallback_0 callback);

// Calculates a perspective transform from four pairs of the corresponding points.
// Mat cv::getPerspectiveTransform (const CvPoint2f src[], const CvPoint2f dst[], int solveMethod=DECOMP_LU)
// Mat cv::getPerspectiveTransform (InputArray src, InputArray dst, int solveMethod=DECOMP_LU)
CvStatus* cv_getPerspectiveTransform(
    VecPoint src, VecPoint dst, Mat* rval, int solveMethod, CvCallback_0 callback
);
CvStatus* cv_getPerspectiveTransform2f(
    VecPoint2f src, VecPoint2f dst, Mat* rval, int solveMethod, CvCallback_0 callback
);

// Retrieves a pixel rectangle from an image with sub-pixel accuracy.
// void cv::getRectSubPix (InputArray image, CvSize patchSize, CvPoint2f center, OutputArray patch, int patchType=-1)
CvStatus* cv_getRectSubPix(
    Mat src, CvSize patchSize, CvPoint2f center, Mat dst, CvCallback_0 callback
);

// Calculates an affine matrix of 2D rotation.
// Mat cv::getRotationMatrix2D (CvPoint2f center, double angle, double scale)
CvStatus* cv_getRotationMatrix2D(
    CvPoint2f center, double angle, double scale, Mat* rval, CvCallback_0 callback
);

// Inverts an affine transformation.
// void cv::invertAffineTransform (InputArray M, OutputArray iM)
CvStatus* cv_invertAffineTransform(Mat src, Mat dst, CvCallback_0 callback);

// Remaps an image to polar coordinates space.
// void cv::linearPolar (InputArray src, OutputArray dst, CvPoint2f center, double maxRadius, int flags)
CvStatus* cv_linearPolar(
    Mat src, Mat dst, CvPoint2f center, double maxRadius, int flags, CvCallback_0 callback
);

// Remaps an image to semilog-polar coordinates space.
// void cv::logPolar (InputArray src, OutputArray dst, CvPoint2f center, double M, int flags)
CvStatus* cv_logPolar(
    Mat src, Mat dst, CvPoint2f center, double m, int flags, CvCallback_0 callback
);

// Applies a generic geometrical transformation to an image.
// void cv::remap (InputArray src, OutputArray dst, InputArray map1, InputArray map2, int interpolation, int borderMode=BORDER_CONSTANT, const Scalar &borderValue=Scalar())
CvStatus* cv_remap(
    Mat src,
    Mat dst,
    Mat map1,
    Mat map2,
    int interpolation,
    int borderMode,
    Scalar borderValue,
    CvCallback_0 callback
);

// Resizes an image.
// void cv::resize (InputArray src, OutputArray dst, CvSize dsize, double fx=0, double fy=0, int interpolation=INTER_LINEAR)
CvStatus* cv_resize(
    Mat src, Mat dst, CvSize sz, double fx, double fy, int interp, CvCallback_0 callback
);

// Applies an affine transformation to an image.
// void cv::warpAffine (InputArray src, OutputArray dst, InputArray M, CvSize dsize, int flags=INTER_LINEAR, int borderMode=BORDER_CONSTANT, const Scalar &borderValue=Scalar())
CvStatus* cv_warpAffine(Mat src, Mat dst, Mat rot_mat, CvSize dsize, CvCallback_0 callback);
CvStatus* cv_warpAffine_1(
    Mat src,
    Mat dst,
    Mat rot_mat,
    CvSize dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_0 callback
);
// Applies a perspective transformation to an image.
// void cv::warpPerspective (InputArray src, OutputArray dst, InputArray M, CvSize dsize, int flags=INTER_LINEAR, int borderMode=BORDER_CONSTANT, const Scalar &borderValue=Scalar())
CvStatus* cv_warpPerspective(Mat src, Mat dst, Mat m, CvSize dsize, CvCallback_0 callback);
CvStatus* cv_warpPerspective_1(
    Mat src,
    Mat dst,
    Mat rot_mat,
    CvSize dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_0 callback
);

// TODO
// Remaps an image to polar or semilog-polar coordinates space.
// void cv::warpPolar (InputArray src, OutputArray dst, CvSize dsize, CvPoint2f center, double maxRadius, int flags)

// SECTION - Miscellaneous Image Transformations
// Applies an adaptive threshold to an array.
// void cv::adaptiveThreshold (InputArray src, OutputArray dst, double maxValue, int adaptiveMethod, int thresholdType, int blockSize, double C)
CvStatus* cv_adaptiveThreshold(
    Mat src,
    Mat dst,
    double maxValue,
    int adaptiveTyp,
    int typ,
    int blockSize,
    double c,
    CvCallback_0 callback
);

// void cv::blendLinear (InputArray src1, InputArray src2, InputArray weights1, InputArray weights2, OutputArray dst)

// void cv::distanceTransform (InputArray src, OutputArray dst, int distanceType, int maskSize, int dstType=CV_32F)

// Calculates the distance to the closest zero pixel for each pixel of the source image.
// void cv::distanceTransform (InputArray src, OutputArray dst, OutputArray labels, int distanceType, int maskSize, int labelType=DIST_LABEL_CCOMP)
CvStatus* cv_distanceTransform(
    Mat src,
    Mat dst,
    Mat labels,
    int distanceType,
    int maskSize,
    int labelType,
    CvCallback_0 callback
);

// Fills a connected component with the given color.
// int cv::floodFill (InputOutputArray image, InputOutputArray mask, CvPoint seedPoint, Scalar newVal, CvRect *rect=0, Scalar loDiff=Scalar(), Scalar upDiff=Scalar(), int flags=4)
// int cv::floodFill (InputOutputArray image, CvPoint seedPoint, Scalar newVal, CvRect *rect=0, Scalar loDiff=Scalar(), Scalar upDiff=Scalar(), int flags=4)
CvStatus* cv_floodFill(
    Mat src,
    Mat mask,
    CvPoint seedPoint,
    Scalar newVal,
    CvRect* rect,
    Scalar loDiff,
    Scalar upDiff,
    int flags,
    int* rval,
    CvCallback_0 callback
);

// Calculates the integral of an image.
// void cv::integral (InputArray src, OutputArray sum, int sdepth=-1)
// void cv::integral (InputArray src, OutputArray sum, OutputArray sqsum, int sdepth=-1, int sqdepth=-1)
// void cv::integral (InputArray src, OutputArray sum, OutputArray sqsum, OutputArray tilted, int sdepth=-1, int sqdepth=-1)
CvStatus* cv_integral(
    Mat src, Mat sum, Mat sqsum, Mat tilted, int sdepth, int sqdepth, CvCallback_0 callback
);

// Applies a fixed-level threshold to each array element.
// double cv::threshold (InputArray src, OutputArray dst, double thresh, double maxval, int type)
CvStatus* cv_threshold(
    Mat src, Mat dst, double thresh, double maxvalue, int typ, double* rval, CvCallback_0 callback
);

// thresholdWithMask
CvStatus* cv_thresholdWithMask(
    Mat src,
    Mat dst,
    Mat mask,
    double thresh,
    double maxvalue,
    int typ,
    double* rval,
    CvCallback_0 callback
);

// SECTION - Drawing Functions

// Draws an arrow segment pointing from the first point to the second one.
// void cv::arrowedLine (InputOutputArray img, CvPoint pt1, CvPoint pt2, const Scalar &color, int thickness=1, int line_type=8, int shift=0, double tipLength=0.1)
CvStatus* cv_arrowedLine(
    Mat img,
    CvPoint pt1,
    CvPoint pt2,
    Scalar color,
    int thickness,
    int line_type,
    int shift,
    double tipLength,
    CvCallback_0 callback
);

// Draws a circle.
// void cv::circle (InputOutputArray img, CvPoint center, int radius, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus* cv_circle(
    Mat img, CvPoint center, int radius, Scalar color, int thickness, CvCallback_0 callback
);
CvStatus* cv_circle_1(
    Mat img,
    CvPoint center,
    int radius,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);

// Clips the line against the image rectangle.
// bool cv::clipLine (CvRect imgRect, CvPoint &pt1, CvPoint &pt2)
// bool cv::clipLine (CvSize imgSize, CvPoint &pt1, CvPoint &pt2)
// bool cv::clipLine (Size2l imgSize, Point2l &pt1, Point2l &pt2)
CvStatus* cv_clipLine(CvRect imgRect, CvPoint pt1, CvPoint pt2, bool* rval, CvCallback_0 callback);

// Draws contours outlines or filled contours.
// void cv::drawContours (InputOutputArray image, InputArrayOfArrays contours, int contourIdx, const Scalar &color, int thickness=1, int lineType=LINE_8, InputArray hierarchy=noArray(), int maxLevel=INT_MAX, CvPoint offset=CvPoint())
CvStatus* cv_drawContours(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    CvCallback_0 callback
);
CvStatus* cv_drawContours_1(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    int lineType,
    VecVec4i hierarchy,
    int maxLevel,
    CvPoint offset,
    CvCallback_0 callback
);

// Draws a marker on a predefined position in an image.
// void cv::drawMarker (InputOutputArray img, CvPoint position, const Scalar &color, int markerType=MARKER_CROSS, int markerSize=20, int thickness=1, int line_type=8)

// Draws a simple or thick elliptic arc or fills an ellipse sector.
// void cv::ellipse (InputOutputArray img, CvPoint center, CvSize axes, double angle, double startAngle, double endAngle, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
// void cv::ellipse (InputOutputArray img, const RotatedRect &box, const Scalar &color, int thickness=1, int lineType=LINE_8)
CvStatus* cv_ellipse(
    Mat img,
    CvPoint center,
    CvPoint axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    CvCallback_0 callback
);
CvStatus* cv_ellipse_1(
    Mat img,
    CvPoint center,
    CvPoint axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);

// Approximates an elliptic arc with a polyline.
// void cv::ellipse2Poly (CvPoint center, CvSize axes, int angle, int arcStart, int arcEnd, int delta, std::vector< CvPoint > &pts)
// void cv::ellipse2Poly (Point2d center, Size2d axes, int angle, int arcStart, int arcEnd, int delta, std::vector< Point2d > &pts)

// Fills a convex polygon.
// void cv::fillConvexPoly (InputOutputArray img, InputArray points, const Scalar &color, int lineType=LINE_8, int shift=0)
// void cv::fillConvexPoly (InputOutputArray img, const CvPoint *pts, int npts, const Scalar &color, int lineType=LINE_8, int shift=0)

// Fills the area bounded by one or more polygons.
// void cv::fillPoly (InputOutputArray img, const CvPoint **pts, const int *npts, int ncontours, const Scalar &color, int lineType=LINE_8, int shift=0, CvPoint offset=CvPoint())
// void cv::fillPoly (InputOutputArray img, InputArrayOfArrays pts, const Scalar &color, int lineType=LINE_8, int shift=0, CvPoint offset=CvPoint())
CvStatus* cv_fillPoly(Mat img, VecVecPoint points, Scalar color, CvCallback_0 callback);
CvStatus* cv_fillPoly_1(
    Mat img,
    VecVecPoint points,
    Scalar color,
    int lineType,
    int shift,
    CvPoint offset,
    CvCallback_0 callback
);

// Calculates the font-specific size to use to achieve a given height in pixels.
// double cv::getFontScaleFromHeight (const int fontFace, const int pixelHeight, const int thickness=1)

// Calculates the width and height of a text string.
// CvSize cv::getTextSize (const String &text, int fontFace, double fontScale, int thickness, int *baseLine)
CvStatus* cv_getTextSize(
    const char* text,
    int fontFace,
    double fontScale,
    int thickness,
    int* baseline,
    CvSize* rval,
    CvCallback_0 callback
);

// Draws a line segment connecting two points.
// void cv::line (InputOutputArray img, CvPoint pt1, CvPoint pt2, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus* cv_line(
    Mat img,
    CvPoint pt1,
    CvPoint pt2,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);

// Draws several polygonal curves.
// void cv::polylines (InputOutputArray img, const CvPoint *const *pts, const int *npts, int ncontours, bool isClosed, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
// void cv::polylines (InputOutputArray img, InputArrayOfArrays pts, bool isClosed, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus* cv_polylines(
    Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness, CvCallback_0 callback
);

// Draws a text string.
// void cv::putText (InputOutputArray img, const String &text, CvPoint org, int fontFace, double fontScale, Scalar color, int thickness=1, int lineType=LINE_8, bool bottomLeftOrigin=false)
CvStatus* cv_putText(
    Mat img,
    const char* text,
    CvPoint org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    CvCallback_0 callback
);
CvStatus* cv_putText_1(
    Mat img,
    const char* text,
    CvPoint org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    int lineType,
    bool bottomLeftOrigin,
    CvCallback_0 callback
);

// Draws a simple, thick, or filled up-right rectangle.
// void cv::rectangle (InputOutputArray img, CvPoint pt1, CvPoint pt2, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
// void cv::rectangle (InputOutputArray img, CvRect rec, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus* cv_rectangle(Mat img, CvRect rect, Scalar color, int thickness, CvCallback_0 callback);
CvStatus* cv_rectangle_1(
    Mat img,
    CvRect rect,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
);

// SECTION - Color Space Conversions
// Converts an image from one color space to another.
// void cv::cvtColor (InputArray src, OutputArray dst, int code, int dstCn=0, AlgorithmHint hint=cv::ALGO_HINT_DEFAULT)
CvStatus* cv_cvtColor(Mat src, CVD_OUT Mat dst, int code, CvCallback_0 callback);

// Converts an image from one color space to another where the source image is stored in two planes.
// void cv::cvtColorTwoPlane (InputArray src1, InputArray src2, OutputArray dst, int code, AlgorithmHint hint=cv::ALGO_HINT_DEFAULT)

// main function for all demosaicing processes
// void cv::demosaicing (InputArray src, OutputArray dst, int code, int dstCn=0)

// SECTION - ColorMaps in OpenCV
// Applies a user colormap on a given image.
// void cv::applyColorMap (InputArray src, OutputArray dst, InputArray userColor)
CvStatus* cv_applyColorMap_1(Mat src, Mat dst, Mat colormap, CvCallback_0 callback);

// Applies a GNU Octave/MATLAB equivalent colormap on a given image.
// void cv::applyColorMap (InputArray src, OutputArray dst, int colormap)
CvStatus* cv_applyColorMap(Mat src, Mat dst, int colormap, CvCallback_0 callback);

// SECTION - Planar Subdivision
CvStatus* cv_Subdiv2D_create(Subdiv2D* rval);
CvStatus* cv_Subdiv2D_create_1(CvRect rect, Subdiv2D* rval);
void cv_Subdiv2D_close(Subdiv2DPtr self);
CvStatus* cv_Subdiv2D_edgeDst(
    Subdiv2D self, int edge, CvPoint2f* dstpt, int* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_edgeOrg(
    Subdiv2D self, int edge, CvPoint2f* orgpt, int* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_findNearest(
    Subdiv2D self, CvPoint2f pt, CvPoint2f* nearestPt, int* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_getEdge(
    Subdiv2D self, int edge, int nextEdgeType, int* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_getEdgeList(Subdiv2D self, Vec4f** rval, size_t* size, CvCallback_0 callback);
CvStatus* cv_Subdiv2D_getLeadingEdgeList(
    Subdiv2D self, VecI32* leadingEdgeList, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_getTriangleList(
    Subdiv2D self, Vec6f** rval, size_t* size, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_getVertex(
    Subdiv2D self, int vertex, int* firstEdge, CvPoint2f* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_getVoronoiFacetList(
    Subdiv2D self,
    VecI32 idx,
    VecVecPoint2f* facetList,
    VecPoint2f* facetCenters,
    CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_initDelaunay(Subdiv2D self, CvRect rect, CvCallback_0 callback);
CvStatus* cv_Subdiv2D_insert(Subdiv2D self, CvPoint2f pt, int* rval, CvCallback_0 callback);
CvStatus* cv_Subdiv2D_insertVec(Subdiv2D self, VecPoint2f ptvec, CvCallback_0 callback);
CvStatus* cv_Subdiv2D_locate(
    Subdiv2D self, CvPoint2f pt, int* edge, int* vertex, int* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_nextEdge(Subdiv2D self, int edge, int* rval, CvCallback_0 callback);
CvStatus* cv_Subdiv2D_rotateEdge(
    Subdiv2D self, int edge, int rotate, int* rval, CvCallback_0 callback
);
CvStatus* cv_Subdiv2D_symEdge(Subdiv2D self, int edge, int* rval, CvCallback_0 callback);

// SECTION - Histograms
// Calculates the back projection of a histogram.
// void cv::calcBackProject (const Mat *images, int nimages, const int *channels, const SparseMat &hist, OutputArray backProject, const float **ranges, double scale=1, bool uniform=true)
// void cv::calcBackProject (const Mat *images, int nimages, const int *channels, InputArray hist, OutputArray backProject, const float **ranges, double scale=1, bool uniform=true)
// void cv::calcBackProject (InputArrayOfArrays images, const std::vector< int > &channels, InputArray hist, OutputArray dst, const std::vector< float > &ranges, double scale)
CvStatus* cv_calcBackProject(
    VecMat mats,
    VecI32 chans,
    Mat hist,
    CVD_OUT Mat backProject,
    VecF32 rng,
    double scale,
    CvCallback_0 callback
);

// Calculates a histogram of a set of arrays.
// void cv::calcHist (const Mat *images, int nimages, const int *channels, InputArray mask, OutputArray hist, int dims, const int *histSize, const float **ranges, bool uniform=true, bool accumulate=false)
// void cv::calcHist (const Mat *images, int nimages, const int *channels, InputArray mask, SparseMat &hist, int dims, const int *histSize, const float **ranges, bool uniform=true, bool accumulate=false)
// void cv::calcHist (InputArrayOfArrays images, const std::vector< int > &channels, InputArray mask, OutputArray hist, const std::vector< int > &histSize, const std::vector< float > &ranges, bool accumulate=false)
CvStatus* cv_calcHist(
    VecMat mats,
    VecI32 chans,
    Mat mask,
    CVD_OUT Mat hist,
    VecI32 sz,
    VecF32 rng,
    bool acc,
    CvCallback_0 callback
);

// Compares two histograms.
// double cv::compareHist (const SparseMat &H1, const SparseMat &H2, int method)
// double cv::compareHist (InputArray H1, InputArray H2, int method)
CvStatus* cv_compareHist(
    Mat hist1, Mat hist2, int method, CVD_OUT double* rval, CvCallback_0 callback
);

// Creates a smart pointer to a cv::CLAHE class and initializes it.
// Ptr< CLAHE > cv::createCLAHE (double clipLimit=40.0, CvSize tileGridSize=CvSize(8, 8))

CvStatus* cv_CLAHE_create(CLAHE* rval);
CvStatus* cv_CLAHE_create_1(double clipLimit, CvSize tileGridSize, CLAHE* rval);
void cv_CLAHE_close(CLAHEPtr self);
CvStatus* cv_CLAHE_apply(CLAHE self, Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_CLAHE_collectGarbage(CLAHE self, CvCallback_0 callback);
double cv_CLAHE_getClipLimit(CLAHE self);
void cv_CLAHE_setClipLimit(CLAHE self, double clipLimit);
CvSize* cv_CLAHE_getTilesGridSize(CLAHE self);
void cv_CLAHE_setTilesGridSize(CLAHE self, CvSize size);

// Computes the "minimal work" distance between two weighted point configurations.
// float cv::EMD (InputArray signature1, InputArray signature2, int distType, InputArray cost=noArray(), float *lowerBound=0, OutputArray flow=noArray())

// Equalizes the histogram of a grayscale image.
// void cv::equalizeHist (InputArray src, OutputArray dst)
CvStatus* cv_equalizeHist(Mat src, CVD_OUT Mat dst, CvCallback_0 callback);

// float cv::wrapperEMD (InputArray signature1, InputArray signature2, int distType, InputArray cost=noArray(), Ptr< float > lowerBound=Ptr< float >(), OutputArray flow=noArray())

// SECTION - Structural Analysis and Shape Descriptors
// Approximates a polygonal curve(s) with the specified precision.
// void cv::approxPolyDP (InputArray curve, OutputArray approxCurve, double epsilon, bool closed)
CvStatus* cv_approxPolyDP(
    VecPoint curve, double epsilon, bool closed, CVD_OUT VecPoint* rval, CvCallback_0 callback
);

CvStatus* cv_approxPolyDP2f(
    VecPoint2f curve, double epsilon, bool closed, CVD_OUT VecPoint2f* rval, CvCallback_0 callback
);

// Approximates a polygon with a convex hull with a specified accuracy and number of sides.
// void cv::approxPolyN (InputArray curve, OutputArray approxCurve, int nsides, float epsilon_percentage=-1.0, bool ensure_convex=true)
CvStatus* cv_approxPolyN(
    VecPoint curve,
    int nsides,
    float epsilon_percentage,
    bool ensure_convex,
    VecPoint* rval,
    CvCallback_0 callback
);

CvStatus* cv_approxPolyN2f(
    VecPoint2f curve,
    int nsides,
    float epsilon_percentage,
    bool ensure_convex,
    VecPoint2f* rval,
    CvCallback_0 callback
);

// Calculates a contour perimeter or a curve length.
// double cv::arcLength (InputArray curve, bool closed)
CvStatus* cv_arcLength(VecPoint curve, bool is_closed, CVD_OUT double* rval, CvCallback_0 callback);

CvStatus* cv_arcLength2f(
    VecPoint2f curve, bool is_closed, CVD_OUT double* rval, CvCallback_0 callback
);

// Calculates the up-right bounding rectangle of a point set or non-zero pixels of gray-scale image.
// CvRect cv::boundingRect (InputArray array)
CvStatus* cv_boundingRect(VecPoint pts, CvRect* rval, CvCallback_0 callback);

CvStatus* cv_boundingRect2f(VecPoint2f pts, CvRect* rval, CvCallback_0 callback);

// Finds the four vertices of a rotated rect. Useful to draw the rotated rectangle.
// void cv::boxPoints (RotatedRect box, OutputArray points)
CvStatus* cv_boxPoints(RotatedRect rect, VecPoint2f* boxPts, CvCallback_0 callback);

// computes the connected components labeled image of boolean image
// int cv::connectedComponents (InputArray image, OutputArray labels, int connectivity, int ltype, int ccltype)
// int cv::connectedComponents (InputArray image, OutputArray labels, int connectivity=8, int ltype=CV_32S)
CvStatus* cv_connectedComponents(
    Mat src, Mat dst, int connectivity, int ltype, int ccltype, int* rval, CvCallback_0 callback
);

// computes the connected components labeled image of boolean image and also produces a statistics output for each label
// int cv::connectedComponentsWithStats (InputArray image, OutputArray labels, OutputArray stats, OutputArray centroids, int connectivity, int ltype, int ccltype)
// int cv::connectedComponentsWithStats (InputArray image, OutputArray labels, OutputArray stats, OutputArray centroids, int connectivity=8, int ltype=CV_32S)
CvStatus* cv_connectedComponents_1(
    Mat src,
    Mat labels,
    Mat stats,
    Mat centroids,
    int connectivity,
    int ltype,
    int ccltype,
    int* rval,
    CvCallback_0 callback
);

// Calculates a contour area.
// double cv::contourArea (InputArray contour, bool oriented=false)
CvStatus* cv_contourArea(VecPoint pts, double* rval, CvCallback_0 callback);
CvStatus* cv_contourArea2f(VecPoint2f pts, double* rval, CvCallback_0 callback);

// Finds the convex hull of a point set.
// void cv::convexHull (InputArray points, OutputArray hull, bool clockwise=false, bool returnPoints=true)
CvStatus* cv_convexHull(
    VecPoint points, CVD_OUT Mat hull, bool clockwise, bool returnPoints, CvCallback_0 callback
);
CvStatus* cv_convexHull2f(
    VecPoint2f points, CVD_OUT Mat hull, bool clockwise, bool returnPoints, CvCallback_0 callback
);

// Finds the convexity defects of a contour.
// void cv::convexityDefects (InputArray contour, InputArray convexhull, OutputArray convexityDefects)
CvStatus* cv_convexityDefects(VecPoint points, Mat hull, Mat result, CvCallback_0 callback);
CvStatus* cv_convexityDefects2f(VecPoint2f points, Mat hull, Mat result, CvCallback_0 callback);

// Creates a smart pointer to a cv::GeneralizedHoughBallard class and initializes it.
// Ptr< GeneralizedHoughBallard > cv::createGeneralizedHoughBallard ()

// Creates a smart pointer to a cv::GeneralizedHoughGuil class and initializes it.
// Ptr< GeneralizedHoughGuil > cv::createGeneralizedHoughGuil ()

// Finds contours in a binary image.
// void cv::findContours (InputArray image, OutputArrayOfArrays contours, int mode, int method, CvPoint offset=CvPoint())
// void cv::findContours (InputArray image, OutputArrayOfArrays contours, OutputArray hierarchy, int mode, int method, CvPoint offset=CvPoint())
CvStatus* cv_findContours(
    Mat src,
    VecVecPoint* out_contours,
    VecVec4i* out_hierarchy,
    int mode,
    int method,
    CvCallback_0 callback
);
CvStatus* cv_findContours2f(
    Mat src,
    VecVecPoint2f* out_contours,
    VecVec4i* out_hierarchy,
    int mode,
    int method,
    CvCallback_0 callback
);

// Find contours using link runs algorithm.
// void cv::findContoursLinkRuns (InputArray image, OutputArrayOfArrays contours)
// void cv::findContoursLinkRuns (InputArray image, OutputArrayOfArrays contours, OutputArray hierarchy)

// Fits an ellipse around a set of 2D points.
// RotatedRect cv::fitEllipse (InputArray points)
CvStatus* cv_fitEllipse(VecPoint pts, RotatedRect* rval, CvCallback_0 callback);
CvStatus* cv_fitEllipse2f(VecPoint2f pts, RotatedRect* rval, CvCallback_0 callback);

// Fits an ellipse around a set of 2D points.
// RotatedRect cv::fitEllipseAMS (InputArray points)

// Fits an ellipse around a set of 2D points.
// RotatedRect cv::fitEllipseDirect (InputArray points)

// Fits a line to a 2D or 3D point set.
// void cv::fitLine (InputArray points, OutputArray line, int distType, double param, double reps, double aeps)
CvStatus* cv_fitLine(
    VecPoint pts,
    Mat line,
    int distType,
    double param,
    double reps,
    double aeps,
    CvCallback_0 callback
);

CvStatus* cv_fitLine2f(
    VecPoint2f pts,
    Mat line,
    int distType,
    double param,
    double reps,
    double aeps,
    CvCallback_0 callback
);

CvStatus* cv_getClosestEllipsePoints(RotatedRect ellipse_params, Mat points, MatOut closest_pts);

// Calculates seven Hu invariants.
// void cv::HuMoments (const cv_moments &m, OutputArray hu)
// void cv::HuMoments (const cv_moments &moments, double hu[7])

// Finds intersection of two convex polygons.
// float cv::intersectConvexConvex (InputArray p1, InputArray p2, OutputArray p12, bool handleNested=true)
CvStatus* cv_intersectConvexConvex(
    VecPoint p1, VecPoint p2, VecPoint* p12, bool handleNested, float* rval, CvCallback_0 callback
);

// Tests a contour convexity.
// bool cv::isContourConvex (InputArray contour)
bool cv_isContourConvex(VecPoint contour);
bool cv_isContourConvex2f(VecPoint2f contour);

// Compares two shapes.
// double cv::matchShapes (InputArray contour1, InputArray contour2, int method, double parameter)
CvStatus* cv_matchShapes(
    VecPoint contour1,
    VecPoint contour2,
    int method,
    double parameter,
    double* rval,
    CvCallback_0 callback
);

// Finds a rotated rectangle of the minimum area enclosing the input 2D point set.
// RotatedRect cv::minAreaRect (InputArray points)
CvStatus* cv_minAreaRect(VecPoint pts, RotatedRect* rval, CvCallback_0 callback);
CvStatus* cv_minAreaRect2f(VecPoint2f pts, RotatedRect* rval, CvCallback_0 callback);

// Finds a circle of the minimum area enclosing a 2D point set.
// void cv::minEnclosingCircle (InputArray points, CvPoint2f &center, float &radius)
CvStatus* cv_minEnclosingCircle(
    VecPoint pts, CvPoint2f* center, float* radius, CvCallback_0 callback
);

CvStatus* cv_minEnclosingCircle2f(
    VecPoint2f pts, CvPoint2f* center, float* radius, CvCallback_0 callback
);

// Finds a triangle of minimum area enclosing a 2D point set and returns its area.
// double cv::minEnclosingTriangle (InputArray points, OutputArray triangle)

// Calculates all of the moments up to the third order of a polygon or rasterized shape.
// cv_moments cv::moments (InputArray array, bool binaryImage=false)
CvStatus* cv_moments(Mat src, bool binaryImage, Moment* rval, CvCallback_0 callback);

// Performs a point-in-contour test.
// double cv::pointPolygonTest (InputArray contour, CvPoint2f pt, bool measureDist)
CvStatus* cv_pointPolygonTest(
    VecPoint pts, CvPoint2f pt, bool measureDist, double* rval, CvCallback_0 callback
);
CvStatus* cv_pointPolygonTest2f(
    VecPoint2f pts, CvPoint2f pt, bool measureDist, double* rval, CvCallback_0 callback
);
// Finds out if there is any intersection between two rotated rectangles.
// int cv::rotatedRectangleIntersection (const RotatedRect &rect1, const RotatedRect &rect2, OutputArray intersectingRegion)

// SECTION - Motion Analysis and Object Tracking
// Adds an image to the accumulator image.
// void cv::accumulate (InputArray src, InputOutputArray dst, InputArray mask=noArray())
CvStatus* cv_accumulate(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_accumulate_1(Mat src, Mat dst, Mat mask, CvCallback_0 callback);

// Adds the per-element product of two input images to the accumulator image.
// void cv::accumulateProduct (InputArray src1, InputArray src2, InputOutputArray dst, InputArray mask=noArray())
CvStatus* cv_accumulateProduct(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_accumulateProduct_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback);

// Adds the square of a source image to the accumulator image.
// void cv::accumulateSquare (InputArray src, InputOutputArray dst, InputArray mask=noArray())
CvStatus* cv_accumulateSquare(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_accumulateSquare_1(Mat src, Mat dst, Mat mask, CvCallback_0 callback);

// Updates a running average.
// void cv::accumulateWeighted (InputArray src, InputOutputArray dst, double alpha, InputArray mask=noArray())
CvStatus* cv_accumulatedWeighted(Mat src, Mat dst, double alpha, CvCallback_0 callback);
CvStatus* cv_accumulatedWeighted_1(Mat src, Mat dst, double alpha, Mat mask, CvCallback_0 callback);

// This function computes a Hanning window coefficients in two dimensions.
// void cv::createHanningWindow (OutputArray dst, CvSize winSize, int type)

// Performs the per-element division of the first Fourier spectrum by the second Fourier spectrum.
// void cv::divSpectrums (InputArray a, InputArray b, OutputArray c, int flags, bool conjB=false)

// The function is used to detect translational shifts that occur between two images.
// Point2d cv::phaseCorrelate (InputArray src1, InputArray src2, InputArray window=noArray(), double *response=0)
CvStatus* cv_phaseCorrelate(
    Mat src1, Mat src2, Mat window, double* response, CvPoint2f* rval, CvCallback_0 callback
);

// SECTION - Feature Detection
// Finds edges in an image using the cv_canny algorithm [48] .
// void cv::canny (InputArray dx, InputArray dy, OutputArray edges, double threshold1, double threshold2, bool L2gradient=false)
// void cv::canny (InputArray image, OutputArray edges, double threshold1, double threshold2, int apertureSize=3, bool L2gradient=false)
CvStatus* cv_canny(
    Mat src,
    Mat edges,
    double t1,
    double t2,
    int apertureSize,
    bool l2gradient,
    CvCallback_0 callback
);

// Calculates eigenvalues and eigenvectors of image blocks for corner detection.
// void cv::cornerEigenValsAndVecs (InputArray src, OutputArray dst, int blockSize, int ksize, int borderType=BORDER_DEFAULT)

// Harris corner detector.
// void cv::cornerHarris (InputArray src, OutputArray dst, int blockSize, int ksize, double k, int borderType=BORDER_DEFAULT)

// Calculates the minimal eigenvalue of gradient matrices for corner detection.
// void cv::cornerMinEigenVal (InputArray src, OutputArray dst, int blockSize, int ksize=3, int borderType=BORDER_DEFAULT)

// Refines the corner locations.
// void cv::cornerSubPix (InputArray image, InputOutputArray corners, CvSize winSize, CvSize zeroZone, TermCriteria criteria)
CvStatus* cv_cornerSubPix(
    Mat img,
    VecPoint2f corners,
    CvSize winSize,
    CvSize zeroZone,
    TermCriteria criteria,
    CvCallback_0 callback
);

// Creates a smart pointer to a LineSegmentDetector object and initializes it.
// Ptr< LineSegmentDetector > cv::createLineSegmentDetector (int refine=LSD_REFINE_STD, double scale=0.8, double sigma_scale=0.6, double quant=2.0, double ang_th=22.5, double log_eps=0, double density_th=0.7, int n_bins=1024)

// Determines strong corners on an image.
// Same as above, but returns also quality measure of the detected corners.
// void cv::goodFeaturesToTrack (InputArray image, OutputArray corners, int maxCorners, double qualityLevel, double minDistance, InputArray mask, int blockSize, int gradientSize, bool useHarrisDetector=false, double k=0.04)
// void cv::goodFeaturesToTrack (InputArray image, OutputArray corners, int maxCorners, double qualityLevel, double minDistance, InputArray mask, OutputArray cornersQuality, int blockSize=3, int gradientSize=3, bool useHarrisDetector=false, double k=0.04)
// void cv::goodFeaturesToTrack (InputArray image, OutputArray corners, int maxCorners, double qualityLevel, double minDistance, InputArray mask=noArray(), int blockSize=3, bool useHarrisDetector=false, double k=0.04)
CvStatus* cv_goodFeaturesToTrack(
    Mat img,
    VecPoint2f* corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    bool useHarrisDetector,
    double k,
    CvCallback_0 callback
);
CvStatus* cv_goodFeaturesToTrack_1(
    Mat img,
    VecPoint2f* corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    int gradientSize,
    bool useHarrisDetector,
    double k,
    CvCallback_0 callback
);

// Finds circles in a grayscale image using the Hough transform.
// void cv::HoughCircles (InputArray image, OutputArray circles, int method, double dp, double minDist, double param1=100, double param2=100, int minRadius=0, int maxRadius=0)
CvStatus* cv_HoughCircles(
    Mat src, Mat circles, int method, double dp, double minDist, CvCallback_0 callback
);
CvStatus* cv_HoughCircles_1(
    Mat src,
    Mat circles,
    int method,
    double dp,
    double minDist,
    double param1,
    double param2,
    int minRadius,
    int maxRadius,
    CvCallback_0 callback
);

// Finds lines in a binary image using the standard Hough transform.
// void cv::HoughLines (InputArray image, OutputArray lines, double rho, double theta, int threshold, double srn=0, double stn=0, double min_theta=0, double max_theta=CV_PI)
CvStatus* cv_HoughLines(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double srn,
    double stn,
    double min_theta,
    double max_theta,
    CvCallback_0 callback
);

// Finds line segments in a binary image using the probabilistic Hough transform.
// void cv::HoughLinesP (InputArray image, OutputArray lines, double rho, double theta, int threshold, double minLineLength=0, double maxLineGap=0)
CvStatus* cv_HoughLinesP(
    Mat src, Mat lines, double rho, double theta, int threshold, CvCallback_0 callback
);
CvStatus* cv_HoughLinesP_1(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double minLineLength,
    double maxLineGap,
    CvCallback_0 callback
);

// Finds lines in a set of points using the standard Hough transform.
// void cv::HoughLinesPointSet (InputArray point, OutputArray lines, int lines_max, int threshold, double min_rho, double max_rho, double rho_step, double min_theta, double max_theta, double theta_step)
CvStatus* cv_HoughLinesPointSet(
    Mat points,
    Mat lines,
    int lines_max,
    int threshold,
    double min_rho,
    double max_rho,
    double rho_step,
    double min_theta,
    double max_theta,
    double theta_step,
    CvCallback_0 callback
);

// Calculates a feature map for corner detection.
// void cv::preCornerDetect (InputArray src, OutputArray dst, int ksize, int borderType=BORDER_DEFAULT)

// SECTION - Object Detection
// Compares a template against overlapped image regions.
// void cv::matchTemplate (InputArray image, InputArray templ, OutputArray result, int method, InputArray mask=noArray())
CvStatus* cv_matchTemplate(
    Mat image, Mat templ, Mat result, int method, Mat mask, CvCallback_0 callback
);

// SECTION - Image Segmentation
// Runs the grabCut algorithm.
// void cv::grabCut (InputArray img, InputOutputArray mask, CvRect rect, InputOutputArray bgdModel, InputOutputArray fgdModel, int iterCount, int mode=GC_EVAL)
CvStatus* cv_grabCut(
    Mat img,
    Mat mask,
    CvRect rect,
    Mat bgdModel,
    Mat fgdModel,
    int iterCount,
    int mode,
    CvCallback_0 callback
);

// Performs a marker-based image segmentation using the watershed algorithm.
// void cv::watershed (InputArray image, InputOutputArray markers)
CvStatus* cv_watershed(Mat image, Mat markers, CvCallback_0 callback);

// SECTION - Hardware Acceleration Layer

CvStatus* cv_stackBlur(Mat src, MatOut dst, CvSize ksize, CvCallback_0 callback);

#ifdef __cplusplus
}
#endif

#endif  //CVD_IMGPROC_H_
