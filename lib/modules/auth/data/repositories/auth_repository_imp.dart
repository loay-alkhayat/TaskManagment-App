import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/auth/data/model/auth_model.dart';
import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/dio_services.dart';
import '../../domain/repositories/auth_repository.dart';
import '../remote/data_sources/auth_data_source/auth_data_source.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImp(this.authDataSource);

  @override
  Future<Either<Failure, AuthModel>> login(AuthParameters parameters) async {
    try {
      final result = await authDataSource.login(parameters);

      return Right(result);
    } catch (e) {
      logger.i(
          "================== in handleEither Exception ====================== \n ${e.runtimeType} \n ${e.toString()}");
      if (e is UnAuthorizedException) {
        return Left(UnAuthorizedFailure(e.message));
      }
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessageModel.statusMessage));
      }
      if (e is MethodNotAllowedExepction) {
        return Left(MethodNotAllowedFailure(e.message));
      }
      if (e is ForbiddenException) {
        return Left(ForbiddenFailure(e.message));
      }
      if (e is NotFoundException) {
        return Left(NotFoundFailure(e.message));
      }
      if (e is InternalServerErrorException) {
        return Left(InternalServerErrorFailure(e.message));
      }
      if (e is NoInternetConnectionException) {
        return Left(NoInternetConnectionFailure(e.message));
      }
      if (e is ParsingException) {
        return Left(ParsingFailure(e.message));
      }
      if (e is UnknownException) {
        return Left(UnknownFailure(e.message));
      }
      return Left(Failure(e.toString()));
    }
  }
}
