// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.videoio;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/constants.g.dart';
import '../g/videoio.g.dart' as cvg;
import '../native_lib.dart' show cvideoio;

class VideoCapture extends CvStruct<cvg.VideoCapture> {
  VideoCapture._(cvg.VideoCapturePtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VideoCapture.fromPointer(cvg.VideoCapturePtr ptr) => VideoCapture._(ptr, false);

  factory VideoCapture.empty() {
    final p = calloc<cvg.VideoCapture>();
    cvRun(() => cvideoio.cv_VideoCapture_create(p));
    return VideoCapture._(p);
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a57c0e81e83e60f36c83027dc2a188e80
  factory VideoCapture.create(String filename, {int apiPreference = CAP_ANY}) {
    final p = calloc<cvg.VideoCapture>();
    final cname = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cvideoio.cv_VideoCapture_create_1(cname, apiPreference, p, ffi.nullptr));
    calloc.free(cname);
    return VideoCapture._(p);
  }

  factory VideoCapture.fromFile(String filename, {int apiPreference = CAP_ANY}) {
    return VideoCapture.create(filename, apiPreference: apiPreference);
  }

  factory VideoCapture.fromDevice(int device, {int apiPreference = CAP_ANY}) {
    final p = calloc<cvg.VideoCapture>();
    cvRun(() => cvideoio.cv_VideoCapture_create_2(device, apiPreference, p, ffi.nullptr));
    return VideoCapture._(p);
  }

  @override
  cvg.VideoCapture get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.VideoCapturePtr>(cvideoio.addresses.cv_VideoCapture_close);

  void dispose() {
    finalizer.detach(this);
    cvideoio.cv_VideoCapture_close(ptr);
  }

  /// Returns the specified [VideoCapture] property.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  double get(int propId) => cvideoio.cv_VideoCapture_get(ref, propId);

  void set(int prop, double value) => cvideoio.cv_VideoCapture_set(ref, prop, value);

  String getBackendName() {
    final p = cvideoio.cv_VideoCapture_getBackendName(ref);
    final name = p.toDartString();
    calloc.free(p);
    return name;
  }

  /// Returns true if video capturing has been initialized already.
  ///
  /// If the previous call to VideoCapture constructor or VideoCapture::open() succeeded, the method returns true.
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  bool get isOpened => cvideoio.cv_VideoCapture_isOpened(ref);

  /// Grabs the next frame from video file or capturing device.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  void grab() => cvideoio.cv_VideoCapture_grab(ref, ffi.nullptr);

  (bool, Mat) read({Mat? m}) {
    m ??= Mat.empty();
    final p = calloc<ffi.Bool>();
    cvRun(() => cvideoio.cv_VideoCapture_read(ref, m!.ref, p, ffi.nullptr));
    final rval = (p.value, m);
    calloc.free(p);
    return rval;
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference and parameters.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  bool open(String uri, {int apiPreference = CAP_ANY}) {
    final cname = uri.toNativeUtf8().cast<ffi.Char>();
    final success = calloc<ffi.Bool>();
    cvRun(() => cvideoio.cv_VideoCapture_open_1(ref, cname, apiPreference, success, ffi.nullptr));
    final rval = success.value;
    calloc.free(cname);
    calloc.free(success);
    return rval;
  }

  /// Opens a camera for video capturing with API Preference and parameters.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a10867868137c2d142aac30a0648d00fe
  bool openIndex(int index, {int apiPreference = CAP_ANY}) {
    final success = calloc<ffi.Bool>();
    cvRun(() => cvideoio.cv_VideoCapture_open_3(ref, index, apiPreference, success, ffi.nullptr));
    final rval = success.value;
    calloc.free(success);
    return rval;
  }

  String get codec {
    final cc = get(CAP_PROP_FOURCC).toInt();
    final res = [cc & 0XFF, (cc & 0XFF00) >> 8, (cc & 0XFF0000) >> 16, (cc & 0XFF000000) >> 24];
    return ascii.decode(res);
  }

  static double toCodec(String codec) {
    final codes = ascii.encode(codec);
    if (codes.length != 4) return -1;
    final c1 = codes[0];
    final c2 = codes[1];
    final c3 = codes[2];
    final c4 = codes[3];
    return ((c1 & 255) + ((c2 & 255) << 8) + ((c3 & 255) << 16) + ((c4 & 255) << 24)).toDouble();
  }

  void release() {
    cvRun(() => cvideoio.cv_VideoCapture_release(ref));
  }
}

class VideoWriter extends CvStruct<cvg.VideoWriter> {
  VideoWriter._(cvg.VideoWriterPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VideoWriter.fromPointer(cvg.VideoWriterPtr ptr) => VideoWriter._(ptr, false);

  factory VideoWriter.empty() {
    final p = calloc<cvg.VideoWriter>();
    cvRun(() => cvideoio.cv_VideoWriter_create(p));
    return VideoWriter._(p);
  }

  factory VideoWriter.fromFile(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    int? apiPreference,
    bool isColor = true,
  }) {
    final p = calloc<cvg.VideoWriter>();
    final cname = filename.toNativeUtf8();
    final codec_ = VideoWriter.fourcc(codec);
    apiPreference == null
        ? cvRun(
            () => cvideoio.cv_VideoWriter_create_1(
              cname.cast(),
              codec_,
              fps,
              frameSize.$1,
              frameSize.$2,
              isColor,
              p,
              ffi.nullptr,
            ),
          )
        : cvRun(
            () => cvideoio.cv_VideoWriter_create_2(
              cname.cast(),
              apiPreference,
              codec_,
              fps,
              frameSize.$1,
              frameSize.$2,
              isColor,
              p,
              ffi.nullptr,
            ),
          );
    calloc.free(cname);
    return VideoWriter._(p);
  }

  void open(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    int? apiPreference,
    bool isColor = true,
  }) {
    final cname = filename.toNativeUtf8();
    final codec_ = VideoWriter.fourcc(codec);
    apiPreference == null
        ? cvRun(
            () => cvideoio.cv_VideoWriter_open(
              ref,
              cname.cast(),
              codec_,
              fps,
              frameSize.$1,
              frameSize.$2,
              isColor,
              ffi.nullptr,
            ),
          )
        : cvRun(
            () => cvideoio.cv_VideoWriter_open_1(
              ref,
              cname.cast(),
              apiPreference,
              codec_,
              fps,
              frameSize.$1,
              frameSize.$2,
              isColor,
              ffi.nullptr,
            ),
          );
    calloc.free(cname);
  }

  void write(InputArray image) {
    cvRun(() => cvideoio.cv_VideoWriter_write(ref, image.ref, ffi.nullptr));
  }

  static int fourcc(String cc) {
    final cc_ = ascii.encode(cc);
    if (cc_.length != 4) return -1;
    return cvideoio.cv_VideoWriter_fourcc(cc_[0], cc_[1], cc_[2], cc_[3]);
  }

  void release() {
    cvRun(() => cvideoio.cv_VideoWriter_release(ref));
  }

  @override
  cvg.VideoWriter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.VideoWriterPtr>(cvideoio.addresses.cv_VideoWriter_close);

  void dispose() {
    finalizer.detach(this);
    cvideoio.cv_VideoWriter_close(ptr);
  }

  bool get isOpened => cvideoio.cv_VideoWriter_isOpened(ref);
}
