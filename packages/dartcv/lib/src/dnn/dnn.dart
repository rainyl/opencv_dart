// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names, constant_identifier_names

library cv.dnn;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/dnn.g.dart' as cvg;
import '../native_lib.dart' show cdnn;

/// Layer is a wrapper around the cv::dnn::Layer algorithm.
class Layer extends CvStruct<cvg.Layer> {
  Layer._(cvg.LayerPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Layer.fromPointer(cvg.LayerPtr ptr, [bool attach = true]) => Layer._(ptr, attach);

  static final finalizer = OcvFinalizer<cvg.LayerPtr>(cdnn.addresses.cv_dnn_Layer_close);

  void dispose() {
    finalizer.detach(this);
    cdnn.cv_dnn_Layer_close(ptr);
  }

  /// GetName returns name for this layer.
  String get name {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cdnn.cv_dnn_Layer_getName(ref, p));
    final r = p.value.toDartString();
    calloc.free(p);
    return r;
  }

  /// GetType returns type for this layer.
  String get type {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cdnn.cv_dnn_Layer_getType(ref, p));
    final r = p.value.toDartString();
    calloc.free(p);
    return r;
  }

  /// InputNameToIndex returns index of input blob in input array.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d6c/classcv_1_1dnn_1_1Layer.html#a60ffc8238f3fa26cd3f49daa7ac0884b
  int inputNameToIndex(String name) {
    final cName = name.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<ffi.Int>();
    cvRun(() => cdnn.cv_dnn_Layer_inputNameToIndex(ref, cName, p));
    final rval = p.value;
    calloc.free(p);
    calloc.free(cName);
    return rval;
  }

  /// OutputNameToIndex returns index of output blob in output array.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d6c/classcv_1_1dnn_1_1Layer.html#a60ffc8238f3fa26cd3f49daa7ac0884b
  int outputNameToIndex(String name) {
    final cName = name.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<ffi.Int>();
    cvRun(() => cdnn.cv_dnn_Layer_outputNameToIndex(ref, cName, p));
    final rval = p.value;
    calloc.free(p);
    calloc.free(cName);
    return rval;
  }

  @override
  cvg.Layer get ref => ptr.ref;
}

/// Net allows you to create and manipulate comprehensive artificial neural networks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html
class Net extends CvStruct<cvg.Net> {
  Net._(cvg.NetPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Net.fromPointer(cvg.NetPtr ptr, [bool attach = true]) => Net._(ptr, attach);

  factory Net.empty() {
    final p = calloc<cvg.Net>();
    cvRun(() => cdnn.cv_dnn_Net_create(p));
    final net = Net._(p);
    return net;
  }

  /// Read deep learning network represented in one of the supported formats.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga4823489a689bf4edfae7447eb807b067
  factory Net.fromFile(String path, {String config = "", String framework = ""}) {
    final cPath = path.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<cvg.Net>();
    cvRun(() => cdnn.cv_dnn_Net_readNet(cPath, cConfig, cFramework, p, ffi.nullptr));
    calloc.free(cPath);
    calloc.free(cConfig);
    calloc.free(cFramework);
    final net = Net._(p);
    return net;
  }

  /// Read deep learning network represented in one of the supported formats.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga138439da76f26266fdefec9723f6c5cd
  factory Net.fromBytes(String framework, Uint8List bufferModel, {Uint8List? bufferConfig}) {
    bufferConfig ??= Uint8List(0);
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    cvRun(() => cdnn.cv_dnn_Net_readNetBytes(cFramework, bufM.ref, bufC.ref, p, ffi.nullptr));
    calloc.free(cFramework);
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in Caffe framework's format.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga7117752a0216d9f84a9677eefdabf514
  factory Net.fromCaffe(String prototxt, String caffeModel) {
    final cProto = prototxt.toNativeUtf8().cast<ffi.Char>();
    final cCaffe = caffeModel.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<cvg.Net>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromCaffe(cProto, cCaffe, p, ffi.nullptr));
    calloc.free(cProto);
    calloc.free(cCaffe);
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in Caffe model in memory.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga5b1fd56ca658f10c3bd544ea46f57164
  factory Net.fromCaffeBytes(Uint8List bufferProto, Uint8List bufferModel) {
    final p = calloc<cvg.Net>();
    final bufP = VecUChar.fromList(bufferProto);
    final bufM = VecUChar.fromList(bufferModel);
    cvRun(() => cdnn.cv_dnn_Net_readNetFromCaffeBytes(bufP.ref, bufM.ref, p, ffi.nullptr));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model ONNX.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gafd98356f905742ff082e3e4e193633a3
  factory Net.fromOnnx(String path) {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromONNX(cpath, p, ffi.nullptr));
    calloc.free(cpath);
    final net = Net._(p);
    return net;
  }

  /// Reads a network model from ONNX in-memory buffer.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gac1a00e8bae54070e5837c15b1482997d
  factory Net.fromOnnxBytes(Uint8List bufferModel) {
    final p = calloc<cvg.Net>();
    final bufM = VecUChar.fromList(bufferModel);
    cvRun(() => cdnn.cv_dnn_Net_readNetFromONNXBytes(bufM.ref, p, ffi.nullptr));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga91c313cd8269ddddaf3cb8299df2d4cb
  factory Net.fromTensorflow(String path, {String config = ""}) {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final cconf = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromTensorflow(cpath, cconf, p, ffi.nullptr));
    calloc.free(cpath);
    calloc.free(cconf);
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gac9b3890caab2f84790a17b306f36bd57
  factory Net.fromTensorflowBytes(Uint8List bufferModel, {Uint8List? bufferConfig}) {
    bufferConfig ??= Uint8List(0);
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromTensorflowBytes(bufM.ref, bufC.ref, p, ffi.nullptr));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in TFLite framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gae563b9ed2bc79838499a22727ad6c604
  factory Net.fromTFLite(String path) {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromTFLite(cpath, p, ffi.nullptr));
    calloc.free(cpath);
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gab913e8da754b3d8e463389894365bd0c
  factory Net.fromTFLiteBytes(Uint8List bufferModel) {
    final bufM = VecUChar.fromList(bufferModel);
    final p = calloc<cvg.Net>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromTFLiteBytes(bufM.ref, p, ffi.nullptr));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in Torch7 framework's format.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga73785dd1e95cd3070ef36f3109b053fe
  factory Net.fromTorch(String path, {bool isBinary = true, bool evaluate = true}) {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cdnn.cv_dnn_Net_readNetFromTorch(cpath, isBinary, evaluate, p, ffi.nullptr));
    calloc.free(cpath);
    final net = Net._(p);
    return net;
  }

  /// Empty returns true if there are no layers in the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a6a5778787d5b8770deab5eda6968e66c
  bool get isEmpty => cdnn.cv_dnn_Net_empty(ref);

  String dump() {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cdnn.cv_dnn_Net_dump(ref, p));
    final ret = p.value.cast<Utf8>().toDartString();
    calloc.free(p);
    return ret;
  }

  /// SetInput sets the new value for the layer output blob.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a5e74adacffd6aa53d56046581de7fcbd
  void setInput(InputArray blob, {String name = "", double scalefactor = 1.0, Scalar? mean}) {
    mean ??= Scalar();
    final cname = name.toNativeUtf8();
    cvRun(() => cdnn.cv_dnn_Net_setInput(ref, blob.ref, cname.cast(), scalefactor, mean!.ref, ffi.nullptr));
    calloc.free(cname);
  }

  /// Forward runs forward pass to compute output of layer with name outputName.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a98ed94cb6ef7063d3697259566da310b
  Mat forward({String outputName = ""}) {
    final m = Mat.empty();
    final cOutName = outputName.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cdnn.cv_dnn_Net_forward(ref, cOutName, m.ptr, ffi.nullptr));
    calloc.free(cOutName);
    return m;
  }

  /// OpenVINO not supported yet, this is not available
  /// ForwardAsync runs forward pass to compute output of layer with name outputName.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a814890154ea9e10b132fec00b6f6ba30
  // AsyncArray forwardAsync({String outputName = ""}) {
  //   return using<AsyncArray>((arena) {
  //     final cname = outputName.toNativeUtf8(allocator: arena);
  //     final p = cffiDnn.Net_forwardAsync(ptr, cname.cast());
  //     return AsyncArray.fromPointer(p);
  //   });
  // }

  /// ForwardLayers forward pass to compute outputs of layers listed in outBlobNames.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4.1/db/d30/classcv_1_1dnn_1_1Net.html#adb34d7650e555264c7da3b47d967311b
  VecMat forwardLayers(List<String> names) {
    final vecName = names.i8;
    final vecMat = VecMat();
    cvRun(() => cdnn.cv_dnn_Net_forwardLayers(ref, vecMat.ptr, vecName.ref, ffi.nullptr));
    return vecMat;
  }

  /// SetPreferableBackend ask network to use specific computation backend.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4/db/d30/classcv_1_1dnn_1_1Net.html#a7f767df11386d39374db49cd8df8f59e
  void setPreferableBackend(int backendId) =>
      cvRun(() => cdnn.cv_dnn_Net_setPreferableBackend(ref, backendId));

  /// SetPreferableTarget ask network to make computations on specific target device.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4/db/d30/classcv_1_1dnn_1_1Net.html#a9dddbefbc7f3defbe3eeb5dc3d3483f4
  void setPreferableTarget(int targetId) => cvRun(() => cdnn.cv_dnn_Net_setPreferableTarget(ref, targetId));

  /// GetLayer returns pointer to layer with specified id from the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a70aec7f768f38c32b1ee25f3a56526df
  Layer getLayer(int index) {
    final p = calloc<cvg.Layer>();
    cvRun(() => cdnn.cv_dnn_Net_getLayer(ref, index, p));
    final layer = Layer.fromPointer(p);
    return layer;
  }

  /// GetLayerNames returns all layer names.
  ///
  /// For furtherdetails, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#ae8be9806024a0d1d41aba687cce99e6b
  List<String> getLayerNames() {
    final cNames = VecVecChar();
    cvRun(() => cdnn.cv_dnn_Net_getLayerNames(ref, cNames.ptr, ffi.nullptr));
    final vec = cNames.asStringList();
    cNames.dispose();
    return vec;
  }

  /// GetPerfProfile returns overall time for inference and timings (in ticks) for layers
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a06ce946f675f75d1c020c5ddbc78aedc
  (int, VecF64 layersTimes) getPerfProfile() {
    final p = calloc<ffi.Int64>();
    final p1 = VecF64();
    cvRun(() => cdnn.cv_dnn_Net_getPerfProfile(ref, p, p1.ptr, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return (rval, p1);
  }

  /// GetUnconnectedOutLayers returns indexes of layers with unconnected outputs.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#ae62a73984f62c49fd3e8e689405b056a
  List<int> getUnconnectedOutLayers() {
    final ids = VecI32();
    cvRun(() => cdnn.cv_dnn_Net_getUnconnectedOutLayers(ref, ids.ptr, ffi.nullptr));
    return ids.toList();
  }

  /// getUnconnectedOutLayersNames
  ///
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a9f699cf9710abd63339b5b8e1937f171
  List<String> getUnconnectedOutLayersNames() {
    final vec = VecVecChar();
    cvRun(() => cdnn.cv_dnn_Net_getUnconnectedOutLayersNames(ref, vec.ptr, ffi.nullptr));
    final rval = vec.asStringList();
    vec.dispose();
    return rval;
  }

  /// Returns input scale and zeropoint for a quantized Net.
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#af82a1c7e7de19712370a34667056102d
  (VecF32, VecI32) getInputDetails() {
    final sc = VecF32();
    final zp = VecI32();
    cvRun(() => cdnn.cv_dnn_Net_getInputDetails(ref, sc.ptr, zp.ptr, ffi.nullptr));
    return (sc, zp);
  }

  static final finalizer = OcvFinalizer<cvg.NetPtr>(cdnn.addresses.cv_dnn_Net_close);

  void dispose() {
    finalizer.detach(this);
    cdnn.cv_dnn_Net_close(ptr);
  }

  @override
  cvg.Net get ref => ptr.ref;
}

void enableModelDiagnostics(bool isDiagnosticsMode) => cdnn.cv_dnn_enableModelDiagnostics(isDiagnosticsMode);

/// getAvailableBackends
///
/// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gab691d0cb65a60adcb0291ea5bf98f438
List<(int backend, int target)> getAvailableBackends() {
  final p = VecPoint();
  cdnn.cv_dnn_getAvailableBackends(p.ptr);
  final rval = List.generate(p.length, (i) => (p[i].x, p[i].y));
  p.dispose();
  return rval;
}

/// getAvailableTargets
/// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga711e5056b6642b33d9480c98c6889f56
List<int> getAvailableTargets(int backend) {
  final p = VecI32();
  cvRun(() => cdnn.cv_dnn_getAvailableTargets(backend, p.ptr));
  final rval = p.toList();
  return rval;
}

/// Creates 4-dimensional blob from image.
/// Optionally resizes and crops image from center,
/// subtract mean values, scales values by scalefactor, swap Blue and Red channels.
///
/// For further details, please see:
/// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga29f34df9376379a603acd8df581ac8d7
Mat blobFromImage(
  InputArray image, {
  double scalefactor = 1.0,
  (int, int) size = (0, 0),
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) {
  mean ??= Scalar.zeros;
  final blob = Mat.empty();
  cvRun(
    () => cdnn.cv_dnn_blobFromImage(
      image.ref,
      blob.ref,
      scalefactor,
      size.cvd.ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      ffi.nullptr,
    ),
  );
  return blob;
}

/// Creates 4-dimensional blob from series of images.
/// Optionally resizes and crops images from center,
/// subtract mean values, scales values by scalefactor,
/// swap Blue and Red channels.
/// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga0b7b7c3c530b747ef738178835e1e70f
Mat blobFromImages(
  VecMat images, {
  Mat? blob,
  double scalefactor = 1.0,
  (int, int) size = (0, 0),
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) {
  blob ??= Mat.empty();
  mean ??= Scalar.zeros;
  cvRun(
    () => cdnn.cv_dnn_blobFromImages(
      images.ref,
      blob!.ref,
      scalefactor,
      size.cvd.ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      ffi.nullptr,
    ),
  );
  return blob;
}

/// ImagesFromBlob Parse a 4D blob and output the images it contains as
/// 2D arrays through a simpler data structure (std::vector<cv::Mat>).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d6/d0f/group__dnn.html#ga4051b5fa2ed5f54b76c059a8625df9f5
VecMat imagesFromBlob(Mat blob) {
  final mats = VecMat();
  cvRun(() => cdnn.cv_dnn_imagesFromBlob(blob.ref, mats.ptr, ffi.nullptr));
  return mats;
}

/// GetBlobChannel extracts a single (2d)channel from a 4 dimensional blob structure
/// (this might e.g. contain the results of a SSD or YOLO detection,
///
///	a bones structure from pose detection, or a color plane from Colorization)
Mat getBlobChannel(Mat blob, int imgidx, int chnidx) {
  final m = Mat.empty();
  cvRun(() => cdnn.cv_dnn_getBlobChannel(blob.ref, imgidx, chnidx, m.ptr, ffi.nullptr));
  return m;
}

/// GetBlobSize retrieves the 4 dimensional size information in (N,C,H,W) order
VecI32 getBlobSize(Mat blob) {
  final s = VecI32();
  cvRun(() => cdnn.cv_dnn_getBlobSize(blob.ref, s.ptr));
  return s;
}

/// NMSBoxes performs non maximum suppression given boxes and corresponding scores.
///
/// For futher details, please see:
/// https://docs.opencv.org/4.4.0/d6/d0f/group__dnn.html#ga9d118d70a1659af729d01b10233213ee
List<int> NMSBoxes(
  VecRect bboxes,
  VecF32 scores,
  double scoreThreshold,
  double nmsThreshold, {
  double eta = 1.0,
  int topK = 0,
}) {
  final indices = VecI32();
  cvRun(
    () => cdnn.cv_dnn_NMSBoxes_1(
      bboxes.ref,
      scores.ref,
      scoreThreshold,
      nmsThreshold,
      indices.ptr,
      eta,
      topK,
      ffi.nullptr,
    ),
  );
  return indices.toList();
}

// Constants

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
