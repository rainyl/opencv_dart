@Tags(["no-local-files"])
import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

bool checkCaffeNet(cv.Net net) {
  expect(net.isEmpty, false);
  net.setPreferableBackend(cv.DNN_BACKEND_DEFAULT);
  net.setPreferableTarget(cv.DNN_TARGET_CPU);

  final img = cv.imread("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = cv.blobFromImage(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: false,
    crop: false,
  );
  expect(blob.isEmpty, false);

  net.setInput(blob, name: "data");
  final layer = net.getLayer(0);
  expect(layer.inputNameToIndex("notthere"), -1);
  expect(layer.outputNameToIndex("notthere"), -1);
  expect(layer.name, "_input");
  expect(layer.type, "");

  final ids = net.getUnconnectedOutLayers();
  expect((ids.length, ids.first), (1, 142));

  final lnames = net.getLayerNames();
  expect((lnames.length, lnames[1]), (142, "conv1/relu_7x7"));

  final prob = net.forwardLayers(["prob"]);
  expect(prob.length, greaterThan(0));
  expect(prob.first.isEmpty, false);

  final probMat = prob.first.reshape(1, 1);
  final (_, maxVal, minLoc, maxLoc) = cv.minMaxLoc(probMat);
  expect(maxVal, closeTo(0.9998, 5e-5));
  expect((minLoc.x, minLoc.y), (955, 0));
  expect((maxLoc.x, maxLoc.y), (812, 0));

  final (perf, layerTimes) = net.getPerfProfile();
  expect(perf, greaterThan(0));
  expect(layerTimes, isNotEmpty);

  return true;
}

bool checkTensorflow(cv.Net net) {
  expect(net.isEmpty, false);
  final img = cv.imread("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = cv.blobFromImage(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: true,
    crop: false,
  );
  expect(blob.isEmpty, false);

  net.setInput(blob, name: "input");
  final prob = net.forwardLayers(["softmax2"]);
  expect(prob.isEmpty, false);

  final probMat = prob.first.reshape(1, 1);
  final (_, maxVal, minLoc, maxLoc) = cv.minMaxLoc(probMat);
  expect(maxVal, closeTo(1.0, 5e-5));
  expect((minLoc.x, minLoc.y), (481, 0));
  expect((maxLoc.x, maxLoc.y), (234, 0));

  final (perf, layerTimes) = net.getPerfProfile();
  expect(perf, greaterThan(0));
  expect(layerTimes, isNotEmpty);

  return true;
}

bool checkOnnx(cv.Net net) {
  expect(net.isEmpty, false);
  final img = cv.imread("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = cv.blobFromImage(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: true,
    crop: false,
  );
  expect(blob.size, [1, 3, 224, 224]);
  expect(blob.isEmpty, false);

  net.setInput(blob, name: "data_0");
  final prob = net.forwardLayers(["prob_1"]);
  expect(prob.isEmpty, false);

  final probMat = prob.first.reshape(1, 1);
  final (_, maxVal, minLoc, maxLoc) = cv.minMaxLoc(probMat);
  expect(maxVal, closeTo(0.9965, 5e-3));
  expect((minLoc.x, minLoc.y), (955, 0));
  expect((maxLoc.x, maxLoc.y), (812, 0));

  // final probAsync = net.forwardAsync(outputName: "prob_1");
  // final probMatAsync = probAsync.get();
  // expect(probMatAsync.isEmpty, false);

  final (perf, layerTimes) = net.getPerfProfile();
  expect(perf, greaterThan(0));
  expect(layerTimes, isNotEmpty);
  return true;
}

bool checkTflite(cv.Net net) {
  expect(net.isEmpty, false);
  final img = cv.imread("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = cv.blobFromImage(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: true,
    crop: false,
  );
  expect(blob.isEmpty, false);

  // TODO: TFLite support of opencv is not complete

  // print(net.getLayerNames());
  // net.setInput(blob, name: "inputs_0");
  return true;
}

void main() async {
  test('cv.Net.fromFile', () async {
    final net = cv.Net.empty();
    expect(net.isEmpty, true);

    final model = cv.Net.fromFile(
      "test/models/bvlc_googlenet.caffemodel",
      config: "test/models/bvlc_googlenet.prototxt",
    );
    checkCaffeNet(model);
    expect(model.dump(), isNotEmpty);

    net.dispose();
  });

  test('cv.Net.fromBytes', () {
    final bytes = File("test/models/bvlc_googlenet.caffemodel").readAsBytesSync();
    final config = File("test/models/bvlc_googlenet.prototxt").readAsBytesSync();
    final model = cv.Net.fromBytes("caffe", bytes, bufferConfig: config);
    checkCaffeNet(model);

    model.dispose();
  });

  test('cv.Net.fromCaffe', () {
    final model =
        cv.Net.fromCaffe("test/models/bvlc_googlenet.prototxt", "test/models/bvlc_googlenet.caffemodel");
    checkCaffeNet(model);
  });

  test('cv.Net.fromCaffeBytes', () {
    final bytes = File("test/models/bvlc_googlenet.caffemodel").readAsBytesSync();
    final config = File("test/models/bvlc_googlenet.prototxt").readAsBytesSync();
    final model = cv.Net.fromCaffeBytes(config, bytes);
    checkCaffeNet(model);
  });

  test('cv.Net.fromOnnx', () {
    final model = cv.Net.fromOnnx("test/models/googlenet-9.onnx");
    checkOnnx(model);
  });

  test('cv.Net.fromOnnxBytes', () {
    final bytes = File("test/models/googlenet-9.onnx").readAsBytesSync();
    final model = cv.Net.fromOnnxBytes(bytes);
    checkOnnx(model);
  });

  test('cv.Net.fromTensorflow', () {
    final model = cv.Net.fromTensorflow("test/models/tensorflow_inception_graph.pb");
    expect(model.isEmpty, false);
    checkTensorflow(model);
  });

  test('cv.Net.fromTensorflowBytes', () {
    final bytes = File("test/models/tensorflow_inception_graph.pb").readAsBytesSync();
    final model = cv.Net.fromTensorflowBytes(bytes);
    expect(model.isEmpty, false);
    checkTensorflow(model);
  });

  test('cv.Net.fromTFLite', skip: true, () {
    final model = cv.Net.fromTFLite("test/models/face_landmark.tflite");
    print(model.getUnconnectedOutLayersNames());
    checkTflite(model);
  });

  test('cv.Net.fromTorch', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final model = cv.Net.fromTorch("test/models/openface.nn4.small2.v1.t7");
    expect(model.isEmpty, false);

    final blob = cv.blobFromImage(
      img,
      scalefactor: 1.0,
      size: (224, 224),
      mean: cv.Scalar.all(0),
      swapRB: false,
      crop: false,
    );
    expect(blob.isEmpty, false);
  });

  test("cv.getAvailableBackends, getAvailableTargets", () {
    cv.enableModelDiagnostics(true);
    final backends = cv.getAvailableBackends();
    expect(backends, isNotEmpty);
    final targets = cv.getAvailableTargets(cv.DNN_BACKEND_DEFAULT);
    expect(targets, isNotEmpty);
  });

  test('cv.blobFromImages, cv.imagesFromBlob, cv.getBlobChannel', () {
    final imgs = [
      cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR),
      cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR),
    ].cvd;

    final blob = cv.blobFromImages(imgs);
    expect(blob.isEmpty, false);
    expect(cv.getBlobSize(blob), [2, 3, 480, 512]);

    final images = cv.imagesFromBlob(blob);
    expect(images.length, 2);
    expect((images.first.rows, images.first.cols), (imgs.first.rows, imgs.first.cols));
    expect((images.last.rows, images.last.cols), (imgs.last.rows, imgs.last.cols));

    final ch2 = cv.getBlobChannel(blob, 0, 1);
    expect(ch2.isEmpty, false);
    expect((ch2.rows, ch2.cols), (imgs.first.rows, imgs.first.cols));
  });

  test('cv.blobFromImages GrayScale', () {
    final imgs = [
      cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE),
      cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE),
    ].cvd;

    final blob = cv.blobFromImages(imgs);
    expect(blob.isEmpty, false);
    expect(cv.getBlobSize(blob), [2, 1, 480, 512]);
  });

  test('cv.NMSBoxes', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    img.convertTo(cv.MatType.CV_32FC1);

    final bboxes = [
      cv.Rect(53, 47, 589, 451),
      cv.Rect(118, 54, 618, 450),
      cv.Rect(53, 66, 605, 480),
      cv.Rect(111, 65, 630, 480),
      cv.Rect(156, 51, 640, 480),
    ].cvd;
    final scores = [0.82094115, 0.7998236, 0.9809663, 0.99717456, 0.89628726].f32;
    final indices = cv.NMSBoxes(bboxes, scores, 0.5, 0.4);
    expect(indices.first, 3);
  });
}
