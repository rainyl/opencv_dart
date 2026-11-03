// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

/// Loads the dartcv WebAssembly module. Must be awaited once before any other dartcv call on the
/// web; on native platforms the library is loaded by the native-assets hooks and this does nothing.
///
/// [moduleUrl] is the URL of `dartcv.mjs` (resolved against the page's base URI); `dartcv.wasm`
/// is loaded from next to it.
Future<void> initDartcv({String moduleUrl = 'dartcv.mjs'}) async {}
