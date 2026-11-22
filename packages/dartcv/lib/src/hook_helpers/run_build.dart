// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

import 'library_names.dart';
import 'patchelf_linux.dart';
import 'user_defines.dart';

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {Set<String>? optionalModules}) async {
  // Check if code assets are expected (not for web builds).
  // Web builds use WASM/JS interop, not native code assets.
  if (!input.config.buildCodeAssets) {
    return;
  }

  final OS targetOS = input.config.code.targetOS;
  final args = UserDefineArgsParser(
    input.userDefines,
    targetOS: targetOS,
    baseModules: optionalModules,
  );

  // Consumers can set `hooks.user_defines.dartcv4.skip_build: true` in their pubspec.yaml
  // to skip the native build entirely (e.g. for unit test runs that never call into
  // dartcv4's native code, where compiling/downloading OpenCV is pure CI overhead).
  if (args.skipBuild) {
    return;
  }

  final packagePath = Directory(await getPackagePath('dartcv4'));

  final logger = Logger('')
    ..level = Level.ALL
    ..onRecord.listen((record) => args.debug ? stderr.write(record.message) : print(record.message));

  final delegateToLinkHook = input.config.linkingEnabled && args.treeshake;

  // The C/C++ wrappers and the CMake logic are inputs too, and Dart only tracks Dart sources, so
  // without this an edited `.cpp` leaves the hook a cache hit and the tests run against the previous
  // binary.
  output.dependencies.addAll(_nativeSources(packagePath.uri.resolve('src/')));

  logger.info("[dartcv4] use_opencl: ${args.useOpenCL}\n");
  logger.info("[dartcv4] treeshake: ${args.treeshake} (link hook: $delegateToLinkHook)\n");
  logger.info("[dartcv4] include modules: ${args.includeModules}\n");
  logger.info("[dartcv4] exclude modules: ${args.excludeModules}\n");
  logger.info("[dartcv4] merged modules: ${args.modules}\n");
  logger.info("[dartcv4] platform defines: ${args.platformDefines}\n");
  logger.warning('Using generator: ${args.generator.name}');
  if (args.opencvDir != null) {
    logger.info("[dartcv4] using the OpenCV in: ${args.opencvDir}\n");
  } else if (args.opencvVersion != null) {
    logger.info("[dartcv4] building OpenCV ${args.opencvVersion} from source\n");
  }

  final moduleDefines = {
    'DARTCV_WITH_CALIB3D': args.modules.contains('calib3d') ? 'ON' : 'OFF',
    'DARTCV_WITH_DNN': args.modules.contains('dnn') ? 'ON' : 'OFF',
    'DARTCV_WITH_FEATURES2D': args.modules.contains('features2d') ? 'ON' : 'OFF',
    'DARTCV_WITH_FLANN': args.modules.contains('flann') ? 'ON' : 'OFF',
    'DARTCV_WITH_FREETYPE': args.modules.contains('freetype') ? 'ON' : 'OFF',
    'DARTCV_WITH_HIGHGUI': args.modules.contains('highgui') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMGCODECS': args.modules.contains('imgcodecs') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMGPROC': args.modules.contains('imgproc') ? 'ON' : 'OFF',
    'DARTCV_WITH_ML': args.modules.contains('ml') ? 'ON' : 'OFF',
    'DARTCV_WITH_OBJDETECT': args.modules.contains('objdetect') ? 'ON' : 'OFF',
    'DARTCV_WITH_PHOTO': args.modules.contains('photo') ? 'ON' : 'OFF',
    'DARTCV_WITH_STITCHING': args.modules.contains('stitching') ? 'ON' : 'OFF',
    'DARTCV_WITH_VIDEO': args.modules.contains('video') ? 'ON' : 'OFF',
    'DARTCV_WITH_VIDEOIO': args.modules.contains('videoio') ? 'ON' : 'OFF',
    // Contrib modules
    'DARTCV_WITH_ARUCO': args.modules.contains('aruco') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMG_HASH': args.modules.contains('img_hash') ? 'ON' : 'OFF',
    'DARTCV_WITH_QUALITY': args.modules.contains('quality') ? 'ON' : 'OFF',
    'DARTCV_WITH_WECHAT_QRCODE': args.modules.contains('wechat_qrcode') ? 'ON' : 'OFF',
    'DARTCV_WITH_XIMGPROC': args.modules.contains('ximgproc') ? 'ON' : 'OFF',
    'DARTCV_WITH_XOBJDETECT': args.modules.contains('xobjdetect') ? 'ON' : 'OFF',
  };

  final builder = CMakeBuilder.create(
    logLevel: args.debug ? LogLevel.DEBUG : LogLevel.STATUS,
    appleArgs: const AppleBuilderArgs(enableArc: false, enableBitcode: false, enableVisibility: true),
    name: dartcvLibraryName,
    sourceDir: packagePath.uri.resolve("src"),
    targets: ['install'],
    buildLocal: false,
    generator: args.generator,
    parallelJobs: args.parallelJobs,
    defines: {
      if (args.appleDeploymentTarget != null) 'DEPLOYMENT_TARGET': args.appleDeploymentTarget,
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'BUILD_TIFF': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_TIFF': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'BUILD_OPENJPEG': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_OPENJPEG': 'OFF',
      'WITH_OPENCL': args.useOpenCL ? 'ON' : 'OFF',
      if (args.useOpenCL && targetOS == OS.macOS) 'WITH_OPENCLAMDBLAS': 'ON',
      if (args.useOpenCL && targetOS == OS.macOS) 'WITH_OPENCLAMDFFT': 'ON',
      if (!args.useOpenCL) 'WITH_OPENCLAMDBLAS': 'OFF',
      if (!args.useOpenCL) 'WITH_OPENCLAMDFFT': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_OPENCL_SVM': 'OFF',
      // 'FFMPEG_USE_STATIC_LIBS': 'OFF',
      if (args.opencvDir != null) ...{
        'DARTCV_BUILD_OPENCV_FROM_SOURCE': 'OFF',
        'DARTCV_DISABLE_DOWNLOAD_OPENCV': 'ON',
        'OpenCV_DIR': args.opencvDir,
      } else if (args.opencvVersion != null) ...{
        'DARTCV_BUILD_OPENCV_FROM_SOURCE': 'ON',
        'OPENCV_VERSION': args.opencvVersion,
      },
      'DARTCV_ENABLE_INSTALL': 'ON',
      'DARTCV_TREESHAKE': args.treeshake ? 'ON' : 'OFF',
      // The tree-shaken library is linked by `hook/link.dart`, which only runs
      // on AOT builds; a JIT (dev) build does not need the extra archive.
      'DARTCV_TREESHAKE_LINK': delegateToLinkHook ? 'ON' : 'OFF',
      'CMAKE_INSTALL_PREFIX': input.outputDirectory.resolve('install/').toFilePath(),
      'CMAKE_POLICY_VERSION_MINIMUM': '3.5',
      ...moduleDefines,
    },
  );
  await builder.run(input: input, output: output, logger: logger);

  final installDir = input.outputDirectory.resolve('install/');
  if (delegateToLinkHook) {
    // `hook/link.dart` links the final library with only the native symbols
    // this build's Dart code uses (`CMakeBuilder.runLink`). It also gets this
    // unrestricted library, so it can pass it through unchanged when the build
    // records no usages (SDKs without the `record-use` experiment, platforms
    // whose link hook is not given the recordings) or when the link fails.
    //
    // Located the same way as for a JIT build (`findCodeAssets` searches the
    // install tree for the library file name of the configured link mode), so
    // an unexpected layout or an unsatisfiable link mode skips the asset
    // instead of handing a non-existent file to the SDK.
    final assets = await output.findCodeAssets(
      input,
      outDir: installDir,
      names: {dartcvLibraryName: dartcvAssetName},
      logger: logger,
    );
    if (assets.isEmpty) {
      logger.warning(
        "[dartcv4] no ${input.config.code.linkModePreference} library for "
        "'$dartcvLibraryName' in $installDir; the package cannot be used by this build\n",
      );
    }
    for (final asset in assets) {
      output.assets.code.add(asset, routing: ToLinkHook(input.packageName));
    }
  } else {
    await output.findAndAddCodeAssets(
      input,
      outDir: installDir,
      names: {dartcvLibraryName: dartcvAssetName},
    );
  }

  final ffmpegLibs = {"avcodec", "avdevice", "avfilter", "avformat", "avutil", "swresample", "swscale"};
  String ffPattern(String lib) => '(?:lib)?$lib(?:.\\d+)?(?:\\.(?:so|dll|dylib))';
  if (args.modules.contains('highgui') || args.modules.contains('videoio')) {
    final r = await output.findAndAddCodeAssets(
      input,
      outDir: input.outputDirectory.resolve('install/'),
      names: {for (final lib in ffmpegLibs) ffPattern(lib): "$lib.dart"},
      regExp: true,
    );

    if (input.config.code.targetOS == OS.linux) {
      for (final lib in r) {
        await setRPath(lib.file!, name: r'$ORIGIN');
      }
    }

    // TODO: dartdev does not support adding FAT libraries yet.
    // https://github.com/dart-lang/sdk/issues/61130

    if (r.isEmpty) {
      logger.warning("FFMPEG libraries not found, please check your build configuration.");
    } else {
      final libFiles = r.map((e) => e.file!.toFilePath()).toList();
      logger.info("adding FFMPEG libraries: $libFiles");
    }
  }
}

/// Files the native build reads that Dart does not track on its own: the top-level CMakeLists, the
/// CMake modules and the C/C++ wrappers. `src/build/` is an artefact directory of manual builds, not
/// an input, so the two source directories are walked explicitly instead of the whole `src/`.
Iterable<Uri> _nativeSources(Uri srcDir) sync* {
  yield srcDir.resolve('CMakeLists.txt');
  for (final sub in ['cmake/', 'dartcv/']) {
    final dir = Directory.fromUri(srcDir.resolve(sub));
    if (!dir.existsSync()) continue;
    for (final file in dir.listSync(recursive: true).whereType<File>()) {
      yield file.uri;
    }
  }
}
