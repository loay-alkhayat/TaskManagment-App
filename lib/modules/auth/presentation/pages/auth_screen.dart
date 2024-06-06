import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanager_app/core/assets_paths/app_png_paths.dart';
import 'package:taskmanager_app/core/enums/request_states.dart';
import 'package:taskmanager_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager_app/modules/auth/presentation/bloc/auth_event.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../core/components/show_toast.dart';
import '../../../../core/components/width_button.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../task_manager/presentation/pages/todos_screen.dart';
import '../../domain/parameters/auth_parameters.dart';
import '../bloc/auth_state.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final TextEditingController _userNameController =
      TextEditingController(text: "kminchelle");
  final TextEditingController _passwordController =
      TextEditingController(text: "0lelplR");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: AppColors.primary,
          resizeToAvoidBottomInset: true,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Image.asset(
                  pngPaths.loginVector,
                  height: 55.h,
                ),
              ),
              Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w),
                    ),
                    color: AppColors.white),
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: AppColors.primary, fontSize: 22.sp),
                      ),
                      Text(
                        "finally you can manage your Task here",
                        style:
                            TextStyle(color: AppColors.grey, fontSize: 15.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 3.h),
                        child: TextFormField(
                          selectionWidthStyle: BoxWidthStyle.tight,
                          selectionControls: MaterialTextSelectionControls(),
                          cursorColor: AppColors.greyColor,
                          cursorOpacityAnimates: true,
                          textInputAction: TextInputAction.next,
                          controller: _userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Write Your username",
                              hintStyle: const TextStyle(color: AppColors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.w),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors.lightGrey,
                              filled: true),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: StatefulBuilder(
                          builder: (context, setState) => TextFormField(
                            selectionWidthStyle: BoxWidthStyle.tight,
                            selectionControls: MaterialTextSelectionControls(),
                            cursorColor: AppColors.greyColor,
                            cursorOpacityAnimates: true,
                            obscureText: obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Password';
                              } else if (value.length != 7) {
                                return 'Password must be 7 digits ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Write Your Password",
                                hintStyle:
                                    const TextStyle(color: AppColors.grey),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword = !obscurePassword;
                                      });
                                    },
                                    icon: obscurePassword
                                        ? const Icon(
                                            Icons.visibility,
                                            color: AppColors.grey,
                                          )
                                        : const Icon(Icons.visibility_off,
                                            color: AppColors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.w),
                                    borderSide: BorderSide.none),
                                fillColor: AppColors.lightGrey,
                                filled: true),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.authStates == RequestStates.loaded) {
                            Functions.navigatorPushAndRemove(
                                context, const TodosScreen());
                          }
                          if (state.authStates == RequestStates.error) {
                            showToast(message: state.message);
                          }
                        },
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition:
                                state.authStates != RequestStates.loading,
                            builder: (context) => WidthButton(
                              textButton: "Login",
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  AuthParameters parameters = AuthParameters(
                                    userName: _userNameController.text,
                                    password: _passwordController.text,
                                  );

                                  context.read<AuthBloc>().add(
                                        LoginPressedButtonEvent(
                                            params: parameters),
                                      );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
