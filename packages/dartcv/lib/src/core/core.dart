// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv.core;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/constants.g.dart';
import '../g/core.g.dart' as cvg;
import '../g/core.g.dart' as ccore;
import 'base.dart';
import 'mat.dart';
import 'mat_type.dart';
import 'point.dart';
import 'rng.dart';
import 'scalar.dart';
import 'termcriteria.dart';
import 'vec.dart';

enum LogLevel {
  SILENT(0),
  FATAL(1),
  ERROR(2),
  WARNING(3),
  INFO(4),
  DEBUG(5),
  VERBOSE(6)
  ;

  final int value;
  const LogLevel(this.value);

  factory LogLevel.fromValue(int value) {
    return switch (value) {
      0 => LogLevel.SILENT,
      1 => LogLevel.FATAL,
      2 => LogLevel.ERROR,
      3 => LogLevel.WARNING,
      4 => LogLevel.INFO,
      5 => LogLevel.DEBUG,
      6 => LogLevel.VERBOSE,
      _ => throw ArgumentError.value(value, 'value', 'Invalid log level value'),
    };
  }
}

/// Sets the global logging level.
void setLogLevel(LogLevel logLevel) {
  cvRun(() => ccore.setLogLevel(logLevel.value));
}

/// Gets the global logging level.
LogLevel getLogLevel() {
  final p = calloc<ffi.Int>();
  cvRun(() => ccore.getLogLevel(p));
  final level = p.value;
  calloc.free(p);
  return LogLevel.fromValue(level);
}

void writeLogMessage(LogLevel logLevel, String message) {
  final cmsg = message.toNativeUtf8().cast<ffi.Char>();
  ccore.writeLogMessage(logLevel.value, cmsg);
  calloc.free(cmsg);
}

/// Writes a log message.
///
/// if [tag], [file], [line], [func] are all null, then it will be the same as [writeLogMessage].
void writeLogMessageEx(
  LogLevel logLevel,
  String message, {
  String? tag,
  String? file,
  int? line,
  String? func,
}) {
  final cmsg = message.toNativeUtf8().cast<ffi.Char>();

  if (tag == null && file == null && line == null && func == null) {
    ccore.writeLogMessage(logLevel.value, cmsg);
  } else {
    final ctag = (tag ?? "").toNativeUtf8().cast<ffi.Char>();
    final cfile = (file ?? "").toNativeUtf8().cast<ffi.Char>();
    final cfunc = (func ?? "").toNativeUtf8().cast<ffi.Char>();
    ccore.writeLogMessageEx(logLevel.value, ctag, cfile, line ?? -1, cfunc, cmsg);
    calloc.free(ctag);
    calloc.free(cfile);
    calloc.free(cfunc);
  }

  calloc.free(cmsg);
}

void defaultLogCallback(LogLevel logLevel, String message) {
  final logMessage = "[dartcv][${logLevel.name}]: $message";
  // ignore: avoid_print
  print(logMessage);
}

void defaultLogCallbackEx(
  LogLevel logLevel,
  String tag,
  String file,
  int line,
  String func,
  String message,
) {
  final logMessage = "[dartcv][${logLevel.name}][$tag]$file:$line:$func: $message";
  // ignore: avoid_print
  print(logMessage);
}

typedef LogCallbackFunction = void Function(LogLevel logLevel, String message);
typedef LogCallbackExFunction =
    void Function(
      LogLevel logLevel,
      String tag,
      String file,
      int line,
      String func,
      String message,
    );

ffi.NativeCallable<cvg.LogCallbackExFunction>? _logCallbackEx;
ffi.NativeCallable<cvg.LogCallbackFunction>? _logCallback;

void replaceWriteLogMessage({LogCallbackFunction? callback}) {
  if (callback == null) {
    cvRun(() => ccore.replaceWriteLogMessage(ffi.nullptr));
    _logCallback?.close();
    _logCallback = null;
  } else {
    void cCallback(int logLevel, ffi.Pointer<ffi.Char> message, int msgLen) {
      final messageStr = message.cast<Utf8>().toDartString(length: msgLen);
      callback(LogLevel.fromValue(logLevel), messageStr);
    }

    final fp = ffi.NativeCallable<cvg.LogCallbackFunction>.listener(cCallback);
    cvRun(() => ccore.replaceWriteLogMessage(fp.nativeFunction));
    _logCallback = fp;
  }
}

void replaceWriteLogMessageEx({LogCallbackExFunction? callback}) {
  if (callback == null) {
    cvRun(() => ccore.replaceWriteLogMessageEx(ffi.nullptr));
    _logCallbackEx?.close();
    _logCallbackEx = null;
  } else {
    void cCallback(
      int logLevel,
      ffi.Pointer<ffi.Char> tag,
      int tagLen,
      ffi.Pointer<ffi.Char> file,
      int fileLen,
      int line,
      ffi.Pointer<ffi.Char> func,
      int funcLen,
      ffi.Pointer<ffi.Char> message,
      int msgLen,
    ) {
      final tagStr = tag.cast<Utf8>().toDartString(length: tagLen);
      final fileStr = file.cast<Utf8>().toDartString(length: fileLen);
      final funcStr = func.cast<Utf8>().toDartString(length: funcLen);
      final messageStr = message.cast<Utf8>().toDartString(length: msgLen);
      callback(LogLevel.fromValue(logLevel), tagStr, fileStr, line, funcStr, messageStr);
    }

    final fp = ffi.NativeCallable<cvg.LogCallbackExFunction>.listener(cCallback);
    cvRun(() => ccore.replaceWriteLogMessageEx(fp.nativeFunction));
    _logCallbackEx = fp;
  }
}

/// get version
String openCvVersion() => ccore.getCvVersion().toDartString();

/// Returns full configuration time cmake output.
///
/// Returned value is raw cmake output including version control system revision, compiler version, compiler flags, enabled modules and third party libraries, etc. Output format depends on target architecture.
String getBuildInformation() => ccore.getBuildInfo().toDartString();

/// AbsDiff calculates the per-element absolute difference between two arrays
/// or between an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6fef31bc8c4071cbc114a758a2b79c14
Mat absDiff(Mat src1, Mat src2, {Mat? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_absdiff(src1.ref, src2.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Add calculates the per-element sum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga10ac1bfb180e2cfda1701d06c24fdbd6
Mat add(Mat src1, Mat src2, {Mat? dst, int dtype = -1, Mat? mask}) {
  dst ??= Mat.empty();
  mask ??= Mat.empty();
  cvRun(() => ccore.cv_add(src1.ref, src2.ref, dst!.ref, mask!.ref, dtype, ffi.nullptr));
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
  int dtype = -1,
}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_addWeighted(src1.ref, alpha, src2.ref, beta, gamma, dst!.ref, dtype, ffi.nullptr));
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
    () => ccore.cv_batchDistance(
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
      ffi.nullptr,
    ),
  );
  return (dist, nidx);
}

/// BitwiseAnd computes bitwise conjunction of the two arrays (dst = src1 & src2).
/// Calculates the per-element bit-wise conjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga60b4d04b251ba5eb1392c34425497e14
Mat bitwiseAND(InputArray src1, InputArray src2, {OutputArray? dst, InputArray? mask}) {
  dst ??= Mat.empty();
  mask == null
      ? cvRun(() => ccore.cv_bitwise_and(src1.ref, src2.ref, dst!.ref, ffi.nullptr))
      : cvRun(() => ccore.cv_bitwise_and_1(src1.ref, src2.ref, dst!.ref, mask.ref, ffi.nullptr));
  return dst;
}

/// BitwiseNot inverts every bit of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0002cf8b418479f4cb49a75442baee2f
Mat bitwiseNOT(InputArray src, {OutputArray? dst, InputArray? mask}) {
  dst ??= Mat.empty();
  mask == null
      ? cvRun(() => ccore.cv_bitwise_not(src.ref, dst!.ref, ffi.nullptr))
      : cvRun(() => ccore.cv_bitwise_not_1(src.ref, dst!.ref, mask.ref, ffi.nullptr));
  return dst;
}

/// BitwiseOr calculates the per-element bit-wise disjunction of two arrays
/// or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gab85523db362a4e26ff0c703793a719b4
Mat bitwiseOR(InputArray src1, InputArray src2, {OutputArray? dst, InputArray? mask}) {
  dst ??= Mat.empty();
  mask == null
      ? cvRun(() => ccore.cv_bitwise_or(src1.ref, src2.ref, dst!.ref, ffi.nullptr))
      : cvRun(() => ccore.cv_bitwise_or_1(src1.ref, src2.ref, dst!.ref, mask.ref, ffi.nullptr));
  return dst;
}

/// BitwiseXor calculates the per-element bit-wise "exclusive or" operation
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga84b2d8188ce506593dcc3f8cd00e8e2c
Mat bitwiseXOR(InputArray src1, InputArray src2, {OutputArray? dst, InputArray? mask}) {
  dst ??= Mat.empty();
  mask == null
      ? cvRun(() => ccore.cv_bitwise_xor(src1.ref, src2.ref, dst!.ref, ffi.nullptr))
      : cvRun(() => ccore.cv_bitwise_xor_1(src1.ref, src2.ref, dst!.ref, mask.ref, ffi.nullptr));
  return dst;
}

/// BorderInterpolate computes the source location of an extrapolated pixel.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga247f571aa6244827d3d798f13892da58
int borderInterpolate(int p, int len, int borderType) {
  final ptr = calloc<ffi.Int>();
  cvRun(() => ccore.cv_borderInterpolate(p, len, borderType, ptr, ffi.nullptr));
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
  cvRun(() => ccore.cv_calcCovarMatrix(samples.ref, covar!.ref, mean.ref, flags, ctype, ffi.nullptr));
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
  cvRun(() => ccore.cv_cartToPolar(x.ref, y.ref, magnitude!.ref, angle!.ref, angleInDegrees, ffi.nullptr));
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
  final pos = calloc<cvg.CvPoint>();
  final pRval = calloc<ffi.Bool>();
  cvRun(() => ccore.cv_checkRange(a.ref, quiet, pos, minVal, maxVal, pRval, ffi.nullptr));
  final rval = pRval.value;
  calloc.free(pRval);
  return (rval, Point.fromPointer(pos));
}

/// Compare performs the per-element comparison of two arrays
/// or an array and scalar value.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga303cfb72acf8cbb36d884650c09a3a97
Mat compare(InputArray src1, InputArray src2, int cmpop, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_compare(src1.ref, src2.ref, dst!.ref, cmpop, ffi.nullptr));
  return dst;
}

/// CompleteSymm copies the lower or the upper half of a square matrix to its another half.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga6847337c0c55769e115a70e0f011b5ca
Mat completeSymm(InputOutputArray m, {bool lowerToUpper = false}) {
  cvRun(() => ccore.cv_completeSymm(m.ref, lowerToUpper, ffi.nullptr));
  return m;
}

/// ConvertScaleAbs scales, calculates absolute values, and converts the result to 8-bit.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3460e9c9f37b563ab9dd550c4d8c4e7d
Mat convertScaleAbs(InputArray src, {OutputArray? dst, double alpha = 1, double beta = 0}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_convertScaleAbs(src.ref, dst!.ref, alpha, beta, ffi.nullptr));
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
    () => ccore.cv_copyMakeBorder(
      src.ref,
      dst!.ref,
      top,
      bottom,
      left,
      right,
      borderType,
      value!.ref,
      ffi.nullptr,
    ),
  );
  return dst;
}

/// CopyTo
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga931a49489330f998452fc53e96e1719a
Mat copyTo(InputArray src, InputArray dst, {InputArray? mask}) {
  mask ??= Mat.empty();
  cvRun(() => ccore.cv_copyTo(src.ref, dst.ref, mask!.ref, ffi.nullptr));
  return dst;
}

/// CountNonZero counts non-zero array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa4b89393263bb4d604e0fe5986723914
int countNonZero(Mat src) => ccore.cv_countNonZero(src.ref);

/// DCT performs a forward or inverse discrete Cosine transform of 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga85aad4d668c01fbd64825f589e3696d4
Mat dct(InputArray src, {OutputArray? dst, int flags = 0}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_dct(src.ref, dst!.ref, flags, ffi.nullptr));
  return dst;
}

/// Determinant returns the determinant of a square floating-point matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf802bd9ca3e07b8b6170645ef0611d0c
double determinant(InputArray mtx) {
  final p = calloc<ffi.Double>();
  cvRun(() => ccore.cv_determinant(mtx.ref, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return rval;
}

/// DFT performs a forward or inverse Discrete Fourier Transform (DFT)
/// of a 1D or 2D floating-point array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadd6cf9baf2b8b704a11b5f04aaf4f39d
Mat dft(InputArray src, {OutputArray? dst, int flags = 0, int nonzeroRows = 0}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_dft(src.ref, dst!.ref, flags, nonzeroRows, ffi.nullptr));
  return dst;
}

/// Divide performs the per-element division
/// on two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6db555d30115642fedae0cda05604874
Mat divide(InputArray src1, InputArray src2, {OutputArray? dst, double scale = 1, int dtype = -1}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_divide(src1.ref, src2.ref, dst!.ref, scale, dtype, ffi.nullptr));
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
  final p = calloc<ffi.Bool>();
  cvRun(() => ccore.cv_eigen(src.ref, eigenvalues!.ref, eigenvectors!.ref, p, ffi.nullptr));
  final ret = p.value;
  calloc.free(p);
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
  cvRun(() => ccore.cv_eigenNonSymmetric(src.ref, eigenvalues!.ref, eigenvectors!.ref, ffi.nullptr));
  return (eigenvalues, eigenvectors);
}

/// Exp calculates the exponent of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3e10108e2162c338f1b848af619f39e5
Mat exp(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_exp(src.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// ExtractChannel extracts a single channel from src (coi is 0-based index).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc6158574aa1f0281878c955bcf35642
Mat extractChannel(InputArray src, int coi, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_extractChannel(src.ref, dst!.ref, coi, ffi.nullptr));
  return dst;
}

/// FindNonZero returns the list of locations of non-zero pixels.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaed7df59a3539b4cc0fe5c9c8d7586190
Mat findNonZero(InputArray src, {OutputArray? idx}) {
  idx ??= Mat.empty();
  cvRun(() => ccore.cv_findNonZero(src.ref, idx!.ref, ffi.nullptr));
  return idx;
}

/// Flip flips a 2D array around horizontal(0), vertical(1), or both axes(-1).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaca7be533e3dac7feb70fc60635adf441
Mat flip(InputArray src, int flipCode, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_flip(src.ref, dst!.ref, flipCode, ffi.nullptr));
  return dst;
}

Mat flipND(InputArray src, int axis, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_flipND(src.ref, dst!.ref, axis, ffi.nullptr));
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
  cvRun(() => ccore.cv_gemm(src1.ref, src2.ref, alpha, src3.ref, beta, dst!.ref, flags, ffi.nullptr));
  return dst;
}

/// GetOptimalDFTSize returns the optimal Discrete Fourier Transform (DFT) size
/// for a given vector size.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6577a2e59968936ae02eb2edde5de299
int getOptimalDFTSize(int vecsize) {
  final p = calloc<ffi.Int>();
  cvRun(() => ccore.cv_getOptimalDFTSize(vecsize, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return rval;
}

/// Checks for the presence of at least one non-zero array element.
///
/// The function returns whether there are non-zero elements in src
///
/// The function do not work with multi-channel arrays. If you need to check non-zero array
/// elements across all the channels, use Mat::reshape first to reinterpret the array
/// as single-channel. Or you may extract the particular channel using either
/// extractImageCOI, or mixChannels, or split.
bool hasNonZero(InputArray src) {
  final p = calloc<ffi.Bool>();
  cvRun(() => ccore.cv_hasNonZero(src.ref, p));
  final rval = p.value;
  calloc.free(p);
  return rval;
}

/// Hconcat applies horizontal concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaab5ceee39e0580f879df645a872c6bf7
Mat hconcat(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_hconcat(src1.ref, src2.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// IDCT calculates the inverse Discrete Cosine Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga77b168d84e564c50228b69730a227ef2
Mat idct(InputArray src, {OutputArray? dst, int flags = 0}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_idct(src.ref, dst!.ref, flags, ffi.nullptr));
  return dst;
}

/// IDFT calculates the inverse Discrete Fourier Transform of a 1D or 2D array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa708aa2d2e57a508f968eb0f69aa5ff1
Mat idft(InputArray src, {OutputArray? dst, int flags = 0, int nonzeroRows = 0}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_idft(src.ref, dst!.ref, flags, nonzeroRows, ffi.nullptr));
  return dst;
}

/// InRange checks if array elements lie between the elements of two Mat arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Mat inRange(InputArray src, InputArray lowerb, InputArray upperb, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_inRange(src.ref, lowerb.ref, upperb.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// InRangeWithScalar checks if array elements lie between the elements of two Scalars
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga48af0ab51e36436c5d04340e036ce981
Mat inRangebyScalar(InputArray src, Scalar lowerb, Scalar upperb, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_inRange_1(src.ref, lowerb.ref, upperb.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// InsertChannel inserts a single channel to dst (coi is 0-based index)
/// (it replaces channel i with another in dst).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1d4bd886d35b00ec0b764cb4ce6eb515
Mat insertChannel(InputArray src, InputOutputArray dst, int coi) {
  cvRun(() => ccore.cv_insertChannel(src.ref, dst.ref, coi, ffi.nullptr));
  return dst;
}

/// Invert finds the inverse or pseudo-inverse of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad278044679d4ecf20f7622cc151aaaa2
(double rval, Mat dst) invert(InputArray src, {OutputArray? dst, int flags = DECOMP_LU}) {
  dst ??= Mat.empty();
  final p = calloc<ffi.Double>();
  cvRun(() => ccore.cv_invert(src.ref, dst!.ref, flags, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return (rval, dst);
}

/// Log calculates the natural logarithm of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga937ecdce4679a77168730830a955bea7
Mat log(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_log(src.ref, dst!.ref, ffi.nullptr));
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
  cvRun(() => ccore.cv_LUT(src.ref, lut.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Magnitude calculates the magnitude of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6d3b097586bca4409873d64a90fe64c3
Mat magnitude(InputArray x, InputArray y, {OutputArray? magnitude}) {
  magnitude ??= Mat.empty();
  cvRun(() => ccore.cv_magnitude(x.ref, y.ref, magnitude!.ref, ffi.nullptr));
  return magnitude;
}

/// Max calculates per-element maximum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gacc40fa15eac0fb83f8ca70b7cc0b588d
Mat max(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_max(src1.ref, src2.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// mean
Scalar mean(InputArray src, {InputArray? mask}) {
  final p = calloc<cvg.Scalar>();
  mask == null
      ? cvRun(() => ccore.cv_mean(src.ref, p, ffi.nullptr))
      : cvRun(() => ccore.cv_mean_1(src.ref, mask.ref, p, ffi.nullptr));
  return Scalar.fromPointer(p);
}

/// MeanStdDev calculates a mean and standard deviation of array elements.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga846c858f4004d59493d7c6a4354b301d
(Scalar mean, Scalar stddev) meanStdDev(InputArray src, {InputArray? mask}) {
  final mean = calloc<cvg.Scalar>();
  final stddev = calloc<cvg.Scalar>();
  mask == null
      ? cvRun(() => ccore.cv_meanStdDev(src.ref, mean, stddev, ffi.nullptr))
      : cvRun(() => ccore.cv_meanStdDev_1(src.ref, mean, stddev, mask.ref, ffi.nullptr));
  return (Scalar.fromPointer(mean), Scalar.fromPointer(stddev));
}

/// Merge creates one multi-channel array out of several single-channel ones.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7d7b4d6c6ee504b30a20b1680029c7b4
Mat merge(VecMat mv, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_merge(mv.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Min calculates per-element minimum of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9af368f182ee76d0463d0d8d5330b764
Mat min(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_min(src1.ref, src2.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// MinMaxIdx finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7622c466c628a75d9ed008b42250a73f
(double minVal, double maxVal, int minIdx, int maxIdx) minMaxIdx(InputArray src, {InputArray? mask}) {
  mask ??= Mat.empty();
  final minValP = calloc<ffi.Double>();
  final maxValP = calloc<ffi.Double>();
  final minIdxP = calloc<ffi.Int>();
  final maxIdxP = calloc<ffi.Int>();
  cvRun(() => ccore.cv_minMaxIdx(src.ref, minValP, maxValP, minIdxP, maxIdxP, mask!.ref, ffi.nullptr));
  final rval = (minValP.value, maxValP.value, minIdxP.value, maxIdxP.value);
  calloc.free(minValP);
  calloc.free(maxValP);
  calloc.free(minIdxP);
  calloc.free(maxIdxP);
  return rval;
}

/// MinMaxLoc finds the global minimum and maximum in an array.
///
/// For further details, please see:
/// https://docs.opencv.org/trunk/d2/de8/group__core__array.html#gab473bf2eb6d14ff97e89b355dac20707
(double minVal, double maxVal, Point minLoc, Point maxLoc) minMaxLoc(InputArray src, {InputArray? mask}) {
  mask ??= Mat.empty();
  final minValP = calloc<ffi.Double>();
  final maxValP = calloc<ffi.Double>();
  final minLocP = calloc<cvg.CvPoint>();
  final maxLocP = calloc<cvg.CvPoint>();
  cvRun(() => ccore.cv_minMaxLoc(src.ref, minValP, maxValP, minLocP, maxLocP, mask!.ref, ffi.nullptr));
  final rval = (minValP.value, maxValP.value, Point.fromPointer(minLocP), Point.fromPointer(maxLocP));
  calloc.free(minValP);
  calloc.free(maxValP);
  return rval;
}

/// Copies specified channels from input arrays to the specified channels of output arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga51d768c270a1cdd3497255017c4504be
VecMat mixChannels(VecMat src, VecMat dst, VecI32 fromTo) {
  cvRun(() => ccore.cv_mixChannels(src.ref, dst.ref, fromTo.ref, ffi.nullptr));
  return dst;
}

/// Mulspectrums performs the per-element multiplication of two Fourier spectrums.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3ab38646463c59bf0ce962a9d51db64f
Mat mulSpectrums(InputArray a, InputArray b, int flags, {OutputArray? c, bool conjB = false}) {
  c ??= Mat.empty();
  cvRun(() => ccore.cv_mulSpectrums(a.ref, b.ref, c!.ref, flags, conjB, ffi.nullptr));
  return c;
}

/// Multiply calculates the per-element scaled product of two arrays.
/// Both input arrays must be of the same size and the same type.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga979d898a58d7f61c53003e162e7ad89f
Mat multiply(InputArray src1, InputArray src2, {OutputArray? dst, double scale = 1, int dtype = -1}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_multiply(src1.ref, src2.ref, dst!.ref, scale, dtype, ffi.nullptr));
  return dst;
}

/// mulTransposed
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gadc4e49f8f7a155044e3be1b9e3b270ab
Mat mulTransposed(
  InputArray src,
  OutputArray dst,
  bool aTa, {
  InputArray? delta,
  double scale = 1,
  int dtype = -1,
}) {
  delta ??= Mat.empty();
  cvRun(() => ccore.cv_mulTransposed(src.ref, dst.ref, aTa, delta!.ref, scale, dtype, ffi.nullptr));
  return dst;
}

/// Norm calculates the absolute norm of an array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
double norm(InputArray src1, {int normType = NORM_L2, InputArray? mask}) {
  mask ??= Mat.empty();
  final p = calloc<ffi.Double>();
  cvRun(() => ccore.cv_norm(src1.ref, normType, mask!.ref, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return rval;
}

/// Norm calculates the absolute difference/relative norm of two arrays.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga7c331fb8dd951707e184ef4e3f21dd33
double norm1(InputArray src1, InputArray src2, {int normType = NORM_L2, InputArray? mask}) {
  final p = calloc<ffi.Double>();
  mask ??= Mat.empty();
  cvRun(() => ccore.cv_norm_1(src1.ref, src2.ref, normType, mask!.ref, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return rval;
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
  int dtype = -1,
  InputArray? mask,
}) {
  mask ??= Mat.empty();
  cvRun(() => ccore.cv_normalize(src.ref, dst.ref, alpha, beta, normType, dtype, mask!.ref, ffi.nullptr));
  return dst;
}

/// patchNaNs
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga62286befb7cde3568ff8c7d14d5079da
Mat patchNaNs(InputArray a, double val) {
  cvRun(() => ccore.cv_patchNaNs(a.ref, val, ffi.nullptr));
  return a;
}

/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gab26049f30ee8e94f7d69d82c124faafc
Mat PCABackProject(InputArray data, InputArray mean, InputArray eigenvectors, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_PCABackProject(data.ref, mean.ref, eigenvectors.ref, dst!.ref, ffi.nullptr));
  return dst;
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
  cvRun(
    () => ccore.cv_PCACompute(
      data.ref,
      mean.ref,
      eigenvectors!.ref,
      eigenvalues!.ref,
      maxComponents,
      ffi.nullptr,
    ),
  );
  return (mean, eigenvalues, eigenvectors);
}

(Mat mean, Mat eigenvalues, Mat eigenvectors) PCACompute1(
  InputArray data,
  InputOutputArray mean,
  double retainedVariance, {
  OutputArray? eigenvectors,
  OutputArray? eigenvalues,
}) {
  eigenvectors ??= Mat.empty();
  eigenvalues ??= Mat.empty();
  cvRun(
    () => ccore.cv_PCACompute_1(
      data.ref,
      mean.ref,
      eigenvectors!.ref,
      eigenvalues!.ref,
      retainedVariance,
      ffi.nullptr,
    ),
  );
  return (mean, eigenvalues, eigenvectors);
}

(Mat mean, Mat result) PCAProject(Mat data, Mat mean, Mat eigenvectors, {OutputArray? result}) {
  result ??= Mat.empty();
  cvRun(() => ccore.cv_PCAProject(data.ref, mean.ref, eigenvectors.ref, result!.ref, ffi.nullptr));
  return (mean, result);
}

/// PerspectiveTransform performs the perspective matrix transformation of vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gad327659ac03e5fd6894b90025e6900a7
Mat perspectiveTransform(InputArray src, InputArray m, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_perspectiveTransform(src.ref, dst!.ref, m.ref, ffi.nullptr));
  return dst;
}

/// Phase calculates the rotation angle of 2D vectors.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9db9ca9b4d81c3bde5677b8f64dc0137
Mat phase(InputArray x, InputArray y, {OutputArray? angle, bool angleInDegrees = false}) {
  angle ??= Mat.empty();
  cvRun(() => ccore.cv_phase(x.ref, y.ref, angle!.ref, angleInDegrees, ffi.nullptr));
  return angle;
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
  cvRun(() => ccore.cv_polarToCart(magnitude.ref, angle.ref, x!.ref, y!.ref, angleInDegrees, ffi.nullptr));
  return (x, y);
}

/// Pow raises every array element to a power.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaf0d056b5bd1dc92500d6f6cf6bac41ef
Mat pow(InputArray src, double power, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_pow(src.ref, power, dst!.ref, ffi.nullptr));
  return dst;
}

/// Computes the Peak Signal-to-Noise Ratio (PSNR) image quality metric.
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga3119e3ea73010a6f810bb05aa36ac8d6
double PSNR(InputArray src1, InputArray src2, {double R = 255.0}) {
  final p = calloc<ffi.Double>();
  cvRun(() => ccore.cv_PSNR(src1.ref, src2.ref, R, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return rval;
}

/// RandN Fills the array with normally distributed random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeff1f61e972d133a04ce3a5f81cf6808
Mat randn(InputOutputArray dst, Scalar mean, Scalar stddev) {
  cvRun(() => ccore.cv_randn(dst.ref, mean.ref, stddev.ref, ffi.nullptr));
  return dst;
}

/// RandShuffle Shuffles the array elements randomly.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga6a789c8a5cb56c6dd62506179808f763
Mat randShuffle(InputOutputArray dst, {double iterFactor = 1, Rng? rng}) {
  if (rng == null) {
    cvRun(() => ccore.cv_randShuffle(dst.ref, ffi.nullptr));
  } else {
    cvRun(() => ccore.cv_randShuffle_1(dst.ref, iterFactor, rng.ref, ffi.nullptr));
  }
  return dst;
}

/// RandU Generates a single uniformly-distributed random
/// number or an array of random numbers.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1ba1026dca0807b27057ba6a49d258c0
Mat randu(InputOutputArray dst, Scalar low, Scalar high) {
  cvRun(() => ccore.cv_randu(dst.ref, low.ref, high.ref, ffi.nullptr));
  return dst;
}

/// Reduce reduces a matrix to a vector.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4b78072a303f29d9031d56e5638da78e
Mat reduce(InputArray src, int dim, int rtype, {OutputArray? dst, int dtype = -1}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_reduce(src.ref, dst!.ref, dim, rtype, dtype, ffi.nullptr));
  return dst;
}

/// Finds indices of max elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa87ea34d99bcc5bf9695048355163da0
Mat reduceArgMax(InputArray src, int axis, {OutputArray? dst, bool lastIndex = false}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_reduceArgMax(src.ref, dst!.ref, axis, lastIndex, ffi.nullptr));
  return dst;
}

/// Finds indices of min elements along provided axis.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaeecd548276bfb91b938989e66b722088
Mat reduceArgMin(InputArray src, int axis, {OutputArray? dst, bool lastIndex = false}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_reduceArgMin(src.ref, dst!.ref, axis, lastIndex, ffi.nullptr));
  return dst;
}

/// Repeat fills the output array with repeated copies of the input array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga496c3860f3ac44c40b48811333cfda2d
Mat repeat(InputArray src, int ny, int nx, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_repeat(src.ref, ny, nx, dst!.ref, ffi.nullptr));
  return dst;
}

/// Rotate rotates a 2D array in multiples of 90 degrees
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga4ad01c0978b0ce64baa246811deeac24
Mat rotate(InputArray src, int rotateCode, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_rotate(src.ref, dst!.ref, rotateCode, ffi.nullptr));
  return dst;
}

/// Calculates the sum of a scaled array and another array.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga9e0845db4135f55dcf20227402f00d98
Mat scaleAdd(InputArray src1, double alpha, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_scaleAdd(src1.ref, alpha, src2.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// SetIdentity initializes a scaled identity matrix.
/// For further details, please see:
///
///	https://docs.opencv.org/master/d2/de8/group__core__array.html#ga388d7575224a4a277ceb98ccaa327c99
Mat setIdentity(InputOutputArray mtx, {Scalar? s}) {
  s ??= Scalar.all(1.0);
  cvRun(() => ccore.cv_setIdentity(mtx.ref, s!.ref, ffi.nullptr));
  return mtx;
}

/// Solve solves one or more linear systems or least-squares problems.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga12b43690dbd31fed96f213eefead2373
(bool ret, Mat dst) solve(InputArray src1, InputArray src2, {OutputArray? dst, int flags = DECOMP_LU}) {
  dst ??= Mat.empty();
  final p = calloc<ffi.Bool>();
  cvRun(() => ccore.cv_solve(src1.ref, src2.ref, dst!.ref, flags, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return (rval, dst);
}

/// SolveCubic finds the real roots of a cubic equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga1c3b0b925b085b6e96931ee309e6a1da
(int rval, Mat roots) solveCubic(InputArray coeffs, {OutputArray? roots}) {
  roots ??= Mat.empty();
  final p = calloc<ffi.Int>();
  cvRun(() => ccore.cv_solveCubic(coeffs.ref, roots!.ref, p, ffi.nullptr));
  final rval = p.value;
  return (rval, roots);
}

/// SolvePoly finds the real or complex roots of a polynomial equation.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gac2f5e953016fabcdf793d762f4ec5dce
(double rval, Mat roots) solvePoly(InputArray coeffs, {OutputArray? roots, int maxIters = 300}) {
  roots ??= Mat.empty();
  final p = calloc<ffi.Double>();
  cvRun(() => ccore.cv_solvePoly(coeffs.ref, roots!.ref, maxIters, p, ffi.nullptr));
  final rval = p.value;
  calloc.free(p);
  return (rval, roots);
}

/// Sort sorts each row or each column of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga45dd56da289494ce874be2324856898f
Mat sort(InputArray src, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_sort(src.ref, dst!.ref, flags, ffi.nullptr));
  return dst;
}

/// SortIdx sorts each row or each column of a matrix.
/// Instead of reordering the elements themselves, it stores the indices of sorted elements in the output array
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gadf35157cbf97f3cb85a545380e383506
Mat sortIdx(InputArray src, int flags, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_sortIdx(src.ref, dst!.ref, flags, ffi.nullptr));
  return dst;
}

/// Split creates an array of single channel images from a multi-channel image
/// Created images should be closed manualy to avoid memory leaks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga0547c7fed86152d7e9d0096029c8518a
VecMat split(InputArray m) {
  final vec = VecMat();
  cvRun(() => ccore.cv_split(m.ref, vec.ptr, ffi.nullptr));
  return vec;
}

/// Calculates a square root of array elements.
///
/// The function cv::sqrt calculates a square root of each input array element.
/// In case of multi-channel arrays, each channel is processed independently.
/// The accuracy is approximately the same as of the built-in std::sqrt .
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga186222c3919657890f88df5a1f64a7d7
Mat sqrt(Mat src, {Mat? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_sqrt(src.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Subtract calculates the per-element subtraction of two arrays or an array and a scalar.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#gaa0f00d98b4b5edeaeb7b8333b2de353b
Mat subtract(InputArray src1, InputArray src2, {OutputArray? dst, InputArray? mask, int dtype = -1}) {
  dst ??= Mat.empty();
  mask ??= Mat.empty();
  cvRun(() => ccore.cv_subtract(src1.ref, src2.ref, dst!.ref, mask!.ref, dtype, ffi.nullptr));
  return dst;
}

/// Calculates the sum of array elements.
///
/// The function cv::sum calculates and returns the sum of array elements,
/// independently for each channel.
///
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#ga716e10a2dd9e228e4d3c95818f106722
Scalar sum(Mat src) {
  final p = calloc<cvg.Scalar>();
  cvRun(() => ccore.cv_sum(src.ref, p, ffi.nullptr));
  return Scalar.fromPointer(p);
}

/// SVBackSubst
Mat SVBackSubst(InputArray w, InputArray u, InputArray vh, InputArray rhs, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_SVBackSubst(w.ref, u.ref, vh.ref, rhs.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// SVDecomp
(Mat w, Mat u, Mat vh) SVDecomp(
  InputArray src, {
  OutputArray? w,
  OutputArray? u,
  OutputArray? vt,
  int flags = 0,
}) {
  w ??= Mat.empty();
  u ??= Mat.empty();
  vt ??= Mat.empty();
  cvRun(() => ccore.cv_SVDecomp(src.ref, w!.ref, u!.ref, vt!.ref, flags, ffi.nullptr));
  return (w, u, vt);
}

/// Trace returns the trace of a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga3419ac19c7dcd2be4bd552a23e147dd8
Scalar trace(InputArray mtx) {
  final ptr = calloc<cvg.Scalar>();
  cvRun(() => ccore.cv_trace(mtx.ref, ptr, ffi.nullptr));
  return Scalar.fromPointer(ptr);
}

/// Transform performs the matrix transformation of every array element.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga393164aa54bb9169ce0a8cc44e08ff22
Mat transform(InputArray src, InputArray m, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_transform(src.ref, dst!.ref, m.ref, ffi.nullptr));
  return dst;
}

/// Transpose transposes a matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
Mat transpose(InputArray src, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_transpose(src.ref, dst!.ref, ffi.nullptr));
  return dst;
}

/// Transpose for n-dimensional matrices.
///
/// Input should be continuous single-channel matrix.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga46630ed6c0ea6254a35f447289bd7404
Mat transposeND(InputArray src, List<int> order, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_transposeND(src.ref, dst!.ref, order.i32.ref, ffi.nullptr));
  return dst;
}

/// TheRNG Returns the default random number generator.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d2/de8/group__core__array.html#ga75843061d150ad6564b5447e38e57722
/// Disabled: double free
Rng theRNG() {
  final p = calloc<cvg.RNG>();
  cvRun(() => ccore.cv_theRNG(p));
  return Rng.fromTheRng(p);
}

/// Vconcat applies vertical concatenation to given matrices.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d2/de8/group__core__array.html#gaad07cede730cdde64b90e987aad179b8
Mat vconcat(InputArray src1, InputArray src2, {OutputArray? dst}) {
  dst ??= Mat.empty();
  cvRun(() => ccore.cv_vconcat(src1.ref, src2.ref, dst!.ref, ffi.nullptr));
  return dst;
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
  final p = calloc<ffi.Double>();
  cvRun(
    () => ccore.cv_kmeans(
      data.ref,
      K,
      bestLabels.ref,
      TermCriteria.fromRecord(criteria).ref,
      attempts,
      flags,
      centers!.ref,
      p,
      ffi.nullptr,
    ),
  );
  final rval = p.value;
  calloc.free(p);
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
  final p = calloc<ffi.Double>();
  cvRun(
    () => ccore.cv_kmeans_points(
      pts.ref,
      K,
      bestLabels.ref,
      TermCriteria.fromRecord(criteria).ref,
      attempts,
      flags,
      centers!.ref,
      p,
      ffi.nullptr,
    ),
  );
  final rval = p.value;
  calloc.free(p);
  return (rval, bestLabels, centers);
}

/// GetTickCount returns the number of ticks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/de0/group__core__utils.html#gae73f58000611a1af25dd36d496bf4487
int getTickCount() => ccore.cv_getTickCount();

/// GetTickFrequency returns the number of ticks per second.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/de0/group__core__utils.html#ga705441a9ef01f47acdc55d87fbe5090c
double getTickFrequency() => ccore.cv_getTickFrequency();

/// Set the number of threads for OpenCV.
void setNumThreads(int n) => ccore.cv_setNumThreads(n);

/// Get the number of threads for OpenCV.
int getNumThreads() => ccore.cv_getNumThreads();

// OpenCL functions
/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#gad2e486ab8104a3b197001e27d54e2a95
bool haveAmdBlas() => ccore.cv_ocl_haveAmdBlas();

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#ga593387b5285a57ea03350b363c74c6cf
bool haveAmdFft() => ccore.cv_ocl_haveAmdFft();

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#gaf8716694664cb127e7928c335b97d217
bool haveOpenCL() => ccore.cv_ocl_haveOpenCL();

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#ga0744f1db6ed2ec8f8aa79a43449a4855
bool haveSVM() => ccore.cv_ocl_haveSVM();

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#gab747fa4efd88d3188f4ebcbc8a639c1e
void setUseOpenCL(bool flag) => ccore.cv_ocl_setUseOpenCL(flag);

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#ga7f2f248d37cfa3e1e4122249f7dc8c49
String typeToStr(int t) {
  final p = ccore.cv_ocl_typeToStr(t);
  return p.toDartString();
}

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#gadb3b41d4552e9db7887855e3a1b2af37
bool useOpenCL() => ccore.cv_ocl_useOpenCL();

/// https://docs.opencv.org/4.12.0/dc/d83/group__core__opencl.html#gaa3c1017cd44dcd6c739943f31bb8f248
String vecopTypeToStr(int t) {
  final p = ccore.cv_ocl_vecopTypeToStr(t);
  return p.toDartString();
}
