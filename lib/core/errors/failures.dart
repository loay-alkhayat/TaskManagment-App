import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure(super.message);
}

class NoContentFailure extends Failure {
  const NoContentFailure(super.message);
}

class MethodNotAllowedFailure extends Failure {
  const MethodNotAllowedFailure(super.message);
}

class ServerUnAvailableFailure extends Failure {
  const ServerUnAvailableFailure(super.message);
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
