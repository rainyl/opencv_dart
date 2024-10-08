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
import '../native_lib.dart' show ccontrib;

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
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => ccontrib.pHashCompare(hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    final p = outputArr?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => ccontrib.pHashCompute(inputArr.ref, p));
    return outputArr ?? Mat.fromPointer(p);
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async => cvRunAsync<double>(
        (callback) => ccontrib.pHashCompare_Async(hashOne.ref, hashTwo.ref, callback),
        doubleCompleter,
      );

  @override
  Future<Mat> computeAsync(InputArray inputArr) async => cvRunAsync<Mat>(
        (callback) => ccontrib.pHashCompute_Async(inputArr.ref, callback),
        matCompleter,
      );
}

/// AverageHash is implementation of the AverageHash algorithm.
class AverageHash implements ImgHashBase {
  /// Compare compares the hash value between a and b using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => ccontrib.averageHashCompare(hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    final p = outputArr?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => ccontrib.averageHashCompute(inputArr.ref, p));
    return outputArr ?? Mat.fromPointer(p);
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async => cvRunAsync<double>(
        (callback) => ccontrib.averageHashCompare_Async(hashOne.ref, hashTwo.ref, callback),
        doubleCompleter,
      );

  @override
  Future<Mat> computeAsync(InputArray inputArr) async => cvRunAsync<Mat>(
        (callback) => ccontrib.averageHashCompute_Async(
          inputArr.ref,
          callback,
        ),
        matCompleter,
      );
}

/// !< use fewer block and generate 16*16/8 uchar hash value
const int BLOCK_MEAN_HASH_MODE_0 = 0;

/// !< use block blocks(step sizes/2), generate 31*31/8 + 1 uchar hash value
const int BLOCK_MEAN_HASH_MODE_1 = 1;

/// BlockMeanHash is implementation of the BlockMeanHash algorithm.
class BlockMeanHash extends CvStruct<cvg.BlockMeanHash> implements ImgHashBase {
  BlockMeanHash._(
    cvg.BlockMeanHashPtr ptr, [
    this._mode = BLOCK_MEAN_HASH_MODE_0,
    bool attach = true,
  ]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  static final finalizer = OcvFinalizer<cvg.BlockMeanHashPtr>(ccontrib.addresses.BlockMeanHash_Close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.BlockMeanHash_Close(ptr);
  }

  factory BlockMeanHash({int mode = BLOCK_MEAN_HASH_MODE_0}) {
    final p = calloc<cvg.BlockMeanHash>();
    cvRun(() => ccontrib.BlockMeanHash_Create(mode, p));
    return BlockMeanHash._(p, mode);
  }

  int _mode;
  int get mode => _mode;
  set mode(int mode) {
    _mode = mode;
    cvRun(() => ccontrib.BlockMeanHash_SetMode(ref, mode));
  }

  /// Compare compares the hash value between a and b using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => ccontrib.BlockMeanHash_Compare(ref, hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    final p = outputArr?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => ccontrib.BlockMeanHash_Compute(ref, inputArr.ref, p));
    return outputArr ?? Mat.fromPointer(p);
  }

  /// https://docs.opencv.org/4.x/df/d55/classcv_1_1img__hash_1_1BlockMeanHash.html#ad5aef85f58315551cac14bcabe05f0c3
  List<double> getMean() {
    return using<List<double>>((arena) {
      final ret = arena<ffi.Pointer<ffi.Double>>();
      final length = arena<ffi.Int>();
      cvRun(() => ccontrib.BlockMeanHash_GetMean(ref, ret, length));
      if (length.value == 0) return List<double>.empty();
      return List.generate(length.value, (i) => ret.value[i]);
    });
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async => cvRunAsync<double>(
        (callback) => ccontrib.BlockMeanHash_Compare_Async(
          ref,
          hashOne.ref,
          hashTwo.ref,
          callback,
        ),
        doubleCompleter,
      );

  @override
  Future<Mat> computeAsync(InputArray inputArr) async => cvRunAsync1<Mat>(
        (callback) => ccontrib.BlockMeanHash_Compute_Async(
          ref,
          inputArr.ref,
          callback,
        ),
        matCompleter,
      );

  Future<VecF64> getMeanAsync() async => cvRunAsync<VecF64>(
        (callback) => ccontrib.BlockMeanHash_GetMean_Async(ref, callback),
        vecF64Completer,
      );

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
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => ccontrib.colorMomentHashCompare(hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    final p = outputArr?.ptr ?? calloc<cvg.Mat>();
    cvRun(() => ccontrib.colorMomentHashCompute(inputArr.ref, p));
    return outputArr ?? Mat.fromPointer(p);
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async => cvRunAsync<double>(
        (callback) => ccontrib.colorMomentHashCompare_Async(
          hashOne.ref,
          hashTwo.ref,
          callback,
        ),
        doubleCompleter,
      );

  @override
  Future<Mat> computeAsync(InputArray inputArr) async => cvRunAsync<Mat>(
        (callback) => ccontrib.colorMomentHashCompute_Async(
          inputArr.ref,
          callback,
        ),
        matCompleter,
      );
}

/// MarrHildrethHash is implementation of the MarrHildrethHash algorithm.
class NewMarrHildrethHash implements ImgHashBase {
  double alpha = 2.0;
  double scale = 1.0;

  NewMarrHildrethHash({this.alpha = 2.0, this.scale = 1.0});

  /// Compare compares the hash value between a and b using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.marrHildrethHashCompare(
          hashOne.ref,
          hashTwo.ref,
          alpha,
          scale,
          p,
        ),
      );
      return p.value;
    });
  }

  /// Compute computes hash of the input image using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    final p = outputArr?.ptr ?? calloc<cvg.Mat>();
    cvRun(
      () => ccontrib.marrHildrethHashCompute(
        inputArr.ref,
        p,
        alpha,
        scale,
      ),
    );
    return outputArr ?? Mat.fromPointer(p);
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async => cvRunAsync<double>(
        (callback) => ccontrib.marrHildrethHashCompare_Async(
          hashOne.ref,
          hashTwo.ref,
          alpha,
          scale,
          callback,
        ),
        doubleCompleter,
      );

  @override
  Future<Mat> computeAsync(InputArray inputArr) async => cvRunAsync<Mat>(
        (callback) => ccontrib.marrHildrethHashCompute_Async(
          inputArr.ref,
          alpha,
          scale,
          callback,
        ),
        matCompleter,
      );
}

/// NewRadialVarianceHash is implementation of the NewRadialVarianceHash algorithm.
class NewRadialVarianceHash implements ImgHashBase {
  double sigma = 1;
  int numOfAngleLine = 180;

  NewRadialVarianceHash({this.sigma = 1, this.numOfAngleLine = 180});

  /// Compare compares the hash value between a and b using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.radialVarianceHashCompare(
          hashOne.ref,
          hashTwo.ref,
          sigma,
          numOfAngleLine,
          p,
        ),
      );
      return p.value;
    });
  }

  /// Compute computes hash of the input image using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  Mat compute(InputArray inputArr, [OutputArray? outputArr]) {
    final p = outputArr?.ptr ?? calloc<cvg.Mat>();
    cvRun(
      () => ccontrib.radialVarianceHashCompute(
        inputArr.ref,
        p,
        sigma,
        numOfAngleLine,
      ),
    );
    return outputArr ?? Mat.fromPointer(p);
  }

  @override
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async => cvRunAsync<double>(
        (callback) => ccontrib.radialVarianceHashCompare_Async(
          hashOne.ref,
          hashTwo.ref,
          sigma,
          numOfAngleLine,
          callback,
        ),
        doubleCompleter,
      );

  @override
  Future<Mat> computeAsync(InputArray inputArr) async => cvRunAsync<Mat>(
        (callback) => ccontrib.radialVarianceHashCompute_Async(
          inputArr.ref,
          sigma,
          numOfAngleLine,
          callback,
        ),
        matCompleter,
      );
}
