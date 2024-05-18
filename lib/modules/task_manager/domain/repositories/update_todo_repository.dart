import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/domain/entities/update_todo_entity.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/update_todo_parameters.dart';

import '../../../../core/errors/failures.dart';

abstract class UpdateTodoRepository {
  Future<Either<Failure, UpdateTodoEntity>> updateTodo(
      UpdateTodoParameters parameters);
}
