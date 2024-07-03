library cv;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import 'wechat_qrcode.dart';

extension WeChatQRCodeAsync on WeChatQRCode {
  static Future<WeChatQRCode> emptyAsync() async => cvRunAsync<WeChatQRCode>(
        CFFI.WeChatQRCode_New_Async,
        (c, p) => c.complete(WeChatQRCode.fromPointer(p.cast<cvg.WeChatQRCode>())),
      );

  static Future<WeChatQRCode> createAsync([
    String detectorPrototxtPath = "",
    String detectorCaffeModelPath = "",
    String superResolutionPrototxtPath = "",
    String superResolutionCaffeModelPath = "",
  ]) async {
    final arena = Arena();
    final dp = detectorPrototxtPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final dm = detectorCaffeModelPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final srp = superResolutionPrototxtPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final srm = superResolutionCaffeModelPath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
    final rval = cvRunAsync<WeChatQRCode>(
      (callback) => CFFI.WeChatQRCode_NewWithParams_Async(dp, dm, srp, srm, callback),
      (c, p) => c.complete(WeChatQRCode.fromPointer(p.cast<cvg.WeChatQRCode>())),
    );
    arena.releaseAll();
    return rval;
  }

  Future<(List<String>, VecMat)> detectAndDecodeAsync(InputArray img) async =>
      cvRunAsync2<(List<String>, VecMat)>(
          (callback) => CFFI.WeChatQRCode_DetectAndDecode_Async(ptr, img.ref, callback), (c, p, p2) {
        final vec = VecVecChar.fromPointer(p.cast<cvg.VecVecChar>());
        final points = VecMat.fromPointer(p2.cast<cvg.VecMat>());
        final rval = vec.asStringList();
        vec.dispose();
        return c.complete((rval, points));
      });
}
