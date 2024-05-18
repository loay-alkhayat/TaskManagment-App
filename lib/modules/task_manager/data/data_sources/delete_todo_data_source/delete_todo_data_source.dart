import '../../../domain/parameters/delete_todo_parameters.dart';
import '../../models/delete_todo_model.dart';

abstract class DeleteTodoDataSource {
  Future<DeleteTodoModel> deleteTodo(DeleteTodoParameters parameters);
}
