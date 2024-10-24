// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv.dnn;

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
import '../g/dnn.g.dart' as cvg;
import '../native_lib.dart' show cdnn;
import './dnn.dart';

extension NetAsync on Net {
  static Future<Net> fromFileAsync(String path, {String config = "", String framework = ""}) async {
    final cPath = path.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<cvg.Net>();
    final rval = cvRunAsync0<Net>(
      (callback) => cdnn.cv_dnn_Net_readNet(cPath, cConfig, cFramework, p, callback),
      (c) {
        final net = Net.fromPointer(p);
        return c.complete(net);
      },
    );
    calloc.free(cPath);
    calloc.free(cConfig);
    calloc.free(cFramework);
    return rval;
  }

  static Future<Net> fromBytesAsync(
    String framework,
    Uint8List bufferModel, {
    Uint8List? bufferConfig,
  }) async {
    bufferConfig ??= Uint8List(0);
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
        (callback) => cdnn.cv_dnn_Net_readNetBytes(cFramework, bufM.ref, bufC.ref, p, callback), (c) {
      calloc.free(cFramework);
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromCaffeAsync(String prototxt, String caffeModel) async {
    final cProto = prototxt.toNativeUtf8().cast<ffi.Char>();
    final cCaffe = caffeModel.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<cvg.Net>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromCaffe(cProto, cCaffe, p, callback), (c) {
      calloc.free(cProto);
      calloc.free(cCaffe);
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromCaffeBytesAsync(Uint8List bufferProto, Uint8List bufferModel) async {
    final p = calloc<cvg.Net>();
    final bufP = VecUChar.fromList(bufferProto);
    final bufM = VecUChar.fromList(bufferModel);
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromCaffeBytes(bufP.ref, bufM.ref, p, callback),
        (c) {
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromOnnxAsync(String path) async {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromONNX(cpath, p, callback), (c) {
      calloc.free(cpath);
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromOnnxBytesAsync(Uint8List bufferModel) async {
    final p = calloc<cvg.Net>();
    final bufM = VecUChar.fromList(bufferModel);
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromONNXBytes(bufM.ref, p, callback), (c) {
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromTensorflowAsync(String path, {String config = ""}) async {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final cconf = config.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromTensorflow(cpath, cconf, p, callback), (c) {
      calloc.free(cpath);
      calloc.free(cconf);
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromTensorflowBytesAsync(Uint8List bufferModel, {Uint8List? bufferConfig}) async {
    bufferConfig ??= Uint8List(0);
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
        (callback) => cdnn.cv_dnn_Net_readNetFromTensorflowBytes(bufM.ref, bufC.ref, p, callback), (c) {
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromTFLiteAsync(String path) async {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromTFLite(cpath, p, callback), (c) {
      calloc.free(cpath);
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromTFLiteBytesAsync(Uint8List bufferModel) async {
    final bufM = VecUChar.fromList(bufferModel);
    final p = calloc<cvg.Net>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromTFLiteBytes(bufM.ref, p, callback), (c) {
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  static Future<Net> fromTorchAsync(String path, {bool isBinary = true, bool evaluate = true}) async {
    final p = calloc<cvg.Net>();
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_readNetFromTorch(cpath, isBinary, evaluate, p, callback),
        (c) {
      calloc.free(cpath);
      final net = Net.fromPointer(p);
      return c.complete(net);
    });
  }

  Future<void> setInputAsync(
    InputArray blob, {
    String name = "",
    double scalefactor = 1.0,
    Scalar? mean,
  }) async {
    mean ??= Scalar();
    final cname = name.toNativeUtf8();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_setInput(ref, blob.ref, cname.cast(), scalefactor, mean!.ref, callback),
      (c) {
        calloc.free(cname);
        c.complete();
      },
    );
  }

  Future<Mat> forwardAsync({String outputName = ""}) async {
    final m = Mat.empty();
    final cOutName = outputName.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_forward(ref, cOutName, m.ptr, callback), (c) {
      calloc.free(cOutName);
      return c.complete(m);
    });
  }

  Future<VecMat> forwardLayersAsync(List<String> names) async {
    final vecName = names.i8;
    final vecMat = calloc<cvg.VecMat>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_forwardLayers(ref, vecMat, vecName.ref, callback),
      (c) {
        return c.complete(VecMat.fromPointer(vecMat));
      },
    );
  }

  Future<(int, VecF64 layersTimes)> getPerfProfileAsync() async {
    final p = calloc<ffi.Int64>();
    final p1 = calloc<cvg.VecF64>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_getPerfProfile(ref, p, p1, callback), (c) {
      final rval = p.value;
      calloc.free(p);
      return c.complete((rval, VecF64.fromPointer(p1)));
    });
  }

  Future<VecI32> getUnconnectedOutLayersAsync() async {
    final ids = calloc<cvg.VecI32>();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_getUnconnectedOutLayers(ref, ids, callback), (c) {
      return c.complete(VecI32.fromPointer(ids));
    });
  }

  Future<List<String>> getLayerNamesAsync() async {
    final cNames = calloc<cvg.VecVecChar>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_getLayerNames(ref, cNames, callback),
      (c) {
        final vec = VecVecChar.fromPointer(cNames);
        return c.complete(vec.asStringList());
      },
    );
  }

  Future<(VecF32, VecI32)> getInputDetailsAsync() async {
    final sc = calloc<cvg.VecF32>();
    final zp = calloc<cvg.VecI32>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_getInputDetails(ref, sc, zp, callback),
      (c) {
        return c.complete((VecF32.fromPointer(sc), VecI32.fromPointer(zp)));
      },
    );
  }
}

Future<Mat> blobFromImageAsync(
  InputArray image, {
  double scalefactor = 1.0,
  (int, int) size = (0, 0),
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) async {
  mean ??= Scalar.zeros;
  final blob = Mat.empty();
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_blobFromImage(
      image.ref,
      blob.ref,
      scalefactor,
      size.cvd.ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      callback,
    ),
    (c) {
      return c.complete(blob);
    },
  );
}

Future<Mat> blobFromImagesAsync(
  VecMat images, {
  Mat? blob,
  double scalefactor = 1.0,
  (int, int) size = (0, 0),
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) async {
  blob ??= Mat.empty();
  mean ??= Scalar.zeros;
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_blobFromImages(
      images.ref,
      blob!.ref,
      scalefactor,
      size.cvd.ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      callback,
    ),
    (c) {
      return c.complete(blob);
    },
  );
}

Future<List<Mat>> imagesFromBlobAsync(Mat blob) async {
  final mats = calloc<cvg.VecMat>();
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_imagesFromBlob(blob.ref, mats, callback),
    (c) {
      return c.complete(VecMat.fromPointer(mats).toList());
    },
  );
}

Future<Mat> getBlobChannelAsync(Mat blob, int imgidx, int chnidx) async {
  final m = Mat.empty();
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_getBlobChannel(blob.ref, imgidx, chnidx, m.ptr, callback),
    (c) {
      return c.complete(m);
    },
  );
}

Future<List<int>> NMSBoxesAsync(
  VecRect bboxes,
  VecF32 scores,
  double scoreThreshold,
  double nmsThreshold, {
  double eta = 1.0,
  int topK = 0,
}) async {
  final indices = calloc<cvg.VecI32>();
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_NMSBoxes_1(
      bboxes.ref,
      scores.ref,
      scoreThreshold,
      nmsThreshold,
      indices,
      eta,
      topK,
      callback,
    ),
    (c) {
      return c.complete(VecI32.fromPointer(indices).toList());
    },
  );
}
