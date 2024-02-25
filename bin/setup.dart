import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as p;

class OS {
  static const auto = "auto";
  static const windows = "windows";
  static const linux = "linux";
  static const android = "android";
  static const fuchsia = "fuchsia";
  static const ios = "ios";
  static const macos = "macos";
}

void main(List<String> args) async {
  final parser = ArgParser();
  parser.addOption(
    "platform",
    abbr: "p",
    allowed: [
      "auto",
      "windows",
      "linux",
      "android",
      "fuchsia",
      "ios",
      "macos",
    ],
    defaultsTo: "auto",
    help: "Platform to setup",
  );
  final argsParsed = parser.parse(args);
  final platform = argsParsed["platform"] == OS.auto ? Platform.operatingSystem : argsParsed["platform"] as String;

  // Assumed package root
  final root = Directory.current.uri;
  print('Building with assumed project root in:');
  print(root.toFilePath());

  // Assumed package_config.json
  final packageConfigFile = File.fromUri(
    root.resolve('.dart_tool/package_config.json'),
  );
  dynamic packageConfig;
  try {
    packageConfig = json.decode(await packageConfigFile.readAsString());
  } on FileSystemException {
    print('Missing .dart_tool/package_config.json');
    print('Run `flutter pub get` first.');
    exit(1);
  } on FormatException {
    print('Invalid .dart_tool/package_config.json');
    print('Run `flutter pub get` first.');
    exit(1);
  }

  // Determine the source path of package:webcrypto in the PUB_CACHE
  final pkg = (packageConfig['packages'] ?? []).firstWhere(
    (e) => e['name'] == 'opencv_dart',
    orElse: () => null,
  );
  if (pkg == null) {
    print('dependency on package:opencv_dart is required');
    exit(1);
  }
  final opencvRoot = packageConfigFile.uri.resolve(pkg['rootUri'] ?? '');
  print('Using package:opencv_dart from ${opencvRoot.toFilePath()}');

  final doc = loadYaml(File("${opencvRoot.toFilePath()}/pubspec.yaml").readAsStringSync());
  final _version = doc["version"] as String;
  final version = _version.replaceAll(RegExp(r"\-dev.*"), "");

  print('Downloading prebuilt binary...');
  String url = "https://github.com/rainyl/opencv_dart/releases/download/v$version";
  String savePath;
  switch (platform) {
    case OS.windows:
      url += "/libopencv_dart-win-x64.dll";
      savePath = p.join(opencvRoot.toFilePath(), "windows", "libopencv_dart.dll");
      break;
    case OS.linux:
      url += "/libopencv_dart-linux-x64.so";
      savePath = p.join(opencvRoot.toFilePath(), "linux", "libopencv_dart.so");
      break;
    case OS.android:
    case OS.fuchsia:
      url = "";
      savePath = "";
      throw UnimplementedError();
      break;
    case OS.ios:
    case OS.macos:
      throw UnimplementedError();
      break;
    default:
      throw UnsupportedError("Platform $platform not supported");
  }

  final saveFile = File(savePath);
  if (!saveFile.parent.existsSync()) saveFile.parent.createSync(recursive: true);

  print("Downloading $url");
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  if (response.statusCode == 200) {
    await response.pipe(saveFile.openWrite());
    print("Saved to $savePath");
  } else {
    print("Download Failed with status: ${response.statusCode}");
    exit(1);
  }
  exit(0);
}
