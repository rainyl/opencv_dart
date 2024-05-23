// ignore_for_file: constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

/// Support Vector Machines.
/// https://docs.opencv.org/4.x/d1/d2d/classcv_1_1ml_1_1SVM.html#ab4b93a4c42bbe213ffd9fb3832c6c44f
class SVM extends CvStruct<cvg.PtrSVM> {
  SVM._(cvg.PtrSVMPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory SVM() {
    throw UnimplementedError();
  }

  static final finalizer = OcvFinalizer<cvg.PtrSVMPtr>(CFFI.addresses.SVM_Close);

  cvg.SVM get svm {
    final s = calloc<cvg.SVM>();
    cvRun(() => CFFI.SVM_Get(ref, s));
    return s.ref;
  }

  @override
  List<int> get props => [ptr.address];

  @override
  cvg.PtrSVM get ref => ptr.ref;

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
