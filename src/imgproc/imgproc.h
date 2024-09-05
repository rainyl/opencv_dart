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

// SECTION - Image Filtering
// Applies the bilateral filter to an image.
// void cv::bilateralFilter (InputArray src, OutputArray dst, int d, double sigmaColor, double sigmaSpace, int borderType=BORDER_DEFAULT)
CvStatus *BilateralFilter(Mat src, Mat dst, int d, double sc, double ss);

// Blurs an image using the normalized box filter.
// void cv::blur (InputArray src, OutputArray dst, Size ksize, Point anchor=Point(-1,-1), int borderType=BORDER_DEFAULT)
CvStatus *Blur(Mat src, Mat dst, Size ps);

// Blurs an image using the box filter.
// void cv::boxFilter (InputArray src, OutputArray dst, int ddepth, Size ksize, Point anchor=Point(-1,-1), bool normalize=true, int borderType=BORDER_DEFAULT)
CvStatus *
BoxFilter(Mat src, Mat dst, int ddepth, Size ps, Point anchor, bool normalize, int borderType);

// TODO
// Constructs the Gaussian pyramid for an image.
// void cv::buildPyramid (InputArray src, OutputArrayOfArrays dst, int maxlevel, int borderType=BORDER_DEFAULT)

// Dilates an image by using a specific structuring element.
// void cv::dilate (InputArray src, OutputArray dst, InputArray kernel, Point anchor=Point(-1,-1), int iterations=1, int borderType=BORDER_CONSTANT, const Scalar &borderValue=morphologyDefaultBorderValue())
CvStatus *Dilate(Mat src, Mat dst, Mat kernel);
CvStatus *DilateWithParams(
    Mat src, Mat dst, Mat kernel, Point anchor, int iterations, int borderType, Scalar borderValue
);

// Erodes an image by using a specific structuring element.
// void cv::erode (InputArray src, OutputArray dst, InputArray kernel, Point anchor=Point(-1,-1), int iterations=1, int borderType=BORDER_CONSTANT, const Scalar &borderValue=morphologyDefaultBorderValue())
CvStatus *Erode(Mat src, Mat dst, Mat kernel);
CvStatus *ErodeWithParams(
    Mat src, Mat dst, Mat kernel, Point anchor, int iterations, int borderType, Scalar borderValue
);

// Convolves an image with the kernel.
// void cv::filter2D (InputArray src, OutputArray dst, int ddepth, InputArray kernel, Point anchor=Point(-1,-1), double delta=0, int borderType=BORDER_DEFAULT)
CvStatus *
Filter2D(Mat src, Mat dst, int ddepth, Mat kernel, Point anchor, double delta, int borderType);

// Blurs an image using a Gaussian filter.
// void cv::GaussianBlur (InputArray src, OutputArray dst, Size ksize, double sigmaX, double sigmaY=0, int borderType=BORDER_DEFAULT, AlgorithmHint hint=cv::ALGO_HINT_DEFAULT)
CvStatus *GaussianBlur(Mat src, Mat dst, Size ps, double sX, double sY, int bt);

// TODO
// Returns filter coefficients for computing spatial image derivatives.
// void cv::getDerivKernels (OutputArray kx, OutputArray ky, int dx, int dy, int ksize, bool normalize=false, int ktype=CV_32F)

// TODO
// Returns Gabor filter coefficients.
// Mat cv::getGaborKernel (Size ksize, double sigma, double theta, double lambd, double gamma, double psi=CV_PI *0.5, int ktype=CV_64F)

// Returns Gaussian filter coefficients.
// Mat cv::getGaussianKernel (int ksize, double sigma, int ktype=CV_64F)
CvStatus *GetGaussianKernel(int ksize, double sigma, int ktype, Mat *rval);

// Returns a structuring element of the specified size and shape for morphological operations.
// Mat cv::getStructuringElement (int shape, Size ksize, Point anchor=Point(-1,-1))
CvStatus *GetStructuringElement(int shape, Size ksize, Mat *rval);

// Calculates the Laplacian of an image.
// void cv::Laplacian (InputArray src, OutputArray dst, int ddepth, int ksize=1, double scale=1, double delta=0, int borderType=BORDER_DEFAULT)
CvStatus *
Laplacian(Mat src, Mat dst, int dDepth, int kSize, double scale, double delta, int borderType);

// Blurs an image using the median filter.
// void cv::medianBlur (InputArray src, OutputArray dst, int ksize)
CvStatus *MedianBlur(Mat src, Mat dst, int ksize);

// returns "magic" border value for erosion and dilation. It is automatically transformed to Scalar::all(-DBL_MAX) for dilation.
// static Scalar cv::morphologyDefaultBorderValue ()
CvStatus *MorphologyDefaultBorderValue(Scalar *rval);

// Performs advanced morphological transformations.
// void cv::morphologyEx (InputArray src, OutputArray dst, int op, InputArray kernel, Point anchor=Point(-1,-1), int iterations=1, int borderType=BORDER_CONSTANT, const Scalar &borderValue=morphologyDefaultBorderValue())
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

// Blurs an image and downsamples it.
// void cv::pyrDown (InputArray src, OutputArray dst, const Size &dstsize=Size(), int borderType=BORDER_DEFAULT)
CvStatus *PyrDown(Mat src, Mat dst, Size dstsize, int borderType);

// TODO
// Performs initial step of meanshift segmentation of an image.
// void cv::pyrMeanShiftFiltering (InputArray src, OutputArray dst, double sp, double sr, int maxLevel=1, TermCriteria termcrit=TermCriteria(TermCriteria::MAX_ITER+TermCriteria::EPS, 5, 1))

// Upsamples an image and then blurs it.
// void cv::pyrUp (InputArray src, OutputArray dst, const Size &dstsize=Size(), int borderType=BORDER_DEFAULT)
CvStatus *PyrUp(Mat src, Mat dst, Size dstsize, int borderType);

// Calculates the first x- or y- image derivative using Scharr operator.
// void cv::Scharr (InputArray src, OutputArray dst, int ddepth, int dx, int dy, double scale=1, double delta=0, int borderType=BORDER_DEFAULT)
CvStatus *
Scharr(Mat src, Mat dst, int dDepth, int dx, int dy, double scale, double delta, int borderType);

// Applies a separable linear filter to an image.
// void cv::sepFilter2D (InputArray src, OutputArray dst, int ddepth, InputArray kernelX, InputArray kernelY, Point anchor=Point(-1,-1), double delta=0, int borderType=BORDER_DEFAULT)
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

// Calculates the first, second, third, or mixed image derivatives using an extended Sobel operator.
// void cv::Sobel (InputArray src, OutputArray dst, int ddepth, int dx, int dy, int ksize=3, double scale=1, double delta=0, int borderType=BORDER_DEFAULT)
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

// Calculates the first order image derivative in both x and y using a Sobel operator.
// void cv::spatialGradient (InputArray src, OutputArray dx, OutputArray dy, int ksize=3, int borderType=BORDER_DEFAULT)
CvStatus *SpatialGradient(Mat src, Mat dx, Mat dy, int ksize, int borderType);

// Calculates the normalized sum of squares of the pixel values overlapping the filter.
// void cv::sqrBoxFilter (InputArray src, OutputArray dst, int ddepth, Size ksize, Point anchor=Point(-1, -1), bool normalize=true, int borderType=BORDER_DEFAULT)
CvStatus *
SqrBoxFilter(Mat src, Mat dst, int ddepth, Size ps, Point anchor, bool normalize, int borderType);

// TODO
// Blurs an image using the stackBlur.
// void cv::stackBlur (InputArray src, OutputArray dst, Size ksize)

// SECTION - Geometric Image Transformations

// TODO
// Converts image transformation maps from one representation to another.
// void cv::convertMaps (InputArray map1, InputArray map2, OutputArray dstmap1, OutputArray dstmap2, int dstmap1type, bool nninterpolation=false)

// Calculates an affine transform from three pairs of the corresponding points.
// Mat cv::getAffineTransform (const Point2f src[], const Point2f dst[])
// Mat cv::getAffineTransform (InputArray src, InputArray dst)
CvStatus *GetAffineTransform(VecPoint src, VecPoint dst, Mat *rval);
CvStatus *GetAffineTransform2f(VecPoint2f src, VecPoint2f dst, Mat *rval);


// Calculates a perspective transform from four pairs of the corresponding points.
// Mat cv::getPerspectiveTransform (const Point2f src[], const Point2f dst[], int solveMethod=DECOMP_LU)
// Mat cv::getPerspectiveTransform (InputArray src, InputArray dst, int solveMethod=DECOMP_LU)
CvStatus *GetPerspectiveTransform(VecPoint src, VecPoint dst, Mat *rval, int solveMethod);
CvStatus *GetPerspectiveTransform2f(VecPoint2f src, VecPoint2f dst, Mat *rval, int solveMethod);

// Retrieves a pixel rectangle from an image with sub-pixel accuracy.
// void cv::getRectSubPix (InputArray image, Size patchSize, Point2f center, OutputArray patch, int patchType=-1)
CvStatus *GetRectSubPix(Mat src, Size patchSize, Point2f center, Mat dst);

// Calculates an affine matrix of 2D rotation.
// Mat cv::getRotationMatrix2D (Point2f center, double angle, double scale)
CvStatus *GetRotationMatrix2D(Point2f center, double angle, double scale, Mat *rval);

// Inverts an affine transformation.
// void cv::invertAffineTransform (InputArray M, OutputArray iM)
CvStatus *InvertAffineTransform(Mat src, Mat dst);

// Remaps an image to polar coordinates space.
// void cv::linearPolar (InputArray src, OutputArray dst, Point2f center, double maxRadius, int flags)
CvStatus *LinearPolar(Mat src, Mat dst, Point2f center, double maxRadius, int flags);

// Remaps an image to semilog-polar coordinates space.
// void cv::logPolar (InputArray src, OutputArray dst, Point2f center, double M, int flags)
CvStatus *LogPolar(Mat src, Mat dst, Point2f center, double m, int flags);

// Applies a generic geometrical transformation to an image.
// void cv::remap (InputArray src, OutputArray dst, InputArray map1, InputArray map2, int interpolation, int borderMode=BORDER_CONSTANT, const Scalar &borderValue=Scalar())
CvStatus *
Remap(Mat src, Mat dst, Mat map1, Mat map2, int interpolation, int borderMode, Scalar borderValue);

// Resizes an image.
// void cv::resize (InputArray src, OutputArray dst, Size dsize, double fx=0, double fy=0, int interpolation=INTER_LINEAR)
CvStatus *Resize(Mat src, Mat dst, Size sz, double fx, double fy, int interp);

// Applies an affine transformation to an image.
// void cv::warpAffine (InputArray src, OutputArray dst, InputArray M, Size dsize, int flags=INTER_LINEAR, int borderMode=BORDER_CONSTANT, const Scalar &borderValue=Scalar())
CvStatus *WarpAffine(Mat src, Mat dst, Mat rot_mat, Size dsize);
CvStatus *WarpAffineWithParams(
    Mat src, Mat dst, Mat rot_mat, Size dsize, int flags, int borderMode, Scalar borderValue
);
// Applies a perspective transformation to an image.
// void cv::warpPerspective (InputArray src, OutputArray dst, InputArray M, Size dsize, int flags=INTER_LINEAR, int borderMode=BORDER_CONSTANT, const Scalar &borderValue=Scalar())
CvStatus *WarpPerspective(Mat src, Mat dst, Mat m, Size dsize);
CvStatus *WarpPerspectiveWithParams(
    Mat src, Mat dst, Mat rot_mat, Size dsize, int flags, int borderMode, Scalar borderValue
);

// TODO
// Remaps an image to polar or semilog-polar coordinates space.
// void cv::warpPolar (InputArray src, OutputArray dst, Size dsize, Point2f center, double maxRadius, int flags)

// SECTION - Miscellaneous Image Transformations
// Applies an adaptive threshold to an array.
// void cv::adaptiveThreshold (InputArray src, OutputArray dst, double maxValue, int adaptiveMethod, int thresholdType, int blockSize, double C)
CvStatus *AdaptiveThreshold(
    Mat src, Mat dst, double maxValue, int adaptiveTyp, int typ, int blockSize, double c
);

// void cv::blendLinear (InputArray src1, InputArray src2, InputArray weights1, InputArray weights2, OutputArray dst)

// void cv::distanceTransform (InputArray src, OutputArray dst, int distanceType, int maskSize, int dstType=CV_32F)

// Calculates the distance to the closest zero pixel for each pixel of the source image.
// void cv::distanceTransform (InputArray src, OutputArray dst, OutputArray labels, int distanceType, int maskSize, int labelType=DIST_LABEL_CCOMP)
CvStatus *
DistanceTransform(Mat src, Mat dst, Mat labels, int distanceType, int maskSize, int labelType);

// Fills a connected component with the given color.
// int cv::floodFill (InputOutputArray image, InputOutputArray mask, Point seedPoint, Scalar newVal, Rect *rect=0, Scalar loDiff=Scalar(), Scalar upDiff=Scalar(), int flags=4)
// int cv::floodFill (InputOutputArray image, Point seedPoint, Scalar newVal, Rect *rect=0, Scalar loDiff=Scalar(), Scalar upDiff=Scalar(), int flags=4)
CvStatus * FloodFill(Mat src, Mat mask, Point seedPoint, Scalar newVal, Rect *rect, Scalar loDiff, Scalar upDiff, int flags, int *rval);

// Calculates the integral of an image.
// void cv::integral (InputArray src, OutputArray sum, int sdepth=-1)
// void cv::integral (InputArray src, OutputArray sum, OutputArray sqsum, int sdepth=-1, int sqdepth=-1)
// void cv::integral (InputArray src, OutputArray sum, OutputArray sqsum, OutputArray tilted, int sdepth=-1, int sqdepth=-1)
CvStatus *Integral(Mat src, Mat sum, Mat sqsum, Mat tilted, int sdepth, int sqdepth);

// Applies a fixed-level threshold to each array element.
// double cv::threshold (InputArray src, OutputArray dst, double thresh, double maxval, int type)
CvStatus *Threshold(Mat src, Mat dst, double thresh, double maxvalue, int typ, double *rval);

// SECTION - Drawing Functions

// Draws an arrow segment pointing from the first point to the second one.
// void cv::arrowedLine (InputOutputArray img, Point pt1, Point pt2, const Scalar &color, int thickness=1, int line_type=8, int shift=0, double tipLength=0.1)
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

// Draws a circle.
// void cv::circle (InputOutputArray img, Point center, int radius, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus *Circle(Mat img, Point center, int radius, Scalar color, int thickness);
CvStatus *CircleWithParams(
    Mat img, Point center, int radius, Scalar color, int thickness, int lineType, int shift
);

// Clips the line against the image rectangle.
// bool cv::clipLine (Rect imgRect, Point &pt1, Point &pt2)
// bool cv::clipLine (Size imgSize, Point &pt1, Point &pt2)
// bool cv::clipLine (Size2l imgSize, Point2l &pt1, Point2l &pt2)
CvStatus *ClipLine(Rect imgRect, Point pt1, Point pt2, bool *rval);

// Draws contours outlines or filled contours.
// void cv::drawContours (InputOutputArray image, InputArrayOfArrays contours, int contourIdx, const Scalar &color, int thickness=1, int lineType=LINE_8, InputArray hierarchy=noArray(), int maxLevel=INT_MAX, Point offset=Point())
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

// Draws a marker on a predefined position in an image.
// void cv::drawMarker (InputOutputArray img, Point position, const Scalar &color, int markerType=MARKER_CROSS, int markerSize=20, int thickness=1, int line_type=8)


// Draws a simple or thick elliptic arc or fills an ellipse sector.
// void cv::ellipse (InputOutputArray img, Point center, Size axes, double angle, double startAngle, double endAngle, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
// void cv::ellipse (InputOutputArray img, const RotatedRect &box, const Scalar &color, int thickness=1, int lineType=LINE_8)
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

// Approximates an elliptic arc with a polyline.
// void cv::ellipse2Poly (Point center, Size axes, int angle, int arcStart, int arcEnd, int delta, std::vector< Point > &pts)
// void cv::ellipse2Poly (Point2d center, Size2d axes, int angle, int arcStart, int arcEnd, int delta, std::vector< Point2d > &pts)


// Fills a convex polygon.
// void cv::fillConvexPoly (InputOutputArray img, InputArray points, const Scalar &color, int lineType=LINE_8, int shift=0)
// void cv::fillConvexPoly (InputOutputArray img, const Point *pts, int npts, const Scalar &color, int lineType=LINE_8, int shift=0)

// Fills the area bounded by one or more polygons.
// void cv::fillPoly (InputOutputArray img, const Point **pts, const int *npts, int ncontours, const Scalar &color, int lineType=LINE_8, int shift=0, Point offset=Point())
// void cv::fillPoly (InputOutputArray img, InputArrayOfArrays pts, const Scalar &color, int lineType=LINE_8, int shift=0, Point offset=Point())
CvStatus *FillPoly(Mat img, VecVecPoint points, Scalar color);
CvStatus *FillPolyWithParams(
    Mat img, VecVecPoint points, Scalar color, int lineType, int shift, Point offset
);

// Calculates the font-specific size to use to achieve a given height in pixels.
// double cv::getFontScaleFromHeight (const int fontFace, const int pixelHeight, const int thickness=1)

// Calculates the width and height of a text string.
// Size cv::getTextSize (const String &text, int fontFace, double fontScale, int thickness, int *baseLine)
CvStatus *GetTextSizeWithBaseline(
    const char *text, int fontFace, double fontScale, int thickness, int *baseline, Size *rval
);

// Draws a line segment connecting two points.
// void cv::line (InputOutputArray img, Point pt1, Point pt2, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus *Line(Mat img, Point pt1, Point pt2, Scalar color, int thickness, int lineType, int shift);

// Draws several polygonal curves.
// void cv::polylines (InputOutputArray img, const Point *const *pts, const int *npts, int ncontours, bool isClosed, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
// void cv::polylines (InputOutputArray img, InputArrayOfArrays pts, bool isClosed, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus *Polylines(Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness);

// Draws a text string.
// void cv::putText (InputOutputArray img, const String &text, Point org, int fontFace, double fontScale, Scalar color, int thickness=1, int lineType=LINE_8, bool bottomLeftOrigin=false)
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

// Draws a simple, thick, or filled up-right rectangle.
// void cv::rectangle (InputOutputArray img, Point pt1, Point pt2, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
// void cv::rectangle (InputOutputArray img, Rect rec, const Scalar &color, int thickness=1, int lineType=LINE_8, int shift=0)
CvStatus *Rectangle(Mat img, Rect rect, Scalar color, int thickness);
CvStatus *
RectangleWithParams(Mat img, Rect rect, Scalar color, int thickness, int lineType, int shift);

// SECTION - Color Space Conversions
// Converts an image from one color space to another.
// void cv::cvtColor (InputArray src, OutputArray dst, int code, int dstCn=0, AlgorithmHint hint=cv::ALGO_HINT_DEFAULT)
CvStatus *CvtColor(Mat src, CVD_OUT Mat dst, int code);

// Converts an image from one color space to another where the source image is stored in two planes.
// void cv::cvtColorTwoPlane (InputArray src1, InputArray src2, OutputArray dst, int code, AlgorithmHint hint=cv::ALGO_HINT_DEFAULT)

// main function for all demosaicing processes
// void cv::demosaicing (InputArray src, OutputArray dst, int code, int dstCn=0)

// SECTION - ColorMaps in OpenCV
// Applies a user colormap on a given image.
// void cv::applyColorMap (InputArray src, OutputArray dst, InputArray userColor)
CvStatus *ApplyCustomColorMap(Mat src, Mat dst, Mat colormap);

// Applies a GNU Octave/MATLAB equivalent colormap on a given image.
// void cv::applyColorMap (InputArray src, OutputArray dst, int colormap)
CvStatus *ApplyColorMap(Mat src, Mat dst, int colormap);

// SECTION - Planar Subdivision
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

// SECTION - Histograms
// Calculates the back projection of a histogram.
// void cv::calcBackProject (const Mat *images, int nimages, const int *channels, const SparseMat &hist, OutputArray backProject, const float **ranges, double scale=1, bool uniform=true)
// void cv::calcBackProject (const Mat *images, int nimages, const int *channels, InputArray hist, OutputArray backProject, const float **ranges, double scale=1, bool uniform=true)
// void cv::calcBackProject (InputArrayOfArrays images, const std::vector< int > &channels, InputArray hist, OutputArray dst, const std::vector< float > &ranges, double scale)
CvStatus *CalcBackProject(
    VecMat mats, VecI32 chans, Mat hist, CVD_OUT Mat *backProject, VecF32 rng, double scale
);

// Calculates a histogram of a set of arrays.
// void cv::calcHist (const Mat *images, int nimages, const int *channels, InputArray mask, OutputArray hist, int dims, const int *histSize, const float **ranges, bool uniform=true, bool accumulate=false)
// void cv::calcHist (const Mat *images, int nimages, const int *channels, InputArray mask, SparseMat &hist, int dims, const int *histSize, const float **ranges, bool uniform=true, bool accumulate=false)
// void cv::calcHist (InputArrayOfArrays images, const std::vector< int > &channels, InputArray mask, OutputArray hist, const std::vector< int > &histSize, const std::vector< float > &ranges, bool accumulate=false)
CvStatus *
CalcHist(VecMat mats, VecI32 chans, Mat mask, CVD_OUT Mat hist, VecI32 sz, VecF32 rng, bool acc);

// Compares two histograms.
// double cv::compareHist (const SparseMat &H1, const SparseMat &H2, int method)
// double cv::compareHist (InputArray H1, InputArray H2, int method)
CvStatus *CompareHist(Mat hist1, Mat hist2, int method, CVD_OUT double *rval);

// Creates a smart pointer to a cv::CLAHE class and initializes it.
// Ptr< CLAHE > cv::createCLAHE (double clipLimit=40.0, Size tileGridSize=Size(8, 8))

CvStatus *CLAHE_Create(CLAHE *rval);
CvStatus *CLAHE_CreateWithParams(double clipLimit, Size tileGridSize, CLAHE *rval);
void CLAHE_Close(CLAHEPtr c);
CvStatus *CLAHE_Apply(CLAHE c, Mat src, Mat dst);
CvStatus *CLAHE_CollectGarbage(CLAHE c);
CvStatus *CLAHE_GetClipLimit(CLAHE c, double *rval);
CvStatus *CLAHE_SetClipLimit(CLAHE c, double clipLimit);
CvStatus *CLAHE_GetTilesGridSize(CLAHE c, Size *rval);
CvStatus *CLAHE_SetTilesGridSize(CLAHE c, Size size);

// Computes the "minimal work" distance between two weighted point configurations.
// float cv::EMD (InputArray signature1, InputArray signature2, int distType, InputArray cost=noArray(), float *lowerBound=0, OutputArray flow=noArray())

// Equalizes the histogram of a grayscale image.
// void cv::equalizeHist (InputArray src, OutputArray dst)
CvStatus *EqualizeHist(Mat src, CVD_OUT Mat dst);

// float cv::wrapperEMD (InputArray signature1, InputArray signature2, int distType, InputArray cost=noArray(), Ptr< float > lowerBound=Ptr< float >(), OutputArray flow=noArray())

// SECTION - Structural Analysis and Shape Descriptors
// Approximates a polygonal curve(s) with the specified precision.
// void cv::approxPolyDP (InputArray curve, OutputArray approxCurve, double epsilon, bool closed)
CvStatus *ApproxPolyDP(VecPoint curve, double epsilon, bool closed, CVD_OUT VecPoint *rval);

// Approximates a polygon with a convex hull with a specified accuracy and number of sides.
// void cv::approxPolyN (InputArray curve, OutputArray approxCurve, int nsides, float epsilon_percentage=-1.0, bool ensure_convex=true)

// Calculates a contour perimeter or a curve length.
// double cv::arcLength (InputArray curve, bool closed)
CvStatus *ArcLength(VecPoint curve, bool is_closed, CVD_OUT double *rval);

// Calculates the up-right bounding rectangle of a point set or non-zero pixels of gray-scale image.
// Rect cv::boundingRect (InputArray array)
CvStatus *BoundingRect(VecPoint pts, Rect *rval);

// Finds the four vertices of a rotated rect. Useful to draw the rotated rectangle.
// void cv::boxPoints (RotatedRect box, OutputArray points)
CvStatus *BoxPoints(RotatedRect rect, VecPoint2f *boxPts);

// computes the connected components labeled image of boolean image
// int cv::connectedComponents (InputArray image, OutputArray labels, int connectivity, int ltype, int ccltype)
// int cv::connectedComponents (InputArray image, OutputArray labels, int connectivity=8, int ltype=CV_32S)
CvStatus *
ConnectedComponents(Mat src, Mat dst, int connectivity, int ltype, int ccltype, int *rval);

// computes the connected components labeled image of boolean image and also produces a statistics output for each label
// int cv::connectedComponentsWithStats (InputArray image, OutputArray labels, OutputArray stats, OutputArray centroids, int connectivity, int ltype, int ccltype)
// int cv::connectedComponentsWithStats (InputArray image, OutputArray labels, OutputArray stats, OutputArray centroids, int connectivity=8, int ltype=CV_32S)
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

// Calculates a contour area.
// double cv::contourArea (InputArray contour, bool oriented=false)
CvStatus *ContourArea(VecPoint pts, double *rval);

// Finds the convex hull of a point set.
// void cv::convexHull (InputArray points, OutputArray hull, bool clockwise=false, bool returnPoints=true)
CvStatus *ConvexHull(VecPoint points, CVD_OUT Mat hull, bool clockwise, bool returnPoints);

// Finds the convexity defects of a contour.
// void cv::convexityDefects (InputArray contour, InputArray convexhull, OutputArray convexityDefects)
CvStatus *ConvexityDefects(VecPoint points, Mat hull, Mat result);

// Creates a smart pointer to a cv::GeneralizedHoughBallard class and initializes it.
// Ptr< GeneralizedHoughBallard > cv::createGeneralizedHoughBallard ()

// Creates a smart pointer to a cv::GeneralizedHoughGuil class and initializes it.
// Ptr< GeneralizedHoughGuil > cv::createGeneralizedHoughGuil ()

// Finds contours in a binary image.
// void cv::findContours (InputArray image, OutputArrayOfArrays contours, int mode, int method, Point offset=Point())
// void cv::findContours (InputArray image, OutputArrayOfArrays contours, OutputArray hierarchy, int mode, int method, Point offset=Point())
CvStatus *FindContours(Mat src, Mat hierarchy, int mode, int method, VecVecPoint *rval);

// Find contours using link runs algorithm.
// void cv::findContoursLinkRuns (InputArray image, OutputArrayOfArrays contours)
// void cv::findContoursLinkRuns (InputArray image, OutputArrayOfArrays contours, OutputArray hierarchy)

// Fits an ellipse around a set of 2D points.
// RotatedRect cv::fitEllipse (InputArray points)
CvStatus *FitEllipse(VecPoint pts, RotatedRect *rval);

// Fits an ellipse around a set of 2D points.
// RotatedRect cv::fitEllipseAMS (InputArray points)

// Fits an ellipse around a set of 2D points.
// RotatedRect cv::fitEllipseDirect (InputArray points)

// Fits a line to a 2D or 3D point set.
// void cv::fitLine (InputArray points, OutputArray line, int distType, double param, double reps, double aeps)
CvStatus *FitLine(VecPoint pts, Mat line, int distType, double param, double reps, double aeps);

// Calculates seven Hu invariants.
// void cv::HuMoments (const Moments &m, OutputArray hu)
// void cv::HuMoments (const Moments &moments, double hu[7])

// Finds intersection of two convex polygons.
// float cv::intersectConvexConvex (InputArray p1, InputArray p2, OutputArray p12, bool handleNested=true)

// Tests a contour convexity.
// bool cv::isContourConvex (InputArray contour)

// Compares two shapes.
// double cv::matchShapes (InputArray contour1, InputArray contour2, int method, double parameter)
CvStatus *
MatchShapes(VecPoint contour1, VecPoint contour2, int method, double parameter, double *rval);

// Finds a rotated rectangle of the minimum area enclosing the input 2D point set.
// RotatedRect cv::minAreaRect (InputArray points)
CvStatus *MinAreaRect(VecPoint pts, RotatedRect *rval);

// Finds a circle of the minimum area enclosing a 2D point set.
// void cv::minEnclosingCircle (InputArray points, Point2f &center, float &radius)
CvStatus *MinEnclosingCircle(VecPoint pts, Point2f *center, float *radius);

// Finds a triangle of minimum area enclosing a 2D point set and returns its area.
// double cv::minEnclosingTriangle (InputArray points, OutputArray triangle)

// Calculates all of the moments up to the third order of a polygon or rasterized shape.
// Moments cv::moments (InputArray array, bool binaryImage=false)
CvStatus *Moments(Mat src, bool binaryImage, Moment *rval);

// Performs a point-in-contour test.
// double cv::pointPolygonTest (InputArray contour, Point2f pt, bool measureDist)
CvStatus *PointPolygonTest(VecPoint pts, Point2f pt, bool measureDist, double *rval);

// Finds out if there is any intersection between two rotated rectangles.
// int cv::rotatedRectangleIntersection (const RotatedRect &rect1, const RotatedRect &rect2, OutputArray intersectingRegion)

// SECTION - Motion Analysis and Object Tracking
// Adds an image to the accumulator image.
// void cv::accumulate (InputArray src, InputOutputArray dst, InputArray mask=noArray())
CvStatus *Mat_Accumulate(Mat src, Mat dst);
CvStatus *Mat_AccumulateWithMask(Mat src, Mat dst, Mat mask);

// Adds the per-element product of two input images to the accumulator image.
// void cv::accumulateProduct (InputArray src1, InputArray src2, InputOutputArray dst, InputArray mask=noArray())
CvStatus *Mat_AccumulateProduct(Mat src1, Mat src2, Mat dst);
CvStatus *Mat_AccumulateProductWithMask(Mat src1, Mat src2, Mat dst, Mat mask);

// Adds the square of a source image to the accumulator image.
// void cv::accumulateSquare (InputArray src, InputOutputArray dst, InputArray mask=noArray())
CvStatus *Mat_AccumulateSquare(Mat src, Mat dst);
CvStatus *Mat_AccumulateSquareWithMask(Mat src, Mat dst, Mat mask);

// Updates a running average.
// void cv::accumulateWeighted (InputArray src, InputOutputArray dst, double alpha, InputArray mask=noArray())
CvStatus *Mat_AccumulatedWeighted(Mat src, Mat dst, double alpha);
CvStatus *Mat_AccumulatedWeightedWithMask(Mat src, Mat dst, double alpha, Mat mask);

// This function computes a Hanning window coefficients in two dimensions.
// void cv::createHanningWindow (OutputArray dst, Size winSize, int type)

// Performs the per-element division of the first Fourier spectrum by the second Fourier spectrum.
// void cv::divSpectrums (InputArray a, InputArray b, OutputArray c, int flags, bool conjB=false)

// The function is used to detect translational shifts that occur between two images.
// Point2d cv::phaseCorrelate (InputArray src1, InputArray src2, InputArray window=noArray(), double *response=0)
CvStatus *PhaseCorrelate(Mat src1, Mat src2, Mat window, double *response, Point2f *rval);

// SECTION - Feature Detection
// Finds edges in an image using the Canny algorithm [48] .
// void cv::Canny (InputArray dx, InputArray dy, OutputArray edges, double threshold1, double threshold2, bool L2gradient=false)
// void cv::Canny (InputArray image, OutputArray edges, double threshold1, double threshold2, int apertureSize=3, bool L2gradient=false)
CvStatus *Canny(Mat src, Mat edges, double t1, double t2, int apertureSize, bool l2gradient);

// Calculates eigenvalues and eigenvectors of image blocks for corner detection.
// void cv::cornerEigenValsAndVecs (InputArray src, OutputArray dst, int blockSize, int ksize, int borderType=BORDER_DEFAULT)

// Harris corner detector.
// void cv::cornerHarris (InputArray src, OutputArray dst, int blockSize, int ksize, double k, int borderType=BORDER_DEFAULT)

// Calculates the minimal eigenvalue of gradient matrices for corner detection.
// void cv::cornerMinEigenVal (InputArray src, OutputArray dst, int blockSize, int ksize=3, int borderType=BORDER_DEFAULT)

// Refines the corner locations.
// void cv::cornerSubPix (InputArray image, InputOutputArray corners, Size winSize, Size zeroZone, TermCriteria criteria)
CvStatus *
CornerSubPix(Mat img, VecPoint2f corners, Size winSize, Size zeroZone, TermCriteria criteria);

// Creates a smart pointer to a LineSegmentDetector object and initializes it.
// Ptr< LineSegmentDetector > cv::createLineSegmentDetector (int refine=LSD_REFINE_STD, double scale=0.8, double sigma_scale=0.6, double quant=2.0, double ang_th=22.5, double log_eps=0, double density_th=0.7, int n_bins=1024)

// Determines strong corners on an image.
// Same as above, but returns also quality measure of the detected corners.
// void cv::goodFeaturesToTrack (InputArray image, OutputArray corners, int maxCorners, double qualityLevel, double minDistance, InputArray mask, int blockSize, int gradientSize, bool useHarrisDetector=false, double k=0.04)
// void cv::goodFeaturesToTrack (InputArray image, OutputArray corners, int maxCorners, double qualityLevel, double minDistance, InputArray mask, OutputArray cornersQuality, int blockSize=3, int gradientSize=3, bool useHarrisDetector=false, double k=0.04)
// void cv::goodFeaturesToTrack (InputArray image, OutputArray corners, int maxCorners, double qualityLevel, double minDistance, InputArray mask=noArray(), int blockSize=3, bool useHarrisDetector=false, double k=0.04)
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

// Finds circles in a grayscale image using the Hough transform.
// void cv::HoughCircles (InputArray image, OutputArray circles, int method, double dp, double minDist, double param1=100, double param2=100, int minRadius=0, int maxRadius=0)
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

// Finds lines in a binary image using the standard Hough transform.
// void cv::HoughLines (InputArray image, OutputArray lines, double rho, double theta, int threshold, double srn=0, double stn=0, double min_theta=0, double max_theta=CV_PI)
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

// Finds line segments in a binary image using the probabilistic Hough transform.
// void cv::HoughLinesP (InputArray image, OutputArray lines, double rho, double theta, int threshold, double minLineLength=0, double maxLineGap=0)
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

// Finds lines in a set of points using the standard Hough transform.
// void cv::HoughLinesPointSet (InputArray point, OutputArray lines, int lines_max, int threshold, double min_rho, double max_rho, double rho_step, double min_theta, double max_theta, double theta_step)
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

// Calculates a feature map for corner detection.
// void cv::preCornerDetect (InputArray src, OutputArray dst, int ksize, int borderType=BORDER_DEFAULT)

// SECTION - Object Detection
// Compares a template against overlapped image regions.
// void cv::matchTemplate (InputArray image, InputArray templ, OutputArray result, int method, InputArray mask=noArray())
CvStatus *MatchTemplate(Mat image, Mat templ, Mat result, int method, Mat mask);

// SECTION - Image Segmentation
// Runs the GrabCut algorithm.
// void cv::grabCut (InputArray img, InputOutputArray mask, Rect rect, InputOutputArray bgdModel, InputOutputArray fgdModel, int iterCount, int mode=GC_EVAL)
CvStatus *
GrabCut(Mat img, Mat mask, Rect rect, Mat bgdModel, Mat fgdModel, int iterCount, int mode);

// Performs a marker-based image segmentation using the watershed algorithm.
// void cv::watershed (InputArray image, InputOutputArray markers)
CvStatus *Watershed(Mat image, Mat markers);

// SECTION - Hardware Acceleration Layer

#ifdef __cplusplus
}
#endif

#endif//_OPENCV3_IMGPROC_H_
