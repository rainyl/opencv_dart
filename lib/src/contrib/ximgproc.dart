// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

class ximgproc {
  static Mat anisotropicDiffusion(
    InputArray src,
    double alpha,
    double K,
    int niters, {
    OutputArray? dst,
  }) {
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_anisotropicDiffusion(src.ref, p, alpha, K, niters));
    return dst ?? Mat.fromPointer(p);
  }

  static Mat edgePreservingFilter(InputArray src, int d, double threshold, {OutputArray? dst}) {
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_edgePreservingFilter(src.ref, p, d, threshold));
    return dst ?? Mat.fromPointer(p);
  }

  static Mat findEllipses(InputArray image,
      {OutputArray? ellipses,
      double scoreThreshold = 0.7,
      double reliabilityThreshold = 0.5,
      double centerDistanceThreshold = 0.05}) {
    final p = ellipses?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_findEllipses(
        image.ref, p, scoreThreshold, reliabilityThreshold, centerDistanceThreshold));
    return ellipses ?? Mat.fromPointer(p);
  }

  static Mat niBlackThreshold(
    InputArray src,
    double maxValue,
    int type,
    int blockSize,
    double k, {
    OutputArray? dst,
    int binarizationMethod = BINARIZATION_NIBLACK,
    double r = 128,
  }) {
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_niBlackThreshold(
        src.ref, p, maxValue, type, blockSize, k, binarizationMethod, r));
    return dst ?? Mat.fromPointer(p);
  }

  static Mat PeiLinNormalization(InputArray I, {OutputArray? T}) {
    final p = T?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_PeiLinNormalization(I.ref, p));
    return T ?? Mat.fromPointer(p);
  }

  static Mat thinning(InputArray src, {OutputArray? dst, int thinningType = THINNING_ZHANGSUEN}) {
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_thinning(src.ref, p, thinningType));
    return dst ?? Mat.fromPointer(p);
  }

  static const int THINNING_ZHANGSUEN = 0;
  static const int THINNING_GUOHALL = 1;

  static const int BINARIZATION_NIBLACK = 0;
  static const int BINARIZATION_SAUVOLA = 1;
  static const int BINARIZATION_WOLF = 2;
  static const int BINARIZATION_NICK = 3;
}
