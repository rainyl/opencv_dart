import 'dart:io';
import 'dart:typed_data';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:dartcv4/src/core/mat_type.dart';
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
  test('cv.CascadeClassifier', () {
    final img = cv.imread("test/images/face.jpg", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final classifier = cv.CascadeClassifier.empty();
    classifier.load("test/data/haarcascade_frontalface_default.xml");
    final rects = classifier.detectMultiScale(img);
    expect(rects.length, 1);

    classifier.dispose();

    final cls = cv.CascadeClassifier.fromFile("test/data/haarcascade_frontalface_default.xml");
    expect(cls.empty(), false);

    {
      final (objects, nums) = cls.detectMultiScale2(img);
      expect(objects.length, 1);
      expect(nums.length, 1);
    }

    {
      final (objects, nums, weights) = cls.detectMultiScale3(img, outputRejectLevels: true);
      expect(objects.length, 1);
      expect(nums.length, 1);
      expect(weights.length, 1);
    }

    expect(cls.getFeatureType(), 0);
    expect(cls.getOriginalWindowSize(), (24, 24));
    expect(cls.isOldFormatCascade(), false);
  });

  test('cv.HOGDescriptor', () {
    final img = cv.imread("test/images/face.jpg", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    {
      final hog = cv.HOGDescriptor.empty();
      final det = cv.HOGDescriptor.getDefaultPeopleDetector();
      hog.setSVMDetector(det);
      final rects = hog.detectMultiScale(img);
      expect(rects.length, 1);
      hog.dispose();
    }
    {
      final hog = cv.HOGDescriptor.empty();
      expect(hog.getDescriptorSize(), 3780);
      expect(hog.getWinSigma(), closeTo(4.0, 1e-6));
      final d = cv.HOGDescriptor.getDaimlerPeopleDetector();
      expect(d.length, 1981);
      final success = hog.load("test/data/hog.xml");
      expect(success, true);
      // hog.setSVMDetector(d);
      final rects = hog.detectMultiScale(img);
      expect(rects.length, greaterThanOrEqualTo(0));
    }

    final hog1 = cv.HOGDescriptor.fromFile("test/data/hog.xml");
    final (descriptors, locations) = hog1.compute(img);
    expect(descriptors.length, greaterThanOrEqualTo(0));
    expect(locations.length, greaterThanOrEqualTo(0));

    final (grad, angle) = hog1.computeGradient(img);
    expect(grad.isEmpty, false);
    expect(angle.isEmpty, false);

    {
      final (locs, slocs) = hog1.detect(img);
      expect(locs.length, greaterThanOrEqualTo(0));
      expect(slocs.length, greaterThanOrEqualTo(0));
    }

    {
      final (locs, weights, slocs) = hog1.detect2(img);
      expect(locs.length, greaterThanOrEqualTo(0));
      expect(weights.length, greaterThanOrEqualTo(0));
      expect(slocs.length, greaterThanOrEqualTo(0));
    }

    {
      final rects = hog1.detectMultiScale(img);
      expect(rects.length, greaterThanOrEqualTo(0));
    }
  });

  test('cv.groupRectangles', () {
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

    final res = cv.groupRectangles(rects.cvd, 1, 0.2);
    expect(res.length, 1);
    expect(res.first, cv.Rect(10, 10, 32, 32));

    {
      final hog = cv.HOGDescriptor.empty();
      final w = List.generate(rects.length, (index) => 0.1);
      final (res, weights) = hog.groupRectangles(rects.cvd, w.f64, 1, 0.1);
      expect(res.length, greaterThan(0));
      expect(weights.length, greaterThan(0));
    }
  });

  test('cv.QRCodeDetector', () {
    final img = cv.imread("test/images/qrcode.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final detector = cv.QRCodeDetector.empty();
    final (res, bbox) = detector.detect(img);
    expect(res, true);
    expect(bbox, isNotNull);

    {
      final (success, pts) = detector.detect(img);
      expect(success, true);
      expect(pts.length, greaterThan(0));

      final (rval, code) = detector.decodeCurved(img, pts);
      expect(rval, "Hello World!");
      expect(code.isEmpty, false);
    }

    {
      final (rval, pts, code) = detector.detectAndDecodeCurved(img);
      expect(rval, "Hello World!");
      expect(pts.length, greaterThan(0));
      expect(code.isEmpty, false);
    }

    final (res2, bbox2, codes2) = detector.decode(img);
    final (res2_1, bbox2_1, codes2_1) = detector.decode(img);
    expect(res2_1, equals(res2));
    expect(bbox2_1, bbox2);
    expect(codes2?.shape, codes2_1?.shape);
    final (res3, bbox3, codes3) = detector.detectAndDecode(img);
    final (res3_1, bbox3_1, codes3_1) = detector.detectAndDecode(img);
    expect(bbox3_1, bbox3);
    expect(codes3.shape, codes3_1.shape);
    expect(res2, equals(res3));
    expect(res3_1, equals(res3));

    final img2 = cv.imread("test/images/multi_qrcodes.png", flags: cv.IMREAD_COLOR);
    expect(img2.isEmpty, false);

    final (res4, multiBox) = detector.detectMulti(img2);
    expect(res4, true);
    expect(multiBox, isNotNull);
    expect(multiBox.length, greaterThan(0));

    final (success, strs, pts, mats) = detector.detectAndDecodeMulti(img);
    expect(success, true);
    expect(strs, ["Hello World!"]);
    expect(pts.length, greaterThan(0));
    expect(mats.length, greaterThan(0));

    detector.setEpsX(0.1);
    detector.setEpsY(0.1);
    detector.setUseAlignmentMarkers(false);

    detector.dispose();
  });

  // https://docs.opencv.org/4.x/d0/dd4/tutorial_dnn_face.html
  test('cv.FaceDetectorYN', tags: ["no-local-files"], () {
    {
      // Test loading from file
      const modelPath = "test/models/face_detection_yunet_2023mar.onnx";
      final detector = cv.FaceDetectorYN.fromFile(modelPath, "", (320, 320));

      // Test loading image and setting input size
      final img = cv.imread("test/images/lenna.png");
      expect(img.isEmpty, false);
      detector.setInputSize((img.width, img.height));

      // Test detection
      final face = detector.detect(img);
      expect(face.rows, greaterThanOrEqualTo(1));
      visualizeFaceDetect(img, face);

      // Test setting parameters
      detector.setScoreThreshold(0.8);
      detector.setNMSThreshold(0.4);
      detector.setTopK(3000);

      // Test getters and compare values
      expect(detector.getScoreThreshold(), closeTo(0.8, 1e-6));
      expect(detector.getNmsThreshold(), closeTo(0.4, 1e-6));
      expect(detector.getTopK(), equals(3000));
      expect(detector.getInputSize(), equals((img.width, img.height)));

      // Dispose the detector
      detector.dispose();
    }

    {
      // Test loading from buffer
      const modelPath = "test/models/face_detection_yunet_2023mar.onnx";
      final buf = File(modelPath).readAsBytesSync();
      final detector = cv.FaceDetectorYN.fromBuffer("onnx", buf, Uint8List(0), (320, 320));

      // Test loading image and setting input size
      final img = cv.imread("test/images/lenna.png");
      expect(img.isEmpty, false);
      detector.setInputSize((img.width, img.height));

      // Test detection
      final face = detector.detect(img);
      expect(face.rows, greaterThanOrEqualTo(1));
      visualizeFaceDetect(img, face);
      // cv.imwrite("AAA.png", img);

      // Dispose the detector
      detector.dispose();
    }
  });

  // // Test for cv.FaceRecognizerSF
  test('cv.FaceRecognizerSF', tags: ["no-local-files"], () {
    const modelPath = "test/models/face_recognition_sface_2021dec.onnx";
    final recognizer = cv.FaceRecognizerSF.fromFile(modelPath, "");

    // Test loading image
    final img = cv.imread("test/images/face.jpg");
    expect(img.isEmpty, false);

    // Assume face detection already done and we have faceBox (a Mat object)
    final faceBox = cv.Mat.zeros(1, 4, MatType.CV_32SC1);
    faceBox.set<int>(0, 0, 50); // x
    faceBox.set<int>(0, 1, 50); // y
    faceBox.set<int>(0, 2, 100); // width
    faceBox.set<int>(0, 3, 100); // height

    // Test alignCrop
    final alignedFace = recognizer.alignCrop(img, faceBox);
    expect(alignedFace.isEmpty, false);

    // Test feature extraction
    final faceFeature = recognizer.feature(alignedFace);
    expect(faceFeature.isEmpty, false);

    // Test loading another image for matching
    final img2 = cv.imread("test/images/lenna.png");
    expect(img2.isEmpty, false);

    // Test alignCrop and feature extraction for the second image
    final alignedFace2 = recognizer.alignCrop(img2, faceBox);
    final faceFeature2 = recognizer.feature(alignedFace2);

    // Test matching features using L2 distance
    final matchScoreL2 = recognizer.match(faceFeature, faceFeature2, disType: cv.FaceRecognizerSF.FR_NORM_L2);
    expect(matchScoreL2, greaterThanOrEqualTo(0));

    // Test matching features using Cosine distance
    final matchScoreCosine =
        recognizer.match(faceFeature, faceFeature2, disType: cv.FaceRecognizerSF.FR_COSINE);
    expect(matchScoreCosine, greaterThanOrEqualTo(0));

    // Clean up
    recognizer.dispose();
    alignedFace.dispose();
    faceFeature.dispose();
    alignedFace2.dispose();
    faceFeature2.dispose();
  });
}
