import 'package:equatable/equatable.dart';

class GetTodoEntity extends Equatable {
  final List<GetTodosInformationEntity> todos;
  final int total;
  final int skip;
  final int limit;

  const GetTodoEntity({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object> get props => [
        todos,
        total,
        skip,
        limit,
      ];
}

class GetTodosInformationEntity extends Equatable {
  final int todoID;
  final String todo;
  final bool completed;
  final int userID;

  const GetTodosInformationEntity(
      {required this.todoID,
      required this.todo,
      required this.completed,
      required this.userID});

  @override
  List<Object> get props => [todoID, todo, completed, userID];
}
