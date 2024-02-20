/*  Error status codes
    Original codes were from OpenCVSharp
    Original Author: @shimat
    LICENSE: Apache-2.0
    https://github.com/shimat/opencvsharp/blob/main/src/OpenCvSharp/Modules/core/Enum/ErrorCode.cs
    
    Ported to Dart By: @Rainyl
    LICENSE: Apache-2.0
*/

enum ErrorCode {
  /// @brief everithing is ok [CV_StsOk]
  StsOk(0),

  /// @brief pseudo error for back trace [CV_StsBackTrace]
  StsBackTrace(-1),

  /// @brief unknown /unspecified error [CV_StsError]
  StsError(-2),

  /// @brief internal error (bad state)  [CV_StsInternal]
  StsInternal(-3),

  /// @brief insufficient memory [CV_StsNoMem]
  StsNoMem(-4),

  /// @brief function arg/param is bad [CV_StsBadArg]
  StsBadArg(-5),

  /// @brief unsupported function [CV_StsBadFunc]
  StsBadFunc(-6),

  /// @brief iter. didn't converge [CV_StsNoConv]
  StsNoConv(-7),

  /// @brief tracing [CV_StsAutoTrace]
  StsAutoTrace(-8),

  /// @brief image header is NULL [CV_HeaderIsNull]
  HeaderIsNull(-9),

  /// @brief image size is invalid [CV_BadImageSize]
  BadImageSize(-10),

  /// @brief offset is invalid [CV_BadOffset]
  BadOffset(-11),

  /// @brief [CV_BadOffset]
  BadDataPtr(-12),

  /// @brief [CV_BadStep]
  BadStep(-13),

  /// @brief [CV_BadModelOrChSeq]
  BadModelOrChSeq(-14),

  /// @brief [CV_BadNumChannels]
  BadNumChannels(-15),

  /// @brief [CV_BadNumChannel1U]
  BadNumChannel1U(-16),

  /// @brief [CV_BadDepth]
  BadDepth(-17),

  /// @brief [CV_BadAlphaChannel]
  BadAlphaChannel(-18),

  /// @brief [CV_BadOrder]
  BadOrder(-19),

  /// @brief [CV_BadOrigin]
  BadOrigin(-20),

  /// @brief [CV_BadAlign]
  BadAlign(-21),

  /// @brief [CV_BadCallBack]
  BadCallBack(-22),

  /// @brief [CV_BadTileSize]
  BadTileSize(-23),

  /// @brief [CV_BadCOI]
  BadCOI(-24),

  /// @brief [CV_BadROISize]
  BadROISize(-25),

  /// @brief [CV_MaskIsTiled]
  MaskIsTiled(-26),

  /// @brief null pointer [CV_StsNullPtr]
  StsNullPtr(-27),

  /// @brief incorrect vector length [CV_StsVecLengthErr]
  StsVecLengthErr(-28),

  /// @brief incorr. filter structure content [CV_StsFilterStructContentErr]
  StsFilterStructContentErr(-29),

  /// @brief incorr. transform kernel content [CV_StsKernelStructContentErr]
  StsKernelStructContentErr(-30),

  /// @brief incorrect filter ofset value [CV_StsFilterOffsetErr]
  StsFilterOffsetErr(-31),

  /*extra for CV */

  /// @brief the input/output structure size is incorrect [CV_StsBadSize]
  StsBadSize(-201),

  /// @brief division by zero [CV_StsDivByZero]
  StsDivByZero(-202),

  /// @brief in-place operation is not supported [CV_StsInplaceNotSupported]
  StsInplaceNotSupported(-203),

  /// @brief request can't be completed [CV_StsObjectNotFound]
  StsObjectNotFound(-204),

  /// @brief formats of input/output arrays differ [CV_StsUnmatchedFormats]
  StsUnmatchedFormats(-205),

  /// @brief flag is wrong or not supported [CV_StsBadFlag]
  StsBadFlag(-206),

  /// @brief bad MyCvPoint [CV_StsBadPoint]
  StsBadPoint(-207),

  /// @brief bad format of mask (neither 8uC1 nor 8sC1) [CV_StsBadMask]
  StsBadMask(-208),

  /// @brief sizes of input/output structures do not match [CV_StsUnmatchedSizes]
  StsUnmatchedSizes(-209),

  /// @brief the data format/type is not supported by the function [CV_StsUnsupportedFormat]
  StsUnsupportedFormat(-210),

  /// @brief some of parameters are out of range [CV_StsOutOfRange]
  StsOutOfRange(-211),

  /// @brief invalid syntax/structure of the parsed file [CV_StsParseError]
  StsParseError(-212),

  /// @brief the requested function/feature is not implemented [CV_StsNotImplemented]
  StsNotImplemented(-213),

  /// @brief an allocated block has been corrupted [CV_StsBadMemBlock]
  StsBadMemBlock(-214),

  /// @brief assertion failed
  StsAssert(-215),

  GpuNotSupported(-216),
  GpuApiCallError(-217),
  OpenGlNotSupported(-218),
  OpenGlApiCallError(-219),
  OpenCLApiCallError(-220),
  OpenCLDoubleNotSupported(-221),
  OpenCLInitError(-222),
  OpenCLNoAMDBlasFft(-223);

  const ErrorCode(this.code);
  final int code;
}
