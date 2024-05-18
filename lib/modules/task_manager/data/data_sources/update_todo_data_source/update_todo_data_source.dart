import '../../../domain/parameters/update_todo_parameters.dart';
import '../../models/update_todo_model.dart';

abstract class UpdateTodoDataSource {
  Future<UpdateTodoModel> updateTodo(UpdateTodoParameters parameters);
}
