library cv;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

class VideoCapture extends CvStruct<cvg.VideoCapture> {
  VideoCapture._(cvg.VideoCapturePtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory VideoCapture.empty() {
    final p = calloc<cvg.VideoCapture>();
    cvRun(() => CFFI.VideoCapture_New(p));
    return VideoCapture._(p);
  }

  /// Opens a video file or a capturing device or an IP video stream for video capturing with API Preference.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a57c0e81e83e60f36c83027dc2a188e80
  factory VideoCapture.create(String filename, {int apiPreference = CAP_ANY}) {
    return using<VideoCapture>((arena) {
      final p = calloc<cvg.VideoCapture>();
      final cname = filename.toNativeUtf8(allocator: arena);
      cvRun(() => CFFI.VideoCapture_NewFromFile(cname.cast(), apiPreference, p));
      return VideoCapture._(p);
    });
  }

  factory VideoCapture.fromFile(String filename, {int apiPreference = CAP_ANY}) {
    return VideoCapture.create(filename, apiPreference: apiPreference);
  }

  factory VideoCapture.fromDevice(int device, {int apiPreference = CAP_ANY}) {
    return using<VideoCapture>((arena) {
      final p = calloc<cvg.VideoCapture>();
      cvRun(() => CFFI.VideoCapture_NewFromIndex(device, apiPreference, p));
      return VideoCapture._(p);
    });
  }

  @override
  cvg.VideoCapture get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.VideoCapturePtr>(CFFI.addresses.VideoCapture_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VideoCapture_Close(ptr);
  }

  /// Returns the specified [VideoCapture] property.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  double get(int propId) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.VideoCapture_Get(ref, propId, p));
      return p.value;
    });
  }

  void set(int prop, double value) {
    cvRun(() => CFFI.VideoCapture_Set(ref, prop, value));
  }

  /// Returns true if video capturing has been initialized already.
  ///
  /// If the previous call to VideoCapture constructor or VideoCapture::open() succeeded, the method returns true.
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  bool get isOpened {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VideoCapture_IsOpened(ref, p));
      return p.value != 0;
    });
  }

  // String getBackendName()=>CFFI.videocapture

  /// Grabs the next frame from video file or capturing device.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#aa6480e6972ef4c00d74814ec841a2939
  void grab({int skip = 0}) {
    cvRun(() => CFFI.VideoCapture_Grab(ref, skip));
  }

  (bool, Mat) read({Mat? m}) {
    m ??= Mat.empty();
    return cvRunArena<(bool, Mat)>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VideoCapture_Read(ref, m!.ref, p));
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
      cvRun(() => CFFI.VideoCapture_OpenWithAPI(ref, cname.cast(), apiPreference, success));
      return success.value;
    });
  }

  /// Opens a camera for video capturing with API Preference and parameters.
  ///
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#a10867868137c2d142aac30a0648d00fe
  bool openIndex(int index, {int apiPreference = CAP_ANY}) {
    return using<bool>((arena) {
      final success = arena<ffi.Bool>();
      cvRun(() => CFFI.VideoCapture_OpenDeviceWithAPI(ref, index, apiPreference, success));
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
    final c1 = codes[0], c2 = codes[1], c3 = codes[2], c4 = codes[3];
    return ((c1 & 255) + ((c2 & 255) << 8) + ((c3 & 255) << 16) + ((c4 & 255) << 24)).toDouble();
  }

  void release() {
    cvRun(() => CFFI.VideoCapture_Release(ref));
  }

  @override
  List<int> get props => [ptr.address];
}

class VideoWriter extends CvStruct<cvg.VideoWriter> {
  VideoWriter._(cvg.VideoWriterPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory VideoWriter.empty() {
    final p = calloc<cvg.VideoWriter>();
    cvRun(() => CFFI.VideoWriter_New(p));
    return VideoWriter._(p);
  }

  factory VideoWriter.open(String filename, String codec, double fps, Size frameSize,
      {bool isColor = true}) {
    return cvRunArena<VideoWriter>((arena) {
      final p = calloc<cvg.VideoWriter>();
      cvRun(() => CFFI.VideoWriter_New(p));
      final name = filename.toNativeUtf8(allocator: arena);
      final codec_ = codec.toNativeUtf8(allocator: arena);
      cvRun(
        () => CFFI.VideoWriter_Open(
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

  void open(String filename, String codec, double fps, Size frameSize, {bool isColor = true}) {
    using((arena) {
      final name = filename.toNativeUtf8(allocator: arena);
      final codec_ = codec.toNativeUtf8(allocator: arena);
      cvRun(() => CFFI.VideoWriter_Open(
          ref, name.cast(), codec_.cast(), fps, frameSize.$1, frameSize.$2, isColor));
    });
  }

  void write(InputArray image) {
    cvRun(() => CFFI.VideoWriter_Write(ref, image.ref));
  }

  static int fourcc(String cc) {
    final cc_ = ascii.encode(cc);
    if (cc_.length != 4) return -1;
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VideoWriter_Fourcc(cc_[0], cc_[1], cc_[2], cc_[3], p));
      return p.value;
    });
  }

  void release() {
    cvRun(() => CFFI.VideoWriter_Release(ref));
  }

  @override
  cvg.VideoWriter get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.VideoWriterPtr>(CFFI.addresses.VideoWriter_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VideoWriter_Close(ptr);
  }

  bool get isOpened {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VideoWriter_IsOpened(ref, p));
      return p.value != 0;
    });
  }

  @override
  List<int> get props => [ptr.address];
}
