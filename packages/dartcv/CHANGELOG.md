# dartcv

## 2.2.1+1

- fix: CMake definitions are not correctly passed when building ios

## 2.2.1

- support setting custom cmake generator
- fix: Skip native build hook for web builds
- new: support enumerating videoio backends

## 2.2.0

- breaking change: support building from opencv source code, it's now the default behavior, since this version, prebuilt opencv static binary is no longer included.
- bump opencv version to `4.13.0`
- NOTE: opencv `4.12.0` is the last version that provides prebuilt static binary.
- breaking change: change default include modules to `imgcodecs` `imgproc`.
- breaking change: change default excluded modules to `calib3d` `dnn` `features2d` `flann` `freetype` `highgui` `objdetect` `photo` `stitching` `video` `videoio` `aruco` `img_hash` `quality` `wechat_qrcode` `ximgproc` `xobjdetect`
- breaking change: since this version, FFMPEG is no longer included.

## 2.1.1

- add: OpenCL functions, allow to disable OpenCL

## 2.1.0+1

- fix: C++ src not included

## 2.1.0

- NOTE: Breaking change.
- The minimum required dart sdk version is 3.10 that supports hooks (Native-Assets) stable.
- add `stackBlur` function in `imgproc` module.
- Breaking change: default included models:  `calib3d`,`features2d`,`imgcodecs`,`imgproc`,`objdetect`,`photo`,`stitching`, default excluded modules:`contrib`,`freetype`,`highgui`,`video`,`videoio`,`dnn`.

## 2.1.0-dev.3

- bump dependencies
- add `UMat`
- [features2d] add more functions/constructions
- add custom loggers, support user-defined logger callback
- add `cv.freetype` module

## 2.1.0-dev.2

- add `Mat.reinterpret`
- add `fisheye.solvePnPRansac`, support `mask` for `cv.threshold`
- add `StereoBM`, `StereoSGBM` from `calib3d` module

## 2.1.0-dev.1

- sync main branch, now support all methods in `dartcv v1.1.6`
- :tada: this version supports windows, linux, macos, android and ios, for platforms except ios, ffmpeg is also supported.

## 2.1.0-dev.0

- Many breaking changes in this version, keep using old version if you do not want to modify your code.
- use Mat::ptr directly in Mat.ptrAt
- faster Mat.atVec
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
- Fix: download wrong binaries on `windows` and `linux`, other platforms are not affected.
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

## 2.0.0-dev.12

- Fix: memory leak caused by cvstatus

## 2.0.0-dev.11

- Fix: free smart pointer

## 2.0.0-dev.10

- API change: `FaceRecognizerSF.feature(Mat alignedImg)` -> `FaceRecognizerSF.feature(Mat alignedImg, {bool clone = false})`
- Deprecated: `FaceRecognizerSF.newRecognizer` `FaceRecognizerSF.DIS_TYPR_FR_COSINE` `FaceRecognizerSF.DIS_TYPE_FR_NORM_L2`

## 2.0.0-dev.9

- Add: FaceDetectorYN, FaceDetectorSF
- Add: Mat.dataPtr to allow get raw data pointer
- update lint rules and format
- Upgrade to OpenCV 4.10.0
- VecUChar.toU8List() return a copy of data rather than a view
- Better Auto setup, support universal ios framework (x86_64 and arm64)
- Optimize Vectors
- Fix: free cExt before exception in cv.imencode
- Add data getter for Vec<int,uchar,chat,float,double>, cache type of Mat

## 2.0.0-dev.8

- Auto setup by @abdelaziz-mahdy, from v1.0.5, libs will be downloaded automatically during build, i.e., no need to run setup commands
- Improve performance and optimize memory consumption
- Add `dispose()` methods to allow manual free native resources
- Better exception for cv.imencode
- Add more API for objdetect module

## 2.0.0-dev.7

- Fix: Stitcher.composePanorama
- Fix: pyrDown/Up border type, BORDER_CONSTANT -> BORDER_DEFAULT
- New API: cv.Subdiv2D
- New API: cv.LUT
- improve performance of Mat.at() and Mat.set()
- Add: Mat.aU8(), Mat.setU8(), etc.

## 1.1.8

* bump dependencies
* add `UMat`
* [features2d] add more functions/constructions
* add custom loggers, support user-defined logger callback
* add `cv.freetype` module

## 1.1.7

* add `Mat.reinterpret`
* add `fisheye.solvePnPRansac`, support `mask` for `cv.threshold`
* add `StereoBM`, `StereoSGBM` from `calib3d` module

## 1.1.6

* add `FlannIndexParams`, `FlannSearchParams`, `FlannKDTreeIndexParams`
* add `FlannBasedMatcher.create`
* bump opencv to 4.12.0

## 1.1.5

* added `approxPolyN`.
* add more high-precision functions (`arcLength2f`, etc.) to `imgproc` module, https://github.com/rainyl/opencv_dart/pull/364
* breaking change: optional arg `hierarchy` of `drawContours` now change from `Mat` to `VecVec4i` type.

## 1.1.4

* remove deprecated `MatType.toInt()`, should use MatType.value instead
* add `MatType.elemSize` `MatType.elemSize1`
* remove deprecated `(double x, double y, double z).asPoint3f`
  `(double x, double y).asPoint2f` `(int x, int y).asPoint` `VecPoint.toVecVecPoint`
* add `bin/gen_cmake_vars.dart` for generating optional module vars for CMake

## 1.1.3

* add `VideoCapture.grabAsync`
* add `Mat.fromBuffer` to allow creating `Mat` from self-managed buffer
* add `copyData` parameter to `Mat.fromVec`
* remove `Mat.fromPtr`, merge it to `Mat.fromMat`
* add `Mat.atU8`, `Mat.setU8`, etc.
* remove deprecated `Mat.copyToWithMask`, `List<Mat>.asVecMat()`

## 1.1.2

* add more functions in `calib3d`

## 1.1.1

* make `VecVecChar` unmodifible
* more tests

## 1.1.0

* update to OpenCV 4.11.0
* change vector wrappers to std::vector
* fix reference of estimateAffinePartial2D
* support `VideoWriter.get()` and `VideoWriter.set()`
* use native implementation of 8U/8S -> F16 for `cv.LUT()`

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
