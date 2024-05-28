// ignore_for_file: constant_identifier_names

library cv;

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../constants.g.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class TrainData extends CvStruct<cvg.PtrTrainData> {
  TrainData._(cvg.PtrTrainDataPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  /// Creates training data from in-memory arrays.
  ///
  /// [samples]	matrix of samples. It should have CV_32F type.
  ///
  /// [layout]	see ml::SampleTypes.
  ///
  /// [responses]	matrix of responses. If the responses are scalar, they should be stored as a single row or as a single column. The matrix should have type CV_32F or CV_32S (in the former case the responses are considered as ordered by default; in the latter case - as categorical)
  ///
  /// [varIdx]	vector specifying which variables to use for training. It can be an integer vector (CV_32S) containing 0-based variable indices or byte vector (CV_8U) containing a mask of active variables.
  ///
  /// [sampleIdx]	vector specifying which samples to use for training. It can be an integer vector (CV_32S) containing 0-based sample indices or byte vector (CV_8U) containing a mask of training samples.
  ///
  /// [sampleWeights]	optional vector with weights for each sample. It should have CV_32F type.
  ///
  /// [varType]	optional vector of type CV_8U and size <number_of_variables_in_samples> + <number_of_variables_in_responses>, containing types of each input and output variable. See ml::VariableTypes.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a7755186f510669f35fbdee8c044ced10
  factory TrainData(
    InputArray samples,
    int layout,
    InputArray responses, {
    InputArray? varIdx,
    InputArray? sampleIdx,
    InputArray? sampleWeights,
    InputArray? varType,
  }) {
    final p = calloc<cvg.PtrTrainData>();
    varIdx ??= Mat.empty();
    sampleIdx ??= Mat.empty();
    sampleWeights ??= Mat.empty();
    varType ??= Mat.empty();
    cvRun(() => CFFI.TrainData_Create(samples.ref, layout, responses.ref, varIdx!.ref,
        sampleIdx!.ref, sampleWeights!.ref, varType!.ref, p));
    return TrainData._(p);
  }

  /// Reads the dataset from a .csv file and returns the ready-to-use training data.
  ///
  /// [filename]	The input file name
  ///
  /// [headerLineCount]	The number of lines in the beginning to skip; besides the header, the function also skips empty lines and lines staring with #
  ///
  /// [responseStartIdx]	Index of the first output variable. If -1, the function considers the last variable as the response
  ///
  /// [responseEndIdx]	Index of the last output variable + 1. If -1, then there is single response variable at responseStartIdx.
  ///
  /// [varTypeSpec]	The optional text string that specifies the variables' types. It has the format ord[n1-n2,n3,n4-n5,...]cat[n6,n7-n8,...]. That is, variables from n1 to n2 (inclusive range), n3, n4 to n5 ... are considered ordered and n6, n7 to n8 ... are considered as categorical. The range [n1..n2] + [n3] + [n4..n5] + ... + [n6] + [n7..n8] should cover all the variables. If varTypeSpec is not specified, then algorithm uses the following rules:
  ///
  ///   - all input variables are considered ordered by default. If some column contains has non- numerical values, e.g. 'apple', 'pear', 'apple', 'apple', 'mango', the corresponding variable is considered categorical.
  ///   - if there are several output variables, they are all considered as ordered. Error is reported when non-numerical values are used.
  ///   - if there is a single output variable, then if its values are non-numerical or are all integers, then it's considered categorical. Otherwise, it's considered ordered.
  ///
  /// [delimiter]	The character used to separate values in each line.
  ///
  /// [missch]	The character used to specify missing measurements. It should not be a digit. Although it's a non-numerical value, it surely does not affect the decision of whether the variable ordered or categorical.
  ///
  ///https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a12eac7e52509b6ee39ddaa7b3df1db8c
  factory TrainData.loadFromCSV(
    String filename,
    int headerLineCount, {
    int responseStartIdx = -1,
    int responseEndIdx = -1,
    String varTypeSpec = "",
    String delimiter = ',',
    String missch = '?',
  }) {
    return cvRunArena((arena) {
      final p = calloc<cvg.PtrTrainData>();
      final fp = filename.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final vp = varTypeSpec.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final dp = ascii.encode(delimiter)[0];
      final mp = ascii.encode(missch)[0];
      cvRun(() => CFFI.TrainData_LoadFromCSV(
          fp, headerLineCount, responseStartIdx, responseEndIdx, vp, dp, mp, p));
      return TrainData._(p);
    });
  }

  static double missingValue() {
    return cvRunArena((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.TrainData_MissingValue(p));
      return p.value;
    });
  }

  static final finalizer = OcvFinalizer<cvg.PtrTrainDataPtr>(CFFI.addresses.TrainData_Close);

  cvg.TrainData get traindata {
    final s = calloc<cvg.TrainData>();
    cvRun(() => CFFI.TrainData_Get(ptr, s));
    return s.ref;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a7e687b7ee8325380bced49f5cd5baf15
  int getCatCount(int vi) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetCatCount(ref, vi, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a3c2c8c6bf46955d9c52f256fdfa9097c
  Mat getCatMap() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetCatMap(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a65ad5f0565ffe9ac26fbff8026faec36
  Mat getCatOfs() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetCatOfs(ref, m.ptr));
    return m;
  }

  /// Returns the vector of class labels.
  ///
  /// The function returns vector of unique labels occurred in the responses.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a0e40c6bd62aa9ad0ae6f5273d2bd824b
  Mat getClassLabels() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetClassLabels(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ab8c65d4efcb364be41febd8e3c2dae70
  Mat getDefaultSubstValues() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetDefaultSubstValues(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#aa2d2889b6dddad5e663cb18b206ac3f1
  int getLayout() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetLayout(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a71f13029c92961dc432fcfeec376ad9a
  Mat getMissing() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetMissing(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a4c81aad5723a86d1f9f97e0ca2cf271b
  int getNAllVars() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetNAllVars(ref, p));
      return p.value;
    });
  }

  /// Returns vector of symbolic names captured in [TrainData.loadFromCSV]
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ae14e1e1c607472f3c72a5a63679d08cb
  List<String> getNames() {
    final v = calloc<cvg.VecVecChar>();
    cvRun(() => CFFI.TrainData_GetNames(ref, v));
    return VecVecChar.fromPointer(v).asStringList();
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a2f6bd6ae08ded472532b28e1b1266230
  Mat getNormCatResponses() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetNormCatResponses(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a38b6da04d4765000e890d614a01be446
  int getNSamples() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetNSamples(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a0f3265d83658f7effd2cb4c05fe6b8c8
  int getNTestSamples() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetNTestSamples(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ac34c8467851769cac20d99cde52f3812
  int getNTrainSamples() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetNTrainSamples(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#acafca98ec8fb43ddcec59af1cc906611
  int getNVars() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetNVars(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a10c5bb5ac7c4b70fbc9db0d3a94684e2
  Mat getResponses() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetResponses(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#afc86c4d4670e535dee2459742f87ea95
  int getResponseType() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetResponseType(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a86fc3bbc9a6d0fef62ec97b28eb452fe
  VecFloat getSample(InputArray varIdx, int sidx) {
    return cvRunArena<VecFloat>((arena) {
      final p = arena<cvg.VecFloat>();
      cvRun(() => CFFI.TrainData_GetSample(ref, varIdx.ref, sidx, p));
      return VecFloat.fromPointer(p);
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a86fc3bbc9a6d0fef62ec97b28eb452fe
  Mat getSamples() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetSamples(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a7ab7348f09a9a44bf1e30df1b979e034
  Mat getSampleWeights() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetSampleWeights(ref, m.ptr));
    return m;
  }

  /// Extract from matrix rows/cols specified by passed indexes.
  ///
  /// [matrix]	input matrix (supported types: CV_32S, CV_32F, CV_64F)
  ///
  /// [idx]	1D index vector
  ///
  /// [layout]	specifies to extract rows (cv::ml::ROW_SAMPLES) or to extract columns (cv::ml::COL_SAMPLES)
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ac3c8a080653b64495a13913903b4667c
  static Mat getSubMatrix(Mat matrix, Mat idx, int layout) {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetSubMatrix(matrix.ref, idx.ref, layout, m.ptr));
    return m;
  }

  /// Extract from 1D vector elements specified by passed indexes.
  ///
  /// [vec]	input vector (supported types: CV_32S, CV_32F, CV_64F)
  ///
  /// [idx]	1D index vector
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a3d01eda6a2eb795bd7ab223b6d065e52
  static Mat getSubVector(Mat vec, Mat idx) {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetSubVector(vec.ref, idx.ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a4fc48158587fe44f863788aefed5d245
  Mat getTestNormCatResponses() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTestNormCatResponses(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ae83fc71c776cd9971463c2e4dbab0427
  Mat getTestResponses() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTestResponses(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a923fc78e64e96543bf8ebe87d179ea29
  Mat getTestSampleIdx() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTestSampleIdx(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ae8549c2b1e3b16b8f0fc64917ffd6fd6
  Mat getTestSamples() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTestSamples(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#acddb9c4642e9b4f39a4bf1337ceb06f7
  Mat getTestSampleWeights() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTestSampleWeights(ref, m.ptr));
    return m;
  }

  /// Returns the vector of normalized categorical responses.
  ///
  /// The function returns vector of responses. Each response is integer from 0 to <number of classes>-1. The actual label value can be retrieved then from the class label vector, see TrainData::getClassLabels.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a0901c9bed4728e3fa29b93a0afa46371
  Mat getTrainNormCatResponses() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTrainNormCatResponses(ref, m.ptr));
    return m;
  }

  /// Returns the vector of responses.
  ///
  /// The function returns ordered or the original categorical responses. Usually it's used in regression algorithms.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ac248adbafbc43a1c00bfa32e2526cf4c
  Mat getTrainResponses() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTrainResponses(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#aaefa64f1e3c208d4dc38127b6739eff7
  Mat getTrainSampleIdx() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTrainSampleIdx(ref, m.ptr));
    return m;
  }

  /// Returns matrix of train samples.
  ///
  /// layout	The requested layout. If it's different from the initial one, the matrix is transposed. See ml::SampleTypes.
  ///
  /// compressSamples	if true, the function returns only the training samples (specified by sampleIdx)
  ///
  /// compressVars	if true, the function returns the shorter training samples, containing only the active variables.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#af35073f4d4e0777159c57622df56117c
  Mat getTrainSamples([
    int layout = ROW_SAMPLE,
    bool compressSamples = true,
    bool compressVars = true,
  ]) {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTrainSamples(ref, layout, compressSamples, compressVars, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ad2de4f384f28259ac849e289be8d970d
  Mat getTrainSampleWeights() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetTrainSampleWeights(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a38d657b15e30bc94124c31cd3c23d816
  VecFloat getValues(int vi, Mat sidx) {
    return cvRunArena<VecFloat>((arena) {
      final p = arena<cvg.VecFloat>();
      cvRun(() => CFFI.TrainData_GetValues(ref, vi, sidx.ref, p));
      return VecFloat.fromPointer(p);
    });
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#aee63a2fc0f0679e3f8dd65dbc2c2b571
  Mat getVarIdx() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetVarIdx(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a7d08ff25ec3eed7c970a707e3000d212
  Mat getVarSymbolFlags() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetVarSymbolFlags(ref, m.ptr));
    return m;
  }

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a56959ac3541cd7d8d3bbcba02f8a1308
  Mat getVarType() {
    final m = Mat.empty();
    cvRun(() => CFFI.TrainData_GetVarType(ref, m.ptr));
    return m;
  }

  /// Splits the training data into the training and test parts.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ab444173f4d980bb3c18d856df706c920
  void setTrainTestSplit(int count, [bool shuffle = true]) =>
      cvRun(() => CFFI.TrainData_SetTrainTestSplit(ref, count, shuffle));

  /// Splits the training data into the training and test parts.
  ///
  /// The function selects a subset of specified relative size and then returns
  /// it as the training set. If the function is not called, all the data is used
  /// for training. Please, note that for each of TrainData::getTrain* there is
  /// corresponding TrainData::getTest*, so that the test subset can be retrieved
  /// and processed as well.
  ///
  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#ad59c8df14e133ba492ff5cbfa21244cc
  void setTrainTestSplitRatio(double ratio, [bool shuffle = true]) =>
      cvRun(() => CFFI.TrainData_SetTrainTestSplitRatio(ref, ratio, shuffle));

  /// https://docs.opencv.org/4.x/dc/d32/classcv_1_1ml_1_1TrainData.html#a0515ddd44168aa5c42478536375c760b
  void shuffleTrainTest() => cvRun(() => CFFI.TrainData_ShuffleTrainTest(ref));

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.PtrTrainData get ref => ptr.ref;
}
