library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/mat_type.dart';
import '../core/point.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// MergeMertens algorithm merge the ldr image should result in a HDR image.
//
/// For further details, please see:
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
/// https://docs.opencv.org/master/d7/dd6/classcv_1_1MergeMertens.html
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga79d59aa3cb3a7c664e59a4b5acc1ccb6
class MergeMertens implements ffi.Finalizable {
  MergeMertens._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  factory MergeMertens.empty() {
    final _ptr = _bindings.MergeMertens_Create();
    return MergeMertens._(_ptr);
  }

  factory MergeMertens.create({
    double contrast_weight = 1.0,
    double saturation_weight = 1.0,
    double exposure_weight = 0.0,
  }) {
    final _ptr = _bindings.MergeMertens_CreateWithParams(contrast_weight, saturation_weight, exposure_weight);
    return MergeMertens._(_ptr);
  }

  final cvg.MergeMertens ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.MergeMertens_Close);

  /// BalanceWhite computes merge LDR images using the current MergeMertens.
  /// Return a image MAT : 8bits 3 channel image ( RGB 8 bits )
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dd6/classcv_1_1MergeMertens.html#a2d2254b2aab722c16954de13a663644d
  Mat process(List<Mat> src) {
    return using<Mat>((arena) {
      final dst = Mat.empty();
      _bindings.MergeMertens_Process(ptr, src.toMats(arena).ref, dst.ptr);
      return dst.convertTo(MatType.CV_8UC3, alpha: 255.0, beta: 0.0);
    });
  }
}

/// AlignMTB for converts images to median threshold bitmaps.
/// of type AlignMTB converts images to median threshold bitmaps (1 for pixels
/// brighter than median luminance and 0 otherwise) and than aligns the resulting
/// bitmaps using bit operations.
/// For further details, please see:
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
/// https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
/// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga2f1fafc885a5d79dbfb3542e08db0244
class AlignMTB implements ffi.Finalizable {
  AlignMTB._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  /// AlignMTB for converts images to median threshold bitmaps.
  /// of type AlignMTB converts images to median threshold bitmaps (1 for pixels
  /// brighter than median luminance and 0 otherwise) and than aligns the resulting
  /// bitmaps using bit operations.
  /// For further details, please see:
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
  /// https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga2f1fafc885a5d79dbfb3542e08db0244
  factory AlignMTB.empty() {
    final _ptr = _bindings.AlignMTB_Create();
    return AlignMTB._(_ptr);
  }

  /// returns an AlignMTB for converts images to median threshold bitmaps.
  /// of type AlignMTB converts images to median threshold bitmaps (1 for pixels
  /// brighter than median luminance and 0 otherwise) and than aligns the resulting
  /// bitmaps using bit operations.
  /// For further details, please see:
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html
  /// https://docs.opencv.org/master/d7/db6/classcv_1_1AlignMTB.html
  /// https://docs.opencv.org/master/d6/df5/group__photo__hdr.html#ga2f1fafc885a5d79dbfb3542e08db0244
  factory AlignMTB.create({int max_bits = 6, int exclude_range = 4, bool cut = true}) {
    final _ptr = _bindings.AlignMTB_CreateWithParams(max_bits, exclude_range, cut);
    return AlignMTB._(_ptr);
  }

  cvg.AlignMTB ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.AlignMTB_Close);

  List<Mat> process(List<Mat> src) {
    return using<List<Mat>>((arena) {
      final dst = arena<cvg.Mats>();
      dst.ref = _bindings.Mats_New();
      _bindings.AlignMTB_Process(ptr, src.toMats(arena).ref, dst);
      final res = List.generate(dst.ref.length, (i) => Mat.fromCMat(dst.ref.mats[i]));
      _bindings.Mats_Close(dst.ref);
      return res;
    });
  }
}

/// ColorChange mix two differently colored versions of an image seamlessly.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#ga6684f35dc669ff6196a7c340dc73b98e
Mat colorChange(
  InputArray src,
  InputArray mask, {
  double red_mul = 1.0,
  double green_mul = 1.0,
  double blue_mul = 1.0,
}) {
  final dst = Mat.empty();
  _bindings.ColorChange(src.ptr, mask.ptr, dst.ptr, red_mul, green_mul, blue_mul);
  return dst;
}

/// SeamlessClone blend two image by Poisson Blending.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#ga2bf426e4c93a6b1f21705513dfeca49d
Mat seamlessClone(InputArray src, InputArray dst, InputArray mask, Point p, int flags) {
  final blend = Mat.empty();
  _bindings.SeamlessClone(src.ptr, dst.ptr, mask.ptr, p.ref, blend.ptr, flags);
  return blend;
}

/// IlluminationChange modifies locally the apparent illumination of an image.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#gac5025767cf2febd8029d474278e886c7
Mat illuminationChange(
  InputArray src,
  InputArray mask, {
  double alpha = 0.2,
  double beta = 0.4,
}) {
  final dst = Mat.empty();
  _bindings.IlluminationChange(src.ptr, mask.ptr, dst.ptr, alpha, beta);
  return dst;
}

/// TextureFlattening washes out the texture of the selected region, giving its contents a flat aspect.
//
/// For further details, please see:
/// https://docs.opencv.org/master/df/da0/group__photo__clone.html#gad55df6aa53797365fa7cc23959a54004
Mat textureFlattening(
  InputArray src,
  InputArray mask, {
  double low_threshold = 30,
  double high_threshold = 45,
  int kernel_size = 3,
}) {
  final dst = Mat.empty();
  _bindings.TextureFlattening(src.ptr, mask.ptr, dst.ptr, low_threshold, high_threshold, kernel_size);
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
  _bindings.FastNlMeansDenoisingWithParams(
    src.ptr,
    dst.ptr,
    h,
    templateWindowSize,
    searchWindowSize,
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
  _bindings.FastNlMeansDenoisingColoredWithParams(
    src.ptr,
    dst.ptr,
    h,
    hColor,
    templateWindowSize,
    searchWindowSize,
  );
  return dst;
}

/// FastNlMeansDenoisingColoredMulti denoises the selected images.
//
/// For further details, please see:
/// https://docs.opencv.org/master/d1/d79/group__photo__denoise.html#gaa501e71f52fb2dc17ff8ca5e7d2d3619
Mat fastNlMeansDenoisingColoredMulti(
  List<Mat> srcImgs,
  int imgToDenoiseIndex,
  int temporalWindowSize, {
  double h = 3,
  double hColor = 3,
  int templateWindowSize = 7,
  int searchWindowSize = 21,
}) {
  return using<Mat>((arena) {
    final dst = Mat.empty();
    _bindings.FastNlMeansDenoisingColoredMultiWithParams(
      srcImgs.toMats(arena).ref,
      dst.ptr,
      imgToDenoiseIndex,
      temporalWindowSize,
      h,
      hColor,
      templateWindowSize,
      searchWindowSize,
    );
    return dst;
  });
}

/// DetailEnhance filter enhances the details of a particular image
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#ga0de660cb6f371a464a74c7b651415975
Mat detailEnhance(InputArray src, {double sigma_s = 10, double sigma_r = 0.15}) {
  final dst = Mat.empty();
  _bindings.DetailEnhance(src.ptr, dst.ptr, sigma_s, sigma_r);
  return dst;
}

/// EdgePreservingFilter filtering is the fundamental operation in image and video processing.
/// Edge-preserving smoothing filters are used in many different applications.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#gafaee2977597029bc8e35da6e67bd31f7
Mat edgePreservingFilter(
  InputArray src, {
  int flags = 1,
  double sigma_s = 60,
  double sigma_r = 0.4,
}) {
  final dst = Mat.empty();
  _bindings.EdgePreservingFilter(src.ptr, dst.ptr, flags, sigma_s, sigma_r);
  return dst;
}

/// PencilSketch pencil-like non-photorealistic line drawing.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#gae5930dd822c713b36f8529b21ddebd0c
(Mat dst1, Mat dst2) pencilSketch(
  InputArray src, {
  double sigma_s = 60,
  double sigma_r = 0.07,
  double shade_factor = 0.02,
}) {
  final dst1 = Mat.empty(), dst2 = Mat.empty();

  _bindings.PencilSketch(src.ptr, dst1.ptr, dst2.ptr, sigma_s, sigma_r, shade_factor);
  return (dst1, dst2);
}

/// Stylization aims to produce digital imagery with a wide variety of effects
/// not focused on photorealism. Edge-aware filters are ideal for stylization,
/// as they can abstract regions of low contrast while preserving, or enhancing,
/// high-contrast features.
//
/// For further details, please see:
/// https://docs.opencv.org/4.x/df/dac/group__photo__render.html#gacb0f7324017df153d7b5d095aed53206
Mat stylization(
  InputArray src, {
  double sigma_s = 60,
  double sigma_r = 0.45,
}) {
  final dst = Mat.empty();
  _bindings.Stylization(src.ptr, dst.ptr, sigma_s, sigma_r);
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
  _bindings.PhotoInpaint(src.ptr, inpaintMask.ptr, dst.ptr, inpaintRadius, flags);
  return dst;
}
