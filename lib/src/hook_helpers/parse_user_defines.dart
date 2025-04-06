import 'dart:io';

import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

Future<Map<String, Object?>> parseUserDefines(File yamlFile, String pkgName, {Logger? logger}) async {
  final yaml = loadYaml(await yamlFile.readAsString()) as YamlMap;
  try {
    final m = yaml['hooks']['user_defines'][pkgName] as YamlMap;
    return Map<String, Object?>.from(m);
  } catch (e) {
    logger?.warning('No user defines found for $pkgName, error: $e\n');
    return {};
  }
}
