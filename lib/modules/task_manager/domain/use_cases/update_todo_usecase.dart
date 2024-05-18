import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/update_todo_entity.dart';
import '../parameters/update_todo_parameters.dart';
import '../repositories/update_todo_repository.dart';

class UpdateTodoUseCase
    extends BaseUseCase<UpdateTodoEntity, UpdateTodoParameters> {
  final UpdateTodoRepository updateTodosRepository;

  UpdateTodoUseCase(this.updateTodosRepository);

  @override
  Future<Either<Failure, UpdateTodoEntity>> call(
      UpdateTodoParameters parameters) async {
    return await updateTodosRepository.updateTodo(parameters);
  }
}
