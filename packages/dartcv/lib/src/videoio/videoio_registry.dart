// Copyright (c) 2026, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.videoio_registry;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../g/constants.g.dart';
import '../g/videoio.g.dart' as cvg;
import 'videoio.dart';

class CameraInfo {
  final int width;
  final int height;
  final double fps;
  final String name;
  final int cameraIndex;
  final VideoCaptureAPIs backend;
  const CameraInfo({
    required this.width,
    required this.height,
    required this.fps,
    required this.name,
    required this.cameraIndex,
    required this.backend,
  });

  @override
  String toString() {
    return "CameraInfo(name=$name, width=$width, height=$height, fps=${fps.toStringAsFixed(2)}, cameraIndex=$cameraIndex, backend=$backend)";
  }
}

class VideoIORegistry {
  /// Returns list of all available backends
  static List<VideoCaptureAPIs> getBackends() {
    final p = calloc<ffi.Pointer<ffi.Int>>();
    final pszie = calloc<ffi.Int>();
    cvRun(() => cvg.cv_video_registry_getBackends(p, pszie));
    final backends = List.generate(pszie.value, (i) => VideoCaptureAPIs.fromValue(p.value[i]));
    calloc.free(p);
    calloc.free(pszie);
    return backends;
  }

  /// Returns list of available backends which works via `cv::VideoCapture(int index)`
  static List<VideoCaptureAPIs> getCameraBackends() {
    final p = calloc<ffi.Pointer<ffi.Int>>();
    final pszie = calloc<ffi.Int>();
    cvRun(() => cvg.cv_video_registry_getCameraBackends(p, pszie));
    final backends = List.generate(pszie.value, (i) => VideoCaptureAPIs.fromValue(p.value[i]));
    calloc.free(p);
    calloc.free(pszie);
    return backends;
  }

  /// Returns list of available backends which works via `cv::VideoCapture(filename)`
  static List<VideoCaptureAPIs> getStreamBackends() {
    final p = calloc<ffi.Pointer<ffi.Int>>();
    final pszie = calloc<ffi.Int>();
    cvRun(() => cvg.cv_video_registry_getStreamBackends(p, pszie));
    final backends = List.generate(pszie.value, (i) => VideoCaptureAPIs.fromValue(p.value[i]));
    calloc.free(p);
    calloc.free(pszie);
    return backends;
  }

  /// Returns list of available backends which works via `cv::VideoCapture(buffer)`
  static List<VideoCaptureAPIs> getStreamBufferedBackends() {
    final p = calloc<ffi.Pointer<ffi.Int>>();
    final pszie = calloc<ffi.Int>();
    cvRun(() => cvg.cv_video_registry_getStreamBufferedBackends(p, pszie));
    final backends = List.generate(pszie.value, (i) => VideoCaptureAPIs.fromValue(p.value[i]));
    calloc.free(p);
    calloc.free(pszie);
    return backends;
  }

  /// Returns list of available backends which works via `cv::VideoWriter()`
  static List<VideoCaptureAPIs> getWriterBackends() {
    final p = calloc<ffi.Pointer<ffi.Int>>();
    final pszie = calloc<ffi.Int>();
    cvRun(() => cvg.cv_video_registry_getWriterBackends(p, pszie));
    final backends = List.generate(pszie.value, (i) => VideoCaptureAPIs.fromValue(p.value[i]));
    calloc.free(p);
    calloc.free(pszie);
    return backends;
  }

  /// Returns true if backend is available
  static bool hasBackend(VideoCaptureAPIs api) => cvg.cv_video_registry_hasBackend(api.value);

  /// Returns true if backend is built in (false if backend is used as plugin)
  static bool isBackendBuiltIn(VideoCaptureAPIs api) => cvg.cv_video_registry_isBackendBuiltIn(api.value);

  /// Parses frame format from int to string
  ///
  /// -1 is returned if frame format is not valid
  static String parseFrameFormat(int frameFormat) {
    final typeList = ['8U', '8S', '16U', '16S', '32S', '32F', '64F'];
    if (frameFormat == -1) {
      return "UnknownFormat";
    }
    return '${typeList[frameFormat % 8]}C${frameFormat ~/ 8 + 1}';
  }

  // enumerate cameras
  // https://github.com/lukehugh/cv2_enumerate_cameras/blob/main/cv2_enumerate_cameras/opencv_backend.py
  static List<CameraInfo> enumerateCameras(VideoCaptureAPIs apiPreference, {int maxCameras = 10}) {
    final cameras = <CameraInfo>[];
    for (var cameraIndex = 0; cameraIndex < maxCameras; cameraIndex++) {
      final camera = VideoCapture.fromDevice(cameraIndex, apiPreference: apiPreference.value);
      if (camera.isOpened) {
        final width = camera.get(CAP_PROP_FRAME_WIDTH);
        final height = camera.get(CAP_PROP_FRAME_HEIGHT);
        final fps = camera.get(CAP_PROP_FPS);
        final frameFormat = camera.get(CAP_PROP_FORMAT).toInt();
        final name = 'video_${parseFrameFormat(frameFormat)}';
        camera.release();
        cameras.add(
          CameraInfo(
            name: name,
            width: width.toInt(),
            height: height.toInt(),
            fps: fps,
            cameraIndex: cameraIndex,
            backend: apiPreference,
          ),
        );
      }
    }

    return cameras;
  }
}

/// cv::VideoCapture API backends identifier.
///
/// Select preferred API for a capture object.
/// To be used in the VideoCapture::VideoCapture() constructor or VideoCapture::open()
///
/// - Backends are available only if they have been built with your OpenCV binaries.
/// See @ref videoio_overview for more information.
/// - Microsoft Media Foundation backend tries to use hardware accelerated transformations
/// if possible. Environment flag "OPENCV_VIDEOIO_MSMF_ENABLE_HW_TRANSFORMS" set to 0
/// disables it and may improve initialization time. More details:
/// https://learn.microsoft.com/en-us/windows/win32/medfound/mf-readwrite-enable-hardware-transforms
enum VideoCaptureAPIs {
  /// Auto detect == 0
  CAP_ANY(0),

  /// Video For Windows (obsolete, removed)
  // CAP_VFW(200),

  /// V4L/V4L2 capturing support
  CAP_V4L(200),

  /// Same as CAP_V4L
  CAP_V4L2(200),

  /// IEEE 1394 drivers
  CAP_FIREWIRE(300),

  /// Same value as CAP_FIREWIRE
  CAP_FIREWARE(300),

  /// Same value as CAP_FIREWIRE
  CAP_IEEE1394(300),

  /// Same value as CAP_FIREWIRE
  CAP_DC1394(300),

  /// Same value as CAP_FIREWIRE
  CAP_CMU1394(300),

  /// QuickTime (obsolete, removed)
  CAP_QT(500),

  /// Unicap drivers (obsolete, removed)
  CAP_UNICAP(600),

  /// DirectShow (via videoInput)
  CAP_DSHOW(700),

  /// PvAPI, Prosilica GigE SDK
  CAP_PVAPI(800),

  /// OpenNI (for Kinect)
  CAP_OPENNI(900),

  /// OpenNI (for Asus Xtion)
  CAP_OPENNI_ASUS(910),

  /// MediaNDK (API Level 21+) and NDK Camera (API level 24+) for Android
  CAP_ANDROID(1000),

  /// XIMEA Camera API
  CAP_XIAPI(1100),

  /// AVFoundation framework for iOS (OS X Lion will have the same API)
  CAP_AVFOUNDATION(1200),

  /// Smartek Giganetix GigEVisionSDK
  CAP_GIGANETIX(1300),

  /// Microsoft Media Foundation (via videoInput). See platform specific notes above.
  CAP_MSMF(1400),

  /// Microsoft Windows Runtime using Media Foundation
  CAP_WINRT(1410),

  /// RealSense (former Intel Perceptual Computing SDK)
  CAP_INTELPERC(1500),

  /// Synonym for CAP_INTELPERC
  CAP_REALSENSE(1500),

  /// OpenNI2 (for Kinect)
  CAP_OPENNI2(1600),

  /// OpenNI2 (for Asus Xtion and Occipital Structure sensors)
  CAP_OPENNI2_ASUS(1610),

  /// OpenNI2 (for Orbbec Astra)
  CAP_OPENNI2_ASTRA(1620),

  /// gPhoto2 connection
  CAP_GPHOTO2(1700),

  /// GStreamer
  CAP_GSTREAMER(1800),

  /// Open and record video file or stream using the FFMPEG library
  CAP_FFMPEG(1900),

  /// OpenCV Image Sequence (e.g. img_%02d.jpg)
  CAP_IMAGES(2000),

  /// Aravis SDK
  CAP_ARAVIS(2100),

  /// Built-in OpenCV MotionJPEG codec
  CAP_OPENCV_MJPEG(2200),

  /// Intel MediaSDK
  CAP_INTEL_MFX(2300),

  /// XINE engine (Linux)
  CAP_XINE(2400),

  /// uEye Camera API
  CAP_UEYE(2500),

  /// For Orbbec 3D-Sensor device/module (Astra+, Femto, Astra2, Gemini2, Gemini2L, Gemini2XL, Gemini330, Femto Mega)
  /// attention: Astra2 cameras currently only support Windows and Linux kernel versions no higher than 4.15,
  /// and higher versions of Linux kernel may have exceptions.
  CAP_OBSENSOR(2600)
  ;

  final int value;
  const VideoCaptureAPIs(this.value);

  factory VideoCaptureAPIs.fromValue(int value) => switch (value) {
    0 => CAP_ANY,
    // 200 => CAP_VFW,
    200 => CAP_V4L,
    // 200 => CAP_V4L2,
    300 => CAP_FIREWIRE,
    // 300 => CAP_FIREWARE,
    // 300 => CAP_IEEE1394,
    // 300 => CAP_DC1394,
    // 300 => CAP_CMU1394,
    500 => CAP_QT,
    600 => CAP_UNICAP,
    700 => CAP_DSHOW,
    800 => CAP_PVAPI,
    900 => CAP_OPENNI,
    910 => CAP_OPENNI_ASUS,
    1000 => CAP_ANDROID,
    1100 => CAP_XIAPI,
    1200 => CAP_AVFOUNDATION,
    1300 => CAP_GIGANETIX,
    1400 => CAP_MSMF,
    1410 => CAP_WINRT,
    1500 => CAP_INTELPERC,
    // 1500 => CAP_REALSENSE,
    1600 => CAP_OPENNI2,
    1610 => CAP_OPENNI2_ASUS,
    1620 => CAP_OPENNI2_ASTRA,
    1700 => CAP_GPHOTO2,
    1800 => CAP_GSTREAMER,
    1900 => CAP_FFMPEG,
    2000 => CAP_IMAGES,
    2100 => CAP_ARAVIS,
    2200 => CAP_OPENCV_MJPEG,
    2300 => CAP_INTEL_MFX,
    2400 => CAP_XINE,
    2500 => CAP_UEYE,
    2600 => CAP_OBSENSOR,
    _ => throw ArgumentError.value(value, 'value', 'No VideoCaptureAPIs with value $value'),
  };
}
