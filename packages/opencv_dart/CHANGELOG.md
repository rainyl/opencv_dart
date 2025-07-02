## 1.4.2

* support optional modules, configure it in `pubspec.yaml`, from this version, both opencv_core and
  opencv_dart can enable/disable optional modules.
* added `approxPolyN`.

## 1.4.1

* add `VideoCapture.grabAsync`
* add `Mat.fromBuffer` to allow creating `Mat` from self-managed buffer
* add `copyData` parameter to `Mat.fromVec`
* remove `Mat.fromPtr`, merge it to `Mat.fromMat`
* add `Mat.atU8`, `Mat.setU8`, etc.
* remove deprecated `Mat.copyToWithMask`, `List<Mat>.asVecMat()`

## 1.4.0

* update to OpenCV 4.11.0
* change vector wrappers to std::vector
* fix reference of estimateAffinePartial2D
* support `VideoWriter.get()` and `VideoWriter.set()`
* use native implementation of 8U/8S -> F16 for `cv.LUT()`
* make `VecVecChar` unmodifible
* more tests
* add more functions in `calib3d`
* make the version of `dartcv4` fixed

## 1.3.3

* Fix example link in readme
* [Android] Support 16KB Page Size
* Fix: `minEnclosingCircle`
* Fix: requested object not found in `glob_rec`
* Exclude system paths from search paths in `ffmpeg-config.cmake`
* bump dartcv to 4.10.0.5
* bump opencv to 4.10.0+10

## 1.3.2

* Fix: minEnclosingCircle
* hide highgui from building, cache options
* [Android] Remove debug info in release build to reduce package size
* bump DartCvIOS and DartCvMacOS to 4.10.0.4, remove `-Wl,-ld_classic` for ios and macos

## 1.3.1

* breaking change: hide `highgui`
* bump DartCvMacOS and DartCvIOS to 4.10.0.3, conditionally add link option `-ld_classic`

## 1.3.0

* breaking change: local build. Will download opencv sdk (~100M) from remote, set `DARTCV_CACHE_DIR` to cache it and avoid downloading in every build.
* breaking change: many async class constructors and getters/setters were removed.
* Breaking change: highgui, remove Window and Trackbar class, use functions like opencv c++ and python directly, e.g., cv.namedWindow("TestWindow"), more examples refer to: https://github.com/rainyl/opencv_dart/blob/split-dartcv/packages/dartcv/test/highgui_test.dart
* macos: support 10.15 and above
* android: API level 24 and above
* ios: 12.0 and above
* support custom linked ffmpeg 6.1 for windows, linux, android, macos
* add DartCvMacOS dependency for macos
* add DartCvIOS for ios
* move all dart code to independent plugin `dartcv4`
* bump dartcv to 1.0.1
* add `cv.Mat.fromMat`

## 1.2.5

* add quality module by @rainyl in https://github.com/rainyl/opencv_dart/pull/239
* Bump ffigen from 13.0.0 to 14.0.0 by @dependabot in https://github.com/rainyl/opencv_dart/pull/242
* Cmake install to platform dir by @rainyl in https://github.com/rainyl/opencv_dart/pull/243
* fix: [iOS] opencv_dart framework is missing MinimumOSVersion #246 by @rainyl in https://github.com/rainyl/opencv_dart/pull/247
* do not dispose vec in Mat.fromVec by @rainyl in https://github.com/rainyl/opencv_dart/pull/250

## 1.2.4

* change `Mat.toString()` to return something like `Mat(addr=0x1dde02c74b0, type=CV_8UC4, rows=-1, cols=-1, channels=4)` by @rainyl in https://github.com/rainyl/opencv_dart/pull/233
* migrate build toolchain from `conan` to `cmake` by @rainyl in https://github.com/rainyl/opencv_dart/pull/234
* add `cv.floodFill` and `cv.floodFillAsync` by @rainyl in https://github.com/rainyl/opencv_dart/pull/236
* move `findHomography` to `calib3d` by @rainyl in https://github.com/rainyl/opencv_dart/pull/236

## 1.2.3

* fix: android build.gradle task by @einsitang in https://github.com/rainyl/opencv_dart/pull/226
* fix: vector conversion by @rainyl in https://github.com/rainyl/opencv_dart/pull/229
* remove the dependency of flutter

## 1.2.2

* remove arm64 and x64 setup options for ios by @rainyl in https://github.com/rainyl/opencv_dart/pull/202
* rename factory VideoWriter.open to VideoWriter.fromFile, add apiPreference option for VideoWriter by @rainyl in https://github.com/rainyl/opencv_dart/pull/203
* check libs for android by @rainyl in https://github.com/rainyl/opencv_dart/pull/210
* Android Plugin custom arch support by @einsitang in https://github.com/rainyl/opencv_dart/pull/211
* use `setRange` for Vec, optimize operator [] by @rainyl in https://github.com/rainyl/opencv_dart/pull/215
* add `asVec()` to List extensions for better Vec and List interop by @rainyl in https://github.com/rainyl/opencv_dart/pull/222

## 1.2.1

- use ndk from conan by @rainyl in https://github.com/rainyl/opencv_dart/pull/187
- add Float16P, Float16List, impl float16 access for Mat by @rainyl in https://github.com/rainyl/opencv_dart/pull/189
- export Mat properies as leaf functions by @rainyl in https://github.com/rainyl/opencv_dart/pull/191
- use Mat::Ptr in Mat.ptrAt by @rainyl in https://github.com/rainyl/opencv_dart/pull/193

## 1.2.0

- Many breaking changes in this version, keep using old version if you do not want to modify your code.
- Split to multiple libraries by @rainyl in https://github.com/rainyl/opencv_dart/pull/147
- refactor vector wrappers by @rainyl in https://github.com/rainyl/opencv_dart/pull/155
- deprecate copyToWithMask, use copyTo(Mat img, {Mat? mask}) instead by @rainyl in https://github.com/rainyl/opencv_dart/pull/157
- support fp16 by @rainyl in https://github.com/rainyl/opencv_dart/pull/158
- add getBackendName() for VideoCapture by @rainyl in https://github.com/rainyl/opencv_dart/pull/161
- support create Mat from VecU8, etc. by @rainyl in https://github.com/rainyl/opencv_dart/pull/162
- fix: Better mat format/print #156 by @rainyl in https://github.com/rainyl/opencv_dart/pull/163
- added from list by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/165
- fix imencode interface by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/168
- fix Mat.size is not correct #170 by @rainyl in https://github.com/rainyl/opencv_dart/pull/171
- logging interface by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/175
- optimize Rng, remove unnecessay async by @rainyl in https://github.com/rainyl/opencv_dart/pull/176
- update version to use enabled vulkan version by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/178
- refactor Mat.at, Mat.set, Mat.ptrAt by @rainyl in https://github.com/rainyl/opencv_dart/pull/172
- improve divide tests by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/181
- updated functions to pass all params by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/182
- bump ffigen to 13.0.0 by @rainyl in https://github.com/rainyl/opencv_dart/pull/183
- add more methods to Mat, more test, add cv.sqrt, cv.sum by @rainyl in https://github.com/rainyl/opencv_dart/pull/185
- added more tests by @abdelaziz-mahdy in https://github.com/rainyl/opencv_dart/pull/186

## 1.1.0+1

- Fix: download wrong binaries on `windows` and `linux`, other platforms are not affected.

## 1.1.0

- Breaking Change: Asynchronous support, APIs ended with `Async` support asynchronous call.
- Breaking Change: `Rng.uniform,gaussian,next` returns a `Stream` now, [#135](https://github.com/rainyl/opencv_dart/pull/135)
- Breaking Change: delete `xdata` of Mat, Make `Mat.fromList` copy data internally to avoid extra data management, now it will copy the input data 2 times
- Breaking Change: `class MatType` -> `extension type const MatType(int value)`
- remove the dependency of `equatable`
- New: `ximgproc` and `xobjdetect` modules.
- `(int, int).toSize(Arena arena)` -> `(int, int).asSize`
- `(int, int).toPoint(Arena arena)` -> `(int, int).asPoint`
- `(double, double, double, double).toScalar(Arena arena)` -> `(double, double, double, double).asScalar`
- New: `Mat.fromRange`
- New: `Point3i`, `VecPoint3i`
- remove `BlockMeanHash.compareS`, `BlockMeanHash.computeS`
- remove `FaceRecognizerSF.newRecognizer`
- More info at: [#143](https://github.com/rainyl/opencv_dart/discussions/143)

## 1.1.0-dev.1

- New: EXPERIMENTAL Asynchronous support by @abdelaziz-mahdy and @rainyl, try it and open an issue if you have any problems.

## 1.0.10+1

- Fix: setup commands error on linux

## 1.0.10

- Fix: memory leak caused by cvstatus

## 1.0.9

- Fix: free smart pointer

## 1.0.8

- API change: `FaceRecognizerSF.feature(Mat alignedImg)` -> `FaceRecognizerSF.feature(Mat alignedImg, {bool clone = false})`
- Deprecated: `FaceRecognizerSF.newRecognizer` `FaceRecognizerSF.DIS_TYPR_FR_COSINE` `FaceRecognizerSF.DIS_TYPE_FR_NORM_L2`

## 1.0.7

- Add: FaceDetectorYN, FaceDetectorSF
- Add: Mat.dataPtr to allow get raw data pointer
- update lint rules and format

## 1.0.6+1

- Fix: auto setup

## 1.0.6

- Upgrade to OpenCV 4.10.0
- VecUChar.toU8List() return a copy of data rather than a view
- Better Auto setup, support universal ios framework (x86_64 and arm64)

## 1.0.5+1

- Optimize Vectors
- Fix: free cExt before exception in cv.imencode
- Add data getter for Vec<int,uchar,chat,float,double>, cache type of Mat
- Make auto setup build locally, set `OPENCV_DART_DISABLE_AUTO_BUILD` to disable auto setup and run
setup commands as before, read more in [README](https://github.com/rainyl/opencv_dart/blob/main/README.md)

## 1.0.5

- Auto setup by @abdelaziz-mahdy, from v1.0.5, libs will be downloaded automatically during build, i.e., no need to run setup commands
- Improve performance and optimize memory consumption
- Add `dispose()` methods to allow manual free native resources
- Better exception for cv.imencode
- Add more API for objdetect module

## 1.0.4

- Fix: Stitcher.composePanorama
- Fix: pyrDown/Up border type, BORDER_CONSTANT -> BORDER_DEFAULT
- New API: cv.Subdiv2D
- New API: cv.LUT
- improve performance of Mat.at() and Mat.set()
- Add: Mat.aU8(), Mat.setU8(), etc.

## 1.0.3+2

- fix: change the default border type of pyrDown/pyrUp to BORDER_DEFAULT, same as opencv

## 1.0.3+1

- fix: Stitcher.composePanorama

## 1.0.3

- New API: Mat::ptr -> Mat.ptrAt
  - ffi.Pointer\<T\> Mat.ptrAt\<T extends ffi.NativeType\>(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.UnsignedChar> Mat.ptrU8(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.Char> ptrI8(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.UnsignedShort> ptrU16(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.Short> ptrI16(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.Int> ptrI32(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.Float> ptrF32(int i0, [int? i1, int? i2])
  - ffi.Pointer<ffi.Double> ptrF64(int i0, [int? i1, int? i2])

## 1.0.2+2

- Fix: update archive version to 3.5.1
- Minor change: change cache, .cache -> .dart_tool/.cache
- Minor change: setup script, use cache, add -f flag to force download

## 1.0.2+1

- Fix: setup script will exit before files are really written to disk

## 1.0.2

- API change: (Mat mean, Mat stdDev) meanStdDev(InputArray src, {OutputArray? mean, OutputArray? stdDev}) => (Scalar mean, Scalar stddev) meanStdDev(InputArray src, {InputArray? mask})
- New: Mat.stdDev(), Mat.variance()
- New: Scalar operator +, -, *, /, sqrt(), pow(int n)

## 1.0.1

- API change: cv.Mat.fromScalar(Scalar s, MatType type, {int rows = 1, int cols = 1}) -> (int rows, int cols, MatType type, Scalar s)
- API change: cv.VideoCapture.getProp(int propId) -> cv.VideoCapture.get(int propId), cv.VideoCapture.setProp(int propId, double value) -> cv.VideoCapture.get(int propId, double value)
- New API: cv.VideoCapture.openIndex
- New module: wechat_qrcode
- Include ffmpeg.dll for windows

## 1.0.0+1

- Replace Finalizer with ffi.NativeFinalizer
- update Mat.toList(), Mat.toList3d<T, P>(), remove Mat.toList4D()
- update Mat.data, now return a view of data pointer, same as v0.6.*
- fix memory leak caused by Finalizer, now GC will also be triggered correctly in pure dart

## 1.0.0

- Refactor nearly all APIs, this version is NOT compitable with previous versions!.
- better exceptions, more concise API

## 0.6.7

- add `img_hash` from opencv contrib, contributed by @mdeleau
- since this version, old APIs will not get any updates from maintainer, please update to v1.0.0 if possible.

## 0.6.6

- add `cv.invertAffineTransform`
- remove net.forwardAsync
- add ios version info

## 0.6.5

- :tada: IOS supported now, tested on simulator, try it!
- fix ios dynamic library loading

## 0.6.4

- this is a minor version and no functional code changes
- speed up download and extract
- change build system to conan
- remove submodules to clean up structure

## 0.6.3

- add support for macOS with Apple Silicon

## 0.6.2

- add support for macos x64

## 0.6.1

- add `stitching` module, for now, cv::Stitcher implemented

## 0.6.0

- add `dnn` module
- add more friendly error message, use `cv.registerErrorCallback();` before potential error occurring.
- change return shape of `Mat.toList()` from `(cols, rows)` to `(rows, cols)`

## 0.5.0

- add `asyncarray`
- add `calib3d` module

## 0.4.0

- :rocket: add support for `photo` module

## 0.3.0

- Please use 0.3.0 or later, tested for android, linux, and windows

## 0.2.0

- :tada: add android `arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64` prebuild binaries, e.g., `dart run opencv_dart:setup -p android -a arm64-v8a` to download prebuilt binaries for android arm64-v8a

## 0.1.0

- Finished: test for aruco, features2d, video module
- :tada: this package is STABLE now! :rocket: check API reference for more details
- more examples and docs are on the way

## 0.0.4

- adjust prebuilt binaries distribution, use `dart run opencv_dart:setup` to download prebuilt binaries
- Finished: test for imgproc module
- Finished: test for Linux

## 0.0.3

- more test for imgproc module

## 0.0.3-dev.0

- Finished: test for core module
- Minor changes for Mat

## 0.0.2

- Implemented: imgproc, imgcodecs, core, video, need to be tested!
- add example

## 0.0.1

- Initial Release
- Implemented: imgproc, imgcodecs, core, video, need to be tested!
