library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/opencv_dart.dart';
import 'package:opencv_dart/src/core/error_code.dart';

import '../core/mat_type.dart';
import '../core/point.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

// Creates a Stitcher configured in one of the stitching modes.
class Stitcher implements ffi.Finalizable {
  Stitcher._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  cvg.Stitcher ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.Stitcher_Close);

  factory Stitcher.create({StitcherMode mode = StitcherMode.PANORAMA}) {
    final ptr = calloc<cvg.Stitcher>();
    final status = _bindings.Stitcher_Create(mode.value, ptr);
    throwIfFailed(status);
    return Stitcher._(ptr.value);
  }

  double get registrationResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetRegistrationResol(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set registrationResol(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetRegistrationResol(ptr, value);
      throwIfFailed(status);
    });
  }

  double get seamEstimationResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetSeamEstimationResol(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set seamEstimationResol(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetSeamEstimationResol(ptr, value);
      throwIfFailed(status);
    });
  }

  double get compositingResol {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetCompositingResol(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set compositingResol(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetCompositingResol(ptr, value);
      throwIfFailed(status);
    });
  }

  double get panoConfidenceThresh {
    return using<double>((arena) {
      final rptr = arena<ffi.Double>();
      final status = _bindings.Stitcher_GetPanoConfidenceThresh(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set panoConfidenceThresh(double value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetPanoConfidenceThresh(ptr, value);
      throwIfFailed(status);
    });
  }

  bool get waveCorrection {
    return using<bool>((arena) {
      final rptr = arena<ffi.Bool>();
      final status = _bindings.Stitcher_GetWaveCorrection(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set waveCorrection(bool value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetWaveCorrection(ptr, value);
      throwIfFailed(status);
    });
  }

  int get interpolationFlags {
    return using<int>((arena) {
      final rptr = arena<ffi.Int>();
      final status = _bindings.Stitcher_GetInterpolationFlags(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set interpolationFlags(int value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetInterpolationFlags(ptr, value);
      throwIfFailed(status);
    });
  }

  int get waveCorrectKind {
    return using<int>((arena) {
      final rptr = arena<ffi.Int>();
      final status = _bindings.Stitcher_GetWaveCorrectKind(ptr, rptr);
      throwIfFailed(status);
      return rptr.value;
    });
  }

  set waveCorrectKind(int value) {
    using<void>((arena) {
      final status = _bindings.Stitcher_SetWaveCorrectKind(ptr, value);
      throwIfFailed(status);
    });
  }

  StitcherStatus estimateTransform(List<Mat> images, {List<Rect>? masks}) {
    return using<StitcherStatus>((arena) {
      final rptr = arena<ffi.Int>();
      masks ??= [];
      final status = _bindings.Stitcher_EstimateTransform(
          ptr, images.toMats(arena).ref, masks!.toNative(arena).ref, rptr);
      throwIfFailed(status);
      return StitcherStatus.fromInt(rptr.value);
    });
  }

  (StitcherStatus, Mat) composePanorama({List<Mat>? images}) {
    return using<(StitcherStatus, Mat)>((arena) {
      final rptr = arena<ffi.Int>();
      final rpano = arena<cvg.Mat>();
      final status = images == null
          ? _bindings.Stitcher_ComposePanorama(ptr, rpano.value, rptr)
          : _bindings.Stitcher_ComposePanorama_1(ptr, images.toMats(arena).ref, rpano.value, rptr);
      throwIfFailed(status);
      return (StitcherStatus.fromInt(rptr.value), Mat.fromCMat(rpano.value));
    });
  }

  (StitcherStatus, Mat) stitch(List<Mat> images, {List<Rect>? masks}) {
    return using<(StitcherStatus, Mat)>((arena) {
      final rptr = arena<ffi.Int>();
      final rpano = Mat.empty();
      final status = masks == null
          ? _bindings.Stitcher_Stitch(ptr, images.toMats(arena).ref, rpano.ptr, rptr)
          : _bindings.Stitcher_Stitch_1(
              ptr, images.toMats(arena).ref, masks.toNative(arena).ref, rpano.ptr, rptr);
      throwIfFailed(status);
      return (StitcherStatus.fromInt(rptr.value), rpano);
    });
  }

  List<int> get component {
    return using<List<int>>((arena) {
      final rptr = arena<cvg.IntVector>();
      final status = _bindings.Stitcher_Component(ptr, rptr);
      throwIfFailed(status);
      return List.generate(rptr.ref.length, (i) => rptr.ref.val[i]);
    });
  }
}

enum StitcherStatus {
  OK(0),
  ERR_NEED_MORE_IMGS(1),
  ERR_HOMOGRAPHY_EST_FAIL(2),
  ERR_CAMERA_PARAMS_ADJUST_FAIL(3);

  const StitcherStatus(this.value);
  factory StitcherStatus.fromInt(int v) => values.firstWhere((e) => e.value == v);
  final int value;
}

enum StitcherMode {
  PANORAMA(0),
  SCANS(1);

  const StitcherMode(this.value);
  factory StitcherMode.fromInt(int v) => values.firstWhere((e) => e.value == v);
  final int value;
}
