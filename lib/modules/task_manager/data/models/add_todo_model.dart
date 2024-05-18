import 'package:taskmanager_app/modules/task_manager/domain/entities/add_todo_entity.dart';

class AddTodoModel extends AddTodoEntity {
  const AddTodoModel(
      {required super.todo,
      required super.todoID,
      required super.completed,
      required super.userID});
  factory AddTodoModel.fromJson(Map<String, dynamic> json) {
    return AddTodoModel(
        userID: json["userId"],
        completed: json["completed"],
        todoID: json['id'],
        todo: json['todo']);
  }
}
