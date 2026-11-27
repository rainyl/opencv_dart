// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// `lib/src/package_version.dart` is what the web runtime compares the loaded module against, and it
// is generated from `pubspec.yaml` by `tool/web/gen_web_bindings.dart` (whose `--check` CI runs).
// A bump that forgets to regenerate would make every app reject its own module, so pin it here too -
// this runs in a plain `dart test`, without Emscripten or a browser.
//
// @TestOn('vm') - it reads the sources with dart:io.
@TestOn('vm')
library;

import 'dart:io';

import 'package:dartcv4/src/package_version.dart';
import 'package:test/test.dart';

void main() {
  test('packageVersion matches pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(r'^version: *(.+)$', multiLine: true).firstMatch(pubspec)?.group(1)?.trim();
    expect(packageVersion, version);
  });
}
