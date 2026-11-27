// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

/// Emscripten's in-memory file system: a path is just a key, nothing touches the user's disk.
String temporaryVideoPath(String name) => '/tmp/$name';
