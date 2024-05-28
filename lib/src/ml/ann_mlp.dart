// ignore_for_file: constant_identifier_names, camel_case_types

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/termcriteria.dart';
import '../opencv.g.dart' as cvg;

class ANN_MLP extends CvStruct<cvg.PtrANN_MLP> {
  ANN_MLP._(cvg.PtrANN_MLPPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory ANN_MLP.create() {
    final p = calloc<cvg.PtrANN_MLP>();
    cvRun(() => CFFI.ANN_MLP_Create(p));
    return ANN_MLP._(p);
  }

  factory ANN_MLP.load(String filepath) {
    return using<ANN_MLP>((arena) {
      final fp = filepath.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = calloc<cvg.PtrANN_MLP>();
      cvRun(() => CFFI.ANN_MLP_Load(fp, p));
      return ANN_MLP._(p);
    });
  }

  factory ANN_MLP.loadFromString(String strModel, String objname) {
    return using<ANN_MLP>((arena) {
      final sm = strModel.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final on = objname.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final p = calloc<cvg.PtrANN_MLP>();
      cvRun(() => CFFI.ANN_MLP_LoadFromString(sm, on, p));
      return ANN_MLP._(p);
    });
  }

  static final finalizer = OcvFinalizer<cvg.PtrANN_MLPPtr>(CFFI.addresses.ANN_MLP_Close);

  int getTrainMethod() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ANN_MLP_GetTrainMethod(ref, p));
      return p.value;
    });
  }

  /// Sets training method and common parameters.
  ///
  /// [method] Default value is [TRAIN_METHODS_RPROP].
  ///
  /// https://docs.opencv.org/4.x/d0/dce/classcv_1_1ml_1_1ANN__MLP.html#a4be093cfd2e743ee2f41e34e50cf3a54
  void setTrainMethod(int method, [double param1 = 0, double param2 = 0]) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetTrainMethod(ref, method, param1, param2));
    });
  }

  void setActivationFunction(int type, double param1, double param2) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetActivationFunction(ref, type, param1, param2));
    });
  }

  void setLayerSizes(Mat layerSizes) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetLayerSizes(ref, layerSizes.ref));
    });
  }

  Mat getLayerSizes() {
    return using<Mat>((arena) {
      final mat = Mat.empty();
      cvRun(() => CFFI.ANN_MLP_GetLayerSizes(ref, mat.ptr));
      return mat;
    });
  }

  void setTermCriteria(TermCriteria val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetTermCriteria(ref, val.toNativePtr(arena).ref));
    });
  }

  TermCriteria getTermCriteria() {
    return using<TermCriteria>((arena) {
      final p = arena<cvg.TermCriteria>();
      cvRun(() => CFFI.ANN_MLP_GetTermCriteria(ref, p));
      return p.ref.toDart();
    });
  }

  void setBackpropWeightScale(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetBackpropWeightScale(ref, val));
    });
  }

  double getBackpropWeightScale() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetBackpropWeightScale(ref, p));
      return p.value;
    });
  }

  void setBackpropMomentumScale(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetBackpropMomentumScale(ref, val));
    });
  }

  double getBackpropMomentumScale() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetBackpropMomentumScale(ref, p));
      return p.value;
    });
  }

  void setRpropDW0(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetRpropDW0(ref, val));
    });
  }

  double getRpropDW0() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetRpropDW0(ref, p));
      return p.value;
    });
  }

  void setRpropDWPlus(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetRpropDWPlus(ref, val));
    });
  }

  double getRpropDWPlus() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetRpropDWPlus(ref, p));
      return p.value;
    });
  }

  void setRpropDWMinus(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetRpropDWMinus(ref, val));
    });
  }

  double getRpropDWMinus() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetRpropDWMinus(ref, p));
      return p.value;
    });
  }

  void setRpropDWMin(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetRpropDWMin(ref, val));
    });
  }

  double getRpropDWMin() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetRpropDWMin(ref, p));
      return p.value;
    });
  }

  void setRpropDWMax(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetRpropDWMax(ref, val));
    });
  }

  double getRpropDWMax() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetRpropDWMax(ref, p));
      return p.value;
    });
  }

  void setAnnealInitialT(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetAnnealInitialT(ref, val));
    });
  }

  double getAnnealInitialT() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetAnnealInitialT(ref, p));
      return p.value;
    });
  }

  void setAnnealFinalT(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetAnnealFinalT(ref, val));
    });
  }

  double getAnnealFinalT() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetAnnealFinalT(ref, p));
      return p.value;
    });
  }

  void setAnnealCoolingRatio(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetAnnealCoolingRatio(ref, val));
    });
  }

  double getAnnealCoolingRatio() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ANN_MLP_GetAnnealCoolingRatio(ref, p));
      return p.value;
    });
  }

  void setAnnealItePerStep(int val) {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_SetAnnealItePerStep(ref, val));
    });
  }

  int getAnnealItePerStep() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ANN_MLP_GetAnnealItePerStep(ref, p));
      return p.value;
    });
  }

  double predict(Mat samples, Mat results, int flags) {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.ANN_MLP_Predict(ref, samples.ref, results.ref, flags, p));
      return p.value;
    });
  }

  bool train(cvg.PtrTrainData trainData, int flags) {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.ANN_MLP_Train(ref, trainData, flags, p));
      return p.value;
    });
  }

  bool trainWithSamples(Mat samples, int layout, Mat responses) {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.ANN_MLP_Train_1(ref, samples.ref, layout, responses.ref, p));
      return p.value;
    });
  }

  void clear() {
    return using<void>((arena) {
      cvRun(() => CFFI.ANN_MLP_Clear(ref));
    });
  }

  void save(String filename) {
    return using<void>((arena) {
      final p = filename.toNativeUtf8().cast<ffi.Char>();
      cvRun(() => CFFI.ANN_MLP_Save(ref, p));
      calloc.free(p);
    });
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.PtrANN_MLP get ref => ptr.ref;

  /// The back-propagation algorithm.
  static const int TRAIN_METHODS_BACKPROP = 0;

  /// The RPROP algorithm. See @cite RPROP93 for details.
  static const int TRAIN_METHODS_RPROP = 1;

  /// The simulated annealing algorithm. See @cite Kirkpatrick83 for details.
  static const int TRAIN_METHODS_ANNEAL = 2;

  static const int TRAIN_FLAGS_UPDATE_WEIGHTS = 1;
  static const int TRAIN_FLAGS_NO_INPUT_SCALE = 2;
  static const int TRAIN_FLAGS_NO_OUTPUT_SCALE = 4;

  static const int ACTIVATION_IDENTITY = 0;
  static const int ACTIVATION_SIGMOID_SYM = 1;
  static const int ACTIVATION_GAUSSIAN = 2;
  static const int ACTIVATION_RELU = 3;
  static const int ACTIVATION_LEAKYRELU = 4;
}
