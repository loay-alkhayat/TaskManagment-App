import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/add_todo_parameters.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/add_todo_entity.dart';
import '../repositories/add_todo_repository.dart';

class AddTodoUseCase extends BaseUseCase<AddTodoEntity, AddTodoParameters> {
  final AddTodoRepository addTodosRepository;

  AddTodoUseCase(this.addTodosRepository);

  @override
  Future<Either<Failure, AddTodoEntity>> call(
      AddTodoParameters parameters) async {
    return await addTodosRepository.addTodo(parameters);
  }
}
