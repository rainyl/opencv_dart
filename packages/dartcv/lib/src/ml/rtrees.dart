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

/// The class implements the random forest predictor.
/// https://docs.opencv.org/4.x/d0/d65/classcv_1_1ml_1_1RTrees.html
class RTrees extends CvStruct<cml.RTrees> {
  RTrees._(cml.RTreesPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory RTrees.fromPointer(cml.RTreesPtr ptr, [bool attach = true]) => RTrees._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [RTrees.load].
  factory RTrees.create() {
    final p = calloc<cml.RTrees>();
    cvRun(() => cml.cv_ml_RTrees_create(p));
    return RTrees._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory RTrees.load(String filepath) => using(
    (arena) => RTrees._make((p) => cml.cv_ml_RTrees_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory RTrees.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => RTrees._make(
      (p) => cml.cv_ml_RTrees_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory RTrees._make(ffi.Pointer<cml.CvStatus> Function(cml.RTreesPtr p) func) {
    final p = calloc<cml.RTrees>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return RTrees._(p);
  }

  static final finalizer = OcvFinalizer<cml.RTreesPtr>(cml.addresses.cv_ml_RTrees_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_RTrees_close(ptr);
  }

  @override
  cml.RTrees get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_RTrees_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_RTrees_clear(ref));

  bool get isEmpty => cml.cv_ml_RTrees_empty(ref);
  bool get isTrained => cml.cv_ml_RTrees_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_RTrees_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_RTrees_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_rtrees`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_RTrees_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_RTrees_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_RTrees_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// [flags] may combine [StatModel.RAW_OUTPUT] and one of the `DTrees.PREDICT_*` flags.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_RTrees_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_RTrees_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  /// Cluster possible values of a categorical variable into K <= maxCategories clusters to find a
  /// suboptimal split. Must be >= 2, values above 15 are clamped to 15.
  int get maxCategories => cml.cv_ml_RTrees_get_maxCategories(ref);
  set maxCategories(int value) => cvRun(() => cml.cv_ml_RTrees_set_maxCategories(ref, value));

  /// The maximum possible depth of the tree, values above 25 are clamped to 25.
  ///
  /// Training reserves memory for about 2^maxDepth nodes, so keep it small (e.g. 5 to 10). The
  /// `DTrees` default, `INT_MAX`, makes OpenCV's training fail.
  int get maxDepth => cml.cv_ml_RTrees_get_maxDepth(ref);
  set maxDepth(int value) => cvRun(() => cml.cv_ml_RTrees_set_maxDepth(ref, value));

  /// If the number of samples in a node is less than this parameter then the node will not be split.
  int get minSampleCount => cml.cv_ml_RTrees_get_minSampleCount(ref);
  set minSampleCount(int value) => cvRun(() => cml.cv_ml_RTrees_set_minSampleCount(ref, value));

  /// The number of cross-validation folds used to prune the tree. OpenCV 4.x does not implement the
  /// pruning: values > 1 throw and 1 is stored as 0 (no pruning).
  int get cvFolds => cml.cv_ml_RTrees_get_cvFolds(ref);
  set cvFolds(int value) => cvRun(() => cml.cv_ml_RTrees_set_cvFolds(ref, value));

  /// Whether to build surrogate splits. Not implemented in OpenCV 4.x: training with `true` throws.
  bool get useSurrogates => cml.cv_ml_RTrees_get_useSurrogates(ref);
  set useSurrogates(bool value) => cvRun(() => cml.cv_ml_RTrees_set_useSurrogates(ref, value));

  /// If true then a pruning will be harsher.
  bool get use1SERule => cml.cv_ml_RTrees_get_use1SERule(ref);
  set use1SERule(bool value) => cvRun(() => cml.cv_ml_RTrees_set_use1SERule(ref, value));

  /// If true then pruned branches are physically removed from the tree.
  bool get truncatePrunedTree => cml.cv_ml_RTrees_get_truncatePrunedTree(ref);
  set truncatePrunedTree(bool value) => cvRun(() => cml.cv_ml_RTrees_set_truncatePrunedTree(ref, value));

  /// Termination criteria for regression trees.
  double get regressionAccuracy => cml.cv_ml_RTrees_get_regressionAccuracy(ref);
  set regressionAccuracy(double value) => cvRun(() => cml.cv_ml_RTrees_set_regressionAccuracy(ref, value));

  /// If true then variable importance will be calculated.
  bool get calculateVarImportance => cml.cv_ml_RTrees_get_calculateVarImportance(ref);
  set calculateVarImportance(bool value) =>
      cvRun(() => cml.cv_ml_RTrees_set_calculateVarImportance(ref, value));

  /// The size of the randomly selected subset of features at each tree node.
  int get activeVarCount => cml.cv_ml_RTrees_get_activeVarCount(ref);
  set activeVarCount(int value) => cvRun(() => cml.cv_ml_RTrees_set_activeVarCount(ref, value));

  /// The array of a priori class probabilities, sorted by the class label value.
  Mat get priors {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_RTrees_getPriors(ref, rval.ref));
    return rval;
  }

  set priors(Mat value) => cvRun(() => cml.cv_ml_RTrees_setPriors(ref, value.ref));

  /// The variable importance array, empty unless [calculateVarImportance] was set when training.
  Mat get varImportance {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_RTrees_getVarImportance(ref, rval.ref));
    return rval;
  }

  /// Termination criteria of the training algorithm.
  TermCriteria get termCriteria {
    final p = calloc<cvg.TermCriteria>();
    try {
      cvRun(() => cml.cv_ml_RTrees_getTermCriteria(ref, p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TermCriteria.fromPointer(p);
  }

  set termCriteria(TermCriteria value) => cvRun(() => cml.cv_ml_RTrees_setTermCriteria(ref, value.ref));

  /// Returns the result of each individual tree in the forest.
  ///
  /// For classification (`DTrees.PREDICT_MAX_VOTE`, the default) the first row holds the class
  /// labels and each following row the number of votes of one sample of [samples] for each class
  /// (`CV_32S`). For regression, with `DTrees.PREDICT_SUM`, or for a 2-class model with
  /// [StatModel.RAW_OUTPUT], each row holds the value of each tree for one sample (`CV_32F`).
  Mat getVotes(Mat samples, {int flags = 0}) {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_RTrees_getVotes(ref, samples.ref, rval.ref, flags));
    return rval;
  }

  /// The out-of-bag error of the trained forest, only computed when [calculateVarImportance] is
  /// set or [termCriteria] has an epsilon; 0 otherwise.
  double get oobError => cml.cv_ml_RTrees_getOOBError(ref);
}
