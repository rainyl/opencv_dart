# Contributing

- [Contributing](#contributing)
  - [Contribute new modules](#contribute-new-modules)
  - [Contribute to Documentation](#contribute-to-documentation)
  - [Contribute to Testing](#contribute-to-testing)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

## Contribute new modules

If you want to add new opencv API/Module,

1. take a look at OpenCV official documents and make sure the required functions/modules are absent in opencv_dart
2. the native C/C++ code is managed by CMake, you will find a `CMakeLists.txt` in `packages/dartcv/src`
3. add new C wrappers in `packages/dartcv/src/dartcv` and make sure it is correctly build, Note: 
  - take a look at the existed code, especially `packages/dartcv/src/dartcv/core/types.h` which defines basic structures
  - if you want to add new modules, create a new directory in `packages/dartcv/src/dartcv`, e.g., `packages/dartcv/src/dartcv/cuda`
  - nearly all C-wrappers of C++ class/struct are wrapped in a struct, you can define a C wrapper of a C++ class via `CVD_TYPEDEF`, e.g., `CVD_TYPEDEF(cv::Mat, Mat)`
4. add your `.h` file to ffigen in [dartcv4](https://github.com/rainyl/opencv_dart/tree/main/packages/dartcv/ffigen) and run `dart run ffigen --config ffigen.yaml`， this will generate corresponding dart:ffi wrappers.
5. add corresponding dart code in [lib](https://github.com/rainyl/opencv_dart/tree/main/packages/dartcv/lib)
6. write testing code and test whether it works as expected, you can refer to [OpencvSharp](https://github.com/shimat/opencvsharp) and [gocv](https://github.com/hybridgroup/gocv) to write tests. 

~~Note: C wrappers should be added to [dartcv](https://github.com/rainyl/dartcv) and dart bindings should be added to [dartcv4](https://github.com/rainyl/opencv_dart/tree/main/packages/dartcv)~~
Since `2.x`, C/C++ code are embeded to this (opencv_dart) repo and no longer needed to develop separetely, just implement your C/C++ code in `packages/dartcv/src/dartcv` and it will be processed by dart native hooks.

## Contribute to Documentation

1. `git clone https://github.com/rainyl/opencv_dart`
2. open project in IDE and write doc strings above functions and classes in source codes.
3. follow the dart documentation recommendations, https://dart.dev/effective-dart/documentation

## Contribute to Testing

For Windows:

1. `git clone https://github.com/rainyl/opencv_dart`
2. cd `opencv_dart/packages/dartcv`
3. install dependencies via `dart pub get` ~~and add dynamic library path to PATH environment variable.~~
4. now write new dart tests and place them in `test/` directory.
5. run `dart test`

Other platforms are similar.
