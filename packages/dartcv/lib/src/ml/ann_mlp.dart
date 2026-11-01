// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names, non_constant_identifier_names, camel_case_types

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

/// Artificial Neural Networks - Multi-Layer Perceptrons.
/// https://docs.opencv.org/4.x/d0/dce/classcv_1_1ml_1_1ANN__MLP.html
class ANN_MLP extends CvStruct<cml.ANN_MLP> {
  ANN_MLP._(cml.ANN_MLPPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory ANN_MLP.fromPointer(cml.ANN_MLPPtr ptr, [bool attach = true]) => ANN_MLP._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [ANN_MLP.load].
  factory ANN_MLP.create() {
    final p = calloc<cml.ANN_MLP>();
    cvRun(() => cml.cv_ml_ANN_MLP_create(p));
    return ANN_MLP._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory ANN_MLP.load(String filepath) => using(
    (arena) =>
        ANN_MLP._make((p) => cml.cv_ml_ANN_MLP_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory ANN_MLP.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => ANN_MLP._make(
      (p) => cml.cv_ml_ANN_MLP_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory ANN_MLP._make(ffi.Pointer<cml.CvStatus> Function(cml.ANN_MLPPtr p) func) {
    final p = calloc<cml.ANN_MLP>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return ANN_MLP._(p);
  }

  static final finalizer = OcvFinalizer<cml.ANN_MLPPtr>(cml.addresses.cv_ml_ANN_MLP_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_ANN_MLP_close(ptr);
  }

  @override
  cml.ANN_MLP get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_ANN_MLP_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_ANN_MLP_clear(ref));

  bool get isEmpty => cml.cv_ml_ANN_MLP_empty(ref);
  bool get isTrained => cml.cv_ml_ANN_MLP_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_ANN_MLP_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_ANN_MLP_getVarCount(ref);

  /// The name used when saving the model, e.g. `opencv_ml_svm`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_ANN_MLP_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_ANN_MLP_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_ANN_MLP_train(ref, data.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_ANN_MLP_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_ANN_MLP_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // training methods
  static const int BACKPROP = 0;
  static const int RPROP = 1;
  static const int ANNEAL = 2;

  // activation functions
  static const int IDENTITY = 0;
  static const int SIGMOID_SYM = 1;
  static const int GAUSSIAN = 2;
  static const int RELU = 3;
  static const int LEAKYRELU = 4;

  // train flags
  static const int UPDATE_WEIGHTS = 1;
  static const int NO_INPUT_SCALE = 2;
  static const int NO_OUTPUT_SCALE = 4;

  /// Integer vector specifying the number of neurons in each layer including the input and output layers.
  Mat get layerSizes {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_ANN_MLP_getLayerSizes(ref, rval.ref));
    return rval;
  }

  set layerSizes(Mat value) => cvRun(() => cml.cv_ml_ANN_MLP_setLayerSizes(ref, value.ref));

  /// Initializes the activation function for each neuron, one of [IDENTITY], [SIGMOID_SYM],
  /// [GAUSSIAN], [RELU], [LEAKYRELU].
  void setActivationFunction(int type, {double param1 = 0, double param2 = 0}) =>
      cvRun(() => cml.cv_ml_ANN_MLP_setActivationFunction(ref, type, param1, param2));

  /// Sets the training method, one of [BACKPROP], [RPROP], [ANNEAL], and its common parameters.
  void setTrainMethod(int method, {double param1 = 0, double param2 = 0}) =>
      cvRun(() => cml.cv_ml_ANN_MLP_setTrainMethod(ref, method, param1, param2));

  /// The current training method.
  int get trainMethod => cml.cv_ml_ANN_MLP_get_trainMethod(ref);

  /// Weights of the layer [layerIdx], 0 and the last index hold the input and output scales.
  Mat getWeights(int layerIdx) {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_ANN_MLP_getWeights(ref, layerIdx, rval.ref));
    return rval;
  }

  /// Termination criteria of the training algorithm.
  TermCriteria get termCriteria {
    final p = calloc<cvg.TermCriteria>();
    try {
      cvRun(() => cml.cv_ml_ANN_MLP_getTermCriteria(ref, p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TermCriteria.fromPointer(p);
  }

  set termCriteria(TermCriteria value) => cvRun(() => cml.cv_ml_ANN_MLP_setTermCriteria(ref, value.ref));

  /// BPROP: strength of the weight gradient term.
  double get backpropWeightScale => cml.cv_ml_ANN_MLP_get_backpropWeightScale(ref);
  set backpropWeightScale(double value) => cml.cv_ml_ANN_MLP_set_backpropWeightScale(ref, value);

  /// BPROP: strength of the momentum term.
  double get backpropMomentumScale => cml.cv_ml_ANN_MLP_get_backpropMomentumScale(ref);
  set backpropMomentumScale(double value) => cml.cv_ml_ANN_MLP_set_backpropMomentumScale(ref, value);

  /// RPROP: initial value of update-values.
  double get rpropDW0 => cml.cv_ml_ANN_MLP_get_rpropDW0(ref);
  set rpropDW0(double value) => cml.cv_ml_ANN_MLP_set_rpropDW0(ref, value);

  /// RPROP: increase factor.
  double get rpropDWPlus => cml.cv_ml_ANN_MLP_get_rpropDWPlus(ref);
  set rpropDWPlus(double value) => cml.cv_ml_ANN_MLP_set_rpropDWPlus(ref, value);

  /// RPROP: decrease factor.
  double get rpropDWMinus => cml.cv_ml_ANN_MLP_get_rpropDWMinus(ref);
  set rpropDWMinus(double value) => cml.cv_ml_ANN_MLP_set_rpropDWMinus(ref, value);

  /// RPROP: update-values lower limit.
  double get rpropDWMin => cml.cv_ml_ANN_MLP_get_rpropDWMin(ref);
  set rpropDWMin(double value) => cml.cv_ml_ANN_MLP_set_rpropDWMin(ref, value);

  /// RPROP: update-values upper limit.
  double get rpropDWMax => cml.cv_ml_ANN_MLP_get_rpropDWMax(ref);
  set rpropDWMax(double value) => cml.cv_ml_ANN_MLP_set_rpropDWMax(ref, value);

  /// ANNEAL: initial temperature.
  double get annealInitialT => cml.cv_ml_ANN_MLP_get_annealInitialT(ref);
  set annealInitialT(double value) => cml.cv_ml_ANN_MLP_set_annealInitialT(ref, value);

  /// ANNEAL: final temperature.
  double get annealFinalT => cml.cv_ml_ANN_MLP_get_annealFinalT(ref);
  set annealFinalT(double value) => cml.cv_ml_ANN_MLP_set_annealFinalT(ref, value);

  /// ANNEAL: cooling ratio.
  double get annealCoolingRatio => cml.cv_ml_ANN_MLP_get_annealCoolingRatio(ref);
  set annealCoolingRatio(double value) => cml.cv_ml_ANN_MLP_set_annealCoolingRatio(ref, value);

  /// ANNEAL: iteration per step.
  int get annealItePerStep => cml.cv_ml_ANN_MLP_get_annealItePerStep(ref);
  set annealItePerStep(int value) => cml.cv_ml_ANN_MLP_set_annealItePerStep(ref, value);
}
