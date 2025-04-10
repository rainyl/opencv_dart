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
@ffi.DefaultAsset('package:dartcv4/dartcv.dart')
library;

import 'dart:ffi' as ffi;
import 'package:dartcv4/src/g/types.g.dart' as imp1;

@ffi.Native<ffi.Bool Function(ffi.Pointer<ffi.Char>)>()
external bool cv_haveImageReader(
  ffi.Pointer<ffi.Char> filename,
);

@ffi.Native<ffi.Bool Function(ffi.Pointer<ffi.Char>)>()
external bool cv_haveImageWriter(
  ffi.Pointer<ffi.Char> filename,
);

@ffi.Native<ffi.Size Function(ffi.Pointer<ffi.Char>, ffi.Int)>()
external int cv_imcount(
  ffi.Pointer<ffi.Char> filename,
  int flags,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(VecUChar, ffi.Int, ffi.Pointer<Mat>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_imdecode(
  VecUChar buf,
  int flags,
  ffi.Pointer<Mat> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        ffi.Pointer<ffi.Char>, Mat, ffi.Pointer<ffi.Bool>, ffi.Pointer<VecUChar>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_imencode(
  ffi.Pointer<ffi.Char> fileExt,
  Mat img,
  ffi.Pointer<ffi.Bool> success,
  ffi.Pointer<VecUChar> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, Mat, VecI32, ffi.Pointer<ffi.Bool>,
        ffi.Pointer<VecUChar>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_imencode_1(
  ffi.Pointer<ffi.Char> fileExt,
  Mat img,
  VecI32 params,
  ffi.Pointer<ffi.Bool> success,
  ffi.Pointer<VecUChar> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, ffi.Int, ffi.Pointer<Mat>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_imread(
  ffi.Pointer<ffi.Char> filename,
  int flags,
  ffi.Pointer<Mat> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, Mat, ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_imwrite(
  ffi.Pointer<ffi.Char> filename,
  Mat img,
  ffi.Pointer<ffi.Bool> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        ffi.Pointer<ffi.Char>, Mat, VecI32, ffi.Pointer<ffi.Bool>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_imwrite_1(
  ffi.Pointer<ffi.Char> filename,
  Mat img,
  VecI32 params,
  ffi.Pointer<ffi.Bool> rval,
  imp1.CvCallback_0 callback,
);

typedef CvStatus = imp1.CvStatus;
typedef Mat = imp1.Mat;
typedef VecI32 = imp1.VecI32;
typedef VecUChar = imp1.VecUChar;
