// ignore_for_file: constant_identifier_names

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/termcriteria.dart';
import '../core/vec.dart';

import '../opencv.g.dart' as cvg;

/// Support Vector Machines.
/// https://docs.opencv.org/4.x/d1/d2d/classcv_1_1ml_1_1SVM.html#ab4b93a4c42bbe213ffd9fb3832c6c44f
class SVM extends CvStruct<cvg.PtrSVM> {
  SVM._(cvg.PtrSVMPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory SVM.create() {
    final p = calloc<cvg.PtrSVM>();
    cvRun(() => CFFI.SVM_Create(p));
    return SVM._(p);
  }

  static final finalizer =
      OcvFinalizer<cvg.PtrSVMPtr>(CFFI.addresses.SVM_Close);

  double getC() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.SVM_GetC(ref, p));
      return p.value;
    });
  }

  Mat getClassWeights() {
    return using<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => CFFI.SVM_GetClassWeights(ref, p));
      return Mat.fromPointer(p);
    });
  }

  double getCoef0() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.SVM_GetCoef0(ref, p));
      return p.value;
    });
  }

  double getDecisionFunction(int i, Mat alpha, Mat svidx) {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
          () => CFFI.SVM_GetDecisionFunction(ref, i, alpha.ref, svidx.ref, p));
      return p.value;
    });
  }

  double getDegree() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.SVM_GetDegree(ref, p));
      return p.value;
    });
  }

  double getGamma() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.SVM_GetGamma(ref, p));
      return p.value;
    });
  }

  int getKernelType() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.SVM_GetKernelType(ref, p));
      return p.value;
    });
  }

  double getNu() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.SVM_GetNu(ref, p));
      return p.value;
    });
  }

  double getP() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.SVM_GetP(ref, p));
      return p.value;
    });
  }

  Mat getSupportVectors() {
    return using<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => CFFI.SVM_GetSupportVectors(ref, p));
      return Mat.fromPointer(p);
    });
  }
//TODO: from pointer is not found
  // TermCriteria getTermCriteria() {
  //   return using<TermCriteria>((arena) {
  //     final p = arena<cvg.TermCriteria>();
  //     cvRun(() => CFFI.SVM_GetTermCriteria(ref, p));
  //     return TermCriteria.fromPointer(p);
  //   });
  // }

  int getType() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.SVM_GetType(ref, p));
      return p.value;
    });
  }

  Mat getUncompressedSupportVectors() {
    return using<Mat>((arena) {
      final p = arena<cvg.Mat>();
      cvRun(() => CFFI.SVM_GetUncompressedSupportVectors(ref, p));
      return Mat.fromPointer(p);
    });
  }

  void setC(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetC(ref, val));
    });
  }

  void setClassWeights(Mat val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetClassWeights(ref, val.ref));
    });
  }

  void setCoef0(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetCoef0(ref, val));
    });
  }

  void setDegree(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetDegree(ref, val));
    });
  }

  void setGamma(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetGamma(ref, val));
    });
  }

  void setKernel(int kernelType) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetKernel(ref, kernelType));
    });
  }

  void setNu(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetNu(ref, val));
    });
  }

  void setP(double val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetP(ref, val));
    });
  }

  void setTermCriteria(TermCriteria val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetTermCriteria(ref, val.ref));
    });
  }

  void setType(int val) {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_SetType(ref, val));
    });
  }

  bool trainAuto(
      cvg.PtrTrainData data,
      int kFold,
      ParamGrid Cgrid,
      ParamGrid gammaGrid,
      ParamGrid pGrid,
      ParamGrid nuGrid,
      ParamGrid coeffGrid,
      ParamGrid degreeGrid,
      bool balanced) {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.SVM_TrainAuto(
          ref,
          data.ref,
          kFold,
          Cgrid.ref,
          gammaGrid.ref,
          pGrid.ref,
          nuGrid.ref,
          coeffGrid.ref,
          degreeGrid.ref,
          balanced,
          p));
      return p.value;
    });
  }

  bool trainAutoWithSamples(
      Mat samples,
      int layout,
      Mat responses,
      int kFold,
      cvg.PtrParamGrid Cgrid,
      cvg.PtrParamGrid gammaGrid,
      cvg.PtrParamGrid pGrid,
      cvg.PtrParamGrid nuGrid,
      cvg.PtrParamGrid coeffGrid,
      cvg.PtrParamGrid degreeGrid,
      bool balanced) {
    return using<bool>((arena) {
      final p = arena<ffi.Uint8>();
      cvRun(() => CFFI.SVM_TrainAuto_1(
          ref,
          samples.ref,
          layout,
          responses.ref,
          kFold,
          Cgrid.ref,
          gammaGrid.ref,
          pGrid.ref,
          nuGrid.ref,
          coeffGrid.ref,
          degreeGrid.ref,
          balanced,
          p));
      return p.value != 0;
    });
  }

  double calcError(cvg.PtrTrainData data, bool test, Mat resp) {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.SVM_CalcError(ref, data.ref, test, resp.ref, p));
      return p.value;
    });
  }

  bool empty() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.SVM_Empty(ref, p));
      return p.value;
    });
  }

  int getVarCount() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.SVM_GetVarCount(ref, p));
      return p.value;
    });
  }

  bool isClassifier() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.SVM_IsClassifier(ref, p));
      return p.value;
    });
  }

  bool isTrained() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.SVM_IsTrained(ref, p));
      return p.value;
    });
  }

  double predict(Mat samples, Mat results, int flags) {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.SVM_Predict(ref, samples.ref, results.ref, flags, p));
      return p.value;
    });
  }

  bool train(cvg.PtrTrainData trainData, int flags) {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.SVM_Train(ref, trainData.ref, flags, p));
      return p.value;
    });
  }

  bool trainWithSamples(Mat samples, int layout, Mat responses) {
    return using<bool>((arena) {
      final p = arena<ffi.Uint8>();
      cvRun(() => CFFI.SVM_Train_1(ref, samples.ref, layout, responses.ref, p));
      return p.value != 0;
    });
  }

  void clear() {
    return using<void>((arena) {
      cvRun(() => CFFI.SVM_Clear(ref));
    });
  }

  String getDefaultName() {
    return using<String>((arena) {
      final p = arena<ffi.Pointer<ffi.Char>>();
      cvRun(() => CFFI.SVM_GetDefaultName(ref, p));
      return p.cast<Utf8>().toDartString();
    });
  }

  ParamGrid getDefaultGrid(int param_id) {
    return using<ParamGrid>((arena) {
      final p = calloc<cvg.ParamGrid>();
      cvRun(() => CFFI.SVM_GetDefaultGrid(ref, param_id, p));
      return ParamGrid.fromPointer(p);
    });
  }

  cvg.PtrParamGrid getDefaultGridPtr(int param_id) {
    return using<cvg.PtrParamGrid>((arena) {
      final p = calloc<cvg.PtrParamGrid>();
      cvRun(() => CFFI.SVM_GetDefaultGridPtr(ref, param_id, p));
      return cvg.PtrParamGrid.fromPointer(p);
    });
  }

  void save(String filename) {
    return using<void>((arena) {
      final p = filename.toNativeUtf8().cast<ffi.Char>();
      cvRun(() => CFFI.SVM_Save(ref, p));
      calloc.free(p);
    });
  }

  void load(String filepath) {
    return using<void>((arena) {
      final p = filepath.toNativeUtf8().cast<ffi.Char>();
      cvRun(() => CFFI.SVM_Load(ref, p));
      calloc.free(p);
    });
  }

  void loadFromString(String strModel, String objname) {
    return using<void>((arena) {
      final sm = strModel.toNativeUtf8().cast<ffi.Char>();
      final on = objname.toNativeUtf8().cast<ffi.Char>();
      cvRun(() => CFFI.SVM_LoadFromString(ref, sm, on));
      calloc.free(sm);
      calloc.free(on);
    });
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.SVM get ref => ptr.ref;

  // @override
  // cvg.PtrSVM get ref => ptr.ref;

  static const int KERNEL_CUSTOM = -1;
  static const int KERNEL_LINEAR = 0;
  static const int KERNEL_POLY = 1;
  static const int KERNEL_RBF = 2;
  static const int KERNEL_SIGMOID = 3;
  static const int KERNEL_CHI2 = 4;
  static const int KERNEL_INTER = 5;

  static const int PARAM_C = 0;
  static const int PARAM_GAMMA = 1;
  static const int PARAM_P = 2;
  static const int PARAM_NU = 3;
  static const int PARAM_COEF = 4;
  static const int PARAM_DEGREE = 5;

  // SVM type
  /// C-Support Vector Classification. n-class classification (n \f$\geq\f$ 2), allows
  /// imperfect separation of classes with penalty multiplier C for outliers.
  static const int C_SVC = 100;

  /// \f$\nu\f$-Support Vector Classification. n-class classification with possible
  ///  imperfect separation. Parameter \f$\nu\f$ (in the range 0..1, the larger the value, the smoother
  ///  the decision boundary) is used instead of C.
  static const int NU_SVC = 101;

  /// Distribution Estimation (One-class %SVM). All the training data are from
  /// the same class, %SVM builds a boundary that separates the class from the rest of the feature
  /// space.
  static const int ONE_CLASS = 102;

  /// \f$\epsilon\f$-Support Vector Regression. The distance between feature vectors
  ///  from the training set and the fitting hyper-plane must be less than p. For outliers the
  ///  penalty multiplier C is used.
  static const int EPS_SVR = 103;

  //// \f$\nu\f$-Support Vector Regression. \f$\nu\f$ is used instead of p.
  ///  See @cite LibSVM for details.
  static const int NU_SVR = 104;
}

class ParamGrid extends CvStruct<cvg.ParamGrid> {
  ParamGrid._(cvg.ParamGridPtr ptr) : super.fromPointer(ptr);

  factory ParamGrid.empty() {
    final p = calloc<cvg.ParamGrid>();
    cvRun(() => CFFI.ParamGrid_Empty(p));
    return ParamGrid._(p);
  }

  factory ParamGrid.newGrid(double minVal, double maxVal, double logstep) {
    final p = calloc<cvg.ParamGrid>();
    cvRun(() => CFFI.ParamGrid_New(minVal, maxVal, logstep, p));
    return ParamGrid._(p);
  }

  double getMinVal() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ParamGrid_getMinVal(ref, p));
      return p.value;
    });
  }

  double getMaxVal() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ParamGrid_GetMaxVal(ref, p));
      return p.value;
    });
  }

  double getLogStep() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ParamGrid_GetLogStep(ref, p));
      return p.value;
    });
  }

  static final finalizer =
      OcvFinalizer<cvg.ParamGridPtr>(CFFI.addresses.ParamGrid_Close);

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.ParamGrid get ref => ptr.ref;
}
