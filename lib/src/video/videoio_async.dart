library cv;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../constants.g.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;
import 'videoio.dart';

extension VideoCaptureAsync on VideoCapture {
  static Future<VideoCapture> emptyAsync() async => cvRunAsync(
        CFFI.VideoCapture_New_Async,
        (completer, p) => completer.complete(VideoCapture.fromPointer(p.cast<cvg.VideoCapture>())),
      );

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a57c0e81e83e60f36c83027dc2a188e80
  static Future<VideoCapture> fromFileAsync(String filename, {int apiPreference = CAP_ANY}) async {
    final cname = filename.toNativeUtf8().cast<ffi.Char>();
    final rval = cvRunAsync<VideoCapture>(
      (callback) => CFFI.VideoCapture_NewFromFile_Async(cname, apiPreference, callback),
      (completer, p) => completer.complete(VideoCapture.fromPointer(p.cast<cvg.VideoCapture>())),
    );
    calloc.free(cname);
    return rval;
  }

  static Future<VideoCapture> fromDeviceAsync(int device, {int apiPreference = CAP_ANY}) async => cvRunAsync(
        (callback) => CFFI.VideoCapture_NewFromIndex_Async(device, apiPreference, callback),
        (completer, p) => completer.complete(VideoCapture.fromPointer(p.cast<cvg.VideoCapture>())),
      );

  // String getBackendName()=>CFFI.videocapture

  /// Grabs the next frame from video file or capturing device.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  Future<bool> grabAsync() async =>
      cvRunAsync((callback) => CFFI.VideoCapture_Grab_Async(ref, callback), boolCompleter);

  Future<(bool, Mat)> readAsync() async =>
      cvRunAsync2((callback) => CFFI.VideoCapture_Read_Async(ref, callback), (completer, p, p1) {
        final rval = p.cast<ffi.Bool>().value;
        calloc.free(p);
        completer.complete((rval, Mat.fromPointer(p1.cast<cvg.Mat>())));
      });

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference and parameters.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  Future<bool> openAsync(String uri, {int apiPreference = CAP_ANY}) {
    final cname = uri.toNativeUtf8().cast<ffi.Char>();
    final rval = cvRunAsync<bool>(
      (callback) => CFFI.VideoCapture_OpenWithAPI_Async(ref, cname, apiPreference, callback),
      boolCompleter,
    );
    calloc.free(cname);
    return rval;
  }

  /// Opens a camera for video capturing with API Preference and parameters.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a10867868137c2d142aac30a0648d00fe
  Future<bool> openIndexAsync(int index, {int apiPreference = CAP_ANY}) async => cvRunAsync(
        (callback) => CFFI.VideoCapture_OpenDeviceWithAPI_Async(ref, index, apiPreference, callback),
        boolCompleter,
      );

  Future<void> releaseAsync() async => cvRunAsync0(
        (callback) => CFFI.VideoCapture_Release_Async(ref, callback),
        (completer) => completer.complete(),
      );
}

extension VideoWriterAsync on VideoWriter {
  static Future<VideoWriter> emptyAsync() async => cvRunAsync(
        CFFI.VideoWriter_New_Async,
        (c, p) => c.complete(VideoWriter.fromPointer(p.cast<cvg.VideoWriter>())),
      );

  static Future<VideoWriter> fromFileAsync(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    bool isColor = true,
  }) async {
    final vw = await cvRunAsync<VideoWriter>(
      CFFI.VideoWriter_New_Async,
      (c, p) => c.complete(VideoWriter.fromPointer(p.cast<cvg.VideoWriter>())),
    );
    await vw.openAsync(filename, codec, fps, frameSize, isColor: isColor);
    return vw;
  }

  Future<bool> openAsync(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    bool isColor = true,
  }) async {
    final name = filename.toNativeUtf8().cast<ffi.Char>();
    final codec_ = codec.toNativeUtf8().cast<ffi.Char>();
    final rval = cvRunAsync<bool>(
      (callback) =>
          CFFI.VideoWriter_Open_Async(ref, name, codec_, fps, frameSize.$1, frameSize.$2, isColor, callback),
      boolCompleter,
    );
    calloc.free(name);
    calloc.free(codec_);
    return rval;
  }

  Future<void> writeAsync(InputArray image) async =>
      cvRunAsync0((callback) => CFFI.VideoWriter_Write_Async(ref, image.ref, callback), voidCompleter);

  static Future<int> fourccAsync(String cc) async {
    final cc_ = ascii.encode(cc);
    if (cc_.length != 4) return -1;
    return cvRunAsync(
      (callback) => CFFI.VideoWriter_Fourcc_Async(cc_[0], cc_[1], cc_[2], cc_[3], callback),
      intCompleter,
    );
  }

  Future<void> releaseAsync() async => cvRunAsync0(
        (callback) => CFFI.VideoWriter_Release_Async(ref, callback),
        voidCompleter,
      );
}
