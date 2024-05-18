import 'package:equatable/equatable.dart';

class AddTodoEntity extends Equatable {
  final String todo;
  final int todoID;
  final bool completed;
  final int userID;

  const AddTodoEntity({
    required this.todo,
    required this.todoID,
    required this.completed,
    required this.userID,
  });

  @override
  List<Object> get props => [
        todo,
        todoID,
        completed,
        userID,
      ];
}
