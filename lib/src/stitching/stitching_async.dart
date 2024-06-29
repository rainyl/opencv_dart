library cv;

import 'dart:ffi' as ffi;
import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import './stitching.dart';

extension StitcherAsync on Stitcher {
  static Future<Stitcher> createAsync({
    StitcherMode mode = StitcherMode.PANORAMA,
  }) async {
    return cvRunAsync(
      (callback) => CFFI.Stitcher_Create_Async(mode.index, callback),
      (c, p) => c.complete(Stitcher.fromPointer(p.cast<cvg.PtrStitcher>())),
    );
  }

  Future<Stitcher> getStitcherAsync() async {
    return cvRunAsync(
      (callback) => CFFI.Stitcher_Get_Async(ptr.ref, callback),
      (c, p) => c.complete(Stitcher.fromPointer(p.cast<cvg.PtrStitcher>())),
    );
  }

  Future<double> getRegistrationResolAsync() async {
    return cvRunAsync(
      (callback) =>
          CFFI.Stitcher_GetRegistrationResol_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setRegistrationResolAsync(double value) async {
    await cvRunAsync0(
      (callback) =>
          CFFI.Stitcher_SetRegistrationResol_Async(stitcher, value, callback),
      (c) => c.complete(),
    );
  }

  Future<double> getSeamEstimationResolAsync() async {
    return cvRunAsync(
      (callback) =>
          CFFI.Stitcher_GetSeamEstimationResol_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setSeamEstimationResolAsync(double value) async {
    await cvRunAsync0(
      (callback) =>
          CFFI.Stitcher_SetSeamEstimationResol_Async(stitcher, value, callback),
      (c) => c.complete(),
    );
  }

  Future<double> getCompositingResolAsync() async {
    return cvRunAsync(
      (callback) => CFFI.Stitcher_GetCompositingResol_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setCompositingResolAsync(double value) async {
    await cvRunAsync0(
      (callback) =>
          CFFI.Stitcher_SetCompositingResol_Async(stitcher, value, callback),
      (c) => c.complete(),
    );
  }

  Future<double> getPanoConfidenceThreshAsync() async {
    return cvRunAsync(
      (callback) =>
          CFFI.Stitcher_GetPanoConfidenceThresh_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setPanoConfidenceThreshAsync(double value) async {
    await cvRunAsync0(
      (callback) => CFFI.Stitcher_SetPanoConfidenceThresh_Async(
        stitcher,
        value,
        callback,
      ),
      (c) => c.complete(),
    );
  }

  Future<bool> getWaveCorrectionAsync() async {
    return cvRunAsync(
      (callback) => CFFI.Stitcher_GetWaveCorrection_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setWaveCorrectionAsync(bool value) async {
    await cvRunAsync0(
      (callback) =>
          CFFI.Stitcher_SetWaveCorrection_Async(stitcher, value, callback),
      (
        c,
      ) =>
          c.complete(),
    );
  }

  Future<int> getInterpolationFlagsAsync() async {
    return cvRunAsync(
      (callback) =>
          CFFI.Stitcher_GetInterpolationFlags_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setInterpolationFlagsAsync(int value) async {
    await cvRunAsync0(
      (callback) =>
          CFFI.Stitcher_SetInterpolationFlags_Async(stitcher, value, callback),
      (c) => c.complete(),
    );
  }

  Future<int> getWaveCorrectKindAsync() async {
    return cvRunAsync(
      (callback) => CFFI.Stitcher_GetWaveCorrectKind_Async(stitcher, callback),
      (c, p) => c.complete(p.value),
    );
  }

  Future<void> setWaveCorrectKindAsync(int value) async {
    await cvRunAsync0(
      (callback) =>
          CFFI.Stitcher_SetWaveCorrectKind_Async(stitcher, value, callback),
      (
        c,
      ) =>
          c.complete(),
    );
  }

  Future<StitcherStatus> estimateTransformAsync(
    VecMat images, {
    VecMat? masks,
  }) async {
    masks ??= VecMat.fromList([]);
    return cvRunAsync(
      (callback) => CFFI.Stitcher_EstimateTransform_Async(
        stitcher,
        images.ref,
        masks!.ref,
        callback,
      ),
      (c, p) => c.complete(StitcherStatus.fromInt(p.value)),
    );
  }

  Future<(StitcherStatus, Mat)> composePanoramaAsync({VecMat? images}) async {
    return cvRunAsync2(
      (callback) => images == null
          ? CFFI.Stitcher_ComposePanorama_Async(
              stitcher,
              callback,
            )
          : CFFI.Stitcher_ComposePanorama_1_Async(
              stitcher,
              images.ref,
              callback,
            ),
      (c, status, pano) => c.complete(
        (
          StitcherStatus.fromInt(status.value),
          Mat.fromPointer(pano.cast<cvg.Mat>())
        ),
      ),
    );
  }

  Future<(StitcherStatus, Mat)> stitchAsync(
    VecMat images, {
    VecMat? masks,
  }) async {
    return cvRunAsync2(
      (callback) => masks == null
          ? CFFI.Stitcher_Stitch_Async(
              stitcher,
              images.ref,
              callback,
            )
          : CFFI.Stitcher_Stitch_1_Async(
              stitcher,
              images.ref,
              masks.ref,
              callback,
            ),
      (c, status, pano) => c.complete(
        (
          StitcherStatus.fromInt(status.value),
          Mat.fromPointer(pano.cast<cvg.Mat>())
        ),
      ),
    );
  }

  Future<VecInt> getComponentAsync() async {
    return cvRunAsync(
      (callback) => CFFI.Stitcher_Component_Async(stitcher, callback),
      (c, p) => c.complete(VecInt.fromPointer(p.cast<cvg.VecInt>())),
    );
  }
}
