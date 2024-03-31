// ignore_for_file: constant_identifier_names

library cv;

import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());


abstract class ImgHashBase {
  double compare (InputArray hashOne, InputArray hashTwo);
  void compute (InputArray inputArr, OutputArray outputArr);
}

/// PHash is implementation of the PHash algorithm.
class PHash implements ImgHashBase {

  /// Compare compares the hash value between a and b using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return _bindings.pHashCompare(hashOne.ptr, hashTwo.ptr);
  }

  /// Compute computes hash of the input image using PHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    return _bindings.pHashCompute(inputArr.ptr, outputArr.ptr);
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
    return _bindings.averageHashCompare(hashOne.ptr, hashTwo.ptr);
  }

  /// Compute computes hash of the input image using AverageHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    return _bindings.averageHashCompute(inputArr.ptr, outputArr.ptr);
  }
}


enum BlockMeanHashMode
{
    BLOCK_MEAN_HASH_MODE_0, //!< use fewer block and generate 16*16/8 uchar hash value
    BLOCK_MEAN_HASH_MODE_1 , //!< use block blocks(step sizes/2), generate 31*31/8 + 1 uchar hash value
}


/// BlockMeanHash is implementation of the BlockMeanHash algorithm.
class BlockMeanHash implements ImgHashBase {

  BlockMeanHashMode mode = BlockMeanHashMode.BLOCK_MEAN_HASH_MODE_0;

  BlockMeanHash({this.mode = BlockMeanHashMode.BLOCK_MEAN_HASH_MODE_0});

  /// Compare compares the hash value between a and b using BlockMeanHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return _bindings.blockMeanHashCompare(hashOne.ptr, hashTwo.ptr, mode.index);
  }

  /// Compute computes hash of the input image using BlockMeanHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    return _bindings.blockMeanHashCompute(inputArr.ptr, outputArr.ptr, mode.index);
  }

// TODO: BlockMeanHash.GetMean isn't implemented, because it requires state from the last
// call to Compute, and there's no easy way to keep it.

}


/// ColorMomentHash is implementation of the ColorMomentHash algorithm.
class ColorMomentHash implements ImgHashBase {

  /// Compare compares the hash value between a and b using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#a444a3e9ec792cf029385809393f84ad5
  @override
  double compare(InputArray hashOne, InputArray hashTwo) {
    return _bindings.colorMomentHashCompare(hashOne.ptr, hashTwo.ptr);
  }

  /// Compute computes hash of the input image using ColorMomentHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    return _bindings.colorMomentHashCompute(inputArr.ptr, outputArr.ptr);
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
    return _bindings.marrHildrethHashCompare(hashOne.ptr, hashTwo.ptr, alpha, scale);
  }

  /// Compute computes hash of the input image using MarrHildrethHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    return _bindings.marrHildrethHashCompute(inputArr.ptr, outputArr.ptr, alpha, scale);
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
    return _bindings.radialVarianceHashCompare(hashOne.ptr, hashTwo.ptr, sigma, numOfAngleLine);
  }

  /// Compute computes hash of the input image using RadialVarianceHash.
  //
  /// For further information, see:
  /// https://docs.opencv.org/master/de/d29/classcv_1_1img__hash_1_1ImgHashBase.html#ae2d9288db370089dfd8aab85d5e0b0f3
  @override
  void compute(InputArray inputArr, OutputArray outputArr) {
    return _bindings.radialVarianceHashCompute(inputArr.ptr, outputArr.ptr, sigma, numOfAngleLine);
  }
}
