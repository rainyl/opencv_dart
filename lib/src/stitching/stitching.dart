// ignore_for_file: constant_identifier_names

library cv.stitching;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/stitching.g.dart' as cvg;
import '../native_lib.dart' show cstitching;

/// High level image stitcher.
///
/// It's possible to use this class without being aware of the entire
/// stitching pipeline. However, to be able to achieve higher stitching
/// stability and quality of the final images at least being familiar
/// with the theory is recommended.
/// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#details
class Stitcher extends CvStruct<cvg.Stitcher> {
  Stitcher._(cvg.StitcherPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Stitcher.fromPointer(cvg.StitcherPtr ptr, [bool attach = true]) => Stitcher._(ptr.cast(), attach);

  /// Creates a Stitcher configured in one of the stitching modes.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a308a47865a1f381e4429c8ec5e99549f
  factory Stitcher.create({StitcherMode mode = StitcherMode.PANORAMA}) {
    final ptr_ = calloc<cvg.Stitcher>();
    cvRun(() => cstitching.Stitcher_Create(mode.index, ptr_));
    return Stitcher._(ptr_);
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a9b90774eabdf68c9ee864918d620538d
  double get registrationResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      cvRun(() => cstitching.Stitcher_GetRegistrationResol(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a9912fe8c095b8385267908e5ef707439
  set registrationResol(double value) {
    cvRun(() => cstitching.Stitcher_SetRegistrationResol(ref, value));
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ac559c3eb228614f9402ff3eba23a08f5
  double get seamEstimationResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      cvRun(() => cstitching.Stitcher_GetSeamEstimationResol(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ad0fcef52b2fedda1dbb90ea780cd7979
  set seamEstimationResol(double value) {
    cvRun(() => cstitching.Stitcher_SetSeamEstimationResol(ref, value));
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ad13d2d50b253e471fbaf041b9a044571
  double get compositingResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      cvRun(() => cstitching.Stitcher_GetCompositingResol(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#afe927e80fcb2ca2061630ddd98eebba8
  set compositingResol(double value) {
    cvRun(() => cstitching.Stitcher_SetCompositingResol(ref, value));
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a3755bbeca7f4c80dc42af034f7621568
  double get panoConfidenceThresh {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      cvRun(() => cstitching.Stitcher_GetPanoConfidenceThresh(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a6f5e62bc1dd5d7bdb5f9313a2c21c558
  set panoConfidenceThresh(double value) {
    cvRun(() => cstitching.Stitcher_SetPanoConfidenceThresh(ref, value));
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#af6a51e0b23dac119a3612d57345f9a7f
  bool get waveCorrection {
    return using<bool>((arena) {
      final rptr = arena<ffi.Bool>();
      cvRun(() => cstitching.Stitcher_GetWaveCorrection(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a968a2f4a1faddfdacbcfce54b44bab70
  set waveCorrection(bool value) {
    cvRun(() => cstitching.Stitcher_SetWaveCorrection(ref, value));
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#abc0c8f54a1d223a1098206654813d973
  int get interpolationFlags {
    return using<int>((arena) {
      final rptr = arena<ffi.Int>();
      cvRun(() => cstitching.Stitcher_GetInterpolationFlags(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a253d04b8dcd3c674321b29139c769873
  set interpolationFlags(int value) {
    cvRun(() => cstitching.Stitcher_SetInterpolationFlags(ref, value));
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#ad9c9c9b8a97b686ad3b93f7918c4c6de
  int get waveCorrectKind {
    return using<int>((arena) {
      final rptr = arena<ffi.Int>();
      cvRun(() => cstitching.Stitcher_GetWaveCorrectKind(ref, rptr));
      return rptr.value;
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a17413f5c06e4e569bfd45e01d4e8ff4a
  set waveCorrectKind(int value) {
    cvRun(() => cstitching.Stitcher_SetWaveCorrectKind(ref, value));
  }

  /// These functions try to match the given images and to estimate rotations of each camera.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a4c25557af4d40a79a4d1f23d9548131d
  StitcherStatus estimateTransform(VecMat images, {VecMat? masks}) {
    return using<StitcherStatus>((arena) {
      final rptr = arena<ffi.Int>();
      masks ??= VecMat.fromList([]);
      cvRun(() => cstitching.Stitcher_EstimateTransform(ref, images.ref, masks!.ref, rptr));
      return StitcherStatus.fromInt(rptr.value);
    });
  }

  /// These functions try to compose the given images (or images stored internally
  /// from the other function calls) into the final pano under the assumption
  /// that the image transformations were estimated before.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#acc8409a6b2e548de1653f0dc5c2ccb02
  (StitcherStatus, Mat pano) composePanorama({VecMat? images}) {
    return using<(StitcherStatus, Mat)>((arena) {
      final rptr = arena<ffi.Int>();
      final rpano = Mat.empty();
      images == null
          ? cvRun(() => cstitching.Stitcher_ComposePanorama(ref, rpano.ref, rptr))
          : cvRun(() => cstitching.Stitcher_ComposePanorama_1(ref, images.ref, rpano.ref, rptr));
      return (StitcherStatus.fromInt(rptr.value), rpano);
    });
  }

  /// This is an overloaded member function, provided for convenience.
  /// It differs from the above function only in what argument(s) it accepts.
  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a37ee5bacf229e9d0fb9f97c8f5ed1acd
  (StitcherStatus, Mat pano) stitch(VecMat images, {VecMat? masks}) {
    return using<(StitcherStatus, Mat)>((arena) {
      final rptr = arena<ffi.Int>();
      final rpano = Mat.empty();
      masks == null
          ? cvRun(() => cstitching.Stitcher_Stitch(ref, images.ref, rpano.ref, rptr))
          : cvRun(() => cstitching.Stitcher_Stitch_1(ref, images.ref, masks.ref, rpano.ref, rptr));
      return (StitcherStatus.fromInt(rptr.value), rpano);
    });
  }

  /// https://docs.opencv.org/4.x/d2/d8d/classcv_1_1Stitcher.html#a7fed80561a9b46a1a924ac6cb334ac85
  VecI32 get component {
    final rptr = calloc<cvg.VecI32>();
    cvRun(() => cstitching.Stitcher_Component(ref, rptr));
    return VecI32.fromPointer(rptr);
  }

  static final finalizer = OcvFinalizer<cvg.StitcherPtr>(cstitching.addresses.Stitcher_Close);

  void dispose() {
    finalizer.detach(this);
    cstitching.Stitcher_Close(ptr);
  }

  @override
  cvg.Stitcher get ref => ptr.ref;
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
