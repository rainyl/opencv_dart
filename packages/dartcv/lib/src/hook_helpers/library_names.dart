// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

/// Base name of the CMake library target and of the artifacts it installs
/// (`libdartcv.so` / `libdartcv.dylib` / `dartcv.dll`), and the name
/// `dntcm_add_treeshake_target` uses for its tree-shaken variant.
const dartcvLibraryName = 'dartcv';

/// Code asset the generated bindings load
/// (`@DefaultAsset('package:dartcv4/dartcv.dart')` in `lib/src/g/*.g.dart`).
const dartcvAssetName = 'dartcv.dart';
