// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names

library cv.contrib.ximgproc;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as cvg;
import '../native_lib.dart' show ccontrib;

class ximgproc {
  /// Performs anisotropic diffusion on an image.
  ///
  /// The function applies Perona-Malik anisotropic diffusion to an image.
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#gaffedd976e0a8efb5938107acab185ec2
  static Mat anisotropicDiffusion(InputArray src, double alpha, double K, int niters, {OutputArray? dst}) {
    dst ??= Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_anisotropicDiffusion(src.ref, dst!.ref, alpha, K, niters, ffi.nullptr));
    return dst;
  }

  /// Performs anisotropic diffusion on an image.
  ///
  /// The function applies Perona-Malik anisotropic diffusion to an image.
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#gaffedd976e0a8efb5938107acab185ec2
  static Future<Mat> anisotropicDiffusionAsync(
    InputArray src,
    double alpha,
    double K,
    int niters, {
    OutputArray? dst,
  }) async {
    dst ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_anisotropicDiffusion(src.ref, dst!.ref, alpha, K, niters, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Smoothes an image using the Edge-Preserving filter.
  ///
  /// The function smoothes Gaussian noise as well as salt & pepper noise.
  /// For more details about this implementation, please see ReiWoe18 Reich,
  /// S. and Wörgötter, F. and Dellen, B. (2018). A Real-Time Edge-Preserving Denoising Filter.
  /// Proceedings of the 13th International Joint Conference on Computer Vision,
  /// Imaging and Computer Graphics Theory and Applications (VISIGRAPP): Visapp, 85-94, 4.
  /// DOI: 10.5220/0006509000850094.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga86fcda65ced0aafa2741088d82e9161c
  static Mat edgePreservingFilter(InputArray src, int d, double threshold, {OutputArray? dst}) {
    dst ??= Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_edgePreservingFilter(src.ref, dst!.ref, d, threshold, ffi.nullptr));
    return dst;
  }

  /// Smoothes an image using the Edge-Preserving filter.
  ///
  /// The function smoothes Gaussian noise as well as salt & pepper noise.
  /// For more details about this implementation, please see ReiWoe18 Reich,
  /// S. and Wörgötter, F. and Dellen, B. (2018). A Real-Time Edge-Preserving Denoising Filter.
  /// Proceedings of the 13th International Joint Conference on Computer Vision,
  /// Imaging and Computer Graphics Theory and Applications (VISIGRAPP): Visapp, 85-94, 4.
  /// DOI: 10.5220/0006509000850094.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga86fcda65ced0aafa2741088d82e9161c
  static Future<Mat> edgePreservingFilterAsync(
    InputArray src,
    int d,
    double threshold, {
    OutputArray? dst,
  }) async {
    dst ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_edgePreservingFilter(src.ref, dst!.ref, d, threshold, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Finds ellipses fastly in an image using projective invariant pruning.
  ///
  /// The function detects ellipses in images using projective invariant pruning.
  /// For more details about this implementation, please see
  /// [137] Jia, Qi et al, (2017). A Fast Ellipse Detector using Projective Invariant Pruning.
  /// IEEE Transactions on Image Processing.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga45405d89eeaa32d00e5a3d1ecc3090c2
  static Mat findEllipses(
    InputArray image, {
    OutputArray? ellipses,
    double scoreThreshold = 0.7,
    double reliabilityThreshold = 0.5,
    double centerDistanceThreshold = 0.05,
  }) {
    ellipses ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_ximgproc_findEllipses(
        image.ref,
        ellipses!.ref,
        scoreThreshold,
        reliabilityThreshold,
        centerDistanceThreshold,
        ffi.nullptr,
      ),
    );
    return ellipses;
  }

  /// Finds ellipses fastly in an image using projective invariant pruning.
  ///
  /// The function detects ellipses in images using projective invariant pruning.
  /// For more details about this implementation, please see
  /// [137] Jia, Qi et al, (2017). A Fast Ellipse Detector using Projective Invariant Pruning.
  /// IEEE Transactions on Image Processing.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga45405d89eeaa32d00e5a3d1ecc3090c2
  static Future<Mat> findEllipsesAsync(
    InputArray image, {
    OutputArray? ellipses,
    double scoreThreshold = 0.7,
    double reliabilityThreshold = 0.5,
    double centerDistanceThreshold = 0.05,
  }) async {
    ellipses ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_findEllipses(
        image.ref,
        ellipses!.ref,
        scoreThreshold,
        reliabilityThreshold,
        centerDistanceThreshold,
        callback,
      ),
      (c) {
        return c.complete(ellipses);
      },
    );
  }

  /// Performs thresholding on input images using Niblack's technique or some of
  /// the popular variations it inspired.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#gab042a5032bbb85275f1fd3e04e7c7660
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
    dst ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_ximgproc_niBlackThreshold(
        src.ref,
        dst!.ref,
        maxValue,
        type,
        blockSize,
        k,
        binarizationMethod,
        r,
        ffi.nullptr,
      ),
    );
    return dst;
  }

  /// Performs thresholding on input images using Niblack's technique or some of
  /// the popular variations it inspired.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#gab042a5032bbb85275f1fd3e04e7c7660
  static Future<Mat> niBlackThresholdAsync(
    InputArray src,
    double maxValue,
    int type,
    int blockSize,
    double k, {
    OutputArray? dst,
    int binarizationMethod = BINARIZATION_NIBLACK,
    double r = 128,
  }) async {
    dst ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_niBlackThreshold(
        src.ref,
        dst!.ref,
        maxValue,
        type,
        blockSize,
        k,
        binarizationMethod,
        r,
        callback,
      ),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Calculates an affine transformation that normalize given image using Pei&Lin Normalization.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga50d064b92f63916f4162474eea22d656
  static Mat PeiLinNormalization(InputArray I, {OutputArray? T}) {
    T ??= Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_PeiLinNormalization(I.ref, T!.ref, ffi.nullptr));
    return T;
  }

  /// Calculates an affine transformation that normalize given image using Pei&Lin Normalization.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga50d064b92f63916f4162474eea22d656
  static Future<Mat> PeiLinNormalizationAsync(InputArray I, {OutputArray? T}) async {
    T ??= Mat.empty();
    return cvRunAsync0((callback) => ccontrib.cv_ximgproc_PeiLinNormalization(I.ref, T!.ref, callback), (c) {
      return c.complete(T);
    });
  }

  /// Applies a binary blob thinning operation, to achieve a skeletization of the input image.
  ///
  /// The function transforms a binary blob image into a skeletized form using the
  /// technique of Zhang-Suen.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga37002c6ca80c978edb6ead5d6b39740c
  static Mat thinning(InputArray src, {OutputArray? dst, int thinningType = THINNING_ZHANGSUEN}) {
    dst ??= Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_thinning(src.ref, dst!.ref, thinningType, ffi.nullptr));
    return dst;
  }

  /// Applies a binary blob thinning operation, to achieve a skeletization of the input image.
  ///
  /// The function transforms a binary blob image into a skeletized form using the
  /// technique of Zhang-Suen.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga37002c6ca80c978edb6ead5d6b39740c
  static Future<Mat> thinningAsync(
    InputArray src, {
    OutputArray? dst,
    int thinningType = THINNING_ZHANGSUEN,
  }) async {
    dst ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_thinning(src.ref, dst!.ref, thinningType, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  static const int THINNING_ZHANGSUEN = 0;
  static const int THINNING_GUOHALL = 1;

  static const int BINARIZATION_NIBLACK = 0;
  static const int BINARIZATION_SAUVOLA = 1;
  static const int BINARIZATION_WOLF = 2;
  static const int BINARIZATION_NICK = 3;
}

/// https://docs.opencv.org/4.x/dd/d65/classcv_1_1ximgproc_1_1EdgeBoxes.html#details
class EdgeBoxes extends CvStruct<cvg.EdgeBoxes> {
  EdgeBoxes.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  /// https://docs.opencv.org/4.x/dd/d65/classcv_1_1ximgproc_1_1EdgeBoxes.html#details
  factory EdgeBoxes({
    double alpha = 0.65,
    double beta = 0.75,
    double eta = 1,
    double minScore = 0.01,
    int maxBoxes = 10000,
    double edgeMinMag = 0.1,
    double edgeMergeThr = 0.5,
    double clusterMinMag = 0.5,
    double maxAspectRatio = 3,
    double minBoxArea = 1000,
    double gamma = 2,
    double kappa = 1.5,
  }) {
    final p = calloc<cvg.EdgeBoxes>();
    cvRun(
      () => ccontrib.cv_ximgproc_EdgeBoxes_create(
        alpha,
        beta,
        eta,
        minScore,
        maxBoxes,
        edgeMinMag,
        edgeMergeThr,
        clusterMinMag,
        maxAspectRatio,
        minBoxArea,
        gamma,
        kappa,
        p,
      ),
    );
    return EdgeBoxes.fromPointer(p);
  }

  /// Returns array containing proposal boxes.
  ///
  /// https://docs.opencv.org/4.x/dd/d65/classcv_1_1ximgproc_1_1EdgeBoxes.html#a822e422556f8103d01a0a4db6815f0e5
  (VecRect boxes, VecF32 scores) getBoundingBoxes(InputArray edge_map, InputArray orientation_map) {
    final pvr = VecRect();
    final pvf = VecF32();
    cvRun(
      () => ccontrib.cv_ximgproc_EdgeBoxes_getBoundingBoxes(
        ref,
        edge_map.ref,
        orientation_map.ref,
        pvr.ptr,
        pvf.ptr,
        ffi.nullptr,
      ),
    );
    return (pvr, pvf);
  }

  double get alpha => ccontrib.cv_ximgproc_EdgeBoxes_getAlpha(ref);
  set alpha(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setAlpha(ref, value);

  double get beta => ccontrib.cv_ximgproc_EdgeBoxes_getBeta(ref);
  set beta(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setBeta(ref, value);

  double get eta => ccontrib.cv_ximgproc_EdgeBoxes_getEta(ref);
  set eta(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setEta(ref, value);

  double get minScore => ccontrib.cv_ximgproc_EdgeBoxes_getMinScore(ref);
  set minScore(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setMinScore(ref, value);

  int get maxBoxes => ccontrib.cv_ximgproc_EdgeBoxes_getMaxBoxes(ref);
  set maxBoxes(int value) => ccontrib.cv_ximgproc_EdgeBoxes_setMaxBoxes(ref, value);

  double get edgeMinMag => ccontrib.cv_ximgproc_EdgeBoxes_getEdgeMinMag(ref);
  set edgeMinMag(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setEdgeMinMag(ref, value);

  double get edgeMergeThr => ccontrib.cv_ximgproc_EdgeBoxes_getEdgeMergeThr(ref);
  set edgeMergeThr(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setEdgeMergeThr(ref, value);

  double get clusterMinMag => ccontrib.cv_ximgproc_EdgeBoxes_getClusterMinMag(ref);
  set clusterMinMag(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setClusterMinMag(ref, value);

  double get maxAspectRatio => ccontrib.cv_ximgproc_EdgeBoxes_getMaxAspectRatio(ref);
  set maxAspectRatio(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setMaxAspectRatio(ref, value);

  double get minBoxArea => ccontrib.cv_ximgproc_EdgeBoxes_getMinBoxArea(ref);
  set minBoxArea(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setMinBoxArea(ref, value);

  double get gamma => ccontrib.cv_ximgproc_EdgeBoxes_getGamma(ref);
  set gamma(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setGamma(ref, value);

  double get kappa => ccontrib.cv_ximgproc_EdgeBoxes_getKappa(ref);
  set kappa(double value) => ccontrib.cv_ximgproc_EdgeBoxes_setKappa(ref, value);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<num> get props => [
    alpha,
    beta,
    eta,
    minScore,
    maxBoxes,
    edgeMinMag,
    edgeMergeThr,
    clusterMinMag,
    maxAspectRatio,
    minBoxArea,
    gamma,
    kappa,
  ];

  @override
  cvg.EdgeBoxes get ref => ptr.ref;
}

class RFFeatureGetter extends CvStruct<cvg.RFFeatureGetter> {
  RFFeatureGetter.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory RFFeatureGetter.empty() {
    final p = calloc<cvg.RFFeatureGetter>();
    cvRun(() => ccontrib.cv_ximgproc_RFFeatureGetter_create(p));
    return RFFeatureGetter.fromPointer(p);
  }

  Mat getFeatures(InputArray src, int gnrmRad, int gsmthRad, int shrink, int outNum, int gradNum) {
    final dst = Mat.empty();
    cvRun(
      () => ccontrib.cv_ximgproc_RFFeatureGetter_getFeatures(
        ref,
        src.ref,
        dst.ref,
        gnrmRad,
        gsmthRad,
        shrink,
        outNum,
        gradNum,
        ffi.nullptr,
      ),
    );
    return dst;
  }

  void clear() => cvRun(() => ccontrib.cv_ximgproc_RFFeatureGetter_clear(ref));

  bool isEmpty() => ccontrib.cv_ximgproc_RFFeatureGetter_empty(ref);

  static final finalizer = OcvFinalizer<cvg.RFFeatureGetterPtr>(
    ccontrib.addresses.cv_ximgproc_RFFeatureGetter_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_ximgproc_RFFeatureGetter_close(ptr);
  }

  @override
  cvg.RFFeatureGetter get ref => ptr.ref;
}

/// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#details
class StructuredEdgeDetection extends CvStruct<cvg.StructuredEdgeDetection> {
  StructuredEdgeDetection.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  /// https://docs.opencv.org/4.x/de/d51/group__ximgproc__edge.html#ga2aad8b0b32e05d82200348dcf5b32066
  factory StructuredEdgeDetection.create(String model) {
    final cmodel = model.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<cvg.StructuredEdgeDetection>();
    cvRun(() => ccontrib.cv_ximgproc_StructuredEdgeDetection_create(cmodel, p));
    calloc.free(cmodel);
    return StructuredEdgeDetection.fromPointer(p);
  }

  /// The function computes orientation from edge image.
  ///
  /// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#a4ef982e80edccef6e92da9db2c20a222
  Mat computeOrientation(Mat src) {
    final dst = Mat.empty();
    cvRun(
      () =>
          ccontrib.cv_ximgproc_StructuredEdgeDetection_computeOrientation(ref, src.ref, dst.ref, ffi.nullptr),
    );
    return dst;
  }

  /// The function detects edges in src and draw them to dst.
  ///
  /// The algorithm underlies this function is much more robust to texture presence,
  /// than common approaches, e.g. Sobel
  ///
  /// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#a31308e06ffea4507b5feb2e1856b1bd8
  Mat detectEdges(InputArray src) {
    cvAssert(src.type.depth == MatType.CV_32F);
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_StructuredEdgeDetection_detectEdges(ref, src.ref, dst.ref, ffi.nullptr));
    return dst;
  }

  /// The function edgenms in edge image and suppress edges where edge is stronger in orthogonal direction.
  ///
  /// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#acbf4fc0ffd8237e53bfc83804c854148
  Mat edgesNms(
    InputArray edgeImage,
    InputArray orientationImage, {
    int r = 2,
    int s = 0,
    double m = 1,
    bool isParallel = true,
  }) {
    final dst = Mat.empty();
    cvRun(
      () => ccontrib.cv_ximgproc_StructuredEdgeDetection_edgesNms(
        ref,
        edgeImage.ref,
        orientationImage.ref,
        dst.ref,
        r,
        s,
        m,
        isParallel,
        ffi.nullptr,
      ),
    );
    return dst;
  }

  static final finalizer = OcvFinalizer<cvg.StructuredEdgeDetectionPtr>(
    ccontrib.addresses.cv_ximgproc_StructuredEdgeDetection_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_ximgproc_StructuredEdgeDetection_close(ptr);
  }

  @override
  cvg.StructuredEdgeDetection get ref => ptr.ref;
}

/// https://docs.opencv.org/4.x/dd/d19/classcv_1_1ximgproc_1_1segmentation_1_1GraphSegmentation.html
class GraphSegmentation extends CvStruct<cvg.GraphSegmentation> {
  GraphSegmentation.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  /// https://docs.opencv.org/4.x/d5/df0/group__ximgproc__segmentation.html#gae067b832eee0d26aa30269a7ae423d2f
  factory GraphSegmentation.create({double sigma = 0.5, double k = 300, int minSize = 100}) {
    final p = calloc<cvg.GraphSegmentation>();
    cvRun(() => ccontrib.cv_ximgproc_GraphSegmentation_create(sigma, k, minSize, p));
    return GraphSegmentation.fromPointer(p);
  }

  /// Segment an image and store output in dst.
  ///
  /// https://docs.opencv.org/4.x/dd/d19/classcv_1_1ximgproc_1_1segmentation_1_1GraphSegmentation.html#a13a3603cb371d740c3c4b01d63553d90
  Mat processImage(Mat src) {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_GraphSegmentation_processImage(ref, src.ref, dst.ref, ffi.nullptr));
    return dst;
  }

  double get K => ccontrib.cv_ximgproc_GraphSegmentation_getK(ref);

  set K(double value) => ccontrib.cv_ximgproc_GraphSegmentation_setK(ref, value);

  double get sigma => ccontrib.cv_ximgproc_GraphSegmentation_getSigma(ref);

  set sigma(double value) => ccontrib.cv_ximgproc_GraphSegmentation_setSigma(ref, value);

  int get minSize => ccontrib.cv_ximgproc_GraphSegmentation_getMinSize(ref);

  set minSize(int value) => ccontrib.cv_ximgproc_GraphSegmentation_setMinSize(ref, value);

  static final finalizer = OcvFinalizer<cvg.GraphSegmentationPtr>(
    ccontrib.addresses.cv_ximgproc_GraphSegmentation_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_ximgproc_GraphSegmentation_close(ptr);
  }

  @override
  cvg.GraphSegmentation get ref => ptr.ref;
}

class EdgeDrawingParams extends CvStruct<cvg.EdgeDrawingParams> {
  EdgeDrawingParams.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory EdgeDrawingParams({
    int AnchorThresholdValue = 0,
    int EdgeDetectionOperator = PREWITT,
    int GradientThresholdValue = 20,
    double LineFitErrorThreshold = 1.0,
    double MaxDistanceBetweenTwoLines = 6.0,
    double MaxErrorThreshold = 1.3,
    int MinLineLength = -1,
    int MinPathLength = 10,
    bool NFAValidation = true,
    bool PFmode = false,
    int ScanInterval = 1,
    double Sigma = 1.0,
    bool SumFlag = true,
  }) {
    final p =
        calloc<cvg.EdgeDrawingParams>()
          ..ref.AnchorThresholdValue = AnchorThresholdValue
          ..ref.EdgeDetectionOperator = EdgeDetectionOperator
          ..ref.GradientThresholdValue = GradientThresholdValue
          ..ref.LineFitErrorThreshold = LineFitErrorThreshold
          ..ref.MaxDistanceBetweenTwoLines = MaxDistanceBetweenTwoLines
          ..ref.MaxErrorThreshold = MaxErrorThreshold
          ..ref.MinLineLength = MinLineLength
          ..ref.MinPathLength = MinPathLength
          ..ref.NFAValidation = NFAValidation
          ..ref.PFmode = PFmode
          ..ref.ScanInterval = ScanInterval
          ..ref.Sigma = Sigma
          ..ref.SumFlag = SumFlag;
    return EdgeDrawingParams.fromPointer(p);
  }

  int get AnchorThresholdValue => ref.AnchorThresholdValue;
  set AnchorThresholdValue(int value) => ref.AnchorThresholdValue = value;

  int get EdgeDetectionOperator => ref.EdgeDetectionOperator;
  set EdgeDetectionOperator(int value) => ref.EdgeDetectionOperator = value;

  int get GradientThresholdValue => ref.GradientThresholdValue;
  set GradientThresholdValue(int value) => ref.GradientThresholdValue = value;

  double get LineFitErrorThreshold => ref.LineFitErrorThreshold;
  set LineFitErrorThreshold(double value) => ref.LineFitErrorThreshold = value;

  double get MaxDistanceBetweenTwoLines => ref.MaxDistanceBetweenTwoLines;
  set MaxDistanceBetweenTwoLines(double value) => ref.MaxDistanceBetweenTwoLines = value;

  double get MaxErrorThreshold => ref.MaxErrorThreshold;
  set MaxErrorThreshold(double value) => ref.MaxErrorThreshold = value;

  int get MinLineLength => ref.MinLineLength;
  set MinLineLength(int value) => ref.MinLineLength = value;

  int get MinPathLength => ref.MinPathLength;
  set MinPathLength(int value) => ref.MinPathLength = value;

  bool get NFAValidation => ref.NFAValidation;
  set NFAValidation(bool value) => ref.NFAValidation = value;

  bool get PFmode => ref.PFmode;
  set PFmode(bool value) => ref.PFmode = value;

  int get ScanInterval => ref.ScanInterval;
  set ScanInterval(int value) => ref.ScanInterval = value;

  double get Sigma => ref.Sigma;
  set Sigma(double value) => ref.Sigma = value;

  bool get SumFlag => ref.SumFlag;
  set SumFlag(bool value) => ref.SumFlag = value;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  List<Object?> get props => [
    AnchorThresholdValue,
    EdgeDetectionOperator,
    GradientThresholdValue,
    LineFitErrorThreshold,
    MaxDistanceBetweenTwoLines,
    MaxErrorThreshold,
    MinLineLength,
    MinPathLength,
    NFAValidation,
    PFmode,
    ScanInterval,
    Sigma,
    SumFlag,
  ];

  @override
  cvg.EdgeDrawingParams get ref => ptr.ref;

  static const int PREWITT = 0;
  static const int SOBEL = 1;
  static const int SCHARR = 2;
  static const int LSD = 3;
}

class EdgeDrawing extends CvStruct<cvg.EdgeDrawing> {
  EdgeDrawing.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  /// Creates a smart pointer to a EdgeDrawing object and initializes it.
  factory EdgeDrawing.empty() {
    final p = calloc<cvg.EdgeDrawing>();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_create(p));
    return EdgeDrawing.fromPointer(p);
  }

  /// Segment an image and store output in dst.
  ///
  /// https://docs.opencv.org/4.x/dd/d19/classcv_1_1ximgproc_1_1segmentation_1_1GraphSegmentation.html#a13a3603cb371d740c3c4b01d63553d90
  void detectEdges(Mat src) =>
      cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_detectEdges(ref, src.ref, ffi.nullptr));

  Mat detectEllipses() {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_detectEllipses(ref, dst.ref, ffi.nullptr));
    return dst;
  }

  Mat detectLines() {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_detectLines(ref, dst.ref, ffi.nullptr));
    return dst;
  }

  Mat getEdgeImage() {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_getEdgeImage(ref, dst.ref, ffi.nullptr));
    return dst;
  }

  Mat getGradientImage() {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_getGradientImage(ref, dst.ref, ffi.nullptr));
    return dst;
  }

  VecI32 getSegmentIndicesOfLines() {
    final v = VecI32();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_getSegmentIndicesOfLines(ref, v.ptr, ffi.nullptr));
    return v;
  }

  VecVecPoint getSegments() {
    final p = VecVecPoint();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_getSegments(ref, p.ptr, ffi.nullptr));
    return p;
  }

  EdgeDrawingParams get params {
    final p = calloc<cvg.EdgeDrawingParams>();
    cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_getParams(ref, p, ffi.nullptr));
    return EdgeDrawingParams.fromPointer(p);
  }

  set params(EdgeDrawingParams value) =>
      cvRun(() => ccontrib.cv_ximgproc_EdgeDrawing_setParams(ref, value.ref, ffi.nullptr));

  static final finalizer = OcvFinalizer<cvg.EdgeDrawingPtr>(ccontrib.addresses.cv_ximgproc_EdgeDrawing_close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_ximgproc_EdgeDrawing_close(ptr);
  }

  @override
  cvg.EdgeDrawing get ref => ptr.ref;
}

class ximgproc_rl {
  ///Creates a run-length encoded image from a vector of runs (column begin, column end, row)
  ///
  ///https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gaa2b3524997874269670f2f63d54d792d
  static Mat createRLEImage(VecPoint3i runs, {(int, int) size = (0, 0)}) {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_rl_createRLEImage(runs.ref, dst.ref, size.cvd.ref, ffi.nullptr));
    return dst;
  }

  ///Creates a run-length encoded image from a vector of runs (column begin, column end, row)
  ///
  ///https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gaa2b3524997874269670f2f63d54d792d
  static Future<Mat> createRLEImageAsync(VecPoint3i runs, {(int, int) size = (0, 0)}) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_rl_createRLEImage(runs.ref, dst.ref, size.cvd.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Dilates an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gac3de990089892266fa30189edcb6da3c
  static Mat dilate(InputArray rlSrc, InputArray rlKernel, {(int, int) anchor = (0, 0)}) {
    final dst = Mat.empty();
    cvRun(
      () =>
          ccontrib.cv_ximgproc_rl_dilate(rlSrc.ref, dst.ref, rlKernel.ref, anchor.toPoint().ref, ffi.nullptr),
    );
    return dst;
  }

  /// Dilates an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gac3de990089892266fa30189edcb6da3c
  static Future<Mat> dilateAsync(InputArray rlSrc, InputArray rlKernel, {(int, int) anchor = (0, 0)}) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) =>
          ccontrib.cv_ximgproc_rl_dilate(rlSrc.ref, dst.ref, rlKernel.ref, anchor.toPoint().ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Erodes an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga1903619622035efbe28ad08151f60ec3
  static Mat erode(
    InputArray rlSrc,
    InputArray rlKernel, {
    bool bBoundaryOn = true,
    (int, int) anchor = (0, 0),
  }) {
    final dst = Mat.empty();
    cvRun(
      () => ccontrib.cv_ximgproc_rl_erode(
        rlSrc.ref,
        dst.ref,
        rlKernel.ref,
        bBoundaryOn,
        anchor.toPoint().ref,
        ffi.nullptr,
      ),
    );
    return dst;
  }

  /// Erodes an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga1903619622035efbe28ad08151f60ec3
  static Future<Mat> erodeAsync(
    InputArray rlSrc,
    InputArray rlKernel, {
    bool bBoundaryOn = true,
    (int, int) anchor = (0, 0),
  }) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_rl_erode(
        rlSrc.ref,
        dst.ref,
        rlKernel.ref,
        bBoundaryOn,
        anchor.toPoint().ref,
        callback,
      ),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Returns a run length encoded structuring element of the specified size and shape.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga8a7c10c524fb2572e2eefe0caf0375fc
  static Mat getStructuringElement(int shape, (int, int) ksize) {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_rl_getStructuringElement(shape, ksize.cvd.ref, dst.ptr, ffi.nullptr));
    return dst;
  }

  /// Returns a run length encoded structuring element of the specified size and shape.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga8a7c10c524fb2572e2eefe0caf0375fc
  static Future<Mat> getStructuringElementAsync(int shape, (int, int) ksize) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_rl_getStructuringElement(shape, ksize.cvd.ref, dst.ptr, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Check whether a custom made structuring element can be used with run length morphological operations.
  /// (It must consist of a continuous array of single runs per row)
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga85ed82296e9e9893dcbaa92b87837019
  static bool isRLMorphologyPossible(InputArray rlStructuringElement) =>
      ccontrib.cv_ximgproc_rl_isRLMorphologyPossible(rlStructuringElement.ref);

  /// Applies a morphological operation to a run-length encoded binary image.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga939a4d8afa86b012f6e3d006e6a32180
  static Mat morphologyEx(
    InputArray rlSrc,
    int op,
    InputArray rlKernel, {
    bool bBoundaryOnForErosion = true,
    (int, int) anchor = (0, 0),
  }) {
    final dst = Mat.empty();
    cvRun(
      () => ccontrib.cv_ximgproc_rl_morphologyEx(
        rlSrc.ref,
        dst.ref,
        op,
        rlKernel.ref,
        bBoundaryOnForErosion,
        anchor.toPoint().ref,
        ffi.nullptr,
      ),
    );
    return dst;
  }

  /// Applies a morphological operation to a run-length encoded binary image.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga939a4d8afa86b012f6e3d006e6a32180
  static Future<Mat> morphologyExAsync(
    InputArray rlSrc,
    int op,
    InputArray rlKernel, {
    bool bBoundaryOnForErosion = true,
    (int, int) anchor = (0, 0),
  }) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_rl_morphologyEx(
        rlSrc.ref,
        dst.ref,
        op,
        rlKernel.ref,
        bBoundaryOnForErosion,
        anchor.toPoint().ref,
        callback,
      ),
      (c) {
        return c.complete(dst);
      },
    );
  }

  /// Paint run length encoded binary image into an image.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga7cabc1c2901b8b58082f8febc366638b
  static Mat paint(InputOutputArray image, InputArray rlSrc, Scalar value) {
    cvRun(() => ccontrib.cv_ximgproc_rl_paint(image.ref, rlSrc.ref, value.ref, ffi.nullptr));
    return image;
  }

  /// Paint run length encoded binary image into an image.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga7cabc1c2901b8b58082f8febc366638b
  static Future<Mat> paintAsync(InputOutputArray image, InputArray rlSrc, Scalar value) async {
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_rl_paint(image.ref, rlSrc.ref, value.ref, callback),
      (c) {
        return c.complete(image);
      },
    );
  }

  /// Applies a fixed-level threshold to each array element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga6c9167cbfe788a52a07f6dd3ef8ca4d9
  static Mat threshold(InputArray src, double thresh, int type) {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_ximgproc_rl_threshold(src.ref, dst.ref, thresh, type, ffi.nullptr));
    return dst;
  }

  /// Applies a fixed-level threshold to each array element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga6c9167cbfe788a52a07f6dd3ef8ca4d9
  static Future<Mat> thresholdAsync(InputArray src, double thresh, int type) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_ximgproc_rl_threshold(src.ref, dst.ref, thresh, type, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}
