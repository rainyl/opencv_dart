import 'dart:math';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('cv.ximgproc.anisotropicDiffusion', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC3);
    final dst = cv.ximgproc.anisotropicDiffusion(src, 0.5, 0.5, 100);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.anisotropicDiffusionAsync', () async {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC3);
    final dst = await cv.ximgproc.anisotropicDiffusionAsync(src, 0.5, 0.5, 100);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.edgePreservingFilter', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC3);
    final dst = cv.ximgproc.edgePreservingFilter(src, 3, 0.5);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.edgePreservingFilterAsync', () async {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC3);
    final dst = await cv.ximgproc.edgePreservingFilterAsync(src, 3, 0.5);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.findEllipses', () {
    final src = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final dst = cv.ximgproc.findEllipses(src);
    expect(dst.isEmpty, false);
  });

  test('cv.ximgproc.findEllipsesAsync', () async {
    final src = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final dst = await cv.ximgproc.findEllipsesAsync(src);
    expect(dst.isEmpty, false);
  });

  test('cv.ximgproc.niBlackThreshold', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = cv.ximgproc.niBlackThreshold(src, 127.0, cv.THRESH_BINARY, 3, 0.5);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.niBlackThresholdAsync', () async {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = await cv.ximgproc.niBlackThresholdAsync(src, 127.0, cv.THRESH_BINARY, 3, 0.5);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.PeiLinNormalization', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = cv.ximgproc.PeiLinNormalization(src);
    expect(dst.isEmpty, false);
    expect(dst.shape, [2, 3, 1]);
  });

  test('cv.ximgproc.PeiLinNormalizationAsync', () async {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = await cv.ximgproc.PeiLinNormalizationAsync(src);
    expect(dst.isEmpty, false);
    expect(dst.shape, [2, 3, 1]);
  });

  test('cv.ximgproc.thinning', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = cv.ximgproc.thinning(src);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.thinningAsync', () async {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = await cv.ximgproc.thinningAsync(src);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.StructuredEdgeDetection', tags: ["no-local-files"], () async {
    final src = cv.imread("test/images/circles.jpg");
    final detector = cv.StructuredEdgeDetection.create("test/models/structure_edge_model.yml");

    // note the alpha, improper data of src will cause crash internally in opencv
    // without friendly exception
    final src32f = src.convertTo(cv.MatType.CV_32FC3, alpha: 1.0 / 255.0);

    final edges = detector.detectEdges(src32f);
    expect(edges.isEmpty, false);
    expect(edges.type, cv.MatType.CV_32FC1);
    // cv.imwrite("test/images_out/StructuredEdgeDetection_edges.png", edges.multiplyF32(255.0).convertTo(cv.MatType.CV_8UC1));

    final orientation = detector.computeOrientation(edges);
    expect(orientation.isEmpty, false);

    final edgeNms = detector.edgesNms(edges, orientation);
    expect(edgeNms.isEmpty, false);

    // cv.imwrite("test/images_out/StructuredEdgeDetection_edgeNms.png", edges.convertTo(cv.MatType.CV_8UC1));

    final eb = cv.EdgeBoxes(maxBoxes: 5);
    final (boxes, scores) = eb.getBoundingBoxes(edgeNms, orientation);
    expect(boxes.length, greaterThan(0));
    expect(scores.length, greaterThan(0));

    final eb1 = cv.EdgeBoxes(maxBoxes: 5);
    expect(eb1 == eb, true);

    eb.alpha = 0.5;
    expect(eb.alpha, closeTo(0.5, 1e-6));

    eb.beta = 0.5;
    expect(eb.beta, closeTo(0.5, 1e-6));

    eb.eta = 0.5;
    expect(eb.eta, closeTo(0.5, 1e-6));

    eb.minScore = 0.5;
    expect(eb.minScore, closeTo(0.5, 1e-6));

    eb.maxBoxes = 10;
    expect(eb.maxBoxes, closeTo(10, 1e-6));

    eb.edgeMinMag = 0.5;
    expect(eb.edgeMinMag, closeTo(0.5, 1e-6));

    eb.edgeMergeThr = 0.5;
    expect(eb.edgeMergeThr, closeTo(0.5, 1e-6));

    eb.clusterMinMag = 0.5;
    expect(eb.clusterMinMag, closeTo(0.5, 1e-6));

    eb.maxAspectRatio = 0.5;
    expect(eb.maxAspectRatio, closeTo(0.5, 1e-6));

    eb.minBoxArea = 100;
    expect(eb.minBoxArea, closeTo(100, 1e-6));

    eb.gamma = 3;
    expect(eb.gamma, closeTo(3.0, 1e-6));

    eb.kappa = 1.0;
    expect(eb.kappa, closeTo(1.0, 1e-6));

    detector.dispose();
  });

  test('cv.GraphSegmentation', () {
    final src = cv.imread("test/images/circles.jpg");
    expect(src.isEmpty, false);
    final gs = cv.GraphSegmentation.create();
    final im = gs.processImage(src);
    expect(im.isEmpty, false);

    gs.K = 2.0;
    expect(gs.K, closeTo(2.0, 1e-6));

    gs.sigma = 0.5;
    expect(gs.sigma, closeTo(0.5, 1e-6));

    gs.minSize = 100;
    expect(gs.minSize, closeTo(100, 1e-6));

    gs.dispose();
  });

  test('cv.EdgeDrawing', () {
    final src = cv.imread("test/images/circles.jpg");
    final gray = cv.cvtColor(src, cv.COLOR_BGR2GRAY);

    final ssrc = cv.Mat.zeros(src.rows, src.cols, src.type);
    // final lsrc = ssrc.clone();
    // final esrc = ssrc.clone();

    final ed = cv.EdgeDrawing.empty();
    ed.detectEdges(gray);

    final segments = ed.getSegments();
    expect(segments.isEmpty, false);
    final lines = ed.detectLines();
    expect(lines.isEmpty, false);

    final ellipses = ed.detectEllipses();
    expect(ellipses.isEmpty, false);

    for (var i = 0; i < segments.length; i++) {
      final color = cv.Scalar.fromRgb(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
      cv.polylines(ssrc, segments[i].asVecVec(), false, color);
    }
    // cv.imwrite("test/images_out/EdgeDrawing_segments.png", ssrc);

    final edgeImage = ed.getEdgeImage();
    expect(edgeImage.isEmpty, false);

    final gradientImage = ed.getGradientImage();
    expect(gradientImage.isEmpty, false);

    final indices = ed.getSegmentIndicesOfLines();
    expect(indices.length, greaterThan(0));

    ed.dispose();
  });

  test('cv.EdgeDrawingParams', () {
    final ed = cv.EdgeDrawing.empty();
    final params = ed.params;

    final params1 = cv.EdgeDrawingParams();
    expect(params1.props, params.props);

    params.AnchorThresholdValue = 0;
    params.EdgeDetectionOperator = cv.EdgeDrawingParams.SOBEL;
    params.GradientThresholdValue = 30;
    params.LineFitErrorThreshold = 1.5;
    params.MaxDistanceBetweenTwoLines = 7.0;
    params.MaxErrorThreshold = 1.3;
    params.MinLineLength = 10;
    params.MinPathLength = 10;
    params.NFAValidation = true;
    params.PFmode = true;
    params.ScanInterval = 2;
    params.Sigma = 2.0;
    params.SumFlag = true;

    expect(params.AnchorThresholdValue, 0);
    expect(params.EdgeDetectionOperator, cv.EdgeDrawingParams.SOBEL);
    expect(params.GradientThresholdValue, 30);
    expect(params.LineFitErrorThreshold, 1.5);
    expect(params.MaxDistanceBetweenTwoLines, 7.0);
    expect(params.MaxErrorThreshold, 1.3);
    expect(params.MinLineLength, 10);
    expect(params.MinPathLength, 10);
    expect(params.NFAValidation, true);
    expect(params.PFmode, true);
    expect(params.ScanInterval, 2);
    expect(params.Sigma, 2.0);
    expect(params.SumFlag, true);

    ed.params = params;
  });

  // https://github.com/opencv/opencv_contrib/blob/438e67f472cb88f5a720196cd4c06e660c1cef8a/modules/ximgproc/test/test_run_length_morphology.cpp#L211
  test('cv.ximgproc_rl.createRLEImage', () async {
    final runs = <cv.Point3i>[];
    const nSize = 21;
    for (var i = 0; i < nSize; i++) {
      runs.add(cv.Point3i(-i, i, -nSize + i));
      runs.add(cv.Point3i(-i, i, nSize - i));
    }
    runs.add(cv.Point3i(-nSize, nSize, 0));
    {
      final kernel = cv.ximgproc_rl.createRLEImage(runs.cvd);
      expect(cv.ximgproc_rl.isRLMorphologyPossible(kernel), true);
    }
    {
      final kernel = await cv.ximgproc_rl.createRLEImageAsync(runs.cvd);
      expect(cv.ximgproc_rl.isRLMorphologyPossible(kernel), true);
    }
  });

  test('cv.ximgproc_rl.threshold getStructuringElement erode dilate', () async {
    final src = cv.Mat.randu(640, 480, cv.MatType.CV_8UC1);
    final (_, src1) = cv.threshold(src, 254.0, 255.0, cv.THRESH_BINARY);
    final src2 = cv.ximgproc_rl.threshold(src1, 254.0, cv.THRESH_BINARY);

    const nSize = 21;

    final elementRLE = cv.ximgproc_rl.getStructuringElement(cv.MORPH_RECT, (nSize * 2 + 1, nSize * 2 + 1));
    final dst = cv.ximgproc_rl.erode(src2, elementRLE, bBoundaryOn: false);
    expect(dst.isEmpty, false);

    final dst1 = cv.ximgproc_rl.dilate(src2, elementRLE);
    expect(dst1.isEmpty, false);

    final dst2 = cv.ximgproc_rl.morphologyEx(src2, cv.MORPH_CROSS, elementRLE);
    expect(dst2.isEmpty, false);

    final dst3 = cv.ximgproc_rl.paint(src, src2, cv.Scalar.all(0));
    expect(dst3.isEmpty, false);
  });

  test('cv.ximgproc_rl.threshold getStructuringElement erode dilate async', () async {
    final src = cv.Mat.randu(640, 480, cv.MatType.CV_8UC1);
    final (_, src1) = await cv.thresholdAsync(src, 254.0, 255.0, cv.THRESH_BINARY);
    final src2 = await cv.ximgproc_rl.thresholdAsync(src1, 254.0, cv.THRESH_BINARY);

    const nSize = 21;

    final elementRLE =
        await cv.ximgproc_rl.getStructuringElementAsync(cv.MORPH_RECT, (nSize * 2 + 1, nSize * 2 + 1));
    final dst = await cv.ximgproc_rl.erodeAsync(src2, elementRLE, bBoundaryOn: false);
    expect(dst.isEmpty, false);

    final dst1 = await cv.ximgproc_rl.dilateAsync(src2, elementRLE);
    expect(dst1.isEmpty, false);

    final dst2 = await cv.ximgproc_rl.morphologyExAsync(src2, cv.MORPH_CROSS, elementRLE);
    expect(dst2.isEmpty, false);

    final dst3 = await cv.ximgproc_rl.paintAsync(src, src2, cv.Scalar.all(0));
    expect(dst3.isEmpty, false);
  });
}
