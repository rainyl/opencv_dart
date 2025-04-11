import 'dart:io';
import 'package:yaml/yaml.dart';

/// Parse the user defined exclude modules from pubspec.yaml
///
/// Returns a list of excluded module names
List<String> parseUserDefinedExcludeModules(String pubspecPath) {
  try {
    // Read the pubspec.yaml file
    final File file = File(pubspecPath);
    if (!file.existsSync()) {
      return [];
    }

    // Parse the YAML content
    final String yamlContent = file.readAsStringSync();
    final dynamic yamlMap = loadYaml(yamlContent);

    // Navigate to the hooks.user_defines.dartcv4.exclude_modules section
    if (yamlMap is YamlMap &&
        yamlMap['hooks'] is YamlMap &&
        yamlMap['hooks']['user_defines'] is YamlMap &&
        yamlMap['hooks']['user_defines']['dartcv4'] is YamlMap &&
        yamlMap['hooks']['user_defines']['dartcv4']['exclude_modules'] is YamlList) {
      final YamlList excludeModules =
          yamlMap['hooks']['user_defines']['dartcv4']['exclude_modules'] as YamlList;

      // Convert YamlList to List<String>
      return excludeModules.map((dynamic module) => module.toString().toLowerCase()).toList();
    }

    return [];
  } catch (e) {
    // Return empty list in case of any error
    print('Error parsing exclude_modules: $e');
    return [];
  }
}
