// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:opencv_dart/opencv.dart' as cv;

enum LogLevel { info, ok, warn, error }

class LogEntry {
  LogEntry(this.level, this.message) : at = DateTime.now();

  final LogLevel level;
  final String message;
  final DateTime at;

  String get stamp =>
      '${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}:'
      '${at.second.toString().padLeft(2, '0')}.${at.millisecond.toString().padLeft(3, '0')}';
}

/// What one measured operation looks like: how long it took, how long the caller was stuck in it,
/// and how many UI frames were missed meanwhile.
class Measure {
  const Measure(this.wall, this.callerBlocked, this.framesMissed);

  final Duration wall;
  final Duration callerBlocked;
  final int framesMissed;

  String get wallMs => (wall.inMicroseconds / 1000).toStringAsFixed(1);
  String get blockedMs => (callerBlocked.inMicroseconds / 1000).toStringAsFixed(1);
}

/// Shared state for the four pages: the log, the UI heartbeat that makes a blocked isolate visible,
/// and the native diagnostics the async work exposes.
///
/// Everything here runs on the Flutter UI isolate on purpose: that is the isolate the demo is about.
class LabController extends ChangeNotifier {
  static const _frameBudget = Duration(milliseconds: 16);
  static const _history = 72;

  final List<LogEntry> _log = [];

  /// Milliseconds between the last [_history] UI ticks; a spike means the UI was blocked.
  // Growable: the heartbeat shifts one value out of the front on every tick.
  final List<double> _gaps = List<double>.filled(_history, 16, growable: true);

  /// Ticks every frame budget so the chart can repaint itself.
  ///
  /// Deliberately *not* `notifyListeners()`: rebuilding the whole tree 16 times a second churns the
  /// semantics tree, which the Windows embedder then fails to apply in one UIA update ("Nodes left
  /// pending by the update"). A painter listening to this repaints without touching the widget tree.
  final ChangeNotifier _pulse = ChangeNotifier();
  Timer? _heartbeat;
  Stopwatch _sinceTick = Stopwatch()..start();
  int _ticks = 0;
  bool _disposed = false;

  /// An async page can finish after the shell was thrown away (`imdecodeAsync` completing during a
  /// shutdown, for instance); reporting into a disposed notifier would assert instead of being
  /// dropped, so every entry point goes through here.
  void _notify() {
    if (!_disposed) notifyListeners();
  }

  /// Repaint source for the heartbeat chart.
  Listenable get framePulse => _pulse;

  List<LogEntry> get entries => List.unmodifiable(_log.reversed.take(120));

  /// A snapshot, for callers that need one.
  List<double> get frameGaps => List.unmodifiable(_gaps);

  /// The live ring buffer: the heartbeat painter reads it while painting, so it must not be copied at
  /// build time (a copy would freeze the chart at whatever it held when the widget was built).
  List<double> get frameGapsLive => _gaps;
  int get heartbeatTicks => _ticks;

  /// Live wrapped C++ objects, from `cv.liveObjectCount()`: a leak in the demo shows up here.
  int get liveObjects => cv.liveObjectCount();

  int get pending => cv.asyncPending();
  int get workers => cv.getAsyncThreads();

  void log(String message, {LogLevel level = LogLevel.info}) {
    if (_disposed) return;
    _log.add(LogEntry(level, message));
    if (_log.length > 300) _log.removeAt(0);
    _notify();
  }

  void clearLog() {
    if (_disposed) return;
    _log.clear();
    _notify();
  }

  void setWorkers(int n) {
    cv.setAsyncThreads(n);
    log('worker threads = ${cv.getAsyncThreads()}', level: LogLevel.info);
  }

  void drain() {
    cv.asyncDrain();
    log('asyncDrain(): queue empty, ${cv.asyncPending()} pending', level: LogLevel.ok);
  }

  void startHeartbeat() {
    if (_disposed) return;
    _heartbeat ??= Timer.periodic(_frameBudget, (_) {
      if (_disposed) return;
      final gap = _sinceTick.elapsedMicroseconds / 1000;
      _sinceTick = Stopwatch()..start();
      _ticks++;
      _gaps.removeAt(0);
      _gaps.add(math.min(gap, 4000)); // a long block would flatten the chart otherwise
      if (!_disposed) _pulse.notifyListeners();
    });
  }

  void stopHeartbeat() {
    _heartbeat?.cancel();
    _heartbeat = null;
  }

  /// Runs [body] and reports how long the caller was inside it (`callerBlocked`), how long the whole
  /// thing took (`wall`), and how many 16 ms frames the UI missed meanwhile.
  ///
  /// For a synchronous call the two are the same; for an awaited async call `callerBlocked` is the
  /// cost of handing the work over, which is the point of the comparison.
  Future<Measure> measure(Future<void> Function() body) async {
    final missedBefore = _ticks;
    final gapsBefore = List<double>.of(_gaps);
    final watch = Stopwatch()..start();
    await body();
    final wall = watch.elapsed;

    // Frames the UI did not manage to draw: whatever the heartbeat counted, minus what it would
    // have counted in that time anyway.
    final expected = wall.inMicroseconds / _frameBudget.inMicroseconds;
    final missed = math.max(0, (expected - (_ticks - missedBefore)).round());
    // Restore the chart when the operation was synchronous and could not tick at all.
    if (missed > 3) {
      _gaps.setAll(0, gapsBefore);
      final spike = wall.inMilliseconds.toDouble();
      _gaps.removeAt(0);
      _gaps.add(spike);
    }
    _notify();
    return Measure(wall, wall, missed);
  }

  /// The caller-visible cost of a call whose completion is awaited later: measured around the call
  /// expression only, i.e. how long the UI was actually blocked.
  Future<(Measure, Future<void>)> measureCaller(Future<void> Function() start) async {
    final watch = Stopwatch()..start();
    final future = start();
    final blocked = watch.elapsed;
    return (Measure(blocked, blocked, 0), future);
  }

  @override
  void dispose() {
    _disposed = true;
    stopHeartbeat();
    _pulse.dispose();
    super.dispose();
  }
}

/// A convenient `BuildContext` extension for the animated snack bars the pages use.
extension LabSnack on BuildContext {
  void showLabSnack(String message, {Color tone = const Color(0xFF9BB4FF)}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Row(
            children: [
              Icon(Icons.bolt_rounded, size: 16, color: tone),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }
}
