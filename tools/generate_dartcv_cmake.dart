import 'dart:io';
import 'package:yaml/yaml.dart';

const knownModules = [
  'calib3d',
  'contrib',
  'dnn',
  'feature2d',
  'highgui',
  'imgproc',
  'objdetect',
  'photo',
  'stitching',
  'video',
  'videoio',
  'gapi',
  'world',
];

const defaultConfig = {
  'calib3d': true,
  'contrib': true,
  'dnn': true,
  'feature2d': true,
  'highgui': false,
  'imgproc': true,
  'objdetect': true,
  'photo': true,
  'stitching': true,
  'video': true,
  'videoio': true,
  'gapi': false,
  'world': false,
};

void main(List<String> args) {
  final toStdout = args.contains('--stdout');
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    stderr.writeln('pubspec.yaml not found!');
    exit(1);
  }
  final yaml = loadYaml(pubspec.readAsStringSync());
  final modules = Map<String, bool>.from(defaultConfig);

  if (yaml is YamlMap && yaml['dartcv_modules'] != null) {
    final config = yaml['dartcv_modules'] as YamlMap;
    if (config['exclude'] != null) {
      for (final m in config['exclude']) {
        if (knownModules.contains(m)) modules[m] = false;
      }
    }
    if (config['include'] != null) {
      for (final m in knownModules) {
        modules[m] = false;
      }
      for (final m in config['include']) {
        if (knownModules.contains(m)) modules[m] = true;
      }
    }
  }

  final buffer = StringBuffer();
  for (final m in knownModules) {
    final cmakeVar = 'DARTCV_WITH_${m.toUpperCase()}';
    final value = modules[m]! ? 'ON' : 'OFF';
    buffer.writeln('set($cmakeVar $value CACHE BOOL "" FORCE)');
  }

  if (toStdout) {
    stdout.write(buffer.toString());
  } else {
    File('dartcv_modules.cmake').writeAsStringSync(buffer.toString());
    print('Generated dartcv_modules.cmake');
  }
}
