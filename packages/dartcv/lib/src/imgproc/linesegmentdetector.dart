// Copyright (c) 2026, Baptiste DUPUCH, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names
library cv.imgproc.linesegmentdetector;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/cv_vec.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/imgproc.g.dart' as cimgproc;
import '../g/imgproc.g.dart' as cvg;

class LineSegmentDetector extends CvStruct<cvg.LineSegmentDetector> {
  LineSegmentDetector._(cvg.LineSegmentDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory LineSegmentDetector.fromPointer(cvg.LineSegmentDetectorPtr ptr) => LineSegmentDetector._(ptr);

  factory LineSegmentDetector.empty() {
    final p = calloc<cvg.LineSegmentDetector>();
    cimgproc.cv_LineSegmentDetector_create(p);
    return LineSegmentDetector._(p);
  }

  /// Creates a smart pointer to a [LineSegmentDetector] object and initializes it.
  ///
  /// The LineSegmentDetector algorithm is defined using the standard values.
  /// Only advanced users may want to edit those, as to tailor it for their own application.
  ///
  /// Parameters
  ///    - refine The way found lines will be refined, see LineSegmentDetectorModes
  ///    - scale The scale of the image that will be used to find the lines. Range (0..1].
  ///    - sigma_scale Sigma for Gaussian filter. It is computed as sigma = sigma_scale/scale.
  ///    - quant Bound to the quantization error on the gradient norm.
  ///    - ang_th Gradient angle tolerance in degrees.
  ///    - log_eps Detection threshold: -log10(NFA) > log_eps. Used only when advance refinement is chosen.
  ///    - density_th Minimal density of aligned region points in the enclosing rectangle.
  ///    - n_bins Number of bins in pseudo-ordering of gradient modulus.
  ///
  /// https://docs.opencv.org/4.x/dd/d1a/group__imgproc__feature.html#gae0bba3b867a5f44d1b823aef4f57ee8d
  factory LineSegmentDetector({
    int refine = LineSegmentDetector.REFINE_NONE,
    double scale = 0.8,
    double sigmaScale = 0.6,
    double quant = 2.0,
    double angTh = 22.5,
    double logEps = 0,
    double densityTh = 0.7,
    int nBins = 1024,
  }) => LineSegmentDetector.create(
    refine: refine,
    scale: scale,
    sigmaScale: sigmaScale,
    quant: quant,
    angTh: angTh,
    logEps: logEps,
    densityTh: densityTh,
    nBins: nBins,
  );

  /// Creates a smart pointer to a [LineSegmentDetector] object and initializes it.
  ///
  /// The LineSegmentDetector algorithm is defined using the standard values.
  /// Only advanced users may want to edit those, as to tailor it for their own application.
  ///
  /// Parameters
  ///    - refine The way found lines will be refined, see LineSegmentDetectorModes
  ///    - scale The scale of the image that will be used to find the lines. Range (0..1].
  ///    - sigma_scale Sigma for Gaussian filter. It is computed as sigma = sigma_scale/scale.
  ///    - quant Bound to the quantization error on the gradient norm.
  ///    - ang_th Gradient angle tolerance in degrees.
  ///    - log_eps Detection threshold: -log10(NFA) > log_eps. Used only when advance refinement is chosen.
  ///    - density_th Minimal density of aligned region points in the enclosing rectangle.
  ///    - n_bins Number of bins in pseudo-ordering of gradient modulus.
  ///
  /// https://docs.opencv.org/4.x/dd/d1a/group__imgproc__feature.html#gae0bba3b867a5f44d1b823aef4f57ee8d
  factory LineSegmentDetector.create({
    int refine = LineSegmentDetector.REFINE_NONE,
    double scale = 0.8,
    double sigmaScale = 0.6,
    double quant = 2.0,
    double angTh = 22.5,
    double logEps = 0,
    double densityTh = 0.7,
    int nBins = 1024,
  }) {
    final p = calloc<cvg.LineSegmentDetector>();
    cimgproc.cv_LineSegmentDetector_create1(
      refine,
      scale,
      sigmaScale,
      quant,
      angTh,
      logEps,
      densityTh,
      nBins,
      p,
    );
    return LineSegmentDetector._(p);
  }

  static final finalizer = OcvFinalizer<cvg.LineSegmentDetectorPtr>(
    cimgproc.addresses.cv_LineSegmentDetector_close,
  );

  void dispose() {
    finalizer.detach(this);
    cimgproc.cv_LineSegmentDetector_close(ptr);
  }

  @override
  cvg.LineSegmentDetector get ref => ptr.ref;

  /// Finds lines in the input image.
  ///
  /// Parameters
  ///  - image A grayscale (CV_8UC1) input image. If only a roi needs to be selected, use: lsd_ptr-\>detect(image(roi), lines, ...); lines += Scalar(roi.x, roi.y, roi.x, roi.y);
  ///  - lines A vector of Vec4f elements specifying the beginning and ending point of a line. Where Vec4f is (x1, y1, x2, y2), point 1 is the start, point 2 - end. Returned lines are strictly oriented depending on the gradient.
  ///  - width Vector of widths of the regions, where the lines are found. E.g. Width of line.
  ///  - prec Vector of precisions with which the lines are found.
  ///  - nfa Vector containing number of false alarms in the line region, with precision of 10%. The bigger the value, logarithmically better the detection.
  ///
  ///      -1 corresponds to 10 mean false alarms
  ///      0 corresponds to 1 mean false alarm
  ///      1 corresponds to 0.1 mean false alarms This vector will be calculated only when the objects type is LSD_REFINE_ADV.
  ///
  /// https://docs.opencv.org/4.x/db/d73/classcv_1_1LineSegmentDetector.html#acb0cbd33bb3fbcd29a68309850da82fd
  (VecVec4f lines, VecF64 width, VecF64 prec, VecF64 nfa) detect(
    InputArray image, {
    VecVec4f? lines,
    VecF64? width,
    VecF64? prec,
    VecF64? nfa,
  }) {
    lines ??= VecVec4f(); // caller is still responsible for dispose-ing these values
    width ??= VecF64();
    prec ??= VecF64();
    nfa ??= VecF64();

    cvRun(
      () => cimgproc.cv_LineSegmentDetector_detect(
        ref,
        image.ref,
        lines!.ref,
        width!.ref,
        prec!.ref,
        nfa!.ref,
        ffi.nullptr,
      ),
    );
    final rval = (lines, width, prec, nfa);
    return rval;
  }

  /// Finds lines in the input image.
  ///
  /// Parameters
  ///  - image A grayscale (CV_8UC1) input image. If only a roi needs to be selected, use: lsd_ptr-\>detect(image(roi), lines, ...); lines += Scalar(roi.x, roi.y, roi.x, roi.y);
  ///  - lines A vector of Vec4f elements specifying the beginning and ending point of a line. Where Vec4f is (x1, y1, x2, y2), point 1 is the start, point 2 - end. Returned lines are strictly oriented depending on the gradient.
  ///  - width Vector of widths of the regions, where the lines are found. E.g. Width of line.
  ///  - prec Vector of precisions with which the lines are found.
  ///  - nfa Vector containing number of false alarms in the line region, with precision of 10%. The bigger the value, logarithmically better the detection.
  ///     - -1 corresponds to 10 mean false alarms
  ///     - 0 corresponds to 1 mean false alarm
  ///     - 1 corresponds to 0.1 mean false alarms This vector will be calculated only when the objects type is LSD_REFINE_ADV.
  ///
  /// https://docs.opencv.org/4.x/db/d73/classcv_1_1LineSegmentDetector.html#acb0cbd33bb3fbcd29a68309850da82fd
  Future<(VecVec4f lines, VecF64 width, VecF64 prec, VecF64 nfa)> detectAsync(
    InputArray image, {
    VecVec4f? lines,
    VecF64? width,
    VecF64? prec,
    VecF64? nfa,
  }) async {
    lines ??= VecVec4f(); // caller is still responsible for dispose-ing these values
    width ??= VecF64();
    prec ??= VecF64();
    nfa ??= VecF64();

    return cvRunAsync0(
      (callback) => cimgproc.cv_LineSegmentDetector_detect(
        ref,
        image.ref,
        lines!.ref,
        width!.ref,
        prec!.ref,
        nfa!.ref,
        callback,
      ),
      (c) {
        final rval = (lines!, width!, prec!, nfa!);
        return c.complete(rval);
      },
    );
  }

  /// Draws the line segments on a given image.
  ///
  /// Parameters
  ///     - image The image, where the lines will be drawn. Should be bigger or equal to the image, where the lines were found.
  ///     - lines A vector of the lines that needed to be drawn.
  ///
  /// https://docs.opencv.org/4.x/db/d73/classcv_1_1LineSegmentDetector.html#aff3fef3cc44188e264e0d27ee6312be2
  void drawSegments(InputArray image, VecVec4f lines) {
    cvRun(() => cimgproc.cv_LineSegmentDetector_drawSegments(ref, image.ref, lines.ref, ffi.nullptr));
  }

  /// Draws two groups of lines in blue and red, counting the non overlapping (mismatching) pixels.
  ///
  /// Parameters
  ///     - size The size of the image, where lines1 and lines2 were found.
  ///     - lines1 The first group of lines that needs to be drawn. It is visualized in blue color.
  ///     - lines2 The second group of lines. They visualized in red color.
  ///     - image Optional image, where the lines will be drawn. The image should be color(3-channel) in order for lines1 and lines2 to be drawn in the above mentioned colors.
  ///
  /// https://docs.opencv.org/4.x/db/d73/classcv_1_1LineSegmentDetector.html#a6f9082d8c459410efcbb9f9da4fd7b4d
  (int rval, Mat imageOut) compareSegments(
    InputArray image,
    (int, int) size,
    VecVec4f lines1,
    VecVec4f lines2, {
    Mat? imageOut,
  }) {
    imageOut ??= Mat.empty();
    final sz = size.toSize();
    final prval = calloc<ffi.Int>();
    cvRun(
      () => cimgproc.cv_LineSegmentDetector_compareSegments(
        ref,
        sz.ref,
        lines1.ref,
        lines2.ref,
        imageOut!.ref,
        prval,
        ffi.nullptr,
      ),
    );
    final rval = (prval.value, imageOut);
    calloc.free(prval);
    sz.dispose();
    return rval;
  }

  @override
  String toString() {
    return "LineSegmentDetector(address=0x${ptr.address.toRadixString(16)})";
  }

  /// No refinement applied.
  static const int REFINE_NONE = 0;

  /// Standard refinement is applied. E.g. breaking arches into smaller straighter line approximations.
  static const int REFINE_STD = 1;

  /// Advanced refinement. Number of false alarms is calculated,
  /// lines are refined through increase of precision, decrement in size, etc.
  static const int REFINE_ADV = 2;
}
