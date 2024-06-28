import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('cv.AKAZEAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ak = await cv.AKAZEAsync.emptyAsync();
    final kp = await ak.detectAsync(img);
    expect(kp.length, greaterThan(512));

    final mask = cv.Mat.empty();
    final (kp2, desc) = await ak.detectAndComputeAsync(img, mask);
    expect(kp2.length, greaterThan(512));
    expect(desc.isEmpty, false);

    ak.dispose();
  });

  test('cv.AgastFeatureDetectorAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ad = await cv.AgastFeatureDetectorAsync.emptyAsync();
    final kp = await ad.detectAsync(img);
    expect(kp.length, greaterThan(2800));

    ad.dispose();
  });

  test('cv.BRISKAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final br = await cv.BRISKAsync.emptyAsync();
    final kp = await br.detectAsync(img);
    expect(kp.length, greaterThan(512));

    final mask = cv.Mat.empty();
    final (kp2, desc) = await br.detectAndComputeAsync(img, mask);
    expect(kp2.length, greaterThan(512));
    expect(desc.isEmpty, false);

    br.dispose();
  });

  test('cv.FastFeatureDetectorAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final fd = await cv.FastFeatureDetectorAsync.emptyAsync();
    final kp = await fd.detectAsync(img);
    expect(kp.length, greaterThan(2690));

    final fd1 = await cv.FastFeatureDetectorAsync.createAsync();
    final kp1 = await fd1.detectAsync(img);
    expect(kp1.length, greaterThan(2690));

    fd.dispose();
  });

  test('cv.GFTTDetectorAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final gf = await cv.GFTTDetectorAsync.emptyAsync();
    final kp = await gf.detectAsync(img);
    expect(kp.length, greaterThan(512));

    gf.dispose();
  });

  test('cv.KAZEAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ka = await cv.KAZEAsync.emptyAsync();
    final kp = await ka.detectAsync(img);
    expect(kp.length, greaterThan(0));

    final mask = cv.Mat.empty();
    final (kp2, desc) = await ka.detectAndComputeAsync(img, mask);
    expect(kp2.length, greaterThan(0));
    expect(desc.isEmpty, false);

    ka.dispose();
  });

  test('cv.MSERAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final gf = await cv.MSERAsync.emptyAsync();
    final kp = await gf.detectAsync(img);
    expect(kp.length, greaterThan(0));

    gf.dispose();
  });

  test('cv.ORBAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final ka = await cv.ORBAsync.emptyAsync();
    final kp = await ka.detectAsync(img);
    expect(kp.length, 500);

    final orb = await cv.ORBAsync.createAsync();
    final kp1 = await orb.detectAsync(img);
    expect(kp1.length, 500);

    final mask = cv.Mat.empty();
    final (kp2, desc) = await ka.detectAndComputeAsync(img, mask);
    expect(kp2.length, 500);
    expect(desc.isEmpty, false);

    orb.dispose();
  });

  test('cv.SimpleBlobDetectorAsync', () async {
    final img =
        await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final detector = await cv.SimpleBlobDetectorAsync.emptyAsync();
    final kp = await detector.detectAsync(img);
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

    final detector1 = await cv.SimpleBlobDetectorAsync.createAsync(params);
    final kp1 = await detector1.detectAsync(img);
    expect(kp1.length, 0);

    detector1.dispose();
    params.dispose();
  });

  test('cv.BFMatcherAsync', () async {
    final desc1 = await cv.imreadAsync("test/images/sift_descriptor.png",
        flags: cv.IMREAD_GRAYSCALE,);
    expect(desc1.isEmpty, false);
    final desc2 = await cv.imreadAsync("test/images/sift_descriptor.png",
        flags: cv.IMREAD_GRAYSCALE,);
    expect(desc2.isEmpty, false);

    final matcher = await cv.BFMatcherAsync.emptyAsync();
    final dmatches = await matcher.knnMatchAsync(desc1, desc2, 2);
    expect(dmatches.length, greaterThan(0));

    final matcher1 = await cv.BFMatcherAsync.createAsync();
    final dmatches1 = await matcher1.knnMatchAsync(desc1, desc2, 2);
    expect(dmatches1.length, greaterThan(0));

    final matches = await matcher.matchAsync(desc1, desc2);
    expect(matches.length, greaterThan(0));

    matcher.dispose();
  });

  test('cv.FlannBasedMatcherAsync', () async {
    final desc1 = await cv.imreadAsync("test/images/sift_descriptor.png",
        flags: cv.IMREAD_GRAYSCALE,);
    expect(desc1.isEmpty, false);
    final desc2 = await cv.imreadAsync("test/images/sift_descriptor.png",
        flags: cv.IMREAD_GRAYSCALE,);
    expect(desc2.isEmpty, false);

    final desc11 = desc1.convertTo(cv.MatType.CV_32FC1);
    final desc21 = desc2.convertTo(cv.MatType.CV_32FC1);

    final matcher = await cv.FlannBasedMatcherAsync.emptyAsync();
    final dmatches = await matcher.knnMatchAsync(desc11, desc21, 2);
    expect(dmatches.length, greaterThan(0));

    matcher.dispose();
  });

  test('cv.SIFTAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png",
        flags: cv.IMREAD_GRAYSCALE,);
    expect(img.isEmpty, false);

    final si = await cv.SIFTAsync.emptyAsync();
    final kp = await si.detectAsync(img);
    expect(kp.length, greaterThan(0));

    final mask = cv.Mat.empty();
    final (kp2, desc) = await si.detectAndComputeAsync(img, mask);
    expect(kp2.length, greaterThan(0));
    expect(desc.isEmpty, false);

    si.dispose();
  });

  test('cv.drawMatchesAsync', () async {
    final query =
        await cv.imreadAsync("test/images/box.png", flags: cv.IMREAD_GRAYSCALE);
    final train = await cv.imreadAsync("test/images/box_in_scene.png",
        flags: cv.IMREAD_GRAYSCALE,);
    expect(query.isEmpty, false);
    expect(train.isEmpty, false);

    final m1 = cv.Mat.empty(), m2 = cv.Mat.empty();
    final (kp1, des1) = await (await cv.SIFTAsync.emptyAsync())
        .detectAndComputeAsync(query, m1);
    final (kp2, des2) = await (await cv.SIFTAsync.emptyAsync())
        .detectAndComputeAsync(train, m2);

    final bf = await cv.BFMatcherAsync.emptyAsync();
    final dmatches = await bf.knnMatchAsync(des1, des2, 2);
    expect(dmatches.length, greaterThan(0));

    final out = cv.Mat.empty();
    await cv.drawMatchesAsync(
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
