// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

/// Direct mandatory module dependencies.
const Map<String, Set<String>> moduleDirectDependencies = {
  'calib3d': {'imgproc', 'features2d', 'flann'},
  'dnn': {'imgproc'},
  'features2d': {'imgproc', 'flann'},
  'highgui': {'imgproc'},
  'imgcodecs': {'imgproc'},
  'objdetect': {'imgproc', 'calib3d'},
  'photo': {'imgproc'},
  'stitching': {'imgproc', 'features2d', 'calib3d', 'flann'},
  'video': {'imgproc'},
  'videoio': {'imgproc', 'imgcodecs'},
  'aruco': {'imgproc', 'calib3d', 'objdetect'},
  'img_hash': {'imgproc'},
  'quality': {'imgproc', 'ml'},
  'wechat_qrcode': {'imgproc', 'objdetect', 'dnn'},
  'ximgproc': {'imgproc', 'calib3d', 'imgcodecs', 'video'},
  'xobjdetect': {'imgproc', 'objdetect', 'imgcodecs'},
};

/// Returns the transitive mandatory dependencies of a module.
Set<String> transitiveModuleDependencies(String module) {
  final result = <String>{};

  void visit(String current) {
    final deps = moduleDirectDependencies[current];
    if (deps == null) return;
    for (final dep in deps) {
      if (result.add(dep)) {
        visit(dep);
      }
    }
  }

  visit(module);
  return result;
}

/// Throws if any built module needs a dependency that the user explicitly
/// removed via `exclude_modules`.
///
/// All conflicting dependencies are collected and reported in a single error.
/// Modules that are merely omitted from `include_modules` are not conflicts:
/// `opencv_options.cmake` auto-enables them through its dependency closure.
void validateModuleConflicts({
  required Set<String> modules,
  required Set<String> explicitlyExcluded,
}) {
  final conflicts = <String>{};

  for (final module in modules) {
    for (final dep in transitiveModuleDependencies(module)) {
      if (explicitlyExcluded.contains(dep)) {
        conflicts.add("'$module' requires '$dep', but '$dep' is explicitly excluded via exclude_modules");
      }
    }
  }

  if (conflicts.isNotEmpty) {
    final sorted = conflicts.toList()..sort();
    throw ArgumentError(
      'dartcv4 module conflict(s):\n'
      '${sorted.map((c) => '  - $c.').join('\n')}\n'
      'Remove the listed dependencies from exclude_modules or remove the '
      'corresponding modules from include_modules.',
    );
  }
}
