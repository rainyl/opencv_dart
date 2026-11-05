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
import '../core/vec.dart';
import '../g/ml.g.dart' as cml;
import 'dtrees.dart';
import 'ml_constants.dart';
import 'train_data.dart';

/// Boosted tree classifier derived from DTrees.
/// https://docs.opencv.org/4.x/db/d7d/classcv_1_1ml_1_1Boost.html
class Boost extends CvStruct<cml.Boost> {
  Boost._(cml.BoostPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Boost.fromPointer(cml.BoostPtr ptr, [bool attach = true]) => Boost._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [Boost.load].
  factory Boost.create() {
    final p = calloc<cml.Boost>();
    cvRun(() => cml.cv_ml_Boost_create(p));
    return Boost._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory Boost.load(String filepath) => using(
    (arena) => Boost._make((p) => cml.cv_ml_Boost_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory Boost.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => Boost._make(
      (p) => cml.cv_ml_Boost_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory Boost._make(ffi.Pointer<cml.CvStatus> Function(cml.BoostPtr p) func) {
    final p = calloc<cml.Boost>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return Boost._(p);
  }

  static final finalizer = OcvFinalizer<cml.BoostPtr>(cml.addresses.cv_ml_Boost_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_Boost_close(ptr);
  }

  @override
  cml.Boost get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_Boost_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Calls OpenCV's `clear`, which does not reset this model: it stays trained. Create a new
  /// model to start over.
  void clear() => cvRun(() => cml.cv_ml_Boost_clear(ref));

  bool get isEmpty => cml.cv_ml_Boost_empty(ref);
  bool get isTrained => cml.cv_ml_Boost_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_Boost_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_Boost_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_boost`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_Boost_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_Boost_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_Boost_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// [flags] may combine [StatModel.RAW_OUTPUT] and one of the `DTrees.PREDICT_*` flags. With
  /// [StatModel.RAW_OUTPUT] alone the result is the class index; pass
  /// `StatModel.RAW_OUTPUT | DTrees.PREDICT_SUM` for the raw sum of the weak responses.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_Boost_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_Boost_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // boost types
  static const int DISCRETE = 0;
  static const int REAL = 1;
  static const int LOGIT = 2;
  static const int GENTLE = 3;

  /// Cluster possible values of a categorical variable into K <= maxCategories clusters to find a
  /// suboptimal split. Must be >= 2, values above 15 are clamped to 15.
  int get maxCategories => cml.cv_ml_Boost_get_maxCategories(ref);
  set maxCategories(int value) => cvRun(() => cml.cv_ml_Boost_set_maxCategories(ref, value));

  /// The maximum possible depth of the tree, values above 25 are clamped to 25.
  ///
  /// Training reserves memory for about 2^maxDepth nodes, so keep it small (e.g. 5 to 10). The
  /// `DTrees` default, `INT_MAX`, makes OpenCV's training fail.
  int get maxDepth => cml.cv_ml_Boost_get_maxDepth(ref);
  set maxDepth(int value) => cvRun(() => cml.cv_ml_Boost_set_maxDepth(ref, value));

  /// If the number of samples in a node is less than this parameter then the node will not be split.
  int get minSampleCount => cml.cv_ml_Boost_get_minSampleCount(ref);
  set minSampleCount(int value) => cvRun(() => cml.cv_ml_Boost_set_minSampleCount(ref, value));

  /// The number of cross-validation folds used to prune the tree. OpenCV 4.x does not implement the
  /// pruning: values > 1 throw and 1 is stored as 0 (no pruning).
  int get cvFolds => cml.cv_ml_Boost_get_cvFolds(ref);
  set cvFolds(int value) => cvRun(() => cml.cv_ml_Boost_set_cvFolds(ref, value));

  /// Whether to build surrogate splits. Not implemented in OpenCV 4.x: training with `true` throws.
  bool get useSurrogates => cml.cv_ml_Boost_get_useSurrogates(ref);
  set useSurrogates(bool value) => cvRun(() => cml.cv_ml_Boost_set_useSurrogates(ref, value));

  /// If true then a pruning will be harsher.
  bool get use1SERule => cml.cv_ml_Boost_get_use1SERule(ref);
  set use1SERule(bool value) => cvRun(() => cml.cv_ml_Boost_set_use1SERule(ref, value));

  /// If true then pruned branches are physically removed from the tree.
  bool get truncatePrunedTree => cml.cv_ml_Boost_get_truncatePrunedTree(ref);
  set truncatePrunedTree(bool value) => cvRun(() => cml.cv_ml_Boost_set_truncatePrunedTree(ref, value));

  /// Termination criteria for regression trees.
  double get regressionAccuracy => cml.cv_ml_Boost_get_regressionAccuracy(ref);
  set regressionAccuracy(double value) => cvRun(() => cml.cv_ml_Boost_set_regressionAccuracy(ref, value));

  /// Type of the boosting algorithm, one of [DISCRETE], [REAL], [LOGIT], [GENTLE].
  int get boostType => cml.cv_ml_Boost_get_boostType(ref);
  set boostType(int value) => cvRun(() => cml.cv_ml_Boost_set_boostType(ref, value));

  /// The number of weak classifiers.
  int get weakCount => cml.cv_ml_Boost_get_weakCount(ref);
  set weakCount(int value) => cvRun(() => cml.cv_ml_Boost_set_weakCount(ref, value));

  /// A threshold between 0 and 1 used to save computational time.
  double get weightTrimRate => cml.cv_ml_Boost_get_weightTrimRate(ref);
  set weightTrimRate(double value) => cvRun(() => cml.cv_ml_Boost_set_weightTrimRate(ref, value));

  /// The array of a priori class probabilities, sorted by the class label value.
  Mat get priors {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_Boost_getPriors(ref, rval.ref));
    return rval;
  }

  set priors(Mat value) => cvRun(() => cml.cv_ml_Boost_setPriors(ref, value.ref));

  /// The indices of the root nodes, one per tree.
  List<int> get roots {
    final v = VecI32();
    try {
      cvRun(() => cml.cv_ml_Boost_getRoots(ref, v.ptr));
      return v.toList();
    } finally {
      v.dispose();
    }
  }

  /// All the nodes of the trees, the children of a node are referenced by index.
  List<DTreesNode> get nodes {
    final count = calloc<ffi.Int>();
    try {
      cvRun(() => cml.cv_ml_Boost_getNodes(ref, ffi.nullptr, 0, count));
      final n = count.value;
      final buf = calloc<cml.MlDTreesNode>(n);
      try {
        cvRun(() => cml.cv_ml_Boost_getNodes(ref, buf, n, count));
        return List.generate(n, (i) {
          final e = buf[i];
          return DTreesNode(
            value: e.value,
            classIdx: e.classIdx,
            parent: e.parent,
            left: e.left,
            right: e.right,
            defaultDir: e.defaultDir,
            split: e.split,
          );
        });
      } finally {
        calloc.free(buf);
      }
    } finally {
      calloc.free(count);
    }
  }

  /// All the splits of the trees, referenced by [DTreesNode.split] and [DTreesSplit.next].
  List<DTreesSplit> get splits {
    final count = calloc<ffi.Int>();
    try {
      cvRun(() => cml.cv_ml_Boost_getSplits(ref, ffi.nullptr, 0, count));
      final n = count.value;
      final buf = calloc<cml.MlDTreesSplit>(n);
      try {
        cvRun(() => cml.cv_ml_Boost_getSplits(ref, buf, n, count));
        return List.generate(n, (i) {
          final e = buf[i];
          return DTreesSplit(
            varIdx: e.varIdx,
            inversed: e.inversed,
            quality: e.quality,
            next: e.next,
            c: e.c,
            subsetOfs: e.subsetOfs,
          );
        });
      } finally {
        calloc.free(buf);
      }
    } finally {
      calloc.free(count);
    }
  }

  /// The bitsets of the splits on categorical variables, see [DTreesSplit.subsetOfs].
  List<int> get subsets {
    final v = VecI32();
    try {
      cvRun(() => cml.cv_ml_Boost_getSubsets(ref, v.ptr));
      return v.toList();
    } finally {
      v.dispose();
    }
  }
}
