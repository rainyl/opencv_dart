library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../types/types.dart';
import '../types/mat.dart';
import '../types/extensions.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

// IMRead reads an image from a file into a Mat.
// The flags param is one of the IMReadFlag flags.
// If the image cannot be read (because of missing file, improper permissions,
// unsupported or invalid format), the function returns an empty Mat.
//
// For further details, please see:
// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga288b8b3da0892bd651fce07b3bbd3a56
Mat imread(String filename, {int flags = IMREAD_COLOR}) {
  final name_ptr = filename.toNativeUtf8();
  final mat = _bindings.Image_IMRead(name_ptr.cast(), flags);
  calloc.free(name_ptr);
  return Mat.fromCMat(mat);
}

// IMWrite writes a Mat to an image file.
//
// For further details, please see:
// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#gabbc7ef1aa2edfaa87772f1202d67e0ce
bool imwrite(String filename, InputArray img, {List<int>? params}) {
  bool isSuccess = false;
  if (params == null) {
    isSuccess =
        _bindings.Image_IMWrite(filename.toNativeUtf8().cast(), img.ptr);
  } else {
    using((arena) {
      final fname = filename.toNativeUtf8();
      isSuccess = _bindings.Image_IMWrite_WithParams(
        fname.cast(),
        img.ptr,
        params.toNativeVector(arena).ref,
      );
      calloc.free(fname);
    });
  }
  return isSuccess;
}

// IMEncode encodes an image Mat into a memory buffer.
// This function compresses the image and stores it in the returned memory buffer,
// using the image format passed in in the form of a file extension string.
//
// For further details, please see:
// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga461f9ac09887e47797a54567df3b8b63
Uint8List imencode(
  String ext,
  InputArray img, {
  List<int>? params,
}) {
  final buffer = _bindings.UCharVector_New();

  if (params == null) {
    _bindings.Image_IMEncode(ext.toNativeUtf8().cast(), img.ptr, buffer);
  } else {
    using((arena) {
      final ptr = ext.toNativeUtf8();
      _bindings.Image_IMEncode_WithParams(
        ptr.cast(),
        img.ptr,
        params.toNativeVector(arena).ref,
        buffer,
      );
      calloc.free(ptr);
    });
  }

  final length = _bindings.UCharVector_Size(buffer);

  final buf = Uint8List(length);
  for (var i = 0; i < length; i++) {
    buf[i] = _bindings.UCharVector_At(buffer, i);
  }
  _bindings.UCharVector_Free(buffer);

  return buf;
}

// IMDecode reads an image from a buffer in memory.
// The function IMDecode reads an image from the specified buffer in memory.
// If the buffer is too short or contains invalid data, the function
// returns an empty matrix.
// @param buf Input array or vector of bytes.
// @param flags The same flags as in cv::imread, see cv::ImreadModes.
// For further details, please see:
// https://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga26a67788faa58ade337f8d28ba0eb19e
Mat imdecode(Uint8List buf, int flags, {Mat? dst}) {
  final buffer = _bindings.UCharVector_New();
  for (var i = 0; i < buf.length; i++) {
    _bindings.UCharVector_Append(buffer, buf[i]);
  }
  if (dst == null) {
    final mat = _bindings.Image_IMDecode(buffer, flags);
    final cvimgDecode = Mat.fromCMat(mat);
    _bindings.UCharVector_Free(buffer);
    return cvimgDecode;
  } else {
    _bindings.Image_IMDecodeIntoMat(buffer, flags, dst.ptr);
    _bindings.UCharVector_Free(buffer);
    return dst;
  }
}
