// ignore_for_file: avoid_print

import 'dart:isolate';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  // On the web this loads `web/dartcv.js` + `web/dartcv.wasm` (see README). On native platforms the
  // library is loaded by the native-assets hooks and this is a no-op.
  await cv.initDartcv();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // The same 1000 iterations are seconds on native but far too slow in wasm, so the web build does
  // fewer of them.
  static final _iterations = kIsWeb ? 10 : 1000;

  var images = <Uint8List>[];

  @override
  void dispose() {
    super.dispose();
  }

  /// The actual work, shared by the isolate and the web variant.
  ///
  /// Only encoded bytes go in and out, so this also runs in an isolate, where the caller's native
  /// resources (`cv.Mat`s) are not reachable. `Mat`s are disposed explicitly: on the web the browser
  /// cannot see the wasm heap, so the garbage collector frees them late.
  static (Uint8List, Uint8List) _process(Uint8List buffer, int count) {
    final im = cv.imdecode(buffer, cv.IMREAD_COLOR);
    late cv.Mat gray, blur;
    for (var i = 0; i < count; i++) {
      gray = cv.cvtColor(im, cv.COLOR_BGR2GRAY);
      blur = cv.gaussianBlur(im, (7, 7), 2, sigmaY: 2);
      if (i != count - 1) {
        gray.dispose();
        blur.dispose();
      }
    }
    final encoded = (
      cv.imencode(".png", gray).$2,
      cv.imencode(".png", blur).$2,
    );
    im.dispose();
    gray.dispose();
    blur.dispose();
    return encoded;
  }

  // native resources are unsendable for isolate, so use raw data or encoded Uint8List and convert back
  Future<(Uint8List, Uint8List)> heavyTask(Uint8List buffer) async {
    // Neither dart2js nor dart2wasm has isolates: run the same work on the calling thread instead,
    // which blocks the UI for the duration.
    if (kIsWeb) return _process(buffer, _iterations);
    return Isolate.run(() => _process(buffer, _iterations));
  }

  Future<(cv.Mat, cv.Mat)> heavyTaskAsync(cv.Mat im) async {
    late cv.Mat gray, blur;
    for (var i = 0; i < _iterations; i++) {
      gray = await cv.cvtColorAsync(im, cv.COLOR_BGR2GRAY);
      blur = await cv.gaussianBlurAsync(im, (7, 7), 2, sigmaY: 2);
      if (i != _iterations - 1) {
        gray.dispose();
        blur.dispose();
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
                  final img = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (img != null) {
                    // On the web the picked file is a `blob:` URL, not a path the decoder can open,
                    // so decode its bytes instead of handing `imread` the path.
                    final bytes = await img.readAsBytes();
                    final mat = kIsWeb
                        ? cv.imdecode(bytes, cv.IMREAD_COLOR)
                        : cv.imread(img.path);
                    print(
                      "cv.imread: width: ${mat.cols}, height: ${mat.rows}, path: ${img.path}",
                    );
                    final encoded = cv.imencode(".png", mat).$2;
                    // heavy computation
                    final (gray, blur) = await heavyTask(encoded);
                    mat.dispose();
                    setState(() {
                      images = [encoded, gray, blur];
                    });
                  }
                },
                child: const Text("Pick Image"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final data = await DefaultAssetBundle.of(context)
                      .load("images/lenna.png");
                  final bytes = data.buffer.asUint8List();
                  print("bytes: ${bytes.length}");
                  // heavy computation
                  final im = await cv.imdecodeAsync(bytes, cv.IMREAD_COLOR);
                  final (gray, blur) = await heavyTaskAsync(im);
                  final encodedGray = cv.imencode(".png", gray).$2;
                  final encodedBlur = cv.imencode(".png", blur).$2;
                  im.dispose();
                  gray.dispose();
                  blur.dispose();
                  setState(() {
                    images = [bytes, encodedGray, encodedBlur];
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
                        itemBuilder: (ctx, idx) =>
                            Card(child: Image.memory(images[idx])),
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
