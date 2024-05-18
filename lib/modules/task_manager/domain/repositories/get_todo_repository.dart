import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/domain/entities/get_tasks_entity.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/get_todo_parameters.dart';

import '../../../../core/errors/failures.dart';

abstract class GetTodoRepository {
  Future<Either<Failure, GetTodoEntity>> getTodo(GetTodoParameters parameters);
}
