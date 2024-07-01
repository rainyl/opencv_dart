library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class WeChatQRCode extends CvStruct<cvg.WeChatQRCode> {
  WeChatQRCode._(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory WeChatQRCode.fromPointer(cvg.WeChatQRCodePtr ptr,
          [bool attach = true]) =>
      WeChatQRCode._(ptr, attach);

  factory WeChatQRCode.empty() {
    final p = calloc<cvg.WeChatQRCode>();
    cvRun(() => CFFI.WeChatQRCode_New(p));
    return WeChatQRCode._(p);
  }

  /// Initialize the WeChatQRCode.
  /// It includes two models, which are packaged with caffe format.
  /// Therefore, there are prototxt and caffe models (In total, four paramenters).
  ///
  /// https://docs.opencv.org/4.x/d5/d04/classcv_1_1wechat__qrcode_1_1WeChatQRCode.html#a9c0dc4c37646a1a051340d6b0916f388
  factory WeChatQRCode([
    String detectorPrototxtPath = "",
    String detectorCaffeModelPath = "",
    String superResolutionPrototxtPath = "",
    String superResolutionCaffeModelPath = "",
  ]) {
    final arena = Arena();
    final p = calloc<cvg.WeChatQRCode>();
    final dp =
        detectorPrototxtPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final dm =
        detectorCaffeModelPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final srp = superResolutionPrototxtPath
        .toNativeUtf8(allocator: arena)
        .cast<ffi.Char>();
    final srm = superResolutionCaffeModelPath
        .toNativeUtf8(allocator: arena)
        .cast<ffi.Char>();
    cvRun(() => CFFI.WeChatQRCode_NewWithParams(dp, dm, srp, srm, p));
    arena.releaseAll();
    return WeChatQRCode._(p);
  }

  /// Both detects and decodes QR code. To simplify the usage, there is a only API: detectAndDecode.
  /// https://docs.opencv.org/4.x/d5/d04/classcv_1_1wechat__qrcode_1_1WeChatQRCode.html#a27c167d2d58e5ee4418fd3a9ed5876cc
  (List<String>, VecMat points) detectAndDecode(InputArray img,
      [VecMat? points]) {
    final p = calloc<cvg.VecMat>();
    final rval = calloc<cvg.VecVecChar>();
    cvRun(() => CFFI.WeChatQRCode_DetectAndDecode(ptr, img.ref, p, rval));
    final vec = VecVecChar.fromPointer(rval);
    final points = VecMat.fromPointer(p);
    return (vec.asStringList(), points);
  }

  /// https://docs.opencv.org/4.x/d5/d04/classcv_1_1wechat__qrcode_1_1WeChatQRCode.html#abf807138abc2626c159abd3e9a80e791
  double get scaleFactor {
    return cvRunArena<double>((arena) {
      final p = calloc<ffi.Float>();
      cvRun(() => CFFI.WeChatQRCode_GetScaleFactor(ptr, p));
      return p.value;
    });
  }

  /// set scale factor QR code detector use neural network to detect QR.
  /// Before running the neural network, the input image is pre-processed by scaling.
  /// By default, the input image is scaled to an image with an area of 160000 pixels.
  /// The scale factor allows to use custom scale the input image:
  /// width = scaleFactor*width height = scaleFactor*width
  ///
  /// scaleFactor valuse must be > 0 and <= 1,
  /// otherwise the scaleFactor value is set to -1 and
  /// use default scaled to an image with an area of 160000 pixels.
  ///
  /// https://docs.opencv.org/4.x/d5/d04/classcv_1_1wechat__qrcode_1_1WeChatQRCode.html#a084f9aa8693fa0a62c43dd10d2533ab8
  set scaleFactor(double scaleFactor) {
    cvRun(() => CFFI.WeChatQRCode_SetScaleFactor(ptr, scaleFactor));
  }

  static final finalizer =
      OcvFinalizer<cvg.WeChatQRCodePtr>(CFFI.addresses.WeChatQRCode_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.WeChatQRCode_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.WeChatQRCode get ref => ptr.ref;
}
