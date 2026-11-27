# dartcv4 lab

A Flutter app that exercises the parts of `dartcv4` that are easy to get wrong: image processing,
video processing, the difference between the synchronous and the worker-thread APIs, and what each
failure looks like from Dart.

```bash
flutter pub get
flutter run                 # desktop / mobile
flutter run -d chrome       # web, after copying dartcv.js + dartcv.wasm into web/ (see below)
flutter test                # the layout smoke test, no device needed
```

Four tabs, each split into a card-based layout that reflows to a single column on a phone:

| tab | what it shows |
| --- | --- |
| **Images** | loads `images/lenna.png` (or a picked file) with `imdecode`, runs one of seven pipelines (grayscale, blur, Canny, threshold, CLAHE, mosaic, invert) and shows the result next to the original, with wall time, caller-blocked time and the live-object count. The switch moves the same kernels between the UI isolate and the library's worker thread. |
| **Video** | draws 48 frames with `cv.line` / `cv.circle` / `cv.putText`, encodes them with `VideoWriter`, reads them back with `VideoCapture`, then plays them while a filter runs per frame. Reports ms/frame and measured fps, and degrades gracefully when the build has no video backend (the wasm module, or a desktop build without FFmpeg). |
| **Sync/Async** | the same 900×900 Gaussian blur run three ways (synchronous, async awaited, async pipelined), with a bar per mode, the worker count, `asyncPending()` and `asyncDrain()`. |
| **Errors** | one button per failure mode: an OpenCV error inside a job (`CvException` on the Future), a timeout (`AsyncTimeoutException` and its `completion`), a synchronous call racing a job (refused), a missing file (an empty `Mat`, not an exception), a bad argument, and a disposal/leak check. |

Two things to watch while clicking around:

- **the UI heartbeat** at the bottom of each lab: milliseconds between UI frames. A synchronous call
  leaves a tall spike, the async twin leaves it flat.
- **the pills in the sidebar**: wrapped C++ objects alive, async jobs queued or running, worker
  threads. They come straight from `liveObjectCount()`, `asyncPending()` and `getAsyncThreads()`.

## Running against this checkout

The example depends on the published `opencv_dart`. To try the APIs on this branch (the async pool,
`AsyncTimeoutException`, the race detection), add the override the CI web job also uses:

```bash
printf 'dependency_overrides:\n  dartcv4:\n    path: ../../dartcv\n' > pubspec_overrides.yaml
flutter pub get
```

## Web

`flutter run -d chrome` needs the wasm module next to the page:

```bash
# from packages/dartcv
dart tool/web/build_wasm.dart
cp build/web/dartcv.js build/web/dartcv.wasm ../opencv_dart/example/web/
```

Then the app loads `dartcv.js` in `main()` via `initDartcv()`. On the web there are no threads, so the
async APIs return a `Future` but run on the calling thread, and the video tab cannot use `videoio`:
both are pointed out in the UI rather than failing silently.

## The `ui::AXTree` error log on Windows

`[ERROR:accessibility_bridge.cc] Failed to update ui::AXTree, error: Nodes left pending by the update: N`
come from the Flutter **Windows embedder**, not from this package: the semantics updates a scroll or a
rebuild produces arrive faster than the UIA tree can apply them, and the batch is dropped. The UI is
unaffected, but the log floods the console.

Measured with the same scripted scroll + rebuild load: 322 messages in 12 s with the accessibility tree
enabled, 1 with it excluded. The accessibility toggle in the top bar (`ExcludeSemantics`) defaults to
*off* on desktop for that reason - turn it on to see the difference.
