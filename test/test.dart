import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  print(cv.openCvVersion());
  final img = cv.imread("test/images/chessboard_4x6_distort.png", flags: cv.IMREAD_GRAYSCALE);

  final (found, corners) = cv.findChessboardCorners(img, (4, 6), flags: 0);

  final objectPointsVector = cv.Contours3f.fromList([
    List.generate(
      3 * 4,
      (i) => cv.Point3f(
        (i ~/ 3).toDouble() * 100,
        (i % 3).toDouble() * 100,
        0.0,
      ),
    ),
  ]);
  print(objectPointsVector);
  final imagePointsVector = cv.Contours2f.fromList([
    cv.ListPoint2f.fromMat(corners),
  ]);
  print(imagePointsVector);

  final cameraMatrix = cv.Mat.empty(), distCoeffs = cv.Mat.empty();
  final rcvs = cv.Mat.empty();
  final tcvs = cv.Mat.empty();
  cv.calibrateCamera(
    objectPointsVector,
    imagePointsVector,
    (img.rows, img.cols),
    cameraMatrix,
    distCoeffs,
    rvecs: rcvs,
    tvecs: tcvs,
    flags: 0,
  );
  print("Finished");
}
