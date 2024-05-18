import 'package:taskmanager_app/modules/task_manager/domain/parameters/get_todo_parameters.dart';

import '../../models/get_todo_model.dart';

abstract class GetTodoDataSource {
  Future<GetTodoModel> getTodo(GetTodoParameters parameters);
}
