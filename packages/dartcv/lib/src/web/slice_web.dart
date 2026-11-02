// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// Spike: the web side of the conditional export in lib/web_spike.dart.

export 'mat.dart';

// lib/src/g/constants.g.dart is pure constants but imports dart:ffi (ffigen boilerplate),
// which dart2js/dart2wasm reject, so the slice redeclares the few it needs. A real port would
// generate constants.g.dart without that import.
const int COLOR_BGR2GRAY = 6;
const int IMREAD_COLOR = 1;
const int IMREAD_UNCHANGED = -1;
