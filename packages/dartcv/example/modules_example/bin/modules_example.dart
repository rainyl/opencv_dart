import 'package:dartcv4/dartcv.dart' as cv;
import 'package:modules_example/modules_example.dart' as modules_example;

void main(List<String> arguments) {
  print('Hello world: ${modules_example.calculate()}!');
  print("Hello OpenCV: ${cv.openCvVersion()}");
}
