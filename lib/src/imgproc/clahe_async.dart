import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../opencv.g.dart' as cvg;
import 'clahe.dart';

extension CLAHEAsync on CLAHE {
  static Future<CLAHE> createAsync([
    double clipLimit = 40,
    (int width, int height) tileGridSize = (8, 8),
  ]) async =>
      cvRunAsync(
        (callback) => CFFI.CLAHE_CreateWithParams_Async(clipLimit, tileGridSize.cvd.ref, callback),
        (c, p) => c.complete(CLAHE.fromPointer(p.cast<cvg.CLAHE>())),
      );

  Future<Mat> applyAsync(Mat src) async =>
      cvRunAsync((callback) => CFFI.CLAHE_Apply_Async(ref, src.ref, callback), matCompleter);
}
