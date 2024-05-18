import 'error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException({
    required this.errorMessageModel,
  });
}

class LocalDatabaseException implements Exception {
  final String message;

  const LocalDatabaseException({
    required this.message,
  });
}

class NoInternetConnectionException implements Exception {
  final String message = "exception: No Internet Connection";

  const NoInternetConnectionException();
}

class ForbiddenException implements Exception {
  final String message = "exception: Forbidden";

  const ForbiddenException();
}

class UnAuthorizedException implements Exception {
  final String message = "exception: unauthorized";

  const UnAuthorizedException();
}

class MethodNotAllowedExepction implements Exception {
  final String message = "exception: MethodNotAllowed";

  const MethodNotAllowedExepction();
}

class InternalServerErrorException implements Exception {
  final String message = "exception: Internal Server Error";

  const InternalServerErrorException();
}

class ServerUnAvailableException implements Exception {
  final String message = "exception: Server unavailable";

  const ServerUnAvailableException();
}

class NotFoundException implements Exception {
  final String message = "exception: Not Found";

  const NotFoundException();
}

class BadRequestException implements Exception {
  final String message = "exception: Error Request";

  const BadRequestException();
}

class NoContentException implements Exception {
  final String message = "exception: Not Content";

  const NoContentException();
}

class UnknownException implements Exception {
  final String message;

  UnknownException({this.message = 'exception: An Error Occurred'});
}

class ParsingException implements Exception {
  final String message;
  final String parsingMessage;

  ParsingException({
    this.message = 'exception: can not parse response',
    required this.parsingMessage,
  });

  @override
  String toString() => "$message ($parsingMessage)";
}
