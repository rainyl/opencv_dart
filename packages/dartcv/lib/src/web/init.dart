// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import '../package_version.dart';
import 'g/register.g.dart' as g;
import 'runtime.dart' as rt;

Future<void>? _loading;

/// Loads the dartcv WebAssembly module. Must be awaited once before any other dartcv call on the
/// web; on native platforms the library is loaded by the native-assets hooks and this does nothing.
///
/// [moduleUrl] is the URL of `dartcv.js` (resolved against the page's base URI); `dartcv.wasm`
/// is loaded from next to it.
Future<void> initDartcv({String moduleUrl = 'dartcv.js'}) async {
  final pending = _loading;
  if (pending != null) {
    await pending;
    return;
  }
  final started = _load(moduleUrl);
  _loading = started;
  try {
    await started;
  } catch (_) {
    // Do not cache a failed load: the caller may retry, e.g. with another moduleUrl.
    if (identical(_loading, started)) _loading = null;
    rethrow;
  }
}

Future<void> _load(String moduleUrl) async {
  final base = (globalContext['document'] as JSObject?)?['baseURI'] as JSString?;
  final url = base == null ? moduleUrl : Uri.parse(base.toDart).resolve(moduleUrl).toString();
  final mod = await importModule(url.toJS).toDart;
  _checkModuleVersion(mod, url);
  final factory = mod['default']! as JSFunction;
  final instance = await (factory.callAsFunction()! as JSPromise<JSObject>).toDart;
  rt.setModule(instance);
  g.registerAll();
}

/// The build tool stamps the module with the `dartcv4` version it was built from
/// (`export const dartcvVersion`), and a `dartcv.js` left over from another release is reported
/// here - before the 96 MB module is instantiated - because the ABI it was built against may differ.
///
/// A warning, not an error: pinning a patch level is a normal thing to do, and refusing to start
/// would take a working app down. A module without the stamp predates this check and is accepted
/// silently.
void _checkModuleVersion(JSObject module, String url) {
  final reported = module['dartcvVersion'];
  if (reported == null || !reported.isA<JSString>()) return;
  final version = (reported as JSString).toDart;
  if (version == packageVersion) return;
  // ignore: avoid_print - on the web `print` is the console; there is no logging dependency here.
  print(
    'dartcv4: warning: $url was built by dartcv4 $version, but this app uses $packageVersion. '
    'Rebuild it with `dart run dartcv4:build_wasm` (or copy the pair from the dartcv4 '
    '$packageVersion release) if calls misbehave.',
  );
}
