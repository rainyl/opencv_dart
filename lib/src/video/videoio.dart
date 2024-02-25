library cv;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/cv_exception.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class VideoCapture extends CvObject {
  VideoCapture._(this._ptr) : super(_ptr) {
    finalizer.attach(this, _ptr);
  }

  factory VideoCapture.empty() {
    return VideoCapture._(_bindings.VideoCapture_New());
  }

  factory VideoCapture.create(
    String filename, {
    int apiPreference = CAP_ANY,
    List<int>? params,
  }) {
    final ptr_ = _bindings.VideoCapture_New();
    final cname = filename.toNativeUtf8();
    final success = _bindings.VideoCapture_OpenWithAPI(ptr_, cname.cast(), apiPreference);
    // calloc.free(cname);
    if (success) {
      return VideoCapture._(ptr_);
    } else {
      throw OpenCvDartException("Open $filename failed!");
    }
  }

  factory VideoCapture.fromFile(
    String filename, {
    int apiPreference = CAP_ANY,
    List<int>? params,
  }) {
    return VideoCapture.create(filename, apiPreference: apiPreference, params: params);
  }

  factory VideoCapture.fromDevice(
    int device, {
    int apiPreference = CAP_ANY,
    List<int>? params,
  }) {
    final ptr_ = _bindings.VideoCapture_New();
    final success = _bindings.VideoCapture_OpenDeviceWithAPI(ptr_, device, apiPreference);
    if (success) {
      return VideoCapture._(ptr_);
    } else {
      throw OpenCvDartException("Open device $device failed!");
    }
  }

  cvg.VideoCapture _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.VideoCapture_Close);

  double getProp(int propId) {
    return _bindings.VideoCapture_Get(_ptr, propId);
  }

  void setProp(int prop, double value) {
    _bindings.VideoCapture_Set(_ptr, prop, value);
  }

  bool get isOpened => _bindings.VideoCapture_IsOpened(_ptr) != 0;

  // String getBackendName()=>_bindings.videocapture
  void grab({int skip = 0}) {
    _bindings.VideoCapture_Grab(_ptr, skip);
  }

  bool read(Mat m) {
    return _bindings.VideoCapture_Read(_ptr, m.ptr) != 0;
  }

  bool open(String filename, {int apiPreference = CAP_ANY}) {
    final cname = filename.toNativeUtf8();
    final success = _bindings.VideoCapture_OpenWithAPI(_ptr, cname.cast(), apiPreference);
    calloc.free(cname);
    return success;
  }

  String get codec {
    List<int> res = [];
    final hexes = [0xff, 0xff00, 0xff0000, 0xff000000];
    for (var i = 0; i < hexes.length; i++) {
      res.add(getProp(CAP_PROP_FOURCC).toInt() & hexes[i] >> i * 8);
    }
    return ascii.decode(res);
  }

  double toCodec(String codec) {
    final codes = ascii.encode(codec);
    if (codes.length != 4) return -1;
    final c1 = codes[0], c2 = codes[1], c3 = codes[2], c4 = codes[3];
    return ((c1 & 255) + ((c2 & 255) << 8) + ((c3 & 255) << 16) + ((c4 & 255) << 24)).toDouble();
  }

  void release() {
    _bindings.VideoCapture_Release(_ptr);
  }

  @override
  ffi.NativeType get ref => throw UnsupportedError("");

  @override
  ffi.NativeType toNative() => throw UnsupportedError("");
}

class VideoWriter implements ffi.Finalizable {
  VideoWriter._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory VideoWriter.empty() {
    final _ptr = _bindings.VideoWriter_New();
    return VideoWriter._(_ptr);
  }

  factory VideoWriter.open(
    String filename,
    String codec,
    double fps,
    Size frameSize, {
    bool isColor = true,
  }) {
    final _ptr = _bindings.VideoWriter_New();
    final name = filename.toNativeUtf8();
    final _codec = codec.toNativeUtf8();
    _bindings.VideoWriter_Open(
      _ptr,
      name.cast(),
      _codec.cast(),
      fps,
      frameSize.$1,
      frameSize.$2,
      isColor,
    );
    calloc.free(name);
    calloc.free(_codec);
    return VideoWriter._(_ptr);
  }

  void open(
    String filename,
    String codec,
    double fps,
    Size frameSize, {
    bool isColor = true,
  }) {
    final name = filename.toNativeUtf8();
    final _codec = codec.toNativeUtf8();
    _bindings.VideoWriter_Open(
      _ptr,
      name.cast(),
      _codec.cast(),
      fps,
      frameSize.$1,
      frameSize.$2,
      isColor,
    );
    calloc.free(name);
    calloc.free(_codec);
  }

  void write(InputArray image) {
    _bindings.VideoWriter_Write(_ptr, image.ptr);
  }

  static int fourcc(String cc) {
    final _cc = ascii.encode(cc);
    if (_cc.length != 4) return -1;
    return _bindings.VideoWriter_Fourcc(_cc[0], _cc[1], _cc[2], _cc[3]);
  }

  void release() {
    _bindings.VideoWriter_Release(_ptr);
  }

  cvg.VideoWriter _ptr;
  cvg.VideoWriter get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.VideoWriter_Close);

  bool get isOpened => _bindings.VideoWriter_IsOpened(_ptr) != 0;
}
