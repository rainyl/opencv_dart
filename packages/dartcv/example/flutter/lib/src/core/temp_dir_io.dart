// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:io';

/// A fresh directory for the demo's temporary video. `videoio` needs a real file path.
String temporaryVideoPath(String name) {
  final dir = Directory.systemTemp.createTempSync('dartcv_demo_');
  return '${dir.path}${Platform.pathSeparator}$name';
}
