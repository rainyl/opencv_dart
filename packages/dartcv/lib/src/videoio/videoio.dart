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
  /// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html#ae38c2a053d39d6b20c9c649e08ff0146
  void grab() => cvRun(() => cvideoio.cv_VideoCapture_grab(ref, ffi.nullptr));

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
    final cname = filename.toNativeUtf8().cast<ffi.Char>();
    final codec_ = VideoWriter.fourcc(codec);
    final p = calloc<ffi.Bool>();
    apiPreference == null
        ? cvRun(
          () => cvideoio.cv_VideoWriter_open(
            ref,
            cname,
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
          () => cvideoio.cv_VideoWriter_open_1(
            ref,
            cname,
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
    calloc.free(p);
  }

  void write(InputArray image) {
    cvRun(() => cvideoio.cv_VideoWriter_write(ref, image.ref, ffi.nullptr));
  }

  static int fourcc(String cc) {
    final cc_ = ascii.encode(cc);
    if (cc_.length != 4) return -1;
    return cvideoio.cv_VideoWriter_fourcc(cc_[0], cc_[1], cc_[2], cc_[3]);
  }

  /// Returns the specified VideoWriter property.
  ///
  /// [propId] Property identifier from cv::VideoWriterProperties (eg. cv::VIDEOWRITER_PROP_QUALITY) or one of Additional flags for video I/O API backends
  ///
  /// Returns
  /// Value for the specified property. Value 0 is returned when querying a property that is not supported by the backend used by the VideoWriter instance.
  double get(int propId) => cvideoio.cv_VideoWriter_get(ref, propId);

  /// Sets a property in the VideoWriter.
  void set(int propId, double value) => cvideoio.cv_VideoWriter_set(ref, propId, value);

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

// constants
/// Current quality (0..100%) of the encoded videostream. Can be adjusted dynamically in some codecs.
const int VIDEOWRITER_PROP_QUALITY = 1;

/// (Read-only): Size of just encoded video frame. Note that the encoding order may be different from representation order.
const int VIDEOWRITER_PROP_FRAMEBYTES = 2;

/// Number of stripes for parallel encoding. -1 for auto detection.
const int VIDEOWRITER_PROP_NSTRIPES = 3;

/// If it is not zero, the encoder will expect and encode color frames, otherwise it will work with grayscale frames.
const int VIDEOWRITER_PROP_IS_COLOR = 4;

/// Defaults to CV_8U.
const int VIDEOWRITER_PROP_DEPTH = 5;

/// (**open-only**) Hardware acceleration type (see #VideoAccelerationType). Setting supported only via `params` parameter in VideoWriter constructor / .open() method. Default value is backend-specific.
const int VIDEOWRITER_PROP_HW_ACCELERATION = 6;

/// (**open-only**) Hardware device index (select GPU if multiple available). Device enumeration is acceleration type specific.
const int VIDEOWRITER_PROP_HW_DEVICE = 7;

/// (**open-only**) If non-zero, create new OpenCL context and bind it to current thread. The OpenCL context created with Video Acceleration context attached it (if not attached yet) for optimized GPU data copy between cv::UMat and HW accelerated encoder.
const int VIDEOWRITER_PROP_HW_ACCELERATION_USE_OPENCL = 8;

/// (**open-only**) Set to non-zero to enable encapsulation of an encoded raw video stream. Each raw encoded video frame should be passed to VideoWriter::write() as single row or column of a CV_8UC1 Mat. \note If the key frame interval is not 1 then it must be manually specified by the user. This can either be performed during initialization passing VIDEOWRITER_PROP_KEY_INTERVAL as one of the extra encoder params  to VideoWriter::VideoWriter(const String &, int, double, const Size &, const std::vector< int > &params) or afterwards by setting the VIDEOWRITER_PROP_KEY_FLAG with VideoWriter::set() before writing each frame. FFMpeg backend only.
const int VIDEOWRITER_PROP_RAW_VIDEO = 9;

/// (**open-only**) Set the key frame interval using raw video encapsulation (VIDEOWRITER_PROP_RAW_VIDEO != 0). Defaults to 1 when not set. FFmpeg back-end only.
const int VIDEOWRITER_PROP_KEY_INTERVAL = 10;

/// Set to non-zero to signal that the following frames are key frames or zero if not, when encapsulating raw video (VIDEOWRITER_PROP_RAW_VIDEO != 0). FFmpeg back-end only.
const int VIDEOWRITER_PROP_KEY_FLAG = 11;

/// Specifies the frame presentation timestamp for each frame using the FPS time base. This property is **only** necessary when encapsulating **externally** encoded video where the decoding order differs from the presentation order, such as in GOP patterns with bi-directional B-frames. The value should be provided by your external encoder and for video sources with fixed frame rates it is equivalent to dividing the current frame's presentation time (CAP_PROP_POS_MSEC) by the frame duration (1000.0 / VideoCapture::get(CAP_PROP_FPS)). It can be queried from the resulting encapsulated video file using VideoCapture::get(CAP_PROP_PTS). FFmpeg back-end only.
const int VIDEOWRITER_PROP_PTS = 12;

/// Specifies the maximum difference between presentation (pts) and decompression timestamps (dts) using the FPS time base. This property is necessary **only** when encapsulating **externally** encoded video where the decoding order differs from the presentation order, such as in GOP patterns with bi-directional B-frames. The value should be calculated based on the specific GOP pattern used during encoding. For example, in a GOP with presentation order IBP and decoding order IPB, this value would be 1, as the B-frame is the second frame presented but the third to be decoded. It can be queried from the resulting encapsulated video file using VideoCapture::get(CAP_PROP_DTS_DELAY). Non-zero values usually imply the stream is encoded using B-frames. FFmpeg back-end only.
const int VIDEOWRITER_PROP_DTS_DELAY = 13;
