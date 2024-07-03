// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names

library cv.ximgproc;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class ximgproc {
  /// Performs anisotropic diffusion on an image.
  ///
  /// The function applies Perona-Malik anisotropic diffusion to an image.
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#gaffedd976e0a8efb5938107acab185ec2
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

  /// Performs anisotropic diffusion on an image.
  ///
  /// The function applies Perona-Malik anisotropic diffusion to an image.
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#gaffedd976e0a8efb5938107acab185ec2
  static Future<Mat> anisotropicDiffusionAsync(InputArray src, double alpha, double K, int niters) async =>
      cvRunAsync(
        (callback) => CFFI.ximgproc_anisotropicDiffusion_Async(src.ref, alpha, K, niters, callback),
        matCompleter,
      );

  /// Smoothes an image using the Edge-Preserving filter.
  ///
  /// The function smoothes Gaussian noise as well as salt & pepper noise.
  /// For more details about this implementation, please see [ReiWoe18] Reich,
  /// S. and Wörgötter, F. and Dellen, B. (2018). A Real-Time Edge-Preserving Denoising Filter.
  /// Proceedings of the 13th International Joint Conference on Computer Vision,
  /// Imaging and Computer Graphics Theory and Applications (VISIGRAPP): Visapp, 85-94, 4.
  /// DOI: 10.5220/0006509000850094.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga86fcda65ced0aafa2741088d82e9161c
  static Mat edgePreservingFilter(InputArray src, int d, double threshold, {OutputArray? dst}) {
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_edgePreservingFilter(src.ref, p, d, threshold));
    return dst ?? Mat.fromPointer(p);
  }

  /// Smoothes an image using the Edge-Preserving filter.
  ///
  /// The function smoothes Gaussian noise as well as salt & pepper noise.
  /// For more details about this implementation, please see [ReiWoe18] Reich,
  /// S. and Wörgötter, F. and Dellen, B. (2018). A Real-Time Edge-Preserving Denoising Filter.
  /// Proceedings of the 13th International Joint Conference on Computer Vision,
  /// Imaging and Computer Graphics Theory and Applications (VISIGRAPP): Visapp, 85-94, 4.
  /// DOI: 10.5220/0006509000850094.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga86fcda65ced0aafa2741088d82e9161c
  static Future<Mat> edgePreservingFilterAsync(InputArray src, int d, double threshold) async => cvRunAsync(
        (callback) => CFFI.ximgproc_edgePreservingFilter_Async(src.ref, d, threshold, callback),
        matCompleter,
      );

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
    final p = ellipses?.ptr ?? calloc<cvg.Mat>();
    cvRun(
      () => CFFI.ximgproc_findEllipses(
        image.ref,
        p,
        scoreThreshold,
        reliabilityThreshold,
        centerDistanceThreshold,
      ),
    );
    return ellipses ?? Mat.fromPointer(p);
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
    double scoreThreshold = 0.7,
    double reliabilityThreshold = 0.5,
    double centerDistanceThreshold = 0.05,
  }) async =>
      cvRunAsync(
        (callback) => CFFI.ximgproc_findEllipses_Async(
          image.ref,
          scoreThreshold,
          reliabilityThreshold,
          centerDistanceThreshold,
          callback,
        ),
        matCompleter,
      );

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
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(
      () => CFFI.ximgproc_niBlackThreshold(
        src.ref,
        p,
        maxValue,
        type,
        blockSize,
        k,
        binarizationMethod,
        r,
      ),
    );
    return dst ?? Mat.fromPointer(p);
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
    int binarizationMethod = BINARIZATION_NIBLACK,
    double r = 128,
  }) async =>
      cvRunAsync(
        (callback) => CFFI.ximgproc_niBlackThreshold_Async(
          src.ref,
          maxValue,
          type,
          blockSize,
          k,
          binarizationMethod,
          r,
          callback,
        ),
        matCompleter,
      );

  /// Calculates an affine transformation that normalize given image using Pei&Lin Normalization.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga50d064b92f63916f4162474eea22d656
  static Mat PeiLinNormalization(InputArray I, {OutputArray? T}) {
    final p = T?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_PeiLinNormalization(I.ref, p));
    return T ?? Mat.fromPointer(p);
  }

  /// Calculates an affine transformation that normalize given image using Pei&Lin Normalization.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga50d064b92f63916f4162474eea22d656
  static Future<Mat> PeiLinNormalizationAsync(InputArray I) async => cvRunAsync(
        (callback) => CFFI.ximgproc_PeiLinNormalization_Async(I.ref, callback),
        matCompleter,
      );

  /// Applies a binary blob thinning operation, to achieve a skeletization of the input image.
  ///
  /// The function transforms a binary blob image into a skeletized form using the
  /// technique of Zhang-Suen.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga37002c6ca80c978edb6ead5d6b39740c
  static Mat thinning(InputArray src, {OutputArray? dst, int thinningType = THINNING_ZHANGSUEN}) {
    final p = dst?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_thinning(src.ref, p, thinningType));
    return dst ?? Mat.fromPointer(p);
  }

  /// Applies a binary blob thinning operation, to achieve a skeletization of the input image.
  ///
  /// The function transforms a binary blob image into a skeletized form using the
  /// technique of Zhang-Suen.
  ///
  /// https://docs.opencv.org/4.x/df/d2d/group__ximgproc.html#ga37002c6ca80c978edb6ead5d6b39740c
  static Future<Mat> thinningAsync(InputArray src, {int thinningType = THINNING_ZHANGSUEN}) async =>
      cvRunAsync(
        (callback) => CFFI.ximgproc_thinning_Async(src.ref, thinningType, callback),
        matCompleter,
      );

  static const int THINNING_ZHANGSUEN = 0;
  static const int THINNING_GUOHALL = 1;

  static const int BINARIZATION_NIBLACK = 0;
  static const int BINARIZATION_SAUVOLA = 1;
  static const int BINARIZATION_WOLF = 2;
  static const int BINARIZATION_NICK = 3;
}

class RFFeatureGetter extends CvStruct<cvg.RFFeatureGetter> {
  RFFeatureGetter.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory RFFeatureGetter.empty() {
    final p = calloc<cvg.RFFeatureGetter>();
    cvRun(() => CFFI.ximgproc_RFFeatureGetter_Create(p));
    return RFFeatureGetter.fromPointer(p);
  }

  static final finalizer =
      OcvFinalizer<cvg.RFFeatureGetterPtr>(CFFI.addresses.ximgproc_RFFeatureGetter_Close);

  Mat getFeatures(InputArray src, int gnrmRad, int gsmthRad, int shrink, int outNum, int gradNum) {
    final p = calloc<cvg.Mat>();
    cvRun(
      () => CFFI.ximgproc_RFFeatureGetter_getFeatures(
        ref,
        src.ref,
        p,
        gnrmRad,
        gsmthRad,
        shrink,
        outNum,
        gradNum,
      ),
    );
    return Mat.fromPointer(p);
  }

  void clear() => cvRun(() => CFFI.ximgproc_RFFeatureGetter_Clear(ref));

  bool isEmpty() {
    final p = calloc<ffi.Bool>();
    cvRun(() => CFFI.ximgproc_RFFeatureGetter_Empty(ref, p));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.RFFeatureGetter get ref => ptr.ref;
}

/// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#details
class StructuredEdgeDetection extends CvStruct<cvg.StructuredEdgeDetection> {
  StructuredEdgeDetection.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  /// https://docs.opencv.org/4.x/de/d51/group__ximgproc__edge.html#ga2aad8b0b32e05d82200348dcf5b32066
  factory StructuredEdgeDetection.create(String model, {RFFeatureGetter? howToGetFeatures}) {
    final cmodel = model.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<cvg.StructuredEdgeDetection>();
    howToGetFeatures == null
        ? cvRun(() => CFFI.ximgproc_StructuredEdgeDetection_Create(cmodel, p))
        : cvRun(() => CFFI.ximgproc_StructuredEdgeDetection_Create_1(cmodel, howToGetFeatures.ref, p));
    calloc.free(cmodel);
    return StructuredEdgeDetection.fromPointer(p);
  }

  /// The function computes orientation from edge image.
  ///
  /// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#a4ef982e80edccef6e92da9db2c20a222
  Mat computeOrientation(Mat src) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_StructuredEdgeDetection_computeOrientation(ref, src.ref, p));
    return Mat.fromPointer(p);
  }

  /// The function detects edges in src and draw them to dst.
  ///
  /// The algorithm underlies this function is much more robust to texture presence,
  /// than common approaches, e.g. Sobel
  ///
  /// https://docs.opencv.org/4.x/d8/d54/classcv_1_1ximgproc_1_1StructuredEdgeDetection.html#a31308e06ffea4507b5feb2e1856b1bd8
  Mat detectEdges(InputArray src) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_StructuredEdgeDetection_detectEdges(ref, src.ref, p));
    return Mat.fromPointer(p);
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
    final p = calloc<cvg.Mat>();
    cvRun(
      () => CFFI.ximgproc_StructuredEdgeDetection_edgesNms(
        ref,
        edgeImage.ref,
        orientationImage.ref,
        p,
        r,
        s,
        m,
        isParallel,
      ),
    );
    return Mat.fromPointer(p);
  }

  static final finalizer =
      OcvFinalizer<cvg.StructuredEdgeDetectionPtr>(CFFI.addresses.ximgproc_StructuredEdgeDetection_Close);

  @override
  List<int> get props => [ptr.address];

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
    cvRun(() => CFFI.ximgproc_GraphSegmentation_Create(sigma, k, minSize, p));
    return GraphSegmentation.fromPointer(p);
  }

  /// Segment an image and store output in dst.
  ///
  /// https://docs.opencv.org/4.x/dd/d19/classcv_1_1ximgproc_1_1segmentation_1_1GraphSegmentation.html#a13a3603cb371d740c3c4b01d63553d90
  Mat processImage(Mat src) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_GraphSegmentation_processImage(ref, src.ref, p));
    return Mat.fromPointer(p);
  }

  double get K {
    final p = calloc<ffi.Float>();
    cvRun(() => CFFI.ximgproc_GraphSegmentation_getK(ref, p));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  set K(double value) => cvRun(() => CFFI.ximgproc_GraphSegmentation_setK(ref, value));

  double get sigma {
    final p = calloc<ffi.Double>();
    cvRun(() => CFFI.ximgproc_GraphSegmentation_getSigma(ref, p));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  set sigma(double value) => cvRun(() => CFFI.ximgproc_GraphSegmentation_setSigma(ref, value));

  int get minSize {
    final p = calloc<ffi.Int>();
    cvRun(() => CFFI.ximgproc_GraphSegmentation_getMinSize(ref, p));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  set minSize(int value) => cvRun(() => CFFI.ximgproc_GraphSegmentation_setMinSize(ref, value));

  static final finalizer =
      OcvFinalizer<cvg.GraphSegmentationPtr>(CFFI.addresses.ximgproc_GraphSegmentation_Close);

  @override
  List<int> get props => [ptr.address];

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
    int MinLineLength = 10,
    int MinPathLength = 50,
    bool NFAValidation = true,
    bool PFmode = false,
    int ScanInterval = 1,
    double Sigma = 1.0,
    bool SumFlag = false,
  }) {
    final p = calloc<cvg.EdgeDrawingParams>()
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
  List<int> get props => [ptr.address];

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
    cvRun(() => CFFI.ximgproc_EdgeDrawing_Create(p));
    return EdgeDrawing.fromPointer(p);
  }

  /// Segment an image and store output in dst.
  ///
  /// https://docs.opencv.org/4.x/dd/d19/classcv_1_1ximgproc_1_1segmentation_1_1GraphSegmentation.html#a13a3603cb371d740c3c4b01d63553d90
  void detectEdges(Mat src) => cvRun(() => CFFI.ximgproc_EdgeDrawing_detectEdges(ref, src.ref));

  Mat detectEllipses() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_detectEllipses(ref, p));
    return Mat.fromPointer(p);
  }

  Mat detectLines() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_detectLines(ref, p));
    return Mat.fromPointer(p);
  }

  Mat getEdgeImage() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_getEdgeImage(ref, p));
    return Mat.fromPointer(p);
  }

  Mat getGradientImage() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_getGradientImage(ref, p));
    return Mat.fromPointer(p);
  }

  VecInt getSegmentIndicesOfLines() {
    final p = calloc<cvg.VecInt>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_getSegmentIndicesOfLines(ref, p));
    return VecInt.fromPointer(p);
  }

  VecVecPoint getSegments() {
    final p = calloc<cvg.VecVecPoint>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_getSegments(ref, p));
    return VecVecPoint.fromPointer(p);
  }

  EdgeDrawingParams get params {
    final p = calloc<cvg.EdgeDrawingParams>();
    cvRun(() => CFFI.ximgproc_EdgeDrawing_getParams(ref, p));
    return EdgeDrawingParams.fromPointer(p);
  }

  set params(EdgeDrawingParams value) => cvRun(() => CFFI.ximgproc_EdgeDrawing_setParams(ref, value.ref));

  static final finalizer = OcvFinalizer<cvg.EdgeDrawingPtr>(CFFI.addresses.ximgproc_EdgeDrawing_Close);

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.EdgeDrawing get ref => ptr.ref;
}

class ximgproc_rl {
  ///Creates a run-length encoded image from a vector of runs (column begin, column end, row)
  ///
  ///https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gaa2b3524997874269670f2f63d54d792d
  static Mat createRLEImage(VecPoint3i runs, {(int, int) size = (0, 0)}) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_rl_createRLEImage(runs.ref, p, size.cvd.ref));
    return Mat.fromPointer(p);
  }

  ///Creates a run-length encoded image from a vector of runs (column begin, column end, row)
  ///
  ///https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gaa2b3524997874269670f2f63d54d792d
  static Future<Mat> createRLEImageAsync(VecPoint3i runs, {(int, int) size = (0, 0)}) async => cvRunAsync(
        (callback) => CFFI.ximgproc_rl_createRLEImage_Async(runs.ref, size.toSize.ref, callback),
        matCompleter,
      );

  /// Dilates an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gac3de990089892266fa30189edcb6da3c
  static Mat dilate(InputArray rlSrc, InputArray rlKernel, {(int, int) anchor = (0, 0)}) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_rl_dilate(rlSrc.ref, p, rlKernel.ref, anchor.asPoint.ref));
    return Mat.fromPointer(p);
  }

  /// Dilates an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#gac3de990089892266fa30189edcb6da3c
  static Future<Mat> dilateAsync(InputArray rlSrc, InputArray rlKernel, {(int, int) anchor = (0, 0)}) async =>
      cvRunAsync(
        (callback) => CFFI.ximgproc_rl_dilate_Async(rlSrc.ref, rlKernel.ref, anchor.asPoint.ref, callback),
        matCompleter,
      );

  /// Erodes an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga1903619622035efbe28ad08151f60ec3
  static Mat erode(
    InputArray rlSrc,
    InputArray rlKernel, {
    bool bBoundaryOn = true,
    (int, int) anchor = (0, 0),
  }) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_rl_erode(rlSrc.ref, p, rlKernel.ref, bBoundaryOn, anchor.asPoint.ref));
    return Mat.fromPointer(p);
  }

  /// Erodes an run-length encoded binary image by using a specific structuring element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga1903619622035efbe28ad08151f60ec3
  static Future<Mat> erodeAsync(
    InputArray rlSrc,
    InputArray rlKernel, {
    bool bBoundaryOn = true,
    (int, int) anchor = (0, 0),
  }) async =>
      cvRunAsync(
        (callback) =>
            CFFI.ximgproc_rl_erode_Async(rlSrc.ref, rlKernel.ref, bBoundaryOn, anchor.asPoint.ref, callback),
        matCompleter,
      );

  /// Returns a run length encoded structuring element of the specified size and shape.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga8a7c10c524fb2572e2eefe0caf0375fc
  static Mat getStructuringElement(int shape, (int, int) ksize) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_rl_getStructuringElement(shape, ksize.cvd.ref, p));
    return Mat.fromPointer(p);
  }

  /// Returns a run length encoded structuring element of the specified size and shape.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga8a7c10c524fb2572e2eefe0caf0375fc
  static Future<Mat> getStructuringElementAsync(int shape, (int, int) ksize) async => cvRunAsync(
        (callback) => CFFI.ximgproc_rl_getStructuringElement_Async(shape, ksize.toSize.ref, callback),
        matCompleter,
      );

  /// Check whether a custom made structuring element can be used with run length morphological operations.
  /// (It must consist of a continuous array of single runs per row)
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga85ed82296e9e9893dcbaa92b87837019
  static bool isRLMorphologyPossible(InputArray rlStructuringElement) {
    final p = calloc<ffi.Bool>();
    cvRun(() => CFFI.ximgproc_rl_isRLMorphologyPossible(rlStructuringElement.ref, p));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Check whether a custom made structuring element can be used with run length morphological operations.
  /// (It must consist of a continuous array of single runs per row)
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga85ed82296e9e9893dcbaa92b87837019
  static Future<bool> isRLMorphologyPossibleAsync(InputArray rlStructuringElement) async => cvRunAsync(
        (callback) => CFFI.ximgproc_rl_isRLMorphologyPossible_Async(rlStructuringElement.ref, callback),
        boolCompleter,
      );

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
    final p = calloc<cvg.Mat>();
    cvRun(
      () => CFFI.ximgproc_rl_morphologyEx(
        rlSrc.ref,
        p,
        op,
        rlKernel.ref,
        bBoundaryOnForErosion,
        anchor.asPoint.ref,
      ),
    );
    return Mat.fromPointer(p);
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
  }) async =>
      cvRunAsync(
        (callback) => CFFI.ximgproc_rl_morphologyEx_Async(
          rlSrc.ref,
          op,
          rlKernel.ref,
          bBoundaryOnForErosion,
          anchor.asPoint.ref,
          callback,
        ),
        matCompleter,
      );

  /// Paint run length encoded binary image into an image.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga7cabc1c2901b8b58082f8febc366638b
  static Mat paint(InputOutputArray image, InputArray rlSrc, Scalar value) {
    cvRun(() => CFFI.ximgproc_rl_paint(image.ref, rlSrc.ref, value.ref));
    return image;
  }

  /// Paint run length encoded binary image into an image.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga7cabc1c2901b8b58082f8febc366638b
  static Future<Mat> paintAsync(InputOutputArray image, InputArray rlSrc, Scalar value) async => cvRunAsync0(
        (callback) => CFFI.ximgproc_rl_paint_Async(image.ref, rlSrc.ref, value.ref, callback),
        (c) => c.complete(image),
      );

  /// Applies a fixed-level threshold to each array element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga6c9167cbfe788a52a07f6dd3ef8ca4d9
  static Mat threshold(InputArray sr, double thresh, int type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.ximgproc_rl_threshold(sr.ref, p, thresh, type));
    return Mat.fromPointer(p);
  }

  /// Applies a fixed-level threshold to each array element.
  ///
  /// https://docs.opencv.org/4.x/df/def/group__ximgproc__run__length__morphology.html#ga6c9167cbfe788a52a07f6dd3ef8ca4d9
  static Future<Mat> thresholdAsync(InputArray src, double thresh, int type) async => cvRunAsync(
        (callback) => CFFI.ximgproc_rl_threshold_Async(src.ref, thresh, type, callback),
        matCompleter,
      );
}
