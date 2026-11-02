// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// Spike: the native side of the conditional export in lib/web_spike.dart. It re-exports the
// existing dart:ffi API, so code written against the slice runs unchanged on the VM.

export '../../dartcv.dart' show Mat, MatType, cvtColor, cvtColorAsync, gaussianBlur, imdecode, imencode;
export '../g/constants.g.dart' show COLOR_BGR2GRAY, IMREAD_COLOR, IMREAD_UNCHANGED;

/// No-op on native: the library is loaded lazily by `@ffi.Native`.
Future<void> initDartcv() async {}
