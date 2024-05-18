import 'package:taskmanager_app/modules/task_manager/domain/entities/update_todo_entity.dart';

class UpdateTodoModel extends UpdateTodoEntity {
  const UpdateTodoModel(
      {required super.todo,
      required super.todoID,
      required super.completed,
      required super.userID});
  factory UpdateTodoModel.fromJson(Map<String, dynamic> json) {
    return UpdateTodoModel(
        userID: json["userId"],
        completed: json["completed"],
        todoID: json['id'],
        todo: json['todo']);
  }
}
