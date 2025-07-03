// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv.imgproc;

import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/contours.dart';
import '../core/cv_vec.dart';
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
Future<VecPoint> approxPolyDPAsync(VecPoint curve, double epsilon, bool closed) async {
  final vec = VecPoint();
  return cvRunAsync0(
    (callback) => cimgproc.cv_approxPolyDP(curve.ref, epsilon, closed, vec.ptr, callback),
    (c) {
      return c.complete(vec);
    },
  );
}

/// ApproxPolyDP approximates a polygonal curve(s) with the specified precision.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga0012a5fdaea70b8a9970165d98722b4c
Future<VecPoint2f> approxPolyDP2fAsync(VecPoint2f curve, double epsilon, bool closed) async {
  final vec = VecPoint2f();
  return cvRunAsync0(
    (callback) => cimgproc.cv_approxPolyDP2f(curve.ref, epsilon, closed, vec.ptr, callback),
    (c) {
      return c.complete(vec);
    },
  );
}

/// ApproxPolyN approximates a polygon with a convex hull with a specified accuracy and number of sides.
///
/// For further details, please see:
///
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#ga88981607a2d61b95074688aac55625cc
Future<VecPoint> approxPolyNAsync(
  VecPoint curve,
  int nsides, {
  double epsilon_percentage = -1.0,
  bool ensure_convex = true,
}) async {
  final vec = VecPoint();
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_approxPolyN(curve.ref, nsides, epsilon_percentage, ensure_convex, vec.ptr, callback),
    (c) {
      return c.complete(vec);
    },
  );
}

/// ApproxPolyN approximates a polygon with a convex hull with a specified accuracy and number of sides.
///
/// For further details, please see:
///
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#ga88981607a2d61b95074688aac55625cc
Future<VecPoint2f> approxPolyN2fAsync(
  VecPoint2f curve,
  int nsides, {
  double epsilon_percentage = -1.0,
  bool ensure_convex = true,
}) async {
  final vec = VecPoint2f();
  return cvRunAsync0(
      (callback) =>
          cimgproc.cv_approxPolyN2f(curve.ref, nsides, epsilon_percentage, ensure_convex, vec.ptr, callback),
      (c) {
    return c.complete(vec);
  });
}

/// ArcLength calculates a contour perimeter or a curve length.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga8d26483c636be6b35c3ec6335798a47c
Future<double> arcLengthAsync(VecPoint curve, bool closed) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0((callback) => cimgproc.cv_arcLength(curve.ref, closed, p, callback), (c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete(rval);
  });
}

/// ArcLength calculates a contour perimeter or a curve length.
///
/// For further details, please see:
///
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga8d26483c636be6b35c3ec6335798a47c
Future<double> arcLength2fAsync(VecPoint2f curve, bool closed) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0((callback) => cimgproc.cv_arcLength2f(curve.ref, closed, p, callback), (c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete(rval);
  });
}

/// ConvexHull finds the convex hull of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga014b28e56cb8854c0de4a211cb2be656
Future<Mat> convexHullAsync(
  VecPoint points, {
  Mat? hull,
  bool clockwise = false,
  bool returnPoints = true,
}) async {
  hull ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_convexHull(points.ref, hull!.ref, clockwise, returnPoints, callback),
    (c) {
      return c.complete(hull);
    },
  );
}

/// ConvexHull finds the convex hull of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga014b28e56cb8854c0de4a211cb2be656
Future<Mat> convexHull2fAsync(
  VecPoint2f points, {
  Mat? hull,
  bool clockwise = false,
  bool returnPoints = true,
}) async {
  hull ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_convexHull2f(points.ref, hull!.ref, clockwise, returnPoints, callback),
    (c) {
      return c.complete(hull);
    },
  );
}

/// ConvexityDefects finds the convexity defects of a contour.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gada4437098113fd8683c932e0567f47ba
Future<Mat> convexityDefectsAsync(VecPoint contour, Mat hull, {Mat? convexityDefects}) async {
  convexityDefects ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_convexityDefects(contour.ref, hull.ref, convexityDefects!.ref, callback),
    (c) {
      return c.complete(convexityDefects);
    },
  );
}

// convexityDefects does not support std::vector<cv::Poinit2f>
// https://github.com/opencv/opencv/blob/31b0eeea0b44b370fd0712312df4214d4ae1b158/modules/imgproc/src/convhull.cpp#L318
// /// ConvexityDefects finds the convexity defects of a contour.
// ///
// /// For further details, please see:
// /// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gada4437098113fd8683c932e0567f47ba
// Future<Mat> convexityDefects2fAsync(VecPoint2f contour, Mat hull, {Mat? convexityDefects}) async {
//   convexityDefects ??= Mat.empty();
//   return cvRunAsync0(
//     (callback) => cimgproc.cv_convexityDefects2f(contour.ref, hull.ref, convexityDefects!.ref, callback),
//     (c) {
//       return c.complete(convexityDefects);
//     },
//   );
// }

/// CvtColor converts an image from one color space to another.
/// It converts the src Mat image to the dst Mat using the
/// code param containing the desired ColorConversionCode color space.
///
/// For further details, please see:
/// http:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga4e0972be5de079fed4e3a10e24ef5ef0
Future<Mat> cvtColorAsync(Mat src, int code, {Mat? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_cvtColor(src.ref, dst!.ref, code, callback), (c) {
    return c.complete(dst);
  });
}

/// EqualizeHist Equalizes the histogram of a grayscale image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#ga7e54091f0c937d49bf84152a16f76d6e
Future<Mat> equalizeHistAsync(Mat src, {Mat? dst}) async {
  cvAssert(src.channels == 1, "src must be grayscale");
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_equalizeHist(src.ref, dst!.ref, callback), (c) {
    return c.complete(dst);
  });
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
  Mat? hist,
  bool accumulate = false,
}) {
  hist ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_calcHist(
      src.ref,
      channels.ref,
      mask.ref,
      hist!.ref,
      histSize.ref,
      ranges.ref,
      accumulate,
      callback,
    ),
    (c) {
      return c.complete(hist);
    },
  );
}

/// CalcBackProject calculates the back projection of a histogram.
///
/// For futher details, please see:
/// https://docs.opencv.org/4.10.0/d6/dc7/group__imgproc__hist.html#gab644bc90e7475cc047aa1b25dbcbd8df
Future<Mat> calcBackProjectAsync(
  VecMat src,
  VecI32 channels,
  Mat hist,
  VecF32 ranges, {
  Mat? dst,
  double scale = 1.0,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_calcBackProject(src.ref, channels.ref, hist.ref, dst!.ref, ranges.ref, scale, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// CompareHist Compares two histograms.
/// mode: HistCompMethods
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/dc7/group__imgproc__hist.html#gaf4190090efa5c47cb367cf97a9a519bd
Future<double> compareHistAsync(Mat hist1, Mat hist2, {int method = 0}) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0((callback) => cimgproc.cv_compareHist(hist1.ref, hist2.ref, method, p, callback), (c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete(rval);
  });
}

/// ClipLine clips the line against the image rectangle.
/// For further details, please see:
/// https:///docs.opencv.org/master/d6/d6e/group__imgproc__draw.html#gaf483cb46ad6b049bc35ec67052ef1c2c
Future<(bool, Point, Point)> clipLineAsync(Rect imgRect, Point pt1, Point pt2) async {
  final p = calloc<ffi.Bool>();
  return cvRunAsync0((callback) => cimgproc.cv_clipLine(imgRect.ref, pt1.ref, pt2.ref, p, callback), (c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete((rval, pt1, pt2));
  });
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
Future<Mat> bilateralFilterAsync(
  Mat src,
  int diameter,
  double sigmaColor,
  double sigmaSpace, {
  Mat? dst,
}) async {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_bilateralFilter(src.ref, dst!.ref, diameter, sigmaColor, sigmaSpace, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Blur blurs an image Mat using a normalized box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga8c45db9afe636703801b0b2e440fce37
Future<Mat> blurAsync(Mat src, (int, int) ksize, {Mat? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_blur(src.ref, dst!.ref, ksize.cvd.ref, callback), (c) {
    return c.complete(dst);
  });
}

/// BoxFilter blurs an image using the box filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad533230ebf2d42509547d514f7d3fbc3
Future<Mat> boxFilterAsync(
  Mat src,
  int depth,
  (int, int) ksize, {
  Point? anchor,
  bool normalize = true,
  int borderType = BORDER_DEFAULT,
  Mat? dst,
}) {
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  return cvRunAsync0(
    (callback) => cimgproc.cv_boxFilter(
      src.ref,
      dst!.ref,
      depth,
      ksize.cvd.ref,
      anchor!.ref,
      normalize,
      borderType,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// SqBoxFilter calculates the normalized sum of squares of the pixel values overlapping the filter.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d4/d86/group__imgproc__filter.html#ga76e863e7869912edbe88321253b72688
Future<Mat> sqrBoxFilterAsync(
  Mat src,
  int depth,
  (int, int) ksize, {
  Point? anchor,
  bool normalize = true,
  int borderType = BORDER_DEFAULT,
  Mat? dst,
}) {
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  return cvRunAsync0(
    (callback) => cimgproc.cv_sqrBoxFilter(
      src.ref,
      dst!.ref,
      depth,
      ksize.cvd.ref,
      anchor!.ref,
      normalize,
      borderType,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Dilate dilates an image by using a specific structuring element.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga4ff0f3318642c4f469d0e11f242f3b6c
Future<Mat> dilateAsync(
  Mat src,
  Mat kernel, {
  Mat? dst,
  Point? anchor,
  int iterations = 1,
  int borderType = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar();
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  return cvRunAsync0(
    (callback) => cimgproc.cv_dilate_1(
      src.ref,
      dst!.ref,
      kernel.ref,
      anchor!.ref,
      iterations,
      borderType,
      borderValue!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

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
}) {
  borderValue ??= Scalar();
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  return cvRunAsync0(
    (callback) => cimgproc.cv_erode_1(
      src.ref,
      dst!.ref,
      kernel.ref,
      anchor!.ref,
      iterations,
      borderType,
      borderValue!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

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
  int labelType, {
  Mat? dst,
  Mat? labels,
}) {
  dst ??= Mat.empty();
  labels ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_distanceTransform(
      src.ref,
      dst!.ref,
      labels!.ref,
      distanceType,
      maskSize,
      labelType,
      callback,
    ),
    (c) {
      return c.complete((dst!, labels!));
    },
  );
}

/// Fills a connected component with the given color.
///
/// https://docs.opencv.org/4.x/d7/d1b/group__imgproc__misc.html#ga366aae45a6c1289b341d140839f18717
Future<(int rval, Mat image, Mat mask, Rect rect)> floodFillAsync(
  InputOutputArray image,
  Point seedPoint,
  Scalar newVal, {
  InputOutputArray? mask,
  Scalar? loDiff,
  Scalar? upDiff,
  int flags = 4,
}) {
  loDiff ??= Scalar();
  upDiff ??= Scalar();
  mask ??= Mat.empty();
  final pRect = calloc<cvg.CvRect>();
  final pRval = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_floodFill(
      image.ref,
      mask!.ref,
      seedPoint.ref,
      newVal.ref,
      pRect,
      loDiff!.ref,
      upDiff!.ref,
      flags,
      pRval,
      callback,
    ),
    (c) {
      final rval = pRval.value;
      calloc.free(pRval);
      return c.complete((rval, image, mask!, Rect.fromPointer(pRect)));
    },
  );
}

/// BoundingRect calculates the up-right bounding rectangle of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gacb413ddce8e48ff3ca61ed7cf626a366
Future<Rect> boundingRectAsync(VecPoint points) async {
  final rect = calloc<cvg.CvRect>();
  return cvRunAsync0((callback) => cimgproc.cv_boundingRect(points.ref, rect, callback), (c) {
    return c.complete(Rect.fromPointer(rect));
  });
}

/// BoundingRect calculates the up-right bounding rectangle of a point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#gacb413ddce8e48ff3ca61ed7cf626a366
Future<Rect> boundingRect2fAsync(VecPoint2f points) async {
  final rect = calloc<cvg.CvRect>();
  return cvRunAsync0((callback) => cimgproc.cv_boundingRect2f(points.ref, rect, callback), (c) {
    return c.complete(Rect.fromPointer(rect));
  });
}

/// BoxPoints finds the four vertices of a rotated rect. Useful to draw the rotated rectangle.
///
/// return: [bottom left, top left, top right, bottom right]
/// For further Details, please see:
/// https://docs.opencv.org/4.10.0/d3/dc0/group__imgproc__shape.html#gaf78d467e024b4d7936cf9397185d2f5c
Future<VecPoint2f> boxPointsAsync(RotatedRect rect, {VecPoint2f? pts}) async {
  pts ??= VecPoint2f();
  return cvRunAsync0((callback) => cimgproc.cv_boxPoints(rect.ref, pts!.ptr, callback), (c) {
    return c.complete(pts);
  });
}

/// ContourArea calculates a contour area.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#ga2c759ed9f497d4a618048a2f56dc97f1
Future<double> contourAreaAsync(VecPoint contour) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0((callback) => cimgproc.cv_contourArea(contour.ref, p, callback), (c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete(rval);
  });
}

/// ContourArea calculates a contour area.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d3/dc0/group__imgproc__shape.html#ga2c759ed9f497d4a618048a2f56dc97f1
Future<double> contourArea2fAsync(VecPoint2f contour) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0((callback) => cimgproc.cv_contourArea2f(contour.ref, p, callback), (c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete(rval);
  });
}

/// MinAreaRect finds a rotated rectangle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga3d476a3417130ae5154aea421ca7ead9
Future<RotatedRect> minAreaRectAsync(VecPoint points) async {
  final p = calloc<cvg.RotatedRect>();
  return cvRunAsync0((callback) => cimgproc.cv_minAreaRect(points.ref, p, callback), (c) {
    return c.complete(RotatedRect.fromPointer(p));
  });
}

/// MinAreaRect finds a rotated rectangle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga3d476a3417130ae5154aea421ca7ead9
Future<RotatedRect> minAreaRect2fAsync(VecPoint2f points) async {
  final p = calloc<cvg.RotatedRect>();
  return cvRunAsync0((callback) => cimgproc.cv_minAreaRect2f(points.ref, p, callback), (c) {
    return c.complete(RotatedRect.fromPointer(p));
  });
}

/// FitEllipse Fits an ellipse around a set of 2D points.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf259efaad93098103d6c27b9e4900ffa
Future<RotatedRect> fitEllipseAsync(VecPoint points) async {
  final p = calloc<cvg.RotatedRect>();
  return cvRunAsync0((callback) => cimgproc.cv_fitEllipse(points.ref, p, callback), (c) {
    return c.complete(RotatedRect.fromPointer(p));
  });
}

/// FitEllipse Fits an ellipse around a set of 2D points.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#ga8ce13c24081bbc7151e9326f412190f1
Future<RotatedRect> fitEllipse2fAsync(VecPoint2f points) async {
  final p = calloc<cvg.RotatedRect>();
  return cvRunAsync0((callback) => cimgproc.cv_fitEllipse2f(points.ref, p, callback), (c) {
    return c.complete(RotatedRect.fromPointer(p));
  });
}

/// MinEnclosingCircle finds a circle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#ga8ce13c24081bbc7151e9326f412190f1
Future<(Point2f center, double radius)> minEnclosingCircleAsync(VecPoint points) async {
  final center = calloc<cvg.CvPoint2f>();
  final pRadius = calloc<ffi.Float>();
  return cvRunAsync0((callback) => cimgproc.cv_minEnclosingCircle(points.ref, center, pRadius, callback), (
    c,
  ) {
    final rval = (Point2f.fromPointer(center), pRadius.value);
    calloc.free(pRadius);
    return c.complete(rval);
  });
}

/// MinEnclosingCircle finds a circle of the minimum area enclosing the input 2D point set.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#ga8ce13c24081bbc7151e9326f412190f1
Future<(Point2f center, double radius)> minEnclosingCircle2fAsync(VecPoint2f points) async {
  final center = calloc<cvg.CvPoint2f>();
  final pRadius = calloc<ffi.Float>();
  return cvRunAsync0((callback) => cimgproc.cv_minEnclosingCircle2f(points.ref, center, pRadius, callback), (
    c,
  ) {
    final rval = (Point2f.fromPointer(center), pRadius.value);
    calloc.free(pRadius);
    return c.complete(rval);
  });
}

/// FindContours finds contours in a binary image.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gadf1ad6a0b82947fa1fe3c3d497f260e0
Future<(Contours contours, VecVec4i hierarchy)> findContoursAsync(Mat src, int mode, int method) async {
  final hierarchy = VecVec4i();
  final contours = VecVecPoint();
  return cvRunAsync0(
    (callback) => cimgproc.cv_findContours(src.ref, contours.ptr, hierarchy.ptr, mode, method, callback),
    (c) {
      return c.complete((contours, hierarchy));
    },
  );
}

/// FindContours finds contours in a binary image.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gadf1ad6a0b82947fa1fe3c3d497f260e0
Future<(Contours2f contours, VecVec4i hierarchy)> findContours2fAsync(Mat src, int mode, int method) async {
  final hierarchy = VecVec4i();
  final contours = VecVecPoint2f();
  return cvRunAsync0(
    (callback) => cimgproc.cv_findContours2f(src.ref, contours.ptr, hierarchy.ptr, mode, method, callback),
    (c) {
      return c.complete((contours, hierarchy));
    },
  );
}

/// PointPolygonTest performs a point-in-contour test.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga1a539e8db2135af2566103705d7a5722
Future<double> pointPolygonTestAsync(VecPoint points, Point2f pt, bool measureDist) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_pointPolygonTest(points.ref, pt.ref, measureDist, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// PointPolygonTest performs a point-in-contour test.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga1a539e8db2135af2566103705d7a5722
Future<double> pointPolygonTest2fAsync(VecPoint2f points, Point2f pt, bool measureDist) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_pointPolygonTest2f(points.ref, pt.ref, measureDist, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// ConnectedComponents computes the connected components labeled image of boolean image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaedef8c7340499ca391d459122e51bef5
Future<int> connectedComponentsAsync(
  Mat image,
  OutputArray labels,
  int connectivity,
  int ltype,
  int ccltype,
) {
  final p = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_connectedComponents(image.ref, labels.ref, connectivity, ltype, ccltype, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// ConnectedComponentsWithStats computes the connected components labeled image of boolean
/// image and also produces a statistics output for each label.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga107a78bf7cd25dec05fb4dfc5c9e765f
Future<int> connectedComponentsWithStatsAsync(
  Mat src,
  Mat labels,
  Mat stats,
  Mat centroids,
  int connectivity,
  int ltype,
  int ccltype,
) {
  final p = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_connectedComponents_1(
      src.ref,
      labels.ref,
      stats.ref,
      centroids.ref,
      connectivity,
      ltype,
      ccltype,
      p,
      callback,
    ),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// MatchTemplate compares a template against overlapped image regions.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/df/dfb/group__imgproc__object.html#ga586ebfb0a7fb604b35a23d85391329be
Future<Mat> matchTemplateAsync(Mat image, Mat templ, int method, {OutputArray? result, Mat? mask}) async {
  mask ??= Mat.empty();
  result ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_matchTemplate(image.ref, templ.ref, result!.ref, method, mask!.ref, callback),
    (c) {
      return c.complete(result);
    },
  );
}

/// Moments calculates all of the moments up to the third order of a polygon
/// or rasterized shape.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#ga556a180f43cab22649c23ada36a8a139
Future<Moments> momentsAsync(Mat src, {bool binaryImage = false}) async {
  final m = calloc<cvg.Moment>();
  return cvRunAsync0((callback) => cimgproc.cv_moments(src.ref, binaryImage, m, callback), (c) {
    return c.complete(Moments.fromPointer(m));
  });
}

/// PyrDown blurs an image and downsamples it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaf9bba239dfca11654cb7f50f889fc2ff
Future<Mat> pyrDownAsync(Mat src, {Mat? dst, (int, int) dstsize = (0, 0), int borderType = BORDER_DEFAULT}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_pyrDown(src.ref, dst!.ref, dstsize.cvd.ref, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// PyrUp upsamples an image and then blurs it.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gada75b59bdaaca411ed6fee10085eb784
Future<Mat> pyrUpAsync(Mat src, {Mat? dst, (int, int) dstsize = (0, 0), int borderType = BORDER_DEFAULT}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_pyrUp(src.ref, dst!.ref, dstsize.cvd.ref, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// MorphologyDefaultBorder returns "magic" border value for erosion and dilation.
/// It is automatically transformed to Scalar::all(-DBL_MAX) for dilation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga94756fad83d9d24d29c9bf478558c40a
Future<Scalar> morphologyDefaultBorderValueAsync() async {
  final s = calloc<cvg.Scalar>();
  return cvRunAsync0((callback) => cimgproc.cv_morphologyDefaultBorderValue(s, callback), (c) {
    return c.complete(Scalar.fromPointer(s));
  });
}

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
}) {
  borderValue = borderValue ?? Scalar();
  dst ??= Mat.empty();
  anchor ??= Point(-1, -1);
  return cvRunAsync0(
    (callback) => cimgproc.cv_morphologyEx_1(
      src.ref,
      dst!.ref,
      op,
      kernel.ref,
      anchor!.ref,
      iterations,
      borderType,
      borderValue!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// GetStructuringElement returns a structuring element of the specified size
/// and shape for morphological operations.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac342a1bb6eabf6f55c803b09268e36dc
Future<Mat> getStructuringElementAsync(int shape, (int, int) ksize, {Point? anchor}) async {
  anchor ??= Point(-1, -1);
  final mat = Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_getStructuringElement(shape, ksize.cvd.ref, mat.ptr, callback),
    (c) {
      return c.complete(mat);
    },
  );
}

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
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_GaussianBlur(src.ref, dst!.ref, ksize.cvd.ref, sigmaX, sigmaY, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// GetGaussianKernel returns Gaussian filter coefficients.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gac05a120c1ae92a6060dd0db190a61afa
Future<Mat> getGaussianKernelAsync(int ksize, double sigma, {int ktype = 6}) async {
  final mat = Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_getGaussianKernel(ksize, sigma, ktype, mat.ptr, callback), (
    c,
  ) {
    return c.complete(mat);
  });
}

/// Sobel calculates the first, second, third, or mixed image derivatives using an extended Sobel operator
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gacea54f142e81b6758cb6f375ce782c8d
Future<Mat> sobelAsync(
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
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_Sobel(src.ref, dst!.ref, ddepth, dx, dy, ksize, scale, delta, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// SpatialGradient calculates the first order image derivative in both x and y using a Sobel operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga405d03b20c782b65a4daf54d233239a2
Future<(Mat dx, Mat dy)> spatialGradientAsync(
  Mat src, {
  Mat? dx,
  Mat? dy,
  int ksize = 3,
  int borderType = BORDER_DEFAULT,
}) {
  dx ??= Mat.empty();
  dy ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_spatialGradient(src.ref, dx!.ref, dy!.ref, ksize, borderType, callback),
    (c) {
      return c.complete((dx!, dy!));
    },
  );
}

/// Laplacian calculates the Laplacian of an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gad78703e4c8fe703d479c1860d76429e6
Future<Mat> laplacianAsync(
  Mat src,
  int ddepth, {
  Mat? dst,
  int ksize = 1,
  double scale = 1,
  double delta = 0,
  int borderType = BORDER_DEFAULT,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_Laplacian(src.ref, dst!.ref, ddepth, ksize, scale, delta, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Scharr calculates the first x- or y- image derivative using Scharr operator.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#gaa13106761eedf14798f37aa2d60404c9
Future<Mat> scharrAsync(
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
  return cvRunAsync0(
    (callback) => cimgproc.cv_Scharr(src.ref, dst!.ref, ddepth, dx, dy, scale, delta, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// MedianBlur blurs an image using the median filter.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga564869aa33e58769b4469101aac458f9
Future<Mat> medianBlurAsync(Mat src, int ksize, {OutputArray? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_medianBlur(src.ref, dst!.ref, ksize, callback), (c) {
    return c.complete(dst);
  });
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
Future<Mat> cannyAsync(
  Mat image,
  double threshold1,
  double threshold2, {
  OutputArray? edges,
  int apertureSize = 3,
  bool l2gradient = false,
}) {
  edges ??= Mat.empty();
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_canny(image.ref, edges!.ref, threshold1, threshold2, apertureSize, l2gradient, callback),
    (c) {
      return c.complete(edges);
    },
  );
}

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
]) {
  final size = winSize.cvd;
  final zone = zeroZone.cvd;
  final c = criteria.toTermCriteria();
  return cvRunAsync0(
    (callback) => cimgproc.cv_cornerSubPix(image.ref, corners.ref, size.ref, zone.ref, c.ref, callback),
    (c) {
      return c.complete(corners);
    },
  );
}

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
  VecPoint2f? corners,
  InputArray? mask,
  int blockSize = 3,
  int? gradientSize,
  bool useHarrisDetector = false,
  double k = 0.04,
}) {
  corners ??= VecPoint2f();
  mask ??= Mat.empty();
  if (gradientSize == null) {
    return cvRunAsync0(
      (callback) => cimgproc.cv_goodFeaturesToTrack(
        image.ref,
        corners!.ptr,
        maxCorners,
        qualityLevel,
        minDistance,
        mask!.ref,
        blockSize,
        useHarrisDetector,
        k,
        callback,
      ),
      (c) {
        return c.complete(corners);
      },
    );
  }
  return cvRunAsync0(
    (callback) => cimgproc.cv_goodFeaturesToTrack_1(
      image.ref,
      corners!.ptr,
      maxCorners,
      qualityLevel,
      minDistance,
      mask!.ref,
      blockSize,
      gradientSize,
      useHarrisDetector,
      k,
      callback,
    ),
    (c) {
      return c.complete(corners);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) => cimgproc.cv_grabCut(
      img.ref,
      mask.ref,
      rect.ref,
      bgdModel.ref,
      fgdModel.ref,
      iterCount,
      mode,
      callback,
    ),
    (c) {
      return c.complete((mask, bgdModel, fgdModel));
    },
  );
}

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
  OutputArray? circles,
  double param1 = 100,
  double param2 = 100,
  int minRadius = 0,
  int maxRadius = 0,
}) {
  circles ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_HoughCircles_1(
      image.ref,
      circles!.ref,
      method,
      dp,
      minDist,
      param1,
      param2,
      minRadius,
      maxRadius,
      callback,
    ),
    (c) {
      return c.complete(circles);
    },
  );
}

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
  OutputArray? lines,
  double srn = 0,
  double stn = 0,
  double min_theta = 0,
  double max_theta = CV_PI,
}) {
  lines ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_HoughLines(
      image.ref,
      lines!.ref,
      rho,
      theta,
      threshold,
      srn,
      stn,
      min_theta,
      max_theta,
      callback,
    ),
    (c) {
      return c.complete(lines);
    },
  );
}

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
  OutputArray? lines,
  double minLineLength = 0,
  double maxLineGap = 0,
}) {
  lines ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_HoughLinesP_1(
      image.ref,
      lines!.ref,
      rho,
      theta,
      threshold,
      minLineLength,
      maxLineGap,
      callback,
    ),
    (c) {
      return c.complete(lines);
    },
  );
}

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
  double theta_step, {
  OutputArray? lines,
}) {
  lines ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_HoughLinesPointSet(
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
      callback,
    ),
    (c) {
      return c.complete(lines);
    },
  );
}

/// Integral calculates one or more integral images for the source image.
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/d1b/group__imgproc__misc.html#ga97b87bec26908237e8ba0f6e96d23e28
Future<(Mat sum, Mat sqsum, Mat tilted)> integralAsync(
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
  return cvRunAsync0(
    (callback) => cimgproc.cv_integral(src.ref, sum!.ref, sqsum!.ref, tilted!.ref, sdepth, sqdepth, callback),
    (c) {
      return c.complete((sum!, sqsum!, tilted!));
    },
  );
}

/// Threshold applies a fixed-level threshold to each array element.
///
/// For further details, please see:
/// https:///docs.opencv.org/3.3.0/d7/d1b/group__imgproc__misc.html#gae8a4a146d1ca78c626a53577199e9c57
Future<(double, Mat dst)> thresholdAsync(
  InputArray src,
  double thresh,
  double maxval,
  int type, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_threshold(src.ref, dst!.ref, thresh, maxval, type, p, callback),
    (c) {
      final rval = (p.value, dst!);
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

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
  double C, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_adaptiveThreshold(
      src.ref,
      dst!.ref,
      maxValue,
      adaptiveMethod,
      thresholdType,
      blockSize,
      C,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) => cimgproc.cv_arrowedLine(
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
    (c) {
      return c.complete(img);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_circle_1(img.ref, center.ref, radius, color.ref, thickness, lineType, shift, callback),
    (c) {
      return c.complete(img);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) => cimgproc.cv_ellipse_1(
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
    (c) {
      return c.complete(img);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_line(img.ref, pt1.ref, pt2.ref, color.ref, thickness, lineType, shift, callback),
    (c) {
      return c.complete(img);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) => cimgproc.cv_rectangle_1(img.ref, rect.ref, color.ref, thickness, lineType, shift, callback),
    (c) {
      return c.complete(img);
    },
  );
}

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
}) {
  offset ??= Point(0, 0);
  return cvRunAsync0(
    (callback) => cimgproc.cv_fillPoly_1(img.ref, pts.ref, color.ref, lineType, shift, offset!.ref, callback),
    (c) {
      return c.complete(img);
    },
  );
}

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
}) {
  return cvRunAsync0(
    (callback) => cimgproc.cv_polylines(img.ref, pts.ref, isClosed, color.ref, thickness, callback),
    (c) {
      return c.complete(img);
    },
  );
}

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
) {
  final pBaseline = calloc<ffi.Int>();
  final size = calloc<cvg.CvSize>();
  final textPtr = text.toNativeUtf8().cast<ffi.Char>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_getTextSize(textPtr, fontFace, fontScale, thickness, pBaseline, size, callback),
    (c) {
      final rval = (Size.fromPointer(size), pBaseline.value);
      calloc.free(pBaseline);
      return c.complete(rval);
    },
  );
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
}) {
  final textPtr = text.toNativeUtf8().cast<ffi.Char>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_putText_1(
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
    (c) {
      calloc.free(textPtr);
      return c.complete(img);
    },
  );
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
  OutputArray? dst,
  double fx = 0,
  double fy = 0,
  int interpolation = INTER_LINEAR,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_resize(src.ref, dst!.ref, dsize.cvd.ref, fx, fy, interpolation, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// GetRectSubPix retrieves a pixel rectangle from an image with sub-pixel accuracy.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga77576d06075c1a4b6ba1a608850cd614
Future<Mat> getRectSubPixAsync(
  InputArray image,
  (int, int) patchSize,
  Point2f center, {
  OutputArray? patch,
  int patchType = -1,
}) {
  patch ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_getRectSubPix(image.ref, patchSize.cvd.ref, center.ref, patch!.ref, callback),
    (c) {
      return c.complete(patch);
    },
  );
}

/// GetRotationMatrix2D calculates an affine matrix of 2D rotation.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gafbbc470ce83812914a70abfb604f4326
Future<Mat> getRotationMatrix2DAsync(Point2f center, double angle, double scale) async {
  final mat = Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_getRotationMatrix2D(center.ref, angle, scale, mat.ptr, callback),
    (c) {
      return c.complete(mat);
    },
  );
}

/// WarpAffine applies an affine transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga0203d9ee5fcd28d40dbc4a1ea4451983
Future<Mat> warpAffineAsync(
  InputArray src,
  InputArray M,
  (int, int) dsize, {
  OutputArray? dst,
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  dst ??= Mat.empty();
  borderValue ??= Scalar();
  return cvRunAsync0(
    (callback) => cimgproc.cv_warpAffine_1(
      src.ref,
      dst!.ref,
      M.ref,
      dsize.cvd.ref,
      flags,
      borderMode,
      borderValue!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// WarpPerspective applies a perspective transformation to an image.
/// For more parameters please check WarpPerspectiveWithParams.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaf73673a7e8e18ec6963e3774e6a94b87
Future<Mat> warpPerspectiveAsync(
  InputArray src,
  InputArray M,
  (int, int) dsize, {
  OutputArray? dst,
  int flags = INTER_LINEAR,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  dst ??= Mat.empty();
  borderValue ??= Scalar();
  return cvRunAsync0(
    (callback) => cimgproc.cv_warpPerspective_1(
      src.ref,
      dst!.ref,
      M.ref,
      dsize.cvd.ref,
      flags,
      borderMode,
      borderValue!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Watershed performs a marker-based image segmentation using the watershed algorithm.
///
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/d47/group__imgproc__segmentation.html#ga3267243e4d3f95165d55a618c65ac6e1
Future<Mat> watershedAsync(InputArray image, InputOutputArray markers) async {
  return cvRunAsync0((callback) => cimgproc.cv_watershed(image.ref, markers.ref, callback), (c) {
    return c.complete(markers);
  });
}

/// ApplyColorMap applies a GNU Octave/MATLAB equivalent colormap on a given image.
/// colormap: ColormapTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gadf478a5e5ff49d8aa24e726ea6f65d15
Future<Mat> applyColorMapAsync(InputArray src, int colormap, {OutputArray? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_applyColorMap(src.ref, dst!.ref, colormap, callback), (c) {
    return c.complete(dst);
  });
}

/// ApplyCustomColorMap applies a custom defined colormap on a given image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/d50/group__imgproc__colormap.html#gacb22288ddccc55f9bd9e6d492b409cae
Future<Mat> applyCustomColorMapAsync(InputArray src, InputArray userColor, {OutputArray? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_applyColorMap_1(src.ref, dst!.ref, userColor.ref, callback), (
    c,
  ) {
    return c.complete(dst);
  });
}

/// GetPerspectiveTransform returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Future<Mat> getPerspectiveTransformAsync(VecPoint src, VecPoint dst, [int solveMethod = DECOMP_LU]) async {
  final mat = Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_getPerspectiveTransform(src.ref, dst.ref, mat.ptr, solveMethod, callback),
    (c) {
      return c.complete(mat);
    },
  );
}

/// GetPerspectiveTransform2f returns 3x3 perspective transformation for the
/// corresponding 4 point pairs as gocv.Point2f.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8c1ae0e3589a9d77fffc962c49b22043
Future<Mat> getPerspectiveTransform2fAsync(
  VecPoint2f src,
  VecPoint2f dst, [
  int solveMethod = DECOMP_LU,
]) async {
  final mat = Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_getPerspectiveTransform2f(src.ref, dst.ref, mat.ptr, solveMethod, callback),
    (c) {
      return c.complete(mat);
    },
  );
}

/// GetAffineTransform returns a 2x3 affine transformation matrix for the
/// corresponding 3 point pairs as image.Point.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#ga8f6d378f9f8eebb5cb55cd3ae295a999
Future<Mat> getAffineTransformAsync(VecPoint src, VecPoint dst) async {
  final mat = Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_getAffineTransform(src.ref, dst.ref, mat.ptr, callback), (c) {
    return c.complete(mat);
  });
}

Future<Mat> getAffineTransform2fAsync(VecPoint2f src, VecPoint2f dst) async {
  final mat = Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_getAffineTransform2f(src.ref, dst.ref, mat.ptr, callback), (
    c,
  ) {
    return c.complete(mat);
  });
}

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
  VecVec4i? hierarchy,
  int maxLevel = 0x3f3f3f3f,
  Point? offset,
}) {
  offset ??= Point(0, 0);
  hierarchy ??= VecVec4i();
  return cvRunAsync0(
    (callback) => cimgproc.cv_drawContours_1(
      image.ref,
      contours.ref,
      contourIdx,
      color.ref,
      thickness,
      lineType,
      hierarchy!.ref,
      maxLevel,
      offset!.ref,
      callback,
    ),
    (c) {
      return c.complete(image);
    },
  );
}

/// Remap applies a generic geometrical transformation to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gab75ef31ce5cdfb5c44b6da5f3b908ea4
Future<Mat> remapAsync(
  InputArray src,
  InputArray map1,
  InputArray map2,
  int interpolation, {
  OutputArray? dst,
  int borderMode = BORDER_CONSTANT,
  Scalar? borderValue,
}) {
  borderValue ??= Scalar();
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_remap(
      src.ref,
      dst!.ref,
      map1.ref,
      map2.ref,
      interpolation,
      borderMode,
      borderValue!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Filter2D applies an arbitrary linear filter to an image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga27c049795ce870216ddfb366086b5a04
Future<Mat> filter2DAsync(
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
  return cvRunAsync0(
    (callback) =>
        cimgproc.cv_filter2D(src.ref, dst!.ref, ddepth, kernel.ref, anchor!.ref, delta, borderType, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// SepFilter2D applies a separable linear filter to the image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d4/d86/group__imgproc__filter.html#ga910e29ff7d7b105057d1625a4bf6318d
Future<Mat> sepFilter2DAsync(
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
  return cvRunAsync0(
    (callback) => cimgproc.cv_sepFilter2D(
      src.ref,
      dst!.ref,
      ddepth,
      kernelX.ref,
      kernelY.ref,
      anchor!.ref,
      delta,
      borderType,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// LogPolar remaps an image to semilog-polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaec3a0b126a85b5ca2c667b16e0ae022d
Future<Mat> logPolarAsync(InputArray src, Point2f center, double M, int flags, {OutputArray? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_logPolar(src.ref, dst!.ref, center.ref, M, flags, callback), (
    c,
  ) {
    return c.complete(dst);
  });
}

/// LinearPolar remaps an image to polar coordinates space.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/da/d54/group__imgproc__transform.html#gaa38a6884ac8b6e0b9bed47939b5362f3
Future<Mat> linearPolarAsync(
  InputArray src,
  Point2f center,
  double maxRadius,
  int flags, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_linearPolar(src.ref, dst!.ref, center.ref, maxRadius, flags, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// FitLine fits a line to a 2D or 3D point set.
/// distType: DistanceTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaf849da1fdafa67ee84b1e9a23b93f91f
Future<Mat> fitLineAsync(
  VecPoint points,
  int distType,
  double param,
  double reps,
  double aeps, {
  OutputArray? line,
}) {
  line ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_fitLine(points.ref, line!.ref, distType, param, reps, aeps, callback),
    (c) {
      return c.complete(line);
    },
  );
}

/// FitLine2f fits a line to a 2D or 3D point set.
/// distType: DistanceTypes
/// For further details, please see:
/// https:///docs.opencv.org/master/d3/dc0/group__imgproc__shape.html#gaaf9519f5f52f4d24805d2b64f4049706
Future<Mat> fitLine2fAsync(
  VecPoint2f points,
  int distType,
  double param,
  double reps,
  double aeps, {
  OutputArray? line,
}) {
  line ??= Mat.empty();
  return cvRunAsync0(
    (callback) => cimgproc.cv_fitLine2f(points.ref, line!.ref, distType, param, reps, aeps, callback),
    (c) {
      return c.complete(line);
    },
  );
}

/// Compares two shapes.
/// method: ShapeMatchModes
/// For further details, please see:
/// https:///docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#gaadc90cb16e2362c9bd6e7363e6e4c317
Future<double> matchShapesAsync(VecPoint contour1, VecPoint contour2, int method, double parameter) async {
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_matchShapes(contour1.ref, contour2.ref, method, parameter, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// Inverts an affine transformation.
/// The function computes an inverse affine transformation represented by 2×3 matrix M:
/// The result is also a 2×3 matrix of the same type as M.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/da/d54/group__imgproc__transform.html#ga57d3505a878a7e1a636645727ca08f51
Future<Mat> invertAffineTransformAsync(InputArray M, {OutputArray? iM}) async {
  iM ??= Mat.empty();
  return cvRunAsync0((callback) => cimgproc.cv_invertAffineTransform(M.ref, iM!.ref, callback), (c) {
    return c.complete(iM);
  });
}

/// Apply phaseCorrelate.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga552420a2ace9ef3fb053cd630fdb4952
Future<(Point2f rval, double response)> phaseCorrelateAsync(
  InputArray src1,
  InputArray src2, {
  InputArray? window,
}) {
  window ??= Mat.empty();
  final p = calloc<ffi.Double>();
  final pp = calloc<cvg.CvPoint2f>();
  return cvRunAsync0(
    (callback) => cimgproc.cv_phaseCorrelate(src1.ref, src2.ref, window!.ref, p, pp, callback),
    (c) {
      final rval = (Point2f.fromPointer(pp), p.value);
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga1a567a79901513811ff3b9976923b199
///
Future<Mat> accumulateAsync(InputArray src, InputOutputArray dst, {InputArray? mask}) async {
  if (mask == null) {
    return cvRunAsync0((callback) => cimgproc.cv_accumulate(src.ref, dst.ref, callback), (c) {
      return c.complete(dst);
    });
  } else {
    return cvRunAsync0((callback) => cimgproc.cv_accumulate_1(src.ref, dst.ref, mask.ref, callback), (c) {
      return c.complete(dst);
    });
  }
}

/// Adds the square of a source image to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#gacb75e7ffb573227088cef9ceaf80be8c
Future<Mat> accumulateSquareAsync(InputArray src, InputOutputArray dst, {InputArray? mask}) async {
  if (mask == null) {
    return cvRunAsync0((callback) => cimgproc.cv_accumulateSquare(src.ref, dst.ref, callback), (c) {
      return c.complete(dst);
    });
  } else {
    return cvRunAsync0((callback) => cimgproc.cv_accumulateSquare_1(src.ref, dst.ref, mask.ref, callback), (
      c,
    ) {
      return c.complete(dst);
    });
  }
}

/// Adds the per-element product of two input images to the accumulator image.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga82518a940ecfda49460f66117ac82520
Future<Mat> accumulateProductAsync(
  InputArray src1,
  InputArray src2,
  InputOutputArray dst, {
  InputArray? mask,
}) {
  if (mask == null) {
    return cvRunAsync0((callback) => cimgproc.cv_accumulateProduct(src1.ref, src2.ref, dst.ref, callback), (
      c,
    ) {
      return c.complete(dst);
    });
  } else {
    return cvRunAsync0(
      (callback) => cimgproc.cv_accumulateProduct_1(src1.ref, src2.ref, dst.ref, mask.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}

/// Updates a running average.
///
/// For further details, please see:
/// https:///docs.opencv.org/master/d7/df3/group__imgproc__motion.html#ga4f9552b541187f61f6818e8d2d826bc7
Future<Mat> accumulateWeightedAsync(
  InputArray src,
  InputOutputArray dst,
  double alpha, {
  InputArray? mask,
}) async {
  if (mask == null) {
    return cvRunAsync0((callback) => cimgproc.cv_accumulatedWeighted(src.ref, dst.ref, alpha, callback), (c) {
      return c.complete(dst);
    });
  } else {
    return cvRunAsync0(
      (callback) => cimgproc.cv_accumulatedWeighted_1(src.ref, dst.ref, alpha, mask.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}

/// Finds intersection of two convex polygons.
///
/// https://docs.opencv.org/4.x/d3/dc0/group__imgproc__shape.html#ga06eed475945f155030f2135a7f25f11d
Future<(double rval, VecPoint p12)> intersectConvexConvexAsync(
  VecPoint p1,
  VecPoint p2, {
  VecPoint? p12,
  bool handleNested = true,
}) {
  final r = calloc<ffi.Float>();
  p12 ??= VecPoint();
  return cvRunAsync0(
    (callback) => cimgproc.cv_intersectConvexConvex(p1.ref, p2.ref, p12!.ptr, handleNested, r, callback),
    (c) {
      final rval = (r.value, p12!);
      calloc.free(r);
      return c.complete(rval);
    },
  );
}
