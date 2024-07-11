import 'package:opencv_dart/opencv_dart.dart' as cv;

void main(List<String> args) {
  for (var i = 0; i < 100000; i++) {
    final vec = cv.VecPoint.generate(1000, (i) => cv.Point(i, i));
    // vec.dispose();
  print(vec.length);
  vec.dispose();
  }
}
