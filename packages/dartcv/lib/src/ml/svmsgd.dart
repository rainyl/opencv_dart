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

/// Stochastic Gradient Descent SVM classifier.
///
/// A linear two-class classifier. The responses of the negative class must be < 0 (use -1 and 1):
/// responses >= 0 count as positive, and without any negative response training succeeds but
/// yields a constant model that predicts 1.
/// https://docs.opencv.org/4.x/d3/d14/classcv_1_1ml_1_1SVMSGD.html
class SVMSGD extends CvStruct<cml.SVMSGD> {
  SVMSGD._(cml.SVMSGDPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory SVMSGD.fromPointer(cml.SVMSGDPtr ptr, [bool attach = true]) => SVMSGD._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [SVMSGD.load].
  factory SVMSGD.create() {
    final p = calloc<cml.SVMSGD>();
    cvRun(() => cml.cv_ml_SVMSGD_create(p));
    return SVMSGD._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory SVMSGD.load(String filepath) => using(
    (arena) => SVMSGD._make((p) => cml.cv_ml_SVMSGD_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory SVMSGD.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => SVMSGD._make(
      (p) => cml.cv_ml_SVMSGD_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory SVMSGD._make(ffi.Pointer<cml.CvStatus> Function(cml.SVMSGDPtr p) func) {
    final p = calloc<cml.SVMSGD>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return SVMSGD._(p);
  }

  static final finalizer = OcvFinalizer<cml.SVMSGDPtr>(cml.addresses.cv_ml_SVMSGD_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_SVMSGD_close(ptr);
  }

  @override
  cml.SVMSGD get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_SVMSGD_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_SVMSGD_clear(ref));

  bool get isEmpty => cml.cv_ml_SVMSGD_empty(ref);
  bool get isTrained => cml.cv_ml_SVMSGD_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_SVMSGD_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_SVMSGD_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_svmsgd`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_SVMSGD_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_SVMSGD_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_SVMSGD_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// [flags] is ignored by this model. The predicted responses are -1 or 1.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_SVMSGD_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_SVMSGD_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // SVMSGD types
  static const int SGD = 0;
  static const int ASGD = 1;

  // margin types
  static const int SOFT_MARGIN = 0;
  static const int HARD_MARGIN = 1;

  /// Algorithm type, one of [SGD], [ASGD].
  int get svmsgdType => cml.cv_ml_SVMSGD_get_svmsgdType(ref);
  set svmsgdType(int value) => cvRun(() => cml.cv_ml_SVMSGD_set_svmsgdType(ref, value));

  /// Margin type, one of [SOFT_MARGIN], [HARD_MARGIN].
  int get marginType => cml.cv_ml_SVMSGD_get_marginType(ref);
  set marginType(int value) => cvRun(() => cml.cv_ml_SVMSGD_set_marginType(ref, value));

  /// Parameter marginRegularization of a SVMSGD optimization problem.
  double get marginRegularization => cml.cv_ml_SVMSGD_get_marginRegularization(ref);
  set marginRegularization(double value) =>
      cvRun(() => cml.cv_ml_SVMSGD_set_marginRegularization(ref, value));

  /// Parameter initialStepSize of a SVMSGD optimization problem.
  double get initialStepSize => cml.cv_ml_SVMSGD_get_initialStepSize(ref);
  set initialStepSize(double value) => cvRun(() => cml.cv_ml_SVMSGD_set_initialStepSize(ref, value));

  /// Parameter stepDecreasingPower of a SVMSGD optimization problem.
  double get stepDecreasingPower => cml.cv_ml_SVMSGD_get_stepDecreasingPower(ref);
  set stepDecreasingPower(double value) => cvRun(() => cml.cv_ml_SVMSGD_set_stepDecreasingPower(ref, value));

  /// The weights of the trained model (decision function f(x) = weights * x + shift).
  Mat get weights {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_SVMSGD_getWeights(ref, rval.ref));
    return rval;
  }

  /// Termination criteria of the training algorithm.
  TermCriteria get termCriteria {
    final p = calloc<cvg.TermCriteria>();
    try {
      cvRun(() => cml.cv_ml_SVMSGD_getTermCriteria(ref, p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TermCriteria.fromPointer(p);
  }

  set termCriteria(TermCriteria value) => cvRun(() => cml.cv_ml_SVMSGD_setTermCriteria(ref, value.ref));

  /// The shift of the trained model (decision function f(x) = weights * x + shift).
  double get shift => cml.cv_ml_SVMSGD_getShift(ref);

  /// Sets the recommended parameters for the given algorithm and margin type.
  void setOptimalParameters({int svmsgdType = ASGD, int marginType = SOFT_MARGIN}) =>
      cvRun(() => cml.cv_ml_SVMSGD_setOptimalParameters(ref, svmsgdType, marginType));
}
