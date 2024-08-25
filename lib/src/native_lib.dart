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
import 'g/video_io.g.dart' as video_io;

const _libraryName = "opencv_dart";

// load native library
ffi.DynamicLibrary loadNativeLibrary() {
  if (Platform.isIOS) return ffi.DynamicLibrary.process();
  final defaultLibPath = switch (Platform.operatingSystem) {
    "windows" => "$_libraryName.dll",
    "linux" || "android" || "fuchsia" => "lib$_libraryName.so",
    "macos" => "lib$_libraryName.dylib",
    _ => throw UnsupportedError(
        "Platform ${Platform.operatingSystem} not supported",
      )
  };
  final libPath = Platform.environment["OPENCV_DART_LIB_PATH"] ?? defaultLibPath;
  return ffi.DynamicLibrary.open(libPath);
}

final ccalib3d = calib3d.CvNativeCalib3d(loadNativeLibrary());
final ccontrib = contrib.CvNativeContrib(loadNativeLibrary());
final ccore = core.CvNativeCore(loadNativeLibrary());
final cdnn = dnn.CvNativeDnn(loadNativeLibrary());
final cfeatures2d = features2d.CvNativeFeatures2d(loadNativeLibrary());
final cgapi = gapi.CvNativeGapi(loadNativeLibrary());
final chighgui = highgui.CvNativeHighgui(loadNativeLibrary());
final cimgcodecs = imgcodecs.CvNativeImgcodecs(loadNativeLibrary());
final cimgproc = imgproc.CvNativeImgproc(loadNativeLibrary());
final cobjdetect = objdetect.CvNativeObjdetect(loadNativeLibrary());
final cphoto = photo.CvNativePhoto(loadNativeLibrary());
final cstitching = stitching.CvNativeStitching(loadNativeLibrary());
final cvideo = video_io.CvNativeVideoIO(loadNativeLibrary());
