import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/add_todo_parameters.dart';

import '../../../../core/errors/failures.dart';
import '../entities/add_todo_entity.dart';

abstract class AddTodoRepository {
  Future<Either<Failure, AddTodoEntity>> addTodo(AddTodoParameters parameters);
}
