import 'dart:io';
import 'dart:typed_data';

import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:opencv_dart/src/core/mat_type.dart';
import 'package:test/test.dart';

cv.Mat visualizeFaceDetect(cv.Mat img, cv.Mat faces) {
  expect(faces.rows, greaterThanOrEqualTo(1));
  for (int row = 0; row < faces.rows; row++) {
    final rect = cv.Rect(
      faces.at<double>(row, 0).toInt(),
      faces.at<double>(row, 1).toInt(),
      faces.at<double>(row, 2).toInt(),
      faces.at<double>(row, 3).toInt(),
    );
    final points = [
      cv.Point(faces.at<double>(row, 4).toInt(), faces.at<double>(row, 5).toInt()),
      cv.Point(faces.at<double>(row, 6).toInt(), faces.at<double>(row, 7).toInt()),
      cv.Point(faces.at<double>(row, 8).toInt(), faces.at<double>(row, 9).toInt()),
      cv.Point(faces.at<double>(row, 10).toInt(), faces.at<double>(row, 11).toInt()),
      cv.Point(faces.at<double>(row, 12).toInt(), faces.at<double>(row, 13).toInt()),
    ];
    cv.rectangle(img, rect, cv.Scalar.green, thickness: 2);
    for (final p in points) {
      cv.circle(img, p, 2, cv.Scalar.blue, thickness: 2);
    }
  }
  return img;
}

void main() async {
  test('cv.CascadeClassifierAsync', () async {
    final img = await cv.imreadAsync("test/images/face.jpg", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final classifier = await cv.CascadeClassifierAsync.emptyNewAsync();
    await classifier.loadAsync("test/data/haarcascade_frontalface_default.xml");
    final rects = await classifier.detectMultiScaleAsync(img);
    expect(rects.length, 1);

    classifier.dispose();

    final cls =
        await cv.CascadeClassifierAsync.fromFileAsync("test/data/haarcascade_frontalface_default.xml");
    expect(cls.empty(), false);

    {
      final (objects, nums) = await cls.detectMultiScale2Async(img);
      expect(objects.length, 1);
      expect(nums.length, 1);
    }

    {
      final (objects, nums, weights) = await cls.detectMultiScale3Async(img, outputRejectLevels: true);
      expect(objects.length, 1);
      expect(nums.length, 1);
      expect(weights.length, 1);
    }

    expect(await cls.getFeatureTypeAsync(), 0);
    expect(await cls.getOriginalWindowSizeAsync(), (24, 24));
    expect(await cls.isOldFormatCascadeAsync(), false);
  });

  test('cv.HOGDescriptorAsync', () async {
    final img = await cv.imreadAsync("test/images/face.jpg", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    {
      final hog = await cv.HOGDescriptorAsync.emptyNewAsync();
      await hog.setSVMDetectorAsync(await cv.HOGDescriptorAsync.getDefaultPeopleDetectorAsync());
      final rects = await hog.detectMultiScaleAsync(img);
      expect(rects.length, 1);
      hog.dispose();
    }
    {
      final hog = await cv.HOGDescriptorAsync.emptyNewAsync();
      expect(await hog.getDescriptorSizeAsync(), 3780);
      expect(await hog.getWinSigmaAsync(), closeTo(4.0, 1e-6));
      final d = await cv.HOGDescriptorAsync.getDaimlerPeopleDetectorAsync();
      expect(d.length, 1981);
      final success = await hog.loadAsync("test/data/hog.xml");
      expect(success, true);
      // hog.setSVMDetector(d);
      final rects = await hog.detectMultiScaleAsync(img);
      expect(rects.length, greaterThanOrEqualTo(0));
    }

    final hog1 = await cv.HOGDescriptorAsync.fromFileAsync("test/data/hog.xml");
    final (descriptors, locations) = await hog1.computeAsync(img);
    expect(descriptors.length, greaterThanOrEqualTo(0));
    expect(locations.length, greaterThanOrEqualTo(0));

    final grad = cv.Mat.empty();
    final angle = cv.Mat.empty();
    await hog1.computeGradientAsync(img, grad, angle);
    expect(grad.isEmpty, false);
    expect(angle.isEmpty, false);

    {
      final (locs, slocs) = await hog1.detectAsync(img);
      expect(locs.length, greaterThanOrEqualTo(0));
      expect(slocs.length, greaterThanOrEqualTo(0));
    }

    {
      final (locs, weights, slocs) = await hog1.detect2Async(img);
      expect(locs.length, greaterThanOrEqualTo(0));
      expect(weights.length, greaterThanOrEqualTo(0));
      expect(slocs.length, greaterThanOrEqualTo(0));
    }

    {
      final rects = await hog1.detectMultiScaleAsync(img);
      expect(rects.length, greaterThanOrEqualTo(0));
    }
  });

  test('cv.groupRectanglesAsync', () async {
    final rects = [
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
    ];

    final res = await cv.groupRectanglesAsync(rects.cvd, 1, 0.2);
    expect(res.length, 1);
    expect(res.first, cv.Rect(10, 10, 32, 32));

    {
      final hog = await cv.HOGDescriptorAsync.emptyNewAsync();
      final w = List.generate(rects.length, (index) => 0.1);
      final (res, weights) = await hog.groupRectanglesAsync(rects.cvd, w.f64, 1, 0.1);
      expect(res.length, greaterThan(0));
      expect(weights.length, greaterThan(0));
    }
  });

  test('cv.QRCodeDetectorAsync', () async {
    final img = await cv.imreadAsync("test/images/qrcode.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final detector = await cv.QRCodeDetectorAsync.emptyNewAsync();
    final (res, bbox) = await detector.detectAsync(img);
    expect(res, true);
    expect(bbox, isNotNull);

    {
      final (success, pts) = await detector.detectAsync(img);
      expect(success, true);
      expect(pts.length, greaterThan(0));

      final (rval, code) = await detector.decodeCurvedAsync(img, pts);
      expect(rval, "Hello World!");
      expect(code.isEmpty, false);
    }

    {
      final (rval, pts, code) = await detector.detectAndDecodeCurvedAsync(img);
      expect(rval, "Hello World!");
      expect(pts.length, greaterThan(0));
      expect(code.isEmpty, false);
    }

    final (res2, bbox2, codes2) = await detector.decodeAsync(img);
    final (res2_1, bbox2_1, codes2_1) = await detector.decodeAsync(img);
    expect(res2_1, equals(res2));
    expect(bbox2_1, bbox2);
    expect(codes2?.shape, codes2_1?.shape);
    final (res3, bbox3, codes3) = await detector.detectAndDecodeAsync(img);
    final (res3_1, bbox3_1, codes3_1) = await detector.detectAndDecodeAsync(img);
    expect(bbox3_1, bbox3);
    expect(codes3.shape, codes3_1.shape);
    expect(res2, equals(res3));
    expect(res3_1, equals(res3));

    final img2 = await cv.imreadAsync("test/images/multi_qrcodes.png", flags: cv.IMREAD_COLOR);
    expect(img2.isEmpty, false);

    final (res4, multiBox) = await detector.detectMultiAsync(img2);
    expect(res4, true);
    expect(multiBox, isNotNull);
    expect(multiBox.length, greaterThan(0));

    final (success, strs, pts, mats) = await detector.detectAndDecodeMultiAsync(img);
    expect(success, true);
    expect(strs, ["Hello World!"]);
    expect(pts.length, greaterThan(0));
    expect(mats.length, greaterThan(0));

    await detector.setEpsXAsync(0.1);
    await detector.setEpsYAsync(0.1);
    await detector.setUseAlignmentMarkersAsync(false);

    detector.dispose();
  });

  // https://docs.opencv.org/4.x/d0/dd4/tutorial_dnn_face.html
  test('cv.FaceDetectorYNAsync', tags: ["no-local-files"], () async {
    {
      // Test loading from file
      const modelPath = "test/models/face_detection_yunet_2023mar.onnx";
      final detector = await cv.FaceDetectorYNAsync.fromFileAsync(modelPath, "", (320, 320));

      // Test loading image and setting input size
      final img = await cv.imreadAsync("test/images/lenna.png");
      expect(img.isEmpty, false);
      await detector.setInputSizeAsync((img.width, img.height));

      // Test detection
      final face = await detector.detectAsync(img);
      expect(face.rows, greaterThanOrEqualTo(1));
      visualizeFaceDetect(img, face);

      // Test setting parameters
      await detector.setScoreThresholdAsync(0.8);
      await detector.setNMSThresholdAsync(0.4);
      await detector.setTopKAsync(3000);

      // Test getters and compare values
      expect(await detector.getScoreThresholdAsync(), closeTo(0.8, 1e-6));
      expect(await detector.getNmsThresholdAsync(), closeTo(0.4, 1e-6));
      expect(await detector.getTopKAsync(), equals(3000));
      expect(await detector.getInputSizeAsync(), equals((img.width, img.height)));

      // Dispose the detector
      detector.dispose();
    }

    {
      // Test loading from buffer
      const modelPath = "test/models/face_detection_yunet_2023mar.onnx";
      final buf = await File(modelPath).readAsBytes();
      final detector = await cv.FaceDetectorYNAsync.fromBufferAsync("onnx", buf, Uint8List(0), (320, 320));

      // Test loading image and setting input size
      final img = await cv.imreadAsync("test/images/lenna.png");
      expect(img.isEmpty, false);
      await detector.setInputSizeAsync((img.width, img.height));

      // Test detection
      final face = await detector.detectAsync(img);
      expect(face.rows, greaterThanOrEqualTo(1));
      visualizeFaceDetect(img, face);
      // cv.imwrite("AAA.png", img);

      // Dispose the detector
      detector.dispose();
    }
  });

  // Test for cv.FaceRecognizerSF
  test('cv.FaceRecognizerSFAsync', tags: ["no-local-files"], () async {
    const modelPath = "test/models/face_recognition_sface_2021dec.onnx";
    final recognizer = await cv.FaceRecognizerSFAsync.fromFileAsync(modelPath, "");

    // Test loading image
    final img = await cv.imreadAsync("test/images/face.jpg");
    expect(img.isEmpty, false);

    // Assume face detection already done and we have faceBox (a Mat object)
    final faceBox = cv.Mat.zeros(1, 4, MatType.CV_32SC1);
    faceBox.set<int>(0, 0, 50); // x
    faceBox.set<int>(0, 1, 50); // y
    faceBox.set<int>(0, 2, 100); // width
    faceBox.set<int>(0, 3, 100); // height

    // Test alignCrop
    final alignedFace = await recognizer.alignCropAsync(img, faceBox);
    expect(alignedFace.isEmpty, false);

    // Test feature extraction
    final faceFeature = await recognizer.featureAsync(alignedFace);
    expect(faceFeature.isEmpty, false);

    // Test loading another image for matching
    final img2 = await cv.imreadAsync("test/images/lenna.png");
    expect(img2.isEmpty, false);

    // Test alignCrop and feature extraction for the second image
    final alignedFace2 = await recognizer.alignCropAsync(img2, faceBox);
    final faceFeature2 = await recognizer.featureAsync(alignedFace2);

    // Test matching features using L2 distance
    final matchScoreL2 =
        await recognizer.matchAsync(faceFeature, faceFeature2, disType: cv.FaceRecognizerSF.FR_NORM_L2);
    expect(matchScoreL2, greaterThanOrEqualTo(0));

    // Test matching features using Cosine distance
    final matchScoreCosine =
        await recognizer.matchAsync(faceFeature, faceFeature2, disType: cv.FaceRecognizerSF.FR_COSINE);
    expect(matchScoreCosine, greaterThanOrEqualTo(0));

    // Clean up
    recognizer.dispose();
    alignedFace.dispose();
    faceFeature.dispose();
    alignedFace2.dispose();
    faceFeature2.dispose();
  });
}
