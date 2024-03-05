library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'rng.dart';
import 'scalar.dart';
import 'base.dart';
import 'point.dart';
import 'mat_type.dart';
import 'mat.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());


/// get version
String openCvVersion() {
  final v = _bindings.openCVVersion().cast<Utf8>().toDartString();
  return v;
}

/// Returns full configuration time cmake output.
///
/// Returned value is raw cmake output including version control system revision, compiler version, compiler flags, enabled modules and third party libraries, etc. Output format depends on target architecture. 
String getBuildInformation() {
  final v = _bindings.getBuildInfo().cast<Utf8>().toDartString();
  return v;
}

/// AbsDiff calculates the per-element absolute difference between two arrays
/// or between an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6fef31bc8c4071cbc114a758a2b79c14
void absDiff(Mat src1, Mat src2, Mat dst) {
  _bindings.Mat_AbsDiff(src1.ptr, src2.ptr, dst.ptr);
}

/// Add calculates the per-element sum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga10ac1bfb180e2cfda1701d06c24fdbd6
void add(Mat src1, Mat src2, Mat dst) {
  _bindings.Mat_Add(src1.ptr, src2.ptr, dst.ptr);
}

/// AddWeighted calculates the weighted sum of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gafafb2513349db3bcff51f54ee5592a19
void addWeighted(
  InputArray src1,
  double alpha,
  InputArray src2,
  double beta,
  double gamma,
  OutputArray dst, {
  int dtype = -1, // TODO: add dtype
}) {
  _bindings.Mat_AddWeighted(
    src1.ptr,
    alpha,
    src2.ptr,
    beta,
    gamma,
    dst.ptr,
    // dtype,
  );
}

/// BitwiseAnd computes bitwise conjunction of the two arrays (dst = src1 & src2).
/// Calculates the per-element bit-wise conjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga60b4d04b251ba5eb1392c34425497e14
void bitwise_and(
  InputArray src1,
  InputArray src2,
  OutputArray dst, {
  InputArray? mask,
}) {
  if (mask == null)
    _bindings.Mat_BitwiseAnd(src1.ptr, src2.ptr, dst.ptr);
  else
    _bindings.Mat_BitwiseAndWithMask(src1.ptr, src2.ptr, dst.ptr, mask.ptr);
}

/// BitwiseNot inverts every bit of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0002cf8b418479f4cb49a75442baee2f
void bitwise_not(InputArray src, OutputArray dst, {InputArray? mask}) {
  if (mask == null)
    _bindings.Mat_BitwiseNot(src.ptr, dst.ptr);
  else
    _bindings.Mat_BitwiseNotWithMask(src.ptr, dst.ptr, mask.ptr);
}

/// BitwiseOr calculates the per-element bit-wise disjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gab85523db362a4e26ff0c703793a719b4
void bitwise_or(
  InputArray src1,
  InputArray src2,
  OutputArray dst, {
  InputArray? mask,
}) {
  if (mask == null)
    _bindings.Mat_BitwiseOr(src1.ptr, src2.ptr, dst.ptr);
  else
    _bindings.Mat_BitwiseOrWithMask(src1.ptr, src2.ptr, dst.ptr, mask.ptr);
}

/// BitwiseXor calculates the per-element bit-wise "exclusive or" operation
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga84b2d8188ce506593dcc3f8cd00e8e2c
void bitwise_xor(
  InputArray src1,
  InputArray src2,
  OutputArray dst, {
  InputArray? mask,
}) {
  if (mask == null)
    _bindings.Mat_BitwiseXor(src1.ptr, src2.ptr, dst.ptr);
  else
    _bindings.Mat_BitwiseXorWithMask(src1.ptr, src2.ptr, dst.ptr, mask.ptr);
}

/// BatchDistance is a naive nearest neighbor finder.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ba778a1c57f83233b1d851c83f5a622
void batchDistance(
  InputArray src1,
  InputArray src2,
  OutputArray dist,
  int dtype,
  OutputArray nidx, {
  int normType = NORM_L2,
  int K = 0,
  InputArray? mask,
  int update = 0,
  bool crosscheck = false,
}) {
  mask ??= Mat.empty();
  _bindings.Mat_BatchDistance(
    src1.ptr,
    src2.ptr,
    dist.ptr,
    dtype,
    nidx.ptr,
    normType,
    K,
    mask.ptr,
    update,
    crosscheck,
  );
}

/// BorderInterpolate computes the source location of an extrapolated pixel.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga247f571aa6244827d3d798f13892da58
int borderInterpolate(int p, int len, int borderType) {
  return _bindings.Mat_BorderInterpolate(p, len, borderType);
}

/// CalcCovarMatrix calculates the covariance matrix of a set of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga017122d912af19d7d0d2cccc2d63819f
void calcCovarMatrix(
  InputArray samples,
  OutputArray covar,
  InputOutputArray mean,
  int flags, {
  int ctype = MatType.CV_64F,
}) {
  _bindings.Mat_CalcCovarMatrix(
    samples.ptr,
    covar.ptr,
    mean.ptr,
    flags,
    ctype,
  );
}

/// CartToPolar calculates the magnitude and angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac5f92f48ec32cacf5275969c33ee837d
void cartToPolar(
  InputArray x,
  InputArray y,
  OutputArray magnitude,
  OutputArray angle, {
  bool angleInDegrees = false,
}) {
  _bindings.Mat_CartToPolar(
    x.ptr,
    y.ptr,
    magnitude.ptr,
    angle.ptr,
    angleInDegrees,
  );
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
  final pos = calloc<cvg.Point>();
  final ret = _bindings.Mat_CheckRange(a.ptr, quiet, pos, minVal, maxVal);
  return (ret, Point.fromPointer(pos));
}

/// Compare performs the per-element comparison of two arrays
/// or an array and scalar value.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga303cfb72acf8cbb36d884650c09a3a97
void compare(InputArray src1, InputArray src2, OutputArray dst, int cmpop) {
  _bindings.Mat_Compare(src1.ptr, src2.ptr, dst.ptr, cmpop);
}

/// CountNonZero counts non-zero array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa4b89393263bb4d604e0fe5986723914
int countNonZero(Mat src) {
  return _bindings.Mat_CountNonZero(src.ptr);
}

/// CompleteSymm copies the lower or the upper half of a square matrix to its another half.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga6847337c0c55769e115a70e0f011b5ca
void completeSymm(InputOutputArray m, {bool lowerToUpper = false}) {
  _bindings.Mat_CompleteSymm(m.ptr, lowerToUpper);
}

/// ConvertScaleAbs scales, calculates absolute values, and converts the result to 8-bit.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3460e9c9f37b563ab9dd550c4d8c4e7d
void convertScaleAbs(
  InputArray src,
  OutputArray dst, {
  double alpha = 1,
  double beta = 0,
}) {
  _bindings.Mat_ConvertScaleAbs(src.ptr, dst.ptr, alpha, beta);
}

/// CopyMakeBorder forms a border around an image (applies padding).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga2ac1049c2c3dd25c2b41bffe17658a36
void copyMakeBorder(
  InputArray src,
  OutputArray dst,
  int top,
  int bottom,
  int left,
  int right,
  int borderType, {
  Scalar? value,
}) {
  value ??= Scalar.default_();
  _bindings.Mat_CopyMakeBorder(
    src.ptr,
    dst.ptr,
    top,
    bottom,
    left,
    right,
    borderType,
    value.toNative(),
  );
}

/// DCT performs a forward or inverse discrete Cosine transform of 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga85aad4d668c01fbd64825f589e3696d4
void dct(InputArray src, OutputArray dst, {int flags = 0}) {
  _bindings.Mat_DCT(src.ptr, dst.ptr, flags);
}

/// Determinant returns the determinant of a square floating-point matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf802bd9ca3e07b8b6170645ef0611d0c
double determinant(InputArray mtx) {
  return _bindings.Mat_Determinant(mtx.ptr);
}

/// DFT performs a forward or inverse Discrete Fourier Transform (DFT)
/// of a 1D or 2D floating-point array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadd6cf9baf2b8b704a11b5f04aaf4f39d
void dft(
  InputArray src,
  OutputArray dst, {
  int flags = 0,
  int nonzeroRows = 0, // TODO: add
}) {
  _bindings.Mat_DFT(src.ptr, dst.ptr, flags);
}

/// Divide performs the per-element division
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6db555d30115642fedae0cda05604874
void divide(
  InputArray src1,
  InputArray src2,
  OutputArray dst, {
  double scale = 1,
  int dtype = -1,
}) {
  _bindings.Mat_Divide(src1.ptr, src2.ptr, dst.ptr);
}

/// Eigen calculates eigenvalues and eigenvectors of a symmetric matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9fa0d58657f60eaa6c71f6fbb40456e3
bool eigen(
  InputArray src,
  OutputArray eigenvalues, {
  OutputArray? eigenvectors,
}) {
  eigenvectors ??= Mat.empty();
  return _bindings.Mat_Eigen(src.ptr, eigenvalues.ptr, eigenvectors.ptr);
}

/// EigenNonSymmetric calculates eigenvalues and eigenvectors of a non-symmetric matrix (real eigenvalues only).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf51987e03cac8d171fbd2b327cf966f6
void eigenNonSymmetric(
  InputArray src,
  OutputArray eigenvalues,
  OutputArray eigenvectors,
) {
  _bindings.Mat_EigenNonSymmetric(src.ptr, eigenvalues.ptr, eigenvectors.ptr);
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
void PCACompute(
  InputArray data,
  InputOutputArray mean,
  OutputArray eigenvectors,
  OutputArray eigenvalues, {
  int maxComponents = 0,
}) {
  _bindings.Mat_PCACompute(data.ptr, mean.ptr, eigenvectors.ptr, eigenvalues.ptr, maxComponents);
}

/// Exp calculates the exponent of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3e10108e2162c338f1b848af619f39e5
void exp(InputArray src, OutputArray dst) {
  _bindings.Mat_Exp(src.ptr, dst.ptr);
}

/// ExtractChannel extracts a single channel from src (coi is 0-based index).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc6158574aa1f0281878c955bcf35642
void extractChannel(InputArray src, OutputArray dst, int coi) {
  _bindings.Mat_ExtractChannel(src.ptr, dst.ptr, coi);
}

/// FindNonZero returns the list of locations of non-zero pixels.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaed7df59a3539b4cc0fe5c9c8d7586190
void findNonZero(InputArray src, OutputArray idx) {
  _bindings.Mat_FindNonZero(src.ptr, idx.ptr);
}

/// Flip flips a 2D array around horizontal(0), vertical(1), or both axes(-1).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaca7be533e3dac7feb70fc60635adf441
void flip(InputArray src, OutputArray dst, int flipCode) {
  _bindings.Mat_Flip(src.ptr, dst.ptr, flipCode);
}

/// Gemm performs generalized matrix multiplication.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacb6e64071dffe36434e1e7ee79e7cb35
void gemm(
  InputArray src1,
  InputArray src2,
  double alpha,
  InputArray src3,
  double beta,
  OutputArray dst, {
  int flags = 0,
}) {
  _bindings.Mat_Gemm(src1.ptr, src2.ptr, alpha, src3.ptr, beta, dst.ptr, flags);
}

/// GetOptimalDFTSize returns the optimal Discrete Fourier Transform (DFT) size
/// for a given vector size.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6577a2e59968936ae02eb2edde5de299
int getOptimalDFTSize(int vecsize) {
  return _bindings.Mat_GetOptimalDFTSize(vecsize);
}

/// Hconcat applies horizontal concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaab5ceee39e0580f879df645a872c6bf7
void hconcat(InputArray src1, InputArray src2, OutputArray dst) {
  _bindings.Mat_Hconcat(src1.ptr, src2.ptr, dst.ptr);
}

/// Vconcat applies vertical concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gaad07cede730cdde64b90e987aad179b8
void vconcat(InputArray src1, InputArray src2, OutputArray dst) {
  _bindings.Mat_Vconcat(src1.ptr, src2.ptr, dst.ptr);
}

/// Rotate rotates a 2D array in multiples of 90 degrees
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ad01c0978b0ce64baa246811deeac24
void rotate(InputArray src, OutputArray dst, int rotateCode) {
  _bindings.Rotate(src.ptr, dst.ptr, rotateCode);
}

/// IDCT calculates the inverse Discrete Cosine Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga77b168d84e564c50228b69730a227ef2
void idct(
  InputArray src,
  OutputArray dst, {
  int flags = 0,
}) {
  _bindings.Mat_Idct(src.ptr, dst.ptr, flags);
}

/// IDFT calculates the inverse Discrete Fourier Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa708aa2d2e57a508f968eb0f69aa5ff1
void idft(
  InputArray src,
  OutputArray dst, {
  int flags = 0,
  int nonzeroRows = 0,
}) {
  _bindings.Mat_Idft(src.ptr, dst.ptr, flags, nonzeroRows);
}

/// InRange checks if array elements lie between the elements of two Mat arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
void inRange(
  InputArray src,
  InputArray lowerb,
  InputArray upperb,
  OutputArray dst,
) {
  _bindings.Mat_InRange(src.ptr, lowerb.ptr, upperb.ptr, dst.ptr);
}

/// InRangeWithScalar checks if array elements lie between the elements of two Scalars
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
void inRangebyScalar(
  InputArray src,
  Scalar lowerb,
  Scalar upperb,
  OutputArray dst,
) {
  _bindings.Mat_InRangeWithScalar(src.ptr, lowerb.ref, upperb.ref, dst.ptr);
}

/// InsertChannel inserts a single channel to dst (coi is 0-based index)
/// (it replaces channel i with another in dst).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1d4bd886d35b00ec0b764cb4ce6eb515
void insertChannel(InputArray src, InputOutputArray dst, int coi) {
  _bindings.Mat_InsertChannel(src.ptr, dst.ptr, coi);
}

/// Invert finds the inverse or pseudo-inverse of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad278044679d4ecf20f7622cc151aaaa2
double invert(
  InputArray src,
  OutputArray dst, {
  int flags = DECOMP_LU,
}) {
  return _bindings.Mat_Invert(src.ptr, dst.ptr, flags);
}

/// KMeans finds centers of clusters and groups input samples around the clusters.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d5/d38/group__core__cluster.html#ga9a34dc06c6ec9460e90860f15bcd2f88
double kmeans(
  InputArray data,
  int K,
  InputOutputArray bestLabels,
  cvg.TermCriteria criteria,
  int attempts,
  int flags,
  OutputArray centers,
) {
  return _bindings.KMeans(
    data.ptr,
    K,
    bestLabels.ptr,
    criteria,
    attempts,
    flags,
    centers.ptr,
  );
}

/// KMeansPoints finds centers of clusters and groups input samples around the clusters.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d5/d38/group__core__cluster.html#ga9a34dc06c6ec9460e90860f15bcd2f88
double kmeansByPoints(
  List<Point> data,
  int K,
  InputOutputArray bestLabels,
  cvg.TermCriteria criteria,
  int attempts,
  int flags,
  OutputArray centers,
) {
  final pv = data.toNativeVecotr();
  final r = _bindings.KMeansPoints(
    pv,
    K,
    bestLabels.ptr,
    criteria,
    attempts,
    flags,
    centers.ptr,
  );
  _bindings.PointVector_Close(pv);
  return r;
}

/// Log calculates the natural logarithm of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga937ecdce4679a77168730830a955bea7
void log(InputArray src, OutputArray dst) {
  _bindings.Mat_Log(src.ptr, dst.ptr);
}

/// Magnitude calculates the magnitude of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6d3b097586bca4409873d64a90fe64c3
void magnitude(InputArray x, InputArray y, OutputArray magnitude) {
  _bindings.Mat_Magnitude(x.ptr, y.ptr, magnitude.ptr);
}

/// Max calculates per-element maximum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc40fa15eac0fb83f8ca70b7cc0b588d
void max(InputArray src1, InputArray src2, OutputArray dst) {
  _bindings.Mat_Max(src1.ptr, src2.ptr, dst.ptr);
}

/// MeanStdDev calculates a mean and standard deviation of array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga846c858f4004d59493d7c6a4354b301d
meanStdDev(
  InputArray src,
  OutputArray mean,
  OutputArray stddev, {
  InputArray? mask, // TODO
}) {
  _bindings.Mat_MeanStdDev(src.ptr, mean.ptr, stddev.ptr);
}

/// Merge creates one multi-channel array out of several single-channel ones.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7d7b4d6c6ee504b30a20b1680029c7b4
void merge(List<Mat> mv, OutputArray dst) {
  using((arena) {
    _bindings.Mat_Merge(mv.toMats(arena).ref, dst.ptr);
  });
}

/// Min calculates per-element minimum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9af368f182ee76d0463d0d8d5330b764
void min(InputArray src1, InputArray src2, OutputArray dst) {
  _bindings.Mat_Min(src1.ptr, src2.ptr, dst.ptr);
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
    _bindings.Mat_MinMaxIdx(src.ptr, minValP, maxValP, minIdxP, maxIdxP);
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
    final minLocP = arena<cvg.Point>();
    final maxLocP = arena<cvg.Point>();
    _bindings.Mat_MinMaxLoc(src.ptr, minValP, maxValP, minLocP, maxLocP);
    return (
      minValP.value,
      maxValP.value,
      Point(minLocP.ref.x, minLocP.ref.y),
      Point(maxLocP.ref.x, maxLocP.ref.y)
    );
  });
}

/// Copies specified channels from input arrays to the specified channels of output arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga51d768c270a1cdd3497255017c4504be
// List<Mat> mixChannels(List<Mat> src, List<int> fromTo) {
//   return using<List<Mat>>((arena) {
//     final dstP = arena<cvg.Mats>();
//     _bindings.Mat_MixChannels(src.toMats(arena).ref, dstP.ref, fromTo.toNativeVector(arena).ref);
//     return dstP.toList();
//   });
// }

/// Mulspectrums performs the per-element multiplication of two Fourier spectrums.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3ab38646463c59bf0ce962a9d51db64f
void mulSpectrums(
  InputArray a,
  InputArray b,
  OutputArray c,
  int flags, {
  bool conjB = false,
}) {
  _bindings.Mat_MulSpectrums(a.ptr, b.ptr, c.ptr, flags);
}

/// Multiply calculates the per-element scaled product of two arrays.
/// Both input arrays must be of the same size and the same type.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga979d898a58d7f61c53003e162e7ad89f
void multiply(
  InputArray src1,
  InputArray src2,
  OutputArray dst, {
  double scale = 1,
  int dtype = -1,
}) {
  _bindings.Mat_MultiplyWithParams(src1.ptr, src2.ptr, dst.ptr, scale, dtype);
}

/// Normalize normalizes the norm or value range of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga87eef7ee3970f86906d69a92cbf064bd
void normalize(
  InputArray src,
  InputOutputArray dst, {
  double alpha = 1,
  double beta = 0,
  int norm_type = NORM_L2,
  // TODO
  // int dtype = -1,
  // InputArray? mask,
}) {
  _bindings.Mat_Normalize(src.ptr, dst.ptr, alpha, beta, norm_type);
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
  return _bindings.Norm(src1.ptr, normType);
}

/// Norm calculates the absolute difference/relative norm of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
double norm1(
  InputArray src1,
  InputArray src2, {
  int normType = NORM_L2,
  InputArray? mask,
}) {
  return _bindings.NormWithMats(src1.ptr, src2.ptr, normType);
}

/// PerspectiveTransform performs the perspective matrix transformation of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad327659ac03e5fd6894b90025e6900a7
void perspectiveTransform(InputArray src, OutputArray dst, InputArray m) {
  _bindings.Mat_PerspectiveTransform(src.ptr, dst.ptr, m.ptr);
}

/// Solve solves one or more linear systems or least-squares problems.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga12b43690dbd31fed96f213eefead2373
bool solve(
  InputArray src1,
  InputArray src2,
  OutputArray dst, {
  int flags = DECOMP_LU,
}) {
  return _bindings.Mat_Solve(src1.ptr, src2.ptr, dst.ptr, flags);
}

/// SolveCubic finds the real roots of a cubic equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1c3b0b925b085b6e96931ee309e6a1da
int solveCubic(InputArray coeffs, OutputArray roots) {
  return _bindings.Mat_SolveCubic(coeffs.ptr, roots.ptr);
}

/// SolvePoly finds the real or complex roots of a polynomial equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac2f5e953016fabcdf793d762f4ec5dce
double solvePoly(
  InputArray coeffs,
  OutputArray roots, {
  int maxIters = 300,
}) {
  return _bindings.Mat_SolvePoly(coeffs.ptr, roots.ptr, maxIters);
}

/// Reduce reduces a matrix to a vector.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4b78072a303f29d9031d56e5638da78e
void reduce(InputArray src, OutputArray dst, int dim, int rtype, {int dtype = -1}) {
  _bindings.Mat_Reduce(src.ptr, dst.ptr, dim, rtype, dtype);
}

/// Finds indices of max elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa87ea34d99bcc5bf9695048355163da0
void reduceArgMax(InputArray src, OutputArray dst, int axis, {bool lastIndex = false}) {
  _bindings.Mat_ReduceArgMax(src.ptr, dst.ptr, axis, lastIndex);
}

/// Finds indices of min elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeecd548276bfb91b938989e66b722088
void reduceArgMin(InputArray src, OutputArray dst, int axis, {bool lastIndex = false}) {
  _bindings.Mat_ReduceArgMin(src.ptr, dst.ptr, axis, lastIndex);
}

/// Repeat fills the output array with repeated copies of the input array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga496c3860f3ac44c40b48811333cfda2d
void repeat(InputArray src, int ny, int nx, OutputArray dst) {
  _bindings.Mat_Repeat(src.ptr, ny, nx, dst.ptr);
}

/// Calculates the sum of a scaled array and another array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9e0845db4135f55dcf20227402f00d98
void scaleAdd(InputArray src1, double alpha, InputArray src2, OutputArray dst) {
  _bindings.Mat_ScaleAdd(src1.ptr, alpha, src2.ptr, dst.ptr);
}

/// SetIdentity initializes a scaled identity matrix.
/// For further details, please see:
///
///	https://docs.opencv.org/master/d2/de8/group__core__array.html#ga388d7575224a4a277ceb98ccaa327c99
void setIdentity(InputOutputArray mtx, {double s = 1}) {
  _bindings.Mat_SetIdentity(mtx.ptr, s);
}

/// Sort sorts each row or each column of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga45dd56da289494ce874be2324856898f
void sort(InputArray src, OutputArray dst, int flags) {
  _bindings.Mat_Sort(src.ptr, dst.ptr, flags);
}

/// SortIdx sorts each row or each column of a matrix.
/// Instead of reordering the elements themselves, it stores the indices of sorted elements in the output array
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadf35157cbf97f3cb85a545380e383506
void sortIdx(InputArray src, OutputArray dst, int flags) {
  _bindings.Mat_SortIdx(src.ptr, dst.ptr, flags);
}

/// Split creates an array of single channel images from a multi-channel image
/// Created images should be closed manualy to avoid memory leaks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0547c7fed86152d7e9d0096029c8518a
List<Mat> split(InputArray m) {
  return using<List<Mat>>((arena) {
    final mats = arena<cvg.Mats>();
    _bindings.Mat_Split(m.ptr, mats);
    return mats.toList();
  });
}

/// Subtract calculates the per-element subtraction of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa0f00d98b4b5edeaeb7b8333b2de353b
void subtract(
  InputArray src1,
  InputArray src2,
  OutputArray dst,
  // TODO
  // {
  //   InputArray? mask,
  //   int dtype = -1,
  // }
) {
  _bindings.Mat_Subtract(src1.ptr, src2.ptr, dst.ptr);
}

/// Trace returns the trace of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3419ac19c7dcd2be4bd552a23e147dd8
Scalar trace(InputArray mtx) {
  return Scalar.fromNative(_bindings.Mat_Trace(mtx.ptr));
}

/// Transform performs the matrix transformation of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga393164aa54bb9169ce0a8cc44e08ff22
void transform(InputArray src, OutputArray dst, InputArray m) {
  _bindings.Mat_Transform(src.ptr, dst.ptr, m.ptr);
}

/// Transpose transposes a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
void transpose(InputArray src, OutputArray dst) {
  _bindings.Mat_Transpose(src.ptr, dst.ptr);
}

/// Pow raises every array element to a power.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf0d056b5bd1dc92500d6f6cf6bac41ef
void pow(InputArray src, double power, OutputArray dst) {
  _bindings.Mat_Pow(src.ptr, power, dst.ptr);
}

/// PolatToCart calculates x and y coordinates of 2D vectors from their magnitude and angle.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga581ff9d44201de2dd1b40a50db93d665
void polarToCart(
  InputArray magnitude,
  InputArray angle,
  OutputArray x,
  OutputArray y, {
  bool angleInDegrees = false,
}) {
  _bindings.Mat_PolarToCart(magnitude.ptr, angle.ptr, x.ptr, y.ptr, angleInDegrees);
}

/// Phase calculates the rotation angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9db9ca9b4d81c3bde5677b8f64dc0137
void phase(InputArray x, InputArray y, OutputArray angle, {bool angleInDegrees = false}) {
  _bindings.Mat_Phase(x.ptr, y.ptr, angle.ptr, angleInDegrees);
}

/// TermCriteria is the criteria for iterative algorithms.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d9/d5d/classcv_1_1TermCriteria.html
cvg.TermCriteria termCriteriaNew(int type, int maxCount, double epsilon) {
  return _bindings.TermCriteria_New(type, maxCount, epsilon);
}

/// GetTickCount returns the number of ticks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/de0/group__core__utils.html#gae73f58000611a1af25dd36d496bf4487
int getTickCount() {
  return _bindings.GetCVTickCount();
}

/// GetTickFrequency returns the number of ticks per second.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/de0/group__core__utils.html#ga705441a9ef01f47acdc55d87fbe5090c
double getTickFrequency() {
  return _bindings.GetTickFrequency();
}

/// TheRNG Returns the default random number generator.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga75843061d150ad6564b5447e38e57722
/// Disabled: double free
Rng theRNG() {
  return Rng.fromTheRng(_bindings.TheRNG());
}

/// RandN Fills the array with normally distributed random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeff1f61e972d133a04ce3a5f81cf6808
void randn(InputOutputArray dst, Scalar mean, Scalar stddev) {
  _bindings.RandN(dst.ptr, mean.ref, stddev.ref);
}

/// RandShuffle Shuffles the array elements randomly.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6a789c8a5cb56c6dd62506179808f763
void randShuffle(
  InputOutputArray dst, {
  double iterFactor = 1,
  Rng? rng,
}) {
  if (rng == null) {
    _bindings.RandShuffle(dst.ptr);
  } else {
    _bindings.RandShuffleWithParams(dst.ptr, iterFactor, rng.ptr);
  }
}

/// RandU Generates a single uniformly-distributed random
/// number or an array of random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1ba1026dca0807b27057ba6a49d258c0
void randu(InputOutputArray dst, Scalar low, Scalar high) {
  _bindings.RandU(dst.ptr, low.ref, high.ref);
}

/// Set the number of threads for OpenCV.
void setNumThreads(int n) {
  _bindings.SetNumThreads(n);
}

/// Get the number of threads for OpenCV.
int getNumThreads() {
  return _bindings.GetNumThreads();
}
