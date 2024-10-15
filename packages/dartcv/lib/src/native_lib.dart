// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
import 'dart:ffi' as ffi;
import 'dart:io';
import 'g/calib3d.g.dart' as calib3d;
import 'g/contrib.g.dart' as contrib;
import 'g/core.g.dart' as core;
import 'g/dnn.g.dart' as dnn;
import 'g/features2d.g.dart' as features2d;
import 'g/gapi.g.dart' as gapi;
import 'g/highgui.g.dart' as highgui;
import 'g/imgcodecs.g.dart' as imgcodecs;
import 'g/imgproc.g.dart' as imgproc;
import 'g/objdetect.g.dart' as objdetect;
import 'g/photo.g.dart' as photo;
import 'g/stitching.g.dart' as stitching;
// import 'g/types.g.dart' as types;
import 'g/video.g.dart' as video;
import 'g/videoio.g.dart' as videoio;

// load native library
ffi.DynamicLibrary loadNativeLibrary(String libName) {
  if (Platform.isIOS || Platform.isMacOS) return ffi.DynamicLibrary.process();
  final defaultLibPath = switch (Platform.operatingSystem) {
    "windows" => "$libName.dll",
    "linux" || "android" || "fuchsia" => "lib$libName.so",
    "macos" => "lib$libName.dylib",
    _ => throw UnsupportedError(
        "Platform ${Platform.operatingSystem} not supported",
      )
  };
  final libPath = Platform.environment["dartcv_core_LIB_PATH"] ?? defaultLibPath;
  return ffi.DynamicLibrary.open(libPath);
}

final ccalib3d = calib3d.CvNativeCalib3d(loadNativeLibrary("dartcv"));
final ccontrib = contrib.CvNativeContrib(loadNativeLibrary("dartcv"));
final ccore = core.CvNativeCore(loadNativeLibrary("dartcv"));
final cdnn = dnn.CvNativeDnn(loadNativeLibrary("dartcv"));
final cfeatures2d = features2d.CvNativeFeatures2d(loadNativeLibrary("dartcv"));
final cgapi = gapi.CvNativeGapi(loadNativeLibrary("dartcv"));
final chighgui = highgui.CvNativeHighgui(loadNativeLibrary("dartcv"));
final cimgcodecs = imgcodecs.CvNativeImgcodecs(loadNativeLibrary("dartcv"));
final cimgproc = imgproc.CvNativeImgproc(loadNativeLibrary("dartcv"));
final cobjdetect = objdetect.CvNativeObjdetect(loadNativeLibrary("dartcv"));
final cphoto = photo.CvNativePhoto(loadNativeLibrary("dartcv"));
final cstitching = stitching.CvNativeStitching(loadNativeLibrary("dartcv"));
final cvideo = video.CvNativeVideo(loadNativeLibrary("dartcv"));
final cvideoio = videoio.CvNativeVideoIO(loadNativeLibrary("dartcv"));
