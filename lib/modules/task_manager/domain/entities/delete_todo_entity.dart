import 'package:equatable/equatable.dart';

class DeleteTodoEntity extends Equatable {
  final String todo;
  final int todoID;
  final bool completed;
  final int userID;
  final bool isDeleted;
  final String deletedOn;

  const DeleteTodoEntity({
    required this.todo,
    required this.todoID,
    required this.completed,
    required this.userID,
    required this.isDeleted,
    required this.deletedOn,
  });

  @override
  List<Object> get props => [
        todo,
        todoID,
        completed,
        userID,
        isDeleted,
        deletedOn,
      ];
}
