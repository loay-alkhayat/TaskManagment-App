import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_states.dart';
import '../../domain/entities/add_todo_entity.dart';
import '../../domain/entities/delete_todo_entity.dart';
import '../../domain/entities/get_tasks_entity.dart';
import '../../domain/entities/update_todo_entity.dart';

class TaskManagerState extends Equatable {
  final RequestStates getTodoStates;
  final RequestStates addTodoStates;
  final RequestStates deleteTodoStates;
  final RequestStates updateTodoStates;
  final bool getAllTodo;
  final String message;
  final GetTodoEntity? getTodoEntity;
  final AddTodoEntity? addTodoEntity;
  final DeleteTodoEntity? deleteTodoEntity;
  final UpdateTodoEntity? updateTodoEntity;

  const TaskManagerState({
    this.message = "",
    this.getAllTodo = false,
    this.addTodoStates = RequestStates.initial,
    this.deleteTodoStates = RequestStates.initial,
    this.updateTodoStates = RequestStates.initial,
    this.getTodoStates = RequestStates.initial,
    this.getTodoEntity,
    this.addTodoEntity,
    this.deleteTodoEntity,
    this.updateTodoEntity,
  });

  TaskManagerState copyWith(
      {RequestStates? getTodoStates,
      RequestStates? addTodoStates,
      RequestStates? deleteTodoStates,
      RequestStates? updateTodoStates,
      bool? getAllTodo,
      String? message,
      GetTodoEntity? getTodoEntity,
      DeleteTodoEntity? deleteTodoEntity,
      UpdateTodoEntity? updateTodoEntity,
      AddTodoEntity? addTodoEntity}) {
    return TaskManagerState(
        addTodoStates: addTodoStates ?? this.addTodoStates,
        getTodoStates: getTodoStates ?? this.getTodoStates,
        deleteTodoStates: deleteTodoStates ?? this.deleteTodoStates,
        updateTodoStates: updateTodoStates ?? this.updateTodoStates,
        getAllTodo: getAllTodo ?? this.getAllTodo,
        message: message ?? this.message,
        getTodoEntity: getTodoEntity ?? this.getTodoEntity,
        deleteTodoEntity: deleteTodoEntity ?? this.deleteTodoEntity,
        updateTodoEntity: updateTodoEntity ?? this.updateTodoEntity,
        addTodoEntity: addTodoEntity ?? this.addTodoEntity);
  }

  @override
  List<Object?> get props => [
        getTodoStates,
        message,
        getTodoEntity,
        addTodoEntity,
        addTodoStates,
        deleteTodoEntity,
        deleteTodoStates,
        updateTodoEntity,
        updateTodoStates,
        getAllTodo,
      ];
}
