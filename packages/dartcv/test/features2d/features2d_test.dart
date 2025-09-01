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

    expect(params1.toString(), startsWith("FlannIndexParams(address=0x"));
  });

  test('cv.FlannSearchParams', () {
    final params = cv.FlannSearchParams(eps: 1.0, exploreAllTrees: true);

    params.checks = 50;
    params.eps = 0.5;
    params.sorted = false;
    params.exploreAllTrees = false;
    expect(params.checks, 50);
    expect(params.eps, 0.5);
    expect(params.sorted, false);
    expect(params.exploreAllTrees, false);
    expect(params.toString(), startsWith("FlannSearchParams(address=0x"));
  });

  test('cv.AKAZE', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final ak in [cv.AKAZE.empty(), cv.AKAZE.create()]) {
      expect(ak.isEmpty, isA<bool>());
      final kp = ak.detect(img);
      expect(kp.length, greaterThan(512));
      expect(ak.defaultName, 'Feature2D.AKAZE');

      final mask = cv.Mat.empty();
      final (kp2, desc) = ak.detectAndCompute(img, mask);
      expect(kp2.length, greaterThan(512));
      expect(desc.isEmpty, false);

      final type = ak.descriptorType;
      expect(type, isA<cv.AKAZEDescriptorType>());
      ak.descriptorType = cv.AKAZEDescriptorType.DESCRIPTOR_KAZE;
      expect(ak.descriptorType, cv.AKAZEDescriptorType.DESCRIPTOR_KAZE);

      ak.descriptorSize = 10;
      expect(ak.descriptorSize, 10);

      ak.descriptorChannels = 1;
      expect(ak.descriptorChannels, 1);

      ak.threshold = 0.1;
      expect(ak.threshold, closeTo(0.1, 1.0e-5));

      ak.nOctaves = 10;
      expect(ak.nOctaves, 10);

      ak.nOctaveLayers = 10;
      expect(ak.nOctaveLayers, 10);

      ak.diffusivity = cv.KAZEDiffusivityType.DIFF_CHARBONNIER;
      expect(ak.diffusivity, cv.KAZEDiffusivityType.DIFF_CHARBONNIER);

      ak.maxPoints = 100;
      expect(ak.maxPoints, 100);

      expect(ak.toString(), startsWith("AKAZE(addr=0x"));

      ak.dispose();
    }
  });

  test('cv.AgastFeatureDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final ad in [cv.AgastFeatureDetector.empty(), cv.AgastFeatureDetector.create()]) {
      expect(ad.isEmpty, isA<bool>());
      expect(ad.defaultName, 'Feature2D.AgastFeatureDetector');

      final kp = ad.detect(img);
      expect(kp.length, greaterThan(2800));

      expect(() => ad.detectAndCompute(cv.Mat.empty(), cv.Mat.empty()), throwsUnsupportedError);

      ad.threshold = 100;
      expect(ad.threshold, closeTo(100, 1.0e-5));

      ad.nonmaxSuppression = true;
      expect(ad.nonmaxSuppression, true);

      ad.type = cv.AgastDetectorType.AGAST_5_8;
      expect(ad.type, cv.AgastDetectorType.AGAST_5_8);

      expect(ad.toString(), startsWith("AgastFeatureDetector(addr=0x"));

      ad.dispose();
    }
  });

  test('cv.BRISK', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    for (final br in [
      cv.BRISK.empty(),
      cv.BRISK.create(),
      cv.BRISK.create1(radiusList: [1, 2, 3], numberList: [4, 5, 6]),
      cv.BRISK.create2(thresh: 30, octaves: 3, radiusList: [1, 2, 3], numberList: [4, 5, 6]),
    ]) {
      expect(br.isEmpty, isA<bool>());
      expect(br.defaultName, 'Feature2D.BRISK');

      final kp = br.detect(img);
      expect(kp.length, greaterThan(512));

      final mask = cv.Mat.empty();
      final (kp2, desc) = br.detectAndCompute(img, mask);
      expect(kp2.length, greaterThan(512));
      expect(desc.isEmpty, false);

      br.threshold = 30;
      expect(br.threshold, closeTo(30, 1.0e-5));

      br.octaves = 3;
      expect(br.octaves, 3);

      br.patternScale = 1.0;
      expect(br.patternScale, closeTo(1.0, 1.0e-5));

      expect(br.toString(), startsWith("BRISK(addr=0x"));
      br.dispose();
    }
  });

  test('cv.FastFeatureDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final fd in [cv.FastFeatureDetector.empty(), cv.FastFeatureDetector.create()]) {
      expect(fd.isEmpty, isA<bool>());
      expect(fd.defaultName, 'Feature2D.FastFeatureDetector');

      final kp = fd.detect(img);
      expect(kp.length, greaterThan(2690));

      expect(() => fd.detectAndCompute(cv.Mat.empty(), cv.Mat.empty()), throwsUnsupportedError);

      fd.threshold = 10;
      expect(fd.threshold, closeTo(10, 1.0e-5));

      fd.nonmaxSuppression = true;
      expect(fd.nonmaxSuppression, true);

      fd.type = cv.FastFeatureDetectorType.TYPE_5_8;
      expect(fd.type, cv.FastFeatureDetectorType.TYPE_5_8);

      expect(fd.toString(), startsWith("FastFeatureDetector(addr=0x"));

      fd.dispose();
    }
  });

  test('cv.GFTTDetector', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final detector in [cv.GFTTDetector.empty(), cv.GFTTDetector.create(), cv.GFTTDetector.create1()]) {
      expect(detector.isEmpty, isA<bool>());
      expect(detector.defaultName, 'Feature2D.GFTTDetector');

      final kp = detector.detect(img);
      expect(kp.length, greaterThan(512));

      expect(() => detector.detectAndCompute(cv.Mat.empty(), cv.Mat.empty()), throwsUnsupportedError);

      detector.maxFeatures = 100;
      expect(detector.maxFeatures, 100);

      detector.qualityLevel = 0.1;
      expect(detector.qualityLevel, closeTo(0.1, 1.0e-5));

      detector.minDistance = 10.0;
      expect(detector.minDistance, closeTo(10.0, 1.0e-5));

      detector.blockSize = 3;
      expect(detector.blockSize, 3);

      detector.gradientSize = 10;
      expect(detector.gradientSize, 10);

      detector.harrisDetector = true;
      expect(detector.harrisDetector, true);

      detector.k = 0.04;
      expect(detector.k, closeTo(0.04, 1.0e-5));

      expect(detector.toString(), startsWith("GFTTDetector(addr=0x"));

      detector.dispose();
    }
  });

  test('cv.KAZE', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final ka in [cv.KAZE.empty(), cv.KAZE.create()]) {
      expect(ka.isEmpty, isA<bool>());
      expect(ka.defaultName, 'Feature2D.KAZE');

      final mask = cv.Mat.empty();
      final (kp2, desc) = ka.detectAndCompute(img, mask);
      expect(kp2.length, greaterThan(0));
      expect(desc.isEmpty, false);

      ka.extended = true;
      expect(ka.extended, true);

      ka.upright = true;
      expect(ka.upright, true);

      ka.threshold = 0.001;
      expect(ka.threshold, closeTo(0.001, 1.0e-5));

      ka.octaves = 3;
      expect(ka.octaves, 3);

      ka.nOctaveLayers = 3;
      expect(ka.nOctaveLayers, 3);

      ka.diffusivity = cv.KAZEDiffusivityType.DIFF_PM_G2;
      expect(ka.diffusivity, cv.KAZEDiffusivityType.DIFF_PM_G2);

      expect(ka.toString(), startsWith("KAZE(addr=0x"));

      ka.dispose();
    }
  });

  test('cv.MSER', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final ms in [cv.MSER.empty(), cv.MSER.create()]) {
      expect(ms.isEmpty, isA<bool>());
      expect(ms.defaultName, 'Feature2D.MSER');

      final kp = ms.detect(img);
      expect(kp.length, greaterThan(0));

      ms.delta = 5;
      expect(ms.delta, 5);

      ms.minArea = 100;
      expect(ms.minArea, 100);

      ms.maxArea = 1000;
      expect(ms.maxArea, 1000);

      ms.maxVariation = 0.01;
      expect(ms.maxVariation, 0.01);

      ms.minDiversity = 0.01;
      expect(ms.minDiversity, 0.01);

      ms.maxEvolution = 100;
      expect(ms.maxEvolution, 100);

      ms.areaThreshold = 1.0;
      expect(ms.areaThreshold, 1.0);

      ms.minMargin = 0.01;
      expect(ms.minMargin, 0.01);

      ms.edgeBlurSize = 3;
      expect(ms.edgeBlurSize, 3);

      ms.pass2Only = true;
      expect(ms.pass2Only, true);

      expect(ms.toString(), startsWith("MSER(addr=0x"));

      ms.dispose();
    }
  });

  test('cv.ORB', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    for (final orb in [cv.ORB.empty(), cv.ORB.create()]) {
      expect(orb.isEmpty, isA<bool>());
      expect(orb.defaultName, 'Feature2D.ORB');

      final kp = orb.detect(img);
      expect(kp.length, 500);

      final mask = cv.Mat.empty();
      final (kp2, desc) = orb.detectAndCompute(img, mask);
      expect(kp2.length, 500);
      expect(desc.isEmpty, false);

      orb.maxFeatures = 100;
      expect(orb.maxFeatures, 100);

      orb.scaleFactor = 1.2;
      expect(orb.scaleFactor, 1.2);

      orb.nLevels = 8;
      expect(orb.nLevels, 8);

      orb.edgeThreshold = 31;
      expect(orb.edgeThreshold, 31);

      orb.firstLevel = 0;
      expect(orb.firstLevel, 0);

      orb.WTA_K = 2;
      expect(orb.WTA_K, 2);

      orb.scoreType = cv.ORBScoreType.FAST_SCORE;
      expect(orb.scoreType, cv.ORBScoreType.FAST_SCORE);

      orb.patchSize = 31;
      expect(orb.patchSize, 31);

      orb.fastThreshold = 20;
      expect(orb.fastThreshold, 20);

      expect(orb.toString(), startsWith('ORB(addr=0x'));

      orb.dispose();
    }
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

    expect(detector1.defaultName, 'Feature2D.SimpleBlobDetector');
    expect(detector1.isEmpty, isA<bool>());

    detector1.params = params;
    expect(detector1.params, params);

    expect(detector1.getBlobContours(), isA<cv.VecVecPoint>());

    expect(detector1.toString(), startsWith('SimpleBlobDetector(addr=0x'));

    detector1.dispose();
    params.dispose();
  });

  test('cv.BFMatcher', () {
    final desc1 = cv.imread("test/images/sift_descriptor.png", flags: cv.IMREAD_GRAYSCALE);
    expect(desc1.isEmpty, false);
    final desc2 = cv.imread("test/images/sift_descriptor.png", flags: cv.IMREAD_GRAYSCALE);
    expect(desc2.isEmpty, false);

    for (final matcher in [cv.BFMatcher.empty(), cv.BFMatcher.create()]) {
      final dmatches = matcher.knnMatch(desc1, desc2, 2);
      expect(dmatches.length, greaterThan(0));

      final matches = matcher.match(desc1, desc2);
      expect(matches.length, greaterThan(0));

      expect(matcher.toString(), startsWith("BFMatcher(addr=0x"));

      matcher.dispose();
    }
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
      // final indexParams = cv.FlannIndexParams.fromMap(
      //   {
      //     'algorithm': cv.FlannAlgorithm.FLANN_INDEX_KDTREE,
      //     "trees": 4,
      //   },
      // );
      final indexParams = cv.FlannKDTreeIndexParams();
      expect(indexParams.toString(), startsWith("FlannKDTreeIndexParams(address=0x"));

      final searchParams = cv.FlannSearchParams(checks: 32);
      final matcher = cv.FlannBasedMatcher.create(indexParams: indexParams, searchParams: searchParams);
      final dmatches = matcher.knnMatch(desc11, desc21, 2);
      expect(dmatches.length, greaterThan(0));

      expect(matcher.toString(), startsWith("FlannBasedMatcher(addr=0x"));

      matcher.dispose();
    }
  });

  test('cv.SIFT', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    for (final si in [
      cv.SIFT.empty(),
      cv.SIFT.create(
        nfeatures: 0,
        nOctaveLayers: 3,
        contrastThreshold: 0.04,
        edgeThreshold: 10,
        sigma: 1.6,
        descriptorType: cv.MatType.CV_32F,
      ),
    ]) {
      expect(si.defaultName, 'Feature2D.SIFT');
      expect(si.isEmpty, isA<bool>());

      final kp = si.detect(img);
      expect(kp.length, greaterThan(0));

      final mask = cv.Mat.empty();
      final (kp2, desc) = si.detectAndCompute(img, mask);
      expect(kp2.length, greaterThan(0));
      expect(desc.isEmpty, false);

      si.NFeatures = 100;
      expect(si.NFeatures, 100);

      si.nOctaveLayers = 10;
      expect(si.nOctaveLayers, 10);

      si.contrastThreshold = 0.05;
      expect(si.contrastThreshold, 0.05);

      si.edgeThreshold = 15;
      expect(si.edgeThreshold, 15);

      si.sigma = 2.0;
      expect(si.sigma, 2.0);

      expect(si.toString(), startsWith("SIFT(addr=0x"));

      si.dispose();
    }
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
