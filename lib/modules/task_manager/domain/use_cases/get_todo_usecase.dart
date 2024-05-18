import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/get_todo_parameters.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/get_tasks_entity.dart';
import '../repositories/get_todo_repository.dart';

class GetTodoUseCase extends BaseUseCase<GetTodoEntity, GetTodoParameters> {
  final GetTodoRepository getTodosRepository;

  GetTodoUseCase(this.getTodosRepository);

  @override
  Future<Either<Failure, GetTodoEntity>> call(
      GetTodoParameters parameters) async {
    return await getTodosRepository.getTodo(parameters);
  }
}
