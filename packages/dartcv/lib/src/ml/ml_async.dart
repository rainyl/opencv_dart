// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: camel_case_extensions

library cv.ml;

import '../bindings/ml.dart' as cml;
import '../bindings/types.dart' as cvg;
import '../core/base.dart';
import '../core/mat.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';
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
  ffi.Pointer<cvg.CvStatus> Function(ffi.Pointer<ffi.Bool> p, cvg.CvCallback_0 callback) func, {
  Duration? timeout,
}) {
  final p = calloc<ffi.Bool>();
  return cvRunAsync0<bool>(
    (callback) => func(p, callback),
    (c) => c.complete(p.value),
    timeout: timeout,
    release: () => calloc.free(p),
  );
}

/// Runs [func] asynchronously and returns the `float` it writes and the Mat it fills.
Future<(double, Mat)> _floatMatAsync(
  ffi.Pointer<cvg.CvStatus> Function(ffi.Pointer<ffi.Float> p, cml.Mat m, cvg.CvCallback_0 callback) func, {
  Duration? timeout,
}) {
  final p = calloc<ffi.Float>();
  final m = Mat.empty();
  return cvRunAsync0<(double, Mat)>(
    (callback) => func(p, m.ref, callback),
    (c) => c.complete((p.value, m)),
    timeout: timeout,
    release: () => calloc.free(p),
    releaseOnFailure: m.dispose,
  );
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
    Duration? timeout,
  }) {
    final delim = TrainData.singleChar(delimiter, 'delimiter');
    final miss = TrainData.singleChar(missch, 'missch');
    final arena = Arena();
    final p = calloc<cml.TrainData>();
    return cvRunAsync0<TrainData>(
      (callback) => cml.cv_ml_TrainData_loadFromCSV(
        filename.toNativeUtf8(allocator: arena).cast(),
        headerLineCount,
        responseStartIdx,
        responseEndIdx,
        varTypeSpec.toNativeUtf8(allocator: arena).cast(),
        delim,
        miss,
        p,
        callback,
      ),
      (c) => c.complete(TrainData.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }
}

extension SVMAsync on SVM {
  Future<(double rho, Mat alpha, Mat svidx)> getDecisionFunctionAsync(int i, {Duration? timeout}) {
    final p = calloc<ffi.Double>();
    final alpha = Mat.empty();
    final svidx = Mat.empty();
    return cvRunAsync0<(double, Mat, Mat)>(
      (callback) => cml.cv_ml_SVM_getDecisionFunction(ref, i, alpha.ref, svidx.ref, p, callback),
      (c) => c.complete((p.value, alpha, svidx)),
      timeout: timeout,
      release: () => calloc.free(p),
      releaseOnFailure: () {
        alpha.dispose();
        svidx.dispose();
      },
    );
  }

  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_SVM_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_SVM_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_SVM_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_SVM_calcError(ref, data.ref, test, m, p, cb), timeout: timeout);

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
    Duration? timeout,
  }) {
    final grids = ParamGrid.allocateNative([Cgrid, gammaGrid, pGrid, nuGrid, coeffGrid, degreeGrid]);
    final p = calloc<ffi.Bool>();
    return cvRunAsync0<bool>(
      (callback) => cml.cv_ml_SVM_trainAuto(
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
        callback,
      ),
      (c) => c.complete(p.value),
      timeout: timeout,
      release: () {
        calloc.free(p);
        calloc.free(grids);
      },
    );
  }
}

extension ANN_MLPAsync on ANN_MLP {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_ANN_MLP_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_ANN_MLP_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_ANN_MLP_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_ANN_MLP_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );
}

extension KNearestAsync on KNearest {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_KNearest_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_KNearest_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_KNearest_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_KNearest_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );

  Future<(Mat results, Mat neighborResponses, Mat dist)> findNearestAsync(
    Mat samples,
    int k, {
    Duration? timeout,
  }) {
    final p = calloc<ffi.Float>();
    final results = Mat.empty();
    final neighborResponses = Mat.empty();
    final dist = Mat.empty();
    return cvRunAsync0<(Mat, Mat, Mat)>(
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
      timeout: timeout,
      release: () => calloc.free(p),
      releaseOnFailure: () {
        results.dispose();
        neighborResponses.dispose();
        dist.dispose();
      },
    );
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
  func, {
  Duration? timeout,
  void Function()? cleanup,
}) {
  final p = calloc<ffi.Bool>();
  final logLikelihoods = Mat.empty();
  final labels = Mat.empty();
  final probs = Mat.empty();
  return cvRunAsync0<(bool, Mat, Mat, Mat)>(
    (callback) => func(logLikelihoods.ref, labels.ref, probs.ref, p, callback),
    (c) => c.complete((p.value, logLikelihoods, labels, probs)),
    timeout: timeout,
    release: () {
      calloc.free(p);
      cleanup?.call();
    },
    releaseOnFailure: () {
      logLikelihoods.dispose();
      labels.dispose();
      probs.dispose();
    },
  );
}

extension DTreesAsync on DTrees {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_DTrees_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_DTrees_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_DTrees_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_DTrees_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );
}

extension RTreesAsync on RTrees {
  Future<Mat> getVotesAsync(Mat samples, {int flags = 0, Duration? timeout}) {
    final rval = Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => cml.cv_ml_RTrees_getVotes(ref, samples.ref, rval.ref, flags, callback),
      (c) => c.complete(rval),
      timeout: timeout,
      releaseOnFailure: rval.dispose,
    );
  }

  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_RTrees_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_RTrees_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_RTrees_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_RTrees_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );
}

extension BoostAsync on Boost {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_Boost_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_Boost_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_Boost_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_Boost_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );
}

extension EMAsync on EM {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_EM_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_EM_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_EM_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) =>
      _floatMatAsync((p, m, cb) => cml.cv_ml_EM_calcError(ref, data.ref, test, m, p, cb), timeout: timeout);

  Future<(double logLikelihood, int label, Mat probs)> predict2Async(Mat sample, {Duration? timeout}) {
    final p = calloc<cvg.Vec2d>();
    final probs = Mat.empty();
    return cvRunAsync0<(double, int, Mat)>(
      (callback) => cml.cv_ml_EM_predict2(ref, sample.ref, probs.ref, p, callback),
      (c) => c.complete((p.ref.val1, p.ref.val2.round(), probs)),
      timeout: timeout,
      release: () => calloc.free(p),
      releaseOnFailure: probs.dispose,
    );
  }

  Future<(bool, Mat logLikelihoods, Mat labels, Mat probs)> trainEMAsync(Mat samples, {Duration? timeout}) =>
      _emTrainAsync(
        (l, lb, pr, p, cb) => cml.cv_ml_EM_trainEM(ref, samples.ref, l, lb, pr, p, cb),
        timeout: timeout,
      );

  Future<(bool, Mat logLikelihoods, Mat labels, Mat probs)> trainEAsync(
    Mat samples,
    Mat means0, {
    VecMat? covs0,
    Mat? weights0,
    Duration? timeout,
  }) {
    final covs = covs0 ?? VecMat();
    final weights = weights0 ?? Mat.empty();
    return _emTrainAsync(
      (l, lb, pr, p, cb) =>
          cml.cv_ml_EM_trainE(ref, samples.ref, means0.ref, covs.ref, weights.ref, l, lb, pr, p, cb),
      timeout: timeout,
      cleanup: () {
        if (covs0 == null) covs.dispose();
        if (weights0 == null) weights.dispose();
      },
    );
  }

  Future<(bool, Mat logLikelihoods, Mat labels, Mat probs)> trainMAsync(
    Mat samples,
    Mat probs0, {
    Duration? timeout,
  }) => _emTrainAsync(
    (l, lb, pr, p, cb) => cml.cv_ml_EM_trainM(ref, samples.ref, probs0.ref, l, lb, pr, p, cb),
    timeout: timeout,
  );
}

extension LogisticRegressionAsync on LogisticRegression {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_LogisticRegression_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_LogisticRegression_train(ref, data.ref, flags, p, cb),
    timeout: timeout,
  );

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_LogisticRegression_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_LogisticRegression_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );
}

extension NormalBayesClassifierAsync on NormalBayesClassifier {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_NormalBayesClassifier_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_NormalBayesClassifier_train(ref, data.ref, flags, p, cb),
    timeout: timeout,
  );

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_NormalBayesClassifier_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_NormalBayesClassifier_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );

  Future<(Mat outputs, Mat outputProbs)> predictProbAsync(
    Mat inputs, {
    int flags = 0,
    Duration? timeout,
  }) {
    final p = calloc<ffi.Float>();
    final outputs = Mat.empty();
    final outputProbs = Mat.empty();
    return cvRunAsync0<(Mat, Mat)>(
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
      timeout: timeout,
      release: () => calloc.free(p),
      releaseOnFailure: () {
        outputs.dispose();
        outputProbs.dispose();
      },
    );
  }
}

extension SVMSGDAsync on SVMSGD {
  Future<bool> trainAsync(Mat samples, int layout, Mat responses, {Duration? timeout}) => _boolAsync(
    (p, cb) => cml.cv_ml_SVMSGD_train_1(ref, samples.ref, layout, responses.ref, p, cb),
    timeout: timeout,
  );

  Future<bool> trainWithDataAsync(TrainData data, {int flags = 0, Duration? timeout}) =>
      _boolAsync((p, cb) => cml.cv_ml_SVMSGD_train(ref, data.ref, flags, p, cb), timeout: timeout);

  Future<Mat> predictAsync(Mat samples, {int flags = 0, Duration? timeout}) async => (await _floatMatAsync(
    (p, m, cb) => cml.cv_ml_SVMSGD_predict(ref, samples.ref, m, flags, p, cb),
    timeout: timeout,
  )).$2;

  Future<(double, Mat)> calcErrorAsync(TrainData data, bool test, {Duration? timeout}) => _floatMatAsync(
    (p, m, cb) => cml.cv_ml_SVMSGD_calcError(ref, data.ref, test, m, p, cb),
    timeout: timeout,
  );
}
