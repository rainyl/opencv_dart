// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.imgcodecs;

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/constants.g.dart';
import '../native_lib.dart' show cimgcodecs;

/// Returns true if the specified image can be decoded by OpenCV.
///
/// https://docs.opencv.org/4.10.0/d4/da8/group__imgcodecs.html#ga65d3569d8845d1210e1aeab8c199031c
bool haveImageReader(String filename) {
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  final rval = cimgcodecs.cv_haveImageReader(cname);
  calloc.free(cname);
  return rval;
}

/// Returns true if an image with the specified filename can be encoded by OpenCV.
///
/// https://docs.opencv.org/4.10.0/d4/da8/group__imgcodecs.html#gac4fa9c4c32b58c55059752c0490d3f20
bool haveImageWriter(String filename) {
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  final rval = cimgcodecs.cv_haveImageWriter(cname);
  calloc.free(cname);
  return rval;
}

/// Returns the number of images inside the give file.
///
/// The function imcount will return the number of pages in a multi-page image, or 1 for single-page images
///
/// https://docs.opencv.org/4.10.0/d4/da8/group__imgcodecs.html#ga02237b2aad2d4ae41c9489a83781f202
int imcount(String filename, {int flags = IMREAD_ANYCOLOR}) {
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  final rval = cimgcodecs.cv_imcount(cname, flags);
  calloc.free(cname);
  return rval;
}

/// read an image from a file into a Mat.
/// The flags param is one of the IMReadFlag flags.
/// If the image cannot be read (because of missing file, improper permissions,
/// unsupported or invalid format), the function returns an empty Mat.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga288b8b3da0892bd651fce07b3bbd3a56
Mat imread(String filename, {int flags = IMREAD_COLOR}) {
  final dst = Mat.empty();
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => cimgcodecs.cv_imread(cname, flags, dst.ptr, ffi.nullptr));
  calloc.free(cname);
  return dst;
}

/// async version of [imread]
Future<Mat> imreadAsync(String filename, {int flags = IMREAD_COLOR}) async {
  final dst = Mat.empty();
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  return cvRunAsync0((callback) => cimgcodecs.cv_imread(cname, flags, dst.ptr, callback), (c) {
    calloc.free(cname);
    return c.complete(dst);
  });
}

/// write a Mat to an image file.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#gabbc7ef1aa2edfaa87772f1202d67e0ce
bool imwrite(String filename, InputArray img, {VecI32? params}) {
  final fname = filename.toNativeUtf8().cast<ffi.Char>();
  final p = calloc<ffi.Bool>();
  if (params == null) {
    cvRun(() => cimgcodecs.cv_imwrite(fname.cast(), img.ref, p, ffi.nullptr));
  } else {
    cvRun(() => cimgcodecs.cv_imwrite_1(fname.cast(), img.ref, params.ref, p, ffi.nullptr));
  }
  final rval = p.value;
  calloc.free(p);
  return rval;
}

/// async version of [imwrite]
Future<bool> imwriteAsync(String filename, InputArray img, {VecI32? params}) async {
  final fname = filename.toNativeUtf8().cast<ffi.Char>();
  final p = calloc<ffi.Bool>();
  void completeFunc(Completer<bool> c) {
    final rval = p.value;
    calloc.free(p);
    return c.complete(rval);
  }

  if (params == null) {
    return cvRunAsync0((callback) => cimgcodecs.cv_imwrite(fname.cast(), img.ref, p, callback), completeFunc);
  }
  return cvRunAsync0(
    (callback) => cimgcodecs.cv_imwrite_1(fname.cast(), img.ref, params.ref, p, callback),
    completeFunc,
  );
}

/// imencode encodes an image Mat into a memory buffer.
/// This function compresses the image and stores it in the returned memory buffer,
/// using the image format passed in in the form of a file extension string.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga461f9ac09887e47797a54567df3b8b63
(bool, Uint8List) imencode(String ext, InputArray img, {VecI32? params}) {
  final (success, vec) = imencodeVec(ext, img, params: params);
  final u8List = vec.toU8List(); // will copy data
  vec.dispose();
  return (success, u8List);
}

/// Same as [imencode] but returns [VecUChar]
(bool, VecUChar) imencodeVec(String ext, InputArray img, {VecI32? params}) {
  final buffer = VecUChar();
  final pSuccess = calloc<ffi.Bool>();
  final cExt = ext.toNativeUtf8().cast<ffi.Char>();

  params == null
      ? cvRun(() => cimgcodecs.cv_imencode(cExt, img.ref, pSuccess, buffer.ptr, ffi.nullptr))
      : cvRun(() => cimgcodecs.cv_imencode_1(cExt, img.ref, params.ref, pSuccess, buffer.ptr, ffi.nullptr));
  final success = pSuccess.value;
  calloc.free(cExt);
  calloc.free(pSuccess);

  return (success, buffer);
}

/// async version of [imencode]
Future<(bool, Uint8List)> imencodeAsync(String ext, InputArray img, {VecI32? params}) async {
  final buffer = VecUChar();
  final pSuccess = calloc<ffi.Bool>();
  final cExt = ext.toNativeUtf8().cast<ffi.Char>();

  void completeFunc(Completer<(bool, Uint8List)> c) {
    final success = pSuccess.value;
    calloc.free(cExt);
    calloc.free(pSuccess);

    final u8List = buffer.toU8List(); // will copy data
    buffer.dispose();
    return c.complete((success, u8List));
  }

  if (params == null) {
    return cvRunAsync0(
      (callback) => cimgcodecs.cv_imencode(cExt, img.ref, pSuccess, buffer.ptr, callback),
      completeFunc,
    );
  }
  return cvRunAsync0(
    (callback) => cimgcodecs.cv_imencode_1(cExt, img.ref, params.ref, pSuccess, buffer.ptr, callback),
    completeFunc,
  );
}

/// Same as [imencodeAsync] but returns [VecUChar]
Future<(bool, VecUChar)> imencodeVecAsync(String ext, InputArray img, {VecI32? params}) async {
  final buffer = VecUChar();
  final pSuccess = calloc<ffi.Bool>();
  final cExt = ext.toNativeUtf8().cast<ffi.Char>();

  void completeFunc(Completer<(bool, VecUChar)> c) {
    final success = pSuccess.value;
    calloc.free(cExt);
    calloc.free(pSuccess);

    return c.complete((success, buffer));
  }

  if (params == null) {
    return cvRunAsync0(
      (callback) => cimgcodecs.cv_imencode(cExt, img.ref, pSuccess, buffer.ptr, callback),
      completeFunc,
    );
  }
  return cvRunAsync0(
    (callback) => cimgcodecs.cv_imencode_1(cExt, img.ref, params.ref, pSuccess, buffer.ptr, callback),
    completeFunc,
  );
}

/// imdecode reads an image from a buffer in memory.
/// The function imdecode reads an image from the specified buffer in memory.
/// If the buffer is too short or contains invalid data, the function
/// returns an empty matrix.
/// @param buf Input array or vector of bytes.
/// @param flags The same flags as in cv::imread, see cv::ImreadModes.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga26a67788faa58ade337f8d28ba0eb19e
Mat imdecode(Uint8List buf, int flags, {Mat? dst}) {
  final vec = VecUChar.fromList(buf);
  return imdecodeVec(vec, flags, dst: dst);
}

/// Same as [imdecode] but accepts [VecUChar]
Mat imdecodeVec(VecUChar buf, int flags, {Mat? dst}) {
  dst ??= Mat.empty();
  cvRun(() => cimgcodecs.cv_imdecode(buf.ref, flags, dst!.ptr, ffi.nullptr));
  return dst;
}

/// async version of [imdecode]
Future<Mat> imdecodeAsync(Uint8List buf, int flags, {Mat? dst}) async {
  final vec = VecUChar.fromList(buf);
  return imdecodeVecAsync(vec, flags, dst: dst);
}

/// Same as [imdecodeAsync] but accepts [VecUChar]
Future<Mat> imdecodeVecAsync(VecUChar vec, int flags, {Mat? dst}) async {
  dst ??= Mat.empty();
  return cvRunAsync0((callback) => cimgcodecs.cv_imdecode(vec.ref, flags, dst!.ptr, callback), (c) {
    return c.complete(dst);
  });
}
