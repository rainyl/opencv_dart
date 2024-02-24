# opencv_dart

OpenCV Bindings for Dart Language.

**!!!This package is experiment and APIs may change in the future!!!**

*Many tests unfinished, contributions are welcome!*

## Status

| module     | Binding status     | Test status             | description             |
| ---------- | ------------------ | ----------------------- | ----------------------- |
| aruco      | :white_check_mark: | :x:                     | ArUco module            |
| core       | :white_check_mark: | :white_check_mark:      | Core module             |
| features2d | :white_check_mark: | :x:                     | Features2D module       |
| highgui    | :white_check_mark: | :white_check_mark:      | HighGUI module          |
| imgcodecs  | :white_check_mark: | :white_check_mark:      | ImageCodecs module      |
| imgproc    | :white_check_mark: | :ballot_box_with_check: | ImageProc module        |
| objdetect  | :white_check_mark: | :white_check_mark:      | Object Detection module |
| svd        | :white_check_mark: | :white_check_mark:      | SVD module              |
| video      | :white_check_mark: | :x:                     | Video module            |
| videoio    | :white_check_mark: | :x:                     | VideoIO module          |
| asyncarray | :x:                | :x:                     | AsyncArray module       |
| calib3d    | :x:                | :x:                     | Calib3D module          |
| dnn        | :x:                | :x:                     | DNN module              |
| photo      | :x:                | :x:                     | Photo module            |
| cuda       | :x:                | :x:                     | CUDA module             |
| contrib    | :x:                | :x:                     | Contrib module          |

- :x: : not finished
- :ballot_box_with_check: : mostly finished
- :white_check_mark: : finished

### TODO

- [ ] compile libs for android, linux
- [ ] support for iOS, macOS
- [ ] add more examples
- [ ] modify C wrapper to catch exceptions
- [ ] Native Assets

## Develop

This package is in heavy development, dynamic libraries for Windows have been compiled, for other platforms, you need to compile it yourself.

1. compile opencv
2. compile this package along with gocv
3. copy libs

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## License

Apache-2.0 License
