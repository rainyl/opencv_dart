// coverage:ignore-file
// opencv_dart - OpenCV bindings for Dart language
//    some c wrappers were from gocv: https://github.com/hybridgroup/gocv
//    License: Apache-2.0 https://github.com/hybridgroup/gocv/blob/release/LICENSE.txt
// Author: Rainyl
// License: Apache-2.0
// Date: 2024/01/28

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;
import 'package:dartcv4/src/g/types.g.dart' as imp1;

/// Native bindings for OpenCV - VideoIO
///
class CvNativeVideoIO {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  CvNativeVideoIO(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  CvNativeVideoIO.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void cv_VideoCapture_close(
    VideoCapturePtr self,
  ) {
    return _cv_VideoCapture_close(
      self,
    );
  }

  late final _cv_VideoCapture_closePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(VideoCapturePtr)>>(
          'cv_VideoCapture_close');
  late final _cv_VideoCapture_close =
      _cv_VideoCapture_closePtr.asFunction<void Function(VideoCapturePtr)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_create(
    ffi.Pointer<VideoCapture> rval,
  ) {
    return _cv_VideoCapture_create(
      rval,
    );
  }

  late final _cv_VideoCapture_createPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              ffi.Pointer<VideoCapture>)>>('cv_VideoCapture_create');
  late final _cv_VideoCapture_create = _cv_VideoCapture_createPtr
      .asFunction<ffi.Pointer<CvStatus> Function(ffi.Pointer<VideoCapture>)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_create_1(
    ffi.Pointer<ffi.Char> filename,
    int apiPreference,
    ffi.Pointer<VideoCapture> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_create_1(
      filename,
      apiPreference,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_create_1Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              ffi.Pointer<ffi.Char>,
              ffi.Int,
              ffi.Pointer<VideoCapture>,
              imp1.CvCallback_0)>>('cv_VideoCapture_create_1');
  late final _cv_VideoCapture_create_1 =
      _cv_VideoCapture_create_1Ptr.asFunction<
          ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, int,
              ffi.Pointer<VideoCapture>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_create_2(
    int index,
    int apiPreference,
    ffi.Pointer<VideoCapture> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_create_2(
      index,
      apiPreference,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_create_2Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              ffi.Int,
              ffi.Int,
              ffi.Pointer<VideoCapture>,
              imp1.CvCallback_0)>>('cv_VideoCapture_create_2');
  late final _cv_VideoCapture_create_2 =
      _cv_VideoCapture_create_2Ptr.asFunction<
          ffi.Pointer<CvStatus> Function(
              int, int, ffi.Pointer<VideoCapture>, imp1.CvCallback_0)>();

  double cv_VideoCapture_get(
    VideoCapture self,
    int prop,
  ) {
    return _cv_VideoCapture_get(
      self,
      prop,
    );
  }

  late final _cv_VideoCapture_getPtr =
      _lookup<ffi.NativeFunction<ffi.Double Function(VideoCapture, ffi.Int)>>(
          'cv_VideoCapture_get');
  late final _cv_VideoCapture_get =
      _cv_VideoCapture_getPtr.asFunction<double Function(VideoCapture, int)>();

  ffi.Pointer<ffi.Char> cv_VideoCapture_getBackendName(
    VideoCapture self,
  ) {
    return _cv_VideoCapture_getBackendName(
      self,
    );
  }

  late final _cv_VideoCapture_getBackendNamePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Char> Function(VideoCapture)>>(
          'cv_VideoCapture_getBackendName');
  late final _cv_VideoCapture_getBackendName =
      _cv_VideoCapture_getBackendNamePtr
          .asFunction<ffi.Pointer<ffi.Char> Function(VideoCapture)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_grab(
    VideoCapture self,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_grab(
      self,
      callback,
    );
  }

  late final _cv_VideoCapture_grabPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture, imp1.CvCallback_0)>>('cv_VideoCapture_grab');
  late final _cv_VideoCapture_grab = _cv_VideoCapture_grabPtr.asFunction<
      ffi.Pointer<CvStatus> Function(VideoCapture, imp1.CvCallback_0)>();

  bool cv_VideoCapture_isOpened(
    VideoCapture self,
  ) {
    return _cv_VideoCapture_isOpened(
      self,
    );
  }

  late final _cv_VideoCapture_isOpenedPtr =
      _lookup<ffi.NativeFunction<ffi.Bool Function(VideoCapture)>>(
          'cv_VideoCapture_isOpened');
  late final _cv_VideoCapture_isOpened =
      _cv_VideoCapture_isOpenedPtr.asFunction<bool Function(VideoCapture)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_open(
    VideoCapture self,
    ffi.Pointer<ffi.Char> uri,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_open(
      self,
      uri,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_openPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoCapture_open');
  late final _cv_VideoCapture_open = _cv_VideoCapture_openPtr.asFunction<
      ffi.Pointer<CvStatus> Function(VideoCapture, ffi.Pointer<ffi.Char>,
          ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_open_1(
    VideoCapture self,
    ffi.Pointer<ffi.Char> uri,
    int apiPreference,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_open_1(
      self,
      uri,
      apiPreference,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_open_1Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture,
              ffi.Pointer<ffi.Char>,
              ffi.Int,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoCapture_open_1');
  late final _cv_VideoCapture_open_1 = _cv_VideoCapture_open_1Ptr.asFunction<
      ffi.Pointer<CvStatus> Function(VideoCapture, ffi.Pointer<ffi.Char>, int,
          ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_open_2(
    VideoCapture self,
    int device,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_open_2(
      self,
      device,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_open_2Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture,
              ffi.Int,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoCapture_open_2');
  late final _cv_VideoCapture_open_2 = _cv_VideoCapture_open_2Ptr.asFunction<
      ffi.Pointer<CvStatus> Function(
          VideoCapture, int, ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_open_3(
    VideoCapture self,
    int device,
    int apiPreference,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_open_3(
      self,
      device,
      apiPreference,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_open_3Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture,
              ffi.Int,
              ffi.Int,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoCapture_open_3');
  late final _cv_VideoCapture_open_3 = _cv_VideoCapture_open_3Ptr.asFunction<
      ffi.Pointer<CvStatus> Function(
          VideoCapture, int, int, ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_read(
    VideoCapture self,
    Mat buf,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_read(
      self,
      buf,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_readPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture,
              Mat,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoCapture_read');
  late final _cv_VideoCapture_read = _cv_VideoCapture_readPtr.asFunction<
      ffi.Pointer<CvStatus> Function(
          VideoCapture, Mat, ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_release(
    VideoCapture self,
  ) {
    return _cv_VideoCapture_release(
      self,
    );
  }

  late final _cv_VideoCapture_releasePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<CvStatus> Function(VideoCapture)>>(
          'cv_VideoCapture_release');
  late final _cv_VideoCapture_release = _cv_VideoCapture_releasePtr
      .asFunction<ffi.Pointer<CvStatus> Function(VideoCapture)>();

  ffi.Pointer<CvStatus> cv_VideoCapture_retrieve(
    VideoCapture self,
    Mat image,
    int flag,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoCapture_retrieve(
      self,
      image,
      flag,
      rval,
      callback,
    );
  }

  late final _cv_VideoCapture_retrievePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoCapture,
              Mat,
              ffi.Int,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoCapture_retrieve');
  late final _cv_VideoCapture_retrieve =
      _cv_VideoCapture_retrievePtr.asFunction<
          ffi.Pointer<CvStatus> Function(VideoCapture, Mat, int,
              ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  void cv_VideoCapture_set(
    VideoCapture self,
    int prop,
    double val,
  ) {
    return _cv_VideoCapture_set(
      self,
      prop,
      val,
    );
  }

  late final _cv_VideoCapture_setPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              VideoCapture, ffi.Int, ffi.Double)>>('cv_VideoCapture_set');
  late final _cv_VideoCapture_set = _cv_VideoCapture_setPtr
      .asFunction<void Function(VideoCapture, int, double)>();

  void cv_VideoWriter_close(
    VideoWriterPtr self,
  ) {
    return _cv_VideoWriter_close(
      self,
    );
  }

  late final _cv_VideoWriter_closePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(VideoWriterPtr)>>(
          'cv_VideoWriter_close');
  late final _cv_VideoWriter_close =
      _cv_VideoWriter_closePtr.asFunction<void Function(VideoWriterPtr)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_create(
    ffi.Pointer<VideoWriter> rval,
  ) {
    return _cv_VideoWriter_create(
      rval,
    );
  }

  late final _cv_VideoWriter_createPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              ffi.Pointer<VideoWriter>)>>('cv_VideoWriter_create');
  late final _cv_VideoWriter_create = _cv_VideoWriter_createPtr
      .asFunction<ffi.Pointer<CvStatus> Function(ffi.Pointer<VideoWriter>)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_create_1(
    ffi.Pointer<ffi.Char> name,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    ffi.Pointer<VideoWriter> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoWriter_create_1(
      name,
      fourcc,
      fps,
      width,
      height,
      isColor,
      rval,
      callback,
    );
  }

  late final _cv_VideoWriter_create_1Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              ffi.Pointer<ffi.Char>,
              ffi.Int,
              ffi.Double,
              ffi.Int,
              ffi.Int,
              ffi.Bool,
              ffi.Pointer<VideoWriter>,
              imp1.CvCallback_0)>>('cv_VideoWriter_create_1');
  late final _cv_VideoWriter_create_1 = _cv_VideoWriter_create_1Ptr.asFunction<
      ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, int, double, int,
          int, bool, ffi.Pointer<VideoWriter>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_create_2(
    ffi.Pointer<ffi.Char> name,
    int apiPreference,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    ffi.Pointer<VideoWriter> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoWriter_create_2(
      name,
      apiPreference,
      fourcc,
      fps,
      width,
      height,
      isColor,
      rval,
      callback,
    );
  }

  late final _cv_VideoWriter_create_2Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              ffi.Pointer<ffi.Char>,
              ffi.Int,
              ffi.Int,
              ffi.Double,
              ffi.Int,
              ffi.Int,
              ffi.Bool,
              ffi.Pointer<VideoWriter>,
              imp1.CvCallback_0)>>('cv_VideoWriter_create_2');
  late final _cv_VideoWriter_create_2 = _cv_VideoWriter_create_2Ptr.asFunction<
      ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, int, int, double,
          int, int, bool, ffi.Pointer<VideoWriter>, imp1.CvCallback_0)>();

  int cv_VideoWriter_fourcc(
    int c1,
    int c2,
    int c3,
    int c4,
  ) {
    return _cv_VideoWriter_fourcc(
      c1,
      c2,
      c3,
      c4,
    );
  }

  late final _cv_VideoWriter_fourccPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Char, ffi.Char, ffi.Char,
              ffi.Char)>>('cv_VideoWriter_fourcc');
  late final _cv_VideoWriter_fourcc =
      _cv_VideoWriter_fourccPtr.asFunction<int Function(int, int, int, int)>();

  double cv_VideoWriter_get(
    VideoWriter self,
    int propId,
  ) {
    return _cv_VideoWriter_get(
      self,
      propId,
    );
  }

  late final _cv_VideoWriter_getPtr =
      _lookup<ffi.NativeFunction<ffi.Double Function(VideoWriter, ffi.Int)>>(
          'cv_VideoWriter_get');
  late final _cv_VideoWriter_get =
      _cv_VideoWriter_getPtr.asFunction<double Function(VideoWriter, int)>();

  ffi.Pointer<ffi.Char> cv_VideoWriter_getBackendName(
    VideoWriter self,
  ) {
    return _cv_VideoWriter_getBackendName(
      self,
    );
  }

  late final _cv_VideoWriter_getBackendNamePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Char> Function(VideoWriter)>>(
          'cv_VideoWriter_getBackendName');
  late final _cv_VideoWriter_getBackendName = _cv_VideoWriter_getBackendNamePtr
      .asFunction<ffi.Pointer<ffi.Char> Function(VideoWriter)>();

  bool cv_VideoWriter_isOpened(
    VideoWriter self,
  ) {
    return _cv_VideoWriter_isOpened(
      self,
    );
  }

  late final _cv_VideoWriter_isOpenedPtr =
      _lookup<ffi.NativeFunction<ffi.Bool Function(VideoWriter)>>(
          'cv_VideoWriter_isOpened');
  late final _cv_VideoWriter_isOpened =
      _cv_VideoWriter_isOpenedPtr.asFunction<bool Function(VideoWriter)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_open(
    VideoWriter self,
    ffi.Pointer<ffi.Char> name,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoWriter_open(
      self,
      name,
      fourcc,
      fps,
      width,
      height,
      isColor,
      rval,
      callback,
    );
  }

  late final _cv_VideoWriter_openPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoWriter,
              ffi.Pointer<ffi.Char>,
              ffi.Int,
              ffi.Double,
              ffi.Int,
              ffi.Int,
              ffi.Bool,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoWriter_open');
  late final _cv_VideoWriter_open = _cv_VideoWriter_openPtr.asFunction<
      ffi.Pointer<CvStatus> Function(VideoWriter, ffi.Pointer<ffi.Char>, int,
          double, int, int, bool, ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_open_1(
    VideoWriter self,
    ffi.Pointer<ffi.Char> name,
    int apiPreference,
    int fourcc,
    double fps,
    int width,
    int height,
    bool isColor,
    ffi.Pointer<ffi.Bool> rval,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoWriter_open_1(
      self,
      name,
      apiPreference,
      fourcc,
      fps,
      width,
      height,
      isColor,
      rval,
      callback,
    );
  }

  late final _cv_VideoWriter_open_1Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoWriter,
              ffi.Pointer<ffi.Char>,
              ffi.Int,
              ffi.Int,
              ffi.Double,
              ffi.Int,
              ffi.Int,
              ffi.Bool,
              ffi.Pointer<ffi.Bool>,
              imp1.CvCallback_0)>>('cv_VideoWriter_open_1');
  late final _cv_VideoWriter_open_1 = _cv_VideoWriter_open_1Ptr.asFunction<
      ffi.Pointer<CvStatus> Function(
          VideoWriter,
          ffi.Pointer<ffi.Char>,
          int,
          int,
          double,
          int,
          int,
          bool,
          ffi.Pointer<ffi.Bool>,
          imp1.CvCallback_0)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_release(
    VideoWriter self,
  ) {
    return _cv_VideoWriter_release(
      self,
    );
  }

  late final _cv_VideoWriter_releasePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<CvStatus> Function(VideoWriter)>>(
          'cv_VideoWriter_release');
  late final _cv_VideoWriter_release = _cv_VideoWriter_releasePtr
      .asFunction<ffi.Pointer<CvStatus> Function(VideoWriter)>();

  void cv_VideoWriter_set(
    VideoWriter self,
    int propId,
    double val,
  ) {
    return _cv_VideoWriter_set(
      self,
      propId,
      val,
    );
  }

  late final _cv_VideoWriter_setPtr = _lookup<
          ffi
          .NativeFunction<ffi.Void Function(VideoWriter, ffi.Int, ffi.Double)>>(
      'cv_VideoWriter_set');
  late final _cv_VideoWriter_set = _cv_VideoWriter_setPtr
      .asFunction<void Function(VideoWriter, int, double)>();

  ffi.Pointer<CvStatus> cv_VideoWriter_write(
    VideoWriter self,
    Mat img,
    imp1.CvCallback_0 callback,
  ) {
    return _cv_VideoWriter_write(
      self,
      img,
      callback,
    );
  }

  late final _cv_VideoWriter_writePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CvStatus> Function(
              VideoWriter, Mat, imp1.CvCallback_0)>>('cv_VideoWriter_write');
  late final _cv_VideoWriter_write = _cv_VideoWriter_writePtr.asFunction<
      ffi.Pointer<CvStatus> Function(VideoWriter, Mat, imp1.CvCallback_0)>();

  late final addresses = _SymbolAddresses(this);
}

class _SymbolAddresses {
  final CvNativeVideoIO _library;
  _SymbolAddresses(this._library);
  ffi.Pointer<ffi.NativeFunction<ffi.Void Function(VideoCapturePtr)>>
      get cv_VideoCapture_close => _library._cv_VideoCapture_closePtr;
  ffi.Pointer<ffi.NativeFunction<ffi.Void Function(VideoWriterPtr)>>
      get cv_VideoWriter_close => _library._cv_VideoWriter_closePtr;
}

typedef CvStatus = imp1.CvStatus;
typedef Mat = imp1.Mat;

final class VideoCapture extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

typedef VideoCapturePtr = ffi.Pointer<VideoCapture>;

final class VideoWriter extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

typedef VideoWriterPtr = ffi.Pointer<VideoWriter>;
