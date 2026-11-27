// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:opencv_dart/opencv.dart' as cv;

import '../core/imaging.dart';
import '../core/lab_controller.dart';
import '../theme.dart';
import '../widgets/primitives.dart';

/// Image processing: one pipeline, two ways to run it, and a heartbeat that shows the difference.
class ImageLabPage extends StatefulWidget {
  const ImageLabPage({super.key, required this.controller});

  final LabController controller;

  @override
  State<ImageLabPage> createState() => _ImageLabPageState();
}

class _ImageLabPageState extends State<ImageLabPage> {
  final _picker = ImagePicker();

  cv.Mat? _original;
  ui.Image? _originalImage;
  ui.Image? _filteredImage;
  LabFilter _filter = LabFilter.blur;
  double _amount = 0.35;
  bool _async = true;
  bool _busy = false;
  String _sourceName = 'images/lenna.png';
  Measure? _last;
  int _liveDelta = 0;

  @override
  void initState() {
    super.initState();
    _loadAsset();
  }

  @override
  void dispose() {
    _original?.dispose();
    _releaseImages();
    super.dispose();
  }

  /// Releases the previews the page owns, each exactly once.
  ///
  /// `_filteredImage` starts out as the *same* `ui.Image` as `_originalImage` (there is nothing to
  /// filter yet), so disposing both fields trips `Image.dispose`'s `assert(!_disposed)`.
  void _releaseImages() {
    final original = _originalImage;
    final filtered = _filteredImage;
    _originalImage = null;
    _filteredImage = null;
    original?.dispose();
    if (!identical(filtered, original)) filtered?.dispose();
  }

  Future<void> _loadAsset() async {
    final data = await rootBundle.load('images/lenna.png');
    await _adopt(data.buffer.asUint8List(), 'images/lenna.png');
  }

  Future<void> _pick() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    await _adopt(await file.readAsBytes(), file.name);
  }

  /// Decodes [bytes] and resets the comparison, so the lab always starts from the untouched image.
  Future<void> _adopt(Uint8List bytes, String name) async {
    setState(() => _busy = true);
    try {
      // Decoding runs on the worker thread too: it is the slowest single call in the demo.
      final before = widget.controller.liveObjects;
      final mat = await cv.imdecodeAsync(bytes, cv.IMREAD_COLOR);
      final image = await matToImage(mat);
      if (!mounted) {
        // The tab was left while the decode ran: keep the images with their owner.
        mat.dispose();
        image.dispose();
        return;
      }
      _original?.dispose();
      _releaseImages();
      setState(() {
        _original = mat;
        _originalImage = image;
        _filteredImage = image;
        _sourceName = name;
        _liveDelta = widget.controller.liveObjects - before;
        _last = null;
      });
      widget.controller.log(
        'imdecodeAsync ${mat.cols}×${mat.rows} (${mat.channels}ch) from $name',
        level: LogLevel.ok,
      );
    } catch (e, s) {
      widget.controller.log('decode failed: $e\n$s', level: LogLevel.error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _run() async {
    final src = _original;
    if (src == null || _busy) return;
    setState(() {
      _busy = true;
      _liveDelta = 0;
    });

    final filter = _filter;
    final amount = _amount;
    final useAsync = _async;
    final controller = widget.controller;
    final liveBefore = controller.liveObjects;

    try {
      cv.Mat result;
      late Measure measure;
      if (useAsync) {
        final watch = Stopwatch()..start();
        final future = applyFilterAsync(src, filter, amount: amount);
        final blocked = watch.elapsed; // only the hand-off, not the work
        result = await future;
        measure = Measure(watch.elapsed, blocked, 0);
      } else {
        final watch = Stopwatch()..start();
        result = applyFilterSync(src, filter, amount: amount);
        measure = Measure(watch.elapsed, watch.elapsed, 0);
      }

      final image = await matToImage(result);
      result.dispose(); // the ui.Image copied the pixels; the Mat is not needed any more
      if (!mounted) {
        image.dispose();
        return;
      }
      final previous = _filteredImage;
      setState(() {
        _filteredImage = image;
        _last = measure;
        _liveDelta = controller.liveObjects - liveBefore;
      });
      // The old preview may be the untouched original (before the first run), which is still shown.
      if (previous != null && !identical(previous, _originalImage)) previous.dispose();
      controller.log(
        '${filter.label}${useAsync ? 'Async' : ''} '
        '(${filter.api}) → ${measure.wallMs} ms on the '
        '${useAsync ? 'worker thread, ${measure.blockedMs} ms blocked' : 'UI isolate, fully blocked'}',
        level: useAsync ? LogLevel.ok : LogLevel.warn,
      );
    } catch (e) {
      controller.log('${filter.label} failed: ${_describe(e)}', level: LogLevel.error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _describe(Object e) => switch (e) {
    cv.CvException(:final msg, :final func, :final code) => 'CvException($code) in $func: $msg',
    cv.AsyncTimeoutException(:final elapsed) => 'AsyncTimeoutException after $elapsed',
    _ => e.toString(),
  };

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 980;
              final compare = GlassCard(
                title: 'Before / after',
                subtitle: _sourceName,
                icon: Icons.compare_rounded,
                accent: Theme.of(context).colorScheme.primary,
                trailing: _busy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
                child: _compare(),
              );
              final controls = Column(
                children: [
                  GlassCard(
                    title: 'Pipeline',
                    subtitle: 'Every filter is one OpenCV call, run on the thread you pick.',
                    icon: Icons.tune_rounded,
                    accent: _async ? LabPalette.async : LabPalette.sync,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final f in LabFilter.values)
                              ChoiceChip(
                                label: Text(f.label),
                                selected: _filter == f,
                                onSelected: _busy ? null : (_) => setState(() => _filter = f),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LabSlider(
                          label: 'Strength',
                          value: _amount,
                          min: 0.05,
                          max: 1,
                          onChanged: (v) => setState(() => _amount = v),
                          format: (v) => '${(v * 100).round()}%',
                          enabled: !_busy,
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          children: [
                            SegmentedChoice<bool>(
                              accent: _async ? LabPalette.async : LabPalette.sync,
                              options: const {false: 'Sync · UI', true: 'Async · worker'},
                              selected: _async,
                              onChanged: (v) => setState(() => _async = v),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            FilledButton.icon(
                              onPressed: _busy ? null : _run,
                              icon: const Icon(Icons.play_arrow_rounded, size: 18),
                              label: const Text('Run pipeline'),
                            ),
                            OutlinedButton.icon(
                              onPressed: _busy ? null : _pick,
                              icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
                              label: const Text('Pick image'),
                            ),
                          ],
                        ),
                        if (_last != null) ...[
                          const SizedBox(height: 18),
                          const Divider(),
                          const SizedBox(height: 14),
                          MetricStrip([
                            Metric(
                              'total',
                              _last!.wallMs,
                              unit: 'ms',
                              tone: _async ? LabPalette.async : LabPalette.sync,
                            ),
                            Metric(
                              'caller blocked',
                              _last!.blockedMs,
                              unit: 'ms',
                              tone: _async ? LabPalette.async : LabPalette.sync,
                            ),
                            Metric(
                              'pipeline',
                              _async ? 'worker' : 'UI isolate',
                              tone: _async ? LabPalette.async : LabPalette.sync,
                            ),
                            Metric('live objects', '${controller.liveObjects}'),
                          ]),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    title: 'UI heartbeat',
                    subtitle:
                        'Milliseconds between UI frames while the pipelines ran. A tall bar is a '
                        'blocked isolate.',
                    icon: Icons.monitor_heart_outlined,
                    accent: LabPalette.async,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeartbeatBars(gaps: () => controller.frameGapsLive, repaint: controller.framePulse),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            const Pill('green < 24 ms', tone: PillTone.good),
                            const Pill('amber < 60 ms', tone: PillTone.warn),
                            const Pill('red = blocked', tone: PillTone.bad),
                            if (_liveDelta != 0)
                              Pill(
                                'handles ${_liveDelta > 0 ? '+' : ''}$_liveDelta',
                                tone: _liveDelta > 0 ? PillTone.warn : PillTone.good,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
              if (!wide) {
                return Column(children: [compare, const SizedBox(height: 16), controls]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: compare),
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

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image lab',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Decode, filter and re-encode a still image. Flip the switch to move the same kernels onto '
          'the worker thread and watch the heartbeat stay flat.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.6), height: 1.45),
        ),
      ],
    );
  }

  Widget _compare() {
    final original = _originalImage;
    final filtered = _filteredImage;
    if (original == null) {
      return const SizedBox(height: 280, child: Center(child: CircularProgressIndicator()));
    }
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            const Pill('original', tone: PillTone.info),
            Pill(_filter.label, tone: _async ? PillTone.good : PillTone.warn),
          ],
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final side = constraints.maxWidth > 620;
            final tiles = [
              _ImageTile('original', original),
              _ImageTile('${_filter.label}${_async ? ' · async' : ' · sync'}', filtered ?? original),
            ];
            if (!side) {
              return Column(
                children: [
                  for (final tile in tiles) ...[tile, const SizedBox(height: 12)],
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: tiles[0]),
                const SizedBox(width: 12),
                Expanded(child: tiles[1]),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.caption, this.image);

  final String caption;
  final ui.Image image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: AspectRatio(
            aspectRatio: image.width / image.height,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              child: RawImage(key: ValueKey(image), image: image, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          style: TextStyle(
            fontSize: 11.5,
            letterSpacing: 0.6,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
