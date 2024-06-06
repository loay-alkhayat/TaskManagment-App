import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanager_app/core/enums/request_states.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/update_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/bloc/task_manager_bloc.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/bloc/task_manager_state.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/pages/todos_screen.dart';

import '../../../../core/components/show_toast.dart';
import '../../../../core/components/width_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/parameters/get_todo_parameters.dart';

class UpdateTodoScreen extends StatelessWidget {
  String? todoDescription;
  int? todoID;

  UpdateTodoScreen(
      {super.key, required this.todoDescription, required this.todoID});

  late final TextEditingController updateTodoController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final bool isCompleted;
  bool updateTodoStatesLoading = false;
  @override
  Widget build(BuildContext context) {
    updateTodoController = TextEditingController(text: todoDescription ?? '');

    return Form(
      key: formKey,
      child: PopScope(
        canPop: updateTodoStatesLoading == false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            forceMaterialTransparency: true,
            title: const Text("Update Todo"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: TextFormField(
                  autofocus: true,
                  maxLines: 3,
                  selectionWidthStyle: BoxWidthStyle.tight,
                  selectionControls: MaterialTextSelectionControls(),
                  cursorColor: AppColors.greyColor,
                  cursorOpacityAnimates: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  controller: updateTodoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Todo';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Write Your Todo",
                    hintStyle: const TextStyle(color: AppColors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.w),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: AppColors.lightGrey,
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) => Checkbox(
                        value: isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            isCompleted = value!;
                          });
                        },
                      ),
                    ),
                    const Text('Completed'),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<TaskManagerBloc, TaskManagerState>(
                listener: (context, state) {
                  if (state.updateTodoStates == RequestStates.loading) {
                    updateTodoStatesLoading = true;
                  }
                  if (state.updateTodoStates == RequestStates.loaded) {
                    updateTodoStatesLoading = false;
                    showToast(message: "Updated Todo Successfully");
                    context
                        .read<TaskManagerBloc>()
                        .add(const ResetTodoStateEvent());
                    TodosScreen.todos.clear();
                    TodosScreen.fetchData = false;
                    GetTodoParameters parameters =
                        GetTodoParameters(limit: 10, skip: 0);
                    context
                        .read<TaskManagerBloc>()
                        .add(GetTodoEvent(parameters));
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return ConditionalBuilder(
                    condition: state.updateTodoStates != RequestStates.loading,
                    builder: (context) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: WidthButton(
                        textButton: "Update Todo Now!",
                        onPress: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            UpdateTodoParameters parameters =
                                UpdateTodoParameters(
                                    completed: isCompleted, todoID: todoID!);
                            context.read<TaskManagerBloc>().add(
                                  UpdateTodoEvent(parameters),
                                );
                          }
                        },
                      ),
                    ),
                    fallback: (context) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
