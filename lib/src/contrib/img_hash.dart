// ignore_for_file: constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

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
      cvRun(() => cvg.pHashCompare(hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => cvg.pHashCompute(inputArr.ref, outputArr.ref));
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
      cvRun(() => cvg.averageHashCompare(hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => cvg.averageHashCompute(inputArr.ref, outputArr.ref));
  }
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
  static final finalizer = OcvFinalizer<cvg.BlockMeanHashPtr>(ffi.Native.addressOf(cvg.BlockMeanHash_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.BlockMeanHash_Close(ptr);
  }

  factory BlockMeanHash({int mode = BLOCK_MEAN_HASH_MODE_0}) {
    final p = calloc<cvg.BlockMeanHash>();
    cvRun(() => cvg.BlockMeanHash_Create(mode, p));
    return BlockMeanHash._(p, mode);
  }

  int _mode;
  int get mode => _mode;
  set mode(int mode) {
    _mode = mode;
    cvRun(() => cvg.BlockMeanHash_SetMode(ref, mode));
  }

  /// Compare compares the hash value between a and b using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo, [int? mode_]) {
    mode_ ??= mode;
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.BlockMeanHash_Compare(ref, hashOne.ref, hashTwo.ref, p));
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
      cvRun(() => cvg.blockMeanHashCompare(hashOne.ref, hashTwo.ref, mode, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr, [int? mode_]) {
    mode_ ??= mode;
    cvRun(() => cvg.BlockMeanHash_Compute(ref, inputArr.ref, outputArr.ref));
  }

  /// STATIC Compute computes hash of the input image using BlockMeanHash.
  ///
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  static void computeS(InputArray inputArr, OutputArray outputArr, [int mode = 0]) {
    cvRun(() => cvg.blockMeanHashCompute(inputArr.ref, outputArr.ref, mode));
  }

  /// https://docs.opencv.org/4.x/df/d55/classcv_1_1img__hash_1_1BlockMeanHash.html#ad5aef85f58315551cac14bcabe05f0c3
  List<double> getMean() {
    return using<List<double>>((arena) {
      final ret = arena<ffi.Pointer<ffi.Double>>();
      final length = arena<ffi.Int>();
      cvRun(() => cvg.BlockMeanHash_GetMean(ref, ret, length));
      if (length.value == 0) return List<double>.empty();
      return List.generate(length.value, (i) => ret.value[i]);
    });
  }

  @override
  List<int> get props => [ptr.address];

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
      cvRun(() => cvg.colorMomentHashCompare(hashOne.ref, hashTwo.ref, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => cvg.colorMomentHashCompute(inputArr.ref, outputArr.ref));
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
      cvRun(() => cvg.marrHildrethHashCompare(hashOne.ref, hashTwo.ref, alpha, scale, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => cvg.marrHildrethHashCompute(inputArr.ref, outputArr.ref, alpha, scale));
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
      cvRun(() => cvg.radialVarianceHashCompare(hashOne.ref, hashTwo.ref, sigma, numOfAngleLine, p));
      return p.value;
    });
  }

  /// Compute computes hash of the input image using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    cvRun(() => cvg.radialVarianceHashCompute(inputArr.ref, outputArr.ref, sigma, numOfAngleLine));
  }
}
