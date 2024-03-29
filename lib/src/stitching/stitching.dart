library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// High level image stitcher.
///
/// It's possible to use this class without being aware of the entire
/// stitching pipeline. However, to be able to achieve higher stitching
/// stability and quality of the final images at least being familiar
/// with the theory is recommended.
/// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#details
class Stitcher implements ffi.Finalizable {
  Stitcher._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  cvg.PtrStitcher ptr;
  cvg.Stitcher get stitcher {
    final s = calloc<cvg.Stitcher>();
    final status1 = _bindings.Stitcher_Get(ptr, s);
    cvRun(status1);
    return s.value;
  }

  static final finalizer = Finalizer<cvg.PtrStitcher>((p) => _bindings.Stitcher_Close(p));

  /// Creates a Stitcher configured in one of the stitching modes.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a308a47865a1f381e4429c8ec5e99549f
  factory Stitcher.create({StitcherMode mode = StitcherMode.PANORAMA}) {
    final ptr_ = calloc<cvg.PtrStitcher>();
    final status = _bindings.Stitcher_Create(mode.index, ptr_);
    cvRun(status);
    return Stitcher._(ptr_.value);
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a9b90774eabdf68c9ee864918d620538d
  double get registrationResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetRegistrationResol(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a9912fe8c095b8385267908e5ef707439
  set registrationResol(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetRegistrationResol(stitcher, value);
      cvRun(status);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ac559c3eb228614f9402ff3eba23a08f5
  double get seamEstimationResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetSeamEstimationResol(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ad0fcef52b2fedda1dbb90ea780cd7979
  set seamEstimationResol(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetSeamEstimationResol(stitcher, value);
      cvRun(status);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ad13d2d50b253e471fbaf041b9a044571
  double get compositingResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetCompositingResol(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#afe927e80fcb2ca2061630ddd98eebba8
  set compositingResol(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetCompositingResol(stitcher, value);
      cvRun(status);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a3755bbeca7f4c80dc42af034f7621568
  double get panoConfidenceThresh {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetPanoConfidenceThresh(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a6f5e62bc1dd5d7bdb5f9313a2c21c558
  set panoConfidenceThresh(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetPanoConfidenceThresh(stitcher, value);
      cvRun(status);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#af6a51e0b23dac119a3612d57345f9a7f
  bool get waveCorrection {
    return using<bool>((arena) {
      final rptr = arena<ffi.Bool>();
      final status = _bindings.Stitcher_GetWaveCorrection(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a968a2f4a1faddfdacbcfce54b44bab70
  set waveCorrection(bool value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetWaveCorrection(stitcher, value);
      cvRun(status);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#abc0c8f54a1d223a1098206654813d973
  int get interpolationFlags {
    return using<int>((arena) {
      final rptr = arena<ffi.Int>();
      final status = _bindings.Stitcher_GetInterpolationFlags(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a253d04b8dcd3c674321b29139c769873
  set interpolationFlags(int value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetInterpolationFlags(stitcher, value);
      cvRun(status);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ad9c9c9b8a97b686ad3b93f7918c4c6de
  int get waveCorrectKind {
    return using<int>((arena) {
      final rptr = arena<ffi.Int>();
      final status = _bindings.Stitcher_GetWaveCorrectKind(stitcher, rptr);
      cvRun(status);
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a17413f5c06e4e569bfd45e01d4e8ff4a
  set waveCorrectKind(int value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetWaveCorrectKind(stitcher, value);
      cvRun(status);
    });
  }

  /// These functions try to match the given images and to estimate rotations of each camera.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a4c25557af4d40a79a4d1f23d9548131d
  StitcherStatus estimateTransform(List<Mat> images, {List<Mat>? masks}) {
    return using<StitcherStatus>((arena) {
      final rptr = arena<ffi.Int>();
      masks ??= [];
      final status = _bindings.Stitcher_EstimateTransform(
          stitcher, images.toMats(arena).ref, masks!.toMats(arena).ref, rptr);
      cvRun(status);
      return StitcherStatus.fromInt(rptr.value);
    });
  }

  /// These functions try to compose the given images (or images stored internally
  /// from the other function calls) into the final pano under the assumption
  /// that the image transformations were estimated before.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#acc8409a6b2e548de1653f0dc5c2ccb02
  (StitcherStatus, Mat) composePanorama({List<Mat>? images}) {
    return using<(StitcherStatus, Mat)>((arena) {
      final rptr = arena<ffi.Int>();
      final rpano = arena<cvg.Mat>();
      final status = images == null
          ? _bindings.Stitcher_ComposePanorama(stitcher, rpano.value, rptr)
          : _bindings.Stitcher_ComposePanorama_1(stitcher, images.toMats(arena).ref, rpano.value, rptr);
      cvRun(status);
      return (StitcherStatus.fromInt(rptr.value), Mat.fromCMat(rpano.value));
    });
  }

  /// This is an overloaded member function, provided for convenience.
  /// It differs from the above function only in what argument(s) it accepts.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a37ee5bacf229e9d0fb9f97c8f5ed1acd
  (StitcherStatus, Mat) stitch(List<Mat> images, {List<Mat>? masks}) {
    return using<(StitcherStatus, Mat)>((arena) {
      final rptr = arena<ffi.Int>();
      final rpano = Mat.empty();
      final status = masks == null
          ? _bindings.Stitcher_Stitch(stitcher, images.toMats(arena).ref, rpano.ptr, rptr)
          : _bindings.Stitcher_Stitch_1(
              stitcher, images.toMats(arena).ref, masks.toMats(arena).ref, rpano.ptr, rptr);
      cvRun(status);
      return (StitcherStatus.fromInt(rptr.value), rpano);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a7fed80561a9b46a1a924ac6cb334ac85
  List<int> get component {
    return using<List<int>>((arena) {
      final rptr = arena<cvg.IntVector>();
      final status = _bindings.Stitcher_Component(stitcher, rptr);
      cvRun(status);
      return List.generate(rptr.ref.length, (i) => rptr.ref.val[i]);
    });
  }
}

/// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a507409ce9435dd89857469d12ec06b45
enum StitcherStatus {
  OK,
  ERR_NEED_MORE_IMGS,
  ERR_HOMOGRAPHY_EST_FAIL,
  ERR_CAMERA_PARAMS_ADJUST_FAIL;

  factory StitcherStatus.fromInt(int v) => values.firstWhere((e) => e.index == v);
}

/// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a114713924ec05a0309f4df7e918c0324
enum StitcherMode {
  /// Mode for creating photo panoramas. Expects images under perspective transformation and projects resulting pano to sphere.
  PANORAMA,

  /// Mode for composing scans. Expects images under affine transformation does not compensate exposure by default.
  SCANS;

  factory StitcherMode.fromInt(int v) => values.firstWhere((e) => e.index == v);
}

/// https://docs.opencv.org/4.x/d7/d74/group__stitching__rotation.html#ga83b24d4c3e93584986a56d9e43b9cf7f
enum WaveCorrectKind { HORIZONTAL, VERTICAL }
