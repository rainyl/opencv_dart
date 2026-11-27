// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.videoio;

import '../bindings/videoio.dart' as cvg;
import '../bindings/videoio.dart' as cvideoio;
import '../core/base.dart';
import '../core/mat.dart';
import '../ffi.dart' as ffi;
import '../g/constants.g.dart';
import '../package_ffi.dart';
import 'videoio.dart';

extension VideoCaptureAsync on VideoCapture {
  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a57c0e81e83e60f36c83027dc2a188e80
  static Future<VideoCapture> fromFileAsync(
    String filename, {
    int apiPreference = CAP_ANY,
    Duration? timeout,
  }) {
    // The file name belongs to the arena until the job reports: `release`, not the return of this
    // call, is the point after which the job may no longer read it.
    final arena = Arena();
    final p = calloc<cvg.VideoCapture>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_create_1(
        filename.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        apiPreference,
        p,
        callback,
      ),
      (c) => c.complete(VideoCapture.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<VideoCapture> fromDeviceAsync(
    int device, {
    int apiPreference = CAP_ANY,
    Duration? timeout,
  }) async {
    final p = calloc<cvg.VideoCapture>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_create_2(device, apiPreference, p, callback),
      (
        c,
      ) {
        return c.complete(VideoCapture.fromPointer(p));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// Grabs the next frame from video file or capturing device.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  Future<void> grabAsync() =>
      cvRunAsync0((callback) => cvideoio.cv_VideoCapture_grab(ref, callback), (c) => c.complete());

  Future<(bool, Mat)> readAsync({Mat? m, Duration? timeout}) async {
    m ??= Mat.empty();
    final p = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_read(ref, m!.ref, p, callback),
      (c) {
        final rval = (p.value, m!);
        return c.complete(rval);
      },
      timeout: timeout,
      release: () => calloc.free(p),
    );
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference and parameters.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  Future<bool> openAsync(String uri, {int apiPreference = CAP_ANY, Duration? timeout}) {
    final arena = Arena();
    final success = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_open_1(
        ref,
        uri.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        apiPreference,
        success,
        callback,
      ),
      (c) => c.complete(success.value),
      release: () {
        calloc.free(success);
        arena.releaseAll();
      },
      timeout: timeout,
    );
  }

  /// Opens a camera for video capturing with API Preference and parameters.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a10867868137c2d142aac30a0648d00fe
  Future<bool> openIndexAsync(int index, {int apiPreference = CAP_ANY, Duration? timeout}) async {
    final success = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoCapture_open_3(ref, index, apiPreference, success, callback),
      (c) {
        final rval = success.value;
        return c.complete(rval);
      },
      release: () => calloc.free(success),
      timeout: timeout,
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
    Duration? timeout,
  }) {
    final arena = Arena();
    final p = calloc<cvg.VideoWriter>();
    final codec_ = VideoWriter.fourcc(codec);
    if (apiPreference == null) {
      return cvRunAsync0(
        (callback) => cvideoio.cv_VideoWriter_create_1(
          filename.toNativeUtf8(allocator: arena).cast(),
          codec_,
          fps,
          frameSize.$1,
          frameSize.$2,
          isColor,
          p,
          callback,
        ),
        (c) => c.complete(VideoWriter.fromPointer(p)),
        timeout: timeout,
        release: arena.releaseAll,
        releaseOnFailure: () => calloc.free(p),
      );
    }
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoWriter_create_2(
        filename.toNativeUtf8(allocator: arena).cast(),
        apiPreference,
        codec_,
        fps,
        frameSize.$1,
        frameSize.$2,
        isColor,
        p,
        callback,
      ),
      (c) => c.complete(VideoWriter.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  Future<bool> openAsync(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    int? apiPreference,
    bool isColor = true,
    Duration? timeout,
  }) {
    final arena = Arena();
    final codec_ = VideoWriter.fourcc(codec);
    final p = calloc<ffi.Bool>();
    if (apiPreference == null) {
      return cvRunAsync0(
        (callback) => cvideoio.cv_VideoWriter_open(
          ref,
          filename.toNativeUtf8(allocator: arena).cast(),
          codec_,
          fps,
          frameSize.$1,
          frameSize.$2,
          isColor,
          p,
          callback,
        ),
        (c) => c.complete(p.value),
        timeout: timeout,
        release: () {
          calloc.free(p);
          arena.releaseAll();
        },
      );
    }

    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoWriter_open_1(
        ref,
        filename.toNativeUtf8(allocator: arena).cast(),
        apiPreference,
        codec_,
        fps,
        frameSize.$1,
        frameSize.$2,
        isColor,
        p,
        callback,
      ),
      (c) => c.complete(p.value),
      timeout: timeout,
      release: () {
        calloc.free(p);
        arena.releaseAll();
      },
    );
  }

  Future<void> writeAsync(InputArray image, {Duration? timeout}) {
    return cvRunAsync0(
      (callback) => cvideoio.cv_VideoWriter_write(ref, image.ref, callback),
      (c) => c.complete(),
      timeout: timeout,
    );
  }
}
