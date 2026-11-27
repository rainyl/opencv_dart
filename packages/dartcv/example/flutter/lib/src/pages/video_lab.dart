// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:dartcv4/dartcv.dart' as cv;

import '../core/imaging.dart';
import '../core/lab_controller.dart';
import '../core/temp_dir.dart';
import '../theme.dart';
import '../widgets/primitives.dart';

/// One generated clip: the frames live in memory, the optional video file is what `videoio` gave back.
class _Clip {
  _Clip({required this.frames, required this.width, required this.height, required this.fps});

  final List<Uint8List> frames;
  final int width;
  final int height;
  final int fps;
  String? videoNote;
}

/// Video processing: generate a clip with `VideoWriter` drawing calls, read it back with
/// `VideoCapture`, then stream frames through a filter while measuring what the UI has left.
class VideoLabPage extends StatefulWidget {
  const VideoLabPage({super.key, required this.controller});

  final LabController controller;

  @override
  State<VideoLabPage> createState() => _VideoLabPageState();
}

class _VideoLabPageState extends State<VideoLabPage> {
  static const _frameW = 480;
  static const _frameH = 270;
  static const _fps = 24;

  _Clip? _clip;
  ui.Image? _image;
  Timer? _playback;
  bool _playing = false;
  bool _generating = false;
  bool _async = true;
  LabFilter? _filter = LabFilter.edges;
  int _index = 0;
  double _perFrameMs = 0;
  double _measuredFps = 0;

  @override
  void dispose() {
    _playback?.cancel();
    _image?.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------- clip generation

  /// Draws one frame with the same primitives an app would use, then PNG-encodes it.
  Uint8List _renderFrame(int i, int total) {
    final bg = cv.Mat.fromScalar(_frameH, _frameW, cv.MatType.CV_8UC3, cv.Scalar.all(16));
    final t = i / total;
    final ink = cv.Scalar(240, 240, 240, 0);
    final accent = cv.Scalar(255, 170, 90, 0);
    final points = <cv.Point>[];
    final scalars = <cv.Scalar>[ink, accent];
    try {
      // A moving grid: the background band travels left to right.
      final bandX = (t * _frameW).round();
      final p1 = cv.Point(bandX, 0), p2 = cv.Point(bandX, _frameH);
      points.addAll([p1, p2]);
      cv.line(bg, p1, p2, accent, thickness: 2, lineType: cv.LINE_AA);

      // An orbiting circle, drawn with a second circle as its glow.
      final cx = (_frameW / 2 + math.cos(t * 2 * math.pi) * 120).round();
      final cy = (_frameH / 2 + math.sin(t * 2 * math.pi) * 70).round();
      final glowP = cv.Point(cx, cy), coreP = cv.Point(cx, cy);
      points.addAll([glowP, coreP]);
      cv.circle(bg, glowP, 26, cv.Scalar(60, 40, 30, 0), thickness: 8, lineType: cv.LINE_AA);
      cv.circle(bg, coreP, 16, ink, thickness: -1, lineType: cv.LINE_AA);

      // A sweeping arc made of segments, so the frame is not just two shapes.
      for (var s = 0; s < 24; s++) {
        final a0 = (t * 2 * math.pi) + s * 0.13;
        final r = 60 + s * 2.0;
        final a = cv.Point(
          (_frameW / 2 + math.cos(a0) * r).round(),
          (_frameH / 2 + math.sin(a0) * r).round(),
        );
        final b = cv.Point(
          (_frameW / 2 + math.cos(a0 + 0.12) * r).round(),
          (_frameH / 2 + math.sin(a0 + 0.12) * r).round(),
        );
        points.addAll([a, b]);
        cv.line(bg, a, b, cv.Scalar(70, 120, 200, 0), thickness: 1, lineType: cv.LINE_AA);
      }

      // Frame counter and title.
      final label = cv.Point(16, 30), sub = cv.Point(16, _frameH - 16);
      points.addAll([label, sub]);
      cv.putText(
        bg,
        'frame ${i.toString().padLeft(2, '0')} / $total',
        label,
        cv.FONT_HERSHEY_SIMPLEX,
        0.6,
        ink,
      );
      cv.putText(
        bg,
        'dartcv4 · generated with cv.line / cv.circle / cv.putText',
        sub,
        cv.FONT_HERSHEY_SIMPLEX,
        0.42,
        cv.Scalar(170, 170, 170, 0),
      );

      final png = matToPng(bg);
      return png;
    } finally {
      bg.dispose();
      for (final p in points) {
        p.dispose();
      }
      for (final s in scalars) {
        s.dispose();
      }
    }
  }

  Future<void> _generate() async {
    setState(() {
      _generating = true;
      _playing = false;
    });
    _playback?.cancel();
    final controller = widget.controller;
    final watch = Stopwatch()..start();
    try {
      const total = 48;
      final frames = <Uint8List>[];
      for (var i = 0; i < total; i++) {
        frames.add(_renderFrame(i, total));
        if (i % 8 == 0) await Future<void>.delayed(Duration.zero); // let the UI paint
      }
      final clip = _Clip(frames: frames, width: _frameW, height: _frameH, fps: _fps);
      controller.log(
        'rendered ${frames.length} frames ($_frameW×$_frameH, $_fps fps) '
        'in ${(watch.elapsedMicroseconds / 1000).toStringAsFixed(0)} ms',
        level: LogLevel.ok,
      );
      // A real round-trip through videoio, when the build has a backend for it.
      clip.videoNote = await _videoRoundTrip(frames, controller);
      if (!mounted) return;
      setState(() => _clip = clip);
      await _showFrame(0, clip);
    } catch (e) {
      controller.log('clip generation failed: $e', level: LogLevel.error);
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  /// Writes the frames with `VideoWriter` and reads them back with `VideoCapture`.
  ///
  /// Fails quietly on a build without a video backend (no FFmpeg in the wasm module, or a desktop
  /// build configured without it): the clip still plays from memory, which is the graceful default
  /// this demo wants to show.
  Future<String?> _videoRoundTrip(List<Uint8List> frames, LabController controller) async {
    if (kIsWeb) return 'web build: video I/O backend not compiled in, frames stay in memory';
    final path = temporaryVideoPath('dartcv_demo.mp4');
    try {
      final writer = cv.VideoWriter.fromFile(path, 'mp4v', _fps.toDouble(), (_frameW, _frameH));
      if (!writer.isOpened) {
        writer.dispose();
        return 'no VideoWriter backend for $path; frames stay in memory';
      }
      for (final png in frames) {
        final mat = await cv.imdecodeAsync(png, cv.IMREAD_COLOR);
        writer.write(mat);
        mat.dispose();
      }
      writer.release();
      writer.dispose();

      final capture = cv.VideoCapture.fromFile(path);
      if (!capture.isOpened) {
        capture.dispose();
        return 'wrote $path, but VideoCapture cannot open it (no decoder in this build)';
      }
      var read = 0;
      while (true) {
        final (ok, frame) = capture.read();
        if (!ok) break;
        read++;
        frame.dispose();
      }
      capture.release();
      capture.dispose();
      controller.log('videoio round-trip: wrote ${frames.length} frames, decoded $read', level: LogLevel.ok);
      return 'round-trip ok: wrote ${frames.length} frames, decoded $read back';
    } catch (e) {
      controller.log('videoio round-trip failed: $e', level: LogLevel.warn);
      return 'videoio round-trip unavailable: $e';
    }
  }

  // ---------------------------------------------------------------- playback

  Future<void> _showFrame(int index, _Clip clip) async {
    final controller = widget.controller;
    final watch = Stopwatch()..start();
    cv.Mat? mat;
    try {
      mat = _async
          ? await cv.imdecodeAsync(clip.frames[index], cv.IMREAD_COLOR)
          : cv.imdecode(clip.frames[index], cv.IMREAD_COLOR);
      var filtered = mat;
      final filter = _filter;
      if (filter != null) {
        filtered = _async
            ? await applyFilterAsync(mat, filter, amount: 0.5)
            : applyFilterSync(mat, filter, amount: 0.5);
        if (!identical(filtered, mat)) mat.dispose();
      }
      final image = await matToImage(filtered);
      filtered.dispose();
      if (!mounted) {
        image.dispose();
        return;
      }
      setState(() {
        _image?.dispose();
        _image = image;
        _index = index;
        _perFrameMs = watch.elapsedMicroseconds / 1000;
      });
    } on cv.AsyncTimeoutException catch (e) {
      controller.log('frame $index timed out, waiting for completion', level: LogLevel.warn);
      await e.completion;
    } catch (e) {
      controller.log('frame $index failed: $e', level: LogLevel.error);
      mat?.dispose();
    }
  }

  void _togglePlay() {
    final clip = _clip;
    if (clip == null) return;
    if (_playing) {
      _playback?.cancel();
      setState(() => _playing = false);
      widget.controller.log('playback paused at frame $_index', level: LogLevel.info);
      return;
    }
    var busy = false;
    var lastTick = DateTime.now();
    setState(() => _playing = true);
    _playback = Timer.periodic(const Duration(milliseconds: 1000 ~/ _fps), (_) async {
      if (busy) return;
      busy = true;
      final now = DateTime.now();
      final delta = now.difference(lastTick).inMicroseconds / 1e6;
      lastTick = now;
      if (delta > 0) {
        final fps = 1 / delta;
        _measuredFps = _measuredFps == 0 ? fps : _measuredFps * 0.8 + fps * 0.2;
      }
      final next = (_index + 1) % clip.frames.length;
      await _showFrame(next, clip);
      busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final clip = _clip;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Video lab',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'A clip drawn frame by frame with OpenCV primitives, encoded with VideoWriter, then played '
            'back through VideoCapture with a filter per frame. Toggle async to keep the UI thread free '
            'while frames are processed.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.6), height: 1.45),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 980;
              final player = GlassCard(
                title: 'Player',
                subtitle: clip == null
                    ? 'Generate a clip to start'
                    : 'frame ${_index + 1} / ${clip.frames.length}',
                icon: Icons.movie_filter_rounded,
                accent: Theme.of(context).colorScheme.primary,
                trailing: Pill(
                  _async ? 'async frames' : 'sync frames',
                  tone: _async ? PillTone.good : PillTone.warn,
                  icon: _async ? Icons.memory_rounded : Icons.block_rounded,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AspectRatio(
                        aspectRatio: _frameW / _frameH,
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.45),
                          child: _image == null
                              ? Center(
                                  child: _generating
                                      ? const CircularProgressIndicator(strokeWidth: 2)
                                      : Text(
                                          'no clip yet',
                                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                                        ),
                                )
                              : AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 120),
                                  child: RawImage(key: ValueKey(_image), image: _image, fit: BoxFit.contain),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        FilledButton.icon(
                          onPressed: clip == null ? null : _togglePlay,
                          icon: Icon(_playing ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 18),
                          label: Text(_playing ? 'Pause' : 'Play'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _generating ? null : _generate,
                          icon: const Icon(Icons.auto_awesome_motion_rounded, size: 18),
                          label: Text(clip == null ? 'Generate clip' : 'Regenerate'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 14),
                    MetricStrip([
                      Metric(
                        'per frame',
                        _perFrameMs.toStringAsFixed(1),
                        unit: 'ms',
                        tone: _async ? LabPalette.async : LabPalette.sync,
                      ),
                      Metric('playback', _measuredFps.toStringAsFixed(0), unit: 'fps', tone: LabPalette.info),
                      Metric('frames', '${clip?.frames.length ?? 0}'),
                      Metric('live objects', '${controller.liveObjects}'),
                    ]),
                    if (clip?.videoNote != null) ...[
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, size: 15, color: LabPalette.info),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              clip!.videoNote!,
                              style: TextStyle(fontSize: 11.5, color: Colors.white.withValues(alpha: 0.55)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
              final controls = GlassCard(
                title: 'Processing',
                subtitle: 'Per-frame work and the heartbeat it leaves behind.',
                icon: Icons.tune_rounded,
                accent: _async ? LabPalette.async : LabPalette.sync,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedChoice<bool>(
                      accent: _async ? LabPalette.async : LabPalette.sync,
                      options: const {false: 'Sync', true: 'Async'},
                      selected: _async,
                      onChanged: (v) {
                        setState(() => _async = v);
                        controller.log('frame processing switched to ${v ? 'worker thread' : 'UI isolate'}');
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'filter per frame',
                      style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.72)),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('none'),
                          selected: _filter == null,
                          onSelected: (_) => setState(() => _filter = null),
                        ),
                        for (final f in [
                          LabFilter.edges,
                          LabFilter.grayscale,
                          LabFilter.blur,
                          LabFilter.invert,
                        ])
                          ChoiceChip(
                            label: Text(f.label),
                            selected: _filter == f,
                            onSelected: (_) => setState(() => _filter = f),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    HeartbeatBars(gaps: () => controller.frameGapsLive, repaint: controller.framePulse),
                    const SizedBox(height: 10),
                    Text(
                      'Processing a frame on the UI isolate stalls this chart; on the worker thread it '
                      'stays flat while the fps meter dips instead.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.45,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              );
              if (!wide) {
                return Column(children: [player, const SizedBox(height: 16), controls]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: player),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: controls),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
