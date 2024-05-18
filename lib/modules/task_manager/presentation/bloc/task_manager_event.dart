part of 'task_manager_bloc.dart';

sealed class TaskManagerEvent extends Equatable {
  const TaskManagerEvent();

  @override
  List<Object> get props => [];
}

class GetTodoEvent extends TaskManagerEvent {
  final GetTodoParameters? parameters;
  const GetTodoEvent(this.parameters);
}

class AddTodoEvent extends TaskManagerEvent {
  final AddTodoParameters? parameters;
  const AddTodoEvent(this.parameters);
}

class UpdateTodoEvent extends TaskManagerEvent {
  final UpdateTodoParameters? parameters;

  const UpdateTodoEvent(this.parameters);
}

class DeleteTodoEvent extends TaskManagerEvent {
  final DeleteTodoParameters? parameters;

  const DeleteTodoEvent(this.parameters);
}

class ResetTodoStateEvent extends TaskManagerEvent {
  const ResetTodoStateEvent();
}
