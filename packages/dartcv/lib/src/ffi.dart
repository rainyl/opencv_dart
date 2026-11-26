// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// `dart:ffi` on native platforms, a wasm-backed stand-in on the web.
export 'dart:ffi' if (dart.library.js_interop) 'web/ffi.dart';
