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
