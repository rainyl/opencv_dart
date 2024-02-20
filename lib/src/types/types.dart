library cv;

import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:w_common/disposable.dart';

import '../opencv.g.dart' as cvg;

const _libraryName = "opencv_dart";

/* fundamental constants */
const double CV_PI = 3.1415926535897932384626433832795;
const double CV_2PI = 6.283185307179586476925286766559;
const double CV_LOG2 = 0.69314718055994530941723212145818;

final _bindings = cvg.CvNative(loadNativeLibrary());

ffi.DynamicLibrary loadNativeLibrary() {
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open("lib$_libraryName.dll");
  } else if (Platform.isAndroid || Platform.isFuchsia || Platform.isLinux) {
    return ffi.DynamicLibrary.open("lib$_libraryName.so");
  } else {
    return ffi.DynamicLibrary.open("lib$_libraryName.dylib");
  }
}

typedef Size = ({int width, int height});

abstract class CvObject<T extends ffi.NativeType> implements ffi.Finalizable {
  CvObject(this._ptr);
  CvObject.fromPointer(this._ptr);
  ffi.Pointer<T> _ptr;
  ffi.Pointer<T> get ptr => _ptr;

  T toNative();
  T get ref;
}

// abstract class CvObject extends Disposable {
//   CvObject(this._ptr);
//   CvObject.fromPointer(this._ptr);

//   ffi.Pointer<ffi.NativeType> _ptr;
//   ffi.Pointer<ffi.NativeType> get ptr => _ptr;
//   bool _isDisposed = false;

//   ffi.NativeType toNative();

//   @override
//   Future<Null> dispose() {
//     if (!_isDisposed) calloc.free(_ptr);
//     return super.dispose();
//   }
// }

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
