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

/// Parameters of a grid searched by [SVM.trainAuto].
///
/// The grid starts at [minVal] and is multiplied by [logStep] while below [maxVal].
/// A [logStep] <= 1 disables the search for that parameter.
/// https://docs.opencv.org/4.x/d6/dca/classcv_1_1ml_1_1ParamGrid.html
class ParamGrid {
  const ParamGrid(this.minVal, this.maxVal, this.logStep);

  final double minVal;
  final double maxVal;
  final double logStep;

  void _write(cml.MlParamGrid g) {
    g.minVal = minVal;
    g.maxVal = maxVal;
    g.logStep = logStep;
  }

  @override
  bool operator ==(Object other) =>
      other is ParamGrid && other.minVal == minVal && other.maxVal == maxVal && other.logStep == logStep;

  @override
  int get hashCode => Object.hash(minVal, maxVal, logStep);

  @override
  String toString() => 'ParamGrid(minVal: $minVal, maxVal: $maxVal, logStep: $logStep)';
}

/// Support Vector Machines.
/// https://docs.opencv.org/4.x/d1/d2d/classcv_1_1ml_1_1SVM.html
class SVM extends CvStruct<cml.SVM> {
  SVM._(cml.SVMPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory SVM.fromPointer(cml.SVMPtr ptr, [bool attach = true]) => SVM._(ptr, attach);

  /// Creates an empty model. Use one of the train methods to train it, or [SVM.load].
  factory SVM.create() {
    final p = calloc<cml.SVM>();
    cvRun(() => cml.cv_ml_SVM_create(p));
    return SVM._(p);
  }

  /// Loads a model saved with [save] from [filepath]. Throws [CvException] when the file
  /// does not hold a valid model.
  factory SVM.load(String filepath) => using(
    (arena) => SVM._make((p) => cml.cv_ml_SVM_load(filepath.toNativeUtf8(allocator: arena).cast(), p)),
  );

  /// Loads a model from the content of a file saved with [save] (e.g. a Flutter asset).
  ///
  /// [objname] is the name of the model node, the first top-level node when empty.
  factory SVM.loadFromString(String strModel, {String objname = ''}) => using(
    (arena) => SVM._make(
      (p) => cml.cv_ml_SVM_loadFromString(
        strModel.toNativeUtf8(allocator: arena).cast(),
        objname.toNativeUtf8(allocator: arena).cast(),
        p,
      ),
    ),
  );

  factory SVM._make(ffi.Pointer<cml.CvStatus> Function(cml.SVMPtr p) func) {
    final p = calloc<cml.SVM>();
    try {
      cvRun(() => func(p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return SVM._(p);
  }

  static final finalizer = OcvFinalizer<cml.SVMPtr>(cml.addresses.cv_ml_SVM_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    cml.cv_ml_SVM_close(ptr);
  }

  @override
  cml.SVM get ref => ptr.ref;

  /// Saves the model to [filename] (.xml, .yml or .json).
  void save(String filename) => using(
    (arena) => cvRun(() => cml.cv_ml_SVM_save(ref, filename.toNativeUtf8(allocator: arena).cast())),
  );

  /// Clears the model, it becomes untrained.
  void clear() => cvRun(() => cml.cv_ml_SVM_clear(ref));

  bool get isEmpty => cml.cv_ml_SVM_empty(ref);
  bool get isTrained => cml.cv_ml_SVM_isTrained(ref);

  /// Whether the model is a classifier (false for a regressor).
  bool get isClassifier => cml.cv_ml_SVM_isClassifier(ref);

  /// Number of variables in training samples.
  int get varCount => cml.cv_ml_SVM_getVarCount(ref);

  /// The name used when saving the model, `opencv_ml_svm`.
  String get defaultName {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    try {
      cvRun(() => cml.cv_ml_SVM_getDefaultName(ref, p));
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
      cvRun(() => cml.cv_ml_SVM_train_1(ref, samples.ref, layout, responses.ref, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the model on [data], [flags] may be [StatModel.UPDATE_MODEL] or model-specific flags.
  bool trainWithData(TrainData data, {int flags = 0}) {
    final p = calloc<ffi.Bool>();
    try {
      cvRun(() => cml.cv_ml_SVM_train(ref, data.ref, flags, p, ffi.nullptr));
      return p.value;
    } finally {
      calloc.free(p);
    }
  }

  /// Predicts the response for each row of [samples], one row of the returned Mat per sample.
  ///
  /// With [StatModel.RAW_OUTPUT] the decision function values are returned instead of the labels.
  Mat predict(Mat samples, {int flags = 0}) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_SVM_predict(ref, samples.ref, results.ref, flags, p, ffi.nullptr));
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
      cvRun(() => cml.cv_ml_SVM_calcError(ref, data.ref, test, resp.ref, p, ffi.nullptr));
      return (p.value, resp);
    } catch (_) {
      resp.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  // SVM types
  static const int C_SVC = 100;
  static const int NU_SVC = 101;
  static const int ONE_CLASS = 102;
  static const int EPS_SVR = 103;
  static const int NU_SVR = 104;

  // kernel types
  static const int CUSTOM = -1;
  static const int LINEAR = 0;
  static const int POLY = 1;
  static const int RBF = 2;
  static const int SIGMOID = 3;
  static const int CHI2 = 4;
  static const int INTER = 5;

  // parameter ids of getDefaultGrid
  static const int PARAM_C = 0;
  static const int PARAM_GAMMA = 1;
  static const int PARAM_P = 2;
  static const int PARAM_NU = 3;
  static const int PARAM_COEF = 4;
  static const int PARAM_DEGREE = 5;

  /// Type of a SVM formulation, one of [C_SVC], [NU_SVC], [ONE_CLASS], [EPS_SVR], [NU_SVR].
  int get type => cml.cv_ml_SVM_get_type(ref);
  set type(int value) => cml.cv_ml_SVM_set_type(ref, value);

  /// Type of a SVM kernel, one of [LINEAR], [POLY], [RBF], [SIGMOID], [CHI2], [INTER].
  int get kernelType => cml.cv_ml_SVM_get_kernelType(ref);
  set kernelType(int value) => cml.cv_ml_SVM_set_kernelType(ref, value);

  /// Parameter gamma of a kernel function.
  double get gamma => cml.cv_ml_SVM_get_gamma(ref);
  set gamma(double value) => cml.cv_ml_SVM_set_gamma(ref, value);

  /// Parameter coef0 of a kernel function.
  double get coef0 => cml.cv_ml_SVM_get_coef0(ref);
  set coef0(double value) => cml.cv_ml_SVM_set_coef0(ref, value);

  /// Parameter degree of a kernel function.
  double get degree => cml.cv_ml_SVM_get_degree(ref);
  set degree(double value) => cml.cv_ml_SVM_set_degree(ref, value);

  /// Parameter C of a SVM optimization problem.
  double get C => cml.cv_ml_SVM_get_C(ref);
  set C(double value) => cml.cv_ml_SVM_set_C(ref, value);

  /// Parameter nu of a SVM optimization problem.
  double get nu => cml.cv_ml_SVM_get_nu(ref);
  set nu(double value) => cml.cv_ml_SVM_set_nu(ref, value);

  /// Parameter epsilon of a SVM optimization problem.
  double get p => cml.cv_ml_SVM_get_p(ref);
  set p(double value) => cml.cv_ml_SVM_set_p(ref, value);

  /// Optional weights in the [C_SVC] problem, assigned to particular classes.
  Mat get classWeights {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_SVM_getClassWeights(ref, rval.ref));
    return rval;
  }

  set classWeights(Mat value) => cvRun(() => cml.cv_ml_SVM_setClassWeights(ref, value.ref));

  /// Termination criteria of the training algorithm.
  TermCriteria get termCriteria {
    final p = calloc<cvg.TermCriteria>();
    try {
      cvRun(() => cml.cv_ml_SVM_getTermCriteria(ref, p));
    } catch (_) {
      calloc.free(p);
      rethrow;
    }
    return TermCriteria.fromPointer(p);
  }

  set termCriteria(TermCriteria value) => cvRun(() => cml.cv_ml_SVM_setTermCriteria(ref, value.ref));

  /// All the support vectors, compressed for a linear kernel.
  Mat get supportVectors {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_SVM_getSupportVectors(ref, rval.ref));
    return rval;
  }

  /// All the uncompressed support vectors of a linear SVM.
  Mat get uncompressedSupportVectors {
    final rval = Mat.empty();
    cvRun(() => cml.cv_ml_SVM_getUncompressedSupportVectors(ref, rval.ref));
    return rval;
  }

  /// Retrieves the decision function [i].
  ///
  /// Returns the `rho` value, the weights `alpha` and the indices of the support vectors `svidx`.
  (double rho, Mat alpha, Mat svidx) getDecisionFunction(int i) {
    final p = calloc<ffi.Double>();
    final alpha = Mat.empty();
    final svidx = Mat.empty();
    try {
      cvRun(() => cml.cv_ml_SVM_getDecisionFunction(ref, i, alpha.ref, svidx.ref, p));
      return (p.value, alpha, svidx);
    } catch (_) {
      alpha.dispose();
      svidx.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  /// The default grid of the SVM parameter [paramId], one of [PARAM_C] .. [PARAM_DEGREE].
  static ParamGrid getDefaultGrid(int paramId) {
    final p = calloc<cml.MlParamGrid>();
    try {
      cvRun(() => cml.cv_ml_SVM_getDefaultGrid(paramId, p));
      return ParamGrid(p.ref.minVal, p.ref.maxVal, p.ref.logStep);
    } finally {
      calloc.free(p);
    }
  }

  /// Trains the SVM with the optimal parameters found by a [kFold] cross-validation over the
  /// grids, a grid left `null` uses [getDefaultGrid].
  ///
  /// [balanced] creates more balanced cross-validation subsets for 2-class classification.
  bool trainAuto(
    TrainData data, {
    int kFold = 10,
    ParamGrid? Cgrid,
    ParamGrid? gammaGrid,
    ParamGrid? pGrid,
    ParamGrid? nuGrid,
    ParamGrid? coeffGrid,
    ParamGrid? degreeGrid,
    bool balanced = false,
  }) {
    final p = calloc<ffi.Bool>();
    final grids = _grids([Cgrid, gammaGrid, pGrid, nuGrid, coeffGrid, degreeGrid]);
    try {
      cvRun(
        () => cml.cv_ml_SVM_trainAuto(
          ref,
          data.ref,
          kFold,
          grids[0],
          grids[1],
          grids[2],
          grids[3],
          grids[4],
          grids[5],
          balanced,
          p,
          ffi.nullptr,
        ),
      );
      return p.value;
    } finally {
      calloc.free(grids);
      calloc.free(p);
    }
  }

  /// Native copies of the six trainAuto grids, `null` ones replaced by the defaults.
  static ffi.Pointer<cml.MlParamGrid> _grids(List<ParamGrid?> grids) {
    final p = calloc<cml.MlParamGrid>(grids.length);
    for (final (i, g) in grids.indexed) {
      (g ?? getDefaultGrid(i))._write(p[i]);
    }
    return p;
  }
}
