// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// A path the demo may write a temporary video to. Native platforms use the system temp directory;
// the web build writes into Emscripten's in-memory file system instead, so the same code compiles.
export 'temp_dir_io.dart' if (dart.library.js_interop) 'temp_dir_web.dart';
