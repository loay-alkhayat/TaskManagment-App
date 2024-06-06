import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/data/models/delete_todo_model.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/delete_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/domain/repositories/delete_todo_repository.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/dio_services.dart';
import '../data_sources/delete_todo_data_source/delete_todo_data_source.dart';

class DeleteTodoRepositoryImp implements DeleteTodoRepository {
  final DeleteTodoDataSource deleteTodoDataSource;

  DeleteTodoRepositoryImp(this.deleteTodoDataSource);

  @override
  Future<Either<Failure, DeleteTodoModel>> deleteTodo(
      DeleteTodoParameters parameters) async {
    try {
      final result = await deleteTodoDataSource.deleteTodo(parameters);

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
