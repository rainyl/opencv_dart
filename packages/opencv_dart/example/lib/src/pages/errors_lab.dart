// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'package:material_ui/material_ui.dart';
import 'package:opencv_dart/opencv.dart' as cv;

import '../core/lab_controller.dart';
import '../theme.dart';
import '../widgets/primitives.dart';

/// What a failure looks like, for each way the library can fail.
///
/// The point of this page is that none of these cases crashes the app and every one of them says
/// which object, which call, and what the caller can do next.
class ErrorsLabPage extends StatefulWidget {
  const ErrorsLabPage({super.key, required this.controller});

  final LabController controller;

  @override
  State<ErrorsLabPage> createState() => _ErrorsLabPageState();
}

class _ErrorsLabPageState extends State<ErrorsLabPage> {
  _Finding? _finding;
  bool _running = false;

  Future<void> _report(String title, Future<_Finding> Function() body) async {
    setState(() => _running = true);
    try {
      final finding = await body();
      if (!mounted) return;
      setState(() => _finding = finding);
      widget.controller.log(
        '$title → ${finding.headline}',
        level: switch (finding.tone) {
          PillTone.good => LogLevel.ok,
          PillTone.warn => LogLevel.warn,
          PillTone.bad => LogLevel.error,
          PillTone.info => LogLevel.info,
        },
      );
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }

  /// 1. An OpenCV error that happens *inside the worker job*: the entry point has already returned,
  ///    so it can only arrive as a failed Future.
  Future<_Finding> _opencvErrorInJob() async {
    final src = cv.Mat.zeros(256, 256, cv.MatType.CV_8UC3);
    try {
      await cv.gaussianBlurAsync(src, (4, 4), 0);
      return const _Finding(
        headline: 'no error?',
        detail: 'an even kernel should have been rejected',
        tone: PillTone.warn,
        code: 'none',
      );
    } on cv.CvException catch (e) {
      return _Finding(
        headline: 'CvException caught from an awaited Future',
        detail:
            'The call returned a Future immediately; the failure arrived here:\n'
            'code ${e.code} · func ${e.func}\n${e.msg}\n${e.file}:${e.line}',
        tone: PillTone.bad,
        code: e.code.toString(),
      );
    } finally {
      src.dispose();
    }
  }

  /// 2. A timeout: the wait is abandoned, the work is not. `completion` is the moment the output the
  ///    caller passed stops changing.
  Future<_Finding> _timeout() async {
    final src = cv.Mat.fromScalar(1400, 1400, cv.MatType.CV_8UC3, cv.Scalar.all(255));
    final dst = cv.Mat.zeros(1400, 1400, cv.MatType.CV_8UC3);
    try {
      await cv.gaussianBlurAsync(
        src,
        (61, 61),
        0,
        dst: dst,
        timeout: const Duration(microseconds: 1),
      );
      return const _Finding(
        headline: 'no timeout?',
        detail: 'expected AsyncTimeoutException',
        tone: PillTone.warn,
        code: '-',
      );
    } on cv.AsyncTimeoutException catch (e) {
      // Touch it too early: the library refuses a synchronous read of an object a job is writing.
      String early;
      try {
        cv.mean(dst);
        early = 'read allowed (unexpected)';
      } on cv.CvException catch (race) {
        early = 'refused early: ${race.msg.split(';').first}';
      }
      await e.completion; // the documented way to learn when the write landed
      final mean = cv.mean(dst).val1;
      return _Finding(
        headline: 'AsyncTimeoutException after ${e.elapsed.inMicroseconds} µs',
        detail:
            '${e.message}\n\n$early\n'
            'After e.completion the destination reads ${mean.toStringAsFixed(1)} '
            '(the abandoned job did write it) - which is why the exception hands back a completion.',
        tone: PillTone.warn,
        code: 'timeout',
      );
    } finally {
      src.dispose();
      dst.dispose();
    }
  }

  /// 3. Racing a synchronous call against a job on the same object is refused instead of corrupting.
  Future<_Finding> _race() async {
    final src = cv.Mat.fromScalar(600, 600, cv.MatType.CV_8UC3, cv.Scalar.all(200));
    final dst = cv.Mat.empty();
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst);
    try {
      cv.cvtColor(dst, cv.COLOR_BGR2GRAY);
      await pending;
      return const _Finding(
        headline: 'race allowed?',
        detail: 'the synchronous call on an in-flight object should have been refused',
        tone: PillTone.warn,
        code: '-',
      );
    } on cv.CvException catch (e) {
      await pending; // the async call itself is unaffected
      return _Finding(
        headline: 'race refused, both calls unharmed',
        detail:
            'The synchronous call threw instead of touching the object:\n${e.msg}\n\n'
            'The awaited job completed normally afterwards.',
        tone: PillTone.info,
        code: e.code.toString(),
      );
    } finally {
      src.dispose();
      dst.dispose();
    }
  }

  /// 4. A missing file is not an exception: imread returns an empty Mat, and the caller decides.
  Future<_Finding> _missingFile() async {
    final mat = cv.imread('this/file/does/not/exist.png');
    try {
      if (mat.isEmpty) {
        return const _Finding(
          headline: 'empty Mat, no exception',
          detail:
              'cv.imread returns an empty matrix for an unreadable path. Check isEmpty and treat '
              'it as "no image" - which is what cv.imdecodeAsync also does with bad bytes.',
          tone: PillTone.info,
          code: 'isEmpty',
        );
      }
      return const _Finding(
        headline: 'unexpected data',
        detail: 'the file should not exist',
        tone: PillTone.warn,
        code: '-',
      );
    } finally {
      mat.dispose();
    }
  }

  /// 5. Bad arguments reach OpenCV and come back as a CvException with the C++ context.
  Future<_Finding> _badArgument() async {
    final src = cv.Mat.zeros(64, 64, cv.MatType.CV_8UC3);
    try {
      cv.resize(src, (0, 0)); // dsize and fx/fy both zero: OpenCV rejects it
      return const _Finding(
        headline: 'no error?',
        detail: 'resize to 0×0 should fail',
        tone: PillTone.warn,
        code: '-',
      );
    } on cv.CvException catch (e) {
      return _Finding(
        headline: 'CvException from a synchronous call',
        detail:
            'Thrown before the call returns, so it is catchable inline:\n'
            'code ${e.code} · ${e.func}\n${e.msg}',
        tone: PillTone.bad,
        code: e.code.toString(),
      );
    } finally {
      src.dispose();
    }
  }

  /// 6. Disposal is observable: the number of live wrapped objects says whether the handles were
  ///    released, which is what the async work relies on.
  Future<_Finding> _leakCheck() async {
    final before = cv.liveObjectCount();
    for (var i = 0; i < 200; i++) {
      final mat = cv.Mat.zeros(32, 32, cv.MatType.CV_8UC1);
      final blurred = cv.gaussianBlur(mat, (3, 3), 0);
      blurred.dispose();
      mat.dispose();
    }
    cv.asyncDrain();
    final after = cv.liveObjectCount();
    return _Finding(
      headline: '400 handles created, disposed, ${after - before} left',
      detail:
          'cv.liveObjectCount() before: $before, after: $after.\n'
          'The async work holds a reference per argument, so a job in flight would show up here until '
          'it completes - `asyncDrain()` is the way to wait for that.',
      tone: after - before <= 2 ? PillTone.good : PillTone.warn,
      code: '${after - before}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final finding = _finding;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Errors & exceptions',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Six ways to fail, and what each one looks like from Dart. Nothing here throws into the '
            'void: a synchronous failure is catchable inline, an asynchronous one arrives on the Future, '
            'and a timeout tells you when the abandoned work stopped writing.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.6), height: 1.45),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 980;
              final buttons = GlassCard(
                title: 'Trigger a failure',
                subtitle: 'Each button runs one case and reports what Dart saw.',
                icon: Icons.science_rounded,
                accent: LabPalette.error,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _Trigger(
                      label: 'Error inside a job',
                      icon: Icons.cloud_off_rounded,
                      onTap: _running ? null : () => _report('error in job', _opencvErrorInJob),
                    ),
                    _Trigger(
                      label: 'Timeout + completion',
                      icon: Icons.timer_off_rounded,
                      onTap: _running ? null : () => _report('timeout', _timeout),
                    ),
                    _Trigger(
                      label: 'Race a sync call',
                      icon: Icons.warning_amber_rounded,
                      onTap: _running ? null : () => _report('race', _race),
                    ),
                    _Trigger(
                      label: 'Missing file',
                      icon: Icons.description_outlined,
                      onTap: _running ? null : () => _report('missing file', _missingFile),
                    ),
                    _Trigger(
                      label: 'Bad argument',
                      icon: Icons.rule_rounded,
                      onTap: _running ? null : () => _report('bad argument', _badArgument),
                    ),
                    _Trigger(
                      label: 'Disposal / leak check',
                      icon: Icons.cleaning_services_rounded,
                      onTap: _running ? null : () => _report('leak check', _leakCheck),
                    ),
                    if (_running)
                      const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2)),
                  ],
                ),
              );
              final report = GlassCard(
                title: 'What Dart saw',
                subtitle: finding?.headline ?? 'run a case to fill this in',
                icon: Icons.report_rounded,
                accent: switch (finding?.tone) {
                  PillTone.good => LabPalette.async,
                  PillTone.warn => LabPalette.sync,
                  PillTone.bad => LabPalette.error,
                  _ => LabPalette.info,
                },
                child: finding == null
                    ? Text(
                        'No case has run yet.',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Pill(finding.headline, tone: finding.tone, icon: Icons.bolt_rounded),
                              Pill('code ${finding.code}', tone: PillTone.info),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SelectableText(
                            finding.detail,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.5,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
              );
              if (!wide) {
                return Column(children: [buttons, const SizedBox(height: 16), report]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: buttons),
                  const SizedBox(width: 16),
                  Expanded(flex: 3, child: report),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Finding {
  const _Finding({
    required this.headline,
    required this.detail,
    required this.tone,
    required this.code,
  });

  final String headline;
  final String detail;
  final PillTone tone;
  final String code;
}

class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
