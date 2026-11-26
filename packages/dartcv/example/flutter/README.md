# dartcv_example

A Flutter app that runs `dartcv4` on Windows, Linux, macOS, Android, iOS **and the web**.

Run it as usual from this directory:

```bash
flutter pub get
flutter run            # native: the native-assets hooks build dartcv + OpenCV
flutter run -d chrome  # web: needs `web/dartcv.js` + `web/dartcv.wasm`, see below
```

The app picks an image (or processes the bundled `images/lenna.png`), runs `cvtColor` +
`gaussianBlur` on it and shows the result next to `cv.getBuildInformation()`. On native platforms the
work runs in an isolate via `Isolate.run`; the web has no isolates, so the same function runs on the
calling thread with a smaller iteration count.

## Web

dartcv4 runs in the browser by compiling the same C wrapper and OpenCV to WebAssembly. The module is
not committed, so build it once and drop the two files next to `index.html` (they are gitignored):

```bash
# from packages/dartcv (the app depends on it by path)
dart tool/web/build_wasm.dart --modules imgproc,imgcodecs

cp build/web/dartcv.js build/web/dartcv.wasm example/flutter/web/
flutter run -d chrome
```

`--modules imgproc,imgcodecs` is enough for this app and keeps the download small (~5 MB instead of
~14 MB); `core` is always included. Building from this directory works too
(`dart run dartcv4:build_wasm`), but the native build hook would run first and build/download OpenCV
for no reason unless `hooks.user_defines.dartcv4.skip_build: true` is set in `pubspec.yaml` (which
would in turn stop `flutter run` on native platforms from building the library).

What changes on the web, in `lib/main.dart`:

- `await cv.initDartcv()` in `main()` loads the module before the first OpenCV call; it is a no-op on
  native platforms.
- The picked file is a `blob:` URL, so its bytes are decoded with `cv.imdecode` instead of `imread`.
- `Mat`s are disposed explicitly after use: the browser cannot see the wasm heap, so finalizers run
  late enough to matter.
