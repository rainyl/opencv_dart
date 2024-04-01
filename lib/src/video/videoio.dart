library cv;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/exception.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

class VideoCapture extends CvStruct<cvg.VideoCapture> {
  VideoCapture._(cvg.VideoCapturePtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }

  factory VideoCapture.empty() {
    final p = calloc<cvg.VideoCapture>();
    cvRun(() => CFFI.VideoCapture_New(p));
    return VideoCapture._(p);
  }

  factory VideoCapture.create(String filename, {int apiPreference = CAP_ANY}) {
    return using<VideoCapture>((arena) {
      final p = calloc<cvg.VideoCapture>();
      cvRun(() => CFFI.VideoCapture_New(p));
      final cname = filename.toNativeUtf8(allocator: arena);
      final ret = arena<ffi.Bool>();
      cvRun(() => CFFI.VideoCapture_OpenWithAPI(p.ref, cname.cast(), apiPreference, ret));
      if (ret.value) {
        return VideoCapture._(p);
      } else {
        throw CvException(-1, msg: "Failed open $filename");
      }
    });
  }

  factory VideoCapture.fromFile(String filename, {int apiPreference = CAP_ANY}) {
    return VideoCapture.create(filename, apiPreference: apiPreference);
  }

  factory VideoCapture.fromDevice(int device, {int apiPreference = CAP_ANY}) {
    return using<VideoCapture>((arena) {
      final p = calloc<cvg.VideoCapture>();
      cvRun(() => CFFI.VideoCapture_New(p));
      final ret = arena<ffi.Bool>();
      cvRun(() => CFFI.VideoCapture_OpenDeviceWithAPI(p.ref, device, apiPreference, ret));
      if (ret.value) {
        return VideoCapture._(p);
      } else {
        throw CvException(-1, msg: "Open device $device Failed!");
      }
    });
  }

  @override
  cvg.VideoCapture get ref => ptr.ref;
  static final finalizer = Finalizer<cvg.VideoCapturePtr>((p) {
    CFFI.VideoCapture_Close(p);
    calloc.free(p);
  });

  double getProp(int propId) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.VideoCapture_Get(ref, propId, p));
      return p.value;
    });
  }

  void setProp(int prop, double value) {
    cvRun(() => CFFI.VideoCapture_Set(ref, prop, value));
  }

  bool get isOpened {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.VideoCapture_IsOpened(ref, p));
      return p.value != 0;
    });
  }

  // String getBackendName()=>CFFI.videocapture
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

  bool open(String filename, {int apiPreference = CAP_ANY}) {
    return using<bool>((arena) {
      final cname = filename.toNativeUtf8(allocator: arena);
      final success = arena<ffi.Bool>();
      cvRun(() => CFFI.VideoCapture_OpenWithAPI(ref, cname.cast(), apiPreference, success));
      return success.value;
    });
  }

  String get codec {
    final hexes = [0xff, 0xff00, 0xff0000, 0xff000000];
    final res = List.generate(hexes.length, (i) => getProp(CAP_PROP_FOURCC).toInt() & hexes[i] >> i * 8);
    return ascii.decode(res);
  }

  double toCodec(String codec) {
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
    finalizer.attach(this, ptr);
  }

  factory VideoWriter.empty() {
    final p = calloc<cvg.VideoWriter>();
    cvRun(() => CFFI.VideoWriter_New(p));
    return VideoWriter._(p);
  }

  factory VideoWriter.open(String filename, String codec, double fps, Size frameSize, {bool isColor = true}) {
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
      cvRun(
        () => CFFI.VideoWriter_Open(
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
  static final finalizer = Finalizer<cvg.VideoWriterPtr>((p) {
    CFFI.VideoWriter_Close(p);
    calloc.free(p);
  });

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
