// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:meta/meta.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

import 'module_conflicts.dart';

/// Modules built when the consumer does not ask for a specific set.
///
/// `core` is always built and can not be configured.
const defaultIncludedModules = {
  'imgcodecs',
  'imgproc',
};

/// Modules that exist, but are only built when explicitly requested.
const defaultExcludedModules = {
  'calib3d',
  'dnn',
  'features2d',
  'flann',
  'freetype',
  'highgui',
  'objdetect',
  'photo',
  'stitching',
  'video',
  'videoio',
  // contrib
  'aruco',
  'img_hash',
  'quality',
  'wechat_qrcode',
  'ximgproc',
  'xobjdetect',
};

/// Every module name accepted in `include_modules` / `exclude_modules`.
const allowedModules = {
  ...defaultIncludedModules,
  ...defaultExcludedModules,
};

/// The parsed and validated `hooks.user_defines.dartcv4` options of a hook invocation.
///
/// Consumers configure the native build from their `pubspec.yaml`:
///
/// ```yaml
/// hooks:
///   user_defines:
///     dartcv4:
///       debug: true
///       include_modules:
///         - imgcodecs
///         - dnn
/// ```
///
/// All options are parsed and validated by the constructor, so a malformed one
/// fails the hook with an [ArgumentError] naming the offending entry, instead of
/// failing later inside CMake with a much less obvious error.
///
/// Keys this parser does not know are deliberately ignored: the same maps carry
/// options read by other code (e.g. `cmake_version` / `ninja_version` of
/// `native_toolchain_cmake`) and by future dartcv versions.
class UserDefineArgsParser {
  /// Parses the `dartcv4` entry of the consumer's `hooks.user_defines`.
  ///
  /// [targetOS] is the OS the code assets are built for, i.e. the only per-OS
  /// sub-map that is consulted. It is `null` when no code assets are built (and
  /// in the link hook), in which case only top-level options apply.
  ///
  /// [baseModules] is the module set used when `include_modules` is not set,
  /// [defaultIncludedModules] by default.
  UserDefineArgsParser(HookInputUserDefines userDefines, {this.targetOS, Set<String>? baseModules})
    : _lookup = ((key) => userDefines[key]),
      _baseModules = baseModules ?? defaultIncludedModules {
    _parse();
  }

  /// Parses an already flattened user-define map.
  ///
  /// [HookInputUserDefines] can only be created by the hooks runner, so this
  /// constructor exists for tests.
  @visibleForTesting
  UserDefineArgsParser.fromMap(
    Map<String, Object?> userDefines, {
    this.targetOS,
    Set<String>? baseModules,
  }) : _lookup = ((key) => userDefines[key]),
       _baseModules = baseModules ?? defaultIncludedModules {
    _parse();
  }

  /// The OS the code assets are built for, or `null` when no code assets are built.
  final OS? targetOS;

  final Object? Function(String) _lookup;

  final Set<String> _baseModules;

  /// The per-OS option sub-maps of the user defines, indexed by [OS].
  ///
  /// `static final` and not `const`: a const map can not be keyed on a type
  /// that overrides `==`, which [OS] does.
  static final Map<OS, String> _platformSubMaps = {
    OS.windows: 'windows',
    OS.linux: 'linux',
    OS.macOS: 'macos',
    OS.android: 'android',
    OS.iOS: 'ios',
  };

  /// The generator names accepted in the `generator` option.
  static const Map<String, Generator> _generators = {
    'Ninja': Generator.ninja,
    'Unix Makefiles': Generator.make,
    'Xcode': Generator.xcode,
    'Visual Studio 16 2019': Generator.vs2019,
    'Visual Studio 17 2022': Generator.vs2022,
    'Visual Studio 18 2026': Generator.vs2026,
  };

  /// Whether to skip the native build entirely (`skip_build`).
  late final bool skipBuild;

  /// Whether hook messages are written to stderr instead of stdout (`debug`).
  late final bool debug;

  /// Number of parallel build jobs (`parallel_jobs`), [Platform.numberOfProcessors] by default.
  late final int parallelJobs;

  /// Whether the linker dead-code elimination is enabled (`treeshake`).
  late final bool treeshake;

  /// The OpenCV tag to build from source (`opencv_version`), `null` to use the pinned one.
  late final String? opencvVersion;

  /// An already built OpenCV to link against (`opencv_dir`), which wins over [opencvVersion].
  late final String? opencvDir;

  /// Whether OpenCV is built with OpenCL support (`use_opencl`), always `false` on iOS.
  late final bool useOpenCL;

  /// The Apple deployment target (`deployment_target` of the `macos` / `ios`
  /// sub-map), `null` when it is not set or [targetOS] is not macOS/iOS.
  ///
  /// Numbers are accepted (`deployment_target: 15.0` is parsed as one by YAML)
  /// and rendered as `15.0`. Quote values with trailing zeros: YAML parses
  /// `10.10` as the number `10.1` and the last zero is lost.
  late final String? appleDeploymentTarget;

  /// The CMake generator to build with: `generator` of the [targetOS] sub-map,
  /// or the platform default when it is not set.
  late final Generator generator;

  /// The per-OS option sub-maps (`windows`, `linux`, `macos`, `android`, `ios`).
  late final Map<OS, Map<String, dynamic>> platformDefines;

  /// The module names requested via `include_modules`.
  late final List<String> includeModules;

  /// The module names rejected via `exclude_modules`.
  late final List<String> excludeModules;

  /// The modules to build: `include_modules` if set, [defaultIncludedModules]
  /// otherwise, without the `exclude_modules` ones.
  late final Set<String> modules;

  /// Parses and validates every option, so that a bad one fails the hook before
  /// it starts the expensive native build.
  void _parse() {
    skipBuild = _bool('skip_build');
    debug = _bool('debug');
    parallelJobs = _int('parallel_jobs') ?? Platform.numberOfProcessors;
    treeshake = _bool('treeshake');
    opencvVersion = _string('opencv_version');
    platformDefines = {
      for (final entry in _platformSubMaps.entries) entry.key: _map(entry.value) ?? const <String, dynamic>{},
    };
    // An OpenCV that is already built wins over one built from source, and may
    // be given per platform: a cross-compiled OpenCV lives somewhere else for
    // every target.
    opencvDir = _string('opencv_dir', platformDefines[targetOS]) ?? _string('opencv_dir');
    // OpenCL is not available on iOS.
    useOpenCL = targetOS != null && targetOS != OS.iOS && _bool('use_opencl', platformDefines[targetOS]);
    // Only the Apple platforms have a deployment target.
    appleDeploymentTarget = switch (targetOS) {
      OS.macOS || OS.iOS => _version('deployment_target', platformDefines[targetOS]),
      _ => null,
    };
    generator = _resolveGenerator();
    includeModules = _moduleNames('include_modules');
    excludeModules = _moduleNames('exclude_modules');
    modules = _resolveModules();
    validateModuleConflicts(modules: modules, explicitlyExcluded: excludeModules.toSet());
  }

  /// Maps the `generator` option to a [Generator], defaulting per platform.
  ///
  /// Without a [targetOS] (no code assets are built) the host platform default
  /// is used; the generator is only used for the native build anyway.
  Generator _resolveGenerator() {
    final name = targetOS == null ? null : _string('generator', platformDefines[targetOS]);
    if (name == null) {
      return switch (targetOS ?? OS.current) {
        OS.linux => Generator.make,
        OS.macOS || OS.iOS => Generator.xcode,
        OS.windows => Generator.defaultGenerator,
        OS.android => Generator.ninja,
        _ => throw ArgumentError.value(targetOS, 'targetOS', 'Unsupported target OS'),
      };
    }
    final generator = _generators[name];
    if (generator != null) return generator;
    final subMap = targetOS == null ? null : _platformSubMaps[targetOS];
    throw ArgumentError.value(
      name,
      subMap == null ? 'user_defines.generator' : 'user_defines.$subMap.generator',
      'unsupported generator, expected one of: ${_generators.keys.join(', ')}',
    );
  }

  /// Resolves the modules to build: `include_modules` replaces [_baseModules]
  /// when set (it is not merged with it), then `exclude_modules` is removed.
  Set<String> _resolveModules() {
    final modules = {..._baseModules};
    if (includeModules.isNotEmpty) {
      modules
        ..clear()
        ..addAll(includeModules);
    }
    modules.removeAll(excludeModules);
    return modules;
  }

  /// Reads a module list, rejecting every name that is not in [allowedModules]:
  /// an ignored name would silently build something else than asked for.
  List<String> _moduleNames(String key) {
    final value = _value(key, null);
    if (value == null) return const [];
    if (value is! List) throw _typeError(key, 'List of module names', value);
    final names = <String>[];
    for (final (index, name) in value.indexed) {
      if (name is! String) throw _typeError('$key[$index]', 'module name (String)', name);
      if (!allowedModules.contains(name)) {
        throw ArgumentError(
          'user_defines.$key contains an unknown module: "$name".\n'
          'Valid modules are: ${(allowedModules.toList()..sort()).join(', ')}\n'
          '(`core` is always built and does not need to be listed).',
        );
      }
      if (!names.contains(name)) {
        names.add(name);
      }
    }
    return names;
  }

  bool _bool(String key, [Map<String, dynamic>? map]) {
    final value = _value(key, map);
    if (value == null) return false;
    if (value is bool) return value;
    throw _typeError(key, 'bool', value);
  }

  int? _int(String key) {
    final value = _value(key, null);
    if (value == null) return null;
    if (value is int) return value;
    throw _typeError(key, 'int', value);
  }

  String? _string(String key, [Map<String, dynamic>? map]) {
    final value = _value(key, map);
    if (value == null) return null;
    if (value is String) return value;
    // YAML turns `opencv_version: 4.12` into a number: refuse it rather than
    // building against a version the consumer did not write.
    if (value is num) throw _typeError(key, 'String (quote the value in pubspec.yaml)', value);
    throw _typeError(key, 'String', value);
  }

  /// Reads a version option, which is commonly written unquoted in YAML, where
  /// `deployment_target: 15.0` parses as a number. Numbers are rendered with
  /// `toString()`, so values with trailing zeros (e.g. `10.10`) must be quoted.
  String? _version(String key, Map<String, dynamic>? map) {
    final value = _value(key, map);
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    throw _typeError(key, 'String or num', value);
  }

  Map<String, dynamic>? _map(String key) {
    final value = _value(key, null);
    if (value == null) return null;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return value.cast<String, dynamic>();
    throw _typeError(key, 'Map', value);
  }

  Object? _value(String key, Map<String, dynamic>? map) => map == null ? _lookup(key) : map[key];

  ArgumentError _typeError(String key, String expected, Object? value) =>
      ArgumentError.value(value, 'user_defines.$key', 'expected $expected');
}
