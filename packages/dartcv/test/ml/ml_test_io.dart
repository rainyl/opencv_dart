// The dart:io side of the ml tests' file helpers; `ml_test_io_web.dart` replaces it on the web.
import 'dart:io';

import 'package:test/test.dart';

/// A temp dir removed after the test.
String tempDir() {
  final dir = Directory.systemTemp.createTempSync('dartcv_ml_test_');
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir.path;
}

/// The content of [path], for the `loadFromString` variants.
String readAsString(String path) => File(path).readAsStringSync();

void writeAsString(String path, String contents) => File(path).writeAsStringSync(contents);
