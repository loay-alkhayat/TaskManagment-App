import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanager_app/core/constants/app_constants.dart';
import 'package:taskmanager_app/core/enums/request_states.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/add_todo_parameters.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/bloc/task_manager_bloc.dart';
import 'package:taskmanager_app/modules/task_manager/presentation/bloc/task_manager_state.dart';

import '../../../../core/components/show_toast.dart';
import '../../../../core/components/width_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/get_tasks_entity.dart';
import '../../domain/parameters/get_todo_parameters.dart';
import '../widgets/todo_card_widget.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});
  static List<GetTodosInformationEntity> todos = [];
  static bool fetchData = false;

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final TextEditingController todoController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;
  int skip = 0;
  @override
  void initState() {
    todoController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    TodosScreen.fetchData = true;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      skip += 10;
      GetTodoParameters parameters = GetTodoParameters(limit: 10, skip: skip);
      context.read<TaskManagerBloc>().add(GetTodoEvent(parameters));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskManagerBloc, TaskManagerState>(
      listener: (context, state) {
        if (state.deleteTodoStates == RequestStates.loaded) {
          showToast(message: "Deleted Todo Success");
          context.read<TaskManagerBloc>().add(const ResetTodoStateEvent());
          TodosScreen.todos.clear();
          GetTodoParameters parameters = GetTodoParameters(limit: 10, skip: 0);
          context.read<TaskManagerBloc>().add(GetTodoEvent(parameters));
        } else if (state.deleteTodoStates == RequestStates.error) {
          showToast(message: state.message);
        }
        if (state.addTodoStates == RequestStates.loaded) {
          showToast(message: "Add Todo Success");
          context.read<TaskManagerBloc>().add(const ResetTodoStateEvent());
          GetTodoParameters parameters = GetTodoParameters(limit: 10, skip: 0);
          context.read<TaskManagerBloc>().add(GetTodoEvent(parameters));
          TodosScreen.todos.clear();
          todoController.clear();
          scaffoldKey.currentState!.showBottomSheet((context) {
            return const SizedBox();
          });
          TodosScreen.fetchData = false;
        } else if (state.addTodoStates == RequestStates.error) {
          showToast(message: state.message);
        }
      },
      builder: (context, state) {
        if (state.getTodoStates == RequestStates.loaded &&
            state.getTodoEntity != null) {
          TodosScreen.todos.addAll(state.getTodoEntity!.todos);
        }
        return Form(
          key: formKey,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                "Todo List",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
              ),
              centerTitle: true,
              forceMaterialTransparency: true,
            ),
            body: ConditionalBuilder(
              condition: state.getAllTodo &&
                  state.deleteTodoStates != RequestStates.loading,
              builder: (context) => Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: 6.h),
                      controller: _scrollController,
                      itemBuilder: (context, index) => TodoCardWidget(
                        todoID: TodosScreen.todos[index].todoID,
                        getTodosInformationEntity: TodosScreen.todos[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 1.h,
                      ),
                      itemCount: TodosScreen.todos.length,
                    ).animate().slideY(
                        begin: 1,
                        end: 0,
                        curve: const FlippedCurve(Curves.linear),
                        delay: const Duration(microseconds: 5000)),
                  ),
                  state.getTodoStates == RequestStates.loading &&
                          TodosScreen.fetchData
                      ? const CircularProgressIndicator()
                      : const SizedBox(),
                ],
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Add Todo",
              onPressed: () {
                scaffoldKey.currentState!.showBottomSheet((context) =>
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColors.black,
                                    )),
                                Text(
                                  'Create Todo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: TextFormField(
                                maxLines: 3,
                                selectionWidthStyle: BoxWidthStyle.tight,
                                selectionControls:
                                    MaterialTextSelectionControls(),
                                cursorColor: AppColors.greyColor,
                                cursorOpacityAnimates: true,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                controller: todoController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Todo';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Write Your Todo",
                                  hintStyle:
                                      const TextStyle(color: AppColors.grey),
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
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: WidthButton(
                                textButton: "Create your Todo Now!",
                                paddingSize: 4.w,
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();

                                    AddTodoParameters parameters =
                                        AddTodoParameters(
                                            todo: todoController.text,
                                            userID: AppConstants.userID!);
                                    context.read<TaskManagerBloc>().add(
                                          AddTodoEvent(parameters),
                                        );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
              backgroundColor: AppColors.primary,
              child: state.addTodoStates != RequestStates.loading
                  ? const Icon(
                      Icons.add,
                      color: AppColors.white,
                    )
                  : const CircularProgressIndicator(
                      color: AppColors.white,
                    ),
            ),
          ),
        );
      },
    );
  }
}
