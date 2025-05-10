// ignore_for_file: avoid_dynamic_calls, avoid_print

import 'dart:io';

import 'package:yaml/yaml.dart';

const defaultModuleSettings = {
  // "core": "ON", // not configurable
  "calib3d": "ON",
  "contrib": "ON",
  "dnn": "ON",
  "features2d": "ON",
  "flann": "ON",
  // "gapi", // disabled
  "highgui": "ON",
  "imgproc": "ON",
  "imgcodecs": "ON",
  "objdetect": "ON",
  "photo": "ON",
  "stitching": "ON",
  "video": "ON",
  "videoio": "ON",
};

void main(List<String> args) {
  final pubspecPath = Platform.script.resolve("../../../../pubspec.yaml");
  final excludeModules = parseUserDefinedExcludeModules(pubspecPath.toFilePath());

  final cmakeVars = StringBuffer("###DARTCV_GEN_CMAKE_VAR_BEGIN###\n");
  for (final k in excludeModules.entries) {
    cmakeVars.write("${k.key.toUpperCase()}=${k.value.toUpperCase()}\n");
  }
  cmakeVars.write("###DARTCV_GEN_CMAKE_VAR_END###");
  print(cmakeVars);
}

/// Parse the user defined exclude modules from pubspec.yaml
///
/// Returns a list of excluded module names
Map<String, String> parseUserDefinedExcludeModules(String pubspecPath, {bool excludeMode = true}) {
  try {
    print("Generating cmake vars from $pubspecPath");
    // Read the pubspec.yaml file
    final File file = File(pubspecPath);
    if (!file.existsSync()) {
      print("$pubspecPath not found");
      return defaultModuleSettings;
    }

    // Parse the YAML content
    final String yamlContent = file.readAsStringSync();
    final dynamic yamlMap = loadYaml(yamlContent);

    // Navigate to the hooks.user_defines.dartcv4.exclude_modules section
    if (yamlMap is YamlMap &&
        yamlMap['hooks'] is YamlMap &&
        yamlMap['hooks']['user_defines'] is YamlMap &&
        yamlMap['hooks']['user_defines']['dartcv4'] is YamlMap) {
      final dartcvDefines = yamlMap['hooks']['user_defines']['dartcv4'] as YamlMap;

      final excludeModules = dartcvDefines['exclude_modules'] as YamlList? ?? YamlList();
      // include is priority over exclude
      final includeModules = dartcvDefines['include_modules'] as YamlList? ?? YamlList();

      final include =
          includeModules
              .map((dynamic module) => module.toString().toLowerCase())
              .where((e) => defaultModuleSettings.containsKey(e))
              .toList();
      final exclude =
          excludeModules
              .map((dynamic module) => module.toString().toLowerCase())
              .where((e) => defaultModuleSettings.containsKey(e) && !include.contains(e))
              .toList();

      final result = {
        for (final e in defaultModuleSettings.keys)
          e: exclude.contains(e) ? "OFF" : defaultModuleSettings[e]!,
      };

      return result;
    }

    print("parse error");
    return defaultModuleSettings;
  } catch (e) {
    // Return empty list in case of any error
    print('Error parsing exclude_modules: $e');
    return defaultModuleSettings;
  }
}
