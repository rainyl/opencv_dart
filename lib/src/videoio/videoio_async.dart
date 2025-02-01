// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.videoio;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/constants.g.dart';
import '../g/videoio.g.dart' as cvg;
import '../g/videoio.g.dart' as cvideoio;
import 'videoio.dart';

extension VideoCaptureAsync on VideoCapture {
  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a57c0e81e83e60f36c83027dc2a188e80
  static Future<VideoCapture> fromFileAsync(String filename, {int apiPreference = CAP_ANY}) async {
    final p = calloc<cvg.VideoCapture>();
    final cname = filename.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_create_1(cname, apiPreference, p, callback),
      (c) {
        calloc.free(cname);
        return c.complete(VideoCapture.fromPointer(p));
      },
    );
  }

  static Future<VideoCapture> fromDeviceAsync(int device, {int apiPreference = CAP_ANY}) async {
    final p = calloc<cvg.VideoCapture>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_create_2(device, apiPreference, p, callback),
      (c) {
        return c.complete(VideoCapture.fromPointer(p));
      },
    );
  }

  /// Grabs the next frame from video file or capturing device.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  Future<void> grabAsync() => cvRunAsync0(
        (callback) => cvideoio.cv_VideoCapture_grab(ref, callback),
        (c) => c.complete(),
      );

  Future<(bool, Mat)> readAsync({Mat? m}) async {
    m ??= Mat.empty();
    final p = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_read(ref, m!.ref, p, callback),
      (c) {
        final rval = (p.value, m!);
        calloc.free(p);
        return c.complete(rval);
      },
    );
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference and parameters.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  Future<bool> openAsync(String uri, {int apiPreference = CAP_ANY}) async {
    final cname = uri.toNativeUtf8().cast<ffi.Char>();
    final success = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_open_1(ref, cname, apiPreference, success, callback),
      (c) {
        final rval = success.value;
        calloc.free(cname);
        calloc.free(success);
        return c.complete(rval);
      },
    );
  }

  /// Opens a camera for video capturing with API Preference and parameters.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a10867868137c2d142aac30a0648d00fe
  Future<bool> openIndexAsync(int index, {int apiPreference = CAP_ANY}) async {
    final success = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_open_3(ref, index, apiPreference, success, callback),
      (c) {
        final rval = success.value;
        calloc.free(success);
        return c.complete(rval);
      },
    );
  }
}

extension VideoWriterAsync on VideoWriter {
  static Future<VideoWriter> fromFileAsync(
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
    if (apiPreference == null) {
      return cvRunAsync0(
        (callback) => cvideoio.cv_VideoWriter_create_1(
          cname.cast(),
          codec_,
          fps,
          frameSize.$1,
          frameSize.$2,
          isColor,
          p,
          callback,
        ),
        (c) {
          calloc.free(cname);
          return c.complete(VideoWriter.fromPointer(p));
        },
      );
    }
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoWriter_create_2(
        cname.cast(),
        apiPreference,
        codec_,
        fps,
        frameSize.$1,
        frameSize.$2,
        isColor,
        p,
        callback,
      ),
      (c) {
        calloc.free(cname);
        return c.complete(VideoWriter.fromPointer(p));
      },
    );
  }

  Future<bool> openAsync(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    int? apiPreference,
    bool isColor = true,
  }) {
    final cname = filename.toNativeUtf8();
    final codec_ = VideoWriter.fourcc(codec);
    final p = calloc<ffi.Bool>();
    if (apiPreference == null) {
      return cvRunAsync0(
        (callback) => cvideoio.cv_VideoWriter_open(
          ref,
          cname.cast(),
          codec_,
          fps,
          frameSize.$1,
          frameSize.$2,
          isColor,
          p,
          callback,
        ),
        (c) {
          calloc.free(cname);
          final rval = p.value;
          calloc.free(p);
          c.complete(rval);
        },
      );
    }

    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoWriter_open_1(
        ref,
        cname.cast(),
        apiPreference,
        codec_,
        fps,
        frameSize.$1,
        frameSize.$2,
        isColor,
        p,
        callback,
      ),
      (c) {
        calloc.free(cname);
        final rval = p.value;
        calloc.free(p);
        c.complete(rval);
      },
    );
  }

  Future<void> writeAsync(InputArray image) async {
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoWriter_write(ref, image.ref, callback),
      (c) => c.complete(),
    );
  }
}
