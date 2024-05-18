import 'package:taskmanager_app/modules/task_manager/domain/parameters/add_todo_parameters.dart';

import '../../models/add_todo_model.dart';

abstract class AddTodoDataSource {
  Future<AddTodoModel> addTodo(AddTodoParameters parameters);
}
