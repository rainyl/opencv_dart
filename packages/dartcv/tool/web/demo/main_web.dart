// Spike demo, web entry point (dart compile js / dart compile wasm), see tool/web/demo/index.html.
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:dartcv4/src/web/opencvjs.dart';

// The slice lives in the Flutter demo so both demos share it.
// ignore: avoid_relative_lib_imports
import '../flutter_demo/lib/slice_demo.dart';

@JS('fetchBytes')
external JSPromise<JSUint8Array> _fetchBytes(String url);
@JS('report')
external void _report(String line);

Future<void> main() async {
  try {
    final png = (await _fetchBytes('lenna.png').toDart).toDart;
    final r = await runSlice(png);
    r.forEach((k, v) => _report('wasm $k: $v'));
    await _opencvJs(png, r);
    _report('DONE');
  } catch (e, st) {
    _report('FAILED: $e\n$st');
  }
}

// Same slice on the prebuilt opencv.js, cross-checked against the dartcv wasm result.
Future<void> _opencvJs(Uint8List png, Map<String, Object?> wasm) async {
  final sw = Stopwatch()..start();
  await initOpenCvJs();
  _report('opencvjs init ms: ${sw.elapsedMilliseconds}');
  final cv = cvjs;
  final rgba = await imdecodeOpenCvJs(png); // browser decode: async, RGBA only
  _report('opencvjs imdecode: ${rgba.rows}x${rgba.cols}x${rgba.channels()}');
  final gray = MatJs();
  cv.cvtColor(rgba, gray, 11 /* COLOR_RGBA2GRAY */);
  final blur = MatJs();
  cv.gaussianBlur(gray, blur, SizeJs(5, 5), 1.5, 0, 4);
  final d = matJsData(blur);
  _report('opencvjs gray checksum matches wasm: ${_fnv(matJsData(gray)) == wasm['gray checksum']}');
  _report('opencvjs blur checksum matches wasm: ${_fnv(d) == wasm['blur checksum']}');
  try {
    cv.cvtColor(gray, MatJs(), 6);
    _report('opencvjs exception: NOT THROWN');
  } catch (e) {
    _report('opencvjs exception surfaces as: ${e.runtimeType}: ${e.toString().split('\n').first}');
  }
  sw.reset();
  for (var i = 0; i < 50; i++) {
    final a = await imdecodeOpenCvJs(png);
    final b = MatJs();
    cv.gaussianBlur(a, b, SizeJs(5, 5), 1.5, 0, 4);
    a.delete_();
    b.delete_();
  }
  _report('opencvjs 50x (imdecode+blur) ms: ${sw.elapsedMilliseconds}');
  for (final m in [rgba, gray, blur]) {
    m.delete_();
  }
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
