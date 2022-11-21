import 'package:dio/dio.dart';

class ImdbCloneException implements Exception {
  final ImdbCloneExceptionType type;
  final String message;
  ImdbCloneException({required this.type, this.message = ""});
}

enum ImdbCloneExceptionType {
  other,
  noConnection,
  apiConnectionProblem,
}

extension DioErrorX on DioError {
  ImdbCloneException get localException {
    if (type == DioErrorType.response) {
      return ImdbCloneException(type: ImdbCloneExceptionType.apiConnectionProblem);
    }
    if (type == DioErrorType.other) {
      return ImdbCloneException(type: ImdbCloneExceptionType.noConnection);
    }
    return ImdbCloneException(type: ImdbCloneExceptionType.noConnection);
  }
}
