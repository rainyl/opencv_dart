// ignore_for_file: avoid_print, constant_identifier_names

import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;
import 'package:stack_trace/stack_trace.dart';

const setupPkgName = "opencv_dart";
const baseUrl = "https://github.com/rainyl/opencv_dart/releases/download";

abstract class BaseSetupCommand extends Command {
  @override
  String get description => "Setup";

  @override
  String get name => "base";

  String get arch {
    final arch_ = argResults?["arch"] as String;
    return ARCH_MAP[os]?[arch_] as String? ?? arch_;
  }

  String get pkgRoot => Frame.caller().uri.resolve("..").toFilePath();

  bool get force => argResults?.flag("force") ?? false;
  String get os => name;

  Future<void> downloadAndExtract(String downArch, [String? extractPath]) async {
    final opencvRoot = pkgRoot;
    print(asInfo('Using package:$setupPkgName from $opencvRoot'));

    final String version = File(p.join(opencvRoot, "binary.version")).readAsStringSync();
    final libTarName = "libopencv_dart-$os-$downArch.tar.gz";

    extractPath ??= switch (os) {
      OS.windows => p.join(opencvRoot, "windows"),
      OS.linux => p.join(opencvRoot, "linux"),
      OS.android => p.join(opencvRoot, "android", "src", "main", "jniLibs", downArch),
      OS.macos => p.join(opencvRoot, "macos"),
      OS.ios => p.join(opencvRoot, "ios"),
      _ => throw UnsupportedError(asError("Platform $os not supported"))
    };

    if (!Directory(extractPath).existsSync()) {
      Directory(extractPath).createSync(recursive: true);
    }

    final cacheTarPath = p.join(opencvRoot, ".dart_tool", ".cache", libTarName);
    final saveFile = File(cacheTarPath);

    if (force || !saveFile.existsSync()) {
      if (!saveFile.parent.existsSync()) saveFile.parent.createSync(recursive: true);

      final String url = "$baseUrl/v$version/$libTarName";
      print(asInfo("Downloading $url"));
      try {
        final request = await HttpClient().getUrl(Uri.parse(url));
        final response = await request.close();
        if (response.statusCode == 200) {
          await response.pipe(saveFile.openWrite());
          print(asWarning("Cached to $cacheTarPath"));
        } else {
          print(asError("Download Failed with status: ${response.statusCode}"));
          exit(1);
        }
      } catch (e) {
        print(asError(e.toString()));
        exit(1);
      }
    } else {
      print(asWarning("Using cached $cacheTarPath"));
      // Check if libs already existed, avoid double-extract
      if (Directory(extractPath)
          .listSync()
          .map(
            (e) =>
                e.path.endsWith(".so") ||
                e.path.endsWith(".dll") ||
                e.path.endsWith(".dylib") ||
                e.path.endsWith(".framework"),
          )
          .any((e) => e)) {
        print(asWarning("Libs already exists in $extractPath, Skipping..."));
        return;
      }
    }

    print(asInfo("Extracting to $extractPath"));
    final tarBytes = GZipDecoder().decodeBytes(saveFile.readAsBytesSync());
    final archive = TarDecoder().decodeBytes(tarBytes);
    await extractArchiveToDisk(archive, extractPath, bufferSize: 1024 * 1024 * 10); // 10MB
  }

  @override
  Future<void> run() async {
    print(asInfo("opencv_dart: working for $os $arch"));
    await downloadAndExtract(arch);
    print(asInfo("Finished"));
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
      allowed: ["x86_64", "x64", "arm64"],
      mandatory: true,
    );
    argParser.addFlag("force", abbr: "f", help: "Force download and extract");
  }
}

class WindowsSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Windows";

  @override
  String get name => "windows";

  WindowsSetupCommand() {
    argParser.addOption("arch", abbr: "a", allowed: ["x86_64", "x64"], mandatory: true);
    argParser.addFlag("force", abbr: "f", help: "Force download and extract");
  }
}

class LinuxSetupCommand extends BaseSetupCommand {
  @override
  String get description => "Setup for Linux";

  @override
  String get name => "linux";

  LinuxSetupCommand() {
    argParser.addOption("arch", abbr: "a", allowed: ["x86_64", "x64"], mandatory: true);
    argParser.addFlag("force", abbr: "f", help: "Force download and extract");
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
    argParser.addFlag("force", abbr: "f", help: "Force download and extract");
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
      allowed: ["x86_64", "x64", "arm64", "os64"],
      mandatory: true,
    );
    argParser.addFlag("force", abbr: "f", help: "Force download and extract");
  }
}

const ARCH_MAP = {
  OS.windows: {
    "x86_64": "x64",
  },
  OS.linux: {
    "x86_64": "x64",
  },
  OS.macos: {
    "x86_64": "x64",
  },
  OS.ios: {
    "x86_64": "x64",
  },
  OS.android: {},
};

class OS {
  static const windows = "windows";
  static const linux = "linux";
  static const android = "android";
  static const fuchsia = "fuchsia";
  static const ios = "ios";
  static const macos = "macos";
}

String asInfo(String text) => '✅\x1B[32m$text\x1B[0m';

String asWarning(String text) => '💡\x1B[33m$text\x1B[0m';

String asError(String text) => '⛔\x1B[31m$text\x1B[0m';
