// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/constants.g.dart';
import '../g/core.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'mat.dart';
import 'mat_type.dart';
import 'point.dart';
import 'rng.dart';
import 'scalar.dart';
import 'termcriteria.dart';
import 'vec.dart';

/// AbsDiff calculates the per-element absolute difference between two arrays
/// or between an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6fef31bc8c4071cbc114a758a2b79c14
Future<Mat> absDiffAsync(Mat src1, Mat src2, {Mat? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_absdiff(src1.ref, src2.ref, dst!.ref, callback),
    (c) => c.complete(dst),
  );
}

/// Add calculates the per-element sum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga10ac1bfb180e2cfda1701d06c24fdbd6
Future<Mat> addAsync(Mat src1, Mat src2, {Mat? dst, int dtype = -1, Mat? mask}) {
  dst ??= Mat.empty();
  mask ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_add(src1.ref, src2.ref, dst!.ref, mask!.ref, dtype, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// AddWeighted calculates the weighted sum of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gafafb2513349db3bcff51f54ee5592a19
Future<Mat> addWeightedAsync(
  InputArray src1,
  double alpha,
  InputArray src2,
  double beta,
  double gamma, {
  OutputArray? dst,
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_addWeighted(src1.ref, alpha, src2.ref, beta, gamma, dst!.ref, dtype, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// BitwiseAnd computes bitwise conjunction of the two arrays (dst = src1 & src2).
/// Calculates the per-element bit-wise conjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga60b4d04b251ba5eb1392c34425497e14
Future<Mat> bitwiseANDAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
}) {
  dst ??= Mat.empty();
  return mask == null
      ? cvRunAsync0(
          (callback) => ccore.cv_bitwise_and(src1.ref, src2.ref, dst!.ref, callback),
          (c) {
            return c.complete(dst);
          },
        )
      : cvRunAsync0(
          (callback) => ccore.cv_bitwise_and_1(src1.ref, src2.ref, dst!.ref, mask.ref, callback),
          (c) {
            return c.complete(dst);
          },
        );
}

/// BitwiseNot inverts every bit of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0002cf8b418479f4cb49a75442baee2f
Future<Mat> bitwiseNOTAsync(InputArray src, {OutputArray? dst, InputArray? mask}) {
  dst ??= Mat.empty();
  return mask == null
      ? cvRunAsync0(
          (callback) => ccore.cv_bitwise_not(src.ref, dst!.ref, callback),
          (c) {
            return c.complete(dst);
          },
        )
      : cvRunAsync0(
          (callback) => ccore.cv_bitwise_not_1(src.ref, dst!.ref, mask.ref, callback),
          (c) {
            return c.complete(dst);
          },
        );
}

/// BitwiseOr calculates the per-element bit-wise disjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gab85523db362a4e26ff0c703793a719b4
Future<Mat> bitwiseORAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
}) {
  dst ??= Mat.empty();
  return mask == null
      ? cvRunAsync0(
          (callback) => ccore.cv_bitwise_or(src1.ref, src2.ref, dst!.ref, callback),
          (c) {
            return c.complete(dst);
          },
        )
      : cvRunAsync0(
          (callback) => ccore.cv_bitwise_or_1(src1.ref, src2.ref, dst!.ref, mask.ref, callback),
          (c) {
            return c.complete(dst);
          },
        );
}

/// BitwiseXor calculates the per-element bit-wise "exclusive or" operation
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga84b2d8188ce506593dcc3f8cd00e8e2c
Future<Mat> bitwiseXORAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
}) {
  dst ??= Mat.empty();
  return mask == null
      ? cvRunAsync0(
          (callback) => ccore.cv_bitwise_xor(src1.ref, src2.ref, dst!.ref, callback),
          (c) {
            return c.complete(dst);
          },
        )
      : cvRunAsync0(
          (callback) => ccore.cv_bitwise_xor_1(src1.ref, src2.ref, dst!.ref, mask.ref, callback),
          (c) {
            return c.complete(dst);
          },
        );
}

/// BatchDistance is a naive nearest neighbor finder.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ba778a1c57f83233b1d851c83f5a622
Future<(Mat dist, Mat nidx)> batchDistanceAsync(
  InputArray src1,
  InputArray src2,
  int dtype, {
  OutputArray? dist,
  OutputArray? nidx,
  int normType = NORM_L2,
  int K = 0,
  InputArray? mask,
  int update = 0,
  bool crosscheck = false,
}) {
  dist ??= Mat.empty();
  nidx ??= Mat.empty();
  mask ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_batchDistance(
      src1.ref,
      src2.ref,
      dist!.ref,
      dtype,
      nidx!.ref,
      normType,
      K,
      mask!.ref,
      update,
      crosscheck,
      callback,
    ),
    (c) {
      return c.complete((dist!, nidx!));
    },
  );
}

/// BorderInterpolate computes the source location of an extrapolated pixel.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga247f571aa6244827d3d798f13892da58
Future<int> borderInterpolateAsync(int p, int len, int borderType) {
  final ptr = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccore.cv_borderInterpolate(p, len, borderType, ptr, callback),
    (c) {
      final v = ptr.value;
      calloc.free(ptr);
      return c.complete(v);
    },
  );
}

/// CalcCovarMatrix calculates the covariance matrix of a set of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga017122d912af19d7d0d2cccc2d63819f
Future<(Mat covar, Mat mean)> calcCovarMatrixAsync(
  InputArray samples,
  InputOutputArray mean,
  int flags, {
  OutputArray? covar,
  int ctype = MatType.CV_64F,
}) {
  covar ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_calcCovarMatrix(
      samples.ref,
      covar!.ref,
      mean.ref,
      flags,
      ctype,
      callback,
    ),
    (c) {
      return c.complete((covar!, mean));
    },
  );
}

/// CartToPolar calculates the magnitude and angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac5f92f48ec32cacf5275969c33ee837d
Future<(Mat magnitude, Mat angle)> cartToPolarAsync(
  InputArray x,
  InputArray y, {
  OutputArray? magnitude,
  OutputArray? angle,
  bool angleInDegrees = false,
}) {
  magnitude ??= Mat.empty();
  angle ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_cartToPolar(x.ref, y.ref, magnitude!.ref, angle!.ref, angleInDegrees, callback),
    (c) {
      return c.complete((magnitude!, angle!));
    },
  );
}

/// CheckRange checks every element of an input array for invalid values.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga2bd19d89cae59361416736f87e3c7a64
Future<(bool, Point)> checkRangeAsync(
  InputArray a, {
  bool quiet = true,
  double minVal = -CV_F64_MAX,
  double maxVal = CV_F64_MAX,
}) {
  final pos = calloc<cvg.CvPoint>();
  final pRval = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccore.cv_checkRange(a.ref, quiet, pos, minVal, maxVal, pRval, callback),
    (c) {
      final rval = pRval.value;
      calloc.free(pRval);
      return c.complete((rval, Point.fromPointer(pos)));
    },
  );
}

/// Compare performs the per-element comparison of two arrays
/// or an array and scalar value.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga303cfb72acf8cbb36d884650c09a3a97
Future<Mat> compareAsync(InputArray src1, InputArray src2, int cmpop, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_compare(src1.ref, src2.ref, dst!.ref, cmpop, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// CompleteSymm copies the lower or the upper half of a square matrix to its another half.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga6847337c0c55769e115a70e0f011b5ca
Future<Mat> completeSymmAsync(InputOutputArray m, {bool lowerToUpper = false}) {
  return cvRunAsync0(
    (callback) => ccore.cv_completeSymm(m.ref, lowerToUpper, callback),
    (c) {
      return c.complete(m);
    },
  );
}

/// ConvertScaleAbs scales, calculates absolute values, and converts the result to 8-bit.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3460e9c9f37b563ab9dd550c4d8c4e7d
Future<Mat> convertScaleAbsAsync(
  InputArray src, {
  OutputArray? dst,
  double alpha = 1,
  double beta = 0,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_convertScaleAbs(src.ref, dst!.ref, alpha, beta, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// CopyMakeBorder forms a border around an image (applies padding).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga2ac1049c2c3dd25c2b41bffe17658a36
Future<Mat> copyMakeBorderAsync(
  InputArray src,
  int top,
  int bottom,
  int left,
  int right,
  int borderType, {
  OutputArray? dst,
  Scalar? value,
}) {
  dst ??= Mat.empty();
  value ??= Scalar();
  return cvRunAsync0(
    (callback) => ccore.cv_copyMakeBorder(
      src.ref,
      dst!.ref,
      top,
      bottom,
      left,
      right,
      borderType,
      value!.ref,
      callback,
    ),
    (c) {
      return c.complete(dst);
    },
  );
}

/// DCT performs a forward or inverse discrete Cosine transform of 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga85aad4d668c01fbd64825f589e3696d4
Future<Mat> dctAsync(InputArray src, {OutputArray? dst, int flags = 0}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_dct(src.ref, dst!.ref, flags, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Determinant returns the determinant of a square floating-point matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf802bd9ca3e07b8b6170645ef0611d0c
Future<double> determinantAsync(InputArray mtx) {
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => ccore.cv_determinant(mtx.ref, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// DFT performs a forward or inverse Discrete Fourier Transform (DFT)
/// of a 1D or 2D floating-point array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadd6cf9baf2b8b704a11b5f04aaf4f39d
Future<Mat> dftAsync(InputArray src, {OutputArray? dst, int flags = 0, int nonzeroRows = 0}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_dft(src.ref, dst!.ref, flags, nonzeroRows, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Divide performs the per-element division
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6db555d30115642fedae0cda05604874
Future<Mat> divideAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  double scale = 1,
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_divide(src1.ref, src2.ref, dst!.ref, scale, dtype, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Eigen calculates eigenvalues and eigenvectors of a symmetric matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9fa0d58657f60eaa6c71f6fbb40456e3
Future<(bool ret, Mat eigenvalues, Mat eigenvectors)> eigenAsync(
  InputArray src, {
  OutputArray? eigenvalues,
  OutputArray? eigenvectors,
}) {
  eigenvalues ??= Mat.empty();
  eigenvectors ??= Mat.empty();
  final p = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccore.cv_eigen(src.ref, eigenvalues!.ref, eigenvectors!.ref, p, callback),
    (c) {
      final ret = p.value;
      calloc.free(p);
      return c.complete((ret, eigenvalues!, eigenvectors!));
    },
  );
}

/// EigenNonSymmetric calculates eigenvalues and eigenvectors of a non-symmetric matrix (real eigenvalues only).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf51987e03cac8d171fbd2b327cf966f6
Future<(Mat eigenvalues, Mat eigenvectors)> eigenNonSymmetricAsync(
  InputArray src, {
  OutputArray? eigenvalues,
  OutputArray? eigenvectors,
}) {
  eigenvalues ??= Mat.empty();
  eigenvectors ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_eigenNonSymmetric(src.ref, eigenvalues!.ref, eigenvectors!.ref, callback),
    (c) {
      return c.complete((eigenvalues!, eigenvectors!));
    },
  );
}

Future<Mat> PCABackProjectAsync(
  InputArray data,
  InputArray mean,
  InputArray eigenvectors, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_PCABackProject(data.ref, mean.ref, eigenvectors.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst!);
    },
  );
}

/// PCACompute performs PCA.
///
/// The computed eigenvalues are sorted from the largest to the smallest and the corresponding
/// eigenvectors are stored as eigenvectors rows.
///
/// Note: Calling with maxComponents == 0 (opencv default) will cause all components to be retained.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga27a565b31d820b05dcbcd47112176b6e
Future<(Mat mean, Mat eigenvalues, Mat eigenvectors)> PCAComputeAsync(
  InputArray data,
  InputOutputArray mean, {
  OutputArray? eigenvectors,
  OutputArray? eigenvalues,
  int maxComponents = 0,
}) {
  eigenvalues ??= Mat.empty();
  eigenvectors ??= Mat.empty();
  return cvRunAsync0(
      (callback) => ccore.cv_PCACompute(
            data.ref,
            mean.ref,
            eigenvectors!.ref,
            eigenvalues!.ref,
            maxComponents,
            callback,
          ), (c) {
    return c.complete((mean, eigenvalues!, eigenvectors!));
  });
}

Future<(Mat mean, Mat eigenvalues, Mat eigenvectors)> PCACompute1Async(
  InputArray data,
  InputOutputArray mean,
  double retainedVariance, {
  OutputArray? eigenvectors,
  OutputArray? eigenvalues,
}) {
  eigenvectors ??= Mat.empty();
  eigenvalues ??= Mat.empty();
  return cvRunAsync0(
      (callback) => ccore.cv_PCACompute_1(
            data.ref,
            mean.ref,
            eigenvectors!.ref,
            eigenvalues!.ref,
            retainedVariance,
            callback,
          ), (c) {
    return c.complete((mean, eigenvalues!, eigenvectors!));
  });
}

Future<(Mat mean, Mat result)> PCAProjectAsync(Mat data, Mat mean, Mat eigenvectors, {OutputArray? result}) {
  result ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_PCAProject(data.ref, mean.ref, eigenvectors.ref, result!.ref, callback),
    (c) {
      return c.complete((mean, result!));
    },
  );
}

/// Exp calculates the exponent of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3e10108e2162c338f1b848af619f39e5
Future<Mat> expAsync(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_exp(src.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// ExtractChannel extracts a single channel from src (coi is 0-based index).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc6158574aa1f0281878c955bcf35642
Future<Mat> extractChannelAsync(InputArray src, int coi, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_extractChannel(src.ref, dst!.ref, coi, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// FindNonZero returns the list of locations of non-zero pixels.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaed7df59a3539b4cc0fe5c9c8d7586190
Future<Mat> findNonZeroAsync(InputArray src, {OutputArray? idx}) {
  idx ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_findNonZero(src.ref, idx!.ref, callback),
    (c) {
      return c.complete(idx);
    },
  );
}

/// Flip flips a 2D array around horizontal(0), vertical(1), or both axes(-1).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaca7be533e3dac7feb70fc60635adf441
Future<Mat> flipAsync(InputArray src, int flipCode, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_flip(src.ref, dst!.ref, flipCode, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

Future<Mat> flipND(InputArray src, int axis, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_flipND(src.ref, dst!.ref, axis, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Gemm performs generalized matrix multiplication.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacb6e64071dffe36434e1e7ee79e7cb35
Future<Mat> gemmAsync(
  InputArray src1,
  InputArray src2,
  double alpha,
  InputArray src3,
  double beta, {
  OutputArray? dst,
  int flags = 0,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_gemm(src1.ref, src2.ref, alpha, src3.ref, beta, dst!.ref, flags, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// GetOptimalDFTSize returns the optimal Discrete Fourier Transform (DFT) size
/// for a given vector size.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6577a2e59968936ae02eb2edde5de299
Future<int> getOptimalDFTSizeAsync(int vecsize) {
  final p = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccore.cv_getOptimalDFTSize(vecsize, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// Hconcat applies horizontal concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaab5ceee39e0580f879df645a872c6bf7
Future<Mat> hconcatAsync(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_hconcat(src1.ref, src2.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Vconcat applies vertical concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gaad07cede730cdde64b90e987aad179b8
Future<Mat> vconcatAsync(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_vconcat(src1.ref, src2.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Rotate rotates a 2D array in multiples of 90 degrees
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ad01c0978b0ce64baa246811deeac24
Future<Mat> rotateAsync(InputArray src, int rotateCode, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_rotate(src.ref, dst!.ref, rotateCode, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// IDCT calculates the inverse Discrete Cosine Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga77b168d84e564c50228b69730a227ef2
Future<Mat> idctAsync(
  InputArray src, {
  OutputArray? dst,
  int flags = 0,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_idct(src.ref, dst!.ref, flags, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// IDFT calculates the inverse Discrete Fourier Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa708aa2d2e57a508f968eb0f69aa5ff1
Future<Mat> idftAsync(
  InputArray src, {
  OutputArray? dst,
  int flags = 0,
  int nonzeroRows = 0,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_idft(src.ref, dst!.ref, flags, nonzeroRows, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// InRange checks if array elements lie between the elements of two Mat arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Future<Mat> inRangeAsync(
  InputArray src,
  InputArray lowerb,
  InputArray upperb, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_inRange(src.ref, lowerb.ref, upperb.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// InRangeWithScalar checks if array elements lie between the elements of two Scalars
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Future<Mat> inRangebyScalarAsync(
  InputArray src,
  Scalar lowerb,
  Scalar upperb, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_inRange_1(src.ref, lowerb.ref, upperb.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// InsertChannel inserts a single channel to dst (coi is 0-based index)
/// (it replaces channel i with another in dst).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1d4bd886d35b00ec0b764cb4ce6eb515
Future<Mat> insertChannelAsync(InputArray src, InputOutputArray dst, int coi) {
  return cvRunAsync0(
    (callback) => ccore.cv_insertChannel(src.ref, dst.ref, coi, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Invert finds the inverse or pseudo-inverse of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad278044679d4ecf20f7622cc151aaaa2
Future<(double rval, Mat dst)> invertAsync(
  InputArray src, {
  OutputArray? dst,
  int flags = DECOMP_LU,
}) {
  dst ??= Mat.empty();
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => ccore.cv_invert(src.ref, dst!.ref, flags, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, dst!));
    },
  );
}

/// KMeans finds centers of clusters and groups input samples around the clusters.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d5/d38/group__core__cluster.html#ga9a34dc06c6ec9460e90860f15bcd2f88
Future<(double rval, Mat bestLabels, Mat centers)> kmeansAsync(
  InputArray data,
  int K,
  InputOutputArray bestLabels,
  (int, int, double) criteria,
  int attempts,
  int flags, {
  OutputArray? centers,
}) {
  centers ??= Mat.empty();
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => ccore.cv_kmeans(
      data.ref,
      K,
      bestLabels.ref,
      TermCriteria.fromRecord(criteria).ref,
      attempts,
      flags,
      centers!.ref,
      p,
      callback,
    ),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, bestLabels, centers!));
    },
  );
}

/// KMeansPoints finds centers of clusters and groups input samples around the clusters.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d5/d38/group__core__cluster.html#ga9a34dc06c6ec9460e90860f15bcd2f88
Future<(double rval, Mat bestLabels, Mat centers)> kmeansByPointsAsync(
  VecPoint2f pts,
  int K,
  InputOutputArray bestLabels,
  (int, int, double) criteria,
  int attempts,
  int flags, {
  OutputArray? centers,
}) {
  centers ??= Mat.empty();
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => ccore.cv_kmeans_points(
      pts.ref,
      K,
      bestLabels.ref,
      TermCriteria.fromRecord(criteria).ref,
      attempts,
      flags,
      centers!.ref,
      p,
      callback,
    ),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, bestLabels, centers!));
    },
  );
}

/// Log calculates the natural logarithm of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga937ecdce4679a77168730830a955bea7
Future<Mat> logAsync(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_log(src.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Performs a look-up table transform of an array. Support CV_8U, CV_8S, CV_16U, CV_16S
///
/// The function LUT fills the output array with values from the look-up table. Indices of the entries
/// are taken from the input array. That is, the function processes each element of src as follows:
///
/// $\texttt{dst} (I)  \leftarrow \texttt{lut(src(I) + d)}$
///
/// where
///
/// $d =  \fork{0}{if \(\texttt{src}\) has depth \(\texttt{CV_8U}\)}{128}{if \(\texttt{src}\) has depth \(\texttt{CV_8S}\)}$
///
/// [src] input array of 8-bit elements.
/// [lut] look-up table of 256 elements; in case of multi-channel input array, the table should
/// either have a single channel (in this case the same table is used for all channels) or the same
/// number of channels as in the input array.
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gab55b8d062b7f5587720ede032d34156f
Future<Mat> LUTAsync(InputArray src, InputArray lut, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_LUT(src.ref, lut.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Magnitude calculates the magnitude of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6d3b097586bca4409873d64a90fe64c3
Future<Mat> magnitudeAsync(InputArray x, InputArray y, {OutputArray? magnitude}) {
  magnitude ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_magnitude(x.ref, y.ref, magnitude!.ref, callback),
    (c) {
      return c.complete(magnitude);
    },
  );
}

/// Max calculates per-element maximum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc40fa15eac0fb83f8ca70b7cc0b588d
Future<Mat> maxAsync(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_max(src1.ref, src2.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// MeanStdDev calculates a mean and standard deviation of array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga846c858f4004d59493d7c6a4354b301d
Future<(Scalar mean, Scalar stddev)> meanStdDevAsync(InputArray src, {InputArray? mask}) {
  final mean = calloc<cvg.Scalar>();
  final stddev = calloc<cvg.Scalar>();
  return mask == null
      ? cvRunAsync0(
          (callback) => ccore.cv_meanStdDev(src.ref, mean, stddev, callback),
          (c) {
            return c.complete((Scalar.fromPointer(mean), Scalar.fromPointer(stddev)));
          },
        )
      : cvRunAsync0(
          (callback) => ccore.cv_meanStdDev_1(src.ref, mean, stddev, mask.ref, callback),
          (c) {
            return c.complete((Scalar.fromPointer(mean), Scalar.fromPointer(stddev)));
          },
        );
}

/// Merge creates one multi-channel array out of several single-channel ones.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7d7b4d6c6ee504b30a20b1680029c7b4
Future<Mat> mergeAsync(VecMat mv, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_merge(mv.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Min calculates per-element minimum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9af368f182ee76d0463d0d8d5330b764
Future<Mat> minAsync(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_min(src1.ref, src2.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// MinMaxIdx finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7622c466c628a75d9ed008b42250a73f
Future<(double minVal, double maxVal, int minIdx, int maxIdx)> minMaxIdxAsync(
  InputArray src, {
  InputArray? mask,
}) {
  mask ??= Mat.empty();
  final minValP = calloc<ffi.Double>();
  final maxValP = calloc<ffi.Double>();
  final minIdxP = calloc<ffi.Int>();
  final maxIdxP = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccore.cv_minMaxIdx(src.ref, minValP, maxValP, minIdxP, maxIdxP, mask!.ref, callback),
    (c) {
      final rval = (minValP.value, maxValP.value, minIdxP.value, maxIdxP.value);
      calloc.free(minValP);
      calloc.free(maxValP);
      calloc.free(minIdxP);
      calloc.free(maxIdxP);
      return c.complete(rval);
    },
  );
}

/// MinMaxLoc finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/trunk/d2/de8/group__core__array.html#gab473bf2eb6d14ff97e89b355dac20707
Future<(double minVal, double maxVal, Point minLoc, Point maxLoc)> minMaxLocAsync(
  InputArray src, {
  InputArray? mask,
}) {
  mask ??= Mat.empty();
  final minValP = calloc<ffi.Double>();
  final maxValP = calloc<ffi.Double>();
  final minLocP = calloc<cvg.CvPoint>();
  final maxLocP = calloc<cvg.CvPoint>();
  return cvRunAsync0(
    (callback) => ccore.cv_minMaxLoc(src.ref, minValP, maxValP, minLocP, maxLocP, mask!.ref, callback),
    (c) {
      final rval = (minValP.value, maxValP.value, Point.fromPointer(minLocP), Point.fromPointer(maxLocP));
      calloc.free(minValP);
      calloc.free(maxValP);
      return c.complete(rval);
    },
  );
}

/// Copies specified channels from input arrays to the specified channels of output arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga51d768c270a1cdd3497255017c4504be
Future<VecMat> mixChannelsAsync(VecMat src, VecMat dst, VecI32 fromTo) {
  return cvRunAsync0(
    (callback) => ccore.cv_mixChannels(src.ref, dst.ref, fromTo.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Mulspectrums performs the per-element multiplication of two Fourier spectrums.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3ab38646463c59bf0ce962a9d51db64f
Future<Mat> mulSpectrumsAsync(
  InputArray a,
  InputArray b,
  int flags, {
  OutputArray? c,
  bool conjB = false,
}) {
  c ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_mulSpectrums(a.ref, b.ref, c!.ref, flags, conjB, callback),
    (completer) {
      return completer.complete(c);
    },
  );
}

/// Multiply calculates the per-element scaled product of two arrays.
/// Both input arrays must be of the same size and the same type.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga979d898a58d7f61c53003e162e7ad89f
Future<Mat> multiplyAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  double scale = 1,
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_multiply(src1.ref, src2.ref, dst!.ref, scale, dtype, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Normalize normalizes the norm or value range of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga87eef7ee3970f86906d69a92cbf064bd
Future<Mat> normalizeAsync(
  InputArray src,
  InputOutputArray dst, {
  double alpha = 1,
  double beta = 0,
  int normType = NORM_L2,
  int dtype = -1,
  InputArray? mask,
}) {
  mask ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_normalize(src.ref, dst.ref, alpha, beta, normType, dtype, mask!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Norm calculates the absolute norm of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
Future<double> normAsync(
  InputArray src1, {
  int normType = NORM_L2,
  InputArray? mask,
}) {
  mask ??= Mat.empty();
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => ccore.cv_norm(src1.ref, normType, mask!.ref, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// Norm calculates the absolute difference/relative norm of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
Future<double> norm1Async(
  InputArray src1,
  InputArray src2, {
  int normType = NORM_L2,
  InputArray? mask,
}) {
  final p = calloc<ffi.Double>();
  mask ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_norm_1(src1.ref, src2.ref, normType, mask!.ref, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
}

/// PerspectiveTransform performs the perspective matrix transformation of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad327659ac03e5fd6894b90025e6900a7
Future<Mat> perspectiveTransformAsync(InputArray src, InputArray m, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_perspectiveTransform(src.ref, dst!.ref, m.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Solve solves one or more linear systems or least-squares problems.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga12b43690dbd31fed96f213eefead2373
Future<(bool ret, Mat dst)> solveAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  int flags = DECOMP_LU,
}) {
  dst ??= Mat.empty();
  final p = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccore.cv_solve(src1.ref, src2.ref, dst!.ref, flags, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, dst!));
    },
  );
}

/// SolveCubic finds the real roots of a cubic equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1c3b0b925b085b6e96931ee309e6a1da
Future<(int rval, Mat roots)> solveCubicAsync(InputArray coeffs, {OutputArray? roots}) {
  roots ??= Mat.empty();
  final p = calloc<ffi.Int>();
  return cvRunAsync0(
    (callback) => ccore.cv_solveCubic(coeffs.ref, roots!.ref, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, roots!));
    },
  );
}

/// SolvePoly finds the real or complex roots of a polynomial equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac2f5e953016fabcdf793d762f4ec5dce
Future<(double rval, Mat roots)> solvePolyAsync(
  InputArray coeffs, {
  OutputArray? roots,
  int maxIters = 300,
}) {
  roots ??= Mat.empty();
  final p = calloc<ffi.Double>();
  return cvRunAsync0(
    (callback) => ccore.cv_solvePoly(coeffs.ref, roots!.ref, maxIters, p, callback),
    (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, roots!));
    },
  );
}

/// Reduce reduces a matrix to a vector.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4b78072a303f29d9031d56e5638da78e
Future<Mat> reduceAsync(InputArray src, int dim, int rtype, {OutputArray? dst, int dtype = -1}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_reduce(src.ref, dst!.ref, dim, rtype, dtype, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Finds indices of max elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa87ea34d99bcc5bf9695048355163da0
Future<Mat> reduceArgMaxAsync(InputArray src, int axis, {OutputArray? dst, bool lastIndex = false}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_reduceArgMax(src.ref, dst!.ref, axis, lastIndex, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Finds indices of min elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeecd548276bfb91b938989e66b722088
Future<Mat> reduceArgMinAsync(InputArray src, int axis, {OutputArray? dst, bool lastIndex = false}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_reduceArgMin(src.ref, dst!.ref, axis, lastIndex, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Repeat fills the output array with repeated copies of the input array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga496c3860f3ac44c40b48811333cfda2d
Future<Mat> repeatAsync(InputArray src, int ny, int nx, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_repeat(src.ref, ny, nx, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Calculates the sum of a scaled array and another array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9e0845db4135f55dcf20227402f00d98
Future<Mat> scaleAddAsync(InputArray src1, double alpha, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_scaleAdd(src1.ref, alpha, src2.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// SetIdentity initializes a scaled identity matrix.
/// For further details, please see:
///
///	https://docs.opencv.org/master/d2/de8/group__core__array.html#ga388d7575224a4a277ceb98ccaa327c99
Future<Mat> setIdentityAsync(InputOutputArray mtx, {double s = 1}) {
  return cvRunAsync0(
    (callback) => ccore.cv_setIdentity(mtx.ref, s, callback),
    (c) {
      return c.complete(mtx);
    },
  );
}

/// Sort sorts each row or each column of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga45dd56da289494ce874be2324856898f
Future<Mat> sortAsync(InputArray src, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_sort(src.ref, dst!.ref, flags, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// SortIdx sorts each row or each column of a matrix.
/// Instead of reordering the elements themselves, it stores the indices of sorted elements in the output array
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadf35157cbf97f3cb85a545380e383506
Future<Mat> sortIdxAsync(InputArray src, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_sortIdx(src.ref, dst!.ref, flags, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Split creates an array of single channel images from a multi-channel image
/// Created images should be closed manualy to avoid memory leaks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0547c7fed86152d7e9d0096029c8518a
Future<VecMat> splitAsync(InputArray m) {
  final vec = calloc<cvg.VecMat>();
  return cvRunAsync0(
    (callback) => ccore.cv_split(m.ref, vec, callback),
    (c) {
      return c.complete(VecMat.fromPointer(vec));
    },
  );
}

/// Calculates a square root of array elements.
///
/// The function cv::sqrt calculates a square root of each input array element.
/// In case of multi-channel arrays, each channel is processed independently.
/// The accuracy is approximately the same as of the built-in std::sqrt .
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga186222c3919657890f88df5a1f64a7d7
Future<Mat> sqrtAsync(Mat src, {Mat? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_sqrt(src.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Subtract calculates the per-element subtraction of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa0f00d98b4b5edeaeb7b8333b2de353b
Future<Mat> subtractAsync(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  mask ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_subtract(src1.ref, src2.ref, dst!.ref, mask!.ref, dtype, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Calculates the sum of array elements.
///
/// The function cv::sum calculates and returns the sum of array elements,
/// independently for each channel.
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga716e10a2dd9e228e4d3c95818f106722
Future<Scalar> sumAsync(Mat src) {
  final p = calloc<cvg.Scalar>();
  return cvRunAsync0(
    (callback) => ccore.cv_sum(src.ref, p, callback),
    (c) {
      return c.complete(Scalar.fromPointer(p));
    },
  );
}

/// Trace returns the trace of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3419ac19c7dcd2be4bd552a23e147dd8
Future<Scalar> traceAsync(InputArray mtx) {
  final ptr = calloc<cvg.Scalar>();
  return cvRunAsync0(
    (callback) => ccore.cv_trace(mtx.ref, ptr, callback),
    (c) {
      return c.complete(Scalar.fromPointer(ptr));
    },
  );
}

/// Transform performs the matrix transformation of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga393164aa54bb9169ce0a8cc44e08ff22
Future<Mat> transformAsync(InputArray src, InputArray m, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_transform(src.ref, dst!.ref, m.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Transpose transposes a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
Future<Mat> transposeAsync(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_transpose(src.ref, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Transpose for n-dimensional matrices.
///
/// Input should be continuous single-channel matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
Future<Mat> transposeNDAsync(InputArray src, List<int> order, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_transposeND(src.ref, dst!.ref, order.i32.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// Pow raises every array element to a power.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf0d056b5bd1dc92500d6f6cf6bac41ef
Future<Mat> powAsync(InputArray src, double power, {OutputArray? dst}) {
  dst ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_pow(src.ref, power, dst!.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// PolatToCart calculates x and y coordinates of 2D vectors from their magnitude and angle.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga581ff9d44201de2dd1b40a50db93d665
Future<(Mat x, Mat y)> polarToCartAsync(
  InputArray magnitude,
  InputArray angle, {
  OutputArray? x,
  OutputArray? y,
  bool angleInDegrees = false,
}) {
  x ??= Mat.empty();
  y ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_polarToCart(magnitude.ref, angle.ref, x!.ref, y!.ref, angleInDegrees, callback),
    (c) {
      return c.complete((x!, y!));
    },
  );
}

/// Phase calculates the rotation angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9db9ca9b4d81c3bde5677b8f64dc0137
Future<Mat> phaseAsync(InputArray x, InputArray y, {OutputArray? angle, bool angleInDegrees = false}) {
  angle ??= Mat.empty();
  return cvRunAsync0(
    (callback) => ccore.cv_phase(x.ref, y.ref, angle!.ref, angleInDegrees, callback),
    (c) {
      return c.complete(angle);
    },
  );
}

/// RandN Fills the array with normally distributed random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeff1f61e972d133a04ce3a5f81cf6808
Future<Mat> randnAsync(InputOutputArray dst, Scalar mean, Scalar stddev) {
  return cvRunAsync0(
    (callback) => ccore.cv_randn(dst.ref, mean.ref, stddev.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}

/// RandShuffle Shuffles the array elements randomly.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6a789c8a5cb56c6dd62506179808f763
Future<Mat> randShuffleAsync(
  InputOutputArray dst, {
  double iterFactor = 1,
  Rng? rng,
}) {
  if (rng == null) {
    return cvRunAsync0(
      (callback) => ccore.cv_randShuffle(dst.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  } else {
    return cvRunAsync0(
      (callback) => ccore.cv_randShuffle_1(dst.ref, iterFactor, rng.ref, callback),
      (c) {
        return c.complete(dst);
      },
    );
  }
}

/// RandU Generates a single uniformly-distributed random
/// number or an array of random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1ba1026dca0807b27057ba6a49d258c0
Future<Mat> randuAsync(InputOutputArray dst, Scalar low, Scalar high) {
  return cvRunAsync0(
    (callback) => ccore.cv_randu(dst.ref, low.ref, high.ref, callback),
    (c) {
      return c.complete(dst);
    },
  );
}
