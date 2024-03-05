import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  cv.registerErrorCallback();
  final net = cv.Net.fromOnnx("test/models/googlenet-9.onnx");
  net.setPreferableBackend(cv.DNN_BACKEND_INFERENCE_ENGINE);
  final img = cv.imread("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);

  final blob = cv.blobFromImage(img,
      scalefactor: 1.0, size: (224, 224), mean: cv.Scalar.all(0), swapRB: true, crop: false);

  net.setInput(blob, name: "data_0");
  final probAsync = net.forwardAsync(outputName: "prob_1");
  final probMatAsync = probAsync.get();
}
