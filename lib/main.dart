import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanager_app/core/constants/app_constants.dart';
import 'package:taskmanager_app/core/constants/app_keys.dart';
import 'package:taskmanager_app/core/services/cache_storage_services.dart';
import 'package:taskmanager_app/core/services/dio_services.dart';
import 'package:taskmanager_app/core/services/services_locator.dart';
import 'package:taskmanager_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/pages/todos_screen.dart';

import 'core/constants/app_colors.dart';
import 'core/services/bloc_observer.dart';
import 'modules/auth/presentation/pages/auth_screen.dart';
import 'modules/task_manager/domain/parameters/get_todo_parameters.dart';
import 'modules/task_manager/presentation/bloc/task_manager_bloc.dart';

Widget widget = const AuthScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DioServices().init();
  ServicesLocator().init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  AppConstants.userID = CacheHelper.getData(key: "userID");
  AppKeys.userToken = CacheHelper.getData(key: "userToken");
  if (AppKeys.userToken != null) {
    widget = TodosScreen();
  } else {
    widget = const AuthScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetTodoParameters parameters = GetTodoParameters(limit: 10, skip: 0);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(sl())),
        BlocProvider<TaskManagerBloc>(
            create: (context) => TaskManagerBloc(sl(), sl(), sl(), sl())
              ..add(GetTodoEvent(parameters))),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.white, primary: AppColors.primary),
          ),
          home: widget,
        ),
      ),
    );
  }
}
