import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('cv.FlannIndexParams', () {
    final params = cv.FlannIndexParams.empty();

    expect(params.get<double>('not exist', 0), 0);
    expect(params.get<int>('not exist', 1), 1);
    expect(params.get<String>('not exist', "abc"), "abc");
    expect(params.getAll(), {});

    params.setAlgorithm(cv.FlannAlgorithm.FLANN_INDEX_LINEAR);
    params.set<bool>("bool_0", true);
    params.set<double>("double_0", 241.0);
    params.set<int>("int_0", 241);
    params.set<String>("string_0", "string_0");

    final double0 = params.get<double>("double_0");
    expect(double0, 241.0);

    final int0 = params.get<int>("int_0");
    expect(int0, 241);

    final string0 = params.get<String>("string_0");
    expect(string0, "string_0");

    final all = params.getAll();
    expect(all, <String, dynamic>{
      "algorithm": cv.FlannAlgorithm.FLANN_INDEX_LINEAR,
      "bool_0": true,
      "double_0": 241.0,
      "int_0": 241,
      "string_0": "string_0",
    });

    final map = {
      "algorithm": cv.FlannAlgorithm.FLANN_INDEX_LINEAR,
      "bool_0": true,
      "double_0": 241.0,
      "int_0": 241,
      "string_0": "string_0",
    };
    final params1 = cv.FlannIndexParams.fromMap(map);
    expect(params1.getAll(), map);
  });

  test('cv.FlannSearchParams', () {
    final params = cv.FlannSearchParams(eps: 1.0, exploreAllTrees: true);
    expect(params.checks, 32);
    expect(params.eps, 1.0);
    expect(params.sorted, true);
    expect(params.exploreAllTrees, true);
    expect(params.toString(), startsWith("FlannSearchParams(address=0x"));
  });

  test('cv.AKAZE', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ak = cv.AKAZE.empty();
    final kp = ak.detect(img);
    expect(kp.length, greaterThan(512));

    final mask = cv.Mat.empty();
    final (kp2, desc) = ak.detectAndCompute(img, mask);
    expect(kp2.length, greaterThan(512));
    expect(desc.isEmpty, false);

    ak.dispose();
  });

  test('cv.AgastFeatureDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final ad = cv.AgastFeatureDetector.empty();
    final kp = ad.detect(img);
    expect(kp.length, greaterThan(2800));

    ad.dispose();
  });

  test('cv.BRISK', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final br = cv.BRISK.empty();
    final kp = br.detect(img);
    expect(kp.length, greaterThan(512));

    final mask = cv.Mat.empty();
    final (kp2, desc) = br.detectAndCompute(img, mask);
    expect(kp2.length, greaterThan(512));
    expect(desc.isEmpty, false);

    br.dispose();
  });

  test('cv.FastFeatureDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final fd = cv.FastFeatureDetector.empty();
    final kp = fd.detect(img);
    expect(kp.length, greaterThan(2690));

    final fd1 = cv.FastFeatureDetector.create();
    final kp1 = fd1.detect(img);
    expect(kp1.length, greaterThan(2690));

    fd.dispose();
  });

  test('cv.GFTTDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final gf = cv.GFTTDetector.empty();
    final kp = gf.detect(img);
    expect(kp.length, greaterThan(512));

    gf.dispose();
  });

  test('cv.KAZE', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ka = cv.KAZE.empty();
    final kp = ka.detect(img);
    expect(kp.length, greaterThan(0));

    final mask = cv.Mat.empty();
    final (kp2, desc) = ka.detectAndCompute(img, mask);
    expect(kp2.length, greaterThan(0));
    expect(desc.isEmpty, false);

    ka.dispose();
  });

  test('cv.MSER', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final gf = cv.MSER.empty();
    final kp = gf.detect(img);
    expect(kp.length, greaterThan(0));

    gf.dispose();
  });

  test('cv.ORB', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ka = cv.ORB.empty();
    final kp = ka.detect(img);

    expect(kp.length, 500);

    final orb = cv.ORB.create();
    final kp1 = orb.detect(img);
    expect(kp1.length, 500);

    final mask = cv.Mat.empty();
    final (kp2, desc) = ka.detectAndCompute(img, mask);
    expect(kp2.length, 500);
    expect(desc.isEmpty, false);

    orb.dispose();
  });

  test('cv.SimpleBlobDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final detector = cv.SimpleBlobDetector.empty();
    final kp = detector.detect(img);
    expect(kp.length, 1);

    final params = cv.SimpleBlobDetectorParams(
      blobColor: 200,
      filterByArea: false,
      filterByCircularity: true,
      filterByConvexity: false,
      filterByInertia: false,
      filterByColor: false,
      maxArea: 1000,
      maxInertiaRatio: 0.97,
      maxThreshold: 241,
      maxCircularity: 0.99,
      maxConvexity: 0.98,
      minArea: 230,
      minCircularity: 0.9,
      minConvexity: 0.89,
      minDistBetweenBlobs: 15.5,
      minInertiaRatio: 0.8,
      minRepeatability: 5,
      minThreshold: 200,
      thresholdStep: 2.0,
    );

    final params1 = cv.SimpleBlobDetectorParams.fromNative(params.ref);
    expect(params1, params);

    expect(params.blobColor, 200);
    params.blobColor = 201;
    final blobColor = params.blobColor;
    expect(blobColor, 201);

    expect(params.filterByArea, false);
    params.filterByArea = true;
    final filterByArea = params.filterByArea;
    expect(filterByArea, true);

    expect(params.filterByCircularity, true);
    params.filterByCircularity = false;
    final filterByCircularity = params.filterByCircularity;
    expect(filterByCircularity, false);

    expect(params.filterByColor, false);
    params.filterByColor = true;
    final filterByColor = params.filterByColor;
    expect(filterByColor, true);

    expect(params.filterByConvexity, false);
    params.filterByConvexity = true;
    final filterByConvexity = params.filterByConvexity;
    expect(filterByConvexity, true);

    expect(params.filterByInertia, false);
    params.filterByInertia = true;
    final filterByInertia = params.filterByInertia;
    expect(filterByInertia, true);

    expect(params.maxArea, 1000);
    params.maxArea = 2000;
    final maxArea = params.maxArea;
    expect(maxArea, 2000);

    expect(params.maxCircularity, closeTo(0.99, 1e-4));
    params.maxCircularity = 0.98;
    final maxCircularity = params.maxCircularity;
    expect(maxCircularity, closeTo(0.98, 1e-4));

    expect(params.maxConvexity, closeTo(0.98, 1e-4));
    params.maxConvexity = 0.99;
    final maxConvexity = params.maxConvexity;
    expect(maxConvexity, closeTo(0.99, 1e-4));

    expect(params.maxInertiaRatio, closeTo(0.97, 1e-4));
    params.maxInertiaRatio = 0.99;
    final maxInertiaRatio = params.maxInertiaRatio;
    expect(maxInertiaRatio, closeTo(0.99, 1e-4));

    expect(params.maxThreshold, 241);
    params.maxThreshold = 255;
    final maxThreshold = params.maxThreshold;
    expect(maxThreshold, 255);

    expect(params.minArea, 230);
    params.minArea = 10;
    final minArea = params.minArea;
    expect(minArea, 10);

    expect(params.minCircularity, closeTo(0.9, 1e-4));
    params.minCircularity = 0.8;
    final minCircularity = params.minCircularity;
    expect(minCircularity, closeTo(0.8, 1e-4));

    expect(params.minConvexity, closeTo(0.89, 1e-4));
    params.minConvexity = 0.8;
    final minConvexity = params.minConvexity;
    expect(minConvexity, closeTo(0.8, 1e-4));

    expect(params.minDistBetweenBlobs, closeTo(15.5, 1e-4));
    params.minDistBetweenBlobs = 10;
    final minDistBetweenBlobs = params.minDistBetweenBlobs;
    expect(minDistBetweenBlobs, closeTo(10, 1e-4));

    expect(params.minInertiaRatio, closeTo(0.8, 1e-4));
    params.minInertiaRatio = 0.7;
    final minInertiaRatio = params.minInertiaRatio;
    expect(minInertiaRatio, closeTo(0.7, 1e-4));

    expect(params.minRepeatability, 5);
    params.minRepeatability = 10;
    final minRepeatability = params.minRepeatability;
    expect(minRepeatability, 10);

    expect(params.minThreshold, 200);
    params.minThreshold = 100;
    final minThreshold = params.minThreshold;
    expect(minThreshold, 100);

    expect(params.thresholdStep, closeTo(2.0, 1e-4));
    params.thresholdStep = 1.0;
    final thresholdStep = params.thresholdStep;
    expect(thresholdStep, closeTo(1.0, 1e-4));

    final detector1 = cv.SimpleBlobDetector.create(params);
    final kp1 = detector1.detect(img);
    expect(kp1.length, 0);

    detector1.dispose();
    params.dispose();
  });

  test('cv.BFMatcher', () {
    final desc1 = cv.imread("test/images/sift_descriptor.png", flags: cv.IMREAD_GRAYSCALE);
    expect(desc1.isEmpty, false);
    final desc2 = cv.imread("test/images/sift_descriptor.png", flags: cv.IMREAD_GRAYSCALE);
    expect(desc2.isEmpty, false);

    final matcher = cv.BFMatcher.empty();
    final dmatches = matcher.knnMatch(desc1, desc2, 2);
    expect(dmatches.length, greaterThan(0));

    final matcher1 = cv.BFMatcher.create();
    final dmatches1 = matcher1.knnMatch(desc1, desc2, 2);
    expect(dmatches1.length, greaterThan(0));

    final matches = matcher.match(desc1, desc2);
    expect(matches.length, greaterThan(0));

    matcher.dispose();
  });

  test('cv.FlannBasedMatcher', () {
    final desc1 = cv.imread("test/images/sift_descriptor.png", flags: cv.IMREAD_GRAYSCALE);
    expect(desc1.isEmpty, false);
    final desc2 = cv.imread("test/images/sift_descriptor.png", flags: cv.IMREAD_GRAYSCALE);
    expect(desc2.isEmpty, false);

    final desc11 = desc1.convertTo(cv.MatType.CV_32FC1);
    final desc21 = desc2.convertTo(cv.MatType.CV_32FC1);
    {
      final matcher = cv.FlannBasedMatcher.empty();
      final dmatches = matcher.knnMatch(desc11, desc21, 2);
      expect(dmatches.length, greaterThan(0));

      matcher.dispose();
    }

    {
      // https://github.com/rainyl/opencv_dart/issues/369
      final indexParams = cv.FlannIndexParams.fromMap(
        {
          'algorithm': cv.FlannAlgorithm.FLANN_INDEX_KDTREE,
          "trees": 4,
        },
      );
      final searchParams = cv.FlannSearchParams(checks: 32);
      final matcher = cv.FlannBasedMatcher.create(indexParams: indexParams, searchParams: searchParams);
      final dmatches = matcher.knnMatch(desc11, desc21, 2);
      expect(dmatches.length, greaterThan(0));

      matcher.dispose();
    }
  });

  test('cv.SIFT', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final si = cv.SIFT.empty();
    final kp = si.detect(img);
    expect(kp.length, greaterThan(0));

    final mask = cv.Mat.empty();
    final (kp2, desc) = si.detectAndCompute(img, mask);
    expect(kp2.length, greaterThan(0));
    expect(desc.isEmpty, false);

    si.dispose();
  });

  test('cv.drawMatches', () {
    final query = cv.imread("test/images/box.png", flags: cv.IMREAD_GRAYSCALE);
    final train = cv.imread("test/images/box_in_scene.png", flags: cv.IMREAD_GRAYSCALE);
    expect(query.isEmpty, false);
    expect(train.isEmpty, false);
    final m1 = cv.Mat.empty(), m2 = cv.Mat.empty();
    final (kp1, des1) = cv.SIFT.empty().detectAndCompute(query, m1);
    final (kp2, des2) = cv.SIFT.empty().detectAndCompute(train, m2);
    final bf = cv.BFMatcher.empty();
    final dmatches = bf.knnMatch(des1, des2, 2);
    expect(dmatches.length, greaterThan(0));

    final out = cv.Mat.empty();

    cv.drawMatches(
      query,
      kp1,
      train,
      kp2,
      dmatches.first,
      out,
      matchColor: cv.Scalar.red,
      singlePointColor: cv.Scalar.green,
    );
    expect(out.cols, query.cols + train.cols);

    bf.dispose();
  });
}
