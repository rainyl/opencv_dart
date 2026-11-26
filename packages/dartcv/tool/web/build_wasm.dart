// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// The wasm build tool lives in `bin/build_wasm.dart`, so an application that depends on dartcv4 can
// run it as `dart run dartcv4:build_wasm`; this is the entry point this package's docs, CI and tests
// use from a checkout. Both are the same code.

import '../../bin/build_wasm.dart' as tool;

Future<void> main(List<String> args) => tool.main(args);
