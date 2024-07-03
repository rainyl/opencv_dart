library cv;

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../opencv.g.dart' as cvg;
import './photo.dart';

extension MergeMertensAsync on MergeMertens {
  static Future<MergeMertens> emptyNewAsync() async => cvRunAsync(
        CFFI.MergeMertens_Create_Async,
        (c, p) => c.complete(MergeMertens.fromPointer(p.cast<cvg.MergeMertens>())),
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
      (c, p) => c.complete(MergeMertens.fromPointer(p.cast<cvg.MergeMertens>())),
    );
  }

  Future<Mat> processAsync(VecMat src) async {
    return cvRunAsync(
      (callback) => CFFI.MergeMertens_Process_Async(ref, src.ref, callback),
      (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
    );
  }
}

extension AlignMTBAsync on AlignMTB {
  static Future<AlignMTB> emptyNewAsync() async => cvRunAsync(
        CFFI.AlignMTB_Create_Async,
        (c, p) => c.complete(AlignMTB.fromPointer(p.cast<cvg.AlignMTB>())),
      );

  static Future<AlignMTB> createAsync({
    int maxBits = 6,
    int excludeRange = 4,
    bool cut = true,
  }) async {
    return cvRunAsync(
      (callback) => CFFI.AlignMTB_CreateWithParams_Async(
        maxBits,
        excludeRange,
        cut,
        callback,
      ),
      (c, p) => c.complete(AlignMTB.fromPointer(p.cast<cvg.AlignMTB>())),
    );
  }

  Future<VecMat> processAsync(VecMat src) async {
    return cvRunAsync(
      (callback) => CFFI.AlignMTB_Process_Async(ref, src.ref, callback),
      (c, pdst) => c.complete(VecMat.fromPointer(pdst.cast<cvg.VecMat>())),
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
  return cvRunAsync(
    (callback) => CFFI.ColorChange_Async(
      src.ref,
      mask.ref,
      redMul,
      greenMul,
      blueMul,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> seamlessCloneAsync(
  InputArray src,
  InputArray dst,
  InputArray mask,
  Point p,
  int flags,
) async {
  return cvRunAsync(
    (callback) => CFFI.SeamlessClone_Async(
      src.ref,
      dst.ref,
      mask.ref,
      p.ref,
      flags,
      callback,
    ),
    matCompleter,
  );
}

Future<Mat> illuminationChangeAsync(
  InputArray src,
  InputArray mask, {
  double alpha = 0.2,
  double beta = 0.4,
}) async {
  return cvRunAsync(
    (callback) => CFFI.IlluminationChange_Async(
      src.ref,
      mask.ref,
      alpha,
      beta,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> textureFlatteningAsync(
  InputArray src,
  InputArray mask, {
  double lowThreshold = 30,
  double highThreshold = 45,
  int kernelSize = 3,
}) async {
  return cvRunAsync(
    (callback) => CFFI.TextureFlattening_Async(
      src.ref,
      mask.ref,
      lowThreshold,
      highThreshold,
      kernelSize,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> fastNlMeansDenoisingAsync(
  InputArray src, {
  double h = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) async {
  return cvRunAsync(
    (callback) => CFFI.FastNlMeansDenoisingWithParams_Async(
      src.ref,
      h,
      templateWindowSize,
      searchWindowSize,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> fastNlMeansDenoisingColoredAsync(
  InputArray src, {
  double h = 3,
  double hColor = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) async {
  return cvRunAsync(
    (callback) => CFFI.FastNlMeansDenoisingColoredWithParams_Async(
      src.ref,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
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
  return cvRunAsync(
    (callback) => CFFI.FastNlMeansDenoisingColoredMultiWithParams_Async(
      srcImgs.ref,
      imgToDenoiseIndex,
      temporalWindowSize,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> detailEnhanceAsync(
  InputArray src, {
  double sigmaS = 10,
  double sigmaR = 0.15,
}) async {
  return cvRunAsync(
    (callback) => CFFI.DetailEnhance_Async(
      src.ref,
      sigmaS,
      sigmaR,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> edgePreservingFilterAsync(
  InputArray src, {
  int flags = 1,
  double sigmaS = 60,
  double sigmaR = 0.4,
}) async {
  return cvRunAsync(
    (callback) => CFFI.EdgePreservingFilter_Async(
      src.ref,
      flags,
      sigmaS,
      sigmaR,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<(Mat dst1, Mat dst2)> pencilSketchAsync(
  InputArray src, {
  double sigmaS = 60,
  double sigmaR = 0.07,
  double shadeFactor = 0.02,
}) async {
  return cvRunAsync2(
    (callback) => CFFI.PencilSketch_Async(
      src.ref,
      sigmaS,
      sigmaR,
      shadeFactor,
      callback,
    ),
    (c, pdst1, pdst2) => c.complete(
      (Mat.fromPointer(pdst1.cast<cvg.Mat>()), Mat.fromPointer(pdst2.cast<cvg.Mat>())),
    ),
  );
}

Future<Mat> stylizationAsync(
  InputArray src, {
  double sigmaS = 60,
  double sigmaR = 0.45,
}) async {
  return cvRunAsync(
    (callback) => CFFI.Stylization_Async(
      src.ref,
      sigmaS,
      sigmaR,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}

Future<Mat> inpaintAsync(
  InputArray src,
  InputArray inpaintMask,
  double inpaintRadius,
  int flags,
) async {
  return cvRunAsync(
    (callback) => CFFI.PhotoInpaint_Async(
      src.ref,
      inpaintMask.ref,
      inpaintRadius,
      flags,
      callback,
    ),
    (c, pdst) => c.complete(Mat.fromPointer(pdst.cast<cvg.Mat>())),
  );
}
