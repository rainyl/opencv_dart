// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as cvg;
import '../g/contrib.g.dart' as ccontrib;

abstract class ImgHashBase {
  double compare(InputArray hashOne, InputArray hashTwo);
  Mat compute(InputArray inputArr, [OutputArray? outputArr]);
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo);
  Future<Mat> computeAsync(InputArray inputArr);
}

/// PHash is implementation of the PHash algorithm.
class PHash implements ImgHashBase {
  /// Compare compares the hash value between a and b using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    final p = calloc<ffi.Double>();
    cvRun(() => ccontrib.cv_img_hash_pHash_compare(hashOne.ref, hashTwo.ref, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Compute computes hash of the input image using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    outputArr ??= Mat.empty();
    cvRun(() => ccontrib.cv_img_hash_pHash_compute(inputArr.ref, outputArr!.ref, ffi.nullptr));
    return outputArr;
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final p = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_pHash_compare(hashOne.ref, hashTwo.ref, p, callback),
      (c) {
        final rval = p.value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  @override
  Future<Mat> computeAsync(InputArray inputArr, [OutputArray? outputArr]) async {
    outputArr ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_pHash_compute(inputArr.ref, outputArr!.ref, callback),
      (c) {
        return c.complete(outputArr);
      },
    );
  }
}

/// AverageHash is implementation of the AverageHash algorithm.
class AverageHash implements ImgHashBase {
  /// Compare compares the hash value between a and b using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    final p = calloc<ffi.Double>();
    cvRun(() => ccontrib.cv_img_hash_averageHash_compare(hashOne.ref, hashTwo.ref, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Compute computes hash of the input image using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    outputArr ??= Mat.empty();
    cvRun(() => ccontrib.cv_img_hash_averageHash_compute(inputArr.ref, outputArr!.ref, ffi.nullptr));
    return outputArr;
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final p = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_averageHash_compare(hashOne.ref, hashTwo.ref, p, callback),
      (c) {
        final rval = p.value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  @override
  Future<Mat> computeAsync(InputArray inputArr, [OutputArray? outputArr]) async {
    outputArr ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_averageHash_compute(inputArr.ref, outputArr!.ref, callback),
      (c) {
        return c.complete(outputArr);
      },
    );
  }
}

/// !< use fewer block and generate 16*16/8 uchar hash value
const int BLOCK_MEAN_HASH_MODE_0 = 0;

/// !< use block blocks(step sizes/2), generate 31*31/8 + 1 uchar hash value
const int BLOCK_MEAN_HASH_MODE_1 = 1;

/// BlockMeanHash is implementation of the BlockMeanHash algorithm.
class BlockMeanHash extends CvStruct<cvg.BlockMeanHash> implements ImgHashBase {
  BlockMeanHash._(cvg.BlockMeanHashPtr ptr, [this._mode = BLOCK_MEAN_HASH_MODE_0, bool attach = true])
      : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  static final finalizer = OcvFinalizer<cvg.BlockMeanHashPtr>(
    ccontrib.addresses.cv_img_hash_BlockMeanHash_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_img_hash_BlockMeanHash_close(ptr);
  }

  factory BlockMeanHash({int mode = BLOCK_MEAN_HASH_MODE_0}) {
    final p = calloc<cvg.BlockMeanHash>();
    cvRun(() => ccontrib.cv_img_hash_BlockMeanHash_create(mode, p, ffi.nullptr));
    return BlockMeanHash._(p, mode);
  }

  int _mode;
  int get mode => _mode;
  set mode(int mode) {
    _mode = mode;
    cvRun(() => ccontrib.cv_img_hash_BlockMeanHash_setMode(ref, mode, ffi.nullptr));
  }

  /// Compare compares the hash value between a and b using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    final p = calloc<ffi.Double>();
    cvRun(() => ccontrib.cv_img_hash_BlockMeanHash_compare(ref, hashOne.ref, hashTwo.ref, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Compute computes hash of the input image using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    outputArr ??= Mat.empty();
    cvRun(() => ccontrib.cv_img_hash_BlockMeanHash_compute(ref, inputArr.ref, outputArr!.ref, ffi.nullptr));
    return outputArr;
  }

  /// https://docs.opencv.org/4.x/df/d55/classcv_1_1img__hash_1_1BlockMeanHash.html#ad5aef85f58315551cac14bcabe05f0c3
  VecF64 getMean() {
    final ret = VecF64();
    cvRun(() => ccontrib.cv_img_hash_BlockMeanHash_getMean(ref, ret.ptr, ffi.nullptr));
    return ret;
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final p = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_BlockMeanHash_compare(ref, hashOne.ref, hashTwo.ref, p, callback),
      (c) {
        final rval = p.value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  @override
  Future<Mat> computeAsync(InputArray inputArr, [OutputArray? outputArr]) async {
    outputArr ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_BlockMeanHash_compute(ref, inputArr.ref, outputArr!.ref, callback),
      (c) {
        return c.complete(outputArr);
      },
    );
  }

  Future<VecF64> getMeanAsync() async {
    final ret = VecF64();
    return cvRunAsync0<VecF64>(
      (callback) => ccontrib.cv_img_hash_BlockMeanHash_getMean(ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }

  @override
  cvg.BlockMeanHash get ref => ptr.ref;
}

/// ColorMomentHash is implementation of the ColorMomentHash algorithm.
class ColorMomentHash implements ImgHashBase {
  /// Compare compares the hash value between a and b using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    final p = calloc<ffi.Double>();
    cvRun(() => ccontrib.cv_img_hash_colorMomentHash_compare(hashOne.ref, hashTwo.ref, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Compute computes hash of the input image using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    outputArr ??= Mat.empty();
    cvRun(() => ccontrib.cv_img_hash_colorMomentHash_compute(inputArr.ref, outputArr!.ref, ffi.nullptr));
    return outputArr;
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final p = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_colorMomentHash_compare(hashOne.ref, hashTwo.ref, p, callback),
      (c) {
        final rval = p.value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  @override
  Future<Mat> computeAsync(InputArray inputArr, [OutputArray? outputArr]) async {
    outputArr ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_colorMomentHash_compute(inputArr.ref, outputArr!.ref, callback),
      (c) {
        return c.complete(outputArr);
      },
    );
  }
}

/// MarrHildrethHash is implementation of the MarrHildrethHash algorithm.
class MarrHildrethHash implements ImgHashBase {
  double alpha = 2.0;
  double scale = 1.0;

  MarrHildrethHash({this.alpha = 2.0, this.scale = 1.0});

  /// Compare compares the hash value between a and b using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    final p = calloc<ffi.Double>();
    cvRun(
      () => ccontrib.cv_img_hash_marrHildrethHash_compare(
        hashOne.ref,
        hashTwo.ref,
        alpha,
        scale,
        p,
        ffi.nullptr,
      ),
    );
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Compute computes hash of the input image using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    outputArr ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_img_hash_marrHildrethHash_compute(
        inputArr.ref,
        outputArr!.ref,
        alpha,
        scale,
        ffi.nullptr,
      ),
    );
    return outputArr;
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final p = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) =>
          ccontrib.cv_img_hash_marrHildrethHash_compare(hashOne.ref, hashTwo.ref, alpha, scale, p, callback),
      (c) {
        final rval = p.value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  @override
  Future<Mat> computeAsync(InputArray inputArr, [OutputArray? outputArr]) async {
    outputArr ??= Mat.empty();
    return cvRunAsync0(
      (callback) =>
          ccontrib.cv_img_hash_marrHildrethHash_compute(inputArr.ref, outputArr!.ref, alpha, scale, callback),
      (c) {
        return c.complete(outputArr);
      },
    );
  }
}

/// RadialVarianceHash is implementation of the RadialVarianceHash algorithm.
class RadialVarianceHash implements ImgHashBase {
  double sigma = 1;
  int numOfAngleLine = 180;

  RadialVarianceHash({this.sigma = 1, this.numOfAngleLine = 180});

  /// Compare compares the hash value between a and b using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    final p = calloc<ffi.Double>();
    cvRun(
      () => ccontrib.cv_img_hash_radialVarianceHash_compare(
        hashOne.ref,
        hashTwo.ref,
        sigma,
        numOfAngleLine,
        p,
        ffi.nullptr,
      ),
    );
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Compute computes hash of the input image using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    outputArr ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_img_hash_radialVarianceHash_compute(
        inputArr.ref,
        outputArr!.ref,
        sigma,
        numOfAngleLine,
        ffi.nullptr,
      ),
    );
    return outputArr;
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final p = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_radialVarianceHash_compare(
        hashOne.ref,
        hashTwo.ref,
        sigma,
        numOfAngleLine,
        p,
        callback,
      ),
      (c) {
        final rval = p.value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  @override
  Future<Mat> computeAsync(InputArray inputArr, [OutputArray? outputArr]) async {
    outputArr ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_img_hash_radialVarianceHash_compute(
        inputArr.ref,
        outputArr!.ref,
        sigma,
        numOfAngleLine,
        callback,
      ),
      (c) {
        return c.complete(outputArr);
      },
    );
  }
}
