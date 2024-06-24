library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../constants.g.dart';
import '../core/base.dart';
import '../core/error_code.dart';
import '../core/exception.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

/// IMRead reads an image from a file into a Mat.
/// The flags param is one of the IMReadFlag flags.
/// If the image cannot be read (because of missing file, improper permissions,
/// unsupported or invalid format), the function returns an empty Mat.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga288b8b3da0892bd651fce07b3bbd3a56
Mat imread(String filename, {int flags = IMREAD_COLOR}) {
  return cvRunArena<Mat>((arena) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Image_IMRead(filename.toNativeUtf8(allocator: arena).cast(), flags, p));
    return Mat.fromPointer(p);
  });
}

Future<Mat> imreadAsync(String filename, {int flags = IMREAD_COLOR}) async {
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  final rval = cvRunAsync((callback) => CFFI.Image_IMRead_Async(cname, flags, callback), matCompleter);
  calloc.free(cname);
  return rval;
}

/// IMWrite writes a Mat to an image file.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#gabbc7ef1aa2edfaa87772f1202d67e0ce
bool imwrite(String filename, InputArray img, {VecInt? params}) {
  return using<bool>((arena) {
    final fname = filename.toNativeUtf8(allocator: arena);
    final p = arena<ffi.Bool>();
    if (params == null) {
      cvRun(() => CFFI.Image_IMWrite(fname.cast(), img.ref, p));
    } else {
      cvRun(
        () => CFFI.Image_IMWrite_WithParams(
          fname.cast(),
          img.ref,
          params.ref,
          p,
        ),
      );
    }
    return p.value;
  });
}

Future<bool> imwriteAsync(String filename, InputArray img, {VecInt? params}) async {
  final cname = filename.toNativeUtf8().cast<ffi.Char>();
  final rval = cvRunAsync<bool>(
    (callback) => params == null
        ? CFFI.Image_IMWrite_Async(cname, img.ref, callback)
        : CFFI.Image_IMWrite_WithParams_Async(cname, img.ref, params.ref, callback),
    (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      return c.complete(rval);
    },
  );
  calloc.free(cname);
  return rval;
}

/// IMEncode encodes an image Mat into a memory buffer.
/// This function compresses the image and stores it in the returned memory buffer,
/// using the image format passed in in the form of a file extension string.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga461f9ac09887e47797a54567df3b8b63
Uint8List imencode(
  String ext,
  InputArray img, {
  VecInt? params,
}) {
  final buffer = calloc<cvg.VecUChar>();
  final success = calloc<ffi.Bool>();
  final cExt = ext.toNativeUtf8().cast<ffi.Char>();

  params == null
      ? cvRun(() => CFFI.Image_IMEncode(cExt, img.ref, success, buffer))
      : cvRun(() => CFFI.Image_IMEncode_WithParams(cExt, img.ref, params.ref, success, buffer));
  calloc.free(cExt);
  if (!success.value) {
    throw CvException(ErrorCode.StsError.code, msg: "imencode failed, check your params");
  }
  return VecUChar.fromPointer(buffer).toU8List();
}

Future<(bool, Uint8List)> imencodeAsync(
  String ext,
  InputArray img, {
  VecInt? params,
}) async {
  final cExt = ext.toNativeUtf8().cast<ffi.Char>();
  final rval = cvRunAsync2<(bool, Uint8List)>(
    (callback) => params == null
        ? CFFI.Image_IMEncode_Async(cExt, img.ref, callback)
        : CFFI.Image_IMEncode_WithParams_Async(cExt, img.ref, params.ref, callback),
    (c, p, p1) {
      final v = p.cast<ffi.Bool>().value;
      calloc.free(p);
      final vec = VecUChar.fromPointer(p1.cast());
      final data = vec.toU8List();
      vec.dispose();
      return c.complete((v, data));
    },
  );
  return rval;
}

/// imdecode reads an image from a buffer in memory.
/// The function imdecode reads an image from the specified buffer in memory.
/// If the buffer is too short or contains invalid data, the function
/// returns an empty matrix.
/// @param buf Input array or vector of bytes.
/// @param flags The same flags as in cv::imread, see cv::ImreadModes.
/// For further details, please see:
/// https://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga26a67788faa58ade337f8d28ba0eb19e
Mat imdecode(Uint8List buf, int flags, {Mat? dst}) {
  final vec = VecUChar.fromList(buf);
  dst ??= Mat.empty();
  cvRun(() => CFFI.Image_IMDecode(vec.ref, flags, dst!.ptr));
  return dst;
}

Future<Mat> imdecodeAsync(Uint8List buf, int flags) async {
  final vec = VecUChar.fromList(buf);
  final rval = cvRunAsync((callback) => CFFI.Image_IMDecode_Async(vec.ref, flags, callback), matCompleter);
  vec.dispose();
  return rval;
}
