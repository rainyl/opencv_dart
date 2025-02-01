// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.photo;

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../g/photo.g.dart' as cphoto;
import './photo.dart';

extension MergeMertensAsync on MergeMertens {
  Future<Mat> processAsync(VecMat src) async {
    final dst = Mat.empty();
    return cvRunAsync0(
      (callback) => cphoto.cv_MergeMertens_process(ref, src.ref, dst.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}

extension AlignMTBAsync on AlignMTB {
  Future<VecMat> processAsync(VecMat src) async {
    final dst = VecMat();
    return cvRunAsync0(
      (callback) => cphoto.cv_AlignMTB_process(ref, src.ref, dst.ptr, callback),
      (c) {
        return c.complete(dst);
      },
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
  final dst = Mat.empty();
  return cvRunAsync0(
    (callback) => cphoto.cv_colorChange(src.ref, mask.ref, dst.ref, redMul, greenMul, blueMul, callback),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_seamlessClone(src.ref, dst.ref, mask.ref, p.ref, blend.ref, flags, callback),
    (c) {
      return c.complete(blend);
    },
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
    (callback) => cphoto.cv_illuminationChange(src.ref, mask.ref, dst.ref, alpha, beta, callback),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_textureFlattening(
      src.ref,
      mask.ref,
      dst.ref,
      lowThreshold,
      highThreshold,
      kernelSize,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_fastNlMeansDenoising_1(
      src.ref,
      dst.ref,
      h,
      templateWindowSize,
      searchWindowSize,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_fastNlMeansDenoisingColored_1(
      src.ref,
      dst.ref,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_fastNlMeansDenoisingColoredMulti_1(
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
    (c) {
      return c.complete(dst);
    },
  );
}

Future<Mat> detailEnhanceAsync(
  InputArray src, {
  double sigmaS = 10,
  double sigmaR = 0.15,
}) async {
  final dst = Mat.empty();
  return cvRunAsync0(
    (callback) => cphoto.cv_detailEnhance(src.ref, dst.ref, sigmaS, sigmaR, callback),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_edgePreservingFilter(src.ref, dst.ref, flags, sigmaS, sigmaR, callback),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_pencilSketch(
      src.ref,
      dst1.ref,
      dst2.ref,
      sigmaS,
      sigmaR,
      shadeFactor,
      callback,
    ),
    (c) {
      return c.complete((dst1, dst2));
    },
  );
}

Future<Mat> stylizationAsync(
  InputArray src, {
  double sigmaS = 60,
  double sigmaR = 0.45,
}) async {
  final dst = Mat.empty();
  return cvRunAsync0(
    (callback) => cphoto.cv_stylization(src.ref, dst.ref, sigmaS, sigmaR, callback),
    (c) {
      return c.complete(dst);
    },
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
    (callback) => cphoto.cv_inpaint(
      src.ref,
      inpaintMask.ref,
      dst.ref,
      inpaintRadius,
      flags,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}
