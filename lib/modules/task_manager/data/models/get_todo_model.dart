import 'package:taskmanager_app/modules/task_manager/domain/entities/get_tasks_entity.dart';

class GetTodoModel extends GetTodoEntity {
  const GetTodoModel(
      {required super.todos,
      required super.total,
      required super.skip,
      required super.limit});
  factory GetTodoModel.fromJson(Map<String, dynamic> json) {
    return GetTodoModel(
        todos: List<GetTodoInformationModel>.from(
          json['todos'].map((data) => GetTodoInformationModel.fromJson(data)),
        ),
        total: json["total"],
        skip: json['skip'],
        limit: json['limit']);
  }
}

class GetTodoInformationModel extends GetTodosInformationEntity {
  const GetTodoInformationModel(
      {required super.todoID,
      required super.todo,
      required super.completed,
      required super.userID});
  factory GetTodoInformationModel.fromJson(Map<String, dynamic> json) {
    return GetTodoInformationModel(
      todoID: json['id'],
      todo: json["todo"],
      completed: json['completed'],
      userID: json['userId'],
    );
  }
}
