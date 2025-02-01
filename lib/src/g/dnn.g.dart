// coverage:ignore-file
// opencv_dart - OpenCV bindings for Dart language
//    some c wrappers were from gocv: https://github.com/hybridgroup/gocv
//    License: Apache-2.0 https://github.com/hybridgroup/gocv/blob/release/LICENSE.txt
// Author: Rainyl
// License: Apache-2.0
// Date: 2024/01/28

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
@ffi.DefaultAsset('package:dartcv4/dartcv.dart')
library;

import 'dart:ffi' as ffi;
import 'package:dartcv4/src/g/types.g.dart' as imp1;
import '' as self;

@ffi.Native<ffi.Void Function(AsyncArrayPtr)>()
external void cv_dnn_AsyncArray_close(
  AsyncArrayPtr a,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(AsyncArray, Mat)>()
external ffi.Pointer<CvStatus> cv_dnn_AsyncArray_get(
  AsyncArray async_out,
  Mat out,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(ffi.Pointer<AsyncArray>)>()
external ffi.Pointer<CvStatus> cv_dnn_AsyncArray_new(
  ffi.Pointer<AsyncArray> rval,
);

@ffi.Native<ffi.Void Function(LayerPtr)>()
external void cv_dnn_Layer_close(
  LayerPtr layer,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(Layer, ffi.Pointer<ffi.Pointer<ffi.Char>>)>()
external ffi.Pointer<CvStatus> cv_dnn_Layer_getName(
  Layer layer,
  ffi.Pointer<ffi.Pointer<ffi.Char>> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(Layer, ffi.Pointer<ffi.Pointer<ffi.Char>>)>()
external ffi.Pointer<CvStatus> cv_dnn_Layer_getType(
  Layer layer,
  ffi.Pointer<ffi.Pointer<ffi.Char>> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Layer, ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Int>)>()
external ffi.Pointer<CvStatus> cv_dnn_Layer_inputNameToIndex(
  Layer layer,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Int> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Layer, ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Int>)>()
external ffi.Pointer<CvStatus> cv_dnn_Layer_outputNameToIndex(
  Layer layer,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Int> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(VecRect, VecF32, ffi.Float, ffi.Float,
        ffi.Pointer<VecI32>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_NMSBoxes(
  VecRect bboxes,
  VecF32 scores,
  double score_threshold,
  double nms_threshold,
  ffi.Pointer<VecI32> out_indices,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(VecRect, VecF32, ffi.Float, ffi.Float,
        ffi.Pointer<VecI32>, ffi.Float, ffi.Int, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_NMSBoxes_1(
  VecRect bboxes,
  VecF32 scores,
  double score_threshold,
  double nms_threshold,
  ffi.Pointer<VecI32> indices,
  double eta,
  int top_k,
  imp1.CvCallback_0 callback,
);

@ffi.Native<ffi.Void Function(NetPtr)>()
external void cv_dnn_Net_close(
  NetPtr net,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(ffi.Pointer<Net>)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_create(
  ffi.Pointer<Net> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(Net, ffi.Pointer<ffi.Pointer<ffi.Char>>)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_dump(
  Net net,
  ffi.Pointer<ffi.Pointer<ffi.Char>> rval,
);

@ffi.Native<ffi.Bool Function(Net)>()
external bool cv_dnn_Net_empty(
  Net net,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<ffi.Char>, ffi.Pointer<Mat>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_forward(
  Net net,
  ffi.Pointer<ffi.Char> outputName,
  ffi.Pointer<Mat> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<ffi.Char>, ffi.Pointer<AsyncArray>)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_forwardAsync(
  Net net,
  ffi.Pointer<ffi.Char> outputName,
  ffi.Pointer<AsyncArray> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<VecMat>, VecVecChar, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_forwardLayers(
  Net net,
  ffi.Pointer<VecMat> outputBlobs,
  VecVecChar outBlobNames,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(Net, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_fromNet(
  Net net,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<VecF32>, ffi.Pointer<VecI32>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_getInputDetails(
  Net net,
  ffi.Pointer<VecF32> scales,
  ffi.Pointer<VecI32> zeropoints,
  imp1.CvCallback_0 callback,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(Net, ffi.Int, ffi.Pointer<Layer>)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_getLayer(
  Net net,
  int layerid,
  ffi.Pointer<Layer> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<VecVecChar>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_getLayerNames(
  Net net,
  ffi.Pointer<VecVecChar> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<ffi.Int64>, ffi.Pointer<VecF64>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_getPerfProfile(
  Net net,
  ffi.Pointer<ffi.Int64> rval,
  ffi.Pointer<VecF64> layersTimes,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<VecI32>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_getUnconnectedOutLayers(
  Net net,
  ffi.Pointer<VecI32> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Net, ffi.Pointer<VecVecChar>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_getUnconnectedOutLayersNames(
  Net net,
  ffi.Pointer<VecVecChar> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNet(
  ffi.Pointer<ffi.Char> model,
  ffi.Pointer<ffi.Char> config,
  ffi.Pointer<ffi.Char> framework,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, VecUChar, VecUChar,
        ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetBytes(
  ffi.Pointer<ffi.Char> framework,
  VecUChar model,
  VecUChar config,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>,
        ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromCaffe(
  ffi.Pointer<ffi.Char> prototxt,
  ffi.Pointer<ffi.Char> caffeModel,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        VecUChar, VecUChar, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromCaffeBytes(
  VecUChar prototxt,
  VecUChar caffeModel,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        ffi.Pointer<ffi.Char>, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromONNX(
  ffi.Pointer<ffi.Char> model,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        VecUChar, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromONNXBytes(
  VecUChar model,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        ffi.Pointer<ffi.Char>, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromTFLite(
  ffi.Pointer<ffi.Char> model,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        VecUChar, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromTFLiteBytes(
  VecUChar bufferModel,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>,
        ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromTensorflow(
  ffi.Pointer<ffi.Char> model,
  ffi.Pointer<ffi.Char> config,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        VecUChar, VecUChar, ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromTensorflowBytes(
  VecUChar model,
  VecUChar config,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(ffi.Pointer<ffi.Char>, ffi.Bool, ffi.Bool,
        ffi.Pointer<Net>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_readNetFromTorch(
  ffi.Pointer<ffi.Char> model,
  bool isBinary,
  bool evaluate,
  ffi.Pointer<Net> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(Net, Mat, ffi.Pointer<ffi.Char>, ffi.Double,
        Scalar, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_setInput(
  Net net,
  Mat blob,
  ffi.Pointer<ffi.Char> name,
  double scalefactor,
  Scalar mean,
  imp1.CvCallback_0 callback,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(Net, ffi.Int)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_setPreferableBackend(
  Net net,
  int backend,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(Net, ffi.Int)>()
external ffi.Pointer<CvStatus> cv_dnn_Net_setPreferableTarget(
  Net net,
  int target,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(Mat, Mat, ffi.Double, CvSize, Scalar,
        ffi.Bool, ffi.Bool, ffi.Int, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_blobFromImage(
  Mat image,
  Mat blob,
  double scalefactor,
  CvSize size,
  Scalar mean,
  bool swapRB,
  bool crop,
  int ddepth,
  imp1.CvCallback_0 callback,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(VecMat, Mat, ffi.Double, CvSize, Scalar,
        ffi.Bool, ffi.Bool, ffi.Int, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_blobFromImages(
  VecMat images,
  Mat blob,
  double scalefactor,
  CvSize size,
  Scalar mean,
  bool swapRB,
  bool crop,
  int ddepth,
  imp1.CvCallback_0 callback,
);

@ffi.Native<ffi.Void Function(ffi.Bool)>()
external void cv_dnn_enableModelDiagnostics(
  bool isDiagnosticsMode,
);

@ffi.Native<ffi.Void Function(ffi.Pointer<VecPoint>)>()
external void cv_dnn_getAvailableBackends(
  ffi.Pointer<VecPoint> rval,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(ffi.Int, ffi.Pointer<VecI32>)>()
external ffi.Pointer<CvStatus> cv_dnn_getAvailableTargets(
  int be,
  ffi.Pointer<VecI32> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Mat, ffi.Int, ffi.Int, ffi.Pointer<Mat>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_getBlobChannel(
  Mat blob,
  int imgidx,
  int chnidx,
  ffi.Pointer<Mat> rval,
  imp1.CvCallback_0 callback,
);

@ffi.Native<ffi.Pointer<CvStatus> Function(Mat, ffi.Pointer<VecI32>)>()
external ffi.Pointer<CvStatus> cv_dnn_getBlobSize(
  Mat blob,
  ffi.Pointer<VecI32> rval,
);

@ffi.Native<
    ffi.Pointer<CvStatus> Function(
        Mat, ffi.Pointer<VecMat>, imp1.CvCallback_0)>()
external ffi.Pointer<CvStatus> cv_dnn_imagesFromBlob(
  Mat blob,
  ffi.Pointer<VecMat> rval,
  imp1.CvCallback_0 callback,
);

const addresses = _SymbolAddresses();

class _SymbolAddresses {
  const _SymbolAddresses();
  ffi.Pointer<ffi.NativeFunction<ffi.Void Function(AsyncArrayPtr)>>
      get cv_dnn_AsyncArray_close =>
          ffi.Native.addressOf(self.cv_dnn_AsyncArray_close);
  ffi.Pointer<ffi.NativeFunction<ffi.Void Function(LayerPtr)>>
      get cv_dnn_Layer_close => ffi.Native.addressOf(self.cv_dnn_Layer_close);
  ffi.Pointer<ffi.NativeFunction<ffi.Void Function(NetPtr)>>
      get cv_dnn_Net_close => ffi.Native.addressOf(self.cv_dnn_Net_close);
}

final class AsyncArray extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

typedef AsyncArrayPtr = ffi.Pointer<AsyncArray>;
typedef CvSize = imp1.CvSize;
typedef CvStatus = imp1.CvStatus;

final class Layer extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

typedef LayerPtr = ffi.Pointer<Layer>;
typedef Mat = imp1.Mat;

final class Net extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

typedef NetPtr = ffi.Pointer<Net>;
typedef Scalar = imp1.Scalar;
typedef VecF32 = imp1.VecF32;
typedef VecF64 = imp1.VecF64;
typedef VecI32 = imp1.VecI32;
typedef VecMat = imp1.VecMat;
typedef VecPoint = imp1.VecPoint;
typedef VecRect = imp1.VecRect;
typedef VecUChar = imp1.VecUChar;
typedef VecVecChar = imp1.VecVecChar;
