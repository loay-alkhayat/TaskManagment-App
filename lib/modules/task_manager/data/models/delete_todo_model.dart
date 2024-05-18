import 'package:taskmanager_app/modules/task_manager/domain/entities/delete_todo_entity.dart';

class DeleteTodoModel extends DeleteTodoEntity {
  const DeleteTodoModel(
      {required super.todo,
      required super.todoID,
      required super.completed,
      required super.userID,
      required super.deletedOn,
      required super.isDeleted});
  factory DeleteTodoModel.fromJson(Map<String, dynamic> json) {
    return DeleteTodoModel(
        deletedOn: json["deletedOn"],
        isDeleted: json["isDeleted"],
        userID: json["userId"],
        completed: json["completed"],
        todoID: json['id'],
        todo: json['todo']);
  }
}
