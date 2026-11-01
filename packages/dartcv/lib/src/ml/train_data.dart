// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.ml;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/ml.g.dart' as cml;
import 'ml_constants.dart';

/// Class encapsulating training data.
/// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html
class TrainData extends CvStruct<cml.TrainData> {
  TrainData._(cml.TrainDataPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory TrainData.fromPointer(cml.TrainDataPtr ptr, [bool attach = true]) => TrainData._(ptr, attach);

  /// Creates training data from in-memory arrays.
  ///
  /// [samples] must be `CV_32F`, [responses] `CV_32F` or `CV_32S`. The optional arrays are
  /// ignored when omitted.
  factory TrainData.create(
    Mat samples,
    int layout,
    Mat responses, {
    Mat? varIdx,
    Mat? sampleIdx,
    Mat? sampleWeights,
    Mat? varType,
  }) {
    final empty = Mat.empty();
    final p = calloc<cml.TrainData>();
    try {
      cvRun(
        () => cml.cv_ml_TrainData_create(
          samples.ref,
          layout,
          responses.ref,
          (varIdx ?? empty).ref,
          (sampleIdx ?? empty).ref,
          (sampleWeights ?? empty).ref,
          (varType ?? empty).ref,
          p,
        ),
      );
    } catch (_) {
      calloc.free(p);
      rethrow;
    } finally {
      empty.dispose();
    }
    return TrainData._(p);
  }

  /// Reads the dataset from a .csv file.
  ///
  /// [delimiter] and [missch] must be single characters.
  factory TrainData.loadFromCSV(
    String filename,
    int headerLineCount, {
    int responseStartIdx = -1,
    int responseEndIdx = -1,
    String varTypeSpec = '',
    String delimiter = ',',
    String missch = '?',
  }) {
    final p = calloc<cml.TrainData>();
    try {
      using((arena) {
        cvRun(
          () => cml.cv_ml_TrainData_loadFromCSV(
            filename.toNativeUtf8(allocator: arena).cast(),
            headerLineCount,
            responseStartIdx,
            responseEndIdx,
            varTypeSpec.toNativeUtf8(allocator: arena).cast(),
            singleChar(delimiter, 'delimiter'),
            singleChar(missch, 'missch'),
            p,
            ffi.nullptr,
          ),
        );
      });
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TrainData._(p);
  }

  /// The code unit of a single-character [value], for the C `char` parameters.
  static int singleChar(String value, String name) {
    if (value.length != 1) throw ArgumentError.value(value, name, 'must be a single character');
    return value.codeUnitAt(0);
  }

  static final finalizer = OcvFinalizer<cml.TrainDataPtr>(cml.addresses.cv_ml_TrainData_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_TrainData_close(ptr);
  }

  @override
  cml.TrainData get ref => ptr.ref;

  int get layout => cml.cv_ml_TrainData_getLayout(ref);
  int get nSamples => cml.cv_ml_TrainData_getNSamples(ref);
  int get nTrainSamples => cml.cv_ml_TrainData_getNTrainSamples(ref);
  int get nTestSamples => cml.cv_ml_TrainData_getNTestSamples(ref);
  int get nVars => cml.cv_ml_TrainData_getNVars(ref);
  int get nAllVars => cml.cv_ml_TrainData_getNAllVars(ref);
  int get responseType => cml.cv_ml_TrainData_getResponseType(ref);

  /// Number of categories of the categorical variable [vi].
  int getCatCount(int vi) {
    final p = calloc<ffi.Int>();
    try {
      cvRun(() => cml.cv_ml_TrainData_getCatCount(ref, vi, p));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  Mat _mat(ffi.Pointer<cml.CvStatus> Function(cml.Mat rval) func) {
    final rval = Mat.empty();
    cvRun(() => func(rval.ref));
    return rval;
  }

  Mat get samples => _mat((r) => cml.cv_ml_TrainData_getSamples(ref, r));
  Mat get responses => _mat((r) => cml.cv_ml_TrainData_getResponses(ref, r));
  Mat get missing => _mat((r) => cml.cv_ml_TrainData_getMissing(ref, r));
  Mat get varIdx => _mat((r) => cml.cv_ml_TrainData_getVarIdx(ref, r));
  Mat get varType => _mat((r) => cml.cv_ml_TrainData_getVarType(ref, r));
  Mat get varSymbolFlags => _mat((r) => cml.cv_ml_TrainData_getVarSymbolFlags(ref, r));
  Mat get sampleWeights => _mat((r) => cml.cv_ml_TrainData_getSampleWeights(ref, r));
  Mat get trainSampleWeights => _mat((r) => cml.cv_ml_TrainData_getTrainSampleWeights(ref, r));
  Mat get testSampleWeights => _mat((r) => cml.cv_ml_TrainData_getTestSampleWeights(ref, r));
  Mat get trainSampleIdx => _mat((r) => cml.cv_ml_TrainData_getTrainSampleIdx(ref, r));
  Mat get testSampleIdx => _mat((r) => cml.cv_ml_TrainData_getTestSampleIdx(ref, r));
  Mat get trainResponses => _mat((r) => cml.cv_ml_TrainData_getTrainResponses(ref, r));
  Mat get testResponses => _mat((r) => cml.cv_ml_TrainData_getTestResponses(ref, r));
  Mat get normCatResponses => _mat((r) => cml.cv_ml_TrainData_getNormCatResponses(ref, r));
  Mat get trainNormCatResponses => _mat((r) => cml.cv_ml_TrainData_getTrainNormCatResponses(ref, r));
  Mat get testNormCatResponses => _mat((r) => cml.cv_ml_TrainData_getTestNormCatResponses(ref, r));
  Mat get classLabels => _mat((r) => cml.cv_ml_TrainData_getClassLabels(ref, r));
  Mat get catOfs => _mat((r) => cml.cv_ml_TrainData_getCatOfs(ref, r));
  Mat get catMap => _mat((r) => cml.cv_ml_TrainData_getCatMap(ref, r));
  Mat get defaultSubstValues => _mat((r) => cml.cv_ml_TrainData_getDefaultSubstValues(ref, r));
  Mat get testSamples => _mat((r) => cml.cv_ml_TrainData_getTestSamples(ref, r));

  /// Returns matrix of train samples.
  Mat getTrainSamples({int layout = ROW_SAMPLE, bool compressSamples = true, bool compressVars = true}) =>
      _mat(
        (r) => cml.cv_ml_TrainData_getTrainSamples(ref, layout, compressSamples, compressVars, r),
      );

  /// The symbolic values of the categorical variables captured by [TrainData.loadFromCSV].
  List<String> get names {
    final v = VecVecChar();
    try {
      cvRun(() => cml.cv_ml_TrainData_getNames(ref, v.ptr));
      return v.asStringList();
    } finally {
      v.dispose();
    }
  }

  /// Splits the training data into the training and test parts.
  void setTrainTestSplit(int count, {bool shuffle = true}) =>
      cvRun(() => cml.cv_ml_TrainData_setTrainTestSplit(ref, count, shuffle));

  /// Splits the training data into the training and test parts by [ratio].
  void setTrainTestSplitRatio(double ratio, {bool shuffle = true}) =>
      cvRun(() => cml.cv_ml_TrainData_setTrainTestSplitRatio(ref, ratio, shuffle));

  void shuffleTrainTest() => cvRun(() => cml.cv_ml_TrainData_shuffleTrainTest(ref));

  /// The value OpenCV uses to mark a missing measurement.
  static double get missingValue => cml.cv_ml_TrainData_missingValue();

  /// Extracts from 1D [vec] the elements specified by [idx].
  static Mat getSubVector(Mat vec, Mat idx) {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_TrainData_getSubVector(vec.ref, idx.ref, rval.ref));
    return rval;
  }

  /// Extracts from [matrix] the rows ([ROW_SAMPLE]) or columns ([COL_SAMPLE]) specified by [idx].
  static Mat getSubMatrix(Mat matrix, Mat idx, int layout) {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_TrainData_getSubMatrix(matrix.ref, idx.ref, layout, rval.ref));
    return rval;
  }
}
