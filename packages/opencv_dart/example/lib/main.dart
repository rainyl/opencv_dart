// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// A tour of dartcv4 from a Flutter app: image processing, video processing, the difference between
// the synchronous and the worker-thread APIs, and what each failure looks like from Dart.
//
// Run with `flutter run` (or `flutter run -d chrome` for the web build, see ../README.md).
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:opencv_dart/opencv.dart' as cv;

import 'src/core/lab_controller.dart';
import 'src/pages/async_lab.dart';
import 'src/pages/errors_lab.dart';
import 'src/pages/image_lab.dart';
import 'src/pages/video_lab.dart';
import 'src/theme.dart';
import 'src/widgets/primitives.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // On the web this loads web/dartcv.js + dartcv.wasm; on native it is a no-op.
  await cv.initDartcv();
  runApp(const LabApp());
}

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dartcv4 lab',
      debugShowCheckedModeBanner: false,
      theme: buildLabTheme(),
      home: const LabShell(),
    );
  }
}

class _Destination {
  const _Destination(this.label, this.icon, this.selectedIcon, this.blurb);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String blurb;
}

const _destinations = <_Destination>[
  _Destination('Images', Icons.image_outlined, Icons.image_rounded, 'filters, encoders, once per tap'),
  _Destination('Video', Icons.movie_outlined, Icons.movie_rounded, 'VideoWriter → VideoCapture, per frame'),
  _Destination('Sync/Async', Icons.speed_outlined, Icons.speed_rounded, 'the same kernel, two threads'),
  _Destination('Errors', Icons.report_outlined, Icons.report_rounded, 'what each failure looks like'),
];

class LabShell extends StatefulWidget {
  const LabShell({super.key});

  @override
  State<LabShell> createState() => _LabShellState();
}

class _LabShellState extends State<LabShell> {
  final _controller = LabController();
  int _index = 0;
  bool _showLog = true;

  /// Excluding the content from the accessibility tree by default on desktop.
  ///
  /// Not because the app has nothing to say, but because the Windows embedder cannot apply the
  /// semantics updates a scroll or a rebuild produces ("Failed to update ui::AXTree, error: Nodes
  /// left pending by the update: N", flutter#98099 and friends) and floods the console the demo is
  /// supposed to be readable in. Toggle it back on to see the difference.
  bool _semantics = kIsWeb;

  @override
  void initState() {
    super.initState();
    _controller.startHeartbeat();
    _controller.log(
      // First two lines of cv::getBuildInformation(): version and platform.
      cv.getBuildInformation().split('\n').take(2).join(' · '),
      level: LogLevel.info,
    );
    _controller.log(
      'async workers: ${cv.getAsyncThreads()} · live objects: ${cv.liveObjectCount()}',
      level: LogLevel.ok,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LabBackdrop(
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final wide = MediaQuery.sizeOf(context).width > 900;
          final pages = [
            ImageLabPage(controller: _controller),
            VideoLabPage(controller: _controller),
            AsyncLabPage(controller: _controller),
            ErrorsLabPage(controller: _controller),
          ];
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: ExcludeSemantics(
                excluding: !_semantics,
                child: Row(
                  children: [
                    if (wide) _rail(context),
                    Expanded(
                      child: Column(
                        children: [
                          _topBar(context, wide),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 260),
                              child: KeyedSubtree(key: ValueKey(_index), child: pages[_index]),
                            ),
                          ),
                          if (_showLog) _logPanel(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: wide ? null : _bottomBar(context),
          );
        },
      ),
    );
  }

  Widget _rail(BuildContext context) {
    return Container(
      width: 236,
      margin: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: LabPalette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF7C5CFF), Color(0xFF64E3C4)]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.filter_vintage_rounded, size: 18, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'dartcv4 lab',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 0.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'OpenCV in Dart, on the UI isolate or on a worker thread.',
                  style: TextStyle(fontSize: 11.5, height: 1.45, color: Colors.white.withValues(alpha: 0.5)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 10),
          for (var i = 0; i < _destinations.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: _RailTile(
                destination: _destinations[i],
                selected: i == _index,
                onTap: () => setState(() => _index = i),
              ),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    Pill('live ${_controller.liveObjects}', tone: PillTone.info, icon: Icons.memory_rounded),
                    Pill(
                      'pending ${_controller.pending}',
                      tone: PillTone.good,
                      icon: Icons.hourglass_bottom_rounded,
                    ),
                    Pill('workers ${_controller.workers}', tone: PillTone.warn, icon: Icons.dns_rounded),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'These three numbers come from the library: wrapped C++ objects alive, async jobs queued '
                  'or running, and worker threads.',
                  style: TextStyle(fontSize: 10.5, height: 1.5, color: Colors.white.withValues(alpha: 0.38)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar(BuildContext context, bool wide) {
    final destination = _destinations[_index];
    return Padding(
      padding: EdgeInsets.fromLTRB(wide ? 24 : 16, 16, wide ? 24 : 16, 0),
      child: Row(
        children: [
          if (!wide) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF7C5CFF), Color(0xFF64E3C4)]),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(Icons.filter_vintage_rounded, size: 16, color: Colors.black),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.label,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                ),
                Text(
                  destination.blurb,
                  style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45)),
                ),
              ],
            ),
          ),
          if (kIsWeb)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Pill('web build', tone: PillTone.warn, icon: Icons.public_rounded),
            ),
          IconButton(
            tooltip: _semantics
                ? 'Accessibility tree: on (scrolling will print AXTree errors on Windows)'
                : 'Accessibility tree: off (silences the Windows AXTree errors)',
            onPressed: () => setState(() => _semantics = !_semantics),
            icon: Icon(
              _semantics ? Icons.accessibility_new_rounded : Icons.accessibility_new_outlined,
              size: 20,
              color: _semantics ? null : LabPalette.info,
            ),
          ),
          IconButton(
            tooltip: _showLog ? 'Hide log' : 'Show log',
            onPressed: () => setState(() => _showLog = !_showLog),
            icon: Icon(_showLog ? Icons.terminal_rounded : Icons.terminal_outlined, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      backgroundColor: LabPalette.surfaceRaised,
      indicatorColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.22),
      destinations: [
        for (final d in _destinations)
          NavigationDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: d.label),
      ],
    );
  }

  Widget _logPanel(BuildContext context) {
    final entries = _controller.entries;
    return Container(
      height: 168,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 14),
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: LabPalette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.terminal_rounded, size: 14, color: LabPalette.async),
              const SizedBox(width: 8),
              Text(
                'runtime log',
                style: TextStyle(
                  fontSize: 10.5,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _controller.clearLog,
                icon: const Icon(Icons.delete_sweep_outlined, size: 15),
                label: const Text('clear', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: entries.length,
              itemBuilder: (context, i) {
                final entry = entries[i];
                final tone = switch (entry.level) {
                  LogLevel.ok => LabPalette.async,
                  LogLevel.warn => LabPalette.sync,
                  LogLevel.error => LabPalette.error,
                  LogLevel.info => LabPalette.info,
                };
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.stamp,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.message,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            height: 1.4,
                            color: Colors.white.withValues(alpha: 0.78),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RailTile extends StatelessWidget {
  const _RailTile({required this.destination, required this.selected, required this.onTap});

  final _Destination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.16) : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: selected ? accent.withValues(alpha: 0.4) : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              selected ? destination.selectedIcon : destination.icon,
              size: 18,
              color: selected ? accent : Colors.white.withValues(alpha: 0.55),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                destination.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? Colors.white : Colors.white.withValues(alpha: 0.62),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
