// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Tests for the struct values that records pass to native functions.
//
// `(w, h).cvd.ref` is a view of the native memory of a temporary `Size`. Nothing
// keeps the wrapper alive, so a GC before the native call copies the struct runs
// its finalizer and the call reads freed memory. `cvdRef`/`pointRef` build the
// struct on the Dart heap instead, which no finalizer can free.

import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
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

/// Allocates enough garbage for several young-generation GCs, and reuses the
/// small native blocks a finalizer may have freed.
void churn() {
  var keep = <List<int>>[];
  for (var i = 0; i < 200000; i++) {
    keep.add(List<int>.filled(16, i));
    if (keep.length > 1000) keep = [];
    cv.Size(1, 2);
  }
}

void main() {
  test('record struct values keep their fields across GCs', () {
    for (var round = 0; round < 20; round++) {
      final size = (600, 400).cvdRef;
      final point = (-1, 7).pointRef;
      final criteria = (cv.TERM_COUNT + cv.TERM_EPS, 30, 1e-4).cvdRef;
      churn();
      expect((size.width, size.height), (600, 400));
      expect((point.x, point.y), (-1, 7));
      expect((criteria.type, criteria.maxCount, criteria.epsilon), (cv.TERM_COUNT + cv.TERM_EPS, 30, 1e-4));
    }
  });

  test('native calls read the sizes they were given', () {
    final src = cv.Mat.zeros(40, 60, cv.MatType.CV_8UC3);
    final m = cv.getRotationMatrix2D(cv.Point2f(30, 20), 10, 1);
    for (var i = 0; i < 2000; i++) {
      final warped = cv.warpAffine(src, m, (61, 41));
      final resized = cv.resize(src, (31, 17));
      expect((warped.cols, warped.rows, resized.cols, resized.rows), (61, 41, 31, 17));
      warped.dispose();
      resized.dispose();
    }
  });

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
