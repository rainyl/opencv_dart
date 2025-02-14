// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.photo;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../g/photo.g.dart' as cvg;
import '../native_lib.dart' show cphoto;

/// MergeMertens algorithm merge the ldr image should result in a HDR image.
//
/// For further details, please see:
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
/// https://docs.opencv.org/master/d7/dd6/classcv_1_1MergeMertens.html
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga79d59aa3cb3a7c664e59a4b5acc1ccb6
class MergeMertens extends CvStruct<cvg.MergeMertens> {
  MergeMertens._(cvg.MergeMertensPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory MergeMertens.fromPointer(cvg.MergeMertensPtr ptr, [bool attach = true]) =>
      MergeMertens._(ptr.cast(), attach);
  factory MergeMertens.empty() {
    final p = calloc<cvg.MergeMertens>();
    cvRun(() => cphoto.cv_createMergeMertens(p));
    return MergeMertens._(p);
  }

  factory MergeMertens.create({
    double contrastWeight = 1.0,
    double saturationWeight = 1.0,
    double exposureWeight = 0.0,
  }) {
    final p = calloc<cvg.MergeMertens>();
    cvRun(() => cphoto.cv_createMergeMertens_1(contrastWeight, saturationWeight, exposureWeight, p));
    return MergeMertens._(p);
  }

  static final finalizer = OcvFinalizer<cvg.MergeMertensPtr>(cphoto.addresses.cv_MergeMertens_close);

  void dispose() {
    finalizer.detach(this);
    cphoto.cv_MergeMertens_close(ptr);
  }

  /// BalanceWhite computes merge LDR images using the current MergeMertens.
  /// Return a image MAT : 8bits 3 channel image ( RGB 8 bits )
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dd6/classcv_1_1MergeMertens.html#a2d2254b2aab722c16954de13a663644d
  Mat process(VecMat src) {
    final dst = Mat.empty();
    cvRun(() => cphoto.cv_MergeMertens_process(ref, src.ref, dst.ref, ffi.nullptr));
    return dst;
  }

  @override
  cvg.MergeMertens get ref => ptr.ref;
}

/// AlignMTB for converts images to median threshold bitmaps.
/// of type AlignMTB converts images to median threshold bitmaps (1 for pixels
/// brighter than median luminance and 0 otherwise) and than aligns the resulting
/// bitmaps using bit operations.
/// For further details, please see:
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
/// https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga2f1fafc885a5d79dbfb3542e08db0244
class AlignMTB extends CvStruct<cvg.AlignMTB> {
  AlignMTB._(cvg.AlignMTBPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory AlignMTB.fromPointer(cvg.AlignMTBPtr ptr, [bool attach = true]) => AlignMTB._(ptr.cast(), attach);

  /// AlignMTB for converts images to median threshold bitmaps.
  /// of type AlignMTB converts images to median threshold bitmaps (1 for pixels
  /// brighter than median luminance and 0 otherwise) and than aligns the resulting
  /// bitmaps using bit operations.
  /// For further details, please see:
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
  /// https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga2f1fafc885a5d79dbfb3542e08db0244
  factory AlignMTB.empty() {
    final p = calloc<cvg.AlignMTB>();
    cvRun(() => cphoto.cv_createAlignMTB(p));
    return AlignMTB._(p);
  }

  /// returns an AlignMTB for converts images to median threshold bitmaps.
  /// of type AlignMTB converts images to median threshold bitmaps (1 for pixels
  /// brighter than median luminance and 0 otherwise) and than aligns the resulting
  /// bitmaps using bit operations.
  /// For further details, please see:
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
  /// https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga2f1fafc885a5d79dbfb3542e08db0244
  factory AlignMTB.create({int maxBits = 6, int excludeRange = 4, bool cut = true}) {
    final p = calloc<cvg.AlignMTB>();
    cvRun(() => cphoto.cv_createAlignMTB_1(maxBits, excludeRange, cut, p));
    return AlignMTB._(p);
  }

  static final finalizer = OcvFinalizer<cvg.AlignMTBPtr>(cphoto.addresses.cv_AlignMTB_close);

  void dispose() {
    finalizer.detach(this);
    cphoto.cv_AlignMTB_close(ptr);
  }

  VecMat process(VecMat src) {
    final dst = VecMat();
    cvRun(() => cphoto.cv_AlignMTB_process(ref, src.ref, dst.ptr, ffi.nullptr));
    return dst;
  }

  @override
  cvg.AlignMTB get ref => ptr.ref;
}

/// ColorChange mix two differently colored versions of an image seamlessly.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#ga6684f35dc669ff6196a7c340dc73b98e
Mat colorChange(
  InputArray src,
  InputArray mask, {
  double redMul = 1.0,
  double greenMul = 1.0,
  double blueMul = 1.0,
}) {
  final dst = Mat.empty();
  cvRun(() => cphoto.cv_colorChange(src.ref, mask.ref, dst.ref, redMul, greenMul, blueMul, ffi.nullptr));
  return dst;
}

/// SeamlessClone blend two image by Poisson Blending.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#ga2bf426e4c93a6b1f21705513dfeca49d
Mat seamlessClone(InputArray src, InputArray dst, InputArray mask, Point p, int flags) {
  final blend = Mat.empty();
  cvRun(() => cphoto.cv_seamlessClone(src.ref, dst.ref, mask.ref, p.ref, blend.ref, flags, ffi.nullptr));
  return blend;
}

/// IlluminationChange modifies locally the apparent illumination of an image.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#gac5025767cf2febd8029d474278e886c7
Mat illuminationChange(InputArray src, InputArray mask, {double alpha = 0.2, double beta = 0.4}) {
  final dst = Mat.empty();
  cvRun(() => cphoto.cv_illuminationChange(src.ref, mask.ref, dst.ref, alpha, beta, ffi.nullptr));
  return dst;
}

/// TextureFlattening washes out the texture of the selected region, giving its contents a flat aspect.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#gad55df6aa53797365fa7cc23959a54004
Mat textureFlattening(
  InputArray src,
  InputArray mask, {
  double lowThreshold = 30,
  double highThreshold = 45,
  int kernelSize = 3,
}) {
  final dst = Mat.empty();
  cvRun(
    () => cphoto.cv_textureFlattening(
      src.ref,
      mask.ref,
      dst.ref,
      lowThreshold,
      highThreshold,
      kernelSize,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// FastNlMeansDenoising performs image denoising using Non-local Means Denoising algorithm
/// http://www.ipol.im/pub/algo/bcm_non_local_means_denoising/
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/d1/d79/group__photo__denoise.html#ga4c6b0031f56ea3f98f768881279ffe93
Mat fastNlMeansDenoising(
  InputArray src, {
  double h = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) {
  final dst = Mat.empty();
  cvRun(
    () => cphoto.cv_fastNlMeansDenoising_1(
      src.ref,
      dst.ref,
      h,
      templateWindowSize,
      searchWindowSize,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// FastNlMeansDenoisingColored is a modification of fastNlMeansDenoising function for colored images.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/d1/d79/group__photo__denoise.html#ga21abc1c8b0e15f78cd3eff672cb6c476
Mat fastNlMeansDenoisingColored(
  InputArray src, {
  double h = 3,
  double hColor = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) {
  final dst = Mat.empty();
  cvRun(
    () => cphoto.cv_fastNlMeansDenoisingColored_1(
      src.ref,
      dst.ref,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// FastNlMeansDenoisingColoredMulti denoises the selected images.
//
/// For further details, please see:
/// https://docs.opencv.org/master/d1/d79/group__photo__denoise.html#gaa501e71f52fb2dc17ff8ca5e7d2d3619
Mat fastNlMeansDenoisingColoredMulti(
  VecMat srcImgs,
  int imgToDenoiseIndex,
  int temporalWindowSize, {
  double h = 3,
  double hColor = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) {
  final dst = Mat.empty();
  cvRun(
    () => cphoto.cv_fastNlMeansDenoisingColoredMulti_1(
      srcImgs.ref,
      dst.ref,
      imgToDenoiseIndex,
      temporalWindowSize,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// DetailEnhance filter enhances the details of a particular image
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#ga0de660cb6f371a464a74c7b651415975
Mat detailEnhance(InputArray src, {double sigmaS = 10, double sigmaR = 0.15}) {
  final dst = Mat.empty();
  cvRun(() => cphoto.cv_detailEnhance(src.ref, dst.ref, sigmaS, sigmaR, ffi.nullptr));
  return dst;
}

/// EdgePreservingFilter filtering is the fundamental operation in image and video processing.
/// Edge-preserving smoothing filters are used in many different applications.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#gafaee2977597029bc8e35da6e67bd31f7
Mat edgePreservingFilter(InputArray src, {int flags = 1, double sigmaS = 60, double sigmaR = 0.4}) {
  final dst = Mat.empty();
  cvRun(() => cphoto.cv_edgePreservingFilter(src.ref, dst.ref, flags, sigmaS, sigmaR, ffi.nullptr));
  return dst;
}

/// PencilSketch pencil-like non-photorealistic line drawing.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#gae5930dd822c713b36f8529b21ddebd0c
(Mat dst1, Mat dst2) pencilSketch(
  InputArray src, {
  double sigmaS = 60,
  double sigmaR = 0.07,
  double shadeFactor = 0.02,
}) {
  final dst1 = Mat.empty();
  final dst2 = Mat.empty();
  cvRun(() => cphoto.cv_pencilSketch(src.ref, dst1.ref, dst2.ref, sigmaS, sigmaR, shadeFactor, ffi.nullptr));
  return (dst1, dst2);
}

/// Stylization aims to produce digital imagery with a wide variety of effects
/// not focused on photorealism. Edge-aware filters are ideal for stylization,
/// as they can abstract regions of low contrast while preserving, or enhancing,
/// high-contrast features.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#gacb0f7324017df153d7b5d095aed53206
Mat stylization(InputArray src, {double sigmaS = 60, double sigmaR = 0.45}) {
  final dst = Mat.empty();
  cvRun(() => cphoto.cv_stylization(src.ref, dst.ref, sigmaS, sigmaR, ffi.nullptr));
  return dst;
}

/// Inpaint reconstructs the selected image area from the pixel near the area boundary.
/// The function may be used to remove dust and scratches from a scanned photo, or to
/// remove undesirable objects from still images or video.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/d7/d8b/group__photo__inpaint.html#gaedd30dfa0214fec4c88138b51d678085
Mat inpaint(InputArray src, InputArray inpaintMask, double inpaintRadius, int flags) {
  final dst = Mat.empty();
  cvRun(() => cphoto.cv_inpaint(src.ref, inpaintMask.ref, dst.ref, inpaintRadius, flags, ffi.nullptr));
  return dst;
}
