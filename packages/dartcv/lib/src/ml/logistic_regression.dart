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
import '../core/termcriteria.dart';
import '../g/ml.g.dart' as cml;
import '../g/types.g.dart' as cvg;
import 'ml_constants.dart';
import 'train_data.dart';

/// Implements Logistic Regression classifier.
/// https://docs.opencv.org/4.x/d6/df9/classcv_1_1ml_1_1LogisticRegression.html
class LogisticRegression extends CvStruct<cml.LogisticRegression> {
  LogisticRegression._(cml.LogisticRegressionPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory LogisticRegression.fromPointer(cml.LogisticRegressionPtr ptr, [bool attach = true]) =>
      LogisticRegression._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [LogisticRegression.load].
  factory LogisticRegression.create() {
    final p = calloc<cml.LogisticRegression>();
    cvRun(() => cml.cv_ml_LogisticRegression_create(p));
    return LogisticRegression._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory LogisticRegression.load(String filepath) => using(
    (arena) => LogisticRegression._make(
      (p) => cml.cv_ml_LogisticRegression_load(filepath.toNativeUtf8(allocator: arena).cast(), p),
    ),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory LogisticRegression.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => LogisticRegression._make(
      (p) => cml.cv_ml_LogisticRegression_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory LogisticRegression._make(ffi.Pointer<cml.CvStatus> Function(cml.LogisticRegressionPtr p) func) {
    final p = calloc<cml.LogisticRegression>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return LogisticRegression._(p);
  }

  static final finalizer = OcvFinalizer<cml.LogisticRegressionPtr>(
    cml.addresses.cv_ml_LogisticRegression_close,
  );

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_LogisticRegression_close(ptr);
  }

  @override
  cml.LogisticRegression get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) =>
        cvRun(() => cml.cv_ml_LogisticRegression_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_LogisticRegression_clear(ref));

  bool get isEmpty => cml.cv_ml_LogisticRegression_empty(ref);
  bool get isTrained => cml.cv_ml_LogisticRegression_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_LogisticRegression_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_LogisticRegression_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_lr`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_LogisticRegression_getDefaultName(ref, p));
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
      cvRun(
        () => cml.cv_ml_LogisticRegression_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr),
      );
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_LogisticRegression_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// [StatModel.RAW_OUTPUT] returns the raw sigmoid outputs instead of the labels.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_LogisticRegression_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_LogisticRegression_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // regularization kinds
  static const int REG_DISABLE = -1;
  static const int REG_L1 = 0;
  static const int REG_L2 = 1;

  // training methods
  static const int BATCH = 0;
  static const int MINI_BATCH = 1;

  /// Learning rate.
  double get learningRate => cml.cv_ml_LogisticRegression_get_learningRate(ref);
  set learningRate(double value) => cvRun(() => cml.cv_ml_LogisticRegression_set_learningRate(ref, value));

  /// Number of iterations.
  int get iterations => cml.cv_ml_LogisticRegression_get_iterations(ref);
  set iterations(int value) => cvRun(() => cml.cv_ml_LogisticRegression_set_iterations(ref, value));

  /// Kind of regularization to be applied, one of [REG_DISABLE], [REG_L1], [REG_L2].
  int get regularization => cml.cv_ml_LogisticRegression_get_regularization(ref);
  set regularization(int value) => cvRun(() => cml.cv_ml_LogisticRegression_set_regularization(ref, value));

  /// Kind of training method used, one of [BATCH], [MINI_BATCH].
  int get trainMethod => cml.cv_ml_LogisticRegression_get_trainMethod(ref);
  set trainMethod(int value) => cvRun(() => cml.cv_ml_LogisticRegression_set_trainMethod(ref, value));

  /// Number of training samples taken in each step of Mini-Batch Gradient Descent.
  int get miniBatchSize => cml.cv_ml_LogisticRegression_get_miniBatchSize(ref);
  set miniBatchSize(int value) => cvRun(() => cml.cv_ml_LogisticRegression_set_miniBatchSize(ref, value));

  /// The trained parameters, arranged across rows; for a two-class classification problem a single row.
  Mat get learntThetas {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_LogisticRegression_get_learnt_thetas(ref, rval.ref));
    return rval;
  }

  /// Termination criteria of the training algorithm.
  TermCriteria get termCriteria {
    final p = calloc<cvg.TermCriteria>();
    try {
      cvRun(() => cml.cv_ml_LogisticRegression_getTermCriteria(ref, p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TermCriteria.fromPointer(p);
  }

  set termCriteria(TermCriteria value) =>
      cvRun(() => cml.cv_ml_LogisticRegression_setTermCriteria(ref, value.ref));
}
