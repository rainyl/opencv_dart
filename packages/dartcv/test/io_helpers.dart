// Files a web test needs but a browser cannot reach through dart:io: `dart:io` natively,
// Emscripten's in-memory file system on the web (which the C side's `FileStorage` and
// `cv::imread`/`cv::imwrite` use as well). Exporting a conditional library keeps the test files
// themselves free of `dart:io`, so they also compile for the browser.
export 'io_helpers_io.dart' if (dart.library.js_interop) 'io_helpers_web.dart';
