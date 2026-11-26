// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Lint-style guard for #464: it walks lib/src and fails on any native call that receives a `.ref`
// view of a temporary wrapper. Needs dart:io, so it runs natively only (the behaviour it guards is
// covered on the web by test/core/record_struct_test.dart).

import 'dart:io';

import 'package:test/test.dart';

/// `.ref` taken from a wrapper that is built inside the argument expression
/// itself: `Point(0, 0).ref`, `toSize().ref`, `warpAffine(src, m, (w, h).cvd.ref)`.
///
/// Only the first alternative is needed for the call/getter forms (`toSize()`
/// and friends all end in `)`), the second catches the record extensions whose
/// only job is to build a wrapper. `..ref` cascades are excluded on purpose:
/// `calloc<CvPoint>()..ref.x = 0` derefs the pointer that was just allocated.
final temporaryRef = RegExp(r'\)\s*\.(?!\.)ref\b|\.cvd\s*\.ref\b');

/// Opt-out marker for a line whose `.ref` receiver is known to stay alive
/// (a named local or a parameter), e.g. `// ref-ok: val is a parameter`.
const refOkMarker = 'ref-ok:';

void main() {
  // The tests above only sample the behaviour; this one keeps the pattern that
  // caused #464 from coming back, because a single reintroduced call site is a
  // use-after-free waiting for a well-timed GC.
  test('lib/src passes no temporary wrapper .ref to native calls', () {
    final root = Directory('lib/src');
    expect(
      root.existsSync(),
      isTrue,
      reason: 'run `dart test` from packages/dartcv, see ${Directory.current.path}',
    );

    final offenders = <String>[];
    for (final file in root.listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll(r'\', '/');
      // Generated ffigen bindings only declare the structs, they make no calls.
      if (!path.endsWith('.dart') || path.startsWith('lib/src/g/')) continue;

      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        // Doc comments mention `toPoint().ref` while explaining the hazard.
        if (line.trimLeft().startsWith('//') || line.contains(refOkMarker)) continue;
        if (temporaryRef.hasMatch(line)) {
          offenders.add('  $path:${i + 1}: ${line.trim()}');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          '''
Found ${offenders.length} temporary wrapper `.ref` receiver(s) in lib/src.
A GC can run the temporary's NativeFinalizer before the native call copies the
struct, so the call reads freed memory (#464). Pass the Dart-heap struct that
represents the same value instead:
  (int, int)              -> (w, h).cvdRef        // CvSize
  (int, int)              -> (x, y).pointRef     // CvPoint
  (int, int, double)      -> (type, n, eps).cvdRef // TermCriteria
If the receiver is a named local or a parameter and therefore stays alive for
the whole call, mark that line with `// $refOkMarker <reason>`.

${offenders.join('\n')}
''',
    );
  });
}
