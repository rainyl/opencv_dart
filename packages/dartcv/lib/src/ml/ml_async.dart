// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: camel_case_extensions

library cv.ml;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/ml.g.dart' as cml;
import '../g/types.g.dart' as cvg;
import 'ann_mlp.dart';
import 'boost.dart';
import 'dtrees.dart';
import 'em.dart';
import 'knearest.dart';
import 'logistic_regression.dart';
import 'normal_bayes_classifier.dart';
import 'rtrees.dart';
import 'svm.dart';
import 'svmsgd.dart';
import 'train_data.dart';

/// Runs [func] asynchronously and returns the `bool` it writes.
Future<bool> _boolAsync(
  ffi.Pointer<cvg.CvStatus> Function(ffi.Pointer<ffi.Bool> p, cvg.CvCallback_0 callback) func,
) async {
  final p = calloc<ffi.Bool>();
  try {
    return await cvRunAsync0<bool>((callback) => func(p, callback), (c) => c.complete(p.value));
  } finally {
    calloc.free(p);
  }
}

/// Runs [func] asynchronously and returns the `float` it writes and the Mat it fills.
Future<(double, Mat)> _floatMatAsync(
  ffi.Pointer<cvg.CvStatus> Function(ffi.Pointer<ffi.Float> p, cml.Mat m, cvg.CvCallback_0 callback) func,
) async {
  final p = calloc<ffi.Float>();
  final m = Mat.empty();
  try {
    return await cvRunAsync0<(double, Mat)>(
      (callback) => func(p, m.ref, callback),
      (c) => c.complete((p.value, m)),
    );
  } catch (_) {
    m.dispose();
    rethrow;
  } finally {
    calloc.free(p);
  }
}

extension TrainDataAsync on TrainData {
  /// Async version of [TrainData.loadFromCSV].
  static Future<TrainData> loadFromCSVAsync(
    String filename,
    int headerLineCount, {
    int responseStartIdx = -1,
    int responseEndIdx = -1,
    String varTypeSpec = '',
    String delimiter = ',',
    String missch = '?',
  }) async {
    final delim = TrainData.singleChar(delimiter, 'delimiter');
    final miss = TrainData.singleChar(missch, 'missch');
    final p = calloc<cml.TrainData>();
    final cFilename = filename.toNativeUtf8();
    final cSpec = varTypeSpec.toNativeUtf8();
    try {
      await cvRunAsync0<void>(
        (callback) => cml.cv_ml_TrainData_loadFromCSV(
          cFilename.cast(),
          headerLineCount,
          responseStartIdx,
          responseEndIdx,
          cSpec.cast(),
          delim,
          miss,
          p,
          callback,
        ),
        (c) => c.complete(),
      );
    } catch (_) {
      calloc.free(p);
      rethrow;
    } finally {
      calloc.free(cFilename);
      calloc.free(cSpec);
    }
    return TrainData.fromPointer(p);
  }
}

extension SVMAsync on SVM {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_SVM_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_SVM_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_SVM_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_SVM_calcError(ref, data.ref, test, m, p, cb));

  Future<bool> trainAutoAsync(
    TrainData data, {
    int kFold = 10,
    ParamGrid? Cgrid,
    ParamGrid? gammaGrid,
    ParamGrid? pGrid,
    ParamGrid? nuGrid,
    ParamGrid? coeffGrid,
    ParamGrid? degreeGrid,
    bool balanced = false,
  }) async {
    final grids = calloc<cml.MlParamGrid>(6);
    for (final (i, g) in [Cgrid, gammaGrid, pGrid, nuGrid, coeffGrid, degreeGrid].indexed) {
      final v = g ?? SVM.getDefaultGrid(i);
      grids[i]
        ..minVal = v.minVal
        ..maxVal = v.maxVal
        ..logStep = v.logStep;
    }
    try {
      return await _boolAsync(
        (p, cb) => cml.cv_ml_SVM_trainAuto(
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
          cb,
        ),
      );
    } finally {
      calloc.free(grids);
    }
  }
}

extension ANN_MLPAsync on ANN_MLP {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_ANN_MLP_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_ANN_MLP_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_ANN_MLP_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_ANN_MLP_calcError(ref, data.ref, test, m, p, cb));
}

extension KNearestAsync on KNearest {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_KNearest_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_KNearest_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_KNearest_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_KNearest_calcError(ref, data.ref, test, m, p, cb));

  Future<(Mat results, Mat neighborResponses, Mat dist)> findNearestAsync(Mat samples, int k) async {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    final neighborResponses = Mat.empty();
    final dist = Mat.empty();
    try {
      return await cvRunAsync0<(Mat, Mat, Mat)>(
        (callback) => cml.cv_ml_KNearest_findNearest(
          ref,
          samples.ref,
          k,
          results.ref,
          neighborResponses.ref,
          dist.ref,
          p,
          callback,
        ),
        (c) => c.complete((results, neighborResponses, dist)),
      );
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

// ---- phase 2 ----

/// Runs one of the EM train functions asynchronously.
Future<(bool, Mat, Mat, Mat)> _emTrainAsync(
  ffi.Pointer<cvg.CvStatus> Function(
    cml.Mat logLikelihoods,
    cml.Mat labels,
    cml.Mat probs,
    ffi.Pointer<ffi.Bool> p,
    cvg.CvCallback_0 callback,
  )
  func,
) async {
  final p = calloc<ffi.Bool>();
  final logLikelihoods = Mat.empty();
  final labels = Mat.empty();
  final probs = Mat.empty();
  try {
    return await cvRunAsync0<(bool, Mat, Mat, Mat)>(
      (callback) => func(logLikelihoods.ref, labels.ref, probs.ref, p, callback),
      (c) => c.complete((p.value, logLikelihoods, labels, probs)),
    );
  } catch (_) {
    logLikelihoods.dispose();
    labels.dispose();
    probs.dispose();
    rethrow;
  } finally {
    calloc.free(p);
  }
}

extension DTreesAsync on DTrees {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_DTrees_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_DTrees_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_DTrees_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_DTrees_calcError(ref, data.ref, test, m, p, cb));
}

extension RTreesAsync on RTrees {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_RTrees_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_RTrees_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_RTrees_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_RTrees_calcError(ref, data.ref, test, m, p, cb));
}

extension BoostAsync on Boost {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_Boost_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_Boost_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_Boost_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_Boost_calcError(ref, data.ref, test, m, p, cb));
}

extension EMAsync on EM {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_EM_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_EM_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_EM_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_EM_calcError(ref, data.ref, test, m, p, cb));

  Future<(double logLikelihood, int label, Mat probs)> predict2Async(Mat sample) async {
    final p = calloc<cvg.Vec2d>();
    final probs = Mat.empty();
    try {
      return await cvRunAsync0<(double, int, Mat)>(
        (callback) => cml.cv_ml_EM_predict2(ref, sample.ref, probs.ref, p, callback),
        (c) => c.complete((p.ref.val1, p.ref.val2.round(), probs)),
      );
    } catch (_) {
      probs.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }

  Future<(bool, Mat logLikelihoods, Mat labels, Mat probs)> trainEMAsync(Mat samples) =>
      _emTrainAsync((l, lb, pr, p, cb) => cml.cv_ml_EM_trainEM(ref, samples.ref, l, lb, pr, p, cb));

  Future<(bool, Mat logLikelihoods, Mat labels, Mat probs)> trainEAsync(
    Mat samples,
    Mat means0, {
    VecMat? covs0,
    Mat? weights0,
  }) async {
    final covs = covs0 ?? VecMat();
    final weights = weights0 ?? Mat.empty();
    try {
      return await _emTrainAsync(
        (l, lb, pr, p, cb) =>
            cml.cv_ml_EM_trainE(ref, samples.ref, means0.ref, covs.ref, weights.ref, l, lb, pr, p, cb),
      );
    } finally {
      if (covs0 == null) covs.dispose();
      if (weights0 == null) weights.dispose();
    }
  }

  Future<(bool, Mat logLikelihoods, Mat labels, Mat probs)> trainMAsync(Mat samples, Mat probs0) =>
      _emTrainAsync(
        (l, lb, pr, p, cb) => cml.cv_ml_EM_trainM(ref, samples.ref, probs0.ref, l, lb, pr, p, cb),
      );
}

extension LogisticRegressionAsync on LogisticRegression {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) => _boolAsync(
    (p, cb) => cml.cv_ml_LogisticRegression_train_1(ref, samples.ref, layout, responses.ref, p, cb),
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_LogisticRegression_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_LogisticRegression_predict(ref, samples.ref, m, flags, p, cb),
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_LogisticRegression_calcError(ref, data.ref, test, m, p, cb));
}

extension NormalBayesClassifierAsync on NormalBayesClassifier {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) => _boolAsync(
    (p, cb) => cml.cv_ml_NormalBayesClassifier_train_1(ref, samples.ref, layout, responses.ref, p, cb),
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_NormalBayesClassifier_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_NormalBayesClassifier_predict(ref, samples.ref, m, flags, p, cb),
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_NormalBayesClassifier_calcError(ref, data.ref, test, m, p, cb));

  Future<(Mat outputs, Mat outputProbs)> predictProbAsync(Mat inputs, {int flags = 0}) async {
    final p = calloc<ffi.Float>();
    final outputs = Mat.empty();
    final outputProbs = Mat.empty();
    try {
      return await cvRunAsync0<(Mat, Mat)>(
        (callback) => cml.cv_ml_NormalBayesClassifier_predictProb(
          ref,
          inputs.ref,
          outputs.ref,
          outputProbs.ref,
          flags,
          p,
          callback,
        ),
        (c) => c.complete((outputs, outputProbs)),
      );
    } catch (_) {
      outputs.dispose();
      outputProbs.dispose();
      rethrow;
    } finally {
      calloc.free(p);
    }
  }
}

extension SVMSGDAsync on SVMSGD {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses) =>
      _boolAsync((p, cb) => cml.cv_ml_SVMSGD_train_1(ref, samples.ref, layout, responses.ref, p, cb));

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0}) =>
      _boolAsync((p, cb) => cml.cv_ml_SVMSGD_train(ref, data.ref, flags, p, cb));

  Future<Mat> predictAsync(Mat samples, {int flags = 0}) async =>
      (await _floatMatAsync((p, m, cb) => cml.cv_ml_SVMSGD_predict(ref, samples.ref, m, flags, p, cb))).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_SVMSGD_calcError(ref, data.ref, test, m, p, cb));
}
