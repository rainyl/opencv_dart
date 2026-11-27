// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// A smoke test for the demo: the shell builds, and every tab renders without throwing. The heavy
// work behind the buttons needs a real device, so this only guards the widget tree.
import 'package:flutter/widgets.dart' show RawImage, Size, SizedBox;
import 'package:flutter_test/flutter_test.dart';
import 'package:opencv_dart_example/main.dart';
import 'package:opencv_dart_example/src/core/lab_controller.dart';

void main() {
  test('the heartbeat keeps updating the chart data without rebuilding widgets', () async {
    final controller = LabController();
    var pulses = 0;
    controller.framePulse.addListener(() => pulses++);
    final before = List<double>.of(controller.frameGapsLive);
    controller.startHeartbeat();
    await Future<void>.delayed(const Duration(milliseconds: 400));
    controller.stopHeartbeat();
    final after = List<double>.of(controller.frameGapsLive);
    controller.dispose();

    // The chart is driven by its repaint source, so a stale copy or a missing pulse keeps the demo
    // frozen; both have happened once, hence the assertions.
    expect(pulses, greaterThan(3), reason: 'framePulse did not tick');
    expect(after, isNot(before), reason: 'the ring buffer the painter reads did not change');
  });

  testWidgets('the shell builds and every tab renders', (tester) async {
    // A desktop-sized window, so the navigation-rail layout is the one under test.
    tester.view.physicalSize = const Size(1500, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const LabApp());
    await tester.pump(const Duration(milliseconds: 60));

    expect(tester.takeException(), isNull);
    expect(find.byType(LabShell), findsOneWidget);
    expect(find.text('Images'), findsWidgets);

    for (final tab in ['Video', 'Sync/Async', 'Errors', 'Images']) {
      await tester.tap(find.text(tab).first);
      await tester.pump(const Duration(milliseconds: 220));
      expect(tester.takeException(), isNull, reason: 'tab $tab threw while building');
    }

    // Unmounting has to stop the UI heartbeat timer the shell started.
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('leaving the images tab does not dispose the shared preview twice', (tester) async {
    tester.view.physicalSize = const Size(1500, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const LabApp());
    // Let the real decode finish (`imdecodeAsync` + `matToImage`): the page only owns two images
    // once it has loaded, and until the first filter run both fields point at the same one.
    for (var i = 0; i < 40 && find.byType(RawImage).evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    expect(tester.takeException(), isNull, reason: 'loading the sample image failed');
    expect(
      find.byType(RawImage),
      findsWidgets,
      reason: 'the sample image did not load, so this test would not reach the dispose path',
    );

    // Unmounting the page runs its dispose(), which is where the double release used to assert.
    await tester.tap(find.text('Video').first);
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull, reason: 'Image.dispose was called twice');

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('leaving a tab mid-decode does not touch the dead page', (tester) async {
    tester.view.physicalSize = const Size(1500, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const LabApp());
    // No wait: the sample image is still decoding when the page goes away.
    await tester.tap(find.text('Video').first);
    await tester.pump(const Duration(milliseconds: 60));
    for (var i = 0; i < 30; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    expect(
      tester.takeException(),
      isNull,
      reason: 'a decode that completed after the page was gone touched a disposed page or controller',
    );

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('the phone layout renders every tab too', (tester) async {
    tester.view.physicalSize = const Size(420, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const LabApp());
    await tester.pump(const Duration(milliseconds: 60));
    expect(tester.takeException(), isNull);

    for (final tab in ['Video', 'Sync/Async', 'Errors', 'Images']) {
      await tester.tap(find.text(tab).first);
      await tester.pump(const Duration(milliseconds: 220));
      expect(tester.takeException(), isNull, reason: 'tab $tab failed to lay out at 420 px');
    }

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}
