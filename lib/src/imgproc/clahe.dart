library cv.imgproc.clahe;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../g/imgproc.g.dart' as cvg;
import '../native_lib.dart' show cimgproc;

class CLAHE extends CvStruct<cvg.CLAHE> {
  CLAHE._(cvg.CLAHEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory CLAHE.fromPointer(cvg.CLAHEPtr ptr) => CLAHE._(ptr);
  factory CLAHE.empty() {
    final p = calloc<cvg.CLAHE>();
    cimgproc.CLAHE_Create(p);
    return CLAHE._(p);
  }

  factory CLAHE([double clipLimit = 40, (int width, int height) tileGridSize = (8, 8)]) =>
      CLAHE.create(clipLimit, tileGridSize);

  /// NewCLAHE returns a new CLAHE algorithm
  ///
  /// For further details, please see:
  /// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html
  factory CLAHE.create([double clipLimit = 40, (int width, int height) tileGridSize = (8, 8)]) {
    final p = calloc<cvg.CLAHE>();
    final size = calloc<cvg.Size>()
      ..ref.width = tileGridSize.$1
      ..ref.height = tileGridSize.$2;
    cimgproc.CLAHE_CreateWithParams(clipLimit, size.ref, p);
    calloc.free(size);
    return CLAHE._(p);
  }

  /// Apply CLAHE.
  ///
  /// For further details, please see:
  /// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html#a4e92e0e427de21be8d1fae8dcd862c5e
  Mat apply(Mat src, {Mat? dst}) {
    dst ??= Mat.empty();
    cvRun(() => cimgproc.CLAHE_Apply(ref, src.ref, dst!.ref));
    return dst;
  }

  double get clipLimit {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cimgproc.CLAHE_GetClipLimit(ref, p));
      return p.value;
    });
  }

  set clipLimit(double value) {
    cvRun(() => cimgproc.CLAHE_SetClipLimit(ref, value));
  }

  Size get tilesGridSize {
    final p = calloc<cvg.Size>();
    cvRun(() => cimgproc.CLAHE_GetTilesGridSize(ref, p));
    return Size.fromPointer(p);
  }

  set tilesGridSize(Size value) => cvRun(() => cimgproc.CLAHE_SetTilesGridSize(ref, value.ref));

  static final finalizer = OcvFinalizer<cvg.CLAHEPtr>(cimgproc.addresses.CLAHE_Close);

  void dispose() {
    finalizer.detach(this);
    cimgproc.CLAHE_Close(ptr);
  }

  @override
  cvg.CLAHE get ref => ptr.ref;
}
