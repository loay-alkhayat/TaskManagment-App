import 'package:get_it/get_it.dart';
import 'package:taskmanager_app/modules/auth/data/repositories/auth_repository_imp.dart';
import 'package:taskmanager_app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:taskmanager_app/modules/auth/domain/use_cases/auth_usecase.dart';
import 'package:taskmanager_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager_app/modules/task_manager/data/data_sources/update_todo_data_source/update_todo_data_source_imp.dart';
import 'package:taskmanager_app/modules/task_manager/data/repositories/update_todo_repository_imp.dart';
import 'package:taskmanager_app/modules/task_manager/domain/repositories/update_todo_repository.dart';
import 'package:taskmanager_app/modules/task_manager/domain/use_cases/update_todo_usecase.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/bloc/task_manager_bloc.dart';

import '../../modules/auth/data/remote/data_sources/auth_data_source/auth_data_source.dart';
import '../../modules/auth/data/remote/data_sources/auth_data_source/auth_data_source_imp.dart';
import '../../modules/task_manager/data/data_sources/add_todo_data_source/add_todo_data_source.dart';
import '../../modules/task_manager/data/data_sources/add_todo_data_source/add_todo_data_source_imp.dart';
import '../../modules/task_manager/data/data_sources/delete_todo_data_source/delete_todo_data_source.dart';
import '../../modules/task_manager/data/data_sources/delete_todo_data_source/delete_todo_data_source_imp.dart';
import '../../modules/task_manager/data/data_sources/get_todo_data_source/get_todo_data_source.dart';
import '../../modules/task_manager/data/data_sources/get_todo_data_source/get_todo_data_source_imp.dart';
import '../../modules/task_manager/data/data_sources/update_todo_data_source/update_todo_data_source.dart';
import '../../modules/task_manager/data/repositories/add_todo_repository_imp.dart';
import '../../modules/task_manager/data/repositories/delete_todo_repository_imp.dart';
import '../../modules/task_manager/data/repositories/get_todo_repository_imp.dart';
import '../../modules/task_manager/domain/repositories/add_todo_repository.dart';
import '../../modules/task_manager/domain/repositories/delete_todo_repository.dart';
import '../../modules/task_manager/domain/repositories/get_todo_repository.dart';
import '../../modules/task_manager/domain/use_cases/add_todo_usecase.dart';
import '../../modules/task_manager/domain/use_cases/delete_todo_usecase.dart';
import '../../modules/task_manager/domain/use_cases/get_todo_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static ServicesLocator? _instance;

  ServicesLocator._();

  factory ServicesLocator() => _instance ??= ServicesLocator._();

  void init() {
    /// Bloc
    //
    sl.registerFactory(() => AuthBloc(sl()));
    sl.registerFactory(() => TaskManagerBloc(sl(), sl(), sl(), sl()));

    /// Use Cases

    sl.registerLazySingleton(() => GetTodoUseCase(sl()));
    sl.registerLazySingleton(() => AuthUseCase(sl()));
    sl.registerLazySingleton(() => AddTodoUseCase(sl()));
    sl.registerLazySingleton(() => DeleteTodoUseCase(sl()));
    sl.registerLazySingleton(() => UpdateTodoUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl()));
    sl.registerLazySingleton<AddTodoRepository>(
        () => AddTodoRepositoryImp(sl()));
    sl.registerLazySingleton<DeleteTodoRepository>(
        () => DeleteTodoRepositoryImp(sl()));
    sl.registerLazySingleton<UpdateTodoRepository>(
        () => UpdateTodoRepositoryImp(sl()));
    sl.registerLazySingleton<GetTodoRepository>(
        () => GetTodoRepositoryImp(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImp());
    sl.registerLazySingleton<GetTodoDataSource>(() => GetTodoDataSourceImp());
    sl.registerLazySingleton<AddTodoDataSource>(() => AddTodoDataSourceImp());
    sl.registerLazySingleton<UpdateTodoDataSource>(
        () => UpdateTodoDataSourceImp());
    sl.registerLazySingleton<DeleteTodoDataSource>(
        () => DeleteTodoDataSourceImp());
  }
}
