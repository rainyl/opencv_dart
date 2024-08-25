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
Future<Mat> absDiffAsync(Mat src1, Mat src2) async => cvRunAsync(
      (callback) => ccore.core_AbsDiff_Async(src1.ref, src2.ref, callback),
      matCompleter,
    );

/// Add calculates the per-element sum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga10ac1bfb180e2cfda1701d06c24fdbd6
Future<Mat> addAsync(Mat src1, Mat src2, {Mat? mask, int dtype = -1}) async => cvRunAsync(
      (callback) => ccore.core_Add_Async(src1.ref, src2.ref, mask?.ref ?? Mat.empty().ref, dtype, callback),
      matCompleter,
    );

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
  int dtype = -1,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_AddWeighted_Async(src1.ref, alpha, src2.ref, beta, gamma, dtype, callback),
      matCompleter,
    );

/// BitwiseAnd computes bitwise conjunction of the two arrays (dst = src1 & src2).
/// Calculates the per-element bit-wise conjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga60b4d04b251ba5eb1392c34425497e14
Future<Mat> bitwiseANDAsync(
  InputArray src1,
  InputArray src2, {
  InputArray? mask,
}) async =>
    cvRunAsync(
      (callback) => mask == null
          ? ccore.core_BitwiseAnd_Async(src1.ref, src2.ref, callback)
          : ccore.core_BitwiseAndWithMask_Async(src1.ref, src2.ref, mask.ref, callback),
      matCompleter,
    );

/// BitwiseNot inverts every bit of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0002cf8b418479f4cb49a75442baee2f
Future<Mat> bitwiseNOTAsync(InputArray src, {InputArray? mask}) async => cvRunAsync(
      (callback) => mask == null
          ? ccore.core_BitwiseNot_Async(src.ref, callback)
          : ccore.core_BitwiseNotWithMask_Async(src.ref, mask.ref, callback),
      matCompleter,
    );

/// BitwiseOr calculates the per-element bit-wise disjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gab85523db362a4e26ff0c703793a719b4
Future<Mat> bitwiseORAsync(InputArray src1, InputArray src2, {InputArray? mask}) async => cvRunAsync(
      (callback) => mask == null
          ? ccore.core_BitwiseOr_Async(src1.ref, src2.ref, callback)
          : ccore.core_BitwiseOrWithMask_Async(src1.ref, src2.ref, mask.ref, callback),
      matCompleter,
    );

/// BitwiseXor calculates the per-element bit-wise "exclusive or" operation
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga84b2d8188ce506593dcc3f8cd00e8e2c
Future<Mat> bitwiseXORAsync(InputArray src1, InputArray src2, {InputArray? mask}) async => cvRunAsync(
      (callback) => mask == null
          ? ccore.core_BitwiseXor_Async(src1.ref, src2.ref, callback)
          : ccore.core_BitwiseXorWithMask_Async(src1.ref, src2.ref, mask.ref, callback),
      matCompleter,
    );

/// BatchDistance is a naive nearest neighbor finder.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ba778a1c57f83233b1d851c83f5a622
Future<(Mat dist, Mat nidx)> batchDistanceAsync(
  InputArray src1,
  InputArray src2,
  int dtype, {
  int normType = NORM_L2,
  int K = 0,
  InputArray? mask,
  int update = 0,
  bool crosscheck = false,
}) async =>
    cvRunAsync2<(Mat, Mat)>(
      (callback) => ccore.core_BatchDistance_Async(
        src1.ref,
        src2.ref,
        dtype,
        normType,
        K,
        mask?.ref ?? Mat.empty().ref,
        update,
        crosscheck,
        callback,
      ),
      matCompleter2,
    );

/// BorderInterpolate computes the source location of an extrapolated pixel.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga247f571aa6244827d3d798f13892da58
Future<int> borderInterpolateAsync(int p, int len, int borderType) async => cvRunAsync(
      (callback) => ccore.core_BorderInterpolate_Async(p, len, borderType, callback),
      intCompleter,
    );

/// CalcCovarMatrix calculates the covariance matrix of a set of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga017122d912af19d7d0d2cccc2d63819f
Future<(Mat covar, Mat mean)> calcCovarMatrixAsync(
  InputArray samples,
  InputOutputArray mean,
  int flags, {
  int ctype = MatType.CV_64F,
}) async =>
    cvRunAsync<(Mat, Mat)>(
      (callback) => ccore.core_CalcCovarMatrix_Async(
        samples.ref,
        mean.ref,
        flags,
        ctype,
        callback,
      ),
      (c, p) => c.complete((Mat.fromPointer(p.cast<cvg.Mat>()), mean)),
    );

/// CartToPolar calculates the magnitude and angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac5f92f48ec32cacf5275969c33ee837d
Future<(Mat magnitude, Mat angle)> cartToPolarAsync(
  InputArray x,
  InputArray y, {
  bool angleInDegrees = false,
}) async =>
    cvRunAsync2<(Mat, Mat)>(
      (callback) => ccore.core_CartToPolar_Async(
        x.ref,
        y.ref,
        angleInDegrees,
        callback,
      ),
      matCompleter2,
    );

/// CheckRange checks every element of an input array for invalid values.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga2bd19d89cae59361416736f87e3c7a64
Future<(bool, Point)> checkRangeAsync(
  InputArray a, {
  bool quiet = true,
  double minVal = -CV_F64_MAX,
  double maxVal = CV_F64_MAX,
}) async =>
    cvRunAsync2((callback) => ccore.core_CheckRange_Async(a.ref, quiet, minVal, maxVal, callback),
        (completer, p, p1) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      completer.complete((rval, Point.fromPointer(p1.cast<cvg.Point>())));
    });

/// Compare performs the per-element comparison of two arrays
/// or an array and scalar value.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga303cfb72acf8cbb36d884650c09a3a97
Future<Mat> compareAsync(InputArray src1, InputArray src2, int cmpop) async =>
    cvRunAsync((callback) => ccore.core_Compare_Async(src1.ref, src2.ref, cmpop, callback), matCompleter);

/// CountNonZero counts non-zero array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa4b89393263bb4d604e0fe5986723914
Future<int> countNonZeroAsync(Mat src) async =>
    cvRunAsync((callback) => ccore.core_CountNonZero_Async(src.ref, callback), intCompleter);

/// CompleteSymm copies the lower or the upper half of a square matrix to its another half.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga6847337c0c55769e115a70e0f011b5ca
Future<Mat> completeSymmAsync(InputOutputArray m, {bool lowerToUpper = false}) async => cvRunAsync0(
      (callback) => ccore.core_CompleteSymm_Async(m.ref, lowerToUpper, callback),
      (c) => c.complete(m),
    );

/// ConvertScaleAbs scales, calculates absolute values, and converts the result to 8-bit.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3460e9c9f37b563ab9dd550c4d8c4e7d
Future<Mat> convertScaleAbsAsync(
  InputArray src, {
  double alpha = 1,
  double beta = 0,
}) async =>
    cvRunAsync((callback) => ccore.core_ConvertScaleAbs_Async(src.ref, alpha, beta, callback), matCompleter);

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
  Scalar? value,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_CopyMakeBorder_Async(
        src.ref,
        top,
        bottom,
        left,
        right,
        borderType,
        value?.ref ?? Scalar().ref,
        callback,
      ),
      matCompleter,
    );

/// DCT performs a forward or inverse discrete Cosine transform of 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga85aad4d668c01fbd64825f589e3696d4
Future<Mat> dctAsync(InputArray src, {int flags = 0}) async =>
    cvRunAsync((callback) => ccore.core_DCT_Async(src.ref, flags, callback), matCompleter);

/// Determinant returns the determinant of a square floating-point matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf802bd9ca3e07b8b6170645ef0611d0c
Future<double> determinantAsync(InputArray mtx) async =>
    cvRunAsync((callback) => ccore.core_Determinant_Async(mtx.ref, callback), doubleCompleter);

/// DFT performs a forward or inverse Discrete Fourier Transform (DFT)
/// of a 1D or 2D floating-point array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadd6cf9baf2b8b704a11b5f04aaf4f39d
Future<Mat> dftAsync(
  InputArray src, {
  int flags = 0,
  int nonzeroRows = 0,
}) async =>
    cvRunAsync((callback) => ccore.core_DFT_Async(src.ref, flags, nonzeroRows, callback), matCompleter);

/// Divide performs the per-element division
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6db555d30115642fedae0cda05604874
Future<Mat> divideAsync(
  InputArray src1,
  InputArray src2, {
  double scale = 1,
  int dtype = -1,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_Divide_Async(src1.ref, src2.ref, scale, dtype, callback),
      matCompleter,
    );

/// Eigen calculates eigenvalues and eigenvectors of a symmetric matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9fa0d58657f60eaa6c71f6fbb40456e3
Future<(bool ret, Mat eigenvalues, Mat eigenvectors)> eigenAsync(InputArray src) async =>
    cvRunAsync3((callback) => ccore.core_Eigen_Async(src.ref, callback), (completer, p, p1, p2) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      completer.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>()), Mat.fromPointer(p2.cast<cvg.Mat>())));
    });

/// EigenNonSymmetric calculates eigenvalues and eigenvectors of a non-symmetric matrix (real eigenvalues only).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf51987e03cac8d171fbd2b327cf966f6
Future<(Mat eigenvalues, Mat eigenvectors)> eigenNonSymmetricAsync(InputArray src) async => cvRunAsync2(
      (callback) => ccore.core_EigenNonSymmetric_Async(src.ref, callback),
      matCompleter2,
    );

Future<(Mat mean, Mat result)> PCABackProjectAsync(Mat src, Mat mean, Mat eigenVectors) async => cvRunAsync(
      (callback) => ccore.core_PCABackProject_Async(src.ref, mean.ref, eigenVectors.ref, callback),
      (completer, p) => completer.complete((mean, Mat.fromPointer(p.cast<cvg.Mat>()))),
    );

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
  int maxComponents = 0,
}) async =>
    cvRunAsync2((callback) => ccore.core_PCACompute_Async(data.ref, mean.ref, maxComponents, callback),
        (completer, p, p1) {
      completer.complete(
        (
          mean,
          Mat.fromPointer(p.cast<cvg.Mat>()),
          Mat.fromPointer(p1.cast<cvg.Mat>()),
        ),
      );
    });

Future<(Mat mean, Mat eigenvectors)> PCACompute1Async(
  InputArray data,
  InputOutputArray mean, {
  int maxComponents = 0,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_PCACompute_1_Async(data.ref, mean.ref, maxComponents, callback),
      (completer, p) => completer.complete((mean, Mat.fromPointer(p.cast<cvg.Mat>()))),
    );

Future<(Mat mean, Mat eigenvectors)> PCACompute2Async(
  InputArray data,
  InputOutputArray mean, {
  double retainedVariance = 0,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_PCACompute_3_Async(data.ref, mean.ref, retainedVariance, callback),
      (completer, p) => completer.complete((mean, Mat.fromPointer(p.cast<cvg.Mat>()))),
    );

Future<(Mat mean, Mat eigenvalues, Mat eigenvectors)> PCACompute3Async(
  InputArray data,
  InputOutputArray mean, {
  double retainedVariance = 0,
}) async =>
    cvRunAsync2(
      (callback) => ccore.core_PCACompute_2_Async(data.ref, mean.ref, retainedVariance, callback),
      (completer, p, p1) =>
          completer.complete((mean, Mat.fromPointer(p.cast<cvg.Mat>()), Mat.fromPointer(p1.cast<cvg.Mat>()))),
    );

Future<(Mat mean, Mat result)> PCAProjectAsync(InputArray src, InputArray mean, InputArray eigenVectors) =>
    cvRunAsync((callback) => ccore.core_PCAProject_Async(src.ref, mean.ref, eigenVectors.ref, callback),
        (completer, p) {
      completer.complete((mean, Mat.fromPointer(p.cast<cvg.Mat>())));
    });

/// Exp calculates the exponent of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3e10108e2162c338f1b848af619f39e5
Future<Mat> expAsync(InputArray src) async =>
    cvRunAsync((callback) => ccore.core_Exp_Async(src.ref, callback), matCompleter);

/// ExtractChannel extracts a single channel from src (coi is 0-based index).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc6158574aa1f0281878c955bcf35642
Future<Mat> extractChannelAsync(InputArray src, int coi) async =>
    cvRunAsync((callback) => ccore.core_ExtractChannel_Async(src.ref, coi, callback), matCompleter);

/// FindNonZero returns the list of locations of non-zero pixels.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaed7df59a3539b4cc0fe5c9c8d7586190
Future<Mat> findNonZeroAsync(InputArray src) async =>
    cvRunAsync((callback) => ccore.core_FindNonZero_Async(src.ref, callback), matCompleter);

/// Flip flips a 2D array around horizontal(0), vertical(1), or both axes(-1).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaca7be533e3dac7feb70fc60635adf441
Future<Mat> flipAsync(InputArray src, int flipCode) async =>
    cvRunAsync((callback) => ccore.core_Flip_Async(src.ref, flipCode, callback), matCompleter);

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
  int flags = 0,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_Gemm_Async(src1.ref, src2.ref, alpha, src3.ref, beta, flags, callback),
      matCompleter,
    );

/// GetOptimalDFTSize returns the optimal Discrete Fourier Transform (DFT) size
/// for a given vector size.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6577a2e59968936ae02eb2edde5de299
Future<int> getOptimalDFTSizeAsync(int vecsize) async =>
    cvRunAsync((callback) => ccore.core_GetOptimalDFTSize_Async(vecsize, callback), intCompleter);

/// Hconcat applies horizontal concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaab5ceee39e0580f879df645a872c6bf7
Future<Mat> hconcatAsync(InputArray src1, InputArray src2) async =>
    cvRunAsync((callback) => ccore.core_Hconcat_Async(src1.ref, src2.ref, callback), matCompleter);

/// Vconcat applies vertical concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gaad07cede730cdde64b90e987aad179b8
Future<Mat> vconcatAsync(InputArray src1, InputArray src2) async =>
    cvRunAsync((callback) => ccore.core_Vconcat_Async(src1.ref, src2.ref, callback), matCompleter);

/// Rotate rotates a 2D array in multiples of 90 degrees
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ad01c0978b0ce64baa246811deeac24
Future<Mat> rotateAsync(InputArray src, int rotateCode) async =>
    cvRunAsync((callback) => ccore.core_Rotate_Async(src.ref, rotateCode, callback), matCompleter);

/// IDCT calculates the inverse Discrete Cosine Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga77b168d84e564c50228b69730a227ef2
Future<Mat> idctAsync(
  InputArray src, {
  int flags = 0,
}) async =>
    cvRunAsync((callback) => ccore.core_Idct_Async(src.ref, flags, callback), matCompleter);

/// IDFT calculates the inverse Discrete Fourier Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa708aa2d2e57a508f968eb0f69aa5ff1
Future<Mat> idftAsync(
  InputArray src, {
  int flags = 0,
  int nonzeroRows = 0,
}) async =>
    cvRunAsync((callback) => ccore.core_Idft_Async(src.ref, flags, nonzeroRows, callback), matCompleter);

/// InRange checks if array elements lie between the elements of two Mat arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Future<Mat> inRangeAsync(
  InputArray src,
  InputArray lowerb,
  InputArray upperb,
) async =>
    cvRunAsync(
      (callback) => ccore.core_InRange_Async(src.ref, lowerb.ref, upperb.ref, callback),
      matCompleter,
    );

/// InRangeWithScalar checks if array elements lie between the elements of two Scalars
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Future<Mat> inRangebyScalarAsync(
  InputArray src,
  Scalar lowerb,
  Scalar upperb,
) async =>
    cvRunAsync(
      (callback) => ccore.core_InRangeWithScalar_Async(src.ref, lowerb.ref, upperb.ref, callback),
      matCompleter,
    );

/// InsertChannel inserts a single channel to dst (coi is 0-based index)
/// (it replaces channel i with another in dst).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1d4bd886d35b00ec0b764cb4ce6eb515
Future<Mat> insertChannelAsync(InputArray src, InputOutputArray dst, int coi) async => cvRunAsync0(
      (callback) => ccore.core_InsertChannel_Async(src.ref, dst.ref, coi, callback),
      (c) => c.complete(dst),
    );

/// Invert finds the inverse or pseudo-inverse of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad278044679d4ecf20f7622cc151aaaa2
Future<(double rval, Mat dst)> invertAsync(
  InputArray src, {
  int flags = DECOMP_LU,
}) async =>
    cvRunAsync2<(double, Mat)>((callback) => ccore.core_Invert_Async(src.ref, flags, callback), (c, p, p1) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      c.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

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
  int flags,
) async =>
    cvRunAsync2(
        (callback) =>
            ccore.core_KMeans_Async(data.ref, K, bestLabels.ref, criteria.cvd.ref, attempts, flags, callback),
        (completer, p, p1) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      completer.complete((rval, bestLabels, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

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
  int flags,
) async =>
    cvRunAsync2(
        (callback) => ccore.core_KMeans_Points_Async(
              pts.ref,
              K,
              bestLabels.ref,
              criteria.cvd.ref,
              attempts,
              flags,
              callback,
            ), (completer, p, p1) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      completer.complete((rval, bestLabels, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

/// Log calculates the natural logarithm of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga937ecdce4679a77168730830a955bea7
Future<Mat> logAsync(InputArray src) async =>
    cvRunAsync((callback) => ccore.core_Log_Async(src.ref, callback), matCompleter);

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
Future<Mat> LUTAsync(InputArray src, InputArray lut) async =>
    cvRunAsync((callback) => ccore.core_LUT_Async(src.ref, lut.ref, callback), matCompleter);

/// Magnitude calculates the magnitude of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6d3b097586bca4409873d64a90fe64c3
Future<Mat> magnitudeAsync(InputArray x, InputArray y) async =>
    cvRunAsync((callback) => ccore.core_Magnitude_Async(x.ref, y.ref, callback), matCompleter);

/// Max calculates per-element maximum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc40fa15eac0fb83f8ca70b7cc0b588d
Future<Mat> maxAsync(InputArray src1, InputArray src2) async =>
    cvRunAsync((callback) => ccore.core_Max_Async(src1.ref, src2.ref, callback), matCompleter);

/// MeanStdDev calculates a mean and standard deviation of array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga846c858f4004d59493d7c6a4354b301d
Future<(Scalar mean, Scalar stddev)> meanStdDevAsync(InputArray src, {InputArray? mask}) async => cvRunAsync2(
      (callback) => mask == null
          ? ccore.core_MeanStdDev_Async(src.ref, callback)
          : ccore.core_MeanStdDevWithMask_Async(src.ref, mask.ref, callback),
      (c, p, p1) =>
          c.complete((Scalar.fromPointer(p.cast<cvg.Scalar>()), Scalar.fromPointer(p1.cast<cvg.Scalar>()))),
    );

/// Merge creates one multi-channel array out of several single-channel ones.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7d7b4d6c6ee504b30a20b1680029c7b4
Future<Mat> mergeAsync(VecMat mv) async =>
    cvRunAsync((callback) => ccore.core_Merge_Async(mv.ref, callback), matCompleter);

/// Min calculates per-element minimum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9af368f182ee76d0463d0d8d5330b764
Future<Mat> minAsync(InputArray src1, InputArray src2) async =>
    cvRunAsync((callback) => ccore.core_Min_Async(src1.ref, src2.ref, callback), matCompleter);

/// MinMaxIdx finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7622c466c628a75d9ed008b42250a73f
Future<(double minVal, double maxVal, int minIdx, int maxIdx)> minMaxIdxAsync(
  InputArray src, {
  InputArray? mask,
}) async =>
    cvRunAsync4(
        (callback) => mask == null
            ? ccore.core_MinMaxIdx_Async(src.ref, callback)
            : ccore.core_MinMaxIdx_Mask_Async(src.ref, mask.ref, callback), (c, p, p1, p2, p3) {
      final minv = p.cast<ffi.Double>().value;
      calloc.free(p);
      final maxv = p1.cast<ffi.Double>().value;
      calloc.free(p1);
      final mini = p2.cast<ffi.Int>().value;
      calloc.free(p2);
      final maxi = p3.cast<ffi.Int>().value;
      calloc.free(p3);
      c.complete((minv, maxv, mini, maxi));
    });

/// MinMaxLoc finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/trunk/d2/de8/group__core__array.html#gab473bf2eb6d14ff97e89b355dac20707
Future<(double minVal, double maxVal, Point minLoc, Point maxLoc)> minMaxLocAsync(
  InputArray src, {
  InputArray? mask,
}) async =>
    cvRunAsync4(
        (callback) => mask == null
            ? ccore.core_MinMaxLoc_Async(src.ref, callback)
            : ccore.core_MinMaxLoc_Mask_Async(src.ref, mask.ref, callback), (c, p, p1, p2, p3) {
      final minv = p.cast<ffi.Double>().value;
      calloc.free(p);
      final maxv = p1.cast<ffi.Double>().value;
      calloc.free(p1);
      c.complete((minv, maxv, Point.fromPointer(p2.cast()), Point.fromPointer(p3.cast())));
    });

/// Copies specified channels from input arrays to the specified channels of output arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga51d768c270a1cdd3497255017c4504be
Future<VecMat> mixChannelsAsync(VecMat src, VecMat dst, VecI32 fromTo) async => cvRunAsync0(
      (callback) => ccore.core_MixChannels_Async(src.ref, dst.ref, fromTo.ref, callback),
      (c) => c.complete(dst),
    );

/// Mulspectrums performs the per-element multiplication of two Fourier spectrums.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3ab38646463c59bf0ce962a9d51db64f
Future<Mat> mulSpectrumsAsync(
  InputArray a,
  InputArray b,
  int flags, {
  bool conjB = false,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_MulSpectrums_Async(a.ref, b.ref, flags, conjB, callback),
      matCompleter,
    );

/// Multiply calculates the per-element scaled product of two arrays.
/// Both input arrays must be of the same size and the same type.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga979d898a58d7f61c53003e162e7ad89f
Future<Mat> multiplyAsync(
  InputArray src1,
  InputArray src2, {
  double scale = 1,
  int dtype = -1,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_MultiplyWithParams_Async(src1.ref, src2.ref, scale, dtype, callback),
      matCompleter,
    );

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
}) async =>
    cvRunAsync0(
      (callback) => mask == null
          ? ccore.core_Normalize_Async(src.ref, dst.ref, alpha, beta, normType, dtype, callback)
          : ccore.core_Normalize_Mask_Async(
              src.ref,
              dst.ref,
              alpha,
              beta,
              normType,
              dtype,
              mask.ref,
              callback,
            ),
      (c) => c.complete(dst),
    );

/// Norm calculates the absolute norm of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
Future<double> normAsync(
  InputArray src1, {
  int normType = NORM_L2,
  InputArray? mask,
}) async =>
    cvRunAsync(
      (callback) => mask == null
          ? ccore.core_Norm_Async(src1.ref, normType, callback)
          : ccore.core_Norm_Mask_Async(src1.ref, normType, mask.ref, callback),
      doubleCompleter,
    );

/// Norm calculates the absolute difference/relative norm of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
Future<double> norm1Async(
  InputArray src1,
  InputArray src2, {
  int normType = NORM_L2,
  // InputArray? mask,
}) async =>
    cvRunAsync(
      (callback) => ccore.core_NormWithMats_Async(src1.ref, src2.ref, normType, callback),
      doubleCompleter,
    );

/// PerspectiveTransform performs the perspective matrix transformation of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad327659ac03e5fd6894b90025e6900a7
Future<Mat> perspectiveTransformAsync(InputArray src, InputArray m) async =>
    cvRunAsync((callback) => ccore.core_PerspectiveTransform_Async(src.ref, m.ref, callback), matCompleter);

/// Solve solves one or more linear systems or least-squares problems.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga12b43690dbd31fed96f213eefead2373
Future<(bool ret, Mat dst)> solveAsync(
  InputArray src1,
  InputArray src2, {
  int flags = DECOMP_LU,
}) async =>
    cvRunAsync2((callback) => ccore.core_Solve_Async(src1.ref, src2.ref, flags, callback), (c, p, p1) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      c.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

/// SolveCubic finds the real roots of a cubic equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1c3b0b925b085b6e96931ee309e6a1da
Future<(int rval, Mat roots)> solveCubicAsync(InputArray coeffs) async =>
    cvRunAsync2((callback) => ccore.core_SolveCubic_Async(coeffs.ref, callback), (c, p, p1) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      c.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

/// SolvePoly finds the real or complex roots of a polynomial equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac2f5e953016fabcdf793d762f4ec5dce
Future<(double rval, Mat roots)> solvePolyAsync(
  InputArray coeffs, {
  int maxIters = 300,
}) async =>
    cvRunAsync2((callback) => ccore.core_SolvePoly_Async(coeffs.ref, maxIters, callback), (c, p, p1) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      c.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
    });

/// Reduce reduces a matrix to a vector.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4b78072a303f29d9031d56e5638da78e
Future<Mat> reduceAsync(InputArray src, int dim, int rtype, {int dtype = -1}) async =>
    cvRunAsync((callback) => ccore.core_Reduce_Async(src.ref, dim, rtype, dtype, callback), matCompleter);

/// Finds indices of max elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa87ea34d99bcc5bf9695048355163da0
Future<Mat> reduceArgMaxAsync(InputArray src, int axis, {bool lastIndex = false}) async =>
    cvRunAsync((callback) => ccore.core_ReduceArgMax_Async(src.ref, axis, lastIndex, callback), matCompleter);

/// Finds indices of min elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeecd548276bfb91b938989e66b722088
Future<Mat> reduceArgMinAsync(InputArray src, int axis, {bool lastIndex = false}) async =>
    cvRunAsync((callback) => ccore.core_ReduceArgMin_Async(src.ref, axis, lastIndex, callback), matCompleter);

/// Repeat fills the output array with repeated copies of the input array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga496c3860f3ac44c40b48811333cfda2d
Future<Mat> repeatAsync(InputArray src, int ny, int nx) async =>
    cvRunAsync((callback) => ccore.core_Repeat_Async(src.ref, ny, nx, callback), matCompleter);

/// Calculates the sum of a scaled array and another array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9e0845db4135f55dcf20227402f00d98
Future<Mat> scaleAddAsync(InputArray src1, double alpha, InputArray src2) async =>
    cvRunAsync((callback) => ccore.core_ScaleAdd_Async(src1.ref, alpha, src2.ref, callback), matCompleter);

/// SetIdentity initializes a scaled identity matrix.
/// For further details, please see:
///
///	https://docs.opencv.org/master/d2/de8/group__core__array.html#ga388d7575224a4a277ceb98ccaa327c99
Future<Mat> setIdentityAsync(InputOutputArray mtx, {Scalar? s}) async => cvRunAsync0(
      (callback) => ccore.core_SetIdentity_Async(mtx.ref, s?.ref ?? Scalar.all(1).ref, callback),
      (c) => c.complete(mtx),
    );

/// Sort sorts each row or each column of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga45dd56da289494ce874be2324856898f
Future<Mat> sortAsync(InputArray src, int flags) async =>
    cvRunAsync((callback) => ccore.core_Sort_Async(src.ref, flags, callback), matCompleter);

/// SortIdx sorts each row or each column of a matrix.
/// Instead of reordering the elements themselves, it stores the indices of sorted elements in the output array
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadf35157cbf97f3cb85a545380e383506
Future<Mat> sortIdxAsync(InputArray src, int flags) async =>
    cvRunAsync((callback) => ccore.core_SortIdx_Async(src.ref, flags, callback), matCompleter);

/// Split creates an array of single channel images from a multi-channel image
/// Created images should be closed manualy to avoid memory leaks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0547c7fed86152d7e9d0096029c8518a
Future<VecMat> splitAsync(InputArray m) async => cvRunAsync(
      (callback) => ccore.core_Split_Async(m.ref, callback),
      (c, p) => VecMat.fromPointer(p.cast<cvg.VecMat>()),
    );

/// Subtract calculates the per-element subtraction of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa0f00d98b4b5edeaeb7b8333b2de353b
Future<Mat> subtractAsync(
  InputArray src1,
  InputArray src2, {
  InputArray? mask,
  int dtype = -1,
}) async =>
    cvRunAsync(
      (callback) =>
          ccore.core_Subtract_Async(src1.ref, src2.ref, mask?.ref ?? Mat.empty().ref, dtype, callback),
      matCompleter,
    );

/// Trace returns the trace of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3419ac19c7dcd2be4bd552a23e147dd8
Future<Scalar> traceAsync(InputArray mtx) async =>
    cvRunAsync((callback) => ccore.core_Trace_Async(mtx.ref, callback), scalarCompleter);

/// Transform performs the matrix transformation of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga393164aa54bb9169ce0a8cc44e08ff22
Future<Mat> transformAsync(InputArray src, InputArray m) async =>
    cvRunAsync((callback) => ccore.core_Transform_Async(src.ref, m.ref, callback), matCompleter);

/// Transpose transposes a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
Future<Mat> transposeAsync(InputArray src) async =>
    cvRunAsync((callback) => ccore.core_Transpose_Async(src.ref, callback), matCompleter);

/// Pow raises every array element to a power.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf0d056b5bd1dc92500d6f6cf6bac41ef
Future<Mat> powAsync(InputArray src, double power) async =>
    cvRunAsync((callback) => ccore.core_Pow_Async(src.ref, power, callback), matCompleter);

/// PolatToCart calculates x and y coordinates of 2D vectors from their magnitude and angle.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga581ff9d44201de2dd1b40a50db93d665
Future<(Mat x, Mat y)> polarToCartAsync(
  InputArray magnitude,
  InputArray angle, {
  bool angleInDegrees = false,
}) async =>
    cvRunAsync2(
      (callback) => ccore.core_PolarToCart_Async(magnitude.ref, angle.ref, angleInDegrees, callback),
      matCompleter2,
    );

/// Phase calculates the rotation angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9db9ca9b4d81c3bde5677b8f64dc0137
Future<Mat> phaseAsync(InputArray x, InputArray y, {bool angleInDegrees = false}) async =>
    cvRunAsync((callback) => ccore.core_Phase_Async(x.ref, y.ref, angleInDegrees, callback), matCompleter);

/// RandN Fills the array with normally distributed random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeff1f61e972d133a04ce3a5f81cf6808
Future<Mat> randnAsync(InputOutputArray dst, Scalar mean, Scalar stddev) async => cvRunAsync0(
      (callback) => ccore.RandN_Async(dst.ref, mean.ref, stddev.ref, callback),
      (c) => c.complete(dst),
    );

/// RandShuffle Shuffles the array elements randomly.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6a789c8a5cb56c6dd62506179808f763
Future<Mat> randShuffleAsync(
  InputOutputArray dst, {
  double iterFactor = 1,
  Rng? rng,
}) async =>
    cvRunAsync0(
      (callback) => rng == null
          ? ccore.RandShuffle_Async(dst.ref, callback)
          : ccore.RandShuffleWithParams_Async(dst.ref, iterFactor, rng.ref, callback),
      (c) => c.complete(dst),
    );

/// RandU Generates a single uniformly-distributed random
/// number or an array of random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1ba1026dca0807b27057ba6a49d258c0
Future<Mat> randuAsync(InputOutputArray dst, Scalar low, Scalar high) async => cvRunAsync0(
      (callback) => ccore.RandU_Async(dst.ref, low.ref, high.ref, callback),
      (c) => c.complete(dst),
    );
