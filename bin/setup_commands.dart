// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:args/command_runner.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as p;

const setupPkgName = "opencv_dart";

abstract class BaseSetupCommand extends Command {
  @override
  String get description => "Setup";

  @override
  String get name => "base";

  String get arch {
    final arch_ = argResults?["arch"] as String;
    return arch_;
  }

  bool get force => argResults?.flag("force") ?? false;
  String get os => name;

  Future<void> downloadAndExtract() async {
    // Detect dependencies
    // Assumed package root
    final root = Directory.current.uri;
    print('Building with assumed project root in: ${root.toFilePath()}');

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
    final version = doc["binary_version"] as String;
    final libTarName = "libopencv_dart-$os-$arch.tar.gz";

    final cacheTarPath = p.join(opencvRoot.toFilePath(), ".dart_tool", ".cache", libTarName);
    final saveFile = File(cacheTarPath);

    if (force || !saveFile.existsSync()) {
      if (!saveFile.parent.existsSync()) saveFile.parent.createSync(recursive: true);

      String url = "https://github.com/rainyl/opencv_dart/releases/download/v$version/$libTarName";
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
    } else {
      print("Using cached $cacheTarPath");
    }

    String extractPath = "";
    switch (os) {
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
      case OS.ios:
        extractPath = p.join(opencvRoot.toFilePath(), "ios");
      case OS.fuchsia:
      default:
        throw UnsupportedError("Platform $os not supported");
    }
    if (!Directory(extractPath).existsSync()) {
      Directory(extractPath).createSync(recursive: true);
    }
    // Check if libs already existed, avoid double-extract
    if (Directory(extractPath)
        .listSync()
        .map((e) =>
            e.path.endsWith(".so") ||
            e.path.endsWith(".dll") ||
            e.path.endsWith(".dylib") ||
            e.path.endsWith(".framework"))
        .any((e) => e)) {
      print("Libs already exists in $extractPath, Skipping...");
      return;
    }
    print("Extracting to $extractPath");
    final tarBytes = GZipDecoder().decodeBytes(saveFile.readAsBytesSync());
    final archive = TarDecoder().decodeBytes(tarBytes);
    await extractArchiveToDisk(archive, extractPath, bufferSize: 1024 * 1024 * 10); // 10MB
  }

  @override
  void run() async {
    print("opencv_dart: working for $os $arch");
    await downloadAndExtract();
    print("Finished");
    exit(0);
  }
}

class MacOsSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for macOS";

  @override
  String get name => "macos";

  MacOsSetupCommand() {
    argParser.addOption(
      "arch",
      abbr: "a",
      allowed: ["x64", "arm64"],
      mandatory: true,
    );
    argParser.addFlag("force", abbr: "f", defaultsTo: false, help: "Force download and extract");
  }
}

class WindowsSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Windows";

  @override
  String get name => "windows";

  WindowsSetupCommand() {
    argParser.addOption("arch", abbr: "a", allowed: ["x64"], mandatory: true);
    argParser.addFlag("force", abbr: "f", defaultsTo: false, help: "Force download and extract");
  }
}

class LinuxSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Linux";

  @override
  String get name => "linux";

  LinuxSetupCommand() {
    argParser.addOption("arch", abbr: "a", allowed: ["x64"], mandatory: true);
    argParser.addFlag("force", abbr: "f", defaultsTo: false, help: "Force download and extract");
  }
}

class AndroidSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Android";

  @override
  String get name => "android";

  AndroidSetupCommand() {
    argParser.addOption(
      "arch",
      abbr: "a",
      allowed: ["x86_64", "arm64-v8a", "armeabi-v7a"],
      mandatory: true,
    );
    argParser.addFlag("force", abbr: "f", defaultsTo: false, help: "Force download and extract");
  }
}

class IosSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for IOS";

  @override
  String get name => "ios";

  IosSetupCommand() {
    argParser.addOption(
      "arch",
      abbr: "a",
      allowed: ["x64", "arm64"],
      mandatory: true,
    );
    argParser.addFlag("force", abbr: "f", defaultsTo: false, help: "Force download and extract");
  }
}

class OS {
  static const windows = "windows";
  static const linux = "linux";
  static const android = "android";
  static const fuchsia = "fuchsia";
  static const ios = "ios";
  static const macos = "macos";
}
