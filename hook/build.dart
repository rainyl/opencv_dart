// ignore_for_file: unused_field, avoid_print

import 'package:logging/logging.dart';
import 'package:native_assets_cli/native_assets_cli.dart';

import 'native_toolchain_conan.dart';

void main(List<String> args) async {
  await build(args, (config, output) async {
    final packageName = config.packageName;
    final builder = ConanBuilder.library(
      name: packageName,
      assetName: '$packageName.dart',
      std: "c++20",
      dartBuildFiles: ['hook/build.dart'],
      defines: {
        // "OpenCV_STATIC": "TRUE",
        // "OpenCV_DIR": "build/libopencv-windows-x64",
      },
    );
    await builder.run(
      buildConfig: config,
      buildOutput: output,
      logger: Logger('')
        ..level = Level.ALL
        ..onRecord.listen((record) => print(record.message)),
    );
  });
}

BuildConfig testIosBuildConfig(BuildConfig config) => BuildConfig.build(
      outputDirectory: config.outputDirectory,
      packageName: config.packageName,
      packageRoot: config.packageRoot,
      targetOS: OS.iOS,
      targetArchitecture: Architecture.arm64,
      targetIOSSdk: IOSSdk.iPhoneOS,
      targetAndroidNdkApi: config.targetAndroidNdkApi,
      cCompiler: config.cCompiler,
      linkModePreference: config.linkModePreference,
      buildMode: config.buildMode,
    );
