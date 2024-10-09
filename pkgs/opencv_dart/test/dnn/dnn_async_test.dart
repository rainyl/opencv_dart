@Tags(["no-local-files"])

import 'dart:io';
import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

Future<bool> checkCaffeNetAsync(cv.Net net) async {
  expect(net.isEmpty, false);
  await net.setPreferableBackendAsync(cv.DNN_BACKEND_DEFAULT);
  await net.setPreferableTargetAsync(cv.DNN_TARGET_CPU);

  final img = await cv.imreadAsync("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = await cv.blobFromImageAsync(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: false,
    crop: false,
  );
  expect(blob.isEmpty, false);

  await net.setInputAsync(blob, name: "data");
  final layer = await net.getLayerAsync(0);
  expect(await layer.inputNameToIndexAsync("notthere"), -1);
  expect(await layer.outputNameToIndexAsync("notthere"), -1);

  final ids = await net.getUnconnectedOutLayersAsync();
  expect((ids.length, ids.first), (1, 142));

  final lnames = await net.getLayerNamesAsync();
  expect((lnames.length, lnames[1]), (142, "conv1/relu_7x7"));

  final prob = await net.forwardLayersAsync(["prob"]);
  expect(prob.length, greaterThan(0));
  expect(prob.first.isEmpty, false);

  final probMat = prob.first.reshape(1, 1);
  final (_, maxVal, minLoc, maxLoc) = await cv.minMaxLocAsync(probMat);
  expect(maxVal, closeTo(0.9998, 5e-5));
  expect((minLoc.x, minLoc.y), (955, 0));
  expect((maxLoc.x, maxLoc.y), (812, 0));

  final perf = await net.getPerfProfileAsync();
  expect(perf, greaterThan(0));

  return true;
}

Future<bool> checkTensorflowAsync(cv.Net net) async {
  expect(net.isEmpty, false);
  final img = await cv.imreadAsync("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = await cv.blobFromImageAsync(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: true,
    crop: false,
  );
  expect(blob.isEmpty, false);

  await net.setInputAsync(blob, name: "input");
  final prob = await net.forwardLayersAsync(["softmax2"]);
  expect(prob.isEmpty, false);

  final probMat = prob.first.reshape(1, 1);
  final (_, maxVal, minLoc, maxLoc) = await cv.minMaxLocAsync(probMat);
  expect(maxVal, closeTo(1.0, 5e-5));
  expect((minLoc.x, minLoc.y), (481, 0));
  expect((maxLoc.x, maxLoc.y), (234, 0));

  final perf = await net.getPerfProfileAsync();
  expect(perf, greaterThan(0));

  return true;
}

Future<bool> checkOnnxAsync(cv.Net net) async {
  expect(net.isEmpty, false);
  final img = await cv.imreadAsync("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = await cv.blobFromImageAsync(
    img,
    scalefactor: 1.0,
    size: (224, 224),
    mean: cv.Scalar.all(0),
    swapRB: true,
    crop: false,
  );
  expect(blob.isEmpty, false);

  await net.setInputAsync(blob, name: "data_0");
  final prob = await net.forwardLayersAsync(["prob_1"]);
  expect(prob.isEmpty, false);

  final probMat = prob.first.reshape(1, 1);
  final (_, maxVal, minLoc, maxLoc) = await cv.minMaxLocAsync(probMat);
  expect(maxVal, closeTo(0.9965, 5e-3));
  expect((minLoc.x, minLoc.y), (955, 0));
  expect((maxLoc.x, maxLoc.y), (812, 0));

  final perf = await net.getPerfProfileAsync();
  expect(perf, greaterThan(0));

  return true;
}

Future<bool> checkTfliteAsync(cv.Net net) async {
  expect(net.isEmpty, false);
  final img = await cv.imreadAsync("test/images/space_shuttle.jpg", flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final blob = await cv.blobFromImageAsync(
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
  test('cv.NetAsync.fromFileAsync', () async {
    final net = await cv.NetAsync.emptyAsync();
    expect(net.isEmpty, true);

    final model = await cv.NetAsync.fromFileAsync(
      "test/models/bvlc_googlenet.caffemodel",
      config: "test/models/bvlc_googlenet.prototxt",
    );
    await checkCaffeNetAsync(model);
    expect(await model.dumpAsync(), isNotEmpty);

    model.dispose();
  });

  test('cv.NetAsync.fromBytesAsync', () async {
    final bytes = await File("test/models/bvlc_googlenet.caffemodel").readAsBytes();
    final config = await File("test/models/bvlc_googlenet.prototxt").readAsBytes();
    final model = await cv.NetAsync.fromBytesAsync("caffe", bytes, bufferConfig: config);
    await checkCaffeNetAsync(model);

    model.dispose();
  });

  test('cv.NetAsync.fromCaffeAsync', () async {
    final model = await cv.NetAsync.fromCaffeAsync(
      "test/models/bvlc_googlenet.prototxt",
      "test/models/bvlc_googlenet.caffemodel",
    );
    await checkCaffeNetAsync(model);
  });

  test('cv.NetAsync.fromCaffeBytesAsync', () async {
    final bytes = await File("test/models/bvlc_googlenet.caffemodel").readAsBytes();
    final config = await File("test/models/bvlc_googlenet.prototxt").readAsBytes();
    final model = await cv.NetAsync.fromCaffeBytesAsync(config, bytes);
    await checkCaffeNetAsync(model);
  });

  test('cv.NetAsync.fromOnnxAsync', () async {
    final model = await cv.NetAsync.fromOnnxAsync("test/models/googlenet-9.onnx");
    await checkOnnxAsync(model);
  });

  test('cv.NetAsync.fromOnnxBytesAsync', () async {
    final bytes = await File("test/models/googlenet-9.onnx").readAsBytes();
    final model = await cv.NetAsync.fromOnnxBytesAsync(bytes);
    await checkOnnxAsync(model);
  });

  test('cv.NetAsync.fromTensorflowAsync', () async {
    final model = await cv.NetAsync.fromTensorflowAsync("test/models/tensorflow_inception_graph.pb");
    expect(model.isEmpty, false);
    await checkTensorflowAsync(model);
  });

  test('cv.NetAsync.fromTensorflowBytesAsync', () async {
    final bytes = await File("test/models/tensorflow_inception_graph.pb").readAsBytes();
    final model = await cv.NetAsync.fromTensorflowBytesAsync(bytes);
    expect(model.isEmpty, false);
    await checkTensorflowAsync(model);
  });

  test('cv.NetAsync.fromTFLiteAsync', skip: true, () async {
    final model = await cv.NetAsync.fromTFLiteAsync("test/models/googlenet_float32.tflite");
    await checkTfliteAsync(model);
  });

  test('cv.NetAsync.fromTorchAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final model = await cv.NetAsync.fromTorchAsync("test/models/openface.nn4.small2.v1.t7");
    expect(model.isEmpty, false);

    final blob = await cv.blobFromImageAsync(
      img,
      scalefactor: 1.0,
      size: (224, 224),
      mean: cv.Scalar.all(0),
      swapRB: false,
      crop: false,
    );
    expect(blob.isEmpty, false);
  });

  test('cv.blobFromImagesAsync, cv.imagesFromBlobAsync, cv.getBlobChannelAsync', () async {
    final imgs = [
      await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR),
      await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR),
    ].cvd;

    final blob = await cv.blobFromImagesAsync(imgs);
    expect(blob.isEmpty, false);
    expect(await cv.getBlobSizeAsync(blob), cv.Scalar(2, 3, 480, 512));

    final images = await cv.imagesFromBlobAsync(blob);
    expect(images.length, 2);
    expect((images.first.rows, images.first.cols), (imgs.first.rows, imgs.first.cols));
    expect((images.last.rows, images.last.cols), (imgs.last.rows, imgs.last.cols));

    final ch2 = await cv.getBlobChannelAsync(blob, 0, 1);
    expect(ch2.isEmpty, false);
    expect((ch2.rows, ch2.cols), (imgs.first.rows, imgs.first.cols));
  });

  test('cv.blobFromImagesAsync GrayScale', () async {
    final imgs = [
      await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE),
      await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE),
    ].cvd;

    final blob = await cv.blobFromImagesAsync(imgs);
    expect(blob.isEmpty, false);
    expect(await cv.getBlobSizeAsync(blob), cv.Scalar(2, 1, 480, 512));
  });

  test('cv.NMSBoxesAsync', () async {
    var img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    img = await img.convertToAsync(cv.MatType.CV_32FC1);

    final bboxes = [
      cv.Rect(53, 47, 589, 451),
      cv.Rect(118, 54, 618, 450),
      cv.Rect(53, 66, 605, 480),
      cv.Rect(111, 65, 630, 480),
      cv.Rect(156, 51, 640, 480),
    ].cvd;
    final scores = [0.82094115, 0.7998236, 0.9809663, 0.99717456, 0.89628726].f32;
    final indices = await cv.NMSBoxesAsync(bboxes, scores, 0.5, 0.4);
    expect(indices.first, 3);
  });
}
