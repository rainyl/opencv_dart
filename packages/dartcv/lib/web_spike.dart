// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

/// Spike: one public surface, two backends. On the VM this is the existing dart:ffi API;
/// under dart2js/dart2wasm it is the Emscripten build of the same C wrapper.
library;

export 'src/web/slice_native.dart' if (dart.library.js_interop) 'src/web/slice_web.dart';
