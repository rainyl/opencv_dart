// Spike demo: the end-to-end slice, written once against package:dartcv4/web_spike.dart.
// Shared by the Flutter demo (this package) and tool/web/demo/main_{web,vm}.dart.
// Compiles for the VM (dart:ffi backend) and for dart2js/dart2wasm (wasm backend).

import 'dart:typed_data';

import 'package:dartcv4/web_spike.dart' as cv;

Future<Map<String, Object?>> runSlice(Uint8List png) async {
  await cv.initDartcv();
  final out = <String, Object?>{};

  // 1. Mat from data + cvtColor, checked against the BT.601 formula.
  final px = cv.Mat.fromList(1, 2, cv.MatType.CV_8UC3, [10, 20, 30, 200, 100, 50]); // BGR
  final g = cv.cvtColor(px, cv.COLOR_BGR2GRAY);
  out['fromList+cvtColor'] = g.data.toList();
  out['fromList+cvtColor expected'] = [
    (0.114 * 10 + 0.587 * 20 + 0.299 * 30).round(),
    (0.114 * 200 + 0.587 * 100 + 0.299 * 50).round(),
  ];

  // 2. imdecode a PNG, gray, blur, read pixels back.
  final img = cv.imdecode(png, cv.IMREAD_COLOR);
  out['imdecode'] = '${img.rows}x${img.cols}x${img.channels} type=${img.type == cv.MatType.CV_8UC3}';
  final gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY);
  final blur = cv.gaussianBlur(gray, (5, 5), 1.5);
  final d = blur.data;
  var sum = 0;
  for (final v in d) {
    sum += v;
  }
  out['gray checksum'] = _fnv(gray.data);
  out['blur checksum'] = _fnv(d);
  out['blur mean'] = (sum / d.length).toStringAsFixed(3);
  out['blur first 8'] = d.sublist(0, 8).toList();

  // 3. imencode round trip (PNG is lossless, so decode(encode(x)) == x).
  final (ok, bytes) = cv.imencode('.png', blur);
  final back = cv.imdecode(bytes, cv.IMREAD_UNCHANGED);
  out['imencode ok'] = ok;
  out['roundtrip equal'] = _fnv(back.data) == _fnv(d) && back.channels == 1;

  // 4. C++ exception -> CvStatus -> CvException (needs wasm exception support).
  try {
    cv.cvtColor(gray, cv.COLOR_BGR2GRAY); // 1 channel in, BGR2GRAY wants 3 or 4
    out['exception'] = 'NOT THROWN';
  } catch (e) {
    out['exception'] = e.toString().split('\n').first;
  }

  // 5. Async API shape.
  final ga = await cv.cvtColorAsync(img, cv.COLOR_BGR2GRAY);
  out['async equal'] = _fnv(ga.data) == _fnv(gray.data);

  // 6. Explicit dispose loop (the GC cannot see wasm-heap pressure).
  final sw = Stopwatch()..start();
  for (var i = 0; i < 50; i++) {
    final a = cv.imdecode(png, cv.IMREAD_COLOR);
    final b = cv.gaussianBlur(a, (5, 5), 1.5);
    a.dispose();
    b.dispose();
  }
  out['50x (imdecode+blur) ms'] = sw.elapsedMilliseconds;

  for (final m in [px, g, img, gray, blur, back, ga]) {
    m.dispose();
  }
  return out;
}

int _fnv(List<int> data) {
  var h = 0x811c9dc5;
  for (final b in data) {
    h ^= b;
    // h * 0x01000193 mod 2^32, split so every intermediate stays exact under dart2js (2^53).
    h = (h * 0x193 + (h & 0xff) * 0x1000000) % 0x100000000;
  }
  return h;
}
