// ignore_for_file: unused_local_variable, avoid_print

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  const counts = 10000;
  final mat = cv.Mat.zeros(1000, 1000, cv.MatType.CV_8UC3);
  final sw = Stopwatch()..start();
  for (var count = 0; count < counts; count++) {
    final mat1 = cv.cvtColor(mat, cv.COLOR_BGR2YCrCb);
    // manually dispose will reduce the memory consumption
    mat1.dispose();
  }
  sw.stop();
  print(
      "All: ${sw.elapsedMicroseconds}μs, counts: $counts, per: ${sw.elapsedMicroseconds / counts} μs");
  print("Finished");
}
