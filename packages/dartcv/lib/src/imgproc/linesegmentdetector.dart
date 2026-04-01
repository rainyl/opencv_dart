// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names
library cv.imgproc.linesegmentdetector;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/cv_vec.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/vec.dart';
import '../g/imgproc.g.dart' as cvg;
import '../g/imgproc.g.dart' as cimgproc;

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

  factory LineSegmentDetector([int refine = LineSegmentDetector.REFINE_NONE, double scale = 0.8, double sigmaScale = 0.6, double quant = 2.0, double angTh = 22.5, double logEps = 0, double densityTh = 0.7, int nBins = 1024]) => LineSegmentDetector.create(refine, scale, sigmaScale, quant, angTh, logEps, densityTh, nBins);

  factory LineSegmentDetector.create([int refine = LineSegmentDetector.REFINE_NONE, double scale = 0.8, double sigmaScale = 0.6, double quant = 2.0, double angTh = 22.5, double logEps = 0, double densityTh = 0.7, int nBins = 1024]) {
    final p = calloc<cvg.LineSegmentDetector>();
    cimgproc.cv_LineSegmentDetector_create1(refine, scale, sigmaScale, quant, angTh, logEps, densityTh, nBins, p);
    return LineSegmentDetector._(p);
  }

  static final finalizer = OcvFinalizer<cvg.LineSegmentDetectorPtr>(cimgproc.addresses.cv_LineSegmentDetector_close);

  void dispose() {
    finalizer.detach(this);
    cimgproc.cv_LineSegmentDetector_close(ptr);
  }

  @override
  cvg.LineSegmentDetector get ref => ptr.ref;

  (int rval, VecVec4f lines, VecF64 width, VecF64 prec, VecF64 nfa) detect(
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

    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_LineSegmentDetector_detect(ref, image.ref, lines!.ref, width!.ref, prec!.ref, nfa!.ref, p, ffi.nullptr));
    final rval = (p.value, lines, width, prec, nfa);
    calloc.free(p);
    return rval;
  }

  static const int REFINE_NONE = 0;
  static const int REFINE_STD = 1;
  static const int REFINE_ADV = 2;
}
