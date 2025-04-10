// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.stitching;

import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/stitching.g.dart' as cstitching;
import './stitching.dart';

extension StitcherAsync on Stitcher {
  Future<StitcherStatus> estimateTransformAsync(VecMat images, {VecMat? masks}) async {
    final rptr = calloc<ffi.Int>();
    masks ??= VecMat.fromList([]);
    return cvRunAsync0(
      (callback) => cstitching.cv_Stitcher_estimateTransform(ref, images.ref, masks!.ref, rptr, callback),
      (c) {
        final rval = StitcherStatus.fromInt(rptr.value);
        calloc.free(rptr);
        return c.complete(rval);
      },
    );
  }

  Future<(StitcherStatus, Mat)> composePanoramaAsync({VecMat? images}) async {
    final rptr = calloc<ffi.Int>();
    final rpano = Mat.empty();
    void completeFunc(Completer c) {
      final rval = (StitcherStatus.fromInt(rptr.value), rpano);
      calloc.free(rptr);
      return c.complete(rval);
    }

    if (images == null) {
      return cvRunAsync0(
        (callback) => cstitching.cv_Stitcher_composePanorama(ref, rpano.ref, rptr, callback),
        completeFunc,
      );
    }
    return cvRunAsync0(
      (callback) => cstitching.cv_Stitcher_composePanorama_1(ref, images.ref, rpano.ref, rptr, callback),
      completeFunc,
    );
  }

  Future<(StitcherStatus, Mat)> stitchAsync(VecMat images, {VecMat? masks}) async {
    final rptr = calloc<ffi.Int>();
    final rpano = Mat.empty();
    void completeFunc(Completer c) {
      final rval = (StitcherStatus.fromInt(rptr.value), rpano);
      calloc.free(rptr);
      return c.complete(rval);
    }

    if (masks == null) {
      return cvRunAsync0(
        (callback) => cstitching.cv_Stitcher_stitch(ref, images.ref, rpano.ref, rptr, callback),
        completeFunc,
      );
    }
    return cvRunAsync0(
      (callback) => cstitching.cv_Stitcher_stitch_1(ref, images.ref, masks.ref, rpano.ref, rptr, callback),
      completeFunc,
    );
  }
}
