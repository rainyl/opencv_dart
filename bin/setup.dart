import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:yaml/yaml.dart';
import 'package:archive/archive_io.dart';
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
  // parser.addFlag(
  //   "flutter",
  //   negatable: true,
  //   defaultsTo: false,
  //   help: "Setup for Flutter",
  // );
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
  parser.addOption(
    "arch",
    abbr: "a",
    allowed: [
      "auto",
      "x86",
      "x64",
      "x86_64",
      "arm64",
      "arm64-v8a",
      "armeabi-v7a",
    ],
    defaultsTo: "auto",
    help: "Architecture to setup",
  );

  final argsParsed = parser.parse(args);
  final platform =
      argsParsed["platform"] == OS.auto ? Platform.operatingSystem : argsParsed["platform"] as String;
  final arch = argsParsed["arch"] == OS.auto
      ? (platform == "android" ? "arm64-v8a" : "x64")
      : argsParsed["arch"] as String;
  final setupPkgName = "opencv_dart";

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
    (e) => e['name'] == setupPkgName,
    orElse: () => null,
  );
  if (pkg == null) {
    print('dependency on package:$setupPkgName is required');
    exit(1);
  }
  final opencvRoot = packageConfigFile.uri.resolve(pkg['rootUri'] ?? '');
  print('Using package:$setupPkgName from ${opencvRoot.toFilePath()}');

  final doc = loadYaml(File("${opencvRoot.toFilePath()}/pubspec.yaml").readAsStringSync());
  final _version = doc["version"] as String;
  final version = _version.replaceAll(RegExp(r"\-dev.*"), "");
  final libTarName = "libopencv_dart-$platform-$arch.tar.gz";

  print('Downloading prebuilt binary...');
  String url = "https://github.com/rainyl/opencv_dart/releases/download/v$version/$libTarName";

  final cacheTarPath = p.join(opencvRoot.toFilePath(), ".cache", libTarName);
  final saveFile = File(cacheTarPath);
  if (!saveFile.parent.existsSync()) saveFile.parent.createSync(recursive: true);

  print("Downloading $url");
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  if (response.statusCode == 200) {
    await response.pipe(saveFile.openWrite());
    print("Cached to $cacheTarPath");
  } else {
    print("Download Failed with status: ${response.statusCode}");
    exit(1);
  }

  print("Extracting...");
  String extractPath = "";
  switch (platform) {
    case OS.windows:
      extractPath = p.join(opencvRoot.toFilePath(), "windows");
      break;
    case OS.linux:
      extractPath = p.join(opencvRoot.toFilePath(), "linux");
      break;
    case OS.android:
      extractPath = p.join(opencvRoot.toFilePath(), "android", "src", "main", "jniLibs", arch);
    case OS.macos:
      extractPath = p.join(opencvRoot.toFilePath(), "macos");
    case OS.fuchsia:
    case OS.ios:
      throw UnimplementedError();
    default:
      throw UnsupportedError("Platform $platform not supported");
  }

  if (!Directory(extractPath).existsSync()) Directory(extractPath).createSync(recursive: true);
  await extractFileToDisk(cacheTarPath, extractPath);

  print("Finished");
  exit(0);
}
