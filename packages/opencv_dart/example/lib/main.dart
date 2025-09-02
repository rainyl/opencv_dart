// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opencv_dart/opencv.dart' as cv;
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
  var images = <Uint8List>[];
  final _ft = cv.FreeType2.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<(cv.Mat, cv.Mat)> heavyTaskAsync(cv.Mat im, {int count = 1000}) async {
    late cv.Mat gray, blur;
    for (var i = 0; i < count; i++) {
      gray = await cv.cvtColorAsync(im, cv.COLOR_BGR2GRAY);
      blur = await cv.gaussianBlurAsync(im, (7, 7), 2, sigmaY: 2);
      if (i != count - 1) {
        gray.dispose(); // manually dispose
        blur.dispose(); // manually dispose
      }
    }
    return (gray, blur);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Native Packages')),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final img = await picker.pickImage(source: ImageSource.gallery);
                  if (img != null) {
                    final path = img.path;
                    final mat = cv.imread(path);
                    print("cv.imread: width: ${mat.cols}, height: ${mat.rows}, path: $path");
                    debugPrint("mat.data.length: ${mat.data.length}");
                    // heavy computation
                    final (gray, blur) = await heavyTaskAsync(mat, count: 1);
                    setState(() {
                      images = [
                        cv.imencode(".png", mat).$2,
                        cv.imencode(".png", gray).$2,
                        cv.imencode(".png", blur).$2,
                      ];
                    });
                  }
                },
                child: const Text("Pick Image"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final data = await DefaultAssetBundle.of(context).load("images/lenna.png");
                  final bytes = data.buffer.asUint8List();
                  final (gray, blur) = await heavyTaskAsync(cv.imdecode(bytes, cv.IMREAD_COLOR));
                  setState(() {
                    images = [bytes, cv.imencode(".png", gray).$2, cv.imencode(".png", blur).$2];
                  });
                },
                child: const Text("Process"),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: images.length,
                        itemBuilder: (ctx, idx) => Card(child: Image.memory(images[idx])),
                      ),
                    ),
                    Expanded(child: SingleChildScrollView(child: Text(cv.getBuildInformation()))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
