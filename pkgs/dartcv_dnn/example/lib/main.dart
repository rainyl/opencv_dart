import 'package:flutter/material.dart';
import 'dart:async';

import 'package:dartcv_dnn/dartcv_dnn.dart' as cv;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? predictedNum;
  Uint8List? _image;
  cv.Net? _net;

  @override
  void initState() {
    super.initState();
  }

  Future<int> _infer(cv.Mat image) async {
    if (_net == null) {
      final buf = await rootBundle.load("assets/models/mnist-8.onnx");
      _net = cv.Net.fromOnnxBytes(buf.buffer.asUint8List());
      assert(!_net!.isEmpty);
    }
    if (image.channels > 1) {
      cv.cvtColor(image, cv.COLOR_BGR2GRAY, dst: image);
    }
    if (image.width != 28 || image.height != 28) {
      cv.resize(image, (28, 28), dst: image);
    }
    final blob = await cv.blobFromImageAsync(image, ddepth: cv.MatType.CV_32F);
    await _net!.setInputAsync(blob);
    cv.Mat out = await _net!.forwardAsync();
    final (_, maxVal, _, maxLoc) = await cv.minMaxLocAsync(out);
    out.dispose();
    blob.dispose();
    debugPrint("maxVal: $maxVal, maxIdx: $maxLoc");
    return maxLoc.x;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('dartcv DNN - MINIST'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(children: [
              // button to select image
              ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final bytes = await image.readAsBytes();
                  setState(() {
                    _image = bytes;
                  });

                  final inferImage = await cv.imdecodeAsync(_image!, cv.IMREAD_GRAYSCALE);
                  final number = await _infer(inferImage);
                  setState(() {
                    predictedNum = number;
                  });
                },
                child: const Text('Select image'),
              ),
              const SizedBox(height: 10),
              // button to predict
              ElevatedButton(
                onPressed: () async {
                  if (_image == null) {
                    final bytes = await rootBundle.load("assets/images/MNIST_9.png");
                    setState(() {
                      _image = bytes.buffer.asUint8List();
                    });
                  }
                  final inferImage = await cv.imdecodeAsync(_image!, cv.IMREAD_GRAYSCALE);
                  final number = await _infer(inferImage);
                  setState(() {
                    predictedNum = number;
                  });
                },
                child: const Text('Predict'),
              ),
              const SizedBox(height: 10),
              // show image
              SizedBox(
                height: 100,
                child: _image == null
                    ? const Placeholder()
                    : Image.memory(
                        _image!,
                        fit: BoxFit.fill,
                      ),
              ),
              const Text('Predicted number:', style: textStyle),
              Text("$predictedNum", style: textStyle),
            ]),
          ),
        ),
      ),
    );
  }
}
