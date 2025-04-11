import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../g/types.g.dart' as cvg;

class UsacParams extends CvStruct<cvg.UsacParams> {
  UsacParams.fromPointer(ffi.Pointer<cvg.UsacParams> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory UsacParams({
    double confidence = 0,
    bool isParallel = false,
    int loIterations = 0,
    int loMethod = LOCAL_OPTIM_NULL,
    int loSampleSize = 0,
    int maxIterations = 0,
    int neighborsSearch = NEIGH_FLANN_KNN,
    int randomGeneratorState = 0,
    int sampler = SAMPLING_UNIFORM,
    int score = SCORE_METHOD_RANSAC,
    double threshold = 0,
    int finalPolisher = NONE_POLISHER,
    int finalPolisherIterations = 0,
  }) {
    final p = calloc<cvg.UsacParams>()
      ..ref.confidence = confidence
      ..ref.isParallel = isParallel
      ..ref.loIterations = loIterations
      ..ref.loMethod = loMethod
      ..ref.loSampleSize = loSampleSize
      ..ref.maxIterations = maxIterations
      ..ref.neighborsSearch = neighborsSearch
      ..ref.randomGeneratorState = randomGeneratorState
      ..ref.sampler = sampler
      ..ref.score = score
      ..ref.threshold = threshold
      ..ref.final_polisher = finalPolisher
      ..ref.final_polisher_iterations = finalPolisherIterations;
    return UsacParams.fromPointer(p);
  }

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  @override
  cvg.UsacParams get ref => ptr.ref;

  /// double confidence;
  double get confidence => ref.confidence;
  set confidence(double value) => ref.confidence = value;

  /// bool isParallel;
  bool get isParallel => ref.isParallel;
  set isParallel(bool value) => ref.isParallel = value;

  /// int loIterations;
  int get loIterations => ref.loIterations;
  set loIterations(int value) => ref.loIterations = value;

  /// int loMethod;
  int get loMethod => ref.loMethod;
  set loMethod(int value) => ref.loMethod = value;

  /// int loSampleSize;
  int get loSampleSize => ref.loSampleSize;
  set loSampleSize(int value) => ref.loSampleSize = value;

  /// int maxIterations;
  int get maxIterations => ref.maxIterations;
  set maxIterations(int value) => ref.maxIterations = value;

  /// int neighborsSearch;
  int get neighborsSearch => ref.neighborsSearch;
  set neighborsSearch(int value) => ref.neighborsSearch = value;

  /// int randomGeneratorState;
  int get randomGeneratorState => ref.randomGeneratorState;
  set randomGeneratorState(int value) => ref.randomGeneratorState = value;

  /// int sampler;
  int get sampler => ref.sampler;
  set sampler(int value) => ref.sampler = value;

  /// int score;
  int get score => ref.score;
  set score(int value) => ref.score = value;

  /// double threshold;
  double get threshold => ref.threshold;
  set threshold(double value) => ref.threshold = value;

  /// int finalPolisher;
  int get finalPolisher => ref.final_polisher;
  set finalPolisher(int value) => ref.final_polisher = value;

  /// int finalPolisherIterations;
  int get finalPolisherIterations => ref.final_polisher_iterations;
  set finalPolisherIterations(int value) => ref.final_polisher_iterations = value;
}

// enum SamplingMethod { SAMPLING_UNIFORM=0, SAMPLING_PROGRESSIVE_NAPSAC=1, SAMPLING_NAPSAC=2, SAMPLING_PROSAC=3 };
const int SAMPLING_UNIFORM = 0;
const int SAMPLING_PROGRESSIVE_NAPSAC = 1;
const int SAMPLING_NAPSAC = 2;
const int SAMPLING_PROSAC = 3;

// enum LocalOptimMethod {LOCAL_OPTIM_NULL=0, LOCAL_OPTIM_INNER_LO=1, LOCAL_OPTIM_INNER_AND_ITER_LO=2, LOCAL_OPTIM_GC=3, LOCAL_OPTIM_SIGMA=4};
const int LOCAL_OPTIM_NULL = 0;
const int LOCAL_OPTIM_INNER_LO = 1;
const int LOCAL_OPTIM_INNER_AND_ITER_LO = 2;
const int LOCAL_OPTIM_GC = 3;
const int LOCAL_OPTIM_SIGMA = 4;

// enum ScoreMethod {SCORE_METHOD_RANSAC=0, SCORE_METHOD_MSAC=1, SCORE_METHOD_MAGSAC=2, SCORE_METHOD_LMEDS=3};
const int SCORE_METHOD_RANSAC = 0;
const int SCORE_METHOD_MSAC = 1;
const int SCORE_METHOD_MAGSAC = 2;
const int SCORE_METHOD_LMEDS = 3;

// enum NeighborSearchMethod { NEIGH_FLANN_KNN=0, NEIGH_GRID=1, NEIGH_FLANN_RADIUS=2 };
const int NEIGH_FLANN_KNN = 0;
const int NEIGH_GRID = 1;
const int NEIGH_FLANN_RADIUS = 2;

// enum PolishingMethod { NONE_POLISHER=0, LSQ_POLISHER=1, MAGSAC=2, COV_POLISHER=3 };
const int NONE_POLISHER = 0;
const int LSQ_POLISHER = 1;
const int MAGSAC = 2;
const int COV_POLISHER = 3;
