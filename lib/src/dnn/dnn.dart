// ignore_for_file: non_constant_identifier_names, constant_identifier_names

library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

/// Layer is a wrapper around the cv::dnn::Layer algorithm.
class Layer extends CvStruct<cvg.Layer> {
  Layer._(cvg.LayerPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  @Deprecated("Use [Layer.fromPointer] instead.")
  factory Layer.fromNative(cvg.LayerPtr ptr) => Layer._(ptr);
  factory Layer.fromPointer(cvg.LayerPtr ptr, [bool attach = true]) => Layer._(ptr, attach);

  static final finalizer = OcvFinalizer<cvg.LayerPtr>(ffi.Native.addressOf(cvg.Layer_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.Layer_Close(ptr);
  }

  /// GetName returns name for this layer.
  String get name {
    return cvRunArena<String>((arena) {
      final p = calloc<ffi.Pointer<ffi.Char>>();
      cvRun(() => cvg.Layer_GetName(ref, p));
      return p.value.toDartString();
    });
  }

  /// GetType returns type for this layer.
  String get type {
    return cvRunArena<String>((arena) {
      final p = calloc<ffi.Pointer<ffi.Char>>();
      cvRun(() => cvg.Layer_GetType(ref, p));
      return p.value.toDartString();
    });
  }

  /// InputNameToIndex returns index of input blob in input array.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d6c/classcv_1_1dnn_1_1Layer.html#a60ffc8238f3fa26cd3f49daa7ac0884b
  int inputNameToIndex(String name) {
    return using<int>((arena) {
      final cName = name.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = arena<ffi.Int>();
      cvRun(() => cvg.Layer_InputNameToIndex(ref, cName, p));
      return p.value;
    });
  }

  /// OutputNameToIndex returns index of output blob in output array.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d6c/classcv_1_1dnn_1_1Layer.html#a60ffc8238f3fa26cd3f49daa7ac0884b
  int outputNameToIndex(String name) {
    return using<int>((arena) {
      final cName = name.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = arena<ffi.Int>();
      cvRun(() => cvg.Layer_OutputNameToIndex(ref, cName, p));
      return p.value;
    });
  }

  @override
  List<int> get props => [ptr.address];
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

  factory Net.empty() {
    return cvRunArena<Net>((arena) {
      final p = calloc<cvg.Net>();
      cvRun(() => cvg.Net_Create(p));
      final net = Net._(p);
      return net;
    });
  }

  /// Read deep learning network represented in one of the supported formats.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga4823489a689bf4edfae7447eb807b067
  factory Net.fromFile(String path, {String config = "", String framework = ""}) {
    return using<Net>((arena) {
      final cPath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cConfig = config.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cFramework = framework.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = calloc<cvg.Net>();
      cvRun(() => cvg.Net_ReadNet(cPath, cConfig, cFramework, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Read deep learning network represented in one of the supported formats.
  ///
  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga138439da76f26266fdefec9723f6c5cd
  factory Net.fromBytes(String framework, Uint8List bufferModel, {Uint8List? bufferConfig}) {
    return using<Net>((arena) {
      bufferConfig ??= Uint8List(0);
      final cFramework = framework.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final bufM = VecUChar.fromList(bufferModel);
      final bufC = VecUChar.fromList(bufferConfig!);
      final p = calloc<cvg.Net>();
      cvRun(() => cvg.Net_ReadNetBytes(cFramework, bufM.ref, bufC.ref, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Reads a network model stored in Caffe framework's format.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga7117752a0216d9f84a9677eefdabf514
  factory Net.fromCaffe(String prototxt, String caffeModel) {
    return using<Net>((arena) {
      final cProto = prototxt.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cCaffe = caffeModel.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = calloc<cvg.Net>();
      cvRun(() => cvg.Net_ReadNetFromCaffe(cProto, cCaffe, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Reads a network model stored in Caffe model in memory.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga5b1fd56ca658f10c3bd544ea46f57164
  factory Net.fromCaffeBytes(Uint8List bufferProto, Uint8List bufferModel) {
    final p = calloc<cvg.Net>();
    final bufP = VecUChar.fromList(bufferProto);
    final bufM = VecUChar.fromList(bufferModel);
    cvRun(() => cvg.Net_ReadNetFromCaffeBytes(bufP.ref, bufM.ref, p));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model ONNX.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gafd98356f905742ff082e3e4e193633a3
  factory Net.fromOnnx(String path) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => cvg.Net_ReadNetFromONNX(cpath, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Reads a network model from ONNX in-memory buffer.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gac1a00e8bae54070e5837c15b1482997d
  factory Net.fromOnnxBytes(Uint8List bufferModel) {
    final p = calloc<cvg.Net>();
    final bufM = VecUChar.fromList(bufferModel);
    cvRun(() => cvg.Net_ReadNetFromONNXBytes(bufM.ref, p));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga91c313cd8269ddddaf3cb8299df2d4cb
  factory Net.fromTensorflow(String path, {String config = ""}) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cconf = config.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => cvg.Net_ReadNetFromTensorflow(cpath, cconf, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gac9b3890caab2f84790a17b306f36bd57
  factory Net.fromTensorflowBytes(Uint8List bufferModel, {Uint8List? bufferConfig}) {
    bufferConfig ??= Uint8List(0);
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    cvRun(() => cvg.Net_ReadNetFromTensorflowBytes(bufM.ref, bufC.ref, p));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in TFLite framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gae563b9ed2bc79838499a22727ad6c604
  factory Net.fromTFLite(String path) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => cvg.Net_ReadNetFromTFLite(cpath, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gab913e8da754b3d8e463389894365bd0c
  factory Net.fromTFLiteBytes(Uint8List bufferModel) {
    final bufM = VecUChar.fromList(bufferModel);
    final p = calloc<cvg.Net>();
    cvRun(() => cvg.Net_ReadNetFromTFLiteBytes(bufM.ref, p));
    final net = Net._(p);
    return net;
  }

  /// Reads a network model stored in Torch7 framework's format.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga73785dd1e95cd3070ef36f3109b053fe
  factory Net.fromTorch(String path, {bool isBinary = true, bool evaluate = true}) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => cvg.Net_ReadNetFromTorch(cpath, isBinary, evaluate, p));
      final net = Net._(p);
      return net;
    });
  }

  /// Empty returns true if there are no layers in the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a6a5778787d5b8770deab5eda6968e66c
  bool get isEmpty {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => cvg.Net_Empty(ref, p));
      return p.value;
    });
  }

  String dump() {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cvg.Net_Dump(ref, p));
    final ret = p.value.cast<Utf8>().toDartString();
    calloc.free(p);
    return ret;
  }

  /// SetInput sets the new value for the layer output blob.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a5e74adacffd6aa53d56046581de7fcbd
  void setInput(InputArray blob, {String name = "", double scalefactor = 1.0, Scalar? mean}) {
    // mean ??= Scalar.default_(); not supported yet
    using((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      cvRun(() => cvg.Net_SetInput(ref, blob.ref, cname.cast()));
    });
  }

  /// Forward runs forward pass to compute output of layer with name outputName.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a98ed94cb6ef7063d3697259566da310b
  Mat forward({String outputName = ""}) {
    return cvRunArena<Mat>((arena) {
      final m = Mat.empty();
      cvRun(() => cvg.Net_Forward(ref, outputName.toNativeUtf8(allocator: arena).cast(), m.ptr));
      return m;
    });
  }

  /// OpenVINO not supported yet, this is not available
  /// ForwardAsync runs forward pass to compute output of layer with name outputName.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a814890154ea9e10b132fec00b6f6ba30
  // AsyncArray forwardAsync({String outputName = ""}) {
  //   return using<AsyncArray>((arena) {
  //     final cname = outputName.toNativeUtf8(allocator: arena);
  //     final p = cvg.Net_forwardAsync(ptr, cname.cast());
  //     return AsyncArray.fromPointer(p);
  //   });
  // }

  /// ForwardLayers forward pass to compute outputs of layers listed in outBlobNames.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4.1/db/d30/classcv_1_1dnn_1_1Net.html#adb34d7650e555264c7da3b47d967311b
  VecMat forwardLayers(List<String> names) {
    return cvRunArena<VecMat>((arena) {
      final vecName = names.i8;
      final vecMat = calloc<cvg.VecMat>();
      cvRun(() => cvg.Net_ForwardLayers(ref, vecMat, vecName.ref));
      return VecMat.fromPointer(vecMat);
    });
  }

  /// SetPreferableBackend ask network to use specific computation backend.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4/db/d30/classcv_1_1dnn_1_1Net.html#a7f767df11386d39374db49cd8df8f59e
  void setPreferableBackend(int backendId) => cvRun(() => cvg.Net_SetPreferableBackend(ref, backendId));

  /// SetPreferableTarget ask network to make computations on specific target device.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4/db/d30/classcv_1_1dnn_1_1Net.html#a9dddbefbc7f3defbe3eeb5dc3d3483f4
  void setPreferableTarget(int targetId) => cvRun(() => cvg.Net_SetPreferableTarget(ref, targetId));

  /// GetLayer returns pointer to layer with specified id from the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a70aec7f768f38c32b1ee25f3a56526df
  Layer getLayer(int index) {
    final p = calloc<cvg.Layer>();
    cvRun(() => cvg.Net_GetLayer(ref, index, p));
    final layer = Layer.fromPointer(p);
    return layer;
  }

  /// GetLayerNames returns all layer names.
  ///
  /// For furtherdetails, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#ae8be9806024a0d1d41aba687cce99e6b
  List<String> getLayerNames() {
    final cNames = calloc<cvg.VecVecChar>();
    cvRun(() => cvg.Net_GetLayerNames(ref, cNames));
    final vec = VecVecChar.fromPointer(cNames);
    return vec.asStringList();
  }

  /// GetPerfProfile returns overall time for inference and timings (in ticks) for layers
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a06ce946f675f75d1c020c5ddbc78aedc
  int getPerfProfile() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int64>();
      cvRun(() => cvg.Net_GetPerfProfile(ref, p));
      return p.value;
    });
  }

  /// GetUnconnectedOutLayers returns indexes of layers with unconnected outputs.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#ae62a73984f62c49fd3e8e689405b056a
  List<int> getUnconnectedOutLayers() {
    return using<List<int>>((arena) {
      final ids = calloc<cvg.VecInt>();
      cvRun(() => cvg.Net_GetUnconnectedOutLayers(ref, ids));
      return VecInt.fromPointer(ids).toList();
    });
  }

  /// Returns input scale and zeropoint for a quantized Net.
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#af82a1c7e7de19712370a34667056102d
  (VecFloat, VecInt) getInputDetails() {
    return using<(VecFloat, VecInt)>((arena) {
      final sc = calloc<cvg.VecFloat>();
      final zp = calloc<cvg.VecInt>();
      cvRun(() => cvg.Net_GetInputDetails(ref, sc, zp));
      return (VecFloat.fromPointer(sc), VecInt.fromPointer(zp));
    });
  }

  static final finalizer = OcvFinalizer<cvg.NetPtr>(ffi.Native.addressOf(cvg.Net_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.Net_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
  @override
  cvg.Net get ref => ptr.ref;
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
  Size? size,
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) {
  return using<Mat>((arena) {
    size ??= (0, 0);
    mean ??= Scalar.zeros;
    final blob = Mat.empty();
    cvRun(
      () => cvg.Net_BlobFromImage(
        image.ref,
        blob.ref,
        scalefactor,
        size!.toSize(arena).ref,
        mean!.ref,
        swapRB,
        crop,
        ddepth,
      ),
    );
    return blob;
  });
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
  Size? size,
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) {
  return using<Mat>((arena) {
    blob ??= Mat.empty();
    size ??= (0, 0);
    mean ??= Scalar.zeros;
    cvg.Net_BlobFromImages(
      images.ref,
      blob!.ref,
      scalefactor,
      size!.toSize(arena).ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
    );
    return blob!;
  });
}

/// ImagesFromBlob Parse a 4D blob and output the images it contains as
/// 2D arrays through a simpler data structure (std::vector<cv::Mat>).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d6/d0f/group__dnn.html#ga4051b5fa2ed5f54b76c059a8625df9f5
List<Mat> imagesFromBlob(Mat blob) {
  final mats = calloc<cvg.VecMat>();
  cvRun(() => cvg.Net_ImagesFromBlob(blob.ref, mats));
  return VecMat.fromPointer(mats).toList();
}

/// GetBlobChannel extracts a single (2d)channel from a 4 dimensional blob structure
/// (this might e.g. contain the results of a SSD or YOLO detection,
///
///	a bones structure from pose detection, or a color plane from Colorization)
Mat getBlobChannel(Mat blob, int imgidx, int chnidx) {
  final m = Mat.empty();
  cvRun(() => cvg.Net_GetBlobChannel(blob.ref, imgidx, chnidx, m.ptr));
  return m;
}

/// GetBlobSize retrieves the 4 dimensional size information in (N,C,H,W) order
Scalar getBlobSize(Mat blob) {
  final s = calloc<cvg.Scalar>();
  cvRun(() => cvg.Net_GetBlobSize(blob.ref, s));
  return Scalar.fromPointer(s);
}

/// NMSBoxes performs non maximum suppression given boxes and corresponding scores.
///
/// For futher details, please see:
/// https://docs.opencv.org/4.4.0/d6/d0f/group__dnn.html#ga9d118d70a1659af729d01b10233213ee
List<int> NMSBoxes(
  VecRect bboxes,
  VecFloat scores,
  double scoreThreshold,
  double nmsThreshold, {
  double eta = 1.0,
  int topK = 0,
}) {
  final indices = calloc<cvg.VecInt>();
  cvg.NMSBoxesWithParams(
    bboxes.ref,
    scores.ref,
    scoreThreshold,
    nmsThreshold,
    indices,
    eta,
    topK,
  );
  return VecInt.fromPointer(indices).toList();
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
