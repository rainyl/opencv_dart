// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import '../g_web/register.g.dart' as g;
import 'runtime.dart' as rt;

Future<void>? _loading;

/// Loads the dartcv WebAssembly module. Must be awaited once before any other dartcv call on the
/// web; on native platforms the library is loaded by the native-assets hooks and this does nothing.
///
/// [moduleUrl] is the URL of `dartcv.mjs` (resolved against the page's base URI); `dartcv.wasm`
/// is loaded from next to it.
Future<void> initDartcv({String moduleUrl = 'dartcv.mjs'}) => _loading ??= _load(moduleUrl);

Future<void> _load(String moduleUrl) async {
  final base = (globalContext['document'] as JSObject?)?['baseURI'] as JSString?;
  final url = base == null ? moduleUrl : Uri.parse(base.toDart).resolve(moduleUrl).toString();
  final mod = await importModule(url.toJS).toDart;
  final factory = mod['default']! as JSFunction;
  final instance = await (factory.callAsFunction()! as JSPromise<JSObject>).toDart;
  rt.setModule(instance);
  g.registerAll();
}
