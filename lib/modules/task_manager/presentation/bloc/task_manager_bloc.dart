import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/add_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/delete_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/get_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/update_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/domain/use_cases/add_todo_usecase.dart';
import 'package:taskmanager_app/modules/task_manager/domain/use_cases/delete_todo_usecase.dart';
import 'package:taskmanager_app/modules/task_manager/domain/use_cases/update_todo_usecase.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/bloc/task_manager_state.dart';

import '../../../../core/enums/request_states.dart';
import '../../domain/use_cases/get_todo_usecase.dart';

part 'task_manager_event.dart';

class TaskManagerBloc extends Bloc<TaskManagerEvent, TaskManagerState> {
  final GetTodoUseCase getTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final AddTodoUseCase addTodoUseCase;
  TaskManagerBloc(this.getTodoUseCase, this.updateTodoUseCase,
      this.deleteTodoUseCase, this.addTodoUseCase)
      : super(const TaskManagerState()) {
    on<GetTodoEvent>(_getTodos);
    on<AddTodoEvent>(_addTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<ResetTodoStateEvent>((event, emit) {
      emit(state.copyWith(
          deleteTodoStates: RequestStates.initial,
          addTodoStates: RequestStates.initial,
          updateTodoStates: RequestStates.initial,
          getAllTodo: false));
    });
  }
  FutureOr<void> _getTodos(
      GetTodoEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(getTodoStates: RequestStates.loading));
    final result = await getTodoUseCase(event.parameters!);
    result.fold(
      (l) => emit(state.copyWith(
          getTodoStates: RequestStates.error, message: l.message)),
      (r) {
        emit(state.copyWith(
            getTodoStates: RequestStates.loaded,
            getAllTodo: true,
            getTodoEntity: r));
      },
    );
  }

  FutureOr<void> _addTodo(
      AddTodoEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(addTodoStates: RequestStates.loading));
    final result = await addTodoUseCase(event.parameters!);
    result.fold(
      (l) => emit(state.copyWith(
          addTodoStates: RequestStates.error, message: l.message)),
      (r) {
        emit(state.copyWith(
            addTodoStates: RequestStates.loaded, addTodoEntity: r));
      },
    );
  }

  FutureOr<void> _deleteTodo(
      DeleteTodoEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(deleteTodoStates: RequestStates.loading));
    final result = await deleteTodoUseCase(event.parameters!);
    result.fold(
      (l) => emit(state.copyWith(
          deleteTodoStates: RequestStates.error, message: l.message)),
      (r) {
        emit(state.copyWith(
            deleteTodoStates: RequestStates.loaded, deleteTodoEntity: r));
      },
    );
  }

  FutureOr<void> _updateTodo(
      UpdateTodoEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(updateTodoStates: RequestStates.loading));
    final result = await updateTodoUseCase(event.parameters!);
    result.fold(
      (l) => emit(state.copyWith(
          updateTodoStates: RequestStates.error, message: l.message)),
      (r) {
        emit(state.copyWith(
            updateTodoStates: RequestStates.loaded, updateTodoEntity: r));
      },
    );
  }
}
