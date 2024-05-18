import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/delete_todo_entity.dart';
import '../parameters/delete_todo_parameters.dart';
import '../repositories/delete_todo_repository.dart';

class DeleteTodoUseCase
    extends BaseUseCase<DeleteTodoEntity, DeleteTodoParameters> {
  final DeleteTodoRepository deleteTodosRepository;

  DeleteTodoUseCase(this.deleteTodosRepository);

  @override
  Future<Either<Failure, DeleteTodoEntity>> call(
      DeleteTodoParameters parameters) async {
    return await deleteTodosRepository.deleteTodo(parameters);
  }
}
