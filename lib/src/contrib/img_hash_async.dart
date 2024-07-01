library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;
import 'img_hash.dart';

extension PHashAsync on PHash {
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.pHashCompare_Async(hashOne.ref, hashTwo.ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> computeAsync(InputArray inputArr, OutputArray outputArr) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.pHashCompute_Async(inputArr.ref, outputArr.ref, callback), (c) => c.complete());
  }
}

extension AverageHashAsync on AverageHash {
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.averageHashCompare_Async(hashOne.ref, hashTwo.ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> computeAsync(InputArray inputArr, OutputArray outputArr) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.averageHashCompute_Async(inputArr.ref, outputArr.ref, callback),
        (c) => c.complete());
  }
}

extension BlockMeanHashAsync on BlockMeanHash {
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo, [int? mode_]) async {
    mode_ ??= mode;
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.BlockMeanHash_Compare_Async(ref, hashOne.ref, hashTwo.ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<double> compareSAsync(InputArray hashOne, InputArray hashTwo, [int mode = 0]) async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.BlockMeanHash_Compare_Async(ref, hashOne.ref, hashTwo.ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> computeAsync(InputArray inputArr, OutputArray outputArr, [int? mode_]) async {
    mode_ ??= mode;
    await cvRunAsync0<void>(
        (callback) => CFFI.BlockMeanHash_Compute_Async(ref, inputArr.ref, outputArr.ref, callback),
        (c) => c.complete());
  }

  Future<void> computeSAsync(InputArray inputArr, OutputArray outputArr, [int mode = 0]) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.BlockMeanHash_Compute_Async(ref, inputArr.ref, outputArr.ref, callback),
        (c) => c.complete());
  }

  Future<List<double>> getMeanAsync() async {
    final rval = await cvRunAsync2<List<double>>(
        (callback) => CFFI.BlockMeanHash_GetMean_Async(ref, callback), (c, p, p2) {
      final ret = p.cast<ffi.Pointer<ffi.Double>>();
      final length = p2.cast<ffi.Int>().value;
      if (length == 0) return c.complete(List<double>.empty());
      return c.complete(List.generate(length, (i) => ret[i].value));
    });
    return rval;
  }
}

extension ColorMomentHashAsync on ColorMomentHash {
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.colorMomentHashCompare_Async(hashOne.ref, hashTwo.ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> computeAsync(InputArray inputArr, OutputArray outputArr) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.colorMomentHashCompute_Async(inputArr.ref, outputArr.ref, callback),
        (c) => c.complete());
  }
}

extension NewMarrHildrethHashAsync on NewMarrHildrethHash {
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.marrHildrethHashCompare_Async(hashOne.ref, hashTwo.ref, alpha, scale, callback),
        (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> computeAsync(InputArray inputArr, OutputArray outputArr) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.marrHildrethHashCompute_Async(inputArr.ref, outputArr.ref, alpha, scale, callback),
        (c) => c.complete());
  }
}

extension NewRadialVarianceHashAsync on NewRadialVarianceHash {
  Future<double> compareAsync(InputArray hashOne, InputArray hashTwo) async {
    final rval = await cvRunAsync<double>(
        (callback) =>
            CFFI.radialVarianceHashCompare_Async(hashOne.ref, hashTwo.ref, sigma, numOfAngleLine, callback),
        (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> computeAsync(InputArray inputArr, OutputArray outputArr) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.radialVarianceHashCompute_Async(
            inputArr.ref, outputArr.ref, sigma, numOfAngleLine, callback),
        (c) => c.complete());
  }
}
