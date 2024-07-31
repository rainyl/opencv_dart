library cv.videoio;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/constants.g.dart';
import '../g/video_io.g.dart' as cvideo;

class VideoCapture extends CvStruct<cvideo.VideoCapture> {
  VideoCapture._(cvideo.VideoCapturePtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VideoCapture.fromPointer(cvideo.VideoCapturePtr ptr) => VideoCapture._(ptr, false);

  factory VideoCapture.empty() {
    final p = calloc<cvideo.VideoCapture>();
    cvRun(() => cvideo.VideoCapture_New(p));
    return VideoCapture._(p);
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a57c0e81e83e60f36c83027dc2a188e80
  factory VideoCapture.create(String filename, {int apiPreference = CAP_ANY}) {
    return using<VideoCapture>((arena) {
      final p = calloc<cvideo.VideoCapture>();
      final cname = filename.toNativeUtf8(allocator: arena);
      cvRun(() => cvideo.VideoCapture_NewFromFile(cname.cast(), apiPreference, p));
      return VideoCapture._(p);
    });
  }

  factory VideoCapture.fromFile(String filename, {int apiPreference = CAP_ANY}) {
    return VideoCapture.create(filename, apiPreference: apiPreference);
  }

  factory VideoCapture.fromDevice(int device, {int apiPreference = CAP_ANY}) {
    final p = calloc<cvideo.VideoCapture>();
    cvRun(() => cvideo.VideoCapture_NewFromIndex(device, apiPreference, p));
    return VideoCapture._(p);
  }

  @override
  cvideo.VideoCapture get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvideo.VideoCapturePtr>(cvideo.addresses.VideoCapture_Close);

  void dispose() {
    finalizer.detach(this);
    cvideo.VideoCapture_Close(ptr);
  }

  /// Returns the specified [VideoCapture] property.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  double get(int propId) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvideo.VideoCapture_Get(ref, propId, p));
      return p.value;
    });
  }

  void set(int prop, double value) {
    cvRun(() => cvideo.VideoCapture_Set(ref, prop, value));
  }

  String getBackendName() {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cvideo.VideoCapture_getBackendName(ref, p));
    final name = p.value.toDartString();
    calloc.free(p);
    return name;
  }

  /// Returns true if video capturing has been initialized already.
  ///
  /// If the previous call to VideoCapture constructor or VideoCapture::open() succeeded, the method returns true.
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  bool get isOpened {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvideo.VideoCapture_IsOpened(ref, p));
      return p.value != 0;
    });
  }

  // String getBackendName()=>cffiVideoIO.videocapture

  /// Grabs the next frame from video file or capturing device.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  void grab({int skip = 0}) {
    cvRun(() => cvideo.VideoCapture_Grab(ref, skip));
  }

  (bool, Mat) read({Mat? m}) {
    m ??= Mat.empty();
    return cvRunArena<(bool, Mat)>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvideo.VideoCapture_Read(ref, m!.ref, p));
      return (p.value != 0, m!);
    });
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference and parameters.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  bool open(String filename, {int apiPreference = CAP_ANY}) {
    return using<bool>((arena) {
      final cname = filename.toNativeUtf8(allocator: arena);
      final success = arena<ffi.Bool>();
      cvRun(() => cvideo.VideoCapture_OpenWithAPI(ref, cname.cast(), apiPreference, success));
      return success.value;
    });
  }

  /// Opens a camera for video capturing with API Preference and parameters.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a10867868137c2d142aac30a0648d00fe
  bool openIndex(int index, {int apiPreference = CAP_ANY}) {
    return using<bool>((arena) {
      final success = arena<ffi.Bool>();
      cvRun(() => cvideo.VideoCapture_OpenDeviceWithAPI(ref, index, apiPreference, success));
      return success.value;
    });
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
    cvRun(() => cvideo.VideoCapture_Release(ref));
  }
}

class VideoWriter extends CvStruct<cvideo.VideoWriter> {
  VideoWriter._(cvideo.VideoWriterPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory VideoWriter.fromPointer(cvideo.VideoWriterPtr ptr) => VideoWriter._(ptr, false);

  factory VideoWriter.empty() {
    final p = calloc<cvideo.VideoWriter>();
    cvRun(() => cvideo.VideoWriter_New(p));
    return VideoWriter._(p);
  }

  factory VideoWriter.open(
    String filename,
    String codec,
    double fps,
    (int, int) frameSize, {
    bool isColor = true,
  }) {
    return cvRunArena<VideoWriter>((arena) {
      final p = calloc<cvideo.VideoWriter>();
      cvRun(() => cvideo.VideoWriter_New(p));
      final name = filename.toNativeUtf8(allocator: arena);
      final codec_ = codec.toNativeUtf8(allocator: arena);
      cvRun(
        () => cvideo.VideoWriter_Open(
          p.ref,
          name.cast(),
          codec_.cast(),
          fps,
          frameSize.$1,
          frameSize.$2,
          isColor,
        ),
      );
      return VideoWriter._(p);
    });
  }

  void open(String filename, String codec, double fps, (int, int) frameSize, {bool isColor = true}) {
    using((arena) {
      final name = filename.toNativeUtf8(allocator: arena);
      final codec_ = codec.toNativeUtf8(allocator: arena);
      cvRun(
        () => cvideo.VideoWriter_Open(
          ref,
          name.cast(),
          codec_.cast(),
          fps,
          frameSize.$1,
          frameSize.$2,
          isColor,
        ),
      );
    });
  }

  void write(InputArray image) {
    cvRun(() => cvideo.VideoWriter_Write(ref, image.ref));
  }

  static int fourcc(String cc) {
    final cc_ = ascii.encode(cc);
    if (cc_.length != 4) return -1;
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvideo.VideoWriter_Fourcc(cc_[0], cc_[1], cc_[2], cc_[3], p));
      return p.value;
    });
  }

  void release() {
    cvRun(() => cvideo.VideoWriter_Release(ref));
  }

  @override
  cvideo.VideoWriter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvideo.VideoWriterPtr>(cvideo.addresses.VideoWriter_Close);

  void dispose() {
    finalizer.detach(this);
    cvideo.VideoWriter_Close(ptr);
  }

  bool get isOpened {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvideo.VideoWriter_IsOpened(ref, p));
      return p.value != 0;
    });
  }
}
