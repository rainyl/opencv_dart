import 'package:dartcv/dartcv.dart' as cv;

void main() {
  final image = cv.Mat.zeros(3, 3, cv.MatType.CV_8UC3);
  cv.randu(image, cv.Scalar.all(0.0), cv.Scalar(255.0));
  print(image);
}
