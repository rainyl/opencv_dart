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

/// The class implements the Expectation Maximization algorithm.
/// https://docs.opencv.org/4.x/d1/dfb/classcv_1_1ml_1_1EM.html
class EM extends CvStruct<cml.EM> {
  EM._(cml.EMPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory EM.fromPointer(cml.EMPtr ptr, [bool attach = true]) => EM._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [EM.load].
  factory EM.create() {
    final p = calloc<cml.EM>();
    cvRun(() => cml.cv_ml_EM_create(p));
    return EM._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory EM.load(String filepath) => using(
    (arena) => EM._make((p) => cml.cv_ml_EM_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory EM.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => EM._make(
      (p) => cml.cv_ml_EM_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory EM._make(ffi.Pointer<cml.CvStatus> Function(cml.EMPtr p) func) {
    final p = calloc<cml.EM>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return EM._(p);
  }

  static final finalizer = OcvFinalizer<cml.EMPtr>(cml.addresses.cv_ml_EM_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_EM_close(ptr);
  }

  @override
  cml.EM get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_EM_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_EM_clear(ref));

  bool get isEmpty => cml.cv_ml_EM_empty(ref);
  bool get isTrained => cml.cv_ml_EM_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_EM_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_EM_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_em`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_EM_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_EM_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_EM_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// Each row of the result holds the posterior probabilities of the mixture components, [flags] is ignored.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_EM_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_EM_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // covariance matrix types
  static const int COV_MAT_SPHERICAL = 0;
  static const int COV_MAT_DIAGONAL = 1;
  static const int COV_MAT_GENERIC = 2;
  static const int COV_MAT_DEFAULT = COV_MAT_DIAGONAL;

  static const int DEFAULT_NCLUSTERS = 5;
  static const int DEFAULT_MAX_ITERS = 100;

  static const int START_E_STEP = 1;
  static const int START_M_STEP = 2;
  static const int START_AUTO_STEP = 0;

  /// The number of mixture components in the Gaussian mixture model.
  int get clustersNumber => cml.cv_ml_EM_get_clustersNumber(ref);
  set clustersNumber(int value) => cvRun(() => cml.cv_ml_EM_set_clustersNumber(ref, value));

  /// Constraint on covariance matrices, one of the `COV_MAT_*` types.
  int get covarianceMatrixType => cml.cv_ml_EM_get_covarianceMatrixType(ref);
  set covarianceMatrixType(int value) => cvRun(() => cml.cv_ml_EM_set_covarianceMatrixType(ref, value));

  /// The weights of the mixtures, a 1 x clustersNumber vector.
  Mat get weights {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_EM_getWeights(ref, rval.ref));
    return rval;
  }

  /// The cluster centers (means of the Gaussian mixture), clustersNumber x dims.
  Mat get means {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_EM_getMeans(ref, rval.ref));
    return rval;
  }

  /// Termination criteria of the training algorithm.
  TermCriteria get termCriteria {
    final p = calloc<cvg.TermCriteria>();
    try {
      cvRun(() => cml.cv_ml_EM_getTermCriteria(ref, p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TermCriteria.fromPointer(p);
  }

  set termCriteria(TermCriteria value) => cvRun(() => cml.cv_ml_EM_setTermCriteria(ref, value.ref));

  /// The covariance matrices of the mixture components, one dims x dims Mat per component.
  VecMat get covs {
    final rval = VecMat();
    try {
      cvRun(() => cml.cv_ml_EM_getCovs(ref, rval.ptr));
    } catch (_) {
      rval.dispose();
      rethrow;
    }
    return rval;
  }

  /// Predicts the likelihood logarithm and the most probable mixture component of [sample]
  /// (a single row), and the posterior probability of each component.
  (double logLikelihood, int label, Mat probs) predict2(Mat sample) {
    final p = calloc<cvg.Vec2d>();
    final probs = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_EM_predict2(ref, sample.ref, probs.ref, p, ffi.nullptr));
      return (p.ref.val1, p.ref.val2.round(), probs);
    } catch (_) {
      probs.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  /// Estimates the Gaussian mixture parameters from [samples], starting with the
  /// Expectation step from initial values computed by k-means.
  ///
  /// Returns whether training succeeded, the likelihood logarithm of each sample, the most
  /// probable mixture component of each sample and the posterior probabilities.
  (bool, Mat logLikelihoods, Mat labels, Mat probs) trainEM(Mat samples) => _train(
    (l, lb, pr, p) => cml.cv_ml_EM_trainEM(ref, samples.ref, l, lb, pr, p, ffi.nullptr),
  );

  /// Like [trainEM], starting with the Expectation step from the initial means [means0] and the
  /// optional initial covariance matrices [covs0] and weights [weights0].
  ///
  /// Unless both [covs0] and [weights0] are given, OpenCV initializes the model with k-means seeded
  /// by [means0], so the order of the resulting components may differ from [means0].
  (bool, Mat logLikelihoods, Mat labels, Mat probs) trainE(
    Mat samples,
    Mat means0, {
    VecMat? covs0,
    Mat? weights0,
  }) {
    final covs = covs0 ?? VecMat();
    final weights = weights0 ?? Mat.empty();
    try {
      return _train(
        (l, lb, pr, p) => cml.cv_ml_EM_trainE(
          ref,
          samples.ref,
          means0.ref,
          covs.ref,
          weights.ref,
          l,
          lb,
          pr,
          p,
          ffi.nullptr,
        ),
      );
    } finally {
      if (covs0 == null) covs.dispose();
      if (weights0 == null) weights.dispose();
    }
  }

  /// Like [trainEM], starting with the Maximization step from the initial probabilities [probs0].
  (bool, Mat logLikelihoods, Mat labels, Mat probs) trainM(Mat samples, Mat probs0) => _train(
    (l, lb, pr, p) => cml.cv_ml_EM_trainM(ref, samples.ref, probs0.ref, l, lb, pr, p, ffi.nullptr),
  );

  (bool, Mat, Mat, Mat) _train(
    ffi.Pointer<cml.CvStatus> Function(cml.Mat l, cml.Mat lb, cml.Mat pr, ffi.Pointer<ffi.Bool> p) func,
  ) {
    final p = calloc<ffi.Bool>();
    final logLikelihoods = Mat.empty();
    final labels = Mat.empty();
    final probs = Mat.empty();
    try {
      cvRun(() => func(logLikelihoods.ref, labels.ref, probs.ref, p));
      return (p.value, logLikelihoods, labels, probs);
    } catch (_) {
      logLikelihoods.dispose();
      labels.dispose();
      probs.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }
}
