// ignore_for_file: non_constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../constants.g.dart';
import '../core/base.dart';
import '../core/contours.dart';
import '../core/mat.dart';
import '../core/moments.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/termcriteria.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

/// ApproxPolyDP approximates a polygonal curve(s) with the specified precision.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga0012a5fdaea70b8a9970165d98722b4c
VecPoint approxPolyDP(VecPoint curve, double epsilon, bool closed) {
  final vec = calloc<cvg.VecPoint>();
  cvRun(() => CFFI.ApproxPolyDP(curve.ref, epsilon, closed, vec));
  return VecPoint.fromPointer(vec);
}

/// ArcLength calculates a contour perimeter or a curve length.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga8d26483c636be6b35c3ec6335798a47c
double arcLength(VecPoint curve, bool closed) {
  return cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => CFFI.ArcLength(curve.ref, closed, p));
    return p.value;
  });
}

/// ConvexHull finds the convex hull of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga014b28e56cb8854c0de4a211cb2be656
Mat convexHull(VecPoint points, {Mat? hull, bool clockwise = false, bool returnPoints = true}) {
  hull ??= Mat.empty();
  cvRun(() => CFFI.ConvexHull(points.ref, hull!.ref, clockwise, returnPoints));
  return hull;
}

/// ConvexityDefects finds the convexity defects of a contour.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gada4437098113fd8683c932e0567f47ba
Mat convexityDefects(VecPoint contour, Mat hull, {Mat? convexityDefects}) {
  convexityDefects ??= Mat.empty();
  cvRun(() => CFFI.ConvexityDefects(contour.ref, hull.ref, convexityDefects!.ref));
  return convexityDefects;
}

/// CvtColor converts an image from one color space to another.
/// It converts the src Mat image to the dst Mat using the
/// code param containing the desired ColorConversionCode color space.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga4e0972be5de079fed4e3a10e24ef5ef0
Mat cvtColor(Mat src, int code, {Mat? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.CvtColor(src.ref, dst!.ref, code));
  return dst;
}

/// EqualizeHist Equalizes the histogram of a grayscale image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga7e54091f0c937d49bf84152a16f76d6e
Mat equalizeHist(Mat src, {Mat? dst}) {
  assert(src.channels == 1, "src must be grayscale");
  dst ??= Mat.empty();
  cvRun(() => CFFI.EqualizeHist(src.ref, dst!.ref));
  return dst;
}

/// CalcHist Calculates a histogram of a set of images
///
/// For futher details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga6ca1876785483836f72a77ced8ea759a
Mat calcHist(
  VecMat src,
  VecInt channels,
  Mat mask,
  VecInt histSize,
  VecFloat ranges, {
  Mat? hist,
  bool accumulate = false,
}) {
  hist ??= Mat.empty();
  cvRun(
    () => CFFI.CalcHist(
      src.ref,
      channels.ref,
      mask.ref,
      hist!.ref,
      histSize.ref,
      ranges.ref,
      accumulate,
    ),
  );

  return hist;
}

/// CalcBackProject calculates the back projection of a histogram.
///
/// For futher details, please see:
/// https:///docs.opencv.org/3.4/d6/dc7/group__imgproc__hist.html#ga3a0af640716b456c3d14af8aee12e3ca
Mat calcBackProject(
  VecMat src,
  VecInt channels,
  Mat hist,
  VecFloat ranges, {
  Mat? dst,
  bool uniform = true,
}) {
  dst ??= Mat.empty();
  cvRun(
    () => CFFI.CalcBackProject(
      src.ref,
      channels.ref,
      hist.ref,
      dst!.ref,
      ranges.ref,
      uniform,
    ),
  );
  return dst;
}

/// CompareHist Compares two histograms.
/// mode: HistCompMethods
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#gaf4190090efa5c47cb367cf97a9a519bd
double compareHist(Mat hist1, Mat hist2, {int method = 0}) {
  return cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => CFFI.CompareHist(hist1.ref, hist2.ref, method, p));
    return p.value;
  });
}

/// ClipLine clips the line against the image rectangle.
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf483cb46ad6b049bc35ec67052ef1c2c
(bool, Point, Point) clipLine(Rect imgRect, Point pt1, Point pt2) {
  final bool r = using<bool>((arena) {
    final rval = arena<ffi.Bool>();
    cvRun(() => CFFI.ClipLine(imgRect.ref, pt1.ref, pt2.ref, rval));
    return rval.value;
  });
  return (r, pt1, pt2);
}

/// BilateralFilter applies a bilateral filter to an image.
///
/// Bilateral filtering is described here:
/// http:///www.dai.ed.ac.uk/CVonline/LOCAL_COPIES/MANDUCHI1/Bilateral_Filtering.html
///
/// BilateralFilter can reduce unwanted noise very well while keeping edges
/// fairly sharp. However, it is very slow compared to most filters.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga9d7064d478c95d60003cf839430737ed
Mat bilateralFilter(Mat src, int diameter, double sigmaColor, double sigmaSpace, {Mat? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.BilateralFilter(src.ref, dst!.ref, diameter, sigmaColor, sigmaSpace));
  return dst;
}

/// Blur blurs an image Mat using a normalized box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga8c45db9afe636703801b0b2e440fce37
Mat blur(Mat src, Size ksize, {Mat? dst}) {
  return using<Mat>((arena) {
    dst ??= Mat.empty();
    cvRun(() => CFFI.Blur(src.ref, dst!.ref, ksize.toSize(arena).ref));
    return dst!;
  });
}

/// BoxFilter blurs an image using the box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad533230ebf2d42509547d514f7d3fbc3
Mat boxFilter(Mat src, int depth, Size ksize, {Mat? dst}) {
  return using<Mat>((arena) {
    dst ??= Mat.empty();
    cvRun(() => CFFI.BoxFilter(src.ref, dst!.ref, depth, ksize.toSize(arena).ref));
    return dst!;
  });
}

/// SqBoxFilter calculates the normalized sum of squares of the pixel values overlapping the filter.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d4/d86/group__imgproc__filter.html#ga76e863e7869912edbe88321253b72688
Mat sqrBoxFilter(Mat src, int depth, Size ksize, {Mat? dst}) {
  return using<Mat>((arena) {
    dst ??= Mat.empty();
    cvRun(() => CFFI.SqBoxFilter(src.ref, dst!.ref, depth, ksize.toSize(arena).ref));
    return dst!;
  });
}

/// Dilate dilates an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga4ff0f3318642c4f469d0e11f242f3b6c
Mat dilate(
  Mat src,
  Mat kernel, {
  Mat? dst,
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar.default_();
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  cvRun(
    () => CFFI.DilateWithParams(
      src.ref,
      dst!.ref,
      kernel.ref,
      anchor!.ref,
      iterations,
      borderType,
      borderValue!.ref,
    ),
  );
  return dst;
}

/// Erode erodes an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaeb1e0c1033e3f6b891a25d0511362aeb
Mat erode(
  Mat src,
  Mat kernel, {
  Mat? dst,
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar.default_();
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  cvRun(
    () => CFFI.ErodeWithParams(
      src.ref,
      dst!.ref,
      kernel.ref,
      anchor!.ref,
      iterations,
      borderType,
      borderValue!.ref,
    ),
  );
  return dst;
}

/// DistanceTransform Calculates the distance to the closest zero pixel for each pixel of the source image.
///
/// distanceType: DistanceTypes
/// maskSize: DistanceTransformMasks
/// labelType: DistanceTransformLabelTypes
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga8a0b7fdfcb7a13dde018988ba3a43042

(Mat dst, Mat labels) distanceTransform(
  Mat src,
  int distanceType,
  int maskSize,
  int labelType, {
  Mat? dst,
  Mat? labels,
}) {
  dst ??= Mat.empty();
  labels ??= Mat.empty();
  cvRun(() => CFFI.DistanceTransform(src.ref, dst!.ref, labels!.ref, distanceType, maskSize, labelType));
  return (dst, labels);
}

/// BoundingRect calculates the up-right bounding rectangle of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gacb413ddce8e48ff3ca61ed7cf626a366
Rect boundingRect(VecPoint points) {
  final rect = calloc<cvg.Rect>();
  cvRun(() => CFFI.BoundingRect(points.ref, rect));
  return Rect.fromPointer(rect);
}

/// BoxPoints finds the four vertices of a rotated rect. Useful to draw the rotated rectangle.
///
/// return: [bottom left, top left, top right, bottom right]
/// For further Details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gaf78d467e024b4d7936cf9397185d2f5c
VecPoint2f boxPoints(RotatedRect rect, {VecPoint2f? pts}) {
  if (pts == null) {
    final p = calloc<cvg.VecPoint2f>();
    cvRun(() => CFFI.BoxPoints(rect.ref, p));
    return VecPoint2f.fromPointer(p);
  }
  cvRun(() => CFFI.BoxPoints(rect.ref, pts.ptr));
  return pts;
}

/// ContourArea calculates a contour area.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#ga2c759ed9f497d4a618048a2f56dc97f1
double contourArea(VecPoint contour) {
  return cvRunArena<double>((arena) {
    final area = arena<ffi.Double>();
    cvRun(() => CFFI.ContourArea(contour.ref, area));
    return area.value;
  });
}

/// MinAreaRect finds a rotated rectangle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga3d476a3417130ae5154aea421ca7ead9
RotatedRect minAreaRect(VecPoint points) {
  final p = calloc<cvg.RotatedRect>();
  cvRun(() => CFFI.MinAreaRect(points.ref, p));
  return RotatedRect.fromPointer(p);
}

/// FitEllipse Fits an ellipse around a set of 2D points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf259efaad93098103d6c27b9e4900ffa
RotatedRect fitEllipse(VecPoint points) {
  final p = calloc<cvg.RotatedRect>();
  cvRun(() => CFFI.FitEllipse(points.ref, p));
  return RotatedRect.fromPointer(p);
}

/// MinEnclosingCircle finds a circle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#ga8ce13c24081bbc7151e9326f412190f1
(Point2f center, double radius) minEnclosingCircle(VecPoint points) {
  return cvRunArena<(Point2f, double)>((arena) {
    final center = calloc<cvg.Point2f>();
    final radius = arena<ffi.Float>();
    cvRun(() => CFFI.MinEnclosingCircle(points.ref, center, radius));
    return (Point2f.fromPointer(center), radius.value);
  });
}

/// FindContours finds contours in a binary image.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gadf1ad6a0b82947fa1fe3c3d497f260e0
(Contours contours, Mat hierarchy) findContours(Mat src, int mode, int method) {
  final hierarchy = Mat.empty();
  final v = calloc<cvg.VecVecPoint>();
  cvRun(() => CFFI.FindContours(src.ref, hierarchy.ref, mode, method, v));
  return (Contours.fromPointer(v), hierarchy);
}

/// PointPolygonTest performs a point-in-contour test.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga1a539e8db2135af2566103705d7a5722
double pointPolygonTest(VecPoint points, Point2f pt, bool measureDist) {
  return cvRunArena<double>((arena) {
    final r = arena<ffi.Double>();
    cvRun(() => CFFI.PointPolygonTest(points.ref, pt.ref, measureDist, r));
    return r.value;
  });
}

/// ConnectedComponents computes the connected components labeled image of boolean image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaedef8c7340499ca391d459122e51bef5
int connectedComponents(Mat image, Mat labels, int connectivity, int ltype, int ccltype) {
  return cvRunArena<int>((arena) {
    final p = arena<ffi.Int>();
    cvRun(() => CFFI.ConnectedComponents(image.ref, labels.ref, connectivity, ltype, ccltype, p));
    return p.value;
  });
}

/// ConnectedComponentsWithStats computes the connected components labeled image of boolean
/// image and also produces a statistics output for each label.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga107a78bf7cd25dec05fb4dfc5c9e765f
int connectedComponentsWithStats(
  Mat src,
  Mat labels,
  Mat stats,
  Mat centroids,
  int connectivity,
  int ltype,
  int ccltype,
) {
  return cvRunArena<int>((arena) {
    final p = arena<ffi.Int>();
    cvRun(
      () => CFFI.ConnectedComponentsWithStats(
        src.ref,
        labels.ref,
        stats.ref,
        centroids.ref,
        connectivity,
        ltype,
        ccltype,
        p,
      ),
    );
    return p.value;
  });
}

/// MatchTemplate compares a template against overlapped image regions.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/df/dfb/group__imgproc__object.html#ga586ebfb0a7fb604b35a23d85391329be
Mat matchTemplate(Mat image, Mat templ, int method, {OutputArray? result, Mat? mask}) {
  mask ??= Mat.empty();
  result ??= Mat.empty();
  cvRun(() => CFFI.MatchTemplate(image.ref, templ.ref, result!.ref, method, mask!.ref));
  return result;
}

/// Moments calculates all of the moments up to the third order of a polygon
/// or rasterized shape.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga556a180f43cab22649c23ada36a8a139
Moments moments(Mat src, {bool binaryImage = false}) {
  final m = calloc<cvg.Moment>();
  cvRun(() => CFFI.Moments(src.ref, binaryImage, m));
  return Moments.fromPointer(m);
}

/// PyrDown blurs an image and downsamples it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaf9bba239dfca11654cb7f50f889fc2ff
Mat pyrDown(
  Mat src, {
  Mat? dst,
  (int, int) dstsize = (0, 0),
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  using((arena) {
    cvRun(() => CFFI.PyrDown(src.ref, dst!.ref, dstsize.toSize(arena).ref, borderType));
  });
  return dst;
}

/// PyrUp upsamples an image and then blurs it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gada75b59bdaaca411ed6fee10085eb784
Mat pyrUp(
  Mat src, {
  Mat? dst,
  (int, int) dstsize = (0, 0),
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  using((arena) {
    cvRun(() => CFFI.PyrUp(src.ref, dst!.ref, dstsize.toSize(arena).ref, borderType));
  });
  return dst;
}

/// MorphologyDefaultBorder returns "magic" border value for erosion and dilation.
/// It is automatically transformed to Scalar::all(-DBL_MAX) for dilation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga94756fad83d9d24d29c9bf478558c40a
Scalar morphologyDefaultBorderValue() {
  final s = calloc<cvg.Scalar>();
  cvRun(() => CFFI.MorphologyDefaultBorderValue(s));
  return Scalar.fromPointer(s);
}

/// MorphologyEx performs advanced morphological transformations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga67493776e3ad1a3df63883829375201f
Mat morphologyEx(
  Mat src,
  int op,
  Mat kernel, {
  Mat? dst,
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue = borderValue ?? Scalar.default_();
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  cvRun(
    () => CFFI.MorphologyExWithParams(
      src.ref,
      dst!.ref,
      op,
      kernel.ref,
      anchor!.ref,
      iterations,
      borderType,
      borderValue!.ref,
    ),
  );
  return dst;
}

/// GetStructuringElement returns a structuring element of the specified size
/// and shape for morphological operations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac342a1bb6eabf6f55c803b09268e36dc
Mat getStructuringElement(int shape, Size ksize, {Point? anchor}) {
  anchor ??= Point(-1, -1);
  return cvRunArena<Mat>((arena) {
    final r = calloc<cvg.Mat>();
    cvRun(() => CFFI.GetStructuringElement(shape, ksize.toSize(arena).ref, r));
    return Mat.fromPointer(r);
  });
}

/// GaussianBlur blurs an image Mat using a Gaussian filter.
/// The function convolves the src Mat image into the dst Mat using
/// the specified Gaussian kernel params.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaabe8c836e97159a9193fb0b11ac52cf1
Mat gaussianBlur(
  Mat src,
  Size ksize,
  double sigmaX, {
  Mat? dst,
  double sigmaY = 0,
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  cvRunArena((arena) {
    cvRun(() => CFFI.GaussianBlur(src.ref, dst!.ref, ksize.toSize(arena).ref, sigmaX, sigmaY, borderType));
  });
  return dst;
}

/// GetGaussianKernel returns Gaussian filter coefficients.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac05a120c1ae92a6060dd0db190a61afa
Mat getGaussianKernel(int ksize, double sigma, {int ktype = 6}) {
  final r = calloc<cvg.Mat>();
  cvRun(() => CFFI.GetGaussianKernel(ksize, sigma, ktype, r));
  return Mat.fromPointer(r);
}

/// Sobel calculates the first, second, third, or mixed image derivatives using an extended Sobel operator
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gacea54f142e81b6758cb6f375ce782c8d
Mat sobel(
  Mat src,
  int ddepth,
  int dx,
  int dy, {
  Mat? dst,
  int ksize = 3,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.Sobel(src.ref, dst!.ref, ddepth, dx, dy, ksize, scale, delta, borderType));
  return dst;
}

/// SpatialGradient calculates the first order image derivative in both x and y using a Sobel operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga405d03b20c782b65a4daf54d233239a2
(Mat dx, Mat dy) spatialGradient(
  Mat src, {
  Mat? dx,
  Mat? dy,
  int ksize = 3,
  int borderType = BORDER_DEFAULT,
}) {
  dx ??= Mat.empty();
  dy ??= Mat.empty();
  cvRun(() => CFFI.SpatialGradient(src.ref, dx!.ref, dy!.ref, ksize, borderType));
  return (dx, dy);
}

/// Laplacian calculates the Laplacian of an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad78703e4c8fe703d479c1860d76429e6
Mat laplacian(
  Mat src,
  int ddepth, {
  Mat? dst,
  int ksize = 1,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.Laplacian(src.ref, dst!.ref, ddepth, ksize, scale, delta, borderType));
  return dst;
}

/// Scharr calculates the first x- or y- image derivative using Scharr operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaa13106761eedf14798f37aa2d60404c9
Mat scharr(
  Mat src,
  int ddepth,
  int dx,
  int dy, {
  Mat? dst,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.Scharr(src.ref, dst!.ref, ddepth, dx, dy, scale, delta, borderType));
  return dst;
}

/// MedianBlur blurs an image using the median filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga564869aa33e58769b4469101aac458f9
Mat medianBlur(Mat src, int ksize, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.MedianBlur(src.ref, dst!.ref, ksize));
  return dst;
}

/// Canny finds edges in an image using the Canny algorithm.
/// The function finds edges in the input image image and marks
/// them in the output map edges using the Canny algorithm.
/// The smallest value between threshold1 and threshold2 is used
/// for edge linking. The largest value is used to
/// find initial segments of strong edges.
/// See http:///en.wikipedia.org/wiki/Canny_edge_detector
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga04723e007ed888ddf11d9ba04e2232de
Mat canny(
  Mat image,
  double threshold1,
  double threshold2, {
  OutputArray? edges,
  int apertureSize = 3,
  bool l2gradient = false,
}) {
  edges ??= Mat.empty();
  cvRun(() => CFFI.Canny(image.ref, edges!.ref, threshold1, threshold2, apertureSize, l2gradient));
  return edges;
}

/// CornerSubPix Refines the corner locations. The function iterates to find
/// the sub-pixel accurate location of corners or radial saddle points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga354e0d7c86d0d9da75de9b9701a9a87e
VecPoint2f cornerSubPix(
  InputArray image,
  VecPoint2f corners,
  Size winSize,
  Size zeroZone, [
  TermCriteria criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
]) {
  cvRunArena((arena) {
    final size = winSize.toSize(arena);
    final zone = zeroZone.toSize(arena);
    final c = criteria.toNativePtr(arena);
    cvRun(() => CFFI.CornerSubPix(image.ref, corners.ref, size.ref, zone.ref, c.ref));
  });
  return corners;
}

/// GoodFeaturesToTrack determines strong corners on an image. The function
/// finds the most prominent corners in the image or in the specified image region.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga1d6bb77486c8f92d79c8793ad995d541
VecPoint2f goodFeaturesToTrack(
  InputArray image,
  int maxCorners,
  double qualityLevel,
  double minDistance, {
  VecPoint2f? corners,
  InputArray? mask,
  int blockSize = 3,
  int? gradientSize,
  bool useHarrisDetector = false,
  double k = 0.04,
}) {
  final c = corners?.ptr ?? calloc<cvg.VecPoint2f>();
  mask ??= Mat.empty();
  if (gradientSize == null) {
    cvRun(
      () => CFFI.GoodFeaturesToTrack(
        image.ref,
        c,
        maxCorners,
        qualityLevel,
        minDistance,
        mask!.ref,
        blockSize,
        useHarrisDetector,
        k,
      ),
    );
  } else {
    cvRun(
      () => CFFI.GoodFeaturesToTrackWithGradient(
        image.ref,
        c,
        maxCorners,
        qualityLevel,
        minDistance,
        mask!.ref,
        blockSize,
        gradientSize,
        useHarrisDetector,
        k,
      ),
    );
  }
  return corners ?? VecPoint2f.fromPointer(c);
}

/// Grabcut runs the GrabCut algorithm.
/// The function implements the GrabCut image segmentation algorithm.
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d47/group__imgproc__segmentation.html#ga909c1dda50efcbeaa3ce126be862b37f
(Mat mask, Mat bgdModel, Mat fgdModel) grabCut(
  InputArray img,
  InputOutputArray mask,
  Rect rect,
  InputOutputArray bgdModel,
  InputOutputArray fgdModel,
  int iterCount, {
  int mode = GC_EVAL,
}) {
  cvRun(() => CFFI.GrabCut(img.ref, mask.ref, rect.ref, bgdModel.ref, fgdModel.ref, iterCount, mode));
  return (mask, bgdModel, fgdModel);
}

/// HoughCircles finds circles in a grayscale image using the Hough transform.
/// The only "method" currently supported is HoughGradient. If you want to pass
/// more parameters, please see `HoughCirclesWithParams`.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga47849c3be0d0406ad3ca45db65a25d2d
Mat HoughCircles(
  InputArray image,
  int method,
  double dp,
  double minDist, {
  OutputArray? circles,
  double param1 = 100,
  double param2 = 100,
  int minRadius = 0,
  int maxRadius = 0,
}) {
  circles ??= Mat.empty();
  cvRun(
    () => CFFI.HoughCirclesWithParams(
      image.ref,
      circles!.ref,
      method,
      dp,
      minDist,
      param1,
      param2,
      minRadius,
      maxRadius,
    ),
  );
  return circles;
}

/// HoughLines implements the standard or standard multi-scale Hough transform
/// algorithm for line detection. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga46b4e588934f6c8dfd509cc6e0e4545a
Mat HoughLines(
  InputArray image,
  double rho,
  double theta,
  int threshold, {
  OutputArray? lines,
  double srn = 0,
  double stn = 0,
  double min_theta = 0,
  double max_theta = CV_PI,
}) {
  lines ??= Mat.empty();
  cvRun(() => CFFI.HoughLines(image.ref, lines!.ref, rho, theta, threshold, srn, stn, min_theta, max_theta));
  return lines;
}

/// HoughLinesP implements the probabilistic Hough transform
/// algorithm for line detection. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga8618180a5948286384e3b7ca02f6feeb
Mat HoughLinesP(
  InputArray image,
  double rho,
  double theta,
  int threshold, {
  OutputArray? lines,
  double minLineLength = 0,
  double maxLineGap = 0,
}) {
  lines ??= Mat.empty();
  cvRun(
    () => CFFI.HoughLinesPWithParams(
      image.ref,
      lines!.ref,
      rho,
      theta,
      threshold,
      minLineLength,
      maxLineGap,
    ),
  );
  return lines;
}

/// HoughLinesPointSet implements the Hough transform algorithm for line
/// detection on a set of points. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga2858ef61b4e47d1919facac2152a160e
Mat HoughLinesPointSet(
  InputArray point,
  int lines_max,
  int threshold,
  double min_rho,
  double max_rho,
  double rho_step,
  double min_theta,
  double max_theta,
  double theta_step, {
  OutputArray? lines,
}) {
  lines ??= Mat.empty();
  cvRun(
    () => CFFI.HoughLinesPointSet(
      point.ref,
      lines!.ref,
      lines_max,
      threshold,
      min_rho,
      max_rho,
      rho_step,
      min_theta,
      max_theta,
      theta_step,
    ),
  );
  return lines;
}

/// Integral calculates one or more integral images for the source image.
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga97b87bec26908237e8ba0f6e96d23e28
(Mat sum, Mat sqsum, Mat tilted) integral(
  InputArray src, {
  OutputArray? sum,
  OutputArray? sqsum,
  OutputArray? tilted,
  int sdepth = -1,
  int sqdepth = -1,
}) {
  sum ??= Mat.empty();
  sqsum ??= Mat.empty();
  tilted ??= Mat.empty();
  cvRun(() => CFFI.Integral(src.ref, sum!.ref, sqsum!.ref, tilted!.ref, sdepth, sqdepth));
  return (sum, sqsum, tilted);
}

/// Threshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d7/d1b/group__imgproc__misc.html#gae8a4a146d1ca78c626a53577199e9c57
(double, Mat dst) threshold(
  InputArray src,
  double thresh,
  double maxval,
  int type, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  final rval = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => CFFI.Threshold(src.ref, dst!.ref, thresh, maxval, type, p));
    return p.value;
  });
  return (rval, dst);
}

/// AdaptiveThreshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga72b913f352e4a1b1b397736707afcde3
Mat adaptiveThreshold(
  InputArray src,
  double maxValue,
  int adaptiveMethod,
  int thresholdType,
  int blockSize,
  double C, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  cvRun(
    () => CFFI.AdaptiveThreshold(
      src.ref,
      dst!.ref,
      maxValue,
      adaptiveMethod,
      thresholdType,
      blockSize,
      C,
    ),
  );
  return dst;
}

/// ArrowedLine draws a arrow segment pointing from the first point
/// to the second one.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga0a165a3ca093fd488ac709fdf10c05b2
Mat arrowedLine(
  InputOutputArray img,
  Point pt1,
  Point pt2,
  Scalar color, {
  int thickness = 1,
  int line_type = 8,
  int shift = 0,
  double tipLength = 0.1,
}) {
  cvRun(() => CFFI.ArrowedLine(img.ref, pt1.ref, pt2.ref, color.ref, thickness, line_type, shift, tipLength));
  return img;
}

/// CircleWithParams draws a circle.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf10604b069374903dbd0f0488cb43670
Mat circle(
  InputOutputArray img,
  Point center,
  int radius,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  cvRun(() => CFFI.CircleWithParams(img.ref, center.ref, radius, color.ref, thickness, lineType, shift));
  return img;
}

/// Ellipse draws a simple or thick elliptic arc or fills an ellipse sector.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga28b2267d35786f5f890ca167236cbc69
Mat ellipse(
  InputOutputArray img,
  Point center,
  Point axes,
  double angle,
  double startAngle,
  double endAngle,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  cvRun(
    () => CFFI.EllipseWithParams(
      img.ref,
      center.ref,
      axes.ref,
      angle,
      startAngle,
      endAngle,
      color.ref,
      thickness,
      lineType,
      shift,
    ),
  );
  return img;
}

/// Line draws a line segment connecting two points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga7078a9fae8c7e7d13d24dac2520ae4a2
Mat line(
  InputOutputArray img,
  Point pt1,
  Point pt2,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  cvRun(() => CFFI.Line(img.ref, pt1.ref, pt2.ref, color.ref, thickness, lineType, shift));
  return img;
}

/// Rectangle draws a simple, thick, or filled up-right rectangle.
/// It renders a rectangle with the desired characteristics to the target Mat image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga07d2f74cadcf8e305e810ce8eed13bc9
Mat rectangle(
  InputOutputArray img,
  Rect rect,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  cvRun(() => CFFI.RectangleWithParams(img.ref, rect.ref, color.ref, thickness, lineType, shift));
  return img;
}

/// FillPolyWithParams fills the area bounded by one or more polygons.
///
/// For more information, see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf30888828337aa4c6b56782b5dfbd4b7
Mat fillPoly(
  InputOutputArray img,
  VecVecPoint pts,
  Scalar color, {
  int lineType = LINE_8,
  int shift = 0,
  Point? offset,
}) {
  offset ??= Point(0, 0);
  cvRun(() => CFFI.FillPolyWithParams(img.ref, pts.ref, color.ref, lineType, shift, offset!.ref));
  return img;
}

/// Polylines draws several polygonal curves.
///
/// For more information, see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga1ea127ffbbb7e0bfc4fd6fd2eb64263c
Mat polylines(
  InputOutputArray img,
  VecVecPoint pts,
  bool isClosed,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  cvRun(() => CFFI.Polylines(img.ref, pts.ref, isClosed, color.ref, thickness));
  return img;
}

/// GetTextSizeWithBaseline calculates the width and height of a text string including the basline of the text.
/// It returns an image.Point with the size required to draw text using
/// a specific font face, scale, and thickness as well as its baseline.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga3d2abfcb995fd2db908c8288199dba82
(Size size, int baseline) getTextSize(
  String text,
  int fontFace,
  double fontScale,
  int thickness,
) {
  return using<(Size, int)>((arena) {
    final baseline = arena<ffi.Int>();
    final size = arena<cvg.Size>();
    final textPtr = text.toNativeUtf8(allocator: arena);
    cvRun(() => CFFI.GetTextSizeWithBaseline(textPtr.cast(), fontFace, fontScale, thickness, baseline, size));
    final Size sz = (size.ref.width, size.ref.height);
    return (sz, baseline.value);
  });
}

/// PutTextWithParams draws a text string.
/// It renders the specified text string into the img Mat at the location
/// passed in the "org" param, using the desired font face, font scale,
/// color, and line thinkness.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga5126f47f883d730f633d74f07456c576
Mat putText(
  InputOutputArray img,
  String text,
  Point org,
  int fontFace,
  double fontScale,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  bool bottomLeftOrigin = false,
}) {
  using((arena) {
    final textPtr = text.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    cvRun(
      () => CFFI.PutTextWithParams(
        img.ref,
        textPtr,
        org.ref,
        fontFace,
        fontScale,
        color.ref,
        thickness,
        lineType,
        bottomLeftOrigin,
      ),
    );
  });
  return img;
}

/// Resize resizes an image.
/// It resizes the image src down to or up to the specified size, storing the
/// result in dst. Note that src and dst may be the same image. If you wish to
/// scale by factor, an empty sz may be passed and non-zero fx and fy. Likewise,
/// if you wish to scale to an explicit size, a non-empty sz may be passed with
/// zero for both fx and fy.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga47a974309e9102f5f08231edc7e7529d
Mat resize(
  InputArray src,
  Size dsize, {
  OutputArray? dst,
  double fx = 0,
  double fy = 0,
  int interpolation = INTER_LINEAR,
}) {
  dst ??= Mat.empty();
  using((arena) {
    cvRun(() => CFFI.Resize(src.ref, dst!.ref, dsize.toSize(arena).ref, fx, fy, interpolation));
  });
  return dst;
}

/// GetRectSubPix retrieves a pixel rectangle from an image with sub-pixel accuracy.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga77576d06075c1a4b6ba1a608850cd614
Mat getRectSubPix(
  InputArray image,
  Size patchSize,
  Point2f center, {
  OutputArray? patch,
  int patchType = -1,
}) {
  patch ??= Mat.empty();
  using((arena) {
    cvRun(
      () => CFFI.GetRectSubPix(
        image.ref,
        patchSize.toSize(arena).ref,
        center.ref,
        patch!.ref,
      ),
    );
  });
  return patch;
}

/// GetRotationMatrix2D calculates an affine matrix of 2D rotation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gafbbc470ce83812914a70abfb604f4326
Mat getRotationMatrix2D(Point2f center, double angle, double scale) {
  final mat = calloc<cvg.Mat>();
  cvRun(() => CFFI.GetRotationMatrix2D(center.ref, angle, scale, mat));
  return Mat.fromPointer(mat);
}

/// WarpAffine applies an affine transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga0203d9ee5fcd28d40dbc4a1ea4451983
Mat warpAffine(
  InputArray src,
  InputArray M,
  Size dsize, {
  OutputArray? dst,
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  dst ??= Mat.empty();
  borderValue ??= Scalar.default_();
  using((arena) {
    cvRun(
      () => CFFI.WarpAffineWithParams(
        src.ref,
        dst!.ref,
        M.ref,
        dsize.toSize(arena).ref,
        flags,
        borderMode,
        borderValue!.ref,
      ),
    );
  });
  return dst;
}

/// WarpPerspective applies a perspective transformation to an image.
/// For more parameters please check WarpPerspectiveWithParams.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaf73673a7e8e18ec6963e3774e6a94b87
Mat warpPerspective(
  InputArray src,
  InputArray M,
  Size dsize, {
  OutputArray? dst,
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  dst ??= Mat.empty();
  borderValue ??= Scalar.default_();
  using((arena) {
    cvRun(
      () => CFFI.WarpPerspectiveWithParams(
        src.ref,
        dst!.ref,
        M.ref,
        dsize.toSize(arena).ref,
        flags,
        borderMode,
        borderValue!.ref,
      ),
    );
  });
  return dst;
}

/// Watershed performs a marker-based image segmentation using the watershed algorithm.
///
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/d47/group__imgproc__segmentation.html#ga3267243e4d3f95165d55a618c65ac6e1
Mat watershed(InputArray image, InputOutputArray markers) {
  cvRun(() => CFFI.Watershed(image.ref, markers.ref));
  return markers;
}

/// ApplyColorMap applies a GNU Octave/MATLAB equivalent colormap on a given image.
/// colormap: ColormapTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gadf478a5e5ff49d8aa24e726ea6f65d15
Mat applyColorMap(InputArray src, int colormap, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.ApplyColorMap(src.ref, dst!.ref, colormap));
  return dst;
}

/// ApplyCustomColorMap applies a custom defined colormap on a given image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gacb22288ddccc55f9bd9e6d492b409cae
Mat applyCustomColorMap(InputArray src, InputArray userColor, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.ApplyCustomColorMap(src.ref, dst!.ref, userColor.ref));
  return dst;
}

/// GetPerspectiveTransform returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Mat getPerspectiveTransform(VecPoint src, VecPoint dst, [int solveMethod = DECOMP_LU]) {
  final mat = calloc<cvg.Mat>();
  cvRun(() => CFFI.GetPerspectiveTransform(src.ref, dst.ref, mat, solveMethod));
  return Mat.fromPointer(mat);
}

/// GetPerspectiveTransform2f returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as gocv.Point2f.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Mat getPerspectiveTransform2f(VecPoint2f src, VecPoint2f dst, [int solveMethod = DECOMP_LU]) {
  final mat = calloc<cvg.Mat>();
  cvRun(() => CFFI.GetPerspectiveTransform2f(src.ref, dst.ref, mat, solveMethod));
  return Mat.fromPointer(mat);
}

/// GetAffineTransform returns a 2x3 affine transformation matrix for the
/// corresponding 3 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8f6d378f9f8eebb5cb55cd3ae295a999
Mat getAffineTransform(VecPoint src, VecPoint dst) {
  final mat = calloc<cvg.Mat>();
  cvRun(() => CFFI.GetAffineTransform(src.ref, dst.ref, mat));
  return Mat.fromPointer(mat);
}

Mat getAffineTransform2f(VecPoint2f src, VecPoint2f dst) {
  final mat = calloc<cvg.Mat>();
  cvRun(() => CFFI.GetAffineTransform2f(src.ref, dst.ref, mat));
  return Mat.fromPointer(mat);
}

/// FindHomography finds an optimal homography matrix using 4 or more point pairs (as opposed to GetPerspectiveTransform, which uses exactly 4)
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d9/d0c/group__calib3d.html#ga4abc2ece9fab9398f2e560d53c8c9780
Mat findHomography(
  InputArray srcPoints,
  InputArray dstPoints, {
  int method = 0,
  double ransacReprojThreshold = 3,
  OutputArray? mask,
  int maxIters = 2000,
  double confidence = 0.995,
}) {
  mask ??= Mat.empty();
  final mat = calloc<cvg.Mat>();
  cvRun(
    () => CFFI.FindHomography(
      srcPoints.ref,
      dstPoints.ref,
      method,
      ransacReprojThreshold,
      mask!.ref,
      maxIters,
      confidence,
      mat,
    ),
  );
  return Mat.fromPointer(mat);
}

/// DrawContours draws contours outlines or filled contours.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga746c0625f1781f1ffc9056259103edbc
Mat drawContours(
  InputOutputArray image,
  Contours contours,
  int contourIdx,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  InputArray? hierarchy, // TODO: replace with vec
  int maxLevel = 0x3f3f3f3f,
  Point? offset,
}) {
  offset ??= Point(0, 0);
  hierarchy ??= Mat.empty();
  cvRun(
    () => CFFI.DrawContoursWithParams(
      image.ref,
      contours.ref,
      contourIdx,
      color.ref,
      thickness,
      lineType,
      hierarchy!.ref,
      maxLevel,
      offset!.ref,
    ),
  );
  return image;
}

/// Remap applies a generic geometrical transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gab75ef31ce5cdfb5c44b6da5f3b908ea4
Mat remap(
  InputArray src,
  InputArray map1,
  InputArray map2,
  int interpolation, {
  OutputArray? dst,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar.default_();
  dst ??= Mat.empty();
  cvRun(() => CFFI.Remap(src.ref, dst!.ref, map1.ref, map2.ref, interpolation, borderMode, borderValue!.ref));
  return dst;
}

/// Filter2D applies an arbitrary linear filter to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga27c049795ce870216ddfb366086b5a04
Mat filter2D(
  InputArray src,
  int ddepth,
  InputArray kernel, {
  OutputArray? dst,
  Point? anchor,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  cvRun(() => CFFI.Filter2D(src.ref, dst!.ref, ddepth, kernel.ref, anchor!.ref, delta, borderType));
  return dst;
}

/// SepFilter2D applies a separable linear filter to the image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga910e29ff7d7b105057d1625a4bf6318d
Mat sepFilter2D(
  InputArray src,
  int ddepth,
  InputArray kernelX,
  InputArray kernelY, {
  OutputArray? dst,
  Point? anchor,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  anchor ??= Point(-1, -1);
  dst ??= Mat.empty();
  cvRun(
    () => CFFI.SepFilter2D(
      src.ref,
      dst!.ref,
      ddepth,
      kernelX.ref,
      kernelY.ref,
      anchor!.ref,
      delta,
      borderType,
    ),
  );
  return dst;
}

/// LogPolar remaps an image to semilog-polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaec3a0b126a85b5ca2c667b16e0ae022d
Mat logPolar(InputArray src, Point2f center, double M, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.LogPolar(src.ref, dst!.ref, center.ref, M, flags));
  return dst;
}

/// LinearPolar remaps an image to polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaa38a6884ac8b6e0b9bed47939b5362f3
Mat linearPolar(InputArray src, Point2f center, double maxRadius, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => CFFI.LinearPolar(src.ref, dst!.ref, center.ref, maxRadius, flags));
  return dst;
}

/// FitLine fits a line to a 2D or 3D point set.
/// distType: DistanceTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf849da1fdafa67ee84b1e9a23b93f91f
Mat fitLine(VecPoint points, int distType, double param, double reps, double aeps, {OutputArray? line}) {
  line ??= Mat.empty();
  cvRun(() => CFFI.FitLine(points.ref, line!.ref, distType, param, reps, aeps));
  return line;
}

/// Compares two shapes.
/// method: ShapeMatchModes
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gaadc90cb16e2362c9bd6e7363e6e4c317
double matchShapes(VecPoint contour1, VecPoint contour2, int method, double parameter) {
  return cvRunArena<double>((arena) {
    final r = arena<ffi.Double>();
    cvRun(() => CFFI.MatchShapes(contour1.ref, contour2.ref, method, parameter, r));
    return r.value;
  });
}

/// Inverts an affine transformation.
/// The function computes an inverse affine transformation represented by 2×3 matrix M:
/// The result is also a 2×3 matrix of the same type as M.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/da/d54/group__imgproc__transform.html#ga57d3505a878a7e1a636645727ca08f51
Mat invertAffineTransform(InputArray M, {OutputArray? iM}) {
  iM ??= Mat.empty();
  cvRun(() => CFFI.InvertAffineTransform(M.ref, iM!.ref));
  return iM;
}

/// Apply phaseCorrelate.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga552420a2ace9ef3fb053cd630fdb4952
(Point2f rval, double response) phaseCorrelate(InputArray src1, InputArray src2, {InputArray? window}) {
  window ??= Mat.empty();
  return cvRunArena<(Point2f, double)>((arena) {
    final p = arena<ffi.Double>();
    final pp = calloc<cvg.Point2f>();
    cvRun(() => CFFI.PhaseCorrelate(src1.ref, src2.ref, window!.ref, p, pp));
    return (Point2f.fromPointer(pp), p.value);
  });
}

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga1a567a79901513811ff3b9976923b199
///
Mat accumulate(InputArray src, InputOutputArray dst, {InputArray? mask}) {
  if (mask == null) {
    cvRun(() => CFFI.Mat_Accumulate(src.ref, dst.ref));
  } else {
    cvRun(() => CFFI.Mat_AccumulateWithMask(src.ref, dst.ref, mask.ref));
  }
  return dst;
}

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#gacb75e7ffb573227088cef9ceaf80be8c
Mat accumulateSquare(InputArray src, InputOutputArray dst, {InputArray? mask}) {
  if (mask == null) {
    cvRun(() => CFFI.Mat_AccumulateSquare(src.ref, dst.ref));
  } else {
    cvRun(() => CFFI.Mat_AccumulateSquareWithMask(src.ref, dst.ref, mask.ref));
  }
  return dst;
}

/// Adds the per-element product of two input images to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga82518a940ecfda49460f66117ac82520
Mat accumulateProduct(InputArray src1, InputArray src2, InputOutputArray dst, {InputArray? mask}) {
  if (mask == null) {
    cvRun(() => CFFI.Mat_AccumulateProduct(src1.ref, src2.ref, dst.ref));
  } else {
    cvRun(() => CFFI.Mat_AccumulateProductWithMask(src1.ref, src2.ref, dst.ref, mask.ref));
  }
  return dst;
}

/// Updates a running average.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga4f9552b541187f61f6818e8d2d826bc7
Mat accumulateWeighted(InputArray src, InputOutputArray dst, double alpha, {InputArray? mask}) {
  if (mask == null) {
    cvRun(() => CFFI.Mat_AccumulatedWeighted(src.ref, dst.ref, alpha));
  } else {
    cvRun(() => CFFI.Mat_AccumulatedWeightedWithMask(src.ref, dst.ref, alpha, mask.ref));
  }
  return dst;
}
