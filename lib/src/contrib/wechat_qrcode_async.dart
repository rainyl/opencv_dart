library cv;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import 'wechat_qrcode.dart';

extension WeChatQRCodeAsync on WeChatQRCode {
  static Future<WeChatQRCode> emptyAsync() async {
    final rval = await cvRunAsync<WeChatQRCode>(CFFI.WeChatQRCode_New_Async, (c, p) {
      return c.complete(WeChatQRCode.fromPointer(p.cast<cvg.WeChatQRCode>()));
    });
    return rval;
  }

  static Future<WeChatQRCode> createAsync(
      [String detectorPrototxtPath = "",
      String detectorCaffeModelPath = "",
      String superResolutionPrototxtPath = "",
      String superResolutionCaffeModelPath = ""]) async {
    final arena = Arena();
    final p = calloc<cvg.WeChatQRCode>();
    final dp = detectorPrototxtPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final dm = detectorCaffeModelPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final srp = superResolutionPrototxtPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final srm = superResolutionCaffeModelPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final rval = await cvRunAsync<WeChatQRCode>(
        (callback) => CFFI.WeChatQRCode_NewWithParams_Async(dp, dm, srp, srm, callback), (c, p) {
      arena.releaseAll();
      return c.complete(WeChatQRCode.fromPointer(p.cast<cvg.WeChatQRCode>()));
    });
    return rval;
  }

  Future<(List<String>, VecMat)> detectAndDecodeAsync(InputArray img) async {
    final rval = await cvRunAsync2<(List<String>, VecMat)>(
        (callback) => CFFI.WeChatQRCode_DetectAndDecode_Async(ptr, img.ref, callback), (c, p, p2) {
      final vec = VecVecChar.fromPointer(p.cast<cvg.VecVecChar>());
      final points = VecMat.fromPointer(p.cast<cvg.VecMat>());
      return c.complete((vec.asStringList(), points));
    });
    return rval;
  }

  Future<double> get scaleFactorAsync async {
    final rval =
        await cvRunAsync<double>((callback) => CFFI.WeChatQRCode_GetScaleFactor_Async(ptr, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setScaleFactorAsync(double scaleFactor) async {
    await cvRunAsync0<void>((callback) => CFFI.WeChatQRCode_SetScaleFactor_Async(ptr, scaleFactor, callback),
        (c) => c.complete());
  }
}
