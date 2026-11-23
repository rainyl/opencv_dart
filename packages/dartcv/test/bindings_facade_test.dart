// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Keeps the platform switch in one place: hand-written code imports `lib/src/bindings/<module>.dart`,
// which is the only file that says `if (dart.library.js_interop)`, instead of repeating the
// conditional import next to every call site.
//
// `tool/web/gen_web_bindings.dart --check` already covers the facades it generates, but nothing
// stops a new (or copied) file from re-introducing the inline switch, which is exactly how 77 files
// ended up carrying it. A normal `dart test` on the VM is a cheap place to catch that.
//
// @TestOn('vm') - it reads the sources with dart:io.
@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

/// Facades that predate `lib/src/bindings/`: they switch to `lib/src/web/` for the platform
/// primitives themselves, so they cannot import a facade that would import them.
const _handWrittenFacades = {'lib/src/ffi.dart', 'lib/src/init.dart', 'lib/src/package_ffi.dart'};

void main() {
  test('only the facades choose between the native and the web bindings', () {
    final offenders = <String>[];
    for (final entity in Directory('lib/src').listSync(recursive: true, followLinks: false)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final path = entity.path.replaceAll(r'\', '/');
      // The facades, their web side, and the generated bindings themselves.
      if (path.startsWith('lib/src/bindings/')) continue;
      if (path.startsWith('lib/src/web/')) continue;
      if (path.startsWith('lib/src/g/')) continue;
      if (_handWrittenFacades.contains(path)) continue;
      if (entity.readAsStringSync().contains('dart.library.js_interop')) offenders.add(path);
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'import ../bindings/<module>.dart instead of a `g/` file: the conditional import belongs '
          'in lib/src/bindings/, which tool/web/gen_web_bindings.dart generates and checks',
    );
  });
}
