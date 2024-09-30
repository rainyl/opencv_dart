// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

/*  Error status codes
    Original codes were from OpenCVSharp
    Original Author: @shimat
    LICENSE: Apache-2.0
    https://github.com/shimat/opencvsharp/blob/main/src/OpenCvSharp/Modules/core/Enum/ErrorCode.cs

    Ported to Dart By: @Rainyl
    LICENSE: Apache-2.0
*/
extension type const ErrorCode(int code) {
  /// @brief everithing is ok CV_StsOk
  static const StsOk = ErrorCode(0);

  /// @brief pseudo error for back trace CV_StsBackTrace
  static const StsBackTrace = ErrorCode(-1);

  /// @brief unknown /unspecified error CV_StsError
  static const StsError = ErrorCode(-2);

  /// @brief internal error (bad state)  CV_StsInternal
  static const StsInternal = ErrorCode(-3);

  /// @brief insufficient memory CV_StsNoMem
  static const StsNoMem = ErrorCode(-4);

  /// @brief function arg/param is bad CV_StsBadArg
  static const StsBadArg = ErrorCode(-5);

  /// @brief unsupported function CV_StsBadFunc
  static const StsBadFunc = ErrorCode(-6);

  /// @brief iter. didn't converge CV_StsNoConv
  static const StsNoConv = ErrorCode(-7);

  /// @brief tracing CV_StsAutoTrace
  static const StsAutoTrace = ErrorCode(-8);

  /// @brief image header is NULL CV_HeaderIsNull
  static const HeaderIsNull = ErrorCode(-9);

  /// @brief image size is invalid CV_BadImageSize
  static const BadImageSize = ErrorCode(-10);

  /// @brief offset is invalid CV_BadOffset
  static const BadOffset = ErrorCode(-11);

  /// @brief CV_BadOffset
  static const BadDataPtr = ErrorCode(-12);

  /// @brief CV_BadStep
  static const BadStep = ErrorCode(-13);

  /// @brief CV_BadModelOrChSeq
  static const BadModelOrChSeq = ErrorCode(-14);

  /// @brief CV_BadNumChannels
  static const BadNumChannels = ErrorCode(-15);

  /// @brief CV_BadNumChannel1U
  static const BadNumChannel1U = ErrorCode(-16);

  /// @brief CV_BadDepth
  static const BadDepth = ErrorCode(-17);

  /// @brief CV_BadAlphaChannel
  static const BadAlphaChannel = ErrorCode(-18);

  /// @brief CV_BadOrder
  static const BadOrder = ErrorCode(-19);

  /// @brief CV_BadOrigin
  static const BadOrigin = ErrorCode(-20);

  /// @brief CV_BadAlign
  static const BadAlign = ErrorCode(-21);

  /// @brief CV_BadCallBack
  static const BadCallBack = ErrorCode(-22);

  /// @brief CV_BadTileSize
  static const BadTileSize = ErrorCode(-23);

  /// @brief CV_BadCOI
  static const BadCOI = ErrorCode(-24);

  /// @brief CV_BadROISize
  static const BadROISize = ErrorCode(-25);

  /// @brief CV_MaskIsTiled
  static const MaskIsTiled = ErrorCode(-26);

  /// @brief null pointer CV_StsNullPtr
  static const StsNullPtr = ErrorCode(-27);

  /// @brief incorrect vector length CV_StsVecLengthErr
  static const StsVecLengthErr = ErrorCode(-28);

  /// @brief incorr. filter structure content CV_StsFilterStructContentErr
  static const StsFilterStructContentErr = ErrorCode(-29);

  /// @brief incorr. transform kernel content CV_StsKernelStructContentErr
  static const StsKernelStructContentErr = ErrorCode(-30);

  /// @brief incorrect filter ofset value CV_StsFilterOffsetErr
  static const StsFilterOffsetErr = ErrorCode(-31);

  /*extra for CV */

  /// @brief the input/output structure size is incorrect CV_StsBadSize
  static const StsBadSize = ErrorCode(-201);

  /// @brief division by zero CV_StsDivByZero
  static const StsDivByZero = ErrorCode(-202);

  /// @brief in-place operation is not supported CV_StsInplaceNotSupported
  static const StsInplaceNotSupported = ErrorCode(-203);

  /// @brief request can't be completed CV_StsObjectNotFound
  static const StsObjectNotFound = ErrorCode(-204);

  /// @brief formats of input/output arrays differ CV_StsUnmatchedFormats
  static const StsUnmatchedFormats = ErrorCode(-205);

  /// @brief flag is wrong or not supported CV_StsBadFlag
  static const StsBadFlag = ErrorCode(-206);

  /// @brief bad MyCvPoint CV_StsBadPoint
  static const StsBadPoint = ErrorCode(-207);

  /// @brief bad format of mask (neither 8uC1 nor 8sC1) CV_StsBadMask
  static const StsBadMask = ErrorCode(-208);

  /// @brief sizes of input/output structures do not match CV_StsUnmatchedSizes
  static const StsUnmatchedSizes = ErrorCode(-209);

  /// @brief the data format/type is not supported by the function CV_StsUnsupportedFormat
  static const StsUnsupportedFormat = ErrorCode(-210);

  /// @brief some of parameters are out of range CV_StsOutOfRange
  static const StsOutOfRange = ErrorCode(-211);

  /// @brief invalid syntax/structure of the parsed file CV_StsParseError
  static const StsParseError = ErrorCode(-212);

  /// @brief the requested function/feature is not implemented CV_StsNotImplemented
  static const StsNotImplemented = ErrorCode(-213);

  /// @brief an allocated block has been corrupted CV_StsBadMemBlock
  static const StsBadMemBlock = ErrorCode(-214);

  /// @brief assertion failed
  static const StsAssert = ErrorCode(-215);

  static const GpuNotSupported = ErrorCode(-216);
  static const GpuApiCallError = ErrorCode(-217);
  static const OpenGlNotSupported = ErrorCode(-218);
  static const OpenGlApiCallError = ErrorCode(-219);
  static const OpenCLApiCallError = ErrorCode(-220);
  static const OpenCLDoubleNotSupported = ErrorCode(-221);
  static const OpenCLInitError = ErrorCode(-222);
  static const OpenCLNoAMDBlasFft = ErrorCode(-223);
}
