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

class Layer extends CvStruct<cvg.Layer> {
  Layer._(cvg.LayerPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Layer.fromPointer(cvg.LayerPtr ptr, [bool attach = true]) => Layer._(ptr, attach);

  static final finalizer = OcvFinalizer<cvg.LayerPtr>(CFFI.addresses.Layer_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.Layer_Close(ptr);
  }

  Future<String> getNameAsync() async {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    final rval = cvRunAsync<String>(
      (callback) => CFFI.Layer_GetName_Async(ref, callback),
      (c, result) {
        final rval = result.cast<Utf8>().toDartString();
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<String> getTypeAsync() async {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    final rval = cvRunAsync<String>(
      (callback) => CFFI.Layer_GetType_Async(ref, callback),
      (c, result) {
        final rval = result.cast<Utf8>().toDartString();
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<int> inputNameToIndexAsync(String name) async {
    final cName = name.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<int>(
      (callback) => CFFI.Layer_InputNameToIndex_Async(ref, cName, callback),
      (c, p) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    calloc.free(cName);

    return rval;
  }

  Future<int> outputNameToIndexAsync(String name) async {
    final cName = name.toNativeUtf8().cast<ffi.Char>();
    final rval = cvRunAsync<int>(
      (callback) => CFFI.Layer_OutputNameToIndex_Async(ref, cName, callback),
      (c, p) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    calloc.free(cName);
    return rval;
  }

  @override
  List<int> get props => [ptr.address];
  @override
  cvg.Layer get ref => ptr.ref;
}

class Net extends CvStruct<cvg.Net> {
  Net._(cvg.NetPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Net.empty() {
    final p = calloc<cvg.Net>();
    cvRun(() => CFFI.Net_Create(p));
    return Net._(p);
  }

  factory Net.fromFile(String path, {String config = "", String framework = ""}) {
    return using<Net>((arena) {
      final cPath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cConfig = config.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cFramework = framework.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = calloc<cvg.Net>();
      cvRun(() => CFFI.Net_ReadNet(cPath, cConfig, cFramework, p));
      return Net._(p);
    });
  }

  factory Net.fromBytes(String framework, Uint8List bufferModel, {Uint8List? bufferConfig}) {
    return using<Net>((arena) {
      bufferConfig ??= Uint8List(0);
      final cFramework = framework.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final bufM = VecUChar.fromList(bufferModel);
      final bufC = VecUChar.fromList(bufferConfig!);
      final p = calloc<cvg.Net>();
      cvRun(() => CFFI.Net_ReadNetBytes(cFramework, bufM.ref, bufC.ref, p));
      return Net._(p);
    });
  }

  factory Net.fromCaffe(String prototxt, String caffeModel) {
    return using<Net>((arena) {
      final cProto = prototxt.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cCaffe = caffeModel.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = calloc<cvg.Net>();
      cvRun(() => CFFI.Net_ReadNetFromCaffe(cProto, cCaffe, p));
      return Net._(p);
    });
  }

  factory Net.fromCaffeBytes(Uint8List bufferProto, Uint8List bufferModel) {
    final p = calloc<cvg.Net>();
    final bufP = VecUChar.fromList(bufferProto);
    final bufM = VecUChar.fromList(bufferModel);
    cvRun(() => CFFI.Net_ReadNetFromCaffeBytes(bufP.ref, bufM.ref, p));
    return Net._(p);
  }

  factory Net.fromOnnx(String path) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => CFFI.Net_ReadNetFromONNX(cpath, p));
      return Net._(p);
    });
  }

  factory Net.fromOnnxBytes(Uint8List bufferModel) {
    final p = calloc<cvg.Net>();
    final bufM = VecUChar.fromList(bufferModel);
    cvRun(() => CFFI.Net_ReadNetFromONNXBytes(bufM.ref, p));
    return Net._(p);
  }

  factory Net.fromTensorflow(String path, {String config = ""}) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cconf = config.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => CFFI.Net_ReadNetFromTensorflow(cpath, cconf, p));
      return Net._(p);
    });
  }

  factory Net.fromTensorflowBytes(Uint8List bufferModel, {Uint8List? bufferConfig}) {
    bufferConfig ??= Uint8List(0);
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final p = calloc<cvg.Net>();
    cvRun(() => CFFI.Net_ReadNetFromTensorflowBytes(bufM.ref, bufC.ref, p));
    return Net._(p);
  }

  factory Net.fromTFLite(String path) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => CFFI.Net_ReadNetFromTFLite(cpath, p));
      return Net._(p);
    });
  }

  factory Net.fromTFLiteBytes(Uint8List bufferModel) {
    final bufM = VecUChar.fromList(bufferModel);
    final p = calloc<cvg.Net>();
    cvRun(() => CFFI.Net_ReadNetFromTFLiteBytes(bufM.ref, p));
    return Net._(p);
  }

  factory Net.fromTorch(String path, {bool isBinary = true, bool evaluate = true}) {
    return using<Net>((arena) {
      final p = calloc<cvg.Net>();
      final cpath = path.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => CFFI.Net_ReadNetFromTorch(cpath, isBinary, evaluate, p));
      return Net._(p);
    });
  }

  Future<bool> isEmptyAsync() async {
    final rval = cvRunAsync<bool>(
      (callback) => CFFI.Net_Empty_Async(ref, callback),
      (c, p) {
        final rval = p.cast<ffi.Bool>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<String> dumpAsync() async {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    final rval = cvRunAsync<String>(
      (callback) => CFFI.Net_Dump_Async(ref, callback),
      (c, result) {
        final rval = result.cast<Utf8>().toDartString();
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<void> setInputAsync(InputArray blob, {String name = ""}) async {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    await cvRunAsync0<void>(
      (callback) => CFFI.Net_SetInput_Async(ref, blob.ref, cname, callback),
      (c) {
        return c.complete();
      },
    );
    calloc.free(cname);
  }

  Future<Mat> forwardAsync({String outputName = ""}) async {
    final rval = cvRunAsync<Mat>(
      (callback) => CFFI.Net_Forward_Async(ref, outputName.toNativeUtf8().cast<ffi.Char>(), callback),
      (c, result) => c.complete(Mat.fromPointer(result.cast<cvg.Mat>())),
    );
    return rval;
  }

  Future<VecMat> forwardLayersAsync(List<String> names) async {
    final vecName = names.i8;
    final rval = cvRunAsync<VecMat>(
      (callback) => CFFI.Net_ForwardLayers_Async(ref, vecName.ref, callback),
      (c, result) => c.complete(VecMat.fromPointer(result.cast<cvg.VecMat>())),
    );
    return rval;
  }

  Future<void> setPreferableBackendAsync(int backendId) async {
    await cvRunAsync0<void>(
      (callback) => CFFI.Net_SetPreferableBackend_Async(ref, backendId, callback),
      (c) => c.complete(),
    );
  }

  Future<void> setPreferableTargetAsync(int targetId) async {
    await cvRunAsync0<void>(
      (callback) => CFFI.Net_SetPreferableTarget_Async(ref, targetId, callback),
      (c) => c.complete(),
    );
  }

  Future<int> getPerfProfileAsync() async {
    final rval = cvRunAsync<int>(
      (callback) => CFFI.Net_GetPerfProfile_Async(ref, callback),
      (c, p) {
        final rval = p.cast<ffi.Int64>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<VecInt> getUnconnectedOutLayersAsync() async {
    final rval = cvRunAsync<VecInt>(
      (callback) => CFFI.Net_GetUnconnectedOutLayers_Async(ref, callback),
      (c, result) => c.complete(VecInt.fromPointer(result.cast<cvg.VecInt>())),
    );
    return rval;
  }

  Future<List<String>> getLayerNamesAsync() async {
    final rval = cvRunAsync<List<String>>(
      (callback) => CFFI.Net_GetLayerNames_Async(ref, callback),
      (c, result) => c.complete(VecVecChar.fromPointer(result.cast<cvg.VecVecChar>()).asStringList()),
    );
    return rval;
  }

  Future<(VecFloat, VecInt)> getInputDetailsAsync() async {
    final rval = cvRunAsync2<(VecFloat, VecInt)>(
      (callback) => CFFI.Net_GetInputDetails_Async(ref, callback),
      (c, sc, zp) => c.complete(
          (VecFloat.fromPointer(sc.cast<cvg.VecFloat>()), VecInt.fromPointer(zp.cast<cvg.VecInt>()))),
    );
    return rval;
  }

  Future<Mat> getBlobChannelAsync(Mat blob, int imgidx, int chnidx) async {
    final rval = cvRunAsync<Mat>(
      (callback) => CFFI.Net_GetBlobChannel_Async(blob.ref, imgidx, chnidx, callback),
      (c, result) => c.complete(Mat.fromPointer(result.cast<cvg.Mat>())),
    );
    return rval;
  }

  Future<Scalar> getBlobSizeAsync(Mat blob) async {
    final rval = cvRunAsync<Scalar>(
      (callback) => CFFI.Net_GetBlobSize_Async(blob.ref, callback),
      (c, result) => c.complete(Scalar.fromPointer(result.cast<cvg.Scalar>())),
    );
    return rval;
  }

  Future<Layer> getLayerAsync(int index) async {
    final rval = cvRunAsync<Layer>(
      (callback) => CFFI.Net_GetLayer_Async(ref, index, callback),
      (c, result) => c.complete(Layer.fromPointer(result.cast<cvg.Layer>())),
    );
    return rval;
  }

  static Future<Mat> blobFromImageAsync(
    InputArray image, {
    double scalefactor = 1.0,
    (int, int) size = (0, 0),
    Scalar? mean,
    bool swapRB = false,
    bool crop = false,
    int ddepth = MatType.CV_32F,
  }) async {
    mean ??= Scalar.zeros;
    final rval = await cvRunAsync<Mat>(
      (callback) => CFFI.Net_BlobFromImage_Async(
        image.ref,
        scalefactor,
        size.cvd.ref,
        mean!.ref,
        swapRB,
        crop,
        ddepth,
        callback,
      ),
      (c, mat) => c.complete(Mat.fromPointer(mat.cast<cvg.Mat>())),
    );
    return rval;
  }

  static Future<Mat> blobFromImagesAsync(
    VecMat images, {
    double scalefactor = 1.0,
    (int, int) size = (0, 0),
    Scalar? mean,
    bool swapRB = false,
    bool crop = false,
    int ddepth = MatType.CV_32F,
  }) async {
    mean ??= Scalar.zeros;
    final rval = await cvRunAsync<Mat>(
      (callback) => CFFI.Net_BlobFromImages_Async(
        images.ref,
        scalefactor,
        size.cvd.ref,
        mean!.ref,
        swapRB,
        crop,
        ddepth,
        callback,
      ),
      (c, blob) => c.complete(Mat.fromPointer(blob.cast<cvg.Mat>())),
    );
    return rval;
  }

  static Future<List<Mat>> imagesFromBlobAsync(Mat blob) async {
    final rval = cvRunAsync<List<Mat>>(
      (callback) => CFFI.Net_ImagesFromBlob_Async(blob.ref, callback),
      (c, result) => c.complete(VecMat.fromPointer(result.cast<cvg.VecMat>()).toList()),
    );
    return rval;
  }

  static Future<List<int>> NMSBoxesAsync(
    VecRect bboxes,
    VecFloat scores,
    double scoreThreshold,
    double nmsThreshold, {
    double eta = 1.0,
    int topK = 0,
  }) async {
    final rval = cvRunAsync<List<int>>(
      (callback) => CFFI.NMSBoxesWithParams_Async(
        bboxes.ref,
        scores.ref,
        scoreThreshold,
        nmsThreshold,
        eta,
        topK,
        callback,
      ),
      (c, result) => c.complete(VecInt.fromPointer(result.cast<cvg.VecInt>()).toList()),
    );
    return rval;
  }

  static final finalizer = OcvFinalizer<cvg.NetPtr>(CFFI.addresses.Net_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.Net_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
  @override
  cvg.Net get ref => ptr.ref;
}
