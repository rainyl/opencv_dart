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
