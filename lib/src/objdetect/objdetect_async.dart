library cv.objdetect;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/objdetect.g.dart' as cvg;
import '../native_lib.dart' show cobjdetect;
import './objdetect.dart';

extension CascadeClassifierAsync on CascadeClassifier {
  static Future<CascadeClassifier> emptyNewAsync() async => cvRunAsync(
        cobjdetect.CascadeClassifier_New_Async,
        (c, p) => c.complete(CascadeClassifier.fromPointer(p.cast<cvg.CascadeClassifier>())),
      );

  static Future<CascadeClassifier> fromFileAsync(String filename) async {
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<CascadeClassifier>(
        (callback) => cobjdetect.CascadeClassifier_NewFromFile_Async(cp, callback), (c, p) {
      return c.complete(CascadeClassifier.fromPointer(p.cast<cvg.CascadeClassifier>()));
    });
    calloc.free(cp);
    return rval;
  }

  Future<bool> loadAsync(String name) async {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final rval =
        cvRunAsync<bool>((callback) => cobjdetect.CascadeClassifier_Load_Async(ref, cname, callback), (c, p) {
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
        (callback) => cobjdetect.CascadeClassifier_DetectMultiScaleWithParams_Async(
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

  Future<(VecRect objects, VecI32 numDetections)> detectMultiScale2Async(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) async {
    final rval = cvRunAsync2<(VecRect, VecI32)>(
        (callback) => cobjdetect.CascadeClassifier_DetectMultiScale2_Async(
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
        (VecRect.fromPointer(ret.cast<cvg.VecRect>()), VecI32.fromPointer(pnums.cast<cvg.VecI32>())),
      );
    });
    return rval;
  }

  Future<(VecRect objects, VecI32 rejectLevels, VecF64 levelWeights)> detectMultiScale3Async(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
    bool outputRejectLevels = false,
  }) async {
    final rval = cvRunAsync3<(VecRect, VecI32, VecF64)>(
      (callback) => cobjdetect.CascadeClassifier_DetectMultiScale3_Async(
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
          VecI32.fromPointer(p2.cast<cvg.VecI32>()),
          VecF64.fromPointer(p3.cast<cvg.VecF64>())
        ),
      ),
    );
    return rval;
  }

  Future<bool> emptyAsync() async {
    final rval =
        cvRunAsync<bool>((callback) => cobjdetect.CascadeClassifier_Empty_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<int> getFeatureTypeAsync() async {
    final rval = cvRunAsync<int>(
        (callback) => cobjdetect.CascadeClassifier_getFeatureType_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);

      return c.complete(rval);
    });
    return rval;
  }

  Future<(int, int)> getOriginalWindowSizeAsync() async {
    final rval = cvRunAsync<(int, int)>(
        (callback) => cobjdetect.CascadeClassifier_getOriginalWindowSize_Async(ref, callback), (c, p) {
      final size = p.cast<cvg.Size>().ref;
      final ret = (size.width, size.height);
      return c.complete(ret);
    });
    return rval;
  }

  Future<bool> isOldFormatCascadeAsync() async {
    final rval = cvRunAsync<bool>(
        (callback) => cobjdetect.CascadeClassifier_isOldFormatCascade_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }
}

extension HOGDescriptorAsync on HOGDescriptor {
  static Future<HOGDescriptor> emptyNewAsync() async => cvRunAsync(
        cobjdetect.HOGDescriptor_New_Async,
        (c, p) => c.complete(HOGDescriptor.fromPointer(p.cast<cvg.HOGDescriptor>())),
      );

  static Future<HOGDescriptor> fromFileAsync(String filename) async {
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<HOGDescriptor>(
        (callback) => cobjdetect.HOGDescriptor_NewFromFile_Async(cp, callback), (c, p) {
      return c.complete(HOGDescriptor.fromPointer(p.cast<cvg.HOGDescriptor>()));
    });
    calloc.free(cp);
    return rval;
  }

  Future<bool> loadAsync(String name) async {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final rval =
        cvRunAsync<bool>((callback) => cobjdetect.HOGDescriptor_Load_Async(ref, cname, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);

      return c.complete(rval);
    });
    calloc.free(cname);
    return rval;
  }

  Future<(VecF32 descriptors, VecPoint locations)> computeAsync(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) async {
    final rval = cvRunAsync2<(VecF32, VecPoint)>(
        (callback) => cobjdetect.HOGDescriptor_Compute_Async(
              ref,
              img.ref,
              winStride.cvd.ref,
              padding.cvd.ref,
              callback,
            ), (c, descriptors, locations) {
      return c.complete(
        (
          VecF32.fromPointer(descriptors.cast<cvg.VecF32>()),
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
        (callback) => cobjdetect.HOGDescriptor_computeGradient_Async(
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

  Future<(VecPoint foundLocations, VecF64 weights, VecPoint searchLocations)> detect2Async(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) async {
    final rval = cvRunAsync3<(VecPoint, VecF64, VecPoint)>(
        (callback) => cobjdetect.HOGDescriptor_Detect_Async(
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
          VecF64.fromPointer(weights.cast<cvg.VecF64>()),
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
        (callback) => cobjdetect.HOGDescriptor_Detect2_Async(
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
        (callback) => cobjdetect.HOGDescriptor_DetectMultiScaleWithParams_Async(
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

  static Future<VecF32> getDefaultPeopleDetectorAsync() async => cvRunAsync<VecF32>(
        cobjdetect.HOG_GetDefaultPeopleDetector_Async,
        (c, v) => c.complete(VecF32.fromPointer(v.cast<cvg.VecF32>())),
      );

  static Future<VecF32> getDaimlerPeopleDetectorAsync() async => cvRunAsync<VecF32>(
        cobjdetect.HOGDescriptor_getDaimlerPeopleDetector_Async,
        (c, v) => c.complete(VecF32.fromPointer(v.cast<cvg.VecF32>())),
      );

  Future<int> getDescriptorSizeAsync() async {
    final rval = cvRunAsync<int>(
        (callback) => cobjdetect.HOGDescriptor_getDescriptorSize_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Size>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<double> getWinSigmaAsync() async {
    final rval =
        cvRunAsync<double>((callback) => cobjdetect.HOGDescriptor_getWinSigma_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<(VecRect rectList, VecF64 weights)> groupRectanglesAsync(
    VecRect rectList,
    VecF64 weights,
    int groupThreshold,
    double eps,
  ) async {
    final rval = cvRunAsync0<(VecRect, VecF64)>(
        (callback) => cobjdetect.HOGDescriptor_groupRectangles_Async(
              ref,
              rectList.ptr,
              weights.ptr,
              groupThreshold,
              eps,
              callback,
            ), (c) {
      rectList.reattach();
      weights.reattach();
      return c.complete((rectList, weights));
    });
    return rval;
  }

  Future<void> setSVMDetectorAsync(VecF32 det) async => cvRunAsync0<void>(
        (callback) => cobjdetect.HOGDescriptor_SetSVMDetector_Async(ref, det.ref, callback),
        (c) => c.complete(),
      );
}

Future<VecRect> groupRectanglesAsync(
  VecRect rects,
  int groupThreshold,
  double eps,
) async {
  final rval = cvRunAsync0<VecRect>(
      (callback) => cobjdetect.GroupRectangles_Async(rects.ptr, groupThreshold, eps, callback), (c) {
    rects.reattach();
    return c.complete(rects);
  });
  return rval;
}

extension QRCodeDetectorAsync on QRCodeDetector {
  static Future<QRCodeDetector> emptyNewAsync() async => cvRunAsync(
        cobjdetect.QRCodeDetector_New_Async,
        (c, p) => c.complete(QRCodeDetector.fromPointer(p.cast<cvg.QRCodeDetector>())),
      );

  Future<(String rval, Mat straightQRcode)> decodeCurvedAsync(
    InputArray img,
    VecPoint points,
  ) async {
    final rval = cvRunAsync2<(String, Mat)>(
        (callback) => cobjdetect.QRCodeDetector_decodeCurved_Async(
              ref,
              img.ref,
              points.ref,
              callback,
            ), (c, prval, pstraightQRcode) {
      // prval is a char ** pointer
      final rval = prval.cast<ffi.Pointer<ffi.Char>>().value.toDartString();
      calloc.free(prval);
      return c.complete(
        (rval, Mat.fromPointer(pstraightQRcode.cast<cvg.Mat>())),
      );
    });
    return rval;
  }

  Future<(String rval, VecPoint points, Mat straightQRcode)> detectAndDecodeCurvedAsync(
    InputArray img,
  ) async {
    final rval = cvRunAsync3<(String, VecPoint, Mat)>(
        (callback) => cobjdetect.QRCodeDetector_detectAndDecodeCurved_Async(
              ref,
              img.ref,
              callback,
            ), (c, prval, points, straightQRcode) {
      // prval is a char ** pointer
      final rval = prval.cast<ffi.Pointer<ffi.Char>>().value.toDartString();
      calloc.free(prval);
      return c.complete(
        (
          rval,
          VecPoint.fromPointer(points.cast<cvg.VecPoint>()),
          Mat.fromPointer(straightQRcode.cast<cvg.Mat>()),
        ),
      );
    });
    return rval;
  }

  Future<(String ret, VecPoint points, Mat straightCode)> detectAndDecodeAsync(InputArray img) async {
    final rval = cvRunAsync3<(String, VecPoint, Mat)>(
        (callback) => cobjdetect.QRCodeDetector_DetectAndDecode_Async(ref, img.ref, callback),
        (c, prval, points, straightCode) {
      // prval is a char ** pointer
      final rval = prval.cast<ffi.Pointer<ffi.Char>>().value.toDartString();
      calloc.free(prval);
      return c.complete(
        (
          rval,
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
        (callback) => cobjdetect.QRCodeDetector_Detect_Async(ref, input.ref, callback), (c, ret, points) {
      final retValue = ret.cast<ffi.Bool>().value;
      calloc.free(ret);
      return c.complete(
        (retValue, VecPoint.fromPointer(points.cast<cvg.VecPoint>())),
      );
    });
    return rval;
  }

  Future<(String ret, VecPoint? points, Mat? straightCode)> decodeAsync(
    InputArray img,
  ) async {
    final rval = cvRunAsync3<(String, VecPoint, Mat)>(
        (callback) => cobjdetect.QRCodeDetector_Decode_Async(ref, img.ref, callback),
        (c, prval, points, straightCode) {
      // prval is a char ** pointer
      final rval = prval.cast<ffi.Pointer<ffi.Char>>().value.toDartString();
      calloc.free(prval);
      return c.complete(
        (
          rval,
          VecPoint.fromPointer(points.cast<cvg.VecPoint>()),
          Mat.fromPointer(straightCode.cast<cvg.Mat>()),
        ),
      );
    });
    return rval;
  }

  Future<(bool ret, VecPoint points)> detectMultiAsync(
    InputArray img,
  ) async {
    final rval = cvRunAsync2<(bool, VecPoint)>(
        (callback) => cobjdetect.QRCodeDetector_DetectMulti_Async(ref, img.ref, callback), (c, ret, points) {
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
        (callback) => cobjdetect.QRCodeDetector_DetectAndDecodeMulti_Async(
              ref,
              img.ref,
              callback,
            ), (c, rval, info, points, codes) {
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
    await cvRunAsync0<void>((callback) => cobjdetect.QRCodeDetector_setEpsX_Async(ref, epsX, callback), (c) {
      return c.complete();
    });
  }

  Future<void> setEpsYAsync(double epsY) async {
    await cvRunAsync0<void>((callback) => cobjdetect.QRCodeDetector_setEpsY_Async(ref, epsY, callback), (c) {
      return c.complete();
    });
  }

  Future<void> setUseAlignmentMarkersAsync(bool useAlignmentMarkers) async {
    await cvRunAsync0<void>(
        (callback) => cobjdetect.QRCodeDetector_setUseAlignmentMarkers_Async(
              ref,
              useAlignmentMarkers,
              callback,
            ), (c) {
      return c.complete();
    });
  }
}

extension FaceDetectorYNAsync on FaceDetectorYN {
  static Future<CascadeClassifier> emptyNewAsync() async => cvRunAsync(
        cobjdetect.CascadeClassifier_New_Async,
        (c, p) => c.complete(CascadeClassifier.fromPointer(p.cast<cvg.CascadeClassifier>())),
      );

  static Future<FaceDetectorYN> fromFileAsync(
    String model,
    String config,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) async {
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<FaceDetectorYN>(
        (callback) => cobjdetect.FaceDetectorYN_New_Async(
              cModel,
              cConfig,
              inputSize.cvd.ref,
              scoreThreshold,
              nmsThreshold,
              topK,
              backendId,
              targetId,
              callback,
            ), (c, p) {
      return c.complete(FaceDetectorYN.fromPointer(p.cast<cvg.FaceDetectorYN>()));
    });
    calloc.free(cModel);
    calloc.free(cConfig);
    return rval;
  }

  static Future<FaceDetectorYN> fromBufferAsync(
    String framework,
    Uint8List bufferModel,
    Uint8List bufferConfig,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) async {
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);

    final rval = await cvRunAsync<FaceDetectorYN>(
        (callback) => cobjdetect.FaceDetectorYN_NewFromBuffer_Async(
              cFramework,
              bufM.ref,
              bufC.ref,
              inputSize.cvd.ref,
              scoreThreshold,
              nmsThreshold,
              topK,
              backendId,
              targetId,
              callback,
            ), (c, p) {
      return c.complete(FaceDetectorYN.fromPointer(p.cast<cvg.FaceDetectorYN>()));
    });
    calloc.free(cFramework);
    bufM.dispose();
    bufC.dispose();

    return rval;
  }

  Future<(int, int)> getInputSizeAsync() async {
    final rval = cvRunAsync<(int, int)>(
        (callback) => cobjdetect.FaceDetectorYN_GetInputSize_Async(ref, callback), (c, p) {
      final size = p.cast<cvg.Size>().ref;
      final ret = (size.width, size.height);
      return c.complete(ret);
    });
    return rval;
  }

  Future<double> getScoreThresholdAsync() async {
    final rval = cvRunAsync<double>(
        (callback) => cobjdetect.FaceDetectorYN_GetScoreThreshold_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<double> getNmsThresholdAsync() async {
    final rval = cvRunAsync<double>(
        (callback) => cobjdetect.FaceDetectorYN_GetNMSThreshold_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<int> getTopKAsync() async {
    final rval =
        cvRunAsync<int>((callback) => cobjdetect.FaceDetectorYN_GetTopK_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<Mat> detectAsync(Mat image) async {
    final rval = cvRunAsync<Mat>(
        (callback) => cobjdetect.FaceDetectorYN_Detect_Async(ref, image.ref, callback), (c, p) {
      return c.complete(Mat.fromPointer(p.cast<cvg.Mat>()));
    });
    return rval;
  }

  Future<void> setInputSizeAsync((int, int) inputSize) async {
    await cvRunAsync0<void>(
        (callback) => cobjdetect.FaceDetectorYN_SetInputSize_Async(
              ref,
              inputSize.cvd.ref,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  Future<void> setScoreThresholdAsync(double scoreThreshold) async {
    await cvRunAsync0<void>(
        (callback) => cobjdetect.FaceDetectorYN_SetScoreThreshold_Async(
              ref,
              scoreThreshold,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  Future<void> setNMSThresholdAsync(double nmsThreshold) async {
    await cvRunAsync0<void>(
        (callback) => cobjdetect.FaceDetectorYN_SetNMSThreshold_Async(
              ref,
              nmsThreshold,
              callback,
            ), (c) {
      return c.complete();
    });
  }

  Future<void> setTopKAsync(int topK) async {
    await cvRunAsync0<void>((callback) => cobjdetect.FaceDetectorYN_SetTopK_Async(ref, topK, callback), (c) {
      return c.complete();
    });
  }
}

extension FaceRecognizerSFAsync on FaceRecognizerSF {
  static Future<FaceRecognizerSF> fromFileAsync(
    String model,
    String config, {
    int backendId = 0,
    int targetId = 0,
  }) async {
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<FaceRecognizerSF>(
        (callback) => cobjdetect.FaceRecognizerSF_New_Async(
              cModel,
              cConfig,
              backendId,
              targetId,
              callback,
            ), (c, p) {
      return c.complete(FaceRecognizerSF.fromPointer(p.cast<cvg.FaceRecognizerSF>()));
    });
    calloc.free(cModel);
    calloc.free(cConfig);
    return rval;
  }

  Future<Mat> alignCropAsync(Mat srcImg, Mat faceBox) async {
    final rval = cvRunAsync<Mat>(
        (callback) => cobjdetect.FaceRecognizerSF_AlignCrop_Async(
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
        (callback) => cobjdetect.FaceRecognizerSF_Feature_Async(
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
        (callback) => cobjdetect.FaceRecognizerSF_Match_Async(
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
}
