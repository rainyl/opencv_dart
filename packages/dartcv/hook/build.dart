// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// NOTE: the dart native-assets build cache is keyed on the CONTENT of this
// file. After changing any native source (C/C++/CMake), modify this file (e.g.
// append a comment line) to force the hooks to recompile.

import 'package:dartcv4/src/hook_helpers/run_build.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    await runBuild(input, output);
  });
}
