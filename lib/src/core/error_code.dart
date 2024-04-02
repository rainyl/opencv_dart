// ignore_for_file: non_constant_identifier_names

/*  Error status codes
    Original codes were from OpenCVSharp
    Original Author: @shimat
    LICENSE: Apache-2.0
    https://github.com/shimat/opencvsharp/blob/main/src/OpenCvSharp/Modules/core/Enum/ErrorCode.cs
    
    Ported to Dart By: @Rainyl
    LICENSE: Apache-2.0
*/

import 'package:equatable/equatable.dart';

class ErrorCode with EquatableMixin {
  /// @brief everithing is ok [CV_StsOk]
  static final ErrorCode StsOk = ErrorCode(0);

  /// @brief pseudo error for back trace [CV_StsBackTrace]
  static final ErrorCode StsBackTrace = ErrorCode(-1);

  /// @brief unknown /unspecified error [CV_StsError]
  static final ErrorCode StsError = ErrorCode(-2);

  /// @brief internal error (bad state)  [CV_StsInternal]
  static final ErrorCode StsInternal = ErrorCode(-3);

  /// @brief insufficient memory [CV_StsNoMem]
  static final ErrorCode StsNoMem = ErrorCode(-4);

  /// @brief function arg/param is bad [CV_StsBadArg]
  static final ErrorCode StsBadArg = ErrorCode(-5);

  /// @brief unsupported function [CV_StsBadFunc]
  static final ErrorCode StsBadFunc = ErrorCode(-6);

  /// @brief iter. didn't converge [CV_StsNoConv]
  static final ErrorCode StsNoConv = ErrorCode(-7);

  /// @brief tracing [CV_StsAutoTrace]
  static final ErrorCode StsAutoTrace = ErrorCode(-8);

  /// @brief image header is NULL [CV_HeaderIsNull]
  static final ErrorCode HeaderIsNull = ErrorCode(-9);

  /// @brief image size is invalid [CV_BadImageSize]
  static final ErrorCode BadImageSize = ErrorCode(-10);

  /// @brief offset is invalid [CV_BadOffset]
  static final ErrorCode BadOffset = ErrorCode(-11);

  /// @brief [CV_BadOffset]
  static final ErrorCode BadDataPtr = ErrorCode(-12);

  /// @brief [CV_BadStep]
  static final ErrorCode BadStep = ErrorCode(-13);

  /// @brief [CV_BadModelOrChSeq]
  static final ErrorCode BadModelOrChSeq = ErrorCode(-14);

  /// @brief [CV_BadNumChannels]
  static final ErrorCode BadNumChannels = ErrorCode(-15);

  /// @brief [CV_BadNumChannel1U]
  static final ErrorCode BadNumChannel1U = ErrorCode(-16);

  /// @brief [CV_BadDepth]
  static final ErrorCode BadDepth = ErrorCode(-17);

  /// @brief [CV_BadAlphaChannel]
  static final ErrorCode BadAlphaChannel = ErrorCode(-18);

  /// @brief [CV_BadOrder]
  static final ErrorCode BadOrder = ErrorCode(-19);

  /// @brief [CV_BadOrigin]
  static final ErrorCode BadOrigin = ErrorCode(-20);

  /// @brief [CV_BadAlign]
  static final ErrorCode BadAlign = ErrorCode(-21);

  /// @brief [CV_BadCallBack]
  static final ErrorCode BadCallBack = ErrorCode(-22);

  /// @brief [CV_BadTileSize]
  static final ErrorCode BadTileSize = ErrorCode(-23);

  /// @brief [CV_BadCOI]
  static final ErrorCode BadCOI = ErrorCode(-24);

  /// @brief [CV_BadROISize]
  static final ErrorCode BadROISize = ErrorCode(-25);

  /// @brief [CV_MaskIsTiled]
  static final ErrorCode MaskIsTiled = ErrorCode(-26);

  /// @brief null pointer [CV_StsNullPtr]
  static final ErrorCode StsNullPtr = ErrorCode(-27);

  /// @brief incorrect vector length [CV_StsVecLengthErr]
  static final ErrorCode StsVecLengthErr = ErrorCode(-28);

  /// @brief incorr. filter structure content [CV_StsFilterStructContentErr]
  static final ErrorCode StsFilterStructContentErr = ErrorCode(-29);

  /// @brief incorr. transform kernel content [CV_StsKernelStructContentErr]
  static final ErrorCode StsKernelStructContentErr = ErrorCode(-30);

  /// @brief incorrect filter ofset value [CV_StsFilterOffsetErr]
  static final ErrorCode StsFilterOffsetErr = ErrorCode(-31);

  /*extra for CV */

  /// @brief the input/output structure size is incorrect [CV_StsBadSize]
  static final ErrorCode StsBadSize = ErrorCode(-201);

  /// @brief division by zero [CV_StsDivByZero]
  static final ErrorCode StsDivByZero = ErrorCode(-202);

  /// @brief in-place operation is not supported [CV_StsInplaceNotSupported]
  static final ErrorCode StsInplaceNotSupported = ErrorCode(-203);

  /// @brief request can't be completed [CV_StsObjectNotFound]
  static final ErrorCode StsObjectNotFound = ErrorCode(-204);

  /// @brief formats of input/output arrays differ [CV_StsUnmatchedFormats]
  static final ErrorCode StsUnmatchedFormats = ErrorCode(-205);

  /// @brief flag is wrong or not supported [CV_StsBadFlag]
  static final ErrorCode StsBadFlag = ErrorCode(-206);

  /// @brief bad MyCvPoint [CV_StsBadPoint]
  static final ErrorCode StsBadPoint = ErrorCode(-207);

  /// @brief bad format of mask (neither 8uC1 nor 8sC1) [CV_StsBadMask]
  static final ErrorCode StsBadMask = ErrorCode(-208);

  /// @brief sizes of input/output structures do not match [CV_StsUnmatchedSizes]
  static final ErrorCode StsUnmatchedSizes = ErrorCode(-209);

  /// @brief the data format/type is not supported by the function [CV_StsUnsupportedFormat]
  static final ErrorCode StsUnsupportedFormat = ErrorCode(-210);

  /// @brief some of parameters are out of range [CV_StsOutOfRange]
  static final ErrorCode StsOutOfRange = ErrorCode(-211);

  /// @brief invalid syntax/structure of the parsed file [CV_StsParseError]
  static final ErrorCode StsParseError = ErrorCode(-212);

  /// @brief the requested function/feature is not implemented [CV_StsNotImplemented]
  static final ErrorCode StsNotImplemented = ErrorCode(-213);

  /// @brief an allocated block has been corrupted [CV_StsBadMemBlock]
  static final ErrorCode StsBadMemBlock = ErrorCode(-214);

  /// @brief assertion failed
  static final ErrorCode StsAssert = ErrorCode(-215);

  static final ErrorCode GpuNotSupported = ErrorCode(-216);
  static final ErrorCode GpuApiCallError = ErrorCode(-217);
  static final ErrorCode OpenGlNotSupported = ErrorCode(-218);
  static final ErrorCode OpenGlApiCallError = ErrorCode(-219);
  static final ErrorCode OpenCLApiCallError = ErrorCode(-220);
  static final ErrorCode OpenCLDoubleNotSupported = ErrorCode(-221);
  static final ErrorCode OpenCLInitError = ErrorCode(-222);
  static final ErrorCode OpenCLNoAMDBlasFft = ErrorCode(-223);

  ErrorCode(this.code);
  final int code;

  @override
  List<int> get props => [code];
}
