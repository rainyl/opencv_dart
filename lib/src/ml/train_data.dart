// ignore_for_file: constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class TrainData extends CvStruct<cvg.PtrTrainData> {
  TrainData._(cvg.PtrTrainDataPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

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

  factory TrainData.fromCsv(
    String filename,
    int headerLineCount, {
    int responseStartIdx = -1,
    int responseEndIdx = -1,
    String varTypeSpec = "",
    String delimiter = ',',
    String missch = '?',
  }) {
    throw UnimplementedError();
  }

  static final finalizer = OcvFinalizer<cvg.PtrTrainDataPtr>(CFFI.addresses.TrainData_Close);

  cvg.TrainData get traindata {
    final s = calloc<cvg.TrainData>();
    cvRun(() => CFFI.TrainData_Get(ptr, s));
    return s.ref;
  }

  int getCatCount(int vi) {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.TrainData_GetCatCount(traindata, vi, p));
      return p.value;
    });
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.PtrTrainData get ref => ptr.ref;
}
