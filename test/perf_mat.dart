import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  const counts = 1000000;
  final mat = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
  final sw = Stopwatch()..start();
  for (var count = 0; count < counts; count++) {
    final mat1 = cv.cvtColor(mat, cv.COLOR_BGR2YCrCb);
  }
  sw.stop();
  print("All: ${sw.elapsedMicroseconds}μs, counts: $counts, per: ${sw.elapsedMicroseconds / counts} μs");
  print("Finished");
}
