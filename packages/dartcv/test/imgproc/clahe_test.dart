import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test("cv.CLAHE", () async {
    final mat = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final clahe = cv.CLAHE.create();
    {
      final dst = clahe.apply(mat);
      expect(dst.isEmpty, false);
    }

    {
      final clahe = cv.CLAHE.create();
      final dst = await clahe.applyAsync(mat);
      expect(dst.isEmpty, false);
    }

    clahe.clipLimit = 50;
    clahe.tilesGridSize = (10, 10).cvd;
    expect(clahe.tilesGridSize, cv.Size(10, 10));
    expect(clahe.clipLimit, closeTo(50, 1e-6));

    clahe.dispose();
  });
}
