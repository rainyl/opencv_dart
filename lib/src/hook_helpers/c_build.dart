// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:native_assets_cli/code_assets_builder.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

const sourceMap = {
  "core": [
    "src/dartcv/core/core.cpp",
    "src/dartcv/core/exception.cpp",
    "src/dartcv/core/logging.cpp",
    "src/dartcv/core/mat.cpp",
    "src/dartcv/core/stdvec.cpp",
    "src/dartcv/core/svd.cpp",
    "src/dartcv/core/utils.cpp",
    "src/dartcv/core/version.cpp",
  ],
  "calib3d": [
    "src/dartcv/calib3d.cpp",
  ],
  "contrib": [
    "src/dartcv/contrib/aruco.cpp",
    "src/dartcv/contrib/img_hash.cpp",
    "src/dartcv/contrib/quality.cpp",
    "src/dartcv/contrib/wechat_qrcode.cpp",
    "src/dartcv/contrib/ximgproc.cpp",
    "src/dartcv/contrib/xobjdetect.cpp",
  ],
  "dnn": [
    "src/dartcv/dnn/dnn.cpp",
  ],
  "features2d": [
    "src/dartcv/features2d/features2d.cpp",
  ],
  "highgui": [
    "src/dartcv/highgui/highgui.cpp",
  ],
  "imgcodecs": [
    "src/dartcv/imgcodecs/imgcodecs.cpp",
  ],
  "imgproc": [
    "src/dartcv/imgproc/imgproc.cpp",
  ],
  "objdetect": [
    "src/dartcv/objdetect/objdetect.cpp",
  ],
  "photo": [
    "src/dartcv/photo/photo.cpp",
  ],
  "stitching": [
    "src/dartcv/stitching/stitching.cpp",
  ],
  "video": [
    "src/dartcv/video/video.cpp",
  ],
  "videoio": [
    "src/dartcv/videoio/videoio.cpp",
  ],
};

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {List<String>? optionalModules}) async {
  Logger("").warning("AAAAAAA");
  optionalModules ??= [
    "calib3d",
    "contrib",
    "dnn",
    "features2d",
    "highgui",
    "imgcodecs",
    "imgproc",
    "objdetect",
    "photo",
    "stitching",
    "video",
    "videoio",
  ];
  final List<String> sourceFiles = sourceMap.entries
      .where((entry) => optionalModules!.contains(entry.key))
      .expand((entry) => entry.value)
      .toList();
  Logger("").warning(sourceFiles);
  final name = createTargetName(
    input.config.code.targetOS.name,
    input.config.code.targetArchitecture.name,
    input.config.code.targetOS == OS.iOS ? input.config.code.iOS.targetSdk.type : null,
  );
  final cbuilder = CBuilder.library(
    name: name,
    assetName: 'dartcv.dart',
    language: Language.cpp,
    sources: sourceFiles,
  );
  await cbuilder.run(
    input: input,
    output: output,
    logger: Logger('')
      ..level = Level.ALL
      ..onRecord.listen((record) => print(record.message)),
  );
}

String createTargetName(String osString, String architecture, String? iOSSdk) {
  var targetName = 'dartcv_${osString}_$architecture';
  if (iOSSdk != null) {
    targetName += '_$iOSSdk';
  }
  return targetName;
}
