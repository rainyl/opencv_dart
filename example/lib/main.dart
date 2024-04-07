import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // native resources are unsendable for isolate, so use raw data or encoded Uint8List and convert back
  Future<(Uint8List, Uint8List)> heavyTask(Uint8List buffer) async {
    final ret = Isolate.run(() {
      final im = cv.imdecode(Uint8List.fromList(buffer), cv.IMREAD_COLOR);
      late cv.Mat gray, blur;
      for (var i = 0; i < 1000; i++) {
        gray = cv.cvtColor(im, cv.COLOR_BGR2GRAY);
        blur = cv.gaussianBlur(im, (7, 7), 2, sigmaY: 2);
      }
      return (cv.imencode(cv.ImageFormat.png.ext, gray), cv.imencode(cv.ImageFormat.png.ext, blur));
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final data = await DefaultAssetBundle.of(context).load("images/lenna.png");
                  final bytes = data.buffer.asUint8List();
                  // heavy computation
                  final (gray, blur) = await heavyTask(bytes);
                  setState(() {
                    images = [bytes, gray, blur];
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
                        itemBuilder: (ctx, idx) => Card(
                          child: Image.memory(images[idx]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(cv.getBuildInformation()),
                      ),
                    ),
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
