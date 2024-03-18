import 'dart:convert';
import 'dart:ffi';
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
    return arch_ == "auto" ? Abi.current().toString().split("_").last : arch_;
  }

  String get os => name;

  Future<void> downloadAndExtract() async {
    // Detect dependencies
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

    final doc = loadYaml(
        File("${opencvRoot.toFilePath()}/pubspec.yaml").readAsStringSync());
    final _version = doc["version"] as String;
    final libTarName = "libopencv_dart-$os-$arch.tar.gz";
    final version = _version.replaceAll(RegExp(r"\-dev.*"), "");

    print('Downloading prebuilt binary...');
    String url =
        "https://github.com/rainyl/opencv_dart/releases/download/v$version/$libTarName";

    final cacheTarPath = p.join(opencvRoot.toFilePath(), ".cache", libTarName);
    final saveFile = File(cacheTarPath);
    if (!saveFile.parent.existsSync())
      saveFile.parent.createSync(recursive: true);

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
    switch (os) {
      case OS.windows:
        extractPath = p.join(opencvRoot.toFilePath(), "windows");
        break;
      case OS.linux:
        extractPath = p.join(opencvRoot.toFilePath(), "linux");
        break;
      case OS.android:
        extractPath = p.join(
            opencvRoot.toFilePath(), "android", "src", "main", "jniLibs", arch);
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
    final tarBytes = GZipDecoder().decodeBytes(saveFile.readAsBytesSync());
    final archive = TarDecoder().decodeBytes(tarBytes);
    extractArchiveToDisk(archive, extractPath,
        bufferSize: 1024 * 1024 * 10); // 10MB
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
      allowed: ["auto", "x64", "arm64"],
      defaultsTo: "auto",
    );
  }
}

class WindowsSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Windows";

  @override
  String get name => "windows";

  WindowsSetupCommand() {
    argParser.addOption("arch", abbr: "a", allowed: ["x64"], defaultsTo: "x64");
  }
}

class LinuxSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Linux";

  @override
  String get name => "linux";

  LinuxSetupCommand() {
    argParser.addOption("arch", abbr: "a", allowed: ["x64"], defaultsTo: "x64");
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
      allowed: ["auto", "x86_64", "arm64-v8a", "armeabi-v7a"],
      defaultsTo: "auto",
    );
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
      allowed: ["auto", "x64", "arm64"],
      defaultsTo: "auto",
    );
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
