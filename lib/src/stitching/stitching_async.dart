library cv.stitching;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/stitching.g.dart' as cvg;
import '../native_lib.dart' show cstitching;
import './stitching.dart';

extension StitcherAsync on Stitcher {
  static Future<Stitcher> createAsync({
    StitcherMode mode = StitcherMode.PANORAMA,
  }) async =>
      cvRunAsync(
        (callback) => cstitching.Stitcher_Create_Async(mode.index, callback),
        (c, p) => c.complete(Stitcher.fromPointer(p.cast<cvg.Stitcher>())),
      );

  Future<double> getRegistrationResolAsync() async => cvRunAsync(
        (callback) => cstitching.Stitcher_GetRegistrationResol_Async(ref, callback),
        doubleCompleter,
      );

  Future<void> setRegistrationResolAsync(double value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetRegistrationResol_Async(ref, value, callback),
        (c) => c.complete(),
      );

  Future<double> getSeamEstimationResolAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_GetSeamEstimationResol_Async(ref, callback),
      doubleCompleter,
    );
  }

  Future<void> setSeamEstimationResolAsync(double value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetSeamEstimationResol_Async(ref, value, callback),
        (c) => c.complete(),
      );

  Future<double> getCompositingResolAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_GetCompositingResol_Async(ref, callback),
      doubleCompleter,
    );
  }

  Future<void> setCompositingResolAsync(double value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetCompositingResol_Async(ref, value, callback),
        (c) => c.complete(),
      );

  Future<double> getPanoConfidenceThreshAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_GetPanoConfidenceThresh_Async(ref, callback),
      doubleCompleter,
    );
  }

  Future<void> setPanoConfidenceThreshAsync(double value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetPanoConfidenceThresh_Async(
          ref,
          value,
          callback,
        ),
        (c) => c.complete(),
      );

  Future<bool> getWaveCorrectionAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_GetWaveCorrection_Async(ref, callback),
      boolCompleter,
    );
  }

  Future<void> setWaveCorrectionAsync(bool value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetWaveCorrection_Async(ref, value, callback),
        (c) => c.complete(),
      );

  Future<int> getInterpolationFlagsAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_GetInterpolationFlags_Async(ref, callback),
      intCompleter,
    );
  }

  Future<void> setInterpolationFlagsAsync(int value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetInterpolationFlags_Async(ref, value, callback),
        (c) => c.complete(),
      );

  Future<int> getWaveCorrectKindAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_GetWaveCorrectKind_Async(ref, callback),
      intCompleter,
    );
  }

  Future<void> setWaveCorrectKindAsync(int value) async => cvRunAsync0(
        (callback) => cstitching.Stitcher_SetWaveCorrectKind_Async(ref, value, callback),
        (c) => c.complete(),
      );

  Future<StitcherStatus> estimateTransformAsync(
    VecMat images, {
    VecMat? masks,
  }) async {
    masks ??= VecMat.fromList([]);
    return cvRunAsync(
        (callback) => cstitching.Stitcher_EstimateTransform_Async(
              ref,
              images.ref,
              masks!.ref,
              callback,
            ), (c, p) {
      final value = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(StitcherStatus.fromInt(value));
    });
  }

  Future<(StitcherStatus, Mat)> composePanoramaAsync({VecMat? images}) async {
    return cvRunAsync2(
        (callback) => images == null
            ? cstitching.Stitcher_ComposePanorama_Async(
                ref,
                callback,
              )
            : cstitching.Stitcher_ComposePanorama_1_Async(
                ref,
                images.ref,
                callback,
              ), (c, status, pano) {
      final value = status.cast<ffi.Int>().value;
      calloc.free(status);
      return c.complete(
        (StitcherStatus.fromInt(value), Mat.fromPointer(pano.cast<cvg.Mat>())),
      );
    });
  }

  Future<(StitcherStatus, Mat)> stitchAsync(
    VecMat images, {
    VecMat? masks,
  }) async {
    return cvRunAsync2(
        (callback) => masks == null
            ? cstitching.Stitcher_Stitch_Async(
                ref,
                images.ref,
                callback,
              )
            : cstitching.Stitcher_Stitch_1_Async(
                ref,
                images.ref,
                masks.ref,
                callback,
              ), (c, status, pano) {
      final value = status.cast<ffi.Int>().value;
      calloc.free(status);
      return c.complete(
        (StitcherStatus.fromInt(value), Mat.fromPointer(pano.cast<cvg.Mat>())),
      );
    });
  }

  Future<VecI32> getComponentAsync() async {
    return cvRunAsync(
      (callback) => cstitching.Stitcher_Component_Async(ref, callback),
      (c, p) => c.complete(VecI32.fromPointer(p.cast<cvg.VecI32>())),
    );
  }
}
