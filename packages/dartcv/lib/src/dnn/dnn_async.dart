// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv.dnn;

import 'dart:typed_data';

import '../bindings/dnn.dart' as cdnn;
import '../bindings/dnn.dart' as cvg;
import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';
import './dnn.dart';

extension NetAsync on Net {
  static Future<Net> fromFileAsync(String path, {String config = "", String framework = ""}) {
    // The paths are owned by the arena until the job stops reading them: `release` runs when it
    // reports, not when this call returns (the job is queued, not started).
    final arena = Arena();
    final p = calloc<cvg.Net>();
    return cvRunAsync0<Net>(
      (callback) => cdnn.cv_dnn_Net_readNet(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        config.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        framework.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromBytesAsync(
    String framework,
    Uint8List bufferModel, {
    Uint8List? bufferConfig,
    Duration? timeout,
  }) {
    bufferConfig ??= Uint8List(0);
    final arena = Arena();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetBytes(
        framework.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        bufM.ref,
        bufC.ref,
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      timeout: timeout,
      release: () {
        arena.releaseAll();
        bufM.dispose();
        bufC.dispose();
      },
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromCaffeAsync(String prototxt, String caffeModel, {Duration? timeout}) {
    final arena = Arena();
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromCaffe(
        prototxt.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        caffeModel.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromCaffeBytesAsync(
    Uint8List bufferProto,
    Uint8List bufferModel, {
    Duration? timeout,
  }) async {
    final p = calloc<cvg.Net>();
    final bufP = VecUChar.fromList(bufferProto);
    final bufM = VecUChar.fromList(bufferModel);
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromCaffeBytes(bufP.ref, bufM.ref, p, callback),
      (
        c,
      ) {
        final net = Net.fromPointer(p);
        return c.complete(net);
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromOnnxAsync(String path, {Duration? timeout}) {
    final arena = Arena();
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromONNX(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromOnnxBytesAsync(Uint8List bufferModel, {Duration? timeout}) async {
    final p = calloc<cvg.Net>();
    final bufM = VecUChar.fromList(bufferModel);
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromONNXBytes(bufM.ref, p, callback),
      (c) {
        final net = Net.fromPointer(p);
        return c.complete(net);
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromTensorflowAsync(String path, {String config = "", Duration? timeout}) {
    final arena = Arena();
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromTensorflow(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        config.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromTensorflowBytesAsync(
    Uint8List bufferModel, {
    Uint8List? bufferConfig,
    Duration? timeout,
  }) async {
    bufferConfig ??= Uint8List(0);
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromTensorflowBytes(bufM.ref, bufC.ref, p, callback),
      (c) {
        final net = Net.fromPointer(p);
        return c.complete(net);
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromTFLiteAsync(String path, {Duration? timeout}) {
    final arena = Arena();
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromTFLite(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromTFLiteBytesAsync(Uint8List bufferModel, {Duration? timeout}) async {
    final bufM = VecUChar.fromList(bufferModel);
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromTFLiteBytes(bufM.ref, p, callback),
      (c) {
        final net = Net.fromPointer(p);
        return c.complete(net);
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static Future<Net> fromTorchAsync(
    String path, {
    bool isBinary = true,
    bool evaluate = true,
    Duration? timeout,
  }) {
    final arena = Arena();
    final p = calloc<cvg.Net>();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_readNetFromTorch(
        path.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        isBinary,
        evaluate,
        p,
        callback,
      ),
      (c) => c.complete(Net.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  Future<void> setInputAsync(
    InputArray blob, {
    String name = "",
    double scalefactor = 1.0,
    Scalar? mean,
    Duration? timeout,
  }) {
    mean ??= Scalar();
    final arena = Arena();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_setInput(
        ref,
        blob.ref,
        name.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        scalefactor,
        mean!.ref,
        callback,
      ),
      (c) => c.complete(),
      timeout: timeout,
      release: arena.releaseAll,
    );
  }

  Future<Mat> forwardAsync({String outputName = "", Duration? timeout}) async {
    final m = Mat.empty();
    final arena = Arena();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_forward(
        ref,
        outputName.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        m.ptr,
        callback,
      ),
      (c) => c.complete(m),
      timeout: timeout,
      release: arena.releaseAll,
    );
  }

  Future<VecMat> forwardLayersAsync(List<String> names, {Duration? timeout}) async {
    final vecName = names.i8;
    final vecMat = VecMat();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_forwardLayers(ref, vecMat.ptr, vecName.ref, callback), (
      c,
    ) {
      return c.complete(vecMat);
    }, timeout: timeout);
  }

  Future<(int, VecF64 layersTimes)> getPerfProfileAsync({Duration? timeout}) async {
    final p = calloc<ffi.Int64>();
    final p1 = VecF64();
    return cvRunAsync0(
      (callback) => cdnn.cv_dnn_Net_getPerfProfile(ref, p, p1.ptr, callback),
      (c) {
        final rval = p.value;
        return c.complete((rval, p1));
      },
      timeout: timeout,
      release: () => calloc.free(p),
    );
  }

  Future<VecI32> getUnconnectedOutLayersAsync({Duration? timeout}) async {
    final ids = VecI32();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_getUnconnectedOutLayers(ref, ids.ptr, callback), (c) {
      return c.complete(ids);
    }, timeout: timeout);
  }

  Future<List<String>> getLayerNamesAsync() async {
    final cNames = VecVecChar();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_getLayerNames(ref, cNames.ptr, callback), (c) {
      final vec = cNames.asStringList();
      cNames.dispose();
      return c.complete(vec);
    });
  }

  Future<(VecF32, VecI32)> getInputDetailsAsync({Duration? timeout}) async {
    final sc = VecF32();
    final zp = VecI32();
    return cvRunAsync0((callback) => cdnn.cv_dnn_Net_getInputDetails(ref, sc.ptr, zp.ptr, callback), (c) {
      return c.complete((sc, zp));
    }, timeout: timeout);
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
  Duration? timeout,
}) async {
  mean ??= Scalar.zeros;
  final blob = Mat.empty();
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_blobFromImage(
      image.ref,
      blob.ref,
      scalefactor,
      size.cvdRef,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      callback,
    ),
    (c) {
      return c.complete(blob);
    },
    timeout: timeout,
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
  Duration? timeout,
}) async {
  blob ??= Mat.empty();
  mean ??= Scalar.zeros;
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_blobFromImages(
      images.ref,
      blob!.ref,
      scalefactor,
      size.cvdRef,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      callback,
    ),
    (c) {
      return c.complete(blob);
    },
    timeout: timeout,
  );
}

Future<VecMat> imagesFromBlobAsync(Mat blob, {Duration? timeout}) async {
  final mats = VecMat();
  return cvRunAsync0((callback) => cdnn.cv_dnn_imagesFromBlob(blob.ref, mats.ptr, callback), (c) {
    return c.complete(mats);
  }, timeout: timeout);
}

Future<Mat> getBlobChannelAsync(Mat blob, int imgidx, int chnidx, {Duration? timeout}) async {
  final m = Mat.empty();
  return cvRunAsync0((callback) => cdnn.cv_dnn_getBlobChannel(blob.ref, imgidx, chnidx, m.ptr, callback), (
    c,
  ) {
    return c.complete(m);
  }, timeout: timeout);
}

Future<List<int>> NMSBoxesAsync(
  VecRect bboxes,
  VecF32 scores,
  double scoreThreshold,
  double nmsThreshold, {
  double eta = 1.0,
  int topK = 0,
}) async {
  final indices = VecI32();
  return cvRunAsync0(
    (callback) => cdnn.cv_dnn_NMSBoxes_1(
      bboxes.ref,
      scores.ref,
      scoreThreshold,
      nmsThreshold,
      indices.ptr,
      eta,
      topK,
      callback,
    ),
    (c) {
      return c.complete(indices.toList());
    },
  );
}
