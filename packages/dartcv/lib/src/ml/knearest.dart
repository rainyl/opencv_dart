// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv.ml;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/exception.dart';
import '../core/mat.dart';
import '../g/ml.g.dart' as cml;
import 'ml_constants.dart';
import 'train_data.dart';

/// The class implements K-Nearest Neighbors model.
/// https://docs.opencv.org/4.x/dd/de1/classcv_1_1ml_1_1KNearest.html
class KNearest extends CvStruct<cml.KNearest> {
  KNearest._(cml.KNearestPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory KNearest.fromPointer(cml.KNearestPtr ptr, [bool attach = true]) => KNearest._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [KNearest.load].
  factory KNearest.create() {
    final p = calloc<cml.KNearest>();
    cvRun(() => cml.cv_ml_KNearest_create(p));
    return KNearest._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory KNearest.load(String filepath) => using(
    (arena) =>
        KNearest._make((p) => cml.cv_ml_KNearest_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory KNearest.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => KNearest._make(
      (p) => cml.cv_ml_KNearest_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory KNearest._make(ffi.Pointer<cml.CvStatus> Function(cml.KNearestPtr p) func) {
    final p = calloc<cml.KNearest>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return KNearest._(p);
  }

  static final finalizer = OcvFinalizer<cml.KNearestPtr>(cml.addresses.cv_ml_KNearest_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_KNearest_close(ptr);
  }

  @override
  cml.KNearest get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_KNearest_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_KNearest_clear(ref));

  bool get isEmpty => cml.cv_ml_KNearest_empty(ref);
  bool get isTrained => cml.cv_ml_KNearest_isTrained(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_KNearest_getVarCount(ref);

  /// The name used when saving the model, e.g. `opencv_ml_svm`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_KNearest_getDefaultName(ref, p));
      final rval = p.value.cast<Utf8>().toDartString();
      calloc.free(p.value);
      return rval;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [samples] (`CV_32F`, one sample per row for [ROW_SAMPLE]).
  bool train(Mat samples, int layout, Mat responses) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_KNearest_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_KNearest_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// With [StatModel.RAW_OUTPUT] the raw model output is returned instead (e.g. the SVM decision
  /// function value).
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_KNearest_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
      return results;
    } catch (_) {
      results.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  /// Computes the error on the training ([test] false) or test ([test] true) part of [data].
  ///
  /// Returns the error (percentage of misclassified samples for classifiers, MSE for regressors)
  /// and the predicted responses.
  (double, Mat) calcError(TrainData data, bool test) {
    final p = calloc<ffi.Float>();
    final resp = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_KNearest_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // algorithm types
  static const int BRUTE_FORCE = 1;
  static const int KDTREE = 2;

  /// Default number of neighbors to use in predict method.
  int get defaultK => cml.cv_ml_KNearest_get_defaultK(ref);
  set defaultK(int value) => cml.cv_ml_KNearest_set_defaultK(ref, value);

  /// Whether classification or regression model should be trained.
  bool get isClassifier => cml.cv_ml_KNearest_get_isClassifier(ref);
  set isClassifier(bool value) => cml.cv_ml_KNearest_set_isClassifier(ref, value);

  /// Parameter for KDTree implementation.
  int get emax => cml.cv_ml_KNearest_get_emax(ref);
  set emax(int value) => cml.cv_ml_KNearest_set_emax(ref, value);

  /// Algorithm type, one of [BRUTE_FORCE], [KDTREE].
  int get algorithmType => cml.cv_ml_KNearest_get_algorithmType(ref);
  set algorithmType(int value) => cml.cv_ml_KNearest_set_algorithmType(ref, value);

  /// Finds the [k] nearest neighbors of each row of [samples] and predicts their responses.
  ///
  /// Returns the predicted responses, the responses of the neighbors (one row of [k] values
  /// per sample) and the distances to them.
  (Mat results, Mat neighborResponses, Mat dist) findNearest(Mat samples, int k) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    final neighborResponses = Mat.empty();
    final dist = Mat.empty();
    try {
      cvRun(
        () => cml.cv_ml_KNearest_findNearest(
          ref,
          samples.ref,
          k,
          results.ref,
          neighborResponses.ref,
          dist.ref,
          p,
          ffi.nullptr,
        ),
      );
      return (results, neighborResponses, dist);
    } catch (_) {
      results.dispose();
      neighborResponses.dispose();
      dist.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }
}
