// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv;

import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import "../opencv.g.dart" show CvStatus, CvNative;
import "exception.dart" show CvException;

const _libraryName = "opencv_dart";

/* fundamental constants */
const double CV_PI = 3.1415926535897932384626433832795;
const double CV_2PI = 6.283185307179586476925286766559;
const double CV_LOG2 = 0.69314718055994530941723212145818;

const int CV_U8_MAX = 255; // uchar
const int CV_U8_MIN = 0;
const int CV_I8_MAX = 127; // schar
const int CV_I8_MIN = -128;
const int CV_U16_MAX = 65535; // ushort
const int CV_U16_MIN = 0;
const int CV_I16_MAX = 32767; // short
const int CV_I16_MIN = -32768;
const int CV_U32_MAX = 4294967295;
const int CV_U32_MIN = 0;
const int CV_I32_MAX = 2147483647; // int
const int CV_I32_MIN = -2147483648;
const double CV_F32_MAX = 3.4028234663852886e+38;
const double CV_F64_MAX = 1.7976931348623157e+308;

ffi.DynamicLibrary loadNativeLibrary() {
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open("$_libraryName.dll");
  } else if (Platform.isAndroid || Platform.isFuchsia || Platform.isLinux) {
    return ffi.DynamicLibrary.open("lib$_libraryName.so");
  } else if (Platform.isMacOS) {
    return ffi.DynamicLibrary.open("lib$_libraryName.dylib");
  } else if (Platform.isIOS) {
    return ffi.DynamicLibrary.process();
  } else {
    throw UnsupportedError("Platform ${Platform.operatingSystem} not supported");
  }
}

final CFFI = CvNative(loadNativeLibrary());

abstract class CvObject<T extends ffi.NativeType> implements ffi.Finalizable {}

abstract class ICvStruct<T extends ffi.Struct> extends CvObject<T> {
  ICvStruct.fromPointer(this.ptr);

  ffi.Pointer<T> ptr;
  T get ref;
}

abstract class CvStruct<T extends ffi.Struct> extends ICvStruct<T> with EquatableMixin {
  CvStruct.fromPointer(super.ptr) : super.fromPointer();
}

void cvRun(CvStatus Function() func) {
  final status = func();
  if (status.code != 0) {
    throw CvException(
      status.code,
      msg: status.msg.cast<Utf8>().toDartString(),
      file: status.file.cast<Utf8>().toDartString(),
      func: status.func.cast<Utf8>().toDartString(),
      line: status.line,
    );
  }
}

R cvRunArena<R>(R Function(Arena arena) computation,
    [Allocator wrappedAllocator = calloc, bool keep = false]) {
  final arena = Arena(wrappedAllocator);
  bool isAsync = false;
  try {
    final result = computation(arena);
    if (result is Future) {
      isAsync = true;
      return (result.whenComplete(arena.releaseAll) as R);
    }
    return result;
  } finally {
    if (!isAsync && !keep) {
      arena.releaseAll();
    }
  }
}

typedef NativeFinalizerFunctionT<T extends ffi.NativeType>
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(T token)>>;

ffi.NativeFinalizer OcvFinalizer<T extends ffi.NativeType>(NativeFinalizerFunctionT<T> func) =>
    ffi.NativeFinalizer(func.cast<ffi.NativeFinalizerFunction>());

typedef U8 = ffi.UnsignedChar;
typedef I8 = ffi.Char;
typedef U16 = ffi.UnsignedShort;
typedef I16 = ffi.Short;
// typedef U32 = ffi.UnsignedInt;
typedef I32 = ffi.Int;
typedef F32 = ffi.Float;
typedef F64 = ffi.Double;

extension PointerCharExtension on ffi.Pointer<ffi.Char>{
  String toDartString() => cast<Utf8>().toDartString();
}

enum ImageFormat {
  // Windows bitmaps - *.bmp, *.dib (always supported)
  bmp(ext: ".bmp"),
  dib(ext: ".dib"),
  // JPEG files - *.jpeg, *.jpg, *.jpe (see the Note section)
  jpg(ext: ".jpg"),
  jpeg(ext: ".jpeg"),
  jpe(ext: ".jpe"),
  // JPEG 2000 files - *.jp2 (see the Note section)
  jp2(ext: ".jp2"),
  // Portable Network Graphics - *.png (see the Note section)
  png(ext: ".png"),
  // WebP - *.webp (see the Note section)
  webp(ext: ".webp"),
  // Portable image format - *.pbm, *.pgm, *.ppm *.pxm, *.pnm (always supported)
  pbm(ext: ".pbm"),
  pgm(ext: ".pgm"),
  ppm(ext: ".ppm"),
  pxm(ext: ".pxm"),
  pnm(ext: ".pnm"),
  // Sun rasters - *.sr, *.ras (always supported)
  sr(ext: ".sr"),
  ras(ext: ".ras"),
  // TIFF files - *.tiff, *.tif (see the Note section)
  tiff(ext: ".tiff"),
  tif(ext: ".tif"),
  // OpenEXR Image files - *.exr (see the Note section)
  exr(ext: ".exr"),
  // Radiance HDR - *.hdr, *.pic (always supported)
  hdr(ext: ".hdr"),
  pic(ext: ".pic");
  // Raster and Vector geospatial data supported by GDAL (see the Note section)

  const ImageFormat({required this.ext});
  final String ext;
}
