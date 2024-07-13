import 'package:opencv_dart/gapi.dart' as cv_gapi;
import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  test("cv.GMat", () {
    {
      final m = cv_gapi.GMat.empty();
      expect(m.ptr.address, isNonZero);
    }

    {
      final m = cv.Mat.zeros(10, 10, cv.MatType.CV_8UC1);
      final gm = cv_gapi.GMat.fromMat(m);
      expect(gm.ptr.address, isNonZero);
    }
  });

  test("cv.GScalar", () {
    {
      final m = cv_gapi.GScalar.empty();
      expect(m.ptr.address, isNonZero);
    }

    {
      final s = cv.Scalar(2, 5, 4, 1);
      final gs = cv_gapi.GScalar.fromScalar(s);
      expect(gs.ptr.address, isNonZero);
    }

    {
      final gs = cv_gapi.GScalar(2541);
      expect(gs.ptr.address, isNonZero);
    }
  });

  test("cv.GComputation", () async {
    {
      final gmIn = cv_gapi.GMat.empty();
      final gmOut = cv_gapi.addMat(gmIn, gmIn);
      final gmOut1 = cv_gapi.addC(gmOut, cv_gapi.GScalar(21));
      final computation = cv_gapi.GComputation.mimo(gmIn, gmOut1);

      final inMat = cv.Mat.ones(10, 10, cv.MatType.CV_8UC1).setTo(cv.Scalar(21, 21, 21, 21));
      final outMat = await computation.apply(inMat);
      expect(outMat.at<int>(0, 1), 63);
      expect(computation.ptr.address, isNonZero);
    }
  });
}
