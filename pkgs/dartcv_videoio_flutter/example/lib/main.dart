import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:dartcv_videoio_flutter/dartcv_videoio.dart' as cv;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late cv.VideoCapture _capture;
  late String backend;
  Uint8List? frame;

  @override
  void initState() {
    super.initState();
    _capture = cv.VideoCapture.fromFile(
      r"D:\flutter\opencv_dart\test\images\small.mp4",
      apiPreference: cv.CAP_FFMPEG,
    );
    backend = _capture.getBackendName();
    final (ret, _frame) = _capture.read();
    if (ret) {
      final (s, f) = cv.imencode(".png", _frame);
      if (s) {
        frame = f;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  "Backend: $backend",
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 200,
                  child: frame == null ? const Placeholder() : Image.memory(frame!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
