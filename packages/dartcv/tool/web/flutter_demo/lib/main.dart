// Flutter web demo for the dartcv4 wasm backend spike.
//
// Runs the same slice as tool/web/demo (Mat, imdecode, cvtColor, gaussianBlur, imencode,
// exceptions, async) through package:dartcv4/web_spike.dart, prints every result to the
// console, and shows the input next to the blurred grayscale output.

import 'package:dartcv4/web_spike.dart' as cv;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slice_demo.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  Uint8List? _input;
  Uint8List? _output;
  Map<String, Object?>? _results;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    try {
      final png = (await rootBundle.load('assets/lenna.png')).buffer.asUint8List();
      final results = await runSlice(png);
      final img = cv.imdecode(png, cv.IMREAD_COLOR);
      final blur = cv.gaussianBlur(cv.cvtColor(img, cv.COLOR_BGR2GRAY), (15, 15), 5);
      final (ok, out) = cv.imencode('.png', blur);
      img.dispose();
      blur.dispose();
      results.forEach((k, v) => debugPrint('dartcv-demo $k: $v'));
      debugPrint('dartcv-demo compiled to ${kIsWasm ? 'wasm' : 'js'}, display imencode ok: $ok');
      debugPrint('dartcv-demo DONE');
      setState(() {
        _input = png;
        _output = out;
        _results = results;
      });
    } catch (e, st) {
      debugPrint('dartcv-demo FAILED: $e\n$st');
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dartcv4 web',
      home: Scaffold(
        appBar: AppBar(title: Text('dartcv4 on Flutter web (${kIsWasm ? 'dart2wasm' : 'dart2js'})')),
        body: _error != null
            ? Center(child: Text('FAILED: $_error'))
            : _results == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(child: Image.memory(_input!)),
                      const SizedBox(width: 16),
                      Expanded(child: Image.memory(_output!)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  for (final e in _results!.entries) Text('${e.key}: ${e.value}'),
                ],
              ),
      ),
    );
  }
}
