// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

/// One place for the colours the lab uses, so the pages stay consistent.
abstract final class LabPalette {
  /// Accent for "runs on a worker thread" and anything that shows the UI staying free.
  static const async = Color(0xFF64E3C4);

  /// Accent for blocking, synchronous work.
  static const sync = Color(0xFFFFB86B);

  /// Accent for failures.
  static const error = Color(0xFFFF7B8A);

  /// Accent for the neutral/informational chrome.
  static const info = Color(0xFF9BB4FF);

  static const surface = Color(0xFF0D0F16);
  static const surfaceRaised = Color(0xFF151925);
  static const outline = Color(0x1FFFFFFF);
}

ThemeData buildLabTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF7C5CFF),
    brightness: Brightness.dark,
  ).copyWith(primary: const Color(0xFFA88BFF), secondary: LabPalette.async, surface: LabPalette.surface);

  final base = ThemeData(colorScheme: scheme, useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: base.textTheme.apply(bodyColor: Colors.white.withValues(alpha: 0.92)),
    dividerTheme: const DividerThemeData(color: LabPalette.outline, space: 1, thickness: 1),
    sliderTheme: base.sliderTheme.copyWith(
      trackHeight: 4,
      activeTrackColor: scheme.primary,
      inactiveTrackColor: Colors.white.withValues(alpha: 0.12),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.2),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: LabPalette.surfaceRaised,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}

/// The animated backdrop: a deep gradient with two soft light pools behind the content.
class LabBackdrop extends StatelessWidget {
  const LabBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0C12), Color(0xFF10121C), Color(0xFF0B0E15)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            left: -180,
            top: -140,
            child: _Glow(color: Color(0xFF7C5CFF), size: 460),
          ),
          const Positioned(
            right: -160,
            bottom: -180,
            child: _Glow(color: Color(0xFF1F8F7A), size: 420),
          ),
          child,
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: 90, sigmaY: 90),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color.withValues(alpha: 0.30), color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
