import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

final resultW = [6.410056, 3.4595323];
final resultU = [-0.32415637, -0.9460035, 0.94600356, -0.3241564];
final resultVt = [-0.32415637, 0.9460035, 0.9460035, -0.32415637];

bool checkFunc(List<double> a, List<double> b, {double eps = 1e-4}) {
  if (a.length != b.length) {
    return false;
  }
  return List.generate(a.length, (i) => a[i] - b[i] < eps).every((e) => e);
}

void checkSVD(cv.Mat w, cv.Mat u, cv.Mat vt) {
  expect(w.isEmpty || u.isEmpty || vt.isEmpty, false);
  expect(w.size, [2, 1]);
  expect(u.size, [2, 2]);
  expect(vt.size, [2, 2]);

  expect(checkFunc([w.at<double>(0, 0), w.at<double>(1, 0)], resultW), true);
  expect(
    checkFunc(
      [u.at<double>(0, 0), u.at<double>(0, 1), u.at<double>(1, 0), u.at<double>(1, 1)],
      resultU,
    ),
    true,
  );
  expect(
    checkFunc(
      [vt.at<double>(0, 0), vt.at<double>(0, 1), vt.at<double>(1, 0), vt.at<double>(1, 1)],
      resultVt,
    ),
    true,
  );
}

void main() async {
  test('SVD.compute', () async {
    final src = cv.Mat.zeros(2, 2, cv.MatType.CV_32FC1);
    src.set<double>(0, 0, 3.76956568);
    src.set<double>(0, 1, -0.90478725);
    src.set<double>(1, 0, -0.90478725);
    src.set<double>(1, 1, 6.10002347);
    expect(src.at<double>(0, 0), closeTo(3.76956568, 1e-4));

    {
      final w = cv.Mat.empty();
      final u = cv.Mat.empty();
      final vt = cv.Mat.empty();
      cv.SVD.compute(src, w: w, u: u, vt: vt);
      checkSVD(w, u, vt);
    }
    {
      final (w, u, vt) = await cv.SVD.computeAsync(src);
      checkSVD(w, u, vt);
    }
  });

  test('cv.SVD.backSubst', () async {
    final src = cv.Mat.zeros(2, 2, cv.MatType.CV_32FC1);
    src.set<double>(0, 0, 3.76956568);
    src.set<double>(0, 1, -0.90478725);
    src.set<double>(1, 0, -0.90478725);
    src.set<double>(1, 1, 6.10002347);
    expect(src.at<double>(0, 0), closeTo(3.76956568, 1e-4));
    {
      final w = cv.Mat.empty();
      final u = cv.Mat.empty();
      final vt = cv.Mat.empty();
      cv.SVD.compute(src, w: w, u: u, vt: vt);
      checkSVD(w, u, vt);
      final dst = cv.SVD.backSubst(w, u, vt, src);
      expect(dst.isEmpty, false);
    }
    {
      final (w, u, vt) = await cv.SVD.computeAsync(src);
      checkSVD(w, u, vt);
      final dst = await cv.SVD.backSubstAsync(w, u, vt, src);
      expect(dst.isEmpty, false);
    }
  });
}
