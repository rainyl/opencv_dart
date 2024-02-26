import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image/image.dart' as img;

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
  cv.Mat? image;

  @override
  void initState() {
    super.initState();
  }

  Future<ui.Image> convertImageToFlutterUi(img.Image image) async {
    if (image.format != img.Format.uint8 || image.numChannels != 4) {
      final cmd = img.Command()
        ..image(image)
        ..convert(format: img.Format.uint8, numChannels: 4);
      final rgba8 = await cmd.getImageThread();
      if (rgba8 != null) {
        image = rgba8;
      }
    }

    ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(image.toUint8List());

    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer,
        height: image.height, width: image.width, pixelFormat: ui.PixelFormat.rgba8888);

    ui.Codec codec = await id.instantiateCodec(targetHeight: image.height, targetWidth: image.width);

    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image uiImage = fi.image;

    return uiImage;
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
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  "images/lenna.png",
                  width: 100,
                  height: 100,
                ),
                spacerSmall,
                ElevatedButton(
                    onPressed: () async {
                      final data = await DefaultAssetBundle.of(context).load("images/lenna.png");
                      setState(() {
                        image = cv.imdecode(data.buffer.asUint8List(), cv.IMREAD_GRAYSCALE);
                      });
                    },
                    child: const Text("Process")),
                image == null
                    ? Text("Image is null!")
                    : Image.memory(
                        cv.imencode(cv.ImageFormat.png.ext, image!),
                        width: 100,
                        height: 100,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
