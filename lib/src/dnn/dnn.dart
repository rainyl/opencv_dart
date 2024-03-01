library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/contours.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../constants.g.dart';
import '../core/extensions.dart';
import '../core/base.dart';
import '../core/core.dart';
import '../core/scalar.dart';

import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

// Net allows you to create and manipulate comprehensive artificial neural networks.
//
// For further details, please see:
// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html
class Net implements ffi.Finalizable {
  Net._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  /// Empty returns true if there are no layers in the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a6a5778787d5b8770deab5eda6968e66c
  bool get isEmpty => _bindings.Net_Empty(ptr);

  // SetInput sets the new value for the layer output blob.
//
// For further details, please see:
// https://docs.opencv.org/trunk/db/d30/classcv_1_1dnn_1_1Net.html#a672a08ae76444d75d05d7bfea3e4a328
  void setInput(InputArray blob, {String name = "", double scalefactor = 1.0, Scalar? mean}) {
    mean ??= Scalar.default_();
    using((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      _bindings.Net_SetInput(ptr, blob.ptr, cname.cast());
    });
  }

  cvg.Net ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.Net_Close);
}

// DNN_BACKEND_DEFAULT equals to OPENCV_DNN_BACKEND_DEFAULT, which can be defined using CMake or a configuration parameter
const int DNN_BACKEND_DEFAULT = 0;
const int DNN_BACKEND_HALIDE = 1;
// Intel OpenVINO computational backend
const int DNN_BACKEND_INFERENCE_ENGINE = 2;
const int DNN_BACKEND_OPENCV = 3;
const int DNN_BACKEND_VKCOM = 4;
const int DNN_BACKEND_CUDA = 5;
const int DNN_BACKEND_WEBNN = 6;
const int DNN_BACKEND_TIMVX = 7;
const int DNN_BACKEND_CANN = 8;

const int DNN_TARGET_CPU = 0;
const int DNN_TARGET_OPENCL = 1;
const int DNN_TARGET_OPENCL_FP16 = 2;
const int DNN_TARGET_MYRIAD = 3;
const int DNN_TARGET_VULKAN = 4;

/// FPGA device with CPU fallbacks using Inference Engine's Heterogeneous plugin.
const int DNN_TARGET_FPGA = 5;
const int DNN_TARGET_CUDA = 6;
const int DNN_TARGET_CUDA_FP16 = 7;
const int DNN_TARGET_HDDL = 8;
const int DNN_TARGET_NPU = 9;

/// Only the ARM platform is supported. Low precision computing, accelerate model inference.
const int DNN_TARGET_CPU_FP16 = 10;
