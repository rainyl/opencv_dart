import 'package:dartcv4/dartcv.dart' as cv;

// `tempDir`, `readAsString` and `writeAsString`: dart:io natively, Emscripten's in-memory file
// system on the web (which the C side's FileStorage uses too), so `save`/`load` work there as well.
export 'ml_test_io.dart' if (dart.library.js_interop) 'ml_test_io_web.dart';

/// Two well separated 2D clusters, class 0 around (1.5, 1.5) and class 1 around (8.5, 8.5).
const clusterPoints = <double>[
  1, 1, 1, 2, 2, 1, 2, 2, 1.5, 1.5, //
  8, 8, 8, 9, 9, 8, 9, 9, 8.5, 8.5,
];
const clusterLabels = <int>[0, 0, 0, 0, 0, 1, 1, 1, 1, 1];

cv.Mat clusterSamples() => cv.Mat.fromList(10, 2, cv.MatType.CV_32FC1, clusterPoints);

cv.Mat clusterResponsesI32() => cv.Mat.fromList(10, 1, cv.MatType.CV_32SC1, clusterLabels);

cv.Mat clusterResponsesF32() =>
    cv.Mat.fromList(10, 1, cv.MatType.CV_32FC1, clusterLabels.map((e) => e.toDouble()).toList());

/// One query point near each cluster, expected labels `[0, 1]`.
cv.Mat queryPoints() => cv.Mat.fromList(2, 2, cv.MatType.CV_32FC1, <double>[1.2, 1.3, 8.7, 8.1]);

List<int> labelsOf(cv.Mat results) => List.generate(results.rows, (i) => results.atNum(i, 0).round());
