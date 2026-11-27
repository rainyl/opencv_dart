// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dartcv4/dartcv.dart' as cv;

/// Turns a [cv.Mat] into something Flutter can paint.
///
/// The pixels are copied into an immutable buffer, so the [cv.Mat] can be disposed right after - the
/// demo relies on that to keep `liveObjectCount()` flat while frames stream.
Future<ui.Image> matToImage(cv.Mat mat) async {
  // Flutter wants RGBA; OpenCV gives BGR (or gray).
  final rgba = switch (mat.channels) {
    4 => cv.cvtColor(mat, cv.COLOR_BGRA2RGBA),
    3 => cv.cvtColor(mat, cv.COLOR_BGR2RGBA),
    _ => cv.cvtColor(mat, cv.COLOR_GRAY2RGBA),
  };
  try {
    final bytes = Uint8List.fromList(rgba.data);
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: rgba.cols,
      height: rgba.rows,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();
    codec.dispose();
    descriptor.dispose();
    buffer.dispose();
    return frame.image;
  } finally {
    if (rgba != mat) rgba.dispose();
  }
}

/// PNG bytes of [mat], through the library's own encoder.
Uint8List matToPng(cv.Mat mat) {
  final (ok, bytes) = cv.imencode('.png', mat, params: cv.VecI32.fromList([cv.IMWRITE_PNG_COMPRESSION, 3]));
  if (!ok) throw cv.CvdException('imencode failed');
  return bytes;
}

/// Decodes PNG/JPEG bytes into a BGR mat.
cv.Mat pngToMat(Uint8List bytes) {
  final mat = cv.imdecode(bytes, cv.IMREAD_COLOR);
  if (mat.isEmpty) throw cv.CvdException('imdecode produced an empty Mat');
  return mat;
}

/// The filters the image lab offers, each with a synchronous and a worker-thread implementation.
///
/// Both halves are plain pointers to the library's own API: the async variants differ only in which
/// thread runs the kernels.
enum LabFilter {
  grayscale('Grayscale', 'cvtColor BGR→GRAY'),
  blur('Gaussian blur', 'gaussianBlur'),
  edges('Canny edges', 'canny'),
  threshold('Binary threshold', 'threshold'),
  clahe('CLAHE contrast', 'CLAHE.apply'),
  pixelate('Pixelate', 'resize ×2'),
  invert('Invert', 'bitwiseNOT');

  const LabFilter(this.label, this.api);

  final String label;
  final String api;
}

/// Applies [filter] on the calling thread.
cv.Mat applyFilterSync(cv.Mat src, LabFilter filter, {required double amount}) {
  return switch (filter) {
    LabFilter.grayscale => cv.cvtColor(src, cv.COLOR_BGR2GRAY),
    LabFilter.blur => cv.gaussianBlur(src, (_odd(amount * 12), _odd(amount * 12)), amount * 4),
    LabFilter.edges => cv.canny(src, amount * 90 + 20, amount * 200 + 60),
    LabFilter.threshold =>
      cv.threshold(cv.cvtColor(src, cv.COLOR_BGR2GRAY), amount * 200 + 20, 255, cv.THRESH_BINARY).$2,
    LabFilter.clahe => _claheSync(src, amount),
    LabFilter.pixelate => _pixelate(src, amount),
    LabFilter.invert => cv.bitwiseNOT(src),
  };
}

/// Same, on the library's worker thread. Every call is awaited, so this is the "UI stays free" path.
Future<cv.Mat> applyFilterAsync(cv.Mat src, LabFilter filter, {required double amount}) async {
  return switch (filter) {
    LabFilter.grayscale => await cv.cvtColorAsync(src, cv.COLOR_BGR2GRAY),
    LabFilter.blur => await cv.gaussianBlurAsync(src, (_odd(amount * 12), _odd(amount * 12)), amount * 4),
    LabFilter.edges => await cv.cannyAsync(src, amount * 90 + 20, amount * 200 + 60),
    LabFilter.threshold => (await cv.thresholdAsync(
      await cv.cvtColorAsync(src, cv.COLOR_BGR2GRAY),
      amount * 200 + 20,
      255,
      cv.THRESH_BINARY,
    )).$2,
    LabFilter.clahe => await _claheAsync(src, amount),
    LabFilter.pixelate => await _pixelateAsync(src, amount),
    LabFilter.invert => await cv.bitwiseNOTAsync(src),
  };
}

/// CLAHE rejects anything but a single-channel 8U/16U image, so it runs on the L channel of LAB and
/// is written back - the adaptive contrast without the colour shift a per-channel pass would cause.
cv.Mat _claheSync(cv.Mat src, double amount) {
  final clahe = cv.CLAHE.create(amount * 8 + 1, (8, 8));
  final lab = cv.cvtColor(src, cv.COLOR_BGR2Lab);
  final l = cv.extractChannel(lab, 0);
  final enhanced = clahe.apply(l);
  cv.insertChannel(enhanced, lab, 0);
  final bgr = cv.cvtColor(lab, cv.COLOR_Lab2BGR);
  clahe.dispose();
  l.dispose();
  enhanced.dispose();
  lab.dispose();
  return bgr;
}

Future<cv.Mat> _claheAsync(cv.Mat src, double amount) async {
  final clahe = cv.CLAHE.create(amount * 8 + 1, (8, 8));
  final lab = await cv.cvtColorAsync(src, cv.COLOR_BGR2Lab);
  final l = await cv.extractChannelAsync(lab, 0);
  final enhanced = await clahe.applyAsync(l);
  await cv.insertChannelAsync(enhanced, lab, 0);
  final bgr = await cv.cvtColorAsync(lab, cv.COLOR_Lab2BGR);
  clahe.dispose();
  l.dispose();
  enhanced.dispose();
  lab.dispose();
  return bgr;
}

/// cv::resize needs an odd kernel-like size for blur; keep the sliders from producing 0 or even.
int _odd(double value) {
  final v = value.round();
  return v.isEven ? v + 1 : (v < 3 ? 3 : v);
}

/// Downscale then upscale with nearest neighbour: the classic mosaic look, and two real kernels.
(int, int) _mosaicSize(cv.Mat src, double amount) {
  final factor = 8 + (amount * 40).round();
  return ((src.cols / factor).round().clamp(2, src.cols), (src.rows / factor).round().clamp(2, src.rows));
}

cv.Mat _pixelate(cv.Mat src, double amount) {
  final small = cv.resize(src, _mosaicSize(src, amount), interpolation: cv.INTER_AREA);
  final up = cv.resize(small, (src.cols, src.rows), interpolation: cv.INTER_NEAREST);
  small.dispose();
  return up;
}

Future<cv.Mat> _pixelateAsync(cv.Mat src, double amount) async {
  final small = await cv.resizeAsync(src, _mosaicSize(src, amount), interpolation: cv.INTER_AREA);
  final up = await cv.resizeAsync(small, (src.cols, src.rows), interpolation: cv.INTER_NEAREST);
  small.dispose();
  return up;
}
