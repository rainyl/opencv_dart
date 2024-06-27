library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class CascadeClassifier extends CvStruct<cvg.CascadeClassifier> {
  CascadeClassifier._(cvg.CascadeClassifierPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory CascadeClassifier.empty() {
    final p = calloc<cvg.CascadeClassifier>();
    cvRun(() => CFFI.CascadeClassifier_New(p));
    return CascadeClassifier._(p);
  }

  factory CascadeClassifier.fromFile(String filename) {
    final p = calloc<cvg.CascadeClassifier>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => CFFI.CascadeClassifier_NewFromFile(cp, p));
    calloc.free(cp);
    return CascadeClassifier._(p);
  }

  Future<bool> loadAsync(String name) async {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final rval =
        cvRunAsync<bool>((callback) => CFFI.CascadeClassifier_Load_Async(ref, cname, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value != 0;
      calloc.free(p);
      return c.complete(rval);
    });
    calloc.free(cname);

    return rval;
  }

  Future<VecRect> detectMultiScaleAsync(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) async {
    final rval = cvRunAsync<VecRect>(
        (callback) => CFFI.CascadeClassifier_DetectMultiScaleWithParams_Async(
              ref,
              image.ref,
              scaleFactor,
              minNeighbors,
              flags,
              minSize.cvd.ref,
              maxSize.cvd.ref,
              callback,
            ), (c, ret) {
      return c.complete(VecRect.fromPointer(ret.cast<cvg.VecRect>()));
    });
    return rval;
  }

  Future<(VecRect objects, VecInt numDetections)> detectMultiScale2Async(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) async {
    final rval = cvRunAsync2<(VecRect, VecInt)>(
        (callback) => CFFI.CascadeClassifier_DetectMultiScale2_Async(
              ref,
              image.ref,
              scaleFactor,
              minNeighbors,
              flags,
              minSize.cvd.ref,
              maxSize.cvd.ref,
              callback,
            ), (c, ret, pnums) {
      return c.complete(
        (VecRect.fromPointer(ret.cast<cvg.VecRect>()), VecInt.fromPointer(pnums.cast<cvg.VecInt>())),
      );
    });
    return rval;
  }

  Future<(VecRect objects, VecInt rejectLevels, VecDouble levelWeights)> detectMultiScale3Async(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
    bool outputRejectLevels = false,
  }) async {
    final rval = cvRunAsync3<(VecRect, VecInt, VecDouble)>(
      (callback) => CFFI.CascadeClassifier_DetectMultiScale3_Async(
        ref,
        image.ref,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        outputRejectLevels,
        callback,
      ),
      (c, p1, p2, p3) => c.complete(
        (
          VecRect.fromPointer(p1.cast<cvg.VecRect>()),
          VecInt.fromPointer(p2.cast<cvg.VecInt>()),
          VecDouble.fromPointer(p3.cast<cvg.VecDouble>())
        ),
      ),
    );
    return rval;
  }

  Future<bool> emptyAsync() async {
    final rval = cvRunAsync<bool>((callback) => CFFI.CascadeClassifier_Empty_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<int> getFeatureTypeAsync() async {
    final rval =
        cvRunAsync<int>((callback) => CFFI.CascadeClassifier_getFeatureType_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);

      return c.complete(rval);
    });
    return rval;
  }

  Future<(int, int)> getOriginalWindowSizeAsync() async {
    final rval = cvRunAsync<(int, int)>(
        (callback) => CFFI.CascadeClassifier_getOriginalWindowSize_Async(ref, callback), (c, p) {
      final size = p.cast<cvg.Size>().ref;
      final ret = (size.width, size.height);
      return c.complete(ret);
    });
    return rval;
  }

  Future<bool> isOldFormatCascadeAsync() async {
    final rval = cvRunAsync<bool>(
        (callback) => CFFI.CascadeClassifier_isOldFormatCascade_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  @override
  cvg.CascadeClassifier get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.CascadeClassifierPtr>(
    CFFI.addresses.CascadeClassifier_Close,
  );

  void dispose() {
    finalizer.detach(this);
    CFFI.CascadeClassifier_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

class HOGDescriptor extends CvStruct<cvg.HOGDescriptor> {
  HOGDescriptor._(cvg.HOGDescriptorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory HOGDescriptor.empty() {
    final p = calloc<cvg.HOGDescriptor>();
    cvRun(() => CFFI.HOGDescriptor_New(p));
    return HOGDescriptor._(p);
  }

  factory HOGDescriptor.fromFile(String filename) {
    final p = calloc<cvg.HOGDescriptor>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => CFFI.HOGDescriptor_NewFromFile(cp, p));
    calloc.free(cp);
    return HOGDescriptor._(p);
  }

  Future<bool> loadAsync(String name) async {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final rval = cvRunAsync<bool>((callback) => CFFI.HOGDescriptor_Load_Async(ref, cname, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);

      return c.complete(rval);
    });
    calloc.free(cname);
    return rval;
  }

  Future<(VecFloat descriptors, VecPoint locations)> computeAsync(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) async {
    final rval = cvRunAsync2<(VecFloat, VecPoint)>(
        (callback) => CFFI.HOGDescriptor_Compute_Async(
              ref,
              img.ref,
              winStride.cvd.ref,
              padding.cvd.ref,
              callback,
            ), (c, descriptors, locations) {
      return c.complete(
        (
          VecFloat.fromPointer(descriptors.cast<cvg.VecFloat>()),
          VecPoint.fromPointer(locations.cast<cvg.VecPoint>())
        ),
      );
    });
    return rval;
  }

  Future<(Mat grad, Mat angleOfs)> computeGradientAsync(
    InputArray img,
    Mat grad,
    Mat angleOfs, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
  }) async {
    final rval = cvRunAsync0<(Mat, Mat)>(
        (callback) => CFFI.HOGDescriptor_computeGradient_Async(
              ref,
              img.ref,
              grad.ref,
              angleOfs.ref,
              paddingTL.cvd.ref,
              paddingBR.cvd.ref,
              callback,
            ), (c) {
      return c.complete((grad, angleOfs));
    });
    return rval;
  }

  Future<(VecPoint foundLocations, VecDouble weights, VecPoint searchLocations)> detect2Async(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) async {
    final rval = cvRunAsync3<(VecPoint, VecDouble, VecPoint)>(
        (callback) => CFFI.HOGDescriptor_Detect_Async(
              ref,
              img.ref,
              hitThreshold,
              winStride.cvd.ref,
              padding.cvd.ref,
              callback,
            ), (c, foundLocations, weights, searchLocations) {
      return c.complete(
        (
          VecPoint.fromPointer(foundLocations.cast<cvg.VecPoint>()),
          VecDouble.fromPointer(weights.cast<cvg.VecDouble>()),
          VecPoint.fromPointer(searchLocations.cast<cvg.VecPoint>())
        ),
      );
    });
    return rval;
  }

  Future<(VecPoint foundLocations, VecPoint searchLocations)> detectAsync(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) async {
    final rval = cvRunAsync2<(VecPoint, VecPoint)>(
        (callback) => CFFI.HOGDescriptor_Detect2_Async(
              ref,
              img.ref,
              hitThreshold,
              winStride.cvd.ref,
              padding.cvd.ref,
              callback,
            ), (c, foundLocations, searchLocations) {
      return c.complete(
        (
          VecPoint.fromPointer(foundLocations.cast<cvg.VecPoint>()),
          VecPoint.fromPointer(searchLocations.cast<cvg.VecPoint>())
        ),
      );
    });
    return rval;
  }

  Future<VecRect> detectMultiScaleAsync(
    InputArray image, {
    double hitThreshold = 0,
    int minNeighbors = 3,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
    double scale = 1.05,
    double groupThreshold = 2.0,
    bool useMeanshiftGrouping = false,
  }) async {
    final rval = cvRunAsync<VecRect>(
        (callback) => CFFI.HOGDescriptor_DetectMultiScaleWithParams_Async(
              ref,
              image.ref,
              hitThreshold,
              winStride.cvd.ref,
              padding.cvd.ref,
              scale,
              groupThreshold,
              useMeanshiftGrouping,
              callback,
            ), (c, rects) {
      return c.complete(VecRect.fromPointer(rects.cast<cvg.VecRect>()));
    });
    return rval;
  }

  static Future<VecFloat> getDefaultPeopleDetectorAsync() async {
    final rval = cvRunAsync<VecFloat>(CFFI.HOG_GetDefaultPeopleDetector_Async, (c, v) {
      return c.complete(VecFloat.fromPointer(v.cast<cvg.VecFloat>()));
    });
    return rval;
  }

  static Future<VecFloat> getDaimlerPeopleDetectorAsync() async {
    final rval = cvRunAsync<VecFloat>(CFFI.HOGDescriptor_getDaimlerPeopleDetector_Async, (c, v) {
      return c.complete(VecFloat.fromPointer(v.cast<cvg.VecFloat>()));
    });
    return rval;
  }

  Future<int> getDescriptorSizeAsync() async {
    final rval =
        cvRunAsync<int>((callback) => CFFI.HOGDescriptor_getDescriptorSize_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Size>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<double> getWinSigmaAsync() async {
    final rval =
        cvRunAsync<double>((callback) => CFFI.HOGDescriptor_getWinSigma_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<(VecRect rectList, VecDouble weights)> groupRectanglesAsync(
    VecRect rectList,
    VecDouble weights,
    int groupThreshold,
    double eps,
  ) async {
    final rval = cvRunAsync0<(VecRect, VecDouble)>(
        (callback) => CFFI.HOGDescriptor_groupRectangles_Async(
              ref,
              rectList.ref,
              weights.ref,
              groupThreshold,
              eps,
              callback,
            ), (c) {
      return c.complete((rectList, weights));
    });
    return rval;
  }

  Future<void> setSVMDetectorAsync(VecFloat det) async {
    await cvRunAsync0<void>((callback) => CFFI.HOGDescriptor_SetSVMDetector_Async(ref, det.ref, callback),
        (c) {
      return c.complete();
    });
  }

  @override
  cvg.HOGDescriptor get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.HOGDescriptorPtr>(CFFI.addresses.HOGDescriptor_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.HOGDescriptor_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

Future<VecRect> groupRectanglesAsync(
  VecRect rects,
  int groupThreshold,
  double eps,
) async {
  final rval = cvRunAsync0<VecRect>(
      (callback) => CFFI.GroupRectangles_Async(rects.ref, groupThreshold, eps, callback), (c) {
    return c.complete(rects);
  });
  return rval;
}

class QRCodeDetector extends CvStruct<cvg.QRCodeDetector> {
  QRCodeDetector._(cvg.QRCodeDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory QRCodeDetector.empty() {
    final p = calloc<cvg.QRCodeDetector>();
    cvRun(() => CFFI.QRCodeDetector_New(p));
    return QRCodeDetector._(p);
  }

  Future<(String rval, Mat straightQRcode)> decodeCurvedAsync(
    InputArray img,
    VecPoint points, {
    OutputArray? straightQRcode,
  }) async {
    final rval = cvRunAsync2<(String, Mat)>(
        (callback) => CFFI.QRCodeDetector_decodeCurved_Async(
              ref,
              img.ref,
              points.ref,
              callback,
            ), (c, rval, straightQRcode) {
      return c.complete(
        (rval.cast<Utf8>().toDartString(), Mat.fromPointer(straightQRcode.cast<cvg.Mat>())),
      );
    });
    return rval;
  }

  Future<(String rval, VecPoint points, Mat straightQRcode)> detectAndDecodeCurvedAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
  }) async {
    final rval = cvRunAsync3<(String, VecPoint, Mat)>(
        (callback) => CFFI.QRCodeDetector_detectAndDecodeCurved_Async(
              ref,
              img.ref,
              callback,
            ), (c, rval, points, straightQRcode) {
      return c.complete(
        (
          rval.cast<Utf8>().toDartString(),
          VecPoint.fromPointer(points.cast<cvg.VecPoint>()),
          Mat.fromPointer(straightQRcode.cast<cvg.Mat>()),
        ),
      );
    });
    return rval;
  }

  Future<(String ret, VecPoint points, Mat straightCode)> detectAndDecodeAsync(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
  }) async {
    final rval = cvRunAsync3<(String, VecPoint, Mat)>(
        (callback) => CFFI.QRCodeDetector_DetectAndDecode_Async(ref, img.ref, callback),
        (c, ret, points, straightCode) {
      return c.complete(
        (
          ret.cast<Utf8>().toDartString(),
          VecPoint.fromPointer(points.cast<cvg.VecPoint>()),
          Mat.fromPointer(straightCode.cast<cvg.Mat>()),
        ),
      );
    });
    return rval;
  }

  Future<(bool ret, VecPoint points)> detectAsync(
    InputArray input, {
    VecPoint? points,
  }) async {
    final rval = cvRunAsync2<(bool, VecPoint)>(
        (callback) => CFFI.QRCodeDetector_Detect_Async(ref, input.ref, callback), (c, ret, points) {
      final retValue = ret.cast<ffi.Bool>().value;
      calloc.free(ret);
      return c.complete(
        (retValue, VecPoint.fromPointer(points.cast<cvg.VecPoint>())),
      );
    });
    return rval;
  }

  Future<(String ret, VecPoint? points, Mat? straightCode)> decodeAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightCode,
  }) async {
    final rval = cvRunAsync3<(String, VecPoint, Mat)>(
        (callback) => CFFI.QRCodeDetector_Decode_Async(ref, img.ref, callback),
        (c, ret, points, straightCode) {
      return c.complete(
        (
          ret.cast<Utf8>().toDartString(),
          VecPoint.fromPointer(points.cast<cvg.VecPoint>()),
          Mat.fromPointer(straightCode.cast<cvg.Mat>()),
        ),
      );
    });
    return rval;
  }

  Future<(bool ret, VecPoint points)> detectMultiAsync(
    InputArray img, {
    VecPoint? points,
  }) async {
    final rval = cvRunAsync2<(bool, VecPoint)>(
        (callback) => CFFI.QRCodeDetector_DetectMulti_Async(ref, img.ref, callback), (c, ret, points) {
      final retValue = ret.cast<ffi.Bool>().value;
      calloc.free(ret);
      return c.complete((retValue, VecPoint.fromPointer(points.cast<cvg.VecPoint>())));
    });
    return rval;
  }

  Future<(bool, List<String>, VecPoint, VecMat)> detectAndDecodeMultiAsync(
    InputArray img,
  ) async {
    final ret = cvRunAsync4<(bool, List<String>, VecPoint, VecMat)>(
        (callback) => CFFI.QRCodeDetector_DetectAndDecodeMulti_Async(
              ref,
              img.ref,
              callback,
            ), (c, info, points, codes, rval) {
      final rvalValue = rval.cast<ffi.Bool>().value;
      calloc.free(rval);
      final ret = (
        rvalValue,
        VecVecChar.fromPointer(info.cast<cvg.VecVecChar>()).asStringList(),
        VecPoint.fromPointer(points.cast<cvg.VecPoint>()),
        VecMat.fromPointer(codes.cast<cvg.VecMat>())
      );
      return c.complete(ret);
    });
    return ret;
  }

  Future<void> setEpsXAsync(double epsX) async {
    await cvRunAsync0<void>((callback) => CFFI.QRCodeDetector_setEpsX_Async(ref, epsX, callback), (c) {
      return c.complete();
    });
  }

  Future<void> setEpsYAsync(double epsY) async {
    await cvRunAsync0<void>((callback) => CFFI.QRCodeDetector_setEpsY_Async(ref, epsY, callback), (c) {
      return c.complete();
    });
  }

  Future<void> setUseAlignmentMarkersAsync(bool useAlignmentMarkers) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.QRCodeDetector_setUseAlignmentMarkers_Async(
              ref,
              useAlignmentMarkers,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  @override
  cvg.QRCodeDetector get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.QRCodeDetectorPtr>(CFFI.addresses.QRCodeDetector_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.QRCodeDetector_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

class FaceDetectorYN extends CvStruct<cvg.FaceDetectorYN> {
  FaceDetectorYN._(cvg.FaceDetectorYNPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory FaceDetectorYN.fromFile(
    String model,
    String config,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cvg.FaceDetectorYN>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => CFFI.FaceDetectorYN_New(
        cModel,
        cConfig,
        inputSize.cvd.ref,
        scoreThreshold,
        nmsThreshold,
        topK,
        backendId,
        targetId,
        p,
      ),
    );
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceDetectorYN._(p);
  }

  factory FaceDetectorYN.fromBuffer(
    String framework,
    Uint8List bufferModel,
    Uint8List bufferConfig,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cvg.FaceDetectorYN>();
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => CFFI.FaceDetectorYN_NewFromBuffer(
        cFramework,
        VecUChar.fromList(bufferModel).ref,
        VecUChar.fromList(bufferConfig).ref,
        inputSize.cvd.ref,
        scoreThreshold,
        nmsThreshold,
        topK,
        backendId,
        targetId,
        p,
      ),
    );
    calloc.free(cFramework);
    return FaceDetectorYN._(p);
  }

  Future<(int, int)> getInputSizeAsync() async {
    final rval =
        cvRunAsync<(int, int)>((callback) => CFFI.FaceDetectorYN_GetInputSize_Async(ref, callback), (c, p) {
      final size = p.cast<cvg.Size>().ref;
      final ret = (size.width, size.height);
      return c.complete(ret);
    });
    return rval;
  }

  Future<double> getScoreThresholdAsync() async {
    final rval =
        cvRunAsync<double>((callback) => CFFI.FaceDetectorYN_GetScoreThreshold_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<double> getNmsThresholdAsync() async {
    final rval =
        cvRunAsync<double>((callback) => CFFI.FaceDetectorYN_GetNMSThreshold_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<int> getTopKAsync() async {
    final rval = cvRunAsync<int>((callback) => CFFI.FaceDetectorYN_GetTopK_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<Mat> detectAsync(Mat image) async {
    final rval =
        cvRunAsync<Mat>((callback) => CFFI.FaceDetectorYN_Detect_Async(ref, image.ref, callback), (c, p) {
      return c.complete(Mat.fromPointer(p.cast<cvg.Mat>()));
    });
    return rval;
  }

  Future<void> setInputSizeAsync((int, int) inputSize) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.FaceDetectorYN_SetInputSize_Async(
              ref,
              inputSize.cvd.ref,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  Future<void> setScoreThresholdAsync(double scoreThreshold) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.FaceDetectorYN_SetScoreThreshold_Async(
              ref,
              scoreThreshold,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  Future<void> setNMSThresholdAsync(double nmsThreshold) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.FaceDetectorYN_SetNMSThreshold_Async(
              ref,
              nmsThreshold,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  Future<void> setTopKAsync(int topK) async {
    await cvRunAsync0<void>((callback) => CFFI.FaceDetectorYN_SetTopK_Async(ref, topK, callback), (c) {
      return c.complete();
    });
  }

  @override
  cvg.FaceDetectorYN get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.FaceDetectorYNPtr>(CFFI.addresses.FaceDetectorYN_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.FaceDetectorYN_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

class FaceRecognizerSF extends CvStruct<cvg.FaceRecognizerSF> {
  FaceRecognizerSF._(cvg.FaceRecognizerSFPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory FaceRecognizerSF.fromFile(
    String model,
    String config, {
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cvg.FaceRecognizerSF>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => CFFI.FaceRecognizerSF_New(cModel, cConfig, backendId, targetId, p),
    );
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceRecognizerSF._(p);
  }

  Future<Mat> alignCropAsync(Mat srcImg, Mat faceBox) async {
    final rval = cvRunAsync<Mat>(
        (callback) => CFFI.FaceRecognizerSF_AlignCrop_Async(
              ref,
              srcImg.ref,
              faceBox.ref,
              callback,
            ), (c, p) {
      return c.complete(Mat.fromPointer(p.cast<cvg.Mat>()));
    });
    return rval;
  }

  Future<Mat> featureAsync(Mat alignedImg, {bool clone = false}) async {
    final rval = cvRunAsync<Mat>(
        (callback) => CFFI.FaceRecognizerSF_Feature_Async(
              ref,
              alignedImg.ref,
              clone,
              callback,
            ), (c, p) {
      return c.complete(Mat.fromPointer(p.cast<cvg.Mat>()));
    });
    return rval;
  }

  Future<double> matchAsync(
    Mat faceFeature1,
    Mat faceFeature2, {
    int disType = FaceRecognizerSF.FR_COSINE,
  }) async {
    final rval = cvRunAsync<double>(
        (callback) => CFFI.FaceRecognizerSF_Match_Async(
              ref,
              faceFeature1.ref,
              faceFeature2.ref,
              disType,
              callback,
            ), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  @override
  cvg.FaceRecognizerSF get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.FaceRecognizerSFPtr>(
    CFFI.addresses.FaceRecognizerSF_Close,
  );

  void dispose() {
    finalizer.detach(this);
    CFFI.FaceRecognizerSF_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];

  @Deprecated("Use [FR_COSINE] instead.")
  static const int DIS_TYPR_FR_COSINE = 0;
  @Deprecated("Use [FR_NORM_L2] instead.")
  static const int DIS_TYPE_FR_NORM_L2 = 1;

  static const int FR_COSINE = 0;
  static const int FR_NORM_L2 = 1;
}
