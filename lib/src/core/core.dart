// ignore_for_file: non_constant_identifier_names

library cv.core;

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

/// Constants for log levels
const int LOG_LEVEL_SILENT = 0;
const int LOG_LEVEL_FATAL = 1;
const int LOG_LEVEL_ERROR = 2;
const int LOG_LEVEL_WARNING = 3;
const int LOG_LEVEL_INFO = 4;
const int LOG_LEVEL_DEBUG = 5;
const int LOG_LEVEL_VERBOSE = 6;

/// Sets the global logging level.
void setLogLevel(int logLevel) {
  cvRun(() => ccore.setLogLevel(logLevel));
}

/// Gets the global logging level.
int getLogLevel() {
  final p = calloc<ffi.Int>();
  cvRun(() => ccore.getLogLevel(p));
  final level = p.value;
  calloc.free(p);
  return level;
}


/// get version
String openCvVersion() {
  final p = calloc<ffi.Pointer<ffi.Char>>();
  cvRun(() => ccore.openCVVersion(p));
  final s = p.value.toDartString();
  calloc.free(p);
  return s;
}

/// Returns full configuration time cmake output.
///
/// Returned value is raw cmake output including version control system revision, compiler version, compiler flags, enabled modules and third party libraries, etc. Output format depends on target architecture.
String getBuildInformation() {
  final p = calloc<ffi.Pointer<ffi.Char>>();
  cvRun(() => ccore.getBuildInfo(p));
  final s = p.value.toDartString();
  calloc.free(p);
  return s;
}

/// AbsDiff calculates the per-element absolute difference between two arrays
/// or between an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6fef31bc8c4071cbc114a758a2b79c14
Mat absDiff(Mat src1, Mat src2, [Mat? dst]) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_AbsDiff(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// Add calculates the per-element sum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga10ac1bfb180e2cfda1701d06c24fdbd6
Mat add(Mat src1, Mat src2, [Mat? dst]) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Add(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// AddWeighted calculates the weighted sum of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gafafb2513349db3bcff51f54ee5592a19
Mat addWeighted(
  InputArray src1,
  double alpha,
  InputArray src2,
  double beta,
  double gamma, {
  OutputArray? dst,
  int dtype = -1, // TODO: Add this
}) {
  dst ??= Mat.empty();
  cvRun(
    () => ccore.Mat_AddWeighted(
      src1.ref,
      alpha,
      src2.ref,
      beta,
      gamma,
      dst!.ref,
      // dtype,
    ),
  );
  return dst;
}

/// BitwiseAnd computes bitwise conjunction of the two arrays (dst = src1 & src2).
/// Calculates the per-element bit-wise conjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga60b4d04b251ba5eb1392c34425497e14
Mat bitwiseAND(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
}) {
  dst ??= Mat.empty();
  if (mask == null) {
    cvRun(() => ccore.Mat_BitwiseAnd(src1.ref, src2.ref, dst!.ref));
  } else {
    cvRun(() => ccore.Mat_BitwiseAndWithMask(src1.ref, src2.ref, dst!.ref, mask.ref));
  }
  return dst;
}

/// BitwiseNot inverts every bit of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0002cf8b418479f4cb49a75442baee2f
Mat bitwiseNOT(InputArray src, {OutputArray? dst, InputArray? mask}) {
  dst ??= Mat.empty();
  if (mask == null) {
    cvRun(() => ccore.Mat_BitwiseNot(src.ref, dst!.ref));
  } else {
    cvRun(() => ccore.Mat_BitwiseNotWithMask(src.ref, dst!.ref, mask.ref));
  }
  return dst;
}

/// BitwiseOr calculates the per-element bit-wise disjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gab85523db362a4e26ff0c703793a719b4
Mat bitwiseOR(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
}) {
  dst ??= Mat.empty();
  if (mask == null) {
    cvRun(() => ccore.Mat_BitwiseOr(src1.ref, src2.ref, dst!.ref));
  } else {
    cvRun(() => ccore.Mat_BitwiseOrWithMask(src1.ref, src2.ref, dst!.ref, mask.ref));
  }
  return dst;
}

/// BitwiseXor calculates the per-element bit-wise "exclusive or" operation
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga84b2d8188ce506593dcc3f8cd00e8e2c
Mat bitwiseXOR(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  InputArray? mask,
}) {
  dst ??= Mat.empty();
  if (mask == null) {
    cvRun(() => ccore.Mat_BitwiseXor(src1.ref, src2.ref, dst!.ref));
  } else {
    cvRun(() => ccore.Mat_BitwiseXorWithMask(src1.ref, src2.ref, dst!.ref, mask.ref));
  }
  return dst;
}

/// BatchDistance is a naive nearest neighbor finder.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ba778a1c57f83233b1d851c83f5a622
(Mat dist, Mat nidx) batchDistance(
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
  cvRun(
    () => ccore.Mat_BatchDistance(
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
    ),
  );
  return (dist, nidx);
}

/// BorderInterpolate computes the source location of an extrapolated pixel.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga247f571aa6244827d3d798f13892da58
int borderInterpolate(int p, int len, int borderType) {
  final ptr = calloc<ffi.Int>();
  cvRun(() => ccore.Mat_BorderInterpolate(p, len, borderType, ptr));
  final v = ptr.value;
  calloc.free(ptr);
  return v;
}

/// CalcCovarMatrix calculates the covariance matrix of a set of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga017122d912af19d7d0d2cccc2d63819f
(Mat covar, Mat mean) calcCovarMatrix(
  InputArray samples,
  InputOutputArray mean,
  int flags, {
  OutputArray? covar,
  int ctype = MatType.CV_64F,
}) {
  covar ??= Mat.empty();
  cvRun(
    () => ccore.Mat_CalcCovarMatrix(
      samples.ref,
      covar!.ref,
      mean.ref,
      flags,
      ctype,
    ),
  );
  return (covar, mean);
}

/// CartToPolar calculates the magnitude and angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac5f92f48ec32cacf5275969c33ee837d
(Mat magnitude, Mat angle) cartToPolar(
  InputArray x,
  InputArray y, {
  OutputArray? magnitude,
  OutputArray? angle,
  bool angleInDegrees = false,
}) {
  magnitude ??= Mat.empty();
  angle ??= Mat.empty();
  cvRun(
    () => ccore.Mat_CartToPolar(
      x.ref,
      y.ref,
      magnitude!.ref,
      angle!.ref,
      angleInDegrees,
    ),
  );
  return (magnitude, angle);
}

/// CheckRange checks every element of an input array for invalid values.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga2bd19d89cae59361416736f87e3c7a64
(bool, Point) checkRange(
  InputArray a, {
  bool quiet = true,
  double minVal = -CV_F64_MAX,
  double maxVal = CV_F64_MAX,
}) {
  return cvRunArena<(bool, Point)>((arena) {
    final pos = calloc<cvg.Point>();
    final rval = arena<ffi.Bool>();
    cvRun(() => ccore.Mat_CheckRange(a.ref, quiet, pos, minVal, maxVal, rval));
    return (rval.value, Point.fromPointer(pos));
  });
}

/// Compare performs the per-element comparison of two arrays
/// or an array and scalar value.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga303cfb72acf8cbb36d884650c09a3a97
Mat compare(InputArray src1, InputArray src2, int cmpop, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Compare(src1.ref, src2.ref, dst!.ref, cmpop));
  return dst;
}

/// CountNonZero counts non-zero array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa4b89393263bb4d604e0fe5986723914
int countNonZero(Mat src) {
  return cvRunArena<int>((arena) {
    final p = arena<ffi.Int>();
    ccore.Mat_CountNonZero(src.ref, p);
    return p.value;
  });
}

/// CompleteSymm copies the lower or the upper half of a square matrix to its another half.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga6847337c0c55769e115a70e0f011b5ca
Mat completeSymm(InputOutputArray m, {bool lowerToUpper = false}) {
  cvRun(() => ccore.Mat_CompleteSymm(m.ref, lowerToUpper));
  return m;
}

/// ConvertScaleAbs scales, calculates absolute values, and converts the result to 8-bit.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3460e9c9f37b563ab9dd550c4d8c4e7d
Mat convertScaleAbs(
  InputArray src, {
  OutputArray? dst,
  double alpha = 1,
  double beta = 0,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_ConvertScaleAbs(src.ref, dst!.ref, alpha, beta));
  return dst;
}

/// CopyMakeBorder forms a border around an image (applies padding).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga2ac1049c2c3dd25c2b41bffe17658a36
Mat copyMakeBorder(
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
  cvRun(
    () => ccore.Mat_CopyMakeBorder(
      src.ref,
      dst!.ref,
      top,
      bottom,
      left,
      right,
      borderType,
      value!.ref,
    ),
  );
  return dst;
}

/// DCT performs a forward or inverse discrete Cosine transform of 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga85aad4d668c01fbd64825f589e3696d4
Mat dct(InputArray src, {OutputArray? dst, int flags = 0}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_DCT(src.ref, dst!.ref, flags));
  return dst;
}

/// Determinant returns the determinant of a square floating-point matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf802bd9ca3e07b8b6170645ef0611d0c
double determinant(InputArray mtx) {
  return cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => ccore.Mat_Determinant(mtx.ref, p));
    return p.value;
  });
}

/// DFT performs a forward or inverse Discrete Fourier Transform (DFT)
/// of a 1D or 2D floating-point array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadd6cf9baf2b8b704a11b5f04aaf4f39d
Mat dft(
  InputArray src, {
  OutputArray? dst,
  int flags = 0,
  int nonzeroRows = 0, // TODO: add
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_DFT(src.ref, dst!.ref, flags));
  return dst;
}

/// Divide performs the per-element division
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6db555d30115642fedae0cda05604874
Mat divide(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  double scale = 1,
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Divide(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// Eigen calculates eigenvalues and eigenvectors of a symmetric matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9fa0d58657f60eaa6c71f6fbb40456e3
(bool ret, Mat eigenvalues, Mat eigenvectors) eigen(
  InputArray src, {
  OutputArray? eigenvalues,
  OutputArray? eigenvectors,
}) {
  eigenvalues ??= Mat.empty();
  eigenvectors ??= Mat.empty();
  final ret = cvRunArena<bool>((arena) {
    final p = arena<ffi.Bool>();
    cvRun(() => ccore.Mat_Eigen(src.ref, eigenvalues!.ref, eigenvectors!.ref, p));
    return p.value;
  });
  return (ret, eigenvalues, eigenvectors);
}

/// EigenNonSymmetric calculates eigenvalues and eigenvectors of a non-symmetric matrix (real eigenvalues only).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf51987e03cac8d171fbd2b327cf966f6
(Mat eigenvalues, Mat eigenvectors) eigenNonSymmetric(
  InputArray src, {
  OutputArray? eigenvalues,
  OutputArray? eigenvectors,
}) {
  eigenvalues ??= Mat.empty();
  eigenvectors ??= Mat.empty();
  cvRun(() => ccore.Mat_EigenNonSymmetric(src.ref, eigenvalues!.ref, eigenvectors!.ref));
  return (eigenvalues, eigenvectors);
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
(Mat mean, Mat eigenvalues, Mat eigenvectors) PCACompute(
  InputArray data,
  InputOutputArray mean, {
  OutputArray? eigenvectors,
  OutputArray? eigenvalues,
  int maxComponents = 0,
}) {
  eigenvalues ??= Mat.empty();
  eigenvectors ??= Mat.empty();
  ccore.Mat_PCACompute(data.ref, mean.ref, eigenvectors.ref, eigenvalues.ref, maxComponents);
  return (mean, eigenvalues, eigenvectors);
}

/// Exp calculates the exponent of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3e10108e2162c338f1b848af619f39e5
Mat exp(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Exp(src.ref, dst!.ref));
  return dst;
}

/// ExtractChannel extracts a single channel from src (coi is 0-based index).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc6158574aa1f0281878c955bcf35642
Mat extractChannel(InputArray src, int coi, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_ExtractChannel(src.ref, dst!.ref, coi));
  return dst;
}

/// FindNonZero returns the list of locations of non-zero pixels.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaed7df59a3539b4cc0fe5c9c8d7586190
Mat findNonZero(InputArray src, {OutputArray? idx}) {
  idx ??= Mat.empty();
  cvRun(() => ccore.Mat_FindNonZero(src.ref, idx!.ref));
  return idx;
}

/// Flip flips a 2D array around horizontal(0), vertical(1), or both axes(-1).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaca7be533e3dac7feb70fc60635adf441
Mat flip(InputArray src, int flipCode, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Flip(src.ref, dst!.ref, flipCode));
  return dst;
}

/// Gemm performs generalized matrix multiplication.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacb6e64071dffe36434e1e7ee79e7cb35
Mat gemm(
  InputArray src1,
  InputArray src2,
  double alpha,
  InputArray src3,
  double beta, {
  OutputArray? dst,
  int flags = 0,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Gemm(src1.ref, src2.ref, alpha, src3.ref, beta, dst!.ref, flags));
  return dst;
}

/// GetOptimalDFTSize returns the optimal Discrete Fourier Transform (DFT) size
/// for a given vector size.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6577a2e59968936ae02eb2edde5de299
int getOptimalDFTSize(int vecsize) {
  return cvRunArena<int>((arena) {
    final p = arena<ffi.Int>();
    cvRun(() => ccore.Mat_GetOptimalDFTSize(vecsize, p));
    return p.value;
  });
}

/// Hconcat applies horizontal concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaab5ceee39e0580f879df645a872c6bf7
Mat hconcat(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Hconcat(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// Vconcat applies vertical concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gaad07cede730cdde64b90e987aad179b8
Mat vconcat(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Vconcat(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// Rotate rotates a 2D array in multiples of 90 degrees
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ad01c0978b0ce64baa246811deeac24
Mat rotate(InputArray src, int rotateCode, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Rotate(src.ref, dst!.ref, rotateCode));
  return dst;
}

/// IDCT calculates the inverse Discrete Cosine Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga77b168d84e564c50228b69730a227ef2
Mat idct(
  InputArray src, {
  OutputArray? dst,
  int flags = 0,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Idct(src.ref, dst!.ref, flags));
  return dst;
}

/// IDFT calculates the inverse Discrete Fourier Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa708aa2d2e57a508f968eb0f69aa5ff1
Mat idft(
  InputArray src, {
  OutputArray? dst,
  int flags = 0,
  int nonzeroRows = 0,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Idft(src.ref, dst!.ref, flags, nonzeroRows));
  return dst;
}

/// InRange checks if array elements lie between the elements of two Mat arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Mat inRange(
  InputArray src,
  InputArray lowerb,
  InputArray upperb, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_InRange(src.ref, lowerb.ref, upperb.ref, dst!.ref));
  return dst;
}

/// InRangeWithScalar checks if array elements lie between the elements of two Scalars
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Mat inRangebyScalar(
  InputArray src,
  Scalar lowerb,
  Scalar upperb, {
  OutputArray? dst,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_InRangeWithScalar(src.ref, lowerb.ref, upperb.ref, dst!.ref));
  return dst;
}

/// InsertChannel inserts a single channel to dst (coi is 0-based index)
/// (it replaces channel i with another in dst).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1d4bd886d35b00ec0b764cb4ce6eb515
Mat insertChannel(InputArray src, InputOutputArray dst, int coi) {
  cvRun(() => ccore.Mat_InsertChannel(src.ref, dst.ref, coi));
  return dst;
}

/// Invert finds the inverse or pseudo-inverse of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad278044679d4ecf20f7622cc151aaaa2
(double rval, Mat dst) invert(
  InputArray src, {
  OutputArray? dst,
  int flags = DECOMP_LU,
}) {
  dst ??= Mat.empty();
  final rval = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => ccore.Mat_Invert(src.ref, dst!.ref, flags, p));
    return p.value;
  });
  return (rval, dst);
}

/// KMeans finds centers of clusters and groups input samples around the clusters.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d5/d38/group__core__cluster.html#ga9a34dc06c6ec9460e90860f15bcd2f88
(double rval, Mat bestLabels, Mat centers) kmeans(
  InputArray data,
  int K,
  InputOutputArray bestLabels,
  (int, int, double) criteria,
  int attempts,
  int flags, {
  OutputArray? centers,
}) {
  centers ??= Mat.empty();
  final rval = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(
      () => ccore.KMeans(
        data.ref,
        K,
        bestLabels.ref,
        TermCriteria.fromRecord(criteria).ref,
        attempts,
        flags,
        centers!.ref,
        p,
      ),
    );
    return p.value;
  });
  return (rval, bestLabels, centers);
}

/// KMeansPoints finds centers of clusters and groups input samples around the clusters.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d5/d38/group__core__cluster.html#ga9a34dc06c6ec9460e90860f15bcd2f88
(double rval, Mat bestLabels, Mat centers) kmeansByPoints(
  VecPoint2f pts,
  int K,
  InputOutputArray bestLabels,
  (int, int, double) criteria,
  int attempts,
  int flags, {
  OutputArray? centers,
}) {
  centers ??= Mat.empty();
  final rval = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(
      () => ccore.KMeansPoints(
        pts.ref,
        K,
        bestLabels.ref,
        TermCriteria.fromRecord(criteria).ref,
        attempts,
        flags,
        centers!.ref,
        p,
      ),
    );
    return p.value;
  });
  return (rval, bestLabels, centers);
}

/// Log calculates the natural logarithm of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga937ecdce4679a77168730830a955bea7
Mat log(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Log(src.ref, dst!.ref));
  return dst;
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
/// [dst] output array of the same size and number of channels as src, and the same depth as lut.
///
/// see also: [convertScaleAbs]
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gab55b8d062b7f5587720ede032d34156f
Mat LUT(InputArray src, InputArray lut, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.LUT(src.ref, lut.ref, dst!.ref));
  return dst;
}

/// Magnitude calculates the magnitude of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6d3b097586bca4409873d64a90fe64c3
Mat magnitude(InputArray x, InputArray y, {OutputArray? magnitude}) {
  magnitude ??= Mat.empty();
  cvRun(() => ccore.Mat_Magnitude(x.ref, y.ref, magnitude!.ref));
  return magnitude;
}

/// Max calculates per-element maximum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc40fa15eac0fb83f8ca70b7cc0b588d
Mat max(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Max(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// MeanStdDev calculates a mean and standard deviation of array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga846c858f4004d59493d7c6a4354b301d
(Scalar mean, Scalar stddev) meanStdDev(InputArray src, {InputArray? mask}) {
  final mean = calloc<cvg.Scalar>();
  final stddev = calloc<cvg.Scalar>();
  mask == null
      ? cvRun(() => ccore.Mat_MeanStdDev(src.ref, mean, stddev))
      : cvRun(() => ccore.Mat_MeanStdDevWithMask(src.ref, mean, stddev, mask.ref));
  return (Scalar.fromPointer(mean), Scalar.fromPointer(stddev));
}

/// Merge creates one multi-channel array out of several single-channel ones.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7d7b4d6c6ee504b30a20b1680029c7b4
Mat merge(VecMat mv, {OutputArray? dst}) {
  final p = calloc<cvg.Mat>();
  cvRun(() => ccore.Mat_Merge(mv.ref, p));
  return Mat.fromPointer(p);
}

/// Min calculates per-element minimum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9af368f182ee76d0463d0d8d5330b764
Mat min(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Min(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// MinMaxIdx finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7622c466c628a75d9ed008b42250a73f
(double minVal, double maxVal, int minIdx, int maxIdx) minMaxIdx(
  InputArray src, {
  InputArray? mask,
}) {
  return using<(double, double, int, int)>((arena) {
    final minValP = arena<ffi.Double>();
    final maxValP = arena<ffi.Double>();
    final minIdxP = arena<ffi.Int>();
    final maxIdxP = arena<ffi.Int>();
    cvRun(() => ccore.Mat_MinMaxIdx(src.ref, minValP, maxValP, minIdxP, maxIdxP));
    return (minValP.value, maxValP.value, minIdxP.value, maxIdxP.value);
  });
}

/// MinMaxLoc finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/trunk/d2/de8/group__core__array.html#gab473bf2eb6d14ff97e89b355dac20707
(double minVal, double maxVal, Point minLoc, Point maxLoc) minMaxLoc(InputArray src, {InputArray? mask}) {
  return using<(double, double, Point, Point)>((arena) {
    final minValP = arena<ffi.Double>();
    final maxValP = arena<ffi.Double>();
    final minLocP = calloc<cvg.Point>();
    final maxLocP = calloc<cvg.Point>();
    cvRun(() => ccore.Mat_MinMaxLoc(src.ref, minValP, maxValP, minLocP, maxLocP));
    return (minValP.value, maxValP.value, Point.fromPointer(minLocP), Point.fromPointer(maxLocP));
  });
}

/// Copies specified channels from input arrays to the specified channels of output arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga51d768c270a1cdd3497255017c4504be
VecMat mixChannels(VecMat src, VecMat dst, VecI32 fromTo) {
  cvRun(() => ccore.Mat_MixChannels(src.ref, dst.ref, fromTo.ref));
  return dst;
}

/// Mulspectrums performs the per-element multiplication of two Fourier spectrums.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3ab38646463c59bf0ce962a9d51db64f
Mat mulSpectrums(
  InputArray a,
  InputArray b,
  int flags, {
  OutputArray? c,
  bool conjB = false,
}) {
  c ??= Mat.empty();
  cvRun(() => ccore.Mat_MulSpectrums(a.ref, b.ref, c!.ref, flags));
  return c;
}

/// Multiply calculates the per-element scaled product of two arrays.
/// Both input arrays must be of the same size and the same type.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga979d898a58d7f61c53003e162e7ad89f
Mat multiply(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  double scale = 1,
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_MultiplyWithParams(src1.ref, src2.ref, dst!.ref, scale, dtype));
  return dst;
}

/// Normalize normalizes the norm or value range of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga87eef7ee3970f86906d69a92cbf064bd
Mat normalize(
  InputArray src,
  InputOutputArray dst, {
  double alpha = 1,
  double beta = 0,
  int normType = NORM_L2,
  // TODO
  // int dtype = -1,
  // InputArray? mask,
}) {
  cvRun(() => ccore.Mat_Normalize(src.ref, dst.ref, alpha, beta, normType));
  return dst;
}

/// Norm calculates the absolute norm of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
double norm(
  InputArray src1, {
  int normType = NORM_L2,
  InputArray? mask,
}) {
  return cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => ccore.Norm(src1.ref, normType, p));
    return p.value;
  });
}

/// Norm calculates the absolute difference/relative norm of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
double norm1(
  InputArray src1,
  InputArray src2, {
  int normType = NORM_L2,
  // InputArray? mask,
}) {
  return cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => ccore.NormWithMats(src1.ref, src2.ref, normType, p));
    return p.value;
  });
}

/// PerspectiveTransform performs the perspective matrix transformation of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad327659ac03e5fd6894b90025e6900a7
Mat perspectiveTransform(InputArray src, InputArray m, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_PerspectiveTransform(src.ref, dst!.ref, m.ref));
  return dst;
}

/// Solve solves one or more linear systems or least-squares problems.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga12b43690dbd31fed96f213eefead2373
(bool ret, Mat dst) solve(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  int flags = DECOMP_LU,
}) {
  dst ??= Mat.empty();
  final rval = cvRunArena<bool>((arena) {
    final p = arena<ffi.Bool>();
    cvRun(() => ccore.Mat_Solve(src1.ref, src2.ref, dst!.ref, flags, p));
    return p.value;
  });
  return (rval, dst);
}

/// SolveCubic finds the real roots of a cubic equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1c3b0b925b085b6e96931ee309e6a1da
(int rval, Mat roots) solveCubic(InputArray coeffs, {OutputArray? roots}) {
  roots ??= Mat.empty();
  final rval = cvRunArena<int>((arena) {
    final p = arena<ffi.Int>();
    cvRun(() => ccore.Mat_SolveCubic(coeffs.ref, roots!.ref, p));
    return p.value;
  });
  return (rval, roots);
}

/// SolvePoly finds the real or complex roots of a polynomial equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac2f5e953016fabcdf793d762f4ec5dce
(double rval, Mat roots) solvePoly(
  InputArray coeffs, {
  OutputArray? roots,
  int maxIters = 300,
}) {
  roots ??= Mat.empty();
  final rval = cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => ccore.Mat_SolvePoly(coeffs.ref, roots!.ref, maxIters, p));
    return p.value;
  });
  return (rval, roots);
}

/// Reduce reduces a matrix to a vector.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4b78072a303f29d9031d56e5638da78e
Mat reduce(InputArray src, int dim, int rtype, {OutputArray? dst, int dtype = -1}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Reduce(src.ref, dst!.ref, dim, rtype, dtype));
  return dst;
}

/// Finds indices of max elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa87ea34d99bcc5bf9695048355163da0
Mat reduceArgMax(InputArray src, int axis, {OutputArray? dst, bool lastIndex = false}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_ReduceArgMax(src.ref, dst!.ref, axis, lastIndex));
  return dst;
}

/// Finds indices of min elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeecd548276bfb91b938989e66b722088
Mat reduceArgMin(InputArray src, int axis, {OutputArray? dst, bool lastIndex = false}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_ReduceArgMin(src.ref, dst!.ref, axis, lastIndex));
  return dst;
}

/// Repeat fills the output array with repeated copies of the input array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga496c3860f3ac44c40b48811333cfda2d
Mat repeat(InputArray src, int ny, int nx, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Repeat(src.ref, ny, nx, dst!.ref));
  return dst;
}

/// Calculates the sum of a scaled array and another array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9e0845db4135f55dcf20227402f00d98
Mat scaleAdd(InputArray src1, double alpha, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_ScaleAdd(src1.ref, alpha, src2.ref, dst!.ref));
  return dst;
}

/// SetIdentity initializes a scaled identity matrix.
/// For further details, please see:
///
///	https://docs.opencv.org/master/d2/de8/group__core__array.html#ga388d7575224a4a277ceb98ccaa327c99
Mat setIdentity(InputOutputArray mtx, {double s = 1}) {
  cvRun(() => ccore.Mat_SetIdentity(mtx.ref, s));
  return mtx;
}

/// Sort sorts each row or each column of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga45dd56da289494ce874be2324856898f
Mat sort(InputArray src, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Sort(src.ref, dst!.ref, flags));
  return dst;
}

/// SortIdx sorts each row or each column of a matrix.
/// Instead of reordering the elements themselves, it stores the indices of sorted elements in the output array
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadf35157cbf97f3cb85a545380e383506
Mat sortIdx(InputArray src, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_SortIdx(src.ref, dst!.ref, flags));
  return dst;
}

/// Split creates an array of single channel images from a multi-channel image
/// Created images should be closed manualy to avoid memory leaks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0547c7fed86152d7e9d0096029c8518a
VecMat split(InputArray m) {
  final p = calloc<cvg.VecMat>();
  final vec = calloc<cvg.VecMat>();
  cvRun(() => ccore.Mat_Split(m.ref, vec));
  calloc.free(p);
  return VecMat.fromPointer(vec);
}

/// Subtract calculates the per-element subtraction of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa0f00d98b4b5edeaeb7b8333b2de353b
Mat subtract(
  InputArray src1,
  InputArray src2, {
  OutputArray? dst,
  // TODO
  //   InputArray? mask,
  //   int dtype = -1,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Subtract(src1.ref, src2.ref, dst!.ref));
  return dst;
}

/// Trace returns the trace of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3419ac19c7dcd2be4bd552a23e147dd8
Scalar trace(InputArray mtx) {
  final ptr = calloc<cvg.Scalar>();
  cvRun(() => ccore.Mat_Trace(mtx.ref, ptr));
  return Scalar.fromPointer(ptr);
}

/// Transform performs the matrix transformation of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga393164aa54bb9169ce0a8cc44e08ff22
Mat transform(InputArray src, InputArray m, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Transform(src.ref, dst!.ref, m.ref));
  return dst;
}

/// Transpose transposes a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
Mat transpose(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Transpose(src.ref, dst!.ref));
  return dst;
}

/// Pow raises every array element to a power.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf0d056b5bd1dc92500d6f6cf6bac41ef
Mat pow(InputArray src, double power, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.Mat_Pow(src.ref, power, dst!.ref));
  return dst;
}

/// PolatToCart calculates x and y coordinates of 2D vectors from their magnitude and angle.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga581ff9d44201de2dd1b40a50db93d665
(Mat x, Mat y) polarToCart(
  InputArray magnitude,
  InputArray angle, {
  OutputArray? x,
  OutputArray? y,
  bool angleInDegrees = false,
}) {
  x ??= Mat.empty();
  y ??= Mat.empty();
  cvRun(() => ccore.Mat_PolarToCart(magnitude.ref, angle.ref, x!.ref, y!.ref, angleInDegrees));
  return (x, y);
}

/// Phase calculates the rotation angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9db9ca9b4d81c3bde5677b8f64dc0137
Mat phase(InputArray x, InputArray y, {OutputArray? angle, bool angleInDegrees = false}) {
  angle ??= Mat.empty();
  cvRun(() => ccore.Mat_Phase(x.ref, y.ref, angle!.ref, angleInDegrees));
  return angle;
}

/// GetTickCount returns the number of ticks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/de0/group__core__utils.html#gae73f58000611a1af25dd36d496bf4487
int getTickCount() {
  return cvRunArena<int>((arena) {
    final p = arena<ffi.Int64>();
    cvRun(() => ccore.GetCVTickCount(p));
    return p.value;
  });
}

/// GetTickFrequency returns the number of ticks per second.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/de0/group__core__utils.html#ga705441a9ef01f47acdc55d87fbe5090c
double getTickFrequency() {
  return cvRunArena<double>((arena) {
    final p = arena<ffi.Double>();
    cvRun(() => ccore.GetTickFrequency(p));
    return p.value;
  });
}

/// TheRNG Returns the default random number generator.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga75843061d150ad6564b5447e38e57722
/// Disabled: double free
Rng theRNG() {
  final p = calloc<cvg.RNG>();
  cvRun(() => ccore.TheRNG(p));
  return Rng.fromTheRng(p);
}

/// RandN Fills the array with normally distributed random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeff1f61e972d133a04ce3a5f81cf6808
Mat randn(InputOutputArray dst, Scalar mean, Scalar stddev) {
  cvRun(() => ccore.RandN(dst.ref, mean.ref, stddev.ref));
  return dst;
}

/// RandShuffle Shuffles the array elements randomly.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6a789c8a5cb56c6dd62506179808f763
Mat randShuffle(
  InputOutputArray dst, {
  double iterFactor = 1,
  Rng? rng,
}) {
  if (rng == null) {
    cvRun(() => ccore.RandShuffle(dst.ref));
  } else {
    cvRun(() => ccore.RandShuffleWithParams(dst.ref, iterFactor, rng.ref));
  }
  return dst;
}

/// RandU Generates a single uniformly-distributed random
/// number or an array of random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1ba1026dca0807b27057ba6a49d258c0
Mat randu(InputOutputArray dst, Scalar low, Scalar high) {
  cvRun(() => ccore.RandU(dst.ref, low.ref, high.ref));
  return dst;
}

/// Set the number of threads for OpenCV.
void setNumThreads(int n) {
  cvRun(() => ccore.SetNumThreads(n));
}

/// Get the number of threads for OpenCV.
int getNumThreads() {
  return cvRunArena<int>((arena) {
    final p = arena<ffi.Int>();
    cvRun(() => ccore.GetNumThreads(p));
    return p.value;
  });
}
