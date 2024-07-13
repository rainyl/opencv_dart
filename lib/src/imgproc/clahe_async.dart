library cv.imgproc.clahe;

import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../g/imgproc.g.dart' as cvg;
import '../native_lib.dart' show cimgproc;
import 'clahe.dart';

extension CLAHEAsync on CLAHE {
  static Future<CLAHE> createAsync([
    double clipLimit = 40,
    (int width, int height) tileGridSize = (8, 8),
  ]) async =>
      cvRunAsync(
        (callback) => cimgproc.CLAHE_CreateWithParams_Async(clipLimit, tileGridSize.cvd.ref, callback),
        (c, p) => c.complete(CLAHE.fromPointer(p.cast<cvg.CLAHE>())),
      );

  Future<Mat> applyAsync(Mat src) async =>
      cvRunAsync((callback) => cimgproc.CLAHE_Apply_Async(ref, src.ref, callback), matCompleter);
}
