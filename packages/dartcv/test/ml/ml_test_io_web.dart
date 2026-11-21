// The web side of the ml tests' file helpers: Emscripten's in-memory file system, which the C
// side's `FileStorage` writes to as well, so `save`/`load` run unchanged in the browser.
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:dartcv4/src/web/runtime.dart' as rt;
import 'package:test/test.dart';

JSObject get _fs => rt.module['FS']! as JSObject;

var _counter = 0;

/// A temp dir removed after the test.
String tempDir() {
  final path = '/tmp/dartcv_ml_test_${_counter++}';
  _fs.callMethod('mkdirTree'.toJS, path.toJS);
  addTearDown(() => _removeTree(path));
  return path;
}

/// The content of [path], for the `loadFromString` variants.
String readAsString(String path) =>
    utf8.decode(_fs.callMethod<JSUint8Array>('readFile'.toJS, path.toJS).toDart);

void writeAsString(String path, String contents) =>
    _fs.callMethod('writeFile'.toJS, path.toJS, utf8.encode(contents).toJS);

void _removeTree(String path, [JSObject? fs]) {
  fs ??= _fs;
  for (final entry in fs.callMethod<JSArray<JSString>>('readdir'.toJS, path.toJS).toDart) {
    final name = entry.toDart;
    if (name == '.' || name == '..') continue;
    final child = '$path/$name';
    final mode = (fs.callMethod<JSObject>('stat'.toJS, child.toJS)['mode']! as JSNumber).toDartInt;
    if (fs.callMethod<JSBoolean>('isDir'.toJS, mode.toJS).toDart) {
      _removeTree(child, fs);
    } else {
      fs.callMethod('unlink'.toJS, child.toJS);
    }
  }
  fs.callMethod('rmdir'.toJS, path.toJS);
}
