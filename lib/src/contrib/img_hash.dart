// ignore_for_file: constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

abstract class ImgHashBase {
  double compare(InputArray hashOne, InputArray hashTwo);
  void compute(InputArray inputArr, OutputArray outputArr);
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
      cvRun(() => _bindings.pHashCompare(hashOne.ptr, hashTwo.ptr, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => _bindings.pHashCompute(inputArr.ptr, outputArr.ptr));
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
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => _bindings.averageHashCompare(hashOne.ptr, hashTwo.ptr, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => _bindings.averageHashCompute(inputArr.ptr, outputArr.ptr));
  }
}

enum BlockMeanHashMode {
  BLOCK_MEAN_HASH_MODE_0, //!< use fewer block and generate 16*16/8 uchar hash value
  BLOCK_MEAN_HASH_MODE_1, //!< use block blocks(step sizes/2), generate 31*31/8 + 1 uchar hash value
}

/// BlockMeanHash is implementation of the BlockMeanHash algorithm.
class BlockMeanHash implements ImgHashBase, ffi.Finalizable {
  BlockMeanHash._(this.ptr, [this._mode = BlockMeanHashMode.BLOCK_MEAN_HASH_MODE_0]) {
    finalizer.attach(this, ptr);
  }
  static final finalizer = Finalizer<ffi.Pointer<cvg.BlockMeanHash>>((p) {
    _bindings.BlockMeanHash_Close(p);
    calloc.free(p);
  });

  factory BlockMeanHash({BlockMeanHashMode mode = BlockMeanHashMode.BLOCK_MEAN_HASH_MODE_0}) {
    final p = calloc<cvg.BlockMeanHash>();
    cvRun(() => _bindings.BlockMeanHash_Create(mode.index, p));
    return BlockMeanHash._(p, mode);
  }

  BlockMeanHashMode _mode;
  BlockMeanHashMode get mode => _mode;
  set mode(BlockMeanHashMode mode) {
    _mode = mode;
    cvRun(() => _bindings.BlockMeanHash_SetMode(ptr.value, mode.index));
  }

  ffi.Pointer<cvg.BlockMeanHash> ptr;

  /// Compare compares the hash value between a and b using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo, [int? mode_]) {
    mode_ ??= mode.index;
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => _bindings.BlockMeanHash_Compare(ptr, hashOne.ptr, hashTwo.ptr, p));
      return p.value;
    });
  }

  /// STATIC Compare compares the hash value between a and b using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  static double compareS(InputArray hashOne, InputArray hashTwo, [int mode = 0]) {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => _bindings.blockMeanHashCompare(hashOne.ptr, hashTwo.ptr, mode, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr, [int? mode_]) {
    mode_ ??= mode.index;
    cvRun(() => _bindings.BlockMeanHash_Compute(ptr, inputArr.ptr, outputArr.ptr));
  }

  /// STATIC Compute computes hash of the input image using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  static void computeS(InputArray inputArr, OutputArray outputArr, [int mode = 0]) {
    cvRun(() => _bindings.blockMeanHashCompute(inputArr.ptr, outputArr.ptr, mode));
  }

  /// https://docs.opencv.org/4.x/df/d55/classcv_1_1img__hash_1_1BlockMeanHash.html#ad5aef85f58315551cac14bcabe05f0c3
  List<double> getMean() {
    return using<List<double>>((arena) {
      final ret = arena<ffi.Pointer<ffi.Double>>();
      final length = arena<ffi.Int>();
      cvRun(() => _bindings.BlockMeanHash_GetMean(ptr.value, ret, length));
      if (length.value == 0) return List<double>.empty();
      return List.generate(length.value, (i) => ret.value[i]);
    });
  }
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
      cvRun(() => _bindings.colorMomentHashCompare(hashOne.ptr, hashTwo.ptr, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => _bindings.colorMomentHashCompute(inputArr.ptr, outputArr.ptr));
  }
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
      cvRun(() => _bindings.marrHildrethHashCompare(hashOne.ptr, hashTwo.ptr, alpha, scale, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => _bindings.marrHildrethHashCompute(inputArr.ptr, outputArr.ptr, alpha, scale));
  }
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
      cvRun(() => _bindings.radialVarianceHashCompare(hashOne.ptr, hashTwo.ptr, sigma, numOfAngleLine, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => _bindings.radialVarianceHashCompute(inputArr.ptr, outputArr.ptr, sigma, numOfAngleLine));
  }
}
