import 'error_code.dart';

class OpenCvException implements Exception {
  /// The numeric code for error status
  ErrorCode status;

  /// The source func name where error is encountered
  String funcName;

  /// A description of the error
  String message;

  /// The source file name where error is encountered
  String fileName;

  /// The line number in the source where error is encountered
  int line;

  OpenCvException(
    this.status,
    this.funcName,
    this.message,
    this.fileName,
    this.line,
  ) : super();

  OpenCvException.empty() : this(ErrorCode.StsOk, "", "", "", 0);
  OpenCvException.message(ErrorCode code, message)
      : this(code, "", message, "", 0);

  String toString() {
    if (message.isEmpty) return "OpenCvException";
    return "OpenCvException: $message";
  }
}

class OpenCvDartException implements Exception {
  final String message;
  OpenCvDartException(this.message);

  @override
  String toString() {
    return "OpenCvDartException: $message";
  }
}
