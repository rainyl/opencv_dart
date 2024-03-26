library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/mat_type.dart';
import '../core/rect.dart';
import '../core/extensions.dart';
import '../core/base.dart';
import '../core/scalar.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// Layer is a wrapper around the cv::dnn::Layer algorithm.
class Layer implements ffi.Finalizable {
  Layer._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory Layer.fromNative(cvg.Layer ptr) => Layer._(ptr);

  cvg.Layer ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.Layer_Close);

  /// GetName returns name for this layer.
  String get name => _bindings.Layer_GetName(ptr).cast<Utf8>().toDartString();

  /// GetType returns type for this layer.
  String get type => _bindings.Layer_GetType(ptr).cast<Utf8>().toDartString();

  /// InputNameToIndex returns index of input blob in input array.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d6c/classcv_1_1dnn_1_1Layer.html#a60ffc8238f3fa26cd3f49daa7ac0884b
  int inputNameToIndex(String name) {
    return using<int>((arena) {
      final cName = name.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      return _bindings.Layer_InputNameToIndex(ptr, cName);
    });
  }

  /// OutputNameToIndex returns index of output blob in output array.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d6c/classcv_1_1dnn_1_1Layer.html#a60ffc8238f3fa26cd3f49daa7ac0884b
  int OutputNameToIndex(String name) {
    return using<int>((arena) {
      final cName = name.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      return _bindings.Layer_OutputNameToIndex(ptr, cName);
    });
  }
}

/// Net allows you to create and manipulate comprehensive artificial neural networks.
///
/// For further details, please see:
/// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html
class Net implements ffi.Finalizable {
  Net._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  factory Net.empty() {
    return Net._(_bindings.Net_Create());
  }

  /// Read deep learning network represented in one of the supported formats.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga4823489a689bf4edfae7447eb807b067
  factory Net.fromFile(String path, {String config = "", String framework = ""}) {
    return using<Net>((arena) {
      final cPath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cConfig = config.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cFramework = framework.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final _ptr = _bindings.Net_ReadNet(cPath, cConfig, cFramework);
      return Net._(_ptr);
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
      final _ptr = _bindings.Net_ReadNetBytes(
        cFramework,
        bufferModel.toByteArray(arena).ref,
        bufferConfig!.toByteArray(arena).ref,
      );
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in Caffe framework's format.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga7117752a0216d9f84a9677eefdabf514
  factory Net.fromCaffe(String prototxt, String caffeModel) {
    return using<Net>((arena) {
      final cProto = prototxt.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cCaffe = caffeModel.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final _ptr = _bindings.Net_ReadNetFromCaffe(cProto, cCaffe);
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in Caffe model in memory.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga5b1fd56ca658f10c3bd544ea46f57164
  factory Net.fromCaffeBytes(Uint8List bufferProto, Uint8List bufferModel) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromCaffeBytes(
        bufferProto.toByteArray(arena).ref,
        bufferModel.toByteArray(arena).ref,
      );
      return Net._(_ptr);
    });
  }

  /// Reads a network model ONNX.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gafd98356f905742ff082e3e4e193633a3
  factory Net.fromOnnx(String path) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromONNX(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
      );
      return Net._(_ptr);
    });
  }

  /// Reads a network model from ONNX in-memory buffer.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gac1a00e8bae54070e5837c15b1482997d
  factory Net.fromOnnxBytes(Uint8List bufferModel) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromONNXBytes(bufferModel.toByteArray(arena).ref);
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga91c313cd8269ddddaf3cb8299df2d4cb
  factory Net.fromTensorflow(String path, {String config = ""}) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromTensorflow(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        config.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
      );
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gac9b3890caab2f84790a17b306f36bd57
  factory Net.fromTensorflowBytes(Uint8List bufferModel, {Uint8List? bufferConfig}) {
    return using<Net>((arena) {
      bufferConfig ??= Uint8List(0);
      final _ptr = _bindings.Net_ReadNetFromTensorflowBytes(
        bufferModel.toByteArray(arena).ref,
        bufferConfig!.toByteArray(arena).ref,
      );
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in TFLite framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gae563b9ed2bc79838499a22727ad6c604
  factory Net.fromTFLite(String path) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromTFLite(path.toNativeUtf8(allocator: arena).cast<ffi.Char>());
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in TensorFlow framework's format.
  ///
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#gab913e8da754b3d8e463389894365bd0c
  factory Net.fromTFLiteBytes(Uint8List bufferModel) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromTFLiteBytes(bufferModel.toByteArray(arena).ref);
      return Net._(_ptr);
    });
  }

  /// Reads a network model stored in Torch7 framework's format.
  /// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga73785dd1e95cd3070ef36f3109b053fe
  factory Net.fromTorch(String path, {bool isBinary = true, bool evaluate = true}) {
    return using<Net>((arena) {
      final _ptr = _bindings.Net_ReadNetFromTorch(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        isBinary,
        evaluate,
      );
      return Net._(_ptr);
    });
  }

  /// Empty returns true if there are no layers in the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a6a5778787d5b8770deab5eda6968e66c
  bool get isEmpty => _bindings.Net_Empty(ptr);

  /// SetInput sets the new value for the layer output blob.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a5e74adacffd6aa53d56046581de7fcbd
  void setInput(InputArray blob, {String name = "", double scalefactor = 1.0, Scalar? mean}) {
    // mean ??= Scalar.default_(); not supported yet
    using((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      _bindings.Net_SetInput(ptr, blob.ptr, cname.cast());
    });
  }

  /// Forward runs forward pass to compute output of layer with name outputName.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a98ed94cb6ef7063d3697259566da310b
  Mat forward({String outputName = ""}) {
    return using<Mat>(
      (p0) => Mat.fromCMat(
        _bindings.Net_Forward(ptr, outputName.toNativeUtf8(allocator: p0).cast()),
      ),
    );
  }

  /// OpenVINO not supported yet, this is not available
  /// ForwardAsync runs forward pass to compute output of layer with name outputName.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#a814890154ea9e10b132fec00b6f6ba30
  // AsyncArray forwardAsync({String outputName = ""}) {
  //   return using<AsyncArray>((arena) {
  //     final cname = outputName.toNativeUtf8(allocator: arena);
  //     final p = _bindings.Net_forwardAsync(ptr, cname.cast());
  //     return AsyncArray.fromPointer(p);
  //   });
  // }

  /// ForwardLayers forward pass to compute outputs of layers listed in outBlobNames.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4.1/db/d30/classcv_1_1dnn_1_1Net.html#adb34d7650e555264c7da3b47d967311b
  List<Mat> forwardLayers(List<String> names) {
    return using<List<Mat>>((arena) {
      final cMats = arena<cvg.Mats>();
      final cStrs = arena<cvg.CStrings>()
        ..ref.length = names.length
        ..ref.strs = arena<ffi.Pointer<ffi.Char>>();
      for (var i = 0; i < names.length; i++) {
        cStrs.ref.strs[i] = names[i].toNativeUtf8(allocator: arena).cast<ffi.Char>();
      }
      _bindings.Net_ForwardLayers(ptr, cMats, cStrs.ref);
      return cMats.toList();
    });
  }

  /// SetPreferableBackend ask network to use specific computation backend.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4/db/d30/classcv_1_1dnn_1_1Net.html#a7f767df11386d39374db49cd8df8f59e
  void setPreferableBackend(int backendId) => _bindings.Net_SetPreferableBackend(ptr, backendId);

  /// SetPreferableTarget ask network to make computations on specific target device.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/3.4/db/d30/classcv_1_1dnn_1_1Net.html#a9dddbefbc7f3defbe3eeb5dc3d3483f4
  void setPreferableTarget(int targetId) => _bindings.Net_SetPreferableTarget(ptr, targetId);

  /// GetLayer returns pointer to layer with specified id from the network.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a70aec7f768f38c32b1ee25f3a56526df
  Layer getLayer(int index) {
    return Layer.fromNative(_bindings.Net_GetLayer(ptr, index));
  }

  /// GetLayerNames returns all layer names.
  ///
  /// For furtherdetails, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#ae8be9806024a0d1d41aba687cce99e6b
  List<String> getLayerNames() {
    return using<List<String>>((arena) {
      final cNames = arena<cvg.CStrings>();
      _bindings.Net_GetLayerNames(ptr, cNames);
      final strPtrs = cNames.ref.strs.cast<ffi.Pointer<Utf8>>();
      return List.generate(cNames.ref.length, (i) => strPtrs[i].toDartString());
    });
  }

  /// GetPerfProfile returns overall time for inference and timings (in ticks) for layers
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#a06ce946f675f75d1c020c5ddbc78aedc
  int getPerfProfile() {
    return _bindings.Net_GetPerfProfile(ptr);
  }

  /// GetUnconnectedOutLayers returns indexes of layers with unconnected outputs.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d30/classcv_1_1dnn_1_1Net.html#ae62a73984f62c49fd3e8e689405b056a
  List<int> getUnconnectedOutLayers() {
    return using<List<int>>((arena) {
      final ids = arena<cvg.IntVector>();
      _bindings.Net_GetUnconnectedOutLayers(ptr, ids);
      return List.generate(ids.ref.length, (i) => ids.ref.val[i]);
    });
  }

  /// Returns input scale and zeropoint for a quantized Net.
  /// https://docs.opencv.org/4.x/db/d30/classcv_1_1dnn_1_1Net.html#af82a1c7e7de19712370a34667056102d
  (List<double>, List<int>) getInputDetails() {
    return using<(List<double>, List<int>)>((arena) {
      final _scales = arena<cvg.FloatVector>();
      final _zeropoints = arena<cvg.IntVector>();
      _bindings.Net_GetInputDetails(ptr, _scales, _zeropoints);
      return (
        _scales.ref.val.asTypedList(_scales.ref.length).toList(),
        _zeropoints.ref.val.cast<ffi.Int32>().asTypedList(_zeropoints.ref.length)
      );
    });
  }

  cvg.Net ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.Net_Close);
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
    final _ptr = _bindings.Net_BlobFromImage(
      image.ptr,
      scalefactor,
      size!.toSize(arena).ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
    );
    return Mat.fromCMat(_ptr);
  });
}

/// Creates 4-dimensional blob from series of images.
/// Optionally resizes and crops images from center,
/// subtract mean values, scales values by scalefactor,
/// swap Blue and Red channels.
/// https://docs.opencv.org/4.x/d6/d0f/group__dnn.html#ga0b7b7c3c530b747ef738178835e1e70f
Mat blobFromImages(
  List<Mat> images, {
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
    _bindings.Net_BlobFromImages(
      images.toMats(arena).ref,
      blob!.ptr,
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
  return using<List<Mat>>((arena) {
    final mats = arena<cvg.Mats>()..ref = _bindings.Mats_New();
    _bindings.Net_ImagesFromBlob(blob.ptr, mats);
    return List.generate(mats.ref.length, (i) => Mat.fromCMat(mats.ref.mats[i]));
  });
}

/// GetBlobChannel extracts a single (2d)channel from a 4 dimensional blob structure
/// (this might e.g. contain the results of a SSD or YOLO detection,
///
///	a bones structure from pose detection, or a color plane from Colorization)
Mat getBlobChannel(Mat blob, int imgidx, int chnidx) {
  return using<Mat>((arena) {
    return Mat.fromCMat(_bindings.Net_GetBlobChannel(blob.ptr, imgidx, chnidx));
  });
}

/// GetBlobSize retrieves the 4 dimensional size information in (N,C,H,W) order
Scalar getBlobSize(Mat blob) {
  return using<Scalar>((arena) {
    return Scalar.fromNative(_bindings.Net_GetBlobSize(blob.ptr));
  });
}

/// NMSBoxes performs non maximum suppression given boxes and corresponding scores.
///
/// For futher details, please see:
/// https://docs.opencv.org/4.4.0/d6/d0f/group__dnn.html#ga9d118d70a1659af729d01b10233213ee
List<int> NMSBoxes(
  List<Rect> bboxes,
  List<double> scores,
  double score_threshold,
  double nms_threshold, {
  double eta = 1.0,
  int top_k = 0,
}) {
  return using<List<int>>((arena) {
    final indices = arena<cvg.IntVector>();
    _bindings.NMSBoxesWithParams(
      bboxes.toNative(arena).ref,
      scores.toNativeVector(arena).ref,
      score_threshold,
      nms_threshold,
      indices,
      eta,
      top_k,
    );
    return List.generate(indices.ref.length, (i) => indices.ref.val[i]);
  });
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
