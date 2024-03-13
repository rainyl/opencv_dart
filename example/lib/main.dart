import 'dart:async';
import 'dart:typed_data';

import 'package:camera_universal/camera_universal.dart';
import 'package:flutter/material.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var images = <Uint8List>[];
  Uint8List? videoFrame;
  CameraController cameraController = CameraController();

  @override
  void initState() {
    super.initState();
    task();
  }

  Future<void> task() async {
    await cameraController.initializeCameras();
    await cameraController.initializeCamera(
      setState: setState,
    );
    await cameraController.activateCamera(
      setState: setState,
      mounted: () {
        return mounted;
      },
    );
  }

  void takePicture() async {
    var frame = cv.Mat.empty();
    if (cameraController.is_camera_init) {
      final im = await cameraController.action_take_picture(
          onCameraNotInit: () {}, onCameraNotSelect: () {}, onCameraNotActive: () {});
      if (im != null) {
        frame = cv.imread(im.path);
      }
    }
    if (!frame.isEmpty) {
      setState(() {
        videoFrame = cv.imencode(cv.ImageFormat.png.ext, frame);
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
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
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Camera(
                        cameraController: cameraController,
                        onCameraNotInit: (context) {
                          return const SizedBox.shrink();
                        },
                        onCameraNotSelect: (context) {
                          return const SizedBox.shrink();
                        },
                        onCameraNotActive: (context) {
                          return const SizedBox.shrink();
                        },
                        onPlatformNotSupported: (context) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    Expanded(child: videoFrame == null ? Text("Empty") : Image.memory(videoFrame!))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final data = await DefaultAssetBundle.of(context).load("images/lenna.png");
                  final im = cv.imdecode(data.buffer.asUint8List(), cv.IMREAD_COLOR);
                  final gray = cv.Mat.empty();
                  cv.cvtColor(im, gray, cv.COLOR_BGR2GRAY);
                  final blur = cv.Mat.empty();
                  cv.gaussianBlur(im, blur, (7, 7), 2, sigmaY: 2);
                  setState(() {
                    images = [
                      data.buffer.asUint8List(),
                      cv.imencode(cv.ImageFormat.png.ext, gray),
                      cv.imencode(cv.ImageFormat.png.ext, blur)
                    ];
                  });
                  takePicture();
                },
                child: const Text("Process"),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (ctx, idx) => Card(
                    child: Image.memory(images[idx]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
