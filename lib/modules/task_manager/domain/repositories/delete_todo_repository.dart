import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/delete_todo_parameters.dart';

import '../../../../core/errors/failures.dart';
import '../entities/delete_todo_entity.dart';

abstract class DeleteTodoRepository {
  Future<Either<Failure, DeleteTodoEntity>> deleteTodo(
      DeleteTodoParameters parameters);
}
