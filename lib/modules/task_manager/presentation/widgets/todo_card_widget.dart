import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanager_app/core/functions/functions.dart';
import 'package:taskmanager_app/modules/task_manager/domain/entities/get_tasks_entity.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/delete_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/pages/edit_todo_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/task_manager_bloc.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({
    super.key,
    required this.getTodosInformationEntity,
    required this.todoID,
  });
  final GetTodosInformationEntity getTodosInformationEntity;
  final int todoID;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      surfaceTintColor: AppColors.white,
      color: AppColors.white,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(3.w),
      ),
      elevation: 3,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(microseconds: 500),
            height: getTodosInformationEntity.todo.characters.length > 50
                ? 15.h
                : 10.h,
            width: 2.w,
            color: getTodosInformationEntity.completed
                ? AppColors.green
                : AppColors.primary,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                getTodosInformationEntity.todo,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp),
              ),
            ),
          ),
          PopupMenuButton(
            color: AppColors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            surfaceTintColor: AppColors.lightGrey,
            iconColor: AppColors.grey,
            splashRadius: 20,
            popUpAnimationStyle: AnimationStyle(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              reverseCurve: Curves.linear,
              reverseDuration: const Duration(milliseconds: 500),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Update Todo'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Delete Todo'),
              ),
            ],
            onSelected: (value) {
              // Handle item selection here
              switch (value) {
                case 1:
                  Functions.navigatorPush(
                      context: context,
                      screenNameToNavigate: UpdateTodoScreen(
                          getTodosInformationEntity:
                              getTodosInformationEntity));
                  break;
                case 2:
                  DeleteTodoParameters parameters =
                      DeleteTodoParameters(todoID: todoID);
                  context.read<TaskManagerBloc>().add(
                        DeleteTodoEvent(parameters),
                      );
                  break;

                default:
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
