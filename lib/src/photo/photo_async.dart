library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/point.dart';
import '../opencv.g.dart' as cvg;
import './photo.dart';

extension MergeMertensAsync on MergeMertens {
  static Future<MergeMertens> emptyNewAsync() async => cvRunAsync(
        (callback) => CFFI.MergeMertens_Create_Async(callback),
        (c, p) =>
            c.complete(MergeMertens.fromPointer(p.cast<cvg.MergeMertens>())),
      );

  static Future<MergeMertens> createAsync({
    double contrastWeight = 1.0,
    double saturationWeight = 1.0,
    double exposureWeight = 0.0,
  }) async {
    return cvRunAsync(
      (callback) => CFFI.MergeMertens_CreateWithParams_Async(
        contrastWeight,
        saturationWeight,
        exposureWeight,
        callback,
      ),
      (c, p) =>
          c.complete(MergeMertens.fromPointer(p.cast<cvg.MergeMertens>())),
    );
  }

  Future<Mat> processAsync(VecMat src) async {
    Mat dst = Mat.empty();
    return cvRunAsync0(
        (callback) =>
            CFFI.MergeMertens_Process_Async(ref, src.ref, dst.ref, callback),
        (c) => c.complete(
              dst.convertTo(MatType.CV_8UC3, alpha: 255.0),
            ));
  }
}

extension AlignMTBAsync on AlignMTB {
  static Future<AlignMTB> emptyNewAsync() async => cvRunAsync(
        (callback) => CFFI.AlignMTB_Create_Async(callback),
        (c, p) => c.complete(AlignMTB.fromPointer(p.cast<cvg.AlignMTB>())),
      );

  static Future<AlignMTB> createAsync(
      {int maxBits = 6, int excludeRange = 4, bool cut = true}) async {
    return cvRunAsync(
      (callback) => CFFI.AlignMTB_CreateWithParams_Async(
          maxBits, excludeRange, cut, callback),
      (c, p) => c.complete(AlignMTB.fromPointer(p.cast<cvg.AlignMTB>())),
    );
  }

  Future<VecMat> processAsync(VecMat src) async {
    return cvRunAsync(
      (callback) => CFFI.AlignMTB_Process_Async(ref, src.ref, callback),
      (c, dst) => c.complete(VecMat.fromPointer(dst.cast<cvg.VecMat>())),
    );
  }
}

Future<Mat> colorChangeAsync(
  InputArray src,
  InputArray mask, {
  double redMul = 1.0,
  double greenMul = 1.0,
  double blueMul = 1.0,
}) async {
  Mat dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.ColorChange_Async(
        src.ref, mask.ref, dst.ref, redMul, greenMul, blueMul, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> seamlessCloneAsync(
  InputArray src,
  InputArray dst,
  InputArray mask,
  Point p,
  int flags,
) async {
  final blend = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.SeamlessClone_Async(
        src.ref, dst.ref, mask.ref, p.ref, blend.ref, flags, callback),
    (c) => c.complete(blend),
  );
}

Future<Mat> illuminationChangeAsync(
  InputArray src,
  InputArray mask, {
  double alpha = 0.2,
  double beta = 0.4,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.IlluminationChange_Async(
        src.ref, mask.ref, dst.ref, alpha, beta, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> textureFlatteningAsync(
  InputArray src,
  InputArray mask, {
  double lowThreshold = 30,
  double highThreshold = 45,
  int kernelSize = 3,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.TextureFlattening_Async(src.ref, mask.ref, dst.ref,
        lowThreshold, highThreshold, kernelSize, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> fastNlMeansDenoisingAsync(
  InputArray src, {
  double h = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.FastNlMeansDenoisingWithParams_Async(
        src.ref, dst.ref, h, templateWindowSize, searchWindowSize, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> fastNlMeansDenoisingColoredAsync(
  InputArray src, {
  double h = 3,
  double hColor = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.FastNlMeansDenoisingColoredWithParams_Async(src.ref,
        dst.ref, h, hColor, templateWindowSize, searchWindowSize, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> fastNlMeansDenoisingColoredMultiAsync(
  VecMat srcImgs,
  int imgToDenoiseIndex,
  int temporalWindowSize, {
  double h = 3,
  double hColor = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.FastNlMeansDenoisingColoredMultiWithParams_Async(
      srcImgs.ref,
      dst.ref,
      imgToDenoiseIndex,
      temporalWindowSize,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
      callback,
    ),
    (c) => c.complete(dst),
  );
}

Future<Mat> detailEnhanceAsync(
  InputArray src, {
  double sigmaS = 10,
  double sigmaR = 0.15,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) =>
        CFFI.DetailEnhance_Async(src.ref, dst.ref, sigmaS, sigmaR, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> edgePreservingFilterAsync(
  InputArray src, {
  int flags = 1,
  double sigmaS = 60,
  double sigmaR = 0.4,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.EdgePreservingFilter_Async(
        src.ref, dst.ref, flags, sigmaS, sigmaR, callback),
    (c) => c.complete(dst),
  );
}

Future<(Mat dst1, Mat dst2)> pencilSketchAsync(
  InputArray src, {
  double sigmaS = 60,
  double sigmaR = 0.07,
  double shadeFactor = 0.02,
}) async {
  final dst1 = Mat.empty();
  final dst2 = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.PencilSketch_Async(
        src.ref, dst1.ref, dst2.ref, sigmaS, sigmaR, shadeFactor, callback),
    (c) => c.complete(
      (dst1, dst2),
    ),
  );
}

Future<Mat> stylizationAsync(
  InputArray src, {
  double sigmaS = 60,
  double sigmaR = 0.45,
}) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) =>
        CFFI.Stylization_Async(src.ref, dst.ref, sigmaS, sigmaR, callback),
    (c) => c.complete(dst),
  );
}

Future<Mat> inpaintAsync(
  InputArray src,
  InputArray inpaintMask,
  double inpaintRadius,
  int flags,
) async {
  final dst = Mat.empty();

  return cvRunAsync0(
    (callback) => CFFI.PhotoInpaint_Async(
        src.ref, inpaintMask.ref, dst.ref, inpaintRadius, flags, callback),
    (c) => c.complete(dst),
  );
}
