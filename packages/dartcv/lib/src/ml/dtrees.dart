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

/// The class represents a single decision tree or a collection of decision trees.
/// https://docs.opencv.org/4.x/d8/d89/classcv_1_1ml_1_1DTrees.html
class DTrees extends CvStruct<cml.DTrees> {
  DTrees._(cml.DTreesPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory DTrees.fromPointer(cml.DTreesPtr ptr, [bool attach = true]) => DTrees._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [DTrees.load].
  factory DTrees.create() {
    final p = calloc<cml.DTrees>();
    cvRun(() => cml.cv_ml_DTrees_create(p));
    return DTrees._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory DTrees.load(String filepath) => using(
    (arena) => DTrees._make((p) => cml.cv_ml_DTrees_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory DTrees.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => DTrees._make(
      (p) => cml.cv_ml_DTrees_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory DTrees._make(ffi.Pointer<cml.CvStatus> Function(cml.DTreesPtr p) func) {
    final p = calloc<cml.DTrees>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return DTrees._(p);
  }

  static final finalizer = OcvFinalizer<cml.DTreesPtr>(cml.addresses.cv_ml_DTrees_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_DTrees_close(ptr);
  }

  @override
  cml.DTrees get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_DTrees_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_DTrees_clear(ref));

  bool get isEmpty => cml.cv_ml_DTrees_empty(ref);
  bool get isTrained => cml.cv_ml_DTrees_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_DTrees_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_DTrees_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_dtree`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_DTrees_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_DTrees_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_DTrees_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// [flags] may combine [StatModel.RAW_OUTPUT] and one of the `PREDICT_*` flags.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_DTrees_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_DTrees_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // predict flags
  static const int PREDICT_AUTO = 0;
  static const int PREDICT_SUM = 1 << 8;
  static const int PREDICT_MAX_VOTE = 2 << 8;
  static const int PREDICT_MASK = 3 << 8;

  /// Cluster possible values of a categorical variable into K <= maxCategories clusters to find a suboptimal split.
  int get maxCategories => cml.cv_ml_DTrees_get_maxCategories(ref);
  set maxCategories(int value) => cvRun(() => cml.cv_ml_DTrees_set_maxCategories(ref, value));

  /// The maximum possible depth of the tree. The default is `INT_MAX`, for which OpenCV's training
  /// fails: set a finite depth before training.
  int get maxDepth => cml.cv_ml_DTrees_get_maxDepth(ref);
  set maxDepth(int value) => cvRun(() => cml.cv_ml_DTrees_set_maxDepth(ref, value));

  /// If the number of samples in a node is less than this parameter then the node will not be split.
  int get minSampleCount => cml.cv_ml_DTrees_get_minSampleCount(ref);
  set minSampleCount(int value) => cvRun(() => cml.cv_ml_DTrees_set_minSampleCount(ref, value));

  /// If cvFolds > 1 then algorithms prunes the built decision tree using K-fold cross-validation procedure where K is equal to cvFolds.
  int get cvFolds => cml.cv_ml_DTrees_get_cvFolds(ref);
  set cvFolds(int value) => cvRun(() => cml.cv_ml_DTrees_set_cvFolds(ref, value));

  /// If true then surrogate splits will be built.
  bool get useSurrogates => cml.cv_ml_DTrees_get_useSurrogates(ref);
  set useSurrogates(bool value) => cvRun(() => cml.cv_ml_DTrees_set_useSurrogates(ref, value));

  /// If true then a pruning will be harsher.
  bool get use1SERule => cml.cv_ml_DTrees_get_use1SERule(ref);
  set use1SERule(bool value) => cvRun(() => cml.cv_ml_DTrees_set_use1SERule(ref, value));

  /// If true then pruned branches are physically removed from the tree.
  bool get truncatePrunedTree => cml.cv_ml_DTrees_get_truncatePrunedTree(ref);
  set truncatePrunedTree(bool value) => cvRun(() => cml.cv_ml_DTrees_set_truncatePrunedTree(ref, value));

  /// Termination criteria for regression trees.
  double get regressionAccuracy => cml.cv_ml_DTrees_get_regressionAccuracy(ref);
  set regressionAccuracy(double value) => cvRun(() => cml.cv_ml_DTrees_set_regressionAccuracy(ref, value));

  /// The array of a priori class probabilities, sorted by the class label value.
  Mat get priors {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_DTrees_getPriors(ref, rval.ref));
    return rval;
  }

  set priors(Mat value) => cvRun(() => cml.cv_ml_DTrees_setPriors(ref, value.ref));
}
