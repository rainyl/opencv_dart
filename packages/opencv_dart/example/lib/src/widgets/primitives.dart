// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// A frosted card: the container every section of the lab sits in.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.icon,
    this.accent = LabPalette.info,
    this.trailing,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Color accent;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.045),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: LabPalette.outline),
          ),
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Row(
                  children: [
                    if (icon != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(icon, size: 17, color: accent),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title!,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          if (subtitle != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                subtitle!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.55),
                                  height: 1.35,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
                const SizedBox(height: 18),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// A small label/value pair, used for every measurement the lab reports.
class Metric extends StatelessWidget {
  const Metric(this.label, this.value, {super.key, this.unit, this.tone = LabPalette.info});

  final String label;
  final String value;
  final String? unit;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.45),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: tone,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            if (unit != null)
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  unit!,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: tone.withValues(alpha: 0.75),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// [Metric]s in a wrapping row.
class MetricStrip extends StatelessWidget {
  const MetricStrip(this.metrics, {super.key});

  final List<Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 26, runSpacing: 14, children: metrics);
  }
}

enum PillTone { info, good, warn, bad }

class Pill extends StatelessWidget {
  const Pill(this.text, {super.key, this.tone = PillTone.info, this.icon});

  final String text;
  final PillTone tone;
  final IconData? icon;

  Color get _color => switch (tone) {
    PillTone.info => LabPalette.info,
    PillTone.good => LabPalette.async,
    PillTone.warn => LabPalette.sync,
    PillTone.bad => LabPalette.error,
  };

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 13, color: color), const SizedBox(width: 5)],
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// A two-to-four-way switch with an animated indicator.
class SegmentedChoice<T> extends StatelessWidget {
  const SegmentedChoice({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.accent = LabPalette.info,
  });

  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: LabPalette.outline),
      ),
      // A Wrap, not a Row: with two long labels the control has to be able to run out of width on a
      // phone without painting an overflow stripe.
      child: Wrap(
        children: [
          for (final entry in options.entries)
            GestureDetector(
              onTap: () => onChanged(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: entry.key == selected ? accent.withValues(alpha: 0.20) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: entry.key == selected ? accent.withValues(alpha: 0.55) : Colors.transparent,
                  ),
                ),
                child: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: entry.key == selected ? accent : Colors.white.withValues(alpha: 0.62),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A labelled slider with the current value on the right.
class LabSlider extends StatelessWidget {
  const LabSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
    this.format,
    this.enabled = true,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;
  final String Function(double)? format;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.72)),
              ),
            ),
            Text(
              (format ?? (v) => v.toStringAsFixed(1))(value),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: enabled ? Theme.of(context).colorScheme.primary : Colors.white38,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 26,
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ],
    );
  }
}

/// The tick histogram that makes a blocked event loop visible.
class HeartbeatBars extends StatelessWidget {
  const HeartbeatBars({
    super.key,
    required this.gaps,
    this.repaint,
    this.height = 46,
  });

  /// Milliseconds between consecutive UI ticks; read on every paint, so it must be the live buffer.
  final List<double> Function() gaps;

  /// Repaints the chart without rebuilding it (see `LabController.framePulse`).
  final Listenable? repaint;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _HeartbeatPainter(gaps, repaint)),
    );
  }
}

class _HeartbeatPainter extends CustomPainter {
  _HeartbeatPainter(this.gaps, Listenable? repaint) : super(repaint: repaint);

  final List<double> Function() gaps;

  @override
  void paint(Canvas canvas, Size size) {
    final values = gaps();
    if (values.isEmpty) return;
    final peak = math.max(16.0, values.reduce(math.max));
    final slot = size.width / math.max(values.length, 1);
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < values.length; i++) {
      final normalized = (values[i] / peak).clamp(0.0, 1.0);
      final barHeight = math.max(2.0, normalized * size.height);
      // Green while the UI keeps up with a 16 ms frame, amber/red once it stalls.
      paint.color = values[i] < 24
          ? LabPalette.async.withValues(alpha: 0.75)
          : values[i] < 60
          ? LabPalette.sync.withValues(alpha: 0.85)
          : LabPalette.error;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(i * slot + slot * 0.18, size.height - barHeight, slot * 0.64, barHeight),
        const Radius.circular(2),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(_HeartbeatPainter oldDelegate) => oldDelegate.gaps != gaps;
}
