// Keeps test/web_test.dart's fixture lists in sync with the tests it runs.
//
// The browser suite copies fixtures into Emscripten's file system before the tests run, because a
// test cannot read the repository from a page. A test file that starts using a new
// `test/<dir>/<file>` path would then fail in Chrome only, minutes into a CI run, with a 404 for a
// file that exists locally. This test scans the sources instead, so the mistake shows up in a
// normal `dart test` on the VM.
//
// @TestOn('vm') - it reads test/web_test.dart and the test files it lists with dart:io.
@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

/// A path a test reads from the repository, e.g. `test/images/lenna.png`.
final _pathLiteral = RegExp(r'''["'](test/(?:images|data|font|models)/[^"'$]+)["']''');

/// Directories the suite writes to; they are created for the browser, not copied.
final _writtenDirs = {'test/images_out'};

void main() {
  test('every fixture the web tests read is in test/web_test.dart', () {
    final webTest = File('test/web_test.dart');
    expect(
      webTest.existsSync(),
      isTrue,
      reason: 'run `dart test` from packages/dartcv, see ${Directory.current.path}',
    );
    final src = webTest.readAsStringSync();

    // The files the browser suite runs, from its conditional imports.
    final webFiles = RegExp(
      r"^import '([^']+_test\.dart)' as",
      multiLine: true,
    ).allMatches(src).map((m) => 'test/${m.group(1)!}').toList();
    expect(webFiles, isNotEmpty);

    final copied = _constList(src, '_fixtures')..addAll(_constList(src, '_optionalFixtures'));

    final missing = <String>[];
    for (final file in webFiles) {
      final lines = File(file).readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        for (final m in _pathLiteral.allMatches(lines[i])) {
          final path = m.group(1)!;
          // Paths are copied under `test/`, so the list holds them relative to it.
          final fixture = path.substring('test/'.length);
          if (_writtenDirs.any(path.startsWith)) continue;
          if (!copied.contains(fixture)) {
            missing.add('  $file:${i + 1}: $path (add "$fixture" to _fixtures/_optionalFixtures)');
          }
        }
      }
    }

    expect(missing, isEmpty, reason: 'fixtures missing from test/web_test.dart:\n${missing.join('\n')}');
  });
}

/// The string entries of the `const <name> = [ ... ];` list in [src].
List<String> _constList(String src, String name) {
  final start = src.indexOf('const $name = [');
  expect(start, isNot(-1), reason: 'no `const $name = [` in test/web_test.dart');
  final end = src.indexOf('];', start);
  expect(end, isNot(-1), reason: 'unterminated `const $name` list');
  return RegExp("'([^']+)'").allMatches(src.substring(start, end)).map((m) => m.group(1)!).toList();
}
