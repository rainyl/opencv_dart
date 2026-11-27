# dartcv4 lab

A Flutter app that runs `dartcv4` on Windows, Linux, macOS, Android, iOS **and the web**, built
around the parts that are easy to get wrong: image processing, video processing, the difference
between the synchronous and the worker-thread APIs, and what each failure looks like from Dart.

```bash
flutter pub get
flutter run            # native: the native-assets hooks build dartcv + OpenCV
flutter run -d chrome  # web: needs web/dartcv.js + web/dartcv.wasm, see below
flutter test           # the layout smoke test, no device needed
```

Four tabs, each in a card layout that reflows to a single column on a phone:

| tab | what it shows |
| --- | --- |
| **Images** | loads `images/lenna.png` (or a picked file) with `imdecode`, runs one of seven pipelines (grayscale, blur, Canny, threshold, CLAHE, mosaic, invert) next to the original, with wall time, caller-blocked time and the live-object count. The switch moves the same kernels between the UI isolate and the library's worker thread. |
| **Video** | draws 48 frames with `cv.line` / `cv.circle` / `cv.putText`, encodes them with `VideoWriter`, reads them back with `VideoCapture`, then plays them while a filter runs per frame; reports ms/frame and measured fps, and says so when the build has no video backend (the wasm module, or a build without FFmpeg). |
| **Sync/Async** | the same 900×900 Gaussian blur run three ways (synchronous, async awaited, async pipelined), a bar per mode, plus the worker count, `asyncPending()` and `asyncDrain()`. |
| **Errors** | one button per failure mode: an OpenCV error inside a job (`CvException` on the Future), a timeout (`AsyncTimeoutException` and its `completion`), a synchronous call racing a job (refused), a missing file (an empty `Mat`, not an exception), a bad argument, and a disposal/leak check. |

Two indicators make the sync/async difference visible rather than described: the **UI heartbeat**
(milliseconds between UI frames, so a blocking call leaves a spike) and the **sidebar pills** fed by
`liveObjectCount()`, `asyncPending()` and `getAsyncThreads()`.

## Web

`flutter run -d chrome` needs the wasm module next to the page:

```bash
# from packages/dartcv
dart tool/web/build_wasm.dart
cp build/web/dartcv.js build/web/dartcv.wasm example/flutter/web/
```

The app then loads it in `main()` via `initDartcv()`. On the web there are no threads, so the async
APIs return a `Future` but run on the calling thread, and `videoio` has no capture backends - the
video tab says so instead of failing silently.

## The `ui::AXTree` error log on Windows

`[ERROR:accessibility_bridge.cc] Failed to update ui::AXTree, error: Nodes left pending by the update: N`
come from the Flutter **Windows embedder**, not from this package: the semantics updates a scroll or a
rebuild produces arrive faster than the UIA tree can apply them, and the batch is dropped. The UI is
unaffected, but the log floods the console.

Measured with the same scripted scroll + rebuild load: 322 messages in 12 s with the accessibility tree
enabled, 1 with it excluded. The accessibility toggle in the top bar (`ExcludeSemantics`) defaults to
*off* on desktop for that reason - turn it on to see the difference.
