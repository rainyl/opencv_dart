// ignore_for_file: non_constant_identifier_names

library cv;

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';

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
import '../g/constants.g.dart';
import '../g/imgproc.g.dart' as cvg;
import '../native_lib.dart' show cimgproc;

/// ApproxPolyDP approximates a polygonal curve(s) with the specified precision.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga0012a5fdaea70b8a9970165d98722b4c
Future<VecPoint> approxPolyDPAsync(VecPoint curve, double epsilon, bool closed) async => cvRunAsync(
      (callback) => cimgproc.ApproxPolyDP_Async(curve.ref, epsilon, closed, callback),
      vecPointCompleter,
    );

/// ArcLength calculates a contour perimeter or a curve length.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga8d26483c636be6b35c3ec6335798a47c
Future<double> arcLengthAsync(VecPoint curve, bool closed) async =>
    cvRunAsync((callback) => cimgproc.ArcLength_Async(curve.ref, closed, callback), doubleCompleter);

/// ConvexHull finds the convex hull of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga014b28e56cb8854c0de4a211cb2be656
Future<Mat> convexHullAsync(
  VecPoint points, {
  Mat? hull,
  bool clockwise = false,
  bool returnPoints = true,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.ConvexHull_Async(points.ref, clockwise, returnPoints, callback),
      matCompleter,
    );

/// ConvexityDefects finds the convexity defects of a contour.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gada4437098113fd8683c932e0567f47ba
Future<Mat> convexityDefectsAsync(VecPoint contour, Mat hull, {Mat? convexityDefects}) async =>
    cvRunAsync((callback) => cimgproc.ConvexityDefects_Async(contour.ref, hull.ref, callback), matCompleter);

/// CvtColor converts an image from one color space to another.
/// It converts the src Mat image to the dst Mat using the
/// code param containing the desired ColorConversionCode color space.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga4e0972be5de079fed4e3a10e24ef5ef0
Future<Mat> cvtColorAsync(Mat src, int code) async =>
    cvRunAsync<Mat>((callback) => cimgproc.CvtColor_Async(src.ref, code, callback), matCompleter);

/// EqualizeHist Equalizes the histogram of a grayscale image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga7e54091f0c937d49bf84152a16f76d6e
Future<Mat> equalizeHistAsync(Mat src) async {
  assert(src.channels == 1, "src must be grayscale");
  return cvRunAsync<Mat>((callback) => cimgproc.EqualizeHist_Async(src.ref, callback), matCompleter);
}

/// CalcHist Calculates a histogram of a set of images
///
/// For futher details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga6ca1876785483836f72a77ced8ea759a
Future<Mat> calcHistAsync(
  VecMat src,
  VecI32 channels,
  Mat mask,
  VecI32 histSize,
  VecF32 ranges, {
  bool accumulate = false,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.CalcHist_Async(
        src.ref,
        channels.ref,
        mask.ref,
        histSize.ref,
        ranges.ref,
        accumulate,
        callback,
      ),
      matCompleter,
    );

/// CalcBackProject calculates the back projection of a histogram.
///
/// For futher details, please see:
/// https://docs.opencv.org/4.10.0/d6/dc7/group__imgproc__hist.html#gab644bc90e7475cc047aa1b25dbcbd8df
Future<Mat> calcBackProjectAsync(
  VecMat src,
  VecI32 channels,
  Mat hist,
  VecF32 ranges, {
  double scale = 1.0,
}) async =>
    cvRunAsync(
      (callback) =>
          cimgproc.CalcBackProject_Async(src.ref, channels.ref, hist.ref, ranges.ref, scale, callback),
      matCompleter,
    );

/// CompareHist Compares two histograms.
/// mode: HistCompMethods
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#gaf4190090efa5c47cb367cf97a9a519bd
Future<double> compareHistAsync(Mat hist1, Mat hist2, {int method = 0}) async => cvRunAsync(
      (callback) => cimgproc.CompareHist_Async(hist1.ref, hist2.ref, method, callback),
      doubleCompleter,
    );

/// ClipLine clips the line against the image rectangle.
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf483cb46ad6b049bc35ec67052ef1c2c
Future<(bool, Point, Point)> clipLineAsync(Rect imgRect, Point pt1, Point pt2) async =>
    cvRunAsync((callback) => cimgproc.ClipLine_Async(imgRect.ref, pt1.ref, pt2.ref, callback),
        (completer, p) {
      final success = p.cast<ffi.Bool>().value;
      calloc.free(p);
      completer.complete((success, pt1, pt2));
    });

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
Future<Mat> bilateralFilterAsync(Mat src, int diameter, double sigmaColor, double sigmaSpace) async =>
    cvRunAsync(
      (callback) => cimgproc.BilateralFilter_Async(src.ref, diameter, sigmaColor, sigmaSpace, callback),
      matCompleter,
    );

/// Blur blurs an image Mat using a normalized box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga8c45db9afe636703801b0b2e440fce37
Future<Mat> blurAsync(Mat src, (int, int) ksize) async =>
    cvRunAsync((callback) => cimgproc.Blur_Async(src.ref, ksize.cvd.ref, callback), matCompleter);

/// BoxFilter blurs an image using the box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad533230ebf2d42509547d514f7d3fbc3
Future<Mat> boxFilterAsync(Mat src, int depth, (int, int) ksize) async =>
    cvRunAsync((callback) => cimgproc.BoxFilter_Async(src.ref, depth, ksize.cvd.ref, callback), matCompleter);

/// SqBoxFilter calculates the normalized sum of squares of the pixel values overlapping the filter.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d4/d86/group__imgproc__filter.html#ga76e863e7869912edbe88321253b72688
Future<Mat> sqrBoxFilterAsync(Mat src, int depth, (int, int) ksize) async => cvRunAsync(
    (callback) => cimgproc.SqBoxFilter_Async(src.ref, depth, ksize.cvd.ref, callback), matCompleter);

/// Dilate dilates an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga4ff0f3318642c4f469d0e11f242f3b6c
Future<Mat> dilateAsync(
  Mat src,
  Mat kernel, {
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.DilateWithParams_Async(
        src.ref,
        kernel.ref,
        anchor?.ref ?? Point(-1, -1).ref,
        iterations,
        borderType,
        borderValue?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// Erode erodes an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaeb1e0c1033e3f6b891a25d0511362aeb
Future<Mat> erodeAsync(
  Mat src,
  Mat kernel, {
  Mat? dst,
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.ErodeWithParams_Async(
        src.ref,
        kernel.ref,
        anchor?.ref ?? Point(-1, -1).ref,
        iterations,
        borderType,
        borderValue?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// DistanceTransform Calculates the distance to the closest zero pixel for each pixel of the source image.
///
/// distanceType: DistanceTypes
/// maskSize: DistanceTransformMasks
/// labelType: DistanceTransformLabelTypes
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga8a0b7fdfcb7a13dde018988ba3a43042

Future<(Mat dst, Mat labels)> distanceTransformAsync(
  Mat src,
  int distanceType,
  int maskSize,
  int labelType,
) async =>
    cvRunAsync2(
      (callback) => cimgproc.DistanceTransform_Async(src.ref, distanceType, maskSize, labelType, callback),
      matCompleter2,
    );

/// BoundingRect calculates the up-right bounding rectangle of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gacb413ddce8e48ff3ca61ed7cf626a366
Future<Rect> boundingRectAsync(VecPoint points) async =>
    cvRunAsync((callback) => cimgproc.BoundingRect_Async(points.ref, callback), rectCompleter);

/// BoxPoints finds the four vertices of a rotated rect. Useful to draw the rotated rectangle.
///
/// return: [bottom left, top left, top right, bottom right]
/// For further Details, please see:
/// https://docs.opencv.org/4.10.0/d3/dc0/group__imgproc__shape.html#gaf78d467e024b4d7936cf9397185d2f5c
Future<VecPoint2f> boxPointsAsync(RotatedRect rect) async =>
    cvRunAsync((callback) => cimgproc.BoxPoints_Async(rect.ref, callback), vecPoint2fCompleter);

/// ContourArea calculates a contour area.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#ga2c759ed9f497d4a618048a2f56dc97f1
Future<double> contourAreaAsync(VecPoint contour) async =>
    cvRunAsync((callback) => cimgproc.ContourArea_Async(contour.ref, callback), doubleCompleter);

/// MinAreaRect finds a rotated rectangle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga3d476a3417130ae5154aea421ca7ead9
Future<RotatedRect> minAreaRectAsync(VecPoint points) async =>
    cvRunAsync((callback) => cimgproc.MinAreaRect_Async(points.ref, callback), rotatedRectCompleter);

/// FitEllipse Fits an ellipse around a set of 2D points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf259efaad93098103d6c27b9e4900ffa
Future<RotatedRect> fitEllipseAsync(VecPoint points) async =>
    cvRunAsync((callback) => cimgproc.FitEllipse_Async(points.ref, callback), rotatedRectCompleter);

/// MinEnclosingCircle finds a circle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#ga8ce13c24081bbc7151e9326f412190f1
Future<(Point2f center, double radius)> minEnclosingCircleAsync(VecPoint points) async =>
    cvRunAsync2((callback) => cimgproc.MinEnclosingCircle_Async(points.ref, callback), (completer, p, p1) {
      final radius = p1.cast<ffi.Float>().value;
      calloc.free(p1);
      completer.complete((Point2f.fromPointer(p.cast()), radius));
    });

/// FindContours finds contours in a binary image.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gadf1ad6a0b82947fa1fe3c3d497f260e0
Future<(Contours contours, Mat hierarchy)> findContoursAsync(Mat src, int mode, int method) async =>
    cvRunAsync2(
      (callback) => cimgproc.FindContours_Async(src.ref, mode, method, callback),
      (c, p, p1) =>
          c.complete((Contours.fromPointer(p.cast<cvg.VecVecPoint>()), Mat.fromPointer(p1.cast<cvg.Mat>()))),
    );

/// PointPolygonTest performs a point-in-contour test.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga1a539e8db2135af2566103705d7a5722
Future<double> pointPolygonTestAsync(VecPoint points, Point2f pt, bool measureDist) async => cvRunAsync(
      (callback) => cimgproc.PointPolygonTest_Async(points.ref, pt.ref, measureDist, callback),
      doubleCompleter,
    );

/// ConnectedComponents computes the connected components labeled image of boolean image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaedef8c7340499ca391d459122e51bef5
Future<(int rval, Mat labels)> connectedComponentsAsync(
  Mat image,
  int connectivity,
  int ltype,
  int ccltype,
) async =>
    cvRunAsync2(
        (callback) => cimgproc.ConnectedComponents_Async(image.ref, connectivity, ltype, ccltype, callback),
        (completer, p, p1) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      completer.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

/// ConnectedComponentsWithStats computes the connected components labeled image of boolean
/// image and also produces a statistics output for each label.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga107a78bf7cd25dec05fb4dfc5c9e765f
Future<(int rval, Mat labels, Mat stats, Mat centroids)> connectedComponentsWithStatsAsync(
  Mat src,
  int connectivity,
  int ltype,
  int ccltype,
) async =>
    cvRunAsync4(
      (callback) =>
          cimgproc.ConnectedComponentsWithStats_Async(src.ref, connectivity, ltype, ccltype, callback),
      (completer, p, p1, p2, p3) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        final labels = Mat.fromPointer(p1.cast<cvg.Mat>());
        final stats = Mat.fromPointer(p2.cast<cvg.Mat>());
        final centroids = Mat.fromPointer(p3.cast<cvg.Mat>());
        completer.complete((rval, labels, stats, centroids));
      },
    );

/// MatchTemplate compares a template against overlapped image regions.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/df/dfb/group__imgproc__object.html#ga586ebfb0a7fb604b35a23d85391329be
Future<Mat> matchTemplateAsync(Mat image, Mat templ, int method, {Mat? mask}) async => cvRunAsync(
      (callback) =>
          cimgproc.MatchTemplate_Async(image.ref, templ.ref, method, mask?.ref ?? Mat.empty().ref, callback),
      matCompleter,
    );

/// Moments calculates all of the moments up to the third order of a polygon
/// or rasterized shape.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga556a180f43cab22649c23ada36a8a139
Future<Moments> momentsAsync(Mat src, {bool binaryImage = false}) async =>
    cvRunAsync((callback) => cimgproc.Moments_Async(src.ref, binaryImage, callback), momentsCompleter);

/// PyrDown blurs an image and downsamples it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaf9bba239dfca11654cb7f50f889fc2ff
Future<Mat> pyrDownAsync(
  Mat src, {
  (int, int) dstsize = (0, 0),
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.PyrDown_Async(src.ref, dstsize.cvd.ref, borderType, callback),
      matCompleter,
    );

/// PyrUp upsamples an image and then blurs it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gada75b59bdaaca411ed6fee10085eb784
Future<Mat> pyrUpAsync(
  Mat src, {
  Mat? dst,
  (int, int) dstsize = (0, 0),
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.PyrUp_Async(src.ref, dstsize.cvd.ref, borderType, callback),
      matCompleter,
    );

/// MorphologyDefaultBorder returns "magic" border value for erosion and dilation.
/// It is automatically transformed to Scalar::all(-DBL_MAX) for dilation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga94756fad83d9d24d29c9bf478558c40a
Future<Scalar> morphologyDefaultBorderValueAsync() async =>
    cvRunAsync(cimgproc.MorphologyDefaultBorderValue_Async, scalarCompleter);

/// MorphologyEx performs advanced morphological transformations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga67493776e3ad1a3df63883829375201f
Future<Mat> morphologyExAsync(
  Mat src,
  int op,
  Mat kernel, {
  Mat? dst,
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.MorphologyExWithParams_Async(
        src.ref,
        op,
        kernel.ref,
        anchor?.ref ?? Point(-1, -1).ref,
        iterations,
        borderType,
        borderValue?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// GetStructuringElement returns a structuring element of the specified size
/// and shape for morphological operations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac342a1bb6eabf6f55c803b09268e36dc
Future<Mat> getStructuringElementAsync(int shape, (int, int) ksize, {Point? anchor}) async => cvRunAsync(
      (callback) => cimgproc.GetStructuringElement_Async(
          shape, ksize.cvd.ref, anchor?.ref ?? Point(-1, -1).ref, callback),
      matCompleter,
    );

/// GaussianBlur blurs an image Mat using a Gaussian filter.
/// The function convolves the src Mat image into the dst Mat using
/// the specified Gaussian kernel params.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaabe8c836e97159a9193fb0b11ac52cf1
Future<Mat> gaussianBlurAsync(
  Mat src,
  (int, int) ksize,
  double sigmaX, {
  Mat? dst,
  double sigmaY = 0,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.GaussianBlur_Async(src.ref, ksize.cvd.ref, sigmaX, sigmaY, borderType, callback),
      matCompleter,
    );

/// GetGaussianKernel returns Gaussian filter coefficients.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac05a120c1ae92a6060dd0db190a61afa
Future<Mat> getGaussianKernelAsync(int ksize, double sigma, {int ktype = 6}) async =>
    cvRunAsync((callback) => cimgproc.GetGaussianKernel_Async(ksize, sigma, ktype, callback), matCompleter);

/// Sobel calculates the first, second, third, or mixed image derivatives using an extended Sobel operator
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gacea54f142e81b6758cb6f375ce782c8d
Future<Mat> sobelAsync(
  Mat src,
  int ddepth,
  int dx,
  int dy, {
  int ksize = 3,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.Sobel_Async(src.ref, ddepth, dx, dy, ksize, scale, delta, borderType, callback),
      matCompleter,
    );

/// SpatialGradient calculates the first order image derivative in both x and y using a Sobel operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga405d03b20c782b65a4daf54d233239a2
Future<(Mat dx, Mat dy)> spatialGradientAsync(
  Mat src, {
  int ksize = 3,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync2(
      (callback) => cimgproc.SpatialGradient_Async(src.ref, ksize, borderType, callback),
      matCompleter2,
    );

/// Laplacian calculates the Laplacian of an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad78703e4c8fe703d479c1860d76429e6
Future<Mat> laplacianAsync(
  Mat src,
  int ddepth, {
  int ksize = 1,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.Laplacian_Async(src.ref, ddepth, ksize, scale, delta, borderType, callback),
      matCompleter,
    );

/// Scharr calculates the first x- or y- image derivative using Scharr operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaa13106761eedf14798f37aa2d60404c9
Future<Mat> scharrAsync(
  Mat src,
  int ddepth,
  int dx,
  int dy, {
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.Scharr_Async(src.ref, ddepth, dx, dy, scale, delta, borderType, callback),
      matCompleter,
    );

/// MedianBlur blurs an image using the median filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga564869aa33e58769b4469101aac458f9
Future<Mat> medianBlurAsync(Mat src, int ksize) async =>
    cvRunAsync((callback) => cimgproc.MedianBlur_Async(src.ref, ksize, callback), matCompleter);

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
Future<Mat> cannyAsync(
  Mat image,
  double threshold1,
  double threshold2, {
  int apertureSize = 3,
  bool l2gradient = false,
}) async =>
    cvRunAsync(
      (callback) =>
          cimgproc.Canny_Async(image.ref, threshold1, threshold2, apertureSize, l2gradient, callback),
      matCompleter,
    );

/// CornerSubPix Refines the corner locations. The function iterates to find
/// the sub-pixel accurate location of corners or radial saddle points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga354e0d7c86d0d9da75de9b9701a9a87e
Future<VecPoint2f> cornerSubPixAsync(
  InputArray image,
  VecPoint2f corners,
  (int, int) winSize,
  (int, int) zeroZone, [
  (int, int, double) criteria = (TERM_COUNT + TERM_EPS, 30, 1e-4),
]) async =>
    cvRunAsync0(
      (callback) => cimgproc.CornerSubPix_Async(
        image.ref,
        corners.ref,
        winSize.cvd.ref,
        zeroZone.cvd.ref,
        criteria.cvd.ref,
        callback,
      ),
      (completer) => completer.complete(corners),
    );

/// GoodFeaturesToTrack determines strong corners on an image. The function
/// finds the most prominent corners in the image or in the specified image region.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga1d6bb77486c8f92d79c8793ad995d541
Future<VecPoint2f> goodFeaturesToTrackAsync(
  InputArray image,
  int maxCorners,
  double qualityLevel,
  double minDistance, {
  InputArray? mask,
  int blockSize = 3,
  int? gradientSize,
  bool useHarrisDetector = false,
  double k = 0.04,
}) async =>
    gradientSize == null
        ? cvRunAsync(
            (callback) => cimgproc.GoodFeaturesToTrack_Async(
              image.ref,
              maxCorners,
              qualityLevel,
              minDistance,
              mask?.ref ?? Mat.empty().ref,
              blockSize,
              useHarrisDetector,
              k,
              callback,
            ),
            vecPoint2fCompleter,
          )
        : cvRunAsync(
            (callback) => cimgproc.GoodFeaturesToTrackWithGradient_Async(
              image.ref,
              maxCorners,
              qualityLevel,
              minDistance,
              mask?.ref ?? Mat.empty().ref,
              blockSize,
              gradientSize,
              useHarrisDetector,
              k,
              callback,
            ),
            vecPoint2fCompleter,
          );

/// Grabcut runs the GrabCut algorithm.
/// The function implements the GrabCut image segmentation algorithm.
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d47/group__imgproc__segmentation.html#ga909c1dda50efcbeaa3ce126be862b37f
Future<(Mat mask, Mat bgdModel, Mat fgdModel)> grabCutAsync(
  InputArray img,
  InputOutputArray mask,
  Rect rect,
  InputOutputArray bgdModel,
  InputOutputArray fgdModel,
  int iterCount, {
  int mode = GC_EVAL,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.GrabCut_Async(
        img.ref,
        mask.ref,
        rect.ref,
        bgdModel.ref,
        fgdModel.ref,
        iterCount,
        mode,
        callback,
      ),
      (completer) => completer.complete((mask, bgdModel, fgdModel)),
    );

/// HoughCircles finds circles in a grayscale image using the Hough transform.
/// The only "method" currently supported is HoughGradient. If you want to pass
/// more parameters, please see `HoughCirclesWithParams`.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga47849c3be0d0406ad3ca45db65a25d2d
Future<Mat> HoughCirclesAsync(
  InputArray image,
  int method,
  double dp,
  double minDist, {
  double param1 = 100,
  double param2 = 100,
  int minRadius = 0,
  int maxRadius = 0,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.HoughCirclesWithParams_Async(
        image.ref,
        method,
        dp,
        minDist,
        param1,
        param2,
        minRadius,
        maxRadius,
        callback,
      ),
      matCompleter,
    );

/// HoughLines implements the standard or standard multi-scale Hough transform
/// algorithm for line detection. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga46b4e588934f6c8dfd509cc6e0e4545a
Future<Mat> HoughLinesAsync(
  InputArray image,
  double rho,
  double theta,
  int threshold, {
  double srn = 0,
  double stn = 0,
  double min_theta = 0,
  double max_theta = CV_PI,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.HoughLines_Async(
          image.ref, rho, theta, threshold, srn, stn, min_theta, max_theta, callback),
      matCompleter,
    );

/// HoughLinesP implements the probabilistic Hough transform
/// algorithm for line detection. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// http:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga8618180a5948286384e3b7ca02f6feeb
Future<Mat> HoughLinesPAsync(
  InputArray image,
  double rho,
  double theta,
  int threshold, {
  double minLineLength = 0,
  double maxLineGap = 0,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.HoughLinesPWithParams_Async(
        image.ref,
        rho,
        theta,
        threshold,
        minLineLength,
        maxLineGap,
        callback,
      ),
      matCompleter,
    );

/// HoughLinesPointSet implements the Hough transform algorithm for line
/// detection on a set of points. For a good explanation of Hough transform, see:
/// http:///homepages.inf.ed.ac.uk/rbf/HIPR2/hough.htm
///
/// For further details, please see:
/// https:///docs.opencv.org/master/dd/d1a/group__imgproc__feature.html#ga2858ef61b4e47d1919facac2152a160e
Future<Mat> HoughLinesPointSetAsync(
  InputArray point,
  int lines_max,
  int threshold,
  double min_rho,
  double max_rho,
  double rho_step,
  double min_theta,
  double max_theta,
  double theta_step,
) async =>
    cvRunAsync(
      (callback) => cimgproc.HoughLinesPointSet_Async(
        point.ref,
        lines_max,
        threshold,
        min_rho,
        max_rho,
        rho_step,
        min_theta,
        max_theta,
        theta_step,
        callback,
      ),
      matCompleter,
    );

/// Integral calculates one or more integral images for the source image.
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga97b87bec26908237e8ba0f6e96d23e28
Future<(Mat sum, Mat sqsum, Mat tilted)> integralAsync(
  InputArray src, {
  int sdepth = -1,
  int sqdepth = -1,
}) async =>
    cvRunAsync3((callback) => cimgproc.Integral_Async(src.ref, sdepth, sqdepth, callback), matCompleter3);

/// Threshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d7/d1b/group__imgproc__misc.html#gae8a4a146d1ca78c626a53577199e9c57
Future<(double, Mat dst)> thresholdAsync(
  InputArray src,
  double thresh,
  double maxval,
  int type,
) async =>
    cvRunAsync2((callback) => cimgproc.Threshold_Async(src.ref, thresh, maxval, type, callback),
        (completer, p, p1) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      completer.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

/// AdaptiveThreshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga72b913f352e4a1b1b397736707afcde3
Future<Mat> adaptiveThresholdAsync(
  InputArray src,
  double maxValue,
  int adaptiveMethod,
  int thresholdType,
  int blockSize,
  double C,
) async =>
    cvRunAsync(
      (callback) => cimgproc.AdaptiveThreshold_Async(
        src.ref,
        maxValue,
        adaptiveMethod,
        thresholdType,
        blockSize,
        C,
        callback,
      ),
      matCompleter,
    );

/// ArrowedLine draws a arrow segment pointing from the first point
/// to the second one.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga0a165a3ca093fd488ac709fdf10c05b2
Future<Mat> arrowedLineAsync(
  InputOutputArray img,
  Point pt1,
  Point pt2,
  Scalar color, {
  int thickness = 1,
  int line_type = 8,
  int shift = 0,
  double tipLength = 0.1,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.ArrowedLine_Async(
        img.ref,
        pt1.ref,
        pt2.ref,
        color.ref,
        thickness,
        line_type,
        shift,
        tipLength,
        callback,
      ),
      (completer) => completer.complete(img),
    );

/// CircleWithParams draws a circle.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf10604b069374903dbd0f0488cb43670
Future<Mat> circleAsync(
  InputOutputArray img,
  Point center,
  int radius,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.CircleWithParams_Async(
        img.ref,
        center.ref,
        radius,
        color.ref,
        thickness,
        lineType,
        shift,
        callback,
      ),
      (completer) => completer.complete(img),
    );

/// Ellipse draws a simple or thick elliptic arc or fills an ellipse sector.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga28b2267d35786f5f890ca167236cbc69
Future<Mat> ellipseAsync(
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
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.EllipseWithParams_Async(
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
        callback,
      ),
      (completer) => completer.complete(img),
    );

/// Line draws a line segment connecting two points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga7078a9fae8c7e7d13d24dac2520ae4a2
Future<Mat> lineAsync(
  InputOutputArray img,
  Point pt1,
  Point pt2,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) async =>
    cvRunAsync0(
      (callback) =>
          cimgproc.Line_Async(img.ref, pt1.ref, pt2.ref, color.ref, thickness, lineType, shift, callback),
      (completer) => completer.complete(img),
    );

/// Rectangle draws a simple, thick, or filled up-right rectangle.
/// It renders a rectangle with the desired characteristics to the target Mat image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga07d2f74cadcf8e305e810ce8eed13bc9
Future<Mat> rectangleAsync(
  InputOutputArray img,
  Rect rect,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.RectangleWithParams_Async(
          img.ref, rect.ref, color.ref, thickness, lineType, shift, callback),
      (completer) => completer.complete(img),
    );

/// FillPolyWithParams fills the area bounded by one or more polygons.
///
/// For more information, see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf30888828337aa4c6b56782b5dfbd4b7
Future<Mat> fillPolyAsync(
  InputOutputArray img,
  VecVecPoint pts,
  Scalar color, {
  int lineType = LINE_8,
  int shift = 0,
  Point? offset,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.FillPolyWithParams_Async(
        img.ref,
        pts.ref,
        color.ref,
        lineType,
        shift,
        offset?.ref ?? Point(-1, -1).ref,
        callback,
      ),
      (completer) => completer.complete(img),
    );

/// Polylines draws several polygonal curves.
///
/// For more information, see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga1ea127ffbbb7e0bfc4fd6fd2eb64263c
Future<Mat> polylinesAsync(
  InputOutputArray img,
  VecVecPoint pts,
  bool isClosed,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  int shift = 0,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.Polylines_Async(img.ref, pts.ref, isClosed, color.ref, thickness, callback),
      (completer) => completer.complete(img),
    );

/// GetTextSizeWithBaseline calculates the width and height of a text string including the basline of the text.
/// It returns an image.Point with the size required to draw text using
/// a specific font face, scale, and thickness as well as its baseline.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga3d2abfcb995fd2db908c8288199dba82
Future<(Size size, int baseline)> getTextSizeAsync(
  String text,
  int fontFace,
  double fontScale,
  int thickness,
) async {
  final ctext = text.toNativeUtf8().cast<ffi.Char>();
  final ret = cvRunAsync2<(Size, int)>(
      (callback) => cimgproc.GetTextSizeWithBaseline_Async(ctext, fontFace, fontScale, thickness, callback),
      (completer, p, p1) {
    final size = Size.fromPointer(p.cast<cvg.Size>());
    final baseline = p1.cast<ffi.Int>().value;
    calloc.free(p1);
    completer.complete((size, baseline));
  });
  calloc.free(ctext);
  return ret;
}

/// PutTextWithParams draws a text string.
/// It renders the specified text string into the img Mat at the location
/// passed in the "org" param, using the desired font face, font scale,
/// color, and line thinkness.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga5126f47f883d730f633d74f07456c576
Future<Mat> putTextAsync(
  InputOutputArray img,
  String text,
  Point org,
  int fontFace,
  double fontScale,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  bool bottomLeftOrigin = false,
}) async {
  final textPtr = text.toNativeUtf8().cast<ffi.Char>();
  final rval = cvRunAsync0<Mat>(
    (callback) => cimgproc.PutTextWithParams_Async(
      img.ref,
      textPtr,
      org.ref,
      fontFace,
      fontScale,
      color.ref,
      thickness,
      lineType,
      bottomLeftOrigin,
      callback,
    ),
    (completer) => completer.complete(img),
  );
  calloc.free(textPtr);
  return rval;
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
Future<Mat> resizeAsync(
  InputArray src,
  (int, int) dsize, {
  double fx = 0,
  double fy = 0,
  int interpolation = INTER_LINEAR,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.Resize_Async(src.ref, dsize.cvd.ref, fx, fy, interpolation, callback),
      matCompleter,
    );

/// GetRectSubPix retrieves a pixel rectangle from an image with sub-pixel accuracy.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga77576d06075c1a4b6ba1a608850cd614
Future<Mat> getRectSubPixAsync(
  InputArray image,
  (int, int) patchSize,
  Point2f center, {
  int patchType = -1,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.GetRectSubPix_Async(image.ref, patchSize.cvd.ref, center.ref, callback),
      matCompleter,
    );

/// GetRotationMatrix2D calculates an affine matrix of 2D rotation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gafbbc470ce83812914a70abfb604f4326
Future<Mat> getRotationMatrix2DAsync(Point2f center, double angle, double scale) async => cvRunAsync(
      (callback) => cimgproc.GetRotationMatrix2D_Async(center.ref, angle, scale, callback),
      matCompleter,
    );

/// WarpAffine applies an affine transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga0203d9ee5fcd28d40dbc4a1ea4451983
Future<Mat> warpAffineAsync(
  InputArray src,
  InputArray M,
  (int, int) dsize, {
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.WarpAffineWithParams_Async(
        src.ref,
        M.ref,
        dsize.cvd.ref,
        flags,
        borderMode,
        borderValue?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// WarpPerspective applies a perspective transformation to an image.
/// For more parameters please check WarpPerspectiveWithParams.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaf73673a7e8e18ec6963e3774e6a94b87
Future<Mat> warpPerspectiveAsync(
  InputArray src,
  InputArray M,
  (int, int) dsize, {
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.WarpPerspectiveWithParams_Async(
        src.ref,
        M.ref,
        dsize.cvd.ref,
        flags,
        borderMode,
        borderValue?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// Watershed performs a marker-based image segmentation using the watershed algorithm.
///
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/d47/group__imgproc__segmentation.html#ga3267243e4d3f95165d55a618c65ac6e1
Future<Mat> watershedAsync(InputArray image, InputOutputArray markers) async => cvRunAsync0(
      (callback) => cimgproc.Watershed_Async(image.ref, markers.ref, callback),
      (c) => c.complete(markers),
    );

/// ApplyColorMap applies a GNU Octave/MATLAB equivalent colormap on a given image.
/// colormap: ColormapTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gadf478a5e5ff49d8aa24e726ea6f65d15
Future<Mat> applyColorMapAsync(InputArray src, int colormap) async => cvRunAsync(
      (callback) => cimgproc.ApplyColorMap_Async(src.ref, colormap, callback),
      matCompleter,
    );

/// ApplyCustomColorMap applies a custom defined colormap on a given image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gacb22288ddccc55f9bd9e6d492b409cae
Future<Mat> applyCustomColorMapAsync(InputArray src, InputArray userColor) async => cvRunAsync(
      (callback) => cimgproc.ApplyCustomColorMap_Async(src.ref, userColor.ref, callback),
      matCompleter,
    );

/// GetPerspectiveTransform returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Future<Mat> getPerspectiveTransformAsync(VecPoint src, VecPoint dst, [int solveMethod = DECOMP_LU]) async =>
    cvRunAsync(
      (callback) => cimgproc.GetPerspectiveTransform_Async(src.ref, dst.ref, solveMethod, callback),
      matCompleter,
    );

/// GetPerspectiveTransform2f returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as gocv.Point2f.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Future<Mat> getPerspectiveTransform2fAsync(
  VecPoint2f src,
  VecPoint2f dst, [
  int solveMethod = DECOMP_LU,
]) async =>
    cvRunAsync(
      (callback) => cimgproc.GetPerspectiveTransform2f_Async(src.ref, dst.ref, solveMethod, callback),
      matCompleter,
    );

/// GetAffineTransform returns a 2x3 affine transformation matrix for the
/// corresponding 3 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8f6d378f9f8eebb5cb55cd3ae295a999
Future<Mat> getAffineTransformAsync(VecPoint src, VecPoint dst) async => cvRunAsync(
      (callback) => cimgproc.GetAffineTransform_Async(src.ref, dst.ref, callback),
      matCompleter,
    );

Future<Mat> getAffineTransform2fAsync(VecPoint2f src, VecPoint2f dst) async => cvRunAsync(
      (callback) => cimgproc.GetAffineTransform2f_Async(src.ref, dst.ref, callback),
      matCompleter,
    );

/// FindHomography finds an optimal homography matrix using 4 or more point pairs (as opposed to GetPerspectiveTransform, which uses exactly 4)
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d9/d0c/group__calib3d.html#ga4abc2ece9fab9398f2e560d53c8c9780
Future<(Mat, Mat)> findHomographyAsync(
  InputArray srcPoints,
  InputArray dstPoints, {
  int method = 0,
  double ransacReprojThreshold = 3,
  int maxIters = 2000,
  double confidence = 0.995,
}) async =>
    cvRunAsync2(
      (callback) => cimgproc.FindHomography_Async(
        srcPoints.ref,
        dstPoints.ref,
        method,
        ransacReprojThreshold,
        maxIters,
        confidence,
        callback,
      ),
      matCompleter2,
    );

/// DrawContours draws contours outlines or filled contours.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#ga746c0625f1781f1ffc9056259103edbc
Future<Mat> drawContoursAsync(
  InputOutputArray image,
  Contours contours,
  int contourIdx,
  Scalar color, {
  int thickness = 1,
  int lineType = LINE_8,
  InputArray? hierarchy, // TODO: replace with vec
  int maxLevel = 0x3f3f3f3f,
  Point? offset,
}) async =>
    cvRunAsync0(
      (callback) => cimgproc.DrawContoursWithParams_Async(
        image.ref,
        contours.ref,
        contourIdx,
        color.ref,
        thickness,
        lineType,
        hierarchy?.ref ?? Mat.empty().ref,
        maxLevel,
        offset?.ref ?? Point(-1, -1).ref,
        callback,
      ),
      (c) => c.complete(image),
    );

/// Remap applies a generic geometrical transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gab75ef31ce5cdfb5c44b6da5f3b908ea4
Future<Mat> remapAsync(
  InputArray src,
  InputArray map1,
  InputArray map2,
  int interpolation, {
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.Remap_Async(
        src.ref,
        map1.ref,
        map2.ref,
        interpolation,
        borderMode,
        borderValue?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// Filter2D applies an arbitrary linear filter to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga27c049795ce870216ddfb366086b5a04
Future<Mat> filter2DAsync(
  InputArray src,
  int ddepth,
  InputArray kernel, {
  Point? anchor,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.Filter2D_Async(
        src.ref,
        ddepth,
        kernel.ref,
        anchor?.ref ?? Point(-1, -1).ref,
        delta,
        borderType,
        callback,
      ),
      matCompleter,
    );

/// SepFilter2D applies a separable linear filter to the image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga910e29ff7d7b105057d1625a4bf6318d
Future<Mat> sepFilter2DAsync(
  InputArray src,
  int ddepth,
  InputArray kernelX,
  InputArray kernelY, {
  Point? anchor,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) async =>
    cvRunAsync(
      (callback) => cimgproc.SepFilter2D_Async(
        src.ref,
        ddepth,
        kernelX.ref,
        kernelY.ref,
        anchor?.ref ?? Point(-1, -1).ref,
        delta,
        borderType,
        callback,
      ),
      matCompleter,
    );

/// LogPolar remaps an image to semilog-polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaec3a0b126a85b5ca2c667b16e0ae022d
Future<Mat> logPolarAsync(InputArray src, Point2f center, double M, int flags) async => cvRunAsync(
      (callback) => cimgproc.LogPolar_Async(src.ref, center.ref, M, flags, callback),
      matCompleter,
    );

/// LinearPolar remaps an image to polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaa38a6884ac8b6e0b9bed47939b5362f3
Future<Mat> linearPolarAsync(InputArray src, Point2f center, double maxRadius, int flags) async => cvRunAsync(
      (callback) => cimgproc.LinearPolar_Async(src.ref, center.ref, maxRadius, flags, callback),
      matCompleter,
    );

/// FitLine fits a line to a 2D or 3D point set.
/// distType: DistanceTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf849da1fdafa67ee84b1e9a23b93f91f
Future<Mat> fitLineAsync(VecPoint points, int distType, double param, double reps, double aeps) async =>
    cvRunAsync(
      (callback) => cimgproc.FitLine_Async(points.ref, distType, param, reps, aeps, callback),
      matCompleter,
    );

/// Compares two shapes.
/// method: ShapeMatchModes
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gaadc90cb16e2362c9bd6e7363e6e4c317
Future<double> matchShapesAsync(VecPoint contour1, VecPoint contour2, int method, double parameter) async =>
    cvRunAsync(
      (callback) => cimgproc.MatchShapes_Async(contour1.ref, contour2.ref, method, parameter, callback),
      doubleCompleter,
    );

/// Inverts an affine transformation.
/// The function computes an inverse affine transformation represented by 2×3 matrix M:
/// The result is also a 2×3 matrix of the same type as M.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/da/d54/group__imgproc__transform.html#ga57d3505a878a7e1a636645727ca08f51
Future<Mat> invertAffineTransformAsync(InputArray M) async => cvRunAsync(
      (callback) => cimgproc.InvertAffineTransform_Async(M.ref, callback),
      matCompleter,
    );

/// Apply phaseCorrelate.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga552420a2ace9ef3fb053cd630fdb4952
Future<(Point2f rval, double response)> phaseCorrelateAsync(
  InputArray src1,
  InputArray src2, {
  InputArray? window,
}) async =>
    cvRunAsync2(
      (callback) =>
          cimgproc.PhaseCorrelate_Async(src1.ref, src2.ref, window?.ref ?? Mat.empty().ref, callback),
      (c, p, p1) {
        final response = p1.cast<ffi.Double>().value;
        calloc.free(p1);
        c.complete((Point2f.fromPointer(p.cast<cvg.Point2f>()), response));
      },
    );

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga1a567a79901513811ff3b9976923b199
///
Future<Mat> accumulateAsync(InputArray src, InputOutputArray dst, {InputArray? mask}) async => mask == null
    ? cvRunAsync0(
        (callback) => cimgproc.Mat_Accumulate_Async(src.ref, dst.ref, callback), (c) => c.complete(dst))
    : cvRunAsync0(
        (callback) => cimgproc.Mat_AccumulateWithMask_Async(src.ref, dst.ref, mask.ref, callback),
        (c) => c.complete(dst),
      );

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#gacb75e7ffb573227088cef9ceaf80be8c
Future<Mat> accumulateSquareAsync(InputArray src, InputOutputArray dst, {InputArray? mask}) async =>
    mask == null
        ? cvRunAsync0(
            (callback) => cimgproc.Mat_AccumulateSquare_Async(src.ref, dst.ref, callback),
            (c) => c.complete(dst),
          )
        : cvRunAsync0(
            (callback) => cimgproc.Mat_AccumulateSquareWithMask_Async(src.ref, dst.ref, mask.ref, callback),
            (c) => c.complete(dst),
          );

/// Adds the per-element product of two input images to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga82518a940ecfda49460f66117ac82520
Future<Mat> accumulateProductAsync(
  InputArray src1,
  InputArray src2,
  InputOutputArray dst, {
  InputArray? mask,
}) async =>
    mask == null
        ? cvRunAsync0(
            (callback) => cimgproc.Mat_AccumulateProduct_Async(src1.ref, src2.ref, dst.ref, callback),
            (c) => c.complete(dst),
          )
        : cvRunAsync0(
            (callback) =>
                cimgproc.Mat_AccumulateProductWithMask_Async(src1.ref, src2.ref, dst.ref, mask.ref, callback),
            (c) => c.complete(dst),
          );

/// Updates a running average.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga4f9552b541187f61f6818e8d2d826bc7
Future<Mat> accumulateWeightedAsync(
  InputArray src,
  InputOutputArray dst,
  double alpha, {
  InputArray? mask,
}) async =>
    mask == null
        ? cvRunAsync0(
            (callback) => cimgproc.Mat_AccumulatedWeighted_Async(src.ref, dst.ref, alpha, callback),
            (c) => c.complete(dst),
          )
        : cvRunAsync0(
            (callback) =>
                cimgproc.Mat_AccumulatedWeightedWithMask_Async(src.ref, dst.ref, alpha, mask.ref, callback),
            (c) => c.complete(dst),
          );
