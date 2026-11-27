// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:dartcv4/dartcv.dart' as cv;

import '../core/lab_controller.dart';
import '../theme.dart';
import '../widgets/primitives.dart';

/// Sync vs async, measured on the same kernels: what the worker thread costs, what it buys, and how
/// the pool behaves once there is more than one of them.
class AsyncLabPage extends StatefulWidget {
  const AsyncLabPage({super.key, required this.controller});

  final LabController controller;

  @override
  State<AsyncLabPage> createState() => _AsyncLabPageState();
}

class _AsyncLabPageState extends State<AsyncLabPage> {
  static const _size = 900;

  double _iterations = 8;
  int _workers = 1;
  bool _running = false;

  final Map<String, _Run> _runs = {};

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sync vs async',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'The same $_size×$_size Gaussian blur, run three ways. Values are wall time for the '
            'whole batch; "blocked" is how long the caller thread could not run anything else.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.6), height: 1.45),
          ),
          const SizedBox(height: 18),
          GlassCard(
            title: 'Batch',
            subtitle: 'One worker runs the jobs in order; more workers only help I/O-bound work.',
            icon: Icons.speed_rounded,
            accent: LabPalette.async,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabSlider(
                  label: 'Iterations',
                  value: _iterations,
                  min: 1,
                  max: 40,
                  divisions: 39,
                  onChanged: _running ? (v) {} : (v) => setState(() => _iterations = v),
                  format: (v) => v.round().toString(),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SegmentedChoice<int>(
                      options: const {1: '1 worker', 2: '2', 4: '4 workers'},
                      selected: _workers,
                      onChanged: _running
                          ? (v) {}
                          : (v) {
                              setState(() => _workers = v);
                              controller.setWorkers(v);
                            },
                    ),
                    Pill('pending ${controller.pending}', icon: Icons.hourglass_bottom_rounded),
                    Pill('live ${controller.liveObjects}', icon: Icons.memory_rounded),
                    OutlinedButton(
                      onPressed: _running ? null : controller.drain,
                      child: const Text('asyncDrain()'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: _running ? null : () => _measure('sync', _runSync),
                      icon: const Icon(Icons.block_rounded, size: 18),
                      label: const Text('Run synchronously'),
                    ),
                    FilledButton.icon(
                      onPressed: _running ? null : () => _measure('await', _runAwaitEach),
                      icon: const Icon(Icons.memory_rounded, size: 18),
                      label: const Text('Async, await each'),
                    ),
                    FilledButton.icon(
                      onPressed: _running ? null : () => _measure('pipeline', _runFireThenAwait),
                      icon: const Icon(Icons.bolt_rounded, size: 18),
                      label: const Text('Async, fire then await all'),
                    ),
                  ],
                ),
                if (_running) ...[
                  const SizedBox(height: 16),
                  const LinearProgressIndicator(minHeight: 3),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 980;
              final chart = GlassCard(
                title: 'Results',
                subtitle: 'Last run of each mode, with the caller-blocked time next to it.',
                icon: Icons.bar_chart_rounded,
                accent: LabPalette.info,
                child: _runs.isEmpty
                    ? Text(
                        'Nothing measured yet.',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
                      )
                    : Column(
                        children: [
                          for (final entry in _runs.entries) ...[
                            _RunBar(label: entry.key, run: entry.value),
                            const SizedBox(height: 14),
                          ],
                        ],
                      ),
              );
              final heartbeat = GlassCard(
                title: 'UI heartbeat',
                subtitle: 'Green bars mean the isolate kept drawing frames; a red spike means it did not.',
                icon: Icons.monitor_heart_outlined,
                accent: LabPalette.async,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeartbeatBars(
                      gaps: () => controller.frameGapsLive,
                      repaint: controller.framePulse,
                      height: 64,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Pill('${controller.heartbeatTicks} ticks', icon: Icons.timeline_rounded),
                        Pill('workers ${controller.workers}', icon: Icons.dns_rounded),
                        Pill('pending ${controller.pending}', icon: Icons.hourglass_bottom_rounded),
                      ],
                    ),
                  ],
                ),
              );
              if (!wide) {
                return Column(children: [chart, const SizedBox(height: 16), heartbeat]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: chart),
                  const SizedBox(width: 16),
                  Expanded(flex: 3, child: heartbeat),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- the three modes

  cv.Mat _source() => cv.Mat.fromScalar(_size, _size, cv.MatType.CV_8UC3, cv.Scalar.all(128));

  Future<void> _runSync() async {
    final src = _source();
    final dst = cv.Mat.empty();
    try {
      for (var i = 0; i < _iterations.round(); i++) {
        cv.gaussianBlur(src, (31, 31), 0, dst: dst);
      }
    } finally {
      src.dispose();
      dst.dispose();
    }
  }

  Future<void> _runAwaitEach() async {
    final src = _source();
    final dst = cv.Mat.empty();
    try {
      for (var i = 0; i < _iterations.round(); i++) {
        await cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst);
      }
    } finally {
      src.dispose();
      dst.dispose();
    }
  }

  Future<void> _runFireThenAwait() async {
    final src = _source();
    final dsts = List.generate(_iterations.round(), (_) => cv.Mat.empty());
    try {
      await Future.wait([
        for (final dst in dsts) cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst),
      ]);
    } finally {
      src.dispose();
      for (final dst in dsts) {
        dst.dispose();
      }
    }
  }

  Future<void> _measure(String key, Future<void> Function() body) async {
    setState(() => _running = true);
    final controller = widget.controller;
    final liveBefore = controller.liveObjects;
    // The caller-blocked time is measured around the call itself. For the awaited variants that is
    // the whole batch (each await hands control back to this isolate), so it is measured the same
    // way for all three and stays comparable.
    final watch = Stopwatch()..start();
    try {
      final measure = await controller.measure(body);
      final wall = watch.elapsed;
      final run = _Run(
        wall: wall,
        blocked: measure.wall,
        iterations: _iterations.round(),
        workers: _workers,
        liveDelta: controller.liveObjects - liveBefore,
      );
      setState(() => _runs[key] = run);
      controller.log(
        '$key: ${run.wallMs} ms for ${run.iterations} iterations '
        '(${run.perIterationMs} ms each, ${run.workers} worker${run.workers == 1 ? '' : 's'})',
        level: key == 'sync' ? LogLevel.warn : LogLevel.ok,
      );
    } catch (e) {
      controller.log('$key failed: $e', level: LogLevel.error);
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }
}

class _Run {
  const _Run({
    required this.wall,
    required this.blocked,
    required this.iterations,
    required this.workers,
    required this.liveDelta,
  });

  final Duration wall;
  final Duration blocked;
  final int iterations;
  final int workers;
  final int liveDelta;

  String get wallMs => (wall.inMicroseconds / 1000).toStringAsFixed(0);
  String get perIterationMs => (wall.inMicroseconds / 1000 / math.max(iterations, 1)).toStringAsFixed(1);
}

/// One row of the comparison chart: a bar per mode, scaled against the slowest run so far.
class _RunBar extends StatelessWidget {
  const _RunBar({required this.label, required this.run});

  final String label;
  final _Run run;

  @override
  Widget build(BuildContext context) {
    final tone = switch (label) {
      'sync' => LabPalette.sync,
      'await' => LabPalette.info,
      _ => LabPalette.async,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.85)),
              ),
            ),
            Text(
              '${run.wallMs} ms · ${run.perIterationMs} ms/iter · ${run.workers}w',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: tone),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: run.iterations.toDouble() * 1.0),
            duration: const Duration(milliseconds: 520),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => LinearProgressIndicator(
              value: (value / math.max(run.iterations, 1)).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.06),
              valueColor: AlwaysStoppedAnimation(tone),
            ),
          ),
        ),
      ],
    );
  }
}
