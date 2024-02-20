library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../types/contours.dart';
import '../types/scalar.dart';
import '../types/types.dart';
import '../types/point.dart';
import '../types/mat.dart';
import '../types/rect.dart';
import '../types/moments.dart';
import '../types/extensions.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// ApproxPolyDP approximates a polygonal curve(s) with the specified precision.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga0012a5fdaea70b8a9970165d98722b4c
List<Point> approxPolyDP(List<Point> curve, double epsilon, bool closed) {
  final pointVec = curve.toNativeVecotr();
  final vec = _bindings.ApproxPolyDP(pointVec, epsilon, closed);
  _bindings.PointVector_Close(pointVec);
  return List.generate(
    _bindings.PointVector_Size(vec),
    (index) => Point.fromNative(_bindings.PointVector_At(vec, index)),
  );
}

/// ArcLength calculates a contour perimeter or a curve length.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga8d26483c636be6b35c3ec6335798a47c
double arcLength(List<Point> curve, bool closed) {
  final pointVec = curve.toNativeVecotr();
  final len = _bindings.ArcLength(pointVec, closed);
  _bindings.PointVector_Close(pointVec);
  return len;
}

/// ConvexHull finds the convex hull of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga014b28e56cb8854c0de4a211cb2be656
void convexHull(
    List<Point> points, Mat hull, bool clockwise, bool returnPoints) {
  final pointVec = points.toNativeVecotr();
  _bindings.ConvexHull(pointVec, hull.ptr, clockwise, returnPoints);
  _bindings.PointVector_Close(pointVec);
}

/// ConvexityDefects finds the convexity defects of a contour.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gada4437098113fd8683c932e0567f47ba
void convexityDefects(List<Point> contour, final Mat hull, Mat result) {
  final pointVec = contour.toNativeVecotr();
  _bindings.ConvexityDefects(pointVec, hull.ptr, result.ptr);
  _bindings.PointVector_Close(pointVec);
}

/// CvtColor converts an image from one color space to another.
/// It converts the src Mat image to the dst Mat using the
/// code param containing the desired ColorConversionCode color space.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga4e0972be5de079fed4e3a10e24ef5ef0
void cvtColor(Mat src, Mat dst, int code) {
  _bindings.CvtColor(src.ptr, dst.ptr, code);
}

/// EqualizeHist Equalizes the histogram of a grayscale image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga7e54091f0c937d49bf84152a16f76d6e
void equalizeHist(Mat src, Mat dst) {
  assert(src.channels == 1, "src must be grayscale");
  _bindings.EqualizeHist(src.ptr, dst.ptr);
}

/// CalcHist Calculates a histogram of a set of images
///
/// For futher details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga6ca1876785483836f72a77ced8ea759a
void calcHist(List<Mat> src, List<int> channels, Mat mask, Mat hist,
    List<int> histSize, List<double> ranges,
    {bool accumulate = false}) {
  using((arena) {
    final matsPtr = src.toMats(arena);
    final channelsPtr = channels.toNativeVector(arena);
    final histPtr = histSize.toNativeVector(arena);
    final rangesPtr = ranges.toNativeVector(arena);
    _bindings.CalcHist(
      matsPtr.ref,
      channelsPtr.ref,
      mask.ptr,
      hist.ptr,
      histPtr.ref,
      rangesPtr.ref,
      accumulate,
    );
  });
}

/// CalcBackProject calculates the back projection of a histogram.
///
/// For futher details, please see:
/// https:///docs.opencv.org/3.4/d6/dc7/group__imgproc__hist.html#ga3a0af640716b456c3d14af8aee12e3ca
void calcBackProject(List<Mat> src, List<int> channels, Mat hist,
    Mat backProject, List<double> ranges,
    {bool uniform = true}) {
  using((arena) {
    final srcPtr = src.toMats(arena);
    final channelsPtr = channels.toNativeVector(arena);
    final rangesPtr = ranges.toNativeVector(arena);
    _bindings.CalcBackProject(
      srcPtr.ref,
      channelsPtr.ref,
      hist.ptr,
      backProject.ptr,
      rangesPtr.ref,
      uniform,
    );
  });
}

/// CompareHist Compares two histograms.
/// mode: HistCompMethods
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#gaf4190090efa5c47cb367cf97a9a519bd
double compareHist(Mat hist1, Mat hist2, {int method = 0}) {
  final result = _bindings.CompareHist(hist1.ptr, hist2.ptr, method);
  return result;
}

/// ClipLine clips the line against the image rectangle.
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf483cb46ad6b049bc35ec67052ef1c2c
bool clipLine(
    (int width, int height) imgSize, (int x, int y) pt1, (int x, int y) pt2) {
  bool r = false;
  using((arena) {
    final size = arena<cvg.Size>()
      ..ref.width = imgSize.$1
      ..ref.height = imgSize.$2;
    final cPt1 = calloc<cvg.Point>()
      ..ref.x = pt1.$1
      ..ref.y = pt1.$2;
    final cPt2 = calloc<cvg.Point>()
      ..ref.x = pt1.$1
      ..ref.y = pt1.$2;
    r = _bindings.ClipLine(size.ref, cPt1.ref, cPt2.ref);
  });
  return r;
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
void bilateralFilter(
    Mat src, Mat dst, int diameter, double sigmaColor, double sigmaSpace) {
  _bindings.BilateralFilter(src.ptr, dst.ptr, diameter, sigmaColor, sigmaSpace);
}

/// Blur blurs an image Mat using a normalized box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga8c45db9afe636703801b0b2e440fce37
void blur(
  Mat src,
  Mat dst,
  ({int width, int height}) ksize,
) {
  using((arena) {
    _bindings.Blur(src.ptr, dst.ptr, ksize.toSize(arena).ref);
  });
}

/// BoxFilter blurs an image using the box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad533230ebf2d42509547d514f7d3fbc3
void boxFilter(Mat src, Mat dst, int depth, ({int width, int height}) ksize) {
  using((arena) {
    _bindings.BoxFilter(src.ptr, dst.ptr, depth, ksize.toSize(arena).ref);
  });
}

/// SqBoxFilter calculates the normalized sum of squares of the pixel values overlapping the filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga045028184a9ef65d7d2579e5c4bff6c0
void sqrBoxFilter(
    Mat src, Mat dst, int depth, ({int width, int height}) ksize) {
  using((arena) {
    _bindings.SqBoxFilter(src.ptr, dst.ptr, depth, ksize.toSize(arena).ref);
  });
}

/// Dilate dilates an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga4ff0f3318642c4f469d0e11f242f3b6c
void dilate(
  Mat src,
  Mat dst,
  Mat kernel, {
  ({int x, int y}) anchor = (x: -1, y: -1),
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  using((arena) {
    final borderValue_ = borderValue ?? Scalar.default_();
    _bindings.DilateWithParams(
      src.ptr,
      dst.ptr,
      kernel.ptr,
      anchor.toPoint(arena).ref,
      iterations,
      borderType,
      borderValue_.ref,
    );
  });
}

/// Erode erodes an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaeb1e0c1033e3f6b891a25d0511362aeb
void erode(
  Mat src,
  Mat dst,
  Mat kernel, {
  ({int x, int y}) anchor = (x: -1, y: -1),
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  using((arena) {
    final borderValue_ = borderValue ?? Scalar.default_();
    _bindings.ErodeWithParams(
      src.ptr,
      dst.ptr,
      kernel.ptr,
      anchor.toPoint(arena).ref,
      iterations,
      borderType,
      borderValue_.ref,
    );
  });
}

/// DistanceTransform Calculates the distance to the closest zero pixel for each pixel of the source image.
///
/// distanceType: DistanceTypes
/// maskSize: DistanceTransformMasks
/// labelType: DistanceTransformLabelTypes
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga8a0b7fdfcb7a13dde018988ba3a43042

void distanceTransform(
  Mat src,
  Mat dst,
  Mat labels,
  int distanceType,
  int maskSize,
  int labelType,
) {
  _bindings.DistanceTransform(
    src.ptr,
    dst.ptr,
    labels.ptr,
    distanceType,
    maskSize,
    labelType,
  );
}

/// BoundingRect calculates the up-right bounding rectangle of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gacb413ddce8e48ff3ca61ed7cf626a366
Rect boundingRect(List<Point> points) {
  final pointVec = points.toNativeVecotr();
  final rect = Rect.fromNative(_bindings.BoundingRect(pointVec));
  _bindings.PointVector_Close(pointVec);
  return rect;
}

/// BoxPoints finds the four vertices of a rotated rect. Useful to draw the rotated rectangle.
///
/// For further Details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gaf78d467e024b4d7936cf9397185d2f5c
void boxPoints(RotatedRect rect, Mat pts) {
  _bindings.BoxPoints(rect.ref, pts.ptr);
}

/// ContourArea calculates a contour area.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#ga2c759ed9f497d4a618048a2f56dc97f1
double contourArea(List<Point> contour) {
  final pointVec = contour.toNativeVecotr();
  final area = _bindings.ContourArea(contour.toNativeVecotr());
  _bindings.PointVector_Close(pointVec);
  return area;
}

/// MinAreaRect finds a rotated rectangle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga3d476a3417130ae5154aea421ca7ead9
RotatedRect minAreaRect(List<Point> points) {
  final pointVec = points.toNativeVecotr();
  final r = _bindings.MinAreaRect(pointVec);
  /* TODO: if we pass r to RotatedRect.fromNative, will r be copied? if copied free r
  `Assigning to ref copies contents of the struct into the native memory starting at address.`
  https:///api.flutter.dev/flutter/dart-ffi/StructPointer/ref.html
  */
  _bindings.PointVector_Close(pointVec);
  return RotatedRect.fromNative(r);
}

/// FitEllipse Fits an ellipse around a set of 2D points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf259efaad93098103d6c27b9e4900ffa
RotatedRect fitEllipse(List<Point> pts) {
  final pointVec = pts.toNativeVecotr();
  final r = _bindings.FitEllipse(pointVec);
  _bindings.PointVector_Close(pointVec);

  final rect = RotatedRect.fromNative(r);

  /// TODO: free?
  return rect;
}

/// MinEnclosingCircle finds a circle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#ga8ce13c24081bbc7151e9326f412190f1
({Point2f center, double radius}) minEnclosingCircle(List<Point> pts) {
  late final Point2f center;
  late final double radius;
  using((arena) {
    final pointVec = pts.toNativeVecotr();
    final _center = arena<cvg.Point2f>();
    final _radius = arena<ffi.Float>();
    _bindings.MinEnclosingCircle(pointVec, _center, _radius);
    _bindings.PointVector_Close(pointVec);

    center = Point2f.fromNative(_center.ref);
    radius = _radius.value;
  });
  return (center: center, radius: radius);
}

/// FindContours finds contours in a binary image.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gadf1ad6a0b82947fa1fe3c3d497f260e0
(Contours contours, Mat hierarchy) findContours(Mat src, int mode, int method) {
  final hierarchy = Mat.empty();
  final _contours =
      _bindings.FindContours(src.ptr, hierarchy.ptr, mode, method);
  final contours = Contours.fromPointer(_contours);
  return (contours, hierarchy);
}

/// PointPolygonTest performs a point-in-contour test.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga1a539e8db2135af2566103705d7a5722
double pointPolygonTest(List<Point> pts, Point2f pt, bool measureDist) {
  final pointVec = pts.toNativeVecotr();
  final r = _bindings.PointPolygonTest(pointVec, pt.toNative(), measureDist);
  _bindings.PointVector_Close(pointVec);
  return r;
}

/// ConnectedComponents computes the connected components labeled image of boolean image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaedef8c7340499ca391d459122e51bef5
int connectedComponents(
  Mat image,
  Mat labels,
  int connectivity,
  int ltype,
  int ccltype,
) {
  return _bindings.ConnectedComponents(
    image.ptr,
    labels.ptr,
    connectivity,
    ltype,
    ccltype,
  );
}

/// ConnectedComponentsWithStats computes the connected components labeled image of boolean
/// image and also produces a statistics output for each label.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga107a78bf7cd25dec05fb4dfc5c9e765f
int connectedComponentsWithStats(
  final Mat src,
  Mat labels,
  Mat stats,
  Mat centroids,
  int connectivity,
  int ltype,
  int ccltype,
) {
  return _bindings.ConnectedComponentsWithStats(
    src.ptr,
    labels.ptr,
    stats.ptr,
    centroids.ptr,
    connectivity,
    ltype,
    ccltype,
  );
}

/// MatchTemplate compares a template against overlapped image regions.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/df/dfb/group__imgproc__object.html#ga586ebfb0a7fb604b35a23d85391329be
void matchTemplate(Mat image, Mat templ, Mat result, int method, {Mat? mask}) {
  mask = mask ?? Mat.empty();
  _bindings.MatchTemplate(image.ptr, templ.ptr, result.ptr, method, mask.ptr);
}

/// Moments calculates all of the moments up to the third order of a polygon
/// or rasterized shape.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga556a180f43cab22649c23ada36a8a139
Moments moments(Mat src, {bool binaryImage = false}) {
  final m = _bindings.Moments(src.ptr, binaryImage);
  return Moments.fromNative(m);
}

/// PyrDown blurs an image and downsamples it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaf9bba239dfca11654cb7f50f889fc2ff
void pyrDown(
  Mat src,
  Mat dst, {
  ({int width, int height}) dstsize = (width: 0, height: 0),
  int borderType = BORDER_CONSTANT,
}) {
  using((arena) {
    _bindings.PyrDown(src.ptr, dst.ptr, dstsize.toSize(arena).ref, borderType);
  });
}

/// PyrUp upsamples an image and then blurs it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gada75b59bdaaca411ed6fee10085eb784
void pyrUp(
  Mat src,
  Mat dst, {
  ({int width, int height}) dstsize = (width: 0, height: 0),
  int borderType = BORDER_CONSTANT,
}) {
  using((arena) {
    _bindings.PyrUp(src.ptr, dst.ptr, dstsize.toSize(arena).ref, borderType);
  });
}

/// MorphologyDefaultBorder returns "magic" border value for erosion and dilation.
/// It is automatically transformed to Scalar::all(-DBL_MAX) for dilation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga94756fad83d9d24d29c9bf478558c40a

cvg.Scalar morphologyDefaultBorderValue() {
  return _bindings.MorphologyDefaultBorderValue();
}

/// MorphologyEx performs advanced morphological transformations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga67493776e3ad1a3df63883829375201f
void morphologyEx(
  Mat src,
  Mat dst,
  int op,
  Mat kernel, {
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,

  /// TODO: Scalar? borderValue,
}) {
  /// borderValue = borderValue ?? Scalar.default_();
  final pt = anchor ?? Point(-1, -1);
  _bindings.MorphologyExWithParams(
    src.ptr,
    dst.ptr,
    op,
    kernel.ptr,
    pt.toNative(),
    iterations,
    borderType,
  );
}

/// GetStructuringElement returns a structuring element of the specified size
/// and shape for morphological operations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac342a1bb6eabf6f55c803b09268e36dc
Mat getStructuringElement(
  int shape,
  ({int width, int height}) ksize, {
  Point? anchor,
}) {
  anchor ??= Point(-1, -1);
  late final Mat result;
  using((p0) {
    final r = _bindings.GetStructuringElement(shape, ksize.toSize(p0).ref);
    result = Mat.fromCMat(r);
  });
  return result;
}

/// GaussianBlur blurs an image Mat using a Gaussian filter.
/// The function convolves the src Mat image into the dst Mat using
/// the specified Gaussian kernel params.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaabe8c836e97159a9193fb0b11ac52cf1
void gaussianBlur(
  Mat src,
  Mat dst,
  ({int width, int height}) ksize,
  double sigmaX, {
  double sigmaY = 0,
  int borderType = BORDER_DEFAULT,
}) {
  using((arena) {
    _bindings.GaussianBlur(
      src.ptr,
      dst.ptr,
      ksize.toSize(arena).ref,
      sigmaX,
      sigmaY,
      borderType,
    );
  });
}

/// GetGaussianKernel returns Gaussian filter coefficients.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac05a120c1ae92a6060dd0db190a61afa
Mat getGaussianKernel(int ksize, double sigma, {int ktype = 6}) {
  final r = _bindings.GetGaussianKernel(ksize, sigma, ktype);
  return Mat.fromCMat(r);
}

/// Sobel calculates the first, second, third, or mixed image derivatives using an extended Sobel operator
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gacea54f142e81b6758cb6f375ce782c8d
void sobel(
  Mat src,
  Mat dst,
  int ddepth,
  int dx,
  int dy, {
  int ksize = 3,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  _bindings.Sobel(
    src.ptr,
    dst.ptr,
    ddepth,
    dx,
    dy,
    ksize,
    scale,
    delta,
    borderType,
  );
}

/// SpatialGradient calculates the first order image derivative in both x and y using a Sobel operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga405d03b20c782b65a4daf54d233239a2
void spatialGradient(
  Mat src,
  Mat dx,
  Mat dy, {
  int ksize = 3,
  int borderType = BORDER_DEFAULT,
}) {
  _bindings.SpatialGradient(src.ptr, dx.ptr, dy.ptr, ksize, borderType);
}

/// Laplacian calculates the Laplacian of an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad78703e4c8fe703d479c1860d76429e6
void Laplacian(
  Mat src,
  Mat dst,
  int ddepth, {
  int ksize = 1,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  _bindings.Laplacian(
    src.ptr,
    dst.ptr,
    ddepth,
    ksize,
    scale,
    delta,
    borderType,
  );
}

/// Scharr calculates the first x- or y- image derivative using Scharr operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaa13106761eedf14798f37aa2d60404c9
void Scharr(
  Mat src,
  Mat dst,
  int ddepth,
  int dx,
  int dy, {
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  _bindings.Scharr(src.ptr, dst.ptr, ddepth, dx, dy, scale, delta, borderType);
}

/// MedianBlur blurs an image using the median filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga564869aa33e58769b4469101aac458f9
void medianBlur(Mat src, OutputArray dst, int ksize) {
  _bindings.MedianBlur(src.ptr, dst.ptr, ksize);
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
void Canny(
  Mat image,
  OutputArray edges,
  double threshold1,
  double threshold2, {
  int apertureSize = 3,

  /// TODO: add
  bool L2gradient = false,
}) {
  _bindings.Canny(image.ptr, edges.ptr, threshold1, threshold2);
}

/// CornerSubPix Refines the corner locations. The function iterates to find
/// the sub-pixel accurate location of corners or radial saddle points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga354e0d7c86d0d9da75de9b9701a9a87e
void cornerSubPix(
  InputArray image,
  InputOutputArray corners,
  ({int width, int height}) winSize,
  ({int width, int height}) zeroZone,
  cvg.TermCriteria criteria,
) {
  using((arena) {
    _bindings.CornerSubPix(
      image.ptr,
      corners.ptr,
      winSize.toSize(arena).ref,
      zeroZone.toSize(arena).ref,
      criteria,
    );
  });
}

/// GoodFeaturesToTrack determines strong corners on an image. The function
/// finds the most prominent corners in the image or in the specified image region.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga1d6bb77486c8f92d79c8793ad995d541
void goodFeaturesToTrack(
  InputArray image,
  OutputArray corners,
  int maxCorners,
  double qualityLevel,
  double minDistance, {
  InputArray? mask,

  /// TODO
  int blockSize = 3,
  bool useHarrisDetector = false,
  double k = 0.04,
}) {
  _bindings.GoodFeaturesToTrack(
    image.ptr,
    corners.ptr,
    maxCorners,
    qualityLevel,
    minDistance,
  );
}

/// Grabcut runs the GrabCut algorithm.
/// The function implements the GrabCut image segmentation algorithm.
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d47/group__imgproc__segmentation.html#ga909c1dda50efcbeaa3ce126be862b37f
void grabCut(
  InputArray img,
  InputOutputArray mask,
  Rect rect,
  InputOutputArray bgdModel,
  InputOutputArray fgdModel,
  int iterCount, {
  int mode = GC_EVAL,
}) {
  _bindings.GrabCut(
    img.ptr,
    mask.ptr,
    rect.ref,
    bgdModel.ptr,
    fgdModel.ptr,
    iterCount,
    mode,
  );
}

/// HoughCircles finds circles in a grayscale image using the Hough transform.
/// The only "method" currently supported is HoughGradient. If you want to pass
/// more parameters, please see `HoughCirclesWithParams`.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga47849c3be0d0406ad3ca45db65a25d2d
void HoughCircles(
  InputArray image,
  OutputArray circles,
  int method,
  double dp,
  double minDist, {
  double param1 = 100,
  double param2 = 100,
  int minRadius = 0,
  int maxRadius = 0,
}) {
  _bindings.HoughCirclesWithParams(
    image.ptr,
    circles.ptr,
    method,
    dp,
    minDist,
    param1,
    param2,
    minRadius,
    maxRadius,
  );
}

/// HoughLines implements the standard or standard multi-scale Hough transform
/// algorithm for line detection. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga46b4e588934f6c8dfd509cc6e0e4545a
void HoughLines(
  InputArray image,
  OutputArray lines,
  double rho,
  double theta,
  int threshold, {
  double srn = 0,

  /// TODO
  double stn = 0,
  double min_theta = 0,
  double max_theta = CV_PI,
}) {
  _bindings.HoughLines(image.ptr, lines.ptr, rho, theta, threshold);
}

/// HoughLinesP implements the probabilistic Hough transform
/// algorithm for line detection. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga8618180a5948286384e3b7ca02f6feeb
void HoughLinesP(
  InputArray image,
  OutputArray lines,
  double rho,
  double theta,
  int threshold, {
  double minLineLength = 0,

  /// TODO
  double maxLineGap = 0,
}) {
  _bindings.HoughLinesPWithParams(
    image.ptr,
    lines.ptr,
    rho,
    theta,
    threshold,
    minLineLength,
    maxLineGap,
  );
}

/// HoughLinesPointSet implements the Hough transform algorithm for line
/// detection on a set of points. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga2858ef61b4e47d1919facac2152a160e
void HoughLinesPointSet(
  InputArray point,
  OutputArray lines,
  int lines_max,
  int threshold,
  double min_rho,
  double max_rho,
  double rho_step,
  double min_theta,
  double max_theta,
  double theta_step,
) {
  _bindings.HoughLinesPointSet(
    point.ptr,
    lines.ptr,
    lines_max,
    threshold,
    min_rho,
    max_rho,
    rho_step,
    min_theta,
    max_theta,
    theta_step,
  );
}

/// Integral calculates one or more integral images for the source image.
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga97b87bec26908237e8ba0f6e96d23e28
void integral(
  InputArray src,
  OutputArray sum,
  OutputArray sqsum,
  OutputArray tilted, {
  int sdepth = -1,

  /// TODO
  int sqdepth = -1,
}) {
  _bindings.Integral(src.ptr, sum.ptr, sqsum.ptr, tilted.ptr);
}

/// Threshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d7/d1b/group__imgproc__misc.html#gae8a4a146d1ca78c626a53577199e9c57
double threshold(
  InputArray src,
  OutputArray dst,
  double thresh,
  double maxval,
  int type,
) {
  return _bindings.Threshold(src.ptr, dst.ptr, thresh, maxval, type);
}

/// AdaptiveThreshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga72b913f352e4a1b1b397736707afcde3
void adaptiveThreshold(
  InputArray src,
  OutputArray dst,
  double maxValue,
  int adaptiveMethod,
  int thresholdType,
  int blockSize,
  double C,
) {
  _bindings.AdaptiveThreshold(
    src.ptr,
    dst.ptr,
    maxValue,
    adaptiveMethod,
    thresholdType,
    blockSize,
    C,
  );
}

/// ArrowedLine draws a arrow segment pointing from the first point
/// to the second one.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga0a165a3ca093fd488ac709fdf10c05b2
void arrowedLine(
  InputOutputArray img,
  Point pt1,
  Point pt2,
  Scalar color, {
  int thickness = 1,
  int line_type = 8,
  int shift = 0,
  double tipLength = 0.1,
}) {
  _bindings.ArrowedLine(
    img.ptr,
    pt1.toNative(),
    pt2.toNative(),
    color.toNative(),
    thickness,
  );
}

/// CircleWithParams draws a circle.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf10604b069374903dbd0f0488cb43670
void circle(
  InputOutputArray img,
  Point center,
  int radius,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  _bindings.CircleWithParams(
    img.ptr,
    center.toNative(),
    radius,
    color.toNative(),
    thickness,
    lineType,
    shift,
  );
}

/// Ellipse draws a simple or thick elliptic arc or fills an ellipse sector.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga28b2267d35786f5f890ca167236cbc69
void ellipse(
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
  _bindings.Ellipse(
    img.ptr,
    center.toNative(),
    axes.toNative(),
    angle,
    startAngle,
    endAngle,
    color.toNative(),
    thickness,
  );
}

/// Line draws a line segment connecting two points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga7078a9fae8c7e7d13d24dac2520ae4a2
void line(
  InputOutputArray img,
  Point pt1,
  Point pt2,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  _bindings.Line(
    img.ptr,
    pt1.toNative(),
    pt2.toNative(),
    color.toNative(),
    thickness,
  );
}

/// Rectangle draws a simple, thick, or filled up-right rectangle.
/// It renders a rectangle with the desired characteristics to the target Mat image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga07d2f74cadcf8e305e810ce8eed13bc9
void rectangle(
  InputOutputArray img,
  Rect rect,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  _bindings.RectangleWithParams(
    img.ptr,
    rect.toNative(),
    color.toNative(),
    thickness,
    lineType,
    shift,
  );
}

/// FillPolyWithParams fills the area bounded by one or more polygons.
///
/// For more information, see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf30888828337aa4c6b56782b5dfbd4b7
void fillPoly(
  InputOutputArray img,
  List<List<Point>> pts,
  Scalar color, {
  int lineType = LINE_8,
  int shift = 0,
  Point? offset,
}) {
  offset ??= Point(0, 0);
  final pointsVec = pts.toNativeVector();
  _bindings.FillPolyWithParams(
    img.ptr,
    pointsVec,
    color.toNative(),
    lineType,
    shift,
    offset.toNative(),
  );
  _bindings.PointsVector_Close(pointsVec);
}

/// Polylines draws several polygonal curves.
///
/// For more information, see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga1ea127ffbbb7e0bfc4fd6fd2eb64263c
void polylines(
  InputOutputArray img,
  List<List<Point>> pts,
  bool isClosed,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) {
  final pointsVec = pts.toNativeVector();
  _bindings.Polylines(
    img.ptr,
    pointsVec,
    isClosed,
    color.toNative(),
    thickness,
  );
  _bindings.PointsVector_Close(pointsVec);
}

/// GetTextSizeWithBaseline calculates the width and height of a text string including the basline of the text.
/// It returns an image.Point with the size required to draw text using
/// a specific font face, scale, and thickness as well as its baseline.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga3d2abfcb995fd2db908c8288199dba82
({Size size, int baseline}) getTextSize(
  String text,
  int fontFace,
  double fontScale,
  int thickness,
) {
  final _baseline = calloc<ffi.Int>();
  final textPtr = text.toNativeUtf8();

  final _size = _bindings.GetTextSizeWithBaseline(
    textPtr.cast(),
    fontFace,
    fontScale,
    thickness,
    _baseline,
  );

  Size sz = (width: _size.width, height: _size.height);
  final result = (size: sz, baseline: _baseline.value);

  calloc.free(_baseline);
  calloc.free(textPtr);

  return result;
}

/// PutTextWithParams draws a text string.
/// It renders the specified text string into the img Mat at the location
/// passed in the "org" param, using the desired font face, font scale,
/// color, and line thinkness.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga5126f47f883d730f633d74f07456c576
void putText(
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
  final textPtr = text.toNativeUtf8();
  _bindings.PutTextWithParams(
    img.ptr,
    textPtr.cast(),
    org.toNative(),
    fontFace,
    fontScale,
    color.toNative(),
    thickness,
    lineType,
    bottomLeftOrigin,
  );
  calloc.free(textPtr);
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
void resize(
  InputArray src,
  OutputArray dst,
  Size dsize, {
  double fx = 0,
  double fy = 0,
  int interpolation = INTER_LINEAR,
}) {
  using((arena) {
    _bindings.Resize(
      src.ptr,
      dst.ptr,
      dsize.toSize(arena).ref,
      fx,
      fy,
      interpolation,
    );
  });
}

/// GetRectSubPix retrieves a pixel rectangle from an image with sub-pixel accuracy.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga77576d06075c1a4b6ba1a608850cd614
void getRectSubPix(
  InputArray image,
  Size patchSize,
  Point2f center,
  OutputArray patch, {
  int patchType = -1,
}) {
  using((arena) {
    _bindings.GetRectSubPix(
      image.ptr,
      patchSize.toSize(arena).ref,
      center.toNative(),
      patch.ptr,
    );
  });
}

/// GetRotationMatrix2D calculates an affine matrix of 2D rotation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gafbbc470ce83812914a70abfb604f4326
Mat getRotationMatrix2D(Point2f center, double angle, double scale) {
  final mat = _bindings.GetRotationMatrix2D(center.toNative(), angle, scale);
  return Mat.fromCMat(mat);
}

/// WarpAffine applies an affine transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga0203d9ee5fcd28d40dbc4a1ea4451983
void warpAffine(
  InputArray src,
  OutputArray dst,
  InputArray M,
  Size dsize, {
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  using((arena) {
    borderValue ??= Scalar.default_();
    _bindings.WarpAffineWithParams(
      src.ptr,
      dst.ptr,
      M.ptr,
      dsize.toSize(arena).ref,
      flags,
      borderMode,
      borderValue!.ref,
    );
  });
}

/// WarpPerspective applies a perspective transformation to an image.
/// For more parameters please check WarpPerspectiveWithParams.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaf73673a7e8e18ec6963e3774e6a94b87
void warpPerspective(
  InputArray src,
  OutputArray dst,
  InputArray M,
  Size dsize, {
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar.default_();
  using((arena) {
    _bindings.WarpPerspectiveWithParams(
      src.ptr,
      dst.ptr,
      M.ptr,
      dsize.toSize(arena).ref,
      flags,
      borderMode,
      borderValue!.ref,
    );
  });
}

/// Watershed performs a marker-based image segmentation using the watershed algorithm.
///
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/d47/group__imgproc__segmentation.html#ga3267243e4d3f95165d55a618c65ac6e1
void watershed(InputArray image, InputOutputArray markers) {
  _bindings.Watershed(image.ptr, markers.ptr);
}

/// ApplyColorMap applies a GNU Octave/MATLAB equivalent colormap on a given image.
/// colormap: ColormapTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gadf478a5e5ff49d8aa24e726ea6f65d15
void applyColorMap(InputArray src, OutputArray dst, int colormap) {
  _bindings.ApplyColorMap(src.ptr, dst.ptr, colormap);
}

/// ApplyCustomColorMap applies a custom defined colormap on a given image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gacb22288ddccc55f9bd9e6d492b409cae
void applyCustomColorMap(
  InputArray src,
  OutputArray dst,
  InputArray userColor,
) {
  _bindings.ApplyCustomColorMap(src.ptr, dst.ptr, userColor.ptr);
}

/// GetPerspectiveTransform returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Mat getPerspectiveTransform(
  List<Point> src,
  List<Point> dst, {
  int solveMethod = DECOMP_LU,

  /// TODO
}) {
  final srcVec = src.toNativeVecotr();
  final dstVec = dst.toNativeVecotr();
  final mat = _bindings.GetPerspectiveTransform(srcVec, dstVec);
  _bindings.PointVector_Close(srcVec);
  _bindings.PointVector_Close(dstVec);
  return Mat.fromCMat(mat);
}

/// GetPerspectiveTransform2f returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as gocv.Point2f.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Mat getPerspectiveTransform2f(
  List<Point2f> src,
  List<Point2f> dst, {
  int solveMethod = DECOMP_LU,

  /// TODO
}) {
  final srcVec = src.toNativeVecotr();
  final dstVec = dst.toNativeVecotr();
  final mat = _bindings.GetPerspectiveTransform2f(srcVec, dstVec);
  _bindings.PointVector_Close(srcVec);
  _bindings.PointVector_Close(dstVec);
  return Mat.fromCMat(mat);
}

/// GetAffineTransform returns a 2x3 affine transformation matrix for the
/// corresponding 3 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8f6d378f9f8eebb5cb55cd3ae295a999
Mat getAffineTransform(List<Point> src, List<Point> dst) {
  final srcVec = src.toNativeVecotr();
  final dstVec = dst.toNativeVecotr();
  final mat = _bindings.GetAffineTransform(srcVec, dstVec);
  _bindings.PointVector_Close(srcVec);
  _bindings.PointVector_Close(dstVec);
  return Mat.fromCMat(mat);
}

Mat getAffineTransform2f(
  List<Point2f> src,
  List<Point2f> dst,
) {
  final srcVec = src.toNativeVecotr();
  final dstVec = dst.toNativeVecotr();
  final mat = _bindings.GetAffineTransform2f(srcVec, dstVec);
  _bindings.PointVector_Close(srcVec);
  _bindings.PointVector_Close(dstVec);
  return Mat.fromCMat(mat);
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
  final mat = _bindings.FindHomography(
    srcPoints.ptr,
    dstPoints.ptr,
    method,
    ransacReprojThreshold,
    mask == null ? _bindings.Mat_New() : mask.ptr,
    maxIters,
    confidence,
  );
  return Mat.fromCMat(mat);
}

/// DrawContours draws contours outlines or filled contours.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga746c0625f1781f1ffc9056259103edbc
void drawContours(
  InputOutputArray image,
  Contours contours,
  int contourIdx,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  InputArray? hierarchy,
  int maxLevel = 0x3f3f3f3f,
  Point? offset,
}) {
  offset ??= Point(0, 0);
  hierarchy ??= Mat.empty();
  _bindings.DrawContoursWithParams(
    image.ptr,
    contours.ptr,
    contourIdx,
    color.ref,
    thickness,
    lineType,
    hierarchy.ptr,
    maxLevel,
    offset.ref,
  );
}

/// Remap applies a generic geometrical transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gab75ef31ce5cdfb5c44b6da5f3b908ea4
void remap(
  InputArray src,
  OutputArray dst,
  InputArray map1,
  InputArray map2,
  int interpolation, {
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar.default_();
  _bindings.Remap(
    src.ptr,
    dst.ptr,
    map1.ptr,
    map2.ptr,
    interpolation,
    borderMode,
    borderValue.ref,
  );
}

/// Filter2D applies an arbitrary linear filter to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga27c049795ce870216ddfb366086b5a04
void filter2D(
  InputArray src,
  OutputArray dst,
  int ddepth,
  InputArray kernel, {
  Point? anchor,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  anchor ??= Point(-1, -1);
  _bindings.Filter2D(
    src.ptr,
    dst.ptr,
    ddepth,
    kernel.ptr,
    anchor.ref,
    delta,
    borderType,
  );
}

/// SepFilter2D applies a separable linear filter to the image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga910e29ff7d7b105057d1625a4bf6318d
void sepFilter2D(
  InputArray src,
  OutputArray dst,
  int ddepth,
  InputArray kernelX,
  InputArray kernelY, {
  Point? anchor,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  anchor ??= Point(-1, -1);
  _bindings.SepFilter2D(
    src.ptr,
    dst.ptr,
    ddepth,
    kernelX.ptr,
    kernelY.ptr,
    anchor.ref,
    delta,
    borderType,
  );
}

/// LogPolar remaps an image to semilog-polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaec3a0b126a85b5ca2c667b16e0ae022d
void logPolar(
  InputArray src,
  OutputArray dst,
  Point2f center,
  double M,
  int flags,
) {
  _bindings.LogPolar(
    src.ptr,
    dst.ptr,
    center.ref,
    M,
    flags,
  );
}

/// LinearPolar remaps an image to polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaa38a6884ac8b6e0b9bed47939b5362f3
void linearPolar(
  InputArray src,
  OutputArray dst,
  Point2f center,
  double maxRadius,
  int flags,
) {
  _bindings.LinearPolar(src.ptr, dst.ptr, center.ref, maxRadius, flags);
}

/// FitLine fits a line to a 2D or 3D point set.
/// distType: DistanceTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf849da1fdafa67ee84b1e9a23b93f91f
void fitLine(
  List<Point> points,
  OutputArray line,
  int distType,
  double param,
  double reps,
  double aeps,
) {
  final pv = points.toNativeVecotr();
  _bindings.FitLine(pv, line.ptr, distType, param, reps, aeps);
  _bindings.PointVector_Close(pv);
}

/// Compares two shapes.
/// method: ShapeMatchModes
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gaadc90cb16e2362c9bd6e7363e6e4c317
double matchShapes(
  List<Point> contour1,
  List<Point> contour2,
  int method,
  double parameter,
) {
  final pv1 = contour1.toNativeVecotr();
  final pv2 = contour2.toNativeVecotr();
  final r = _bindings.MatchShapes(pv1, pv2, method, parameter);
  _bindings.PointVector_Close(pv1);
  _bindings.PointVector_Close(pv2);
  return r;
}

/// NewCLAHE returns a new CLAHE algorithm
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html
/// TODO: finish below

/// NewCLAHEWithParams returns a new CLAHE algorithm
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html

/// Apply CLAHE.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html#a4e92e0e427de21be8d1fae8dcd862c5e
/// void CLAHE_apply(InputArray src, OutputArray dst) {}

/// Apply phaseCorrelate.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga552420a2ace9ef3fb053cd630fdb4952

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga1a567a79901513811ff3b9976923b199
///
void accumulate(InputArray src, InputOutputArray dst, {InputArray? mask}) {
  if (mask == null)
    _bindings.Mat_Accumulate(src.ptr, dst.ptr);
  else
    _bindings.Mat_AccumulateWithMask(src.ptr, dst.ptr, mask.ptr);
}

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#gacb75e7ffb573227088cef9ceaf80be8c
void accumulateSquare(InputArray src, InputOutputArray dst,
    {InputArray? mask}) {
  if (mask == null)
    _bindings.Mat_AccumulateSquare(src.ptr, dst.ptr);
  else
    _bindings.Mat_AccumulateSquareWithMask(src.ptr, dst.ptr, mask.ptr);
}

/// Adds the per-element product of two input images to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga82518a940ecfda49460f66117ac82520
void accumulateProduct(
    InputArray src1, InputArray src2, InputOutputArray dst, InputArray? mask) {
  if (mask == null)
    _bindings.Mat_AccumulateProduct(src1.ptr, src2.ptr, dst.ptr);
  else
    _bindings.Mat_AccumulateProductWithMask(
        src1.ptr, src2.ptr, dst.ptr, mask.ptr);
}

/// Updates a running average.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga4f9552b541187f61f6818e8d2d826bc7
void accumulateWeighted(
    InputArray src, InputOutputArray dst, double alpha, InputArray? mask) {
  if (mask == null)
    _bindings.Mat_AccumulatedWeighted(src.ptr, dst.ptr, alpha);
  else
    _bindings.Mat_AccumulatedWeightedWithMask(
        src.ptr, dst.ptr, alpha, mask.ptr);
}
