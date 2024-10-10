import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dartcv_videoio_flutter/dartcv_videoio.dart' as cv;
import 'package:path/path.dart' as p;

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
  String? backend;
  Uint8List? frame;

  @override
  void initState() {
    super.initState();
    _capture = cv.VideoCapture.empty();
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
                ElevatedButton(
                  onPressed: () async {
                    final appDir = await getApplicationCacheDirectory();
                    final videoFile = File(p.join(appDir.path, "small.mp4"));
                    if (!videoFile.existsSync()) {
                      final bytes = await rootBundle.load("assets/small.mp4");
                      await videoFile.writeAsBytes(bytes.buffer.asUint8List());
                      debugPrint("Save assets/small.mp4 to ${videoFile.path}");
                    }
                    final success = _capture.open(
                      videoFile.path,
                      apiPreference: Platform.isIOS ? cv.CAP_AVFOUNDATION : cv.CAP_FFMPEG,
                    );
                    if (!success) {
                      debugPrint("Open $videoFile failed");
                      return;
                    }

                    final (ret, _frame) = _capture.read();
                    if (ret) {
                      final (s, f) = cv.imencode(".png", _frame);
                      if (s) {
                        setState(() {
                          backend = _capture.getBackendName();
                          frame = f;
                        });
                      }else{
                        debugPrint("cv.imencode failed");
                      }
                    }else{
                      debugPrint("capture.read failed");
                    }
                  },
                  child: const Text("start"),
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
