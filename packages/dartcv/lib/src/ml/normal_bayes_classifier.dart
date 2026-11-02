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

/// Bayes classifier for normally distributed data.
/// https://docs.opencv.org/4.x/d4/d8e/classcv_1_1ml_1_1NormalBayesClassifier.html
class NormalBayesClassifier extends CvStruct<cml.NormalBayesClassifier> {
  NormalBayesClassifier._(cml.NormalBayesClassifierPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory NormalBayesClassifier.fromPointer(cml.NormalBayesClassifierPtr ptr, [bool attach = true]) =>
      NormalBayesClassifier._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [NormalBayesClassifier.load].
  factory NormalBayesClassifier.create() {
    final p = calloc<cml.NormalBayesClassifier>();
    cvRun(() => cml.cv_ml_NormalBayesClassifier_create(p));
    return NormalBayesClassifier._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory NormalBayesClassifier.load(String filepath) => using(
    (arena) => NormalBayesClassifier._make(
      (p) => cml.cv_ml_NormalBayesClassifier_load(filepath.toNativeUtf8(allocator: arena).cast(), p),
    ),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory NormalBayesClassifier.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => NormalBayesClassifier._make(
      (p) => cml.cv_ml_NormalBayesClassifier_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory NormalBayesClassifier._make(
    ffi.Pointer<cml.CvStatus> Function(cml.NormalBayesClassifierPtr p) func,
  ) {
    final p = calloc<cml.NormalBayesClassifier>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return NormalBayesClassifier._(p);
  }

  static final finalizer = OcvFinalizer<cml.NormalBayesClassifierPtr>(
    cml.addresses.cv_ml_NormalBayesClassifier_close,
  );

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_NormalBayesClassifier_close(ptr);
  }

  @override
  cml.NormalBayesClassifier get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(
      () => cml.cv_ml_NormalBayesClassifier_save(ref, filename.toNativeUtf8(allocator: arena).cast()),
    ),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_NormalBayesClassifier_clear(ref));

  bool get isEmpty => cml.cv_ml_NormalBayesClassifier_empty(ref);
  bool get isTrained => cml.cv_ml_NormalBayesClassifier_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_NormalBayesClassifier_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_NormalBayesClassifier_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_nbayes`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_NormalBayesClassifier_getDefaultName(ref, p));
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
        () =>
            cml.cv_ml_NormalBayesClassifier_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr),
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
      cvRun(() => cml.cv_ml_NormalBayesClassifier_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// [StatModel.RAW_OUTPUT] is accepted as in [predictProb].
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(
        () => cml.cv_ml_NormalBayesClassifier_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr),
      );
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
      cvRun(() => cml.cv_ml_NormalBayesClassifier_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [inputs] and the probability of each class.
  ///
  /// Returns the predicted labels and, per sample, the probabilities of the classes.
  (Mat outputs, Mat outputProbs) predictProb(Mat inputs, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final outputs = Mat.empty();
    final outputProbs = Mat.empty();
    try {
      cvRun(
        () => cml.cv_ml_NormalBayesClassifier_predictProb(
          ref,
          inputs.ref,
          outputs.ref,
          outputProbs.ref,
          flags,
          p,
          ffi.nullptr,
        ),
      );
      return (outputs, outputProbs);
    } catch (_) {
      outputs.dispose();
      outputProbs.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }
}
