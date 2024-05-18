import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:taskmanager_app/core/constants/app_constants.dart';
import 'package:taskmanager_app/core/constants/app_keys.dart';
import 'package:taskmanager_app/core/enums/request_states.dart';
import 'package:taskmanager_app/core/services/cache_storage_services.dart';

import '../../domain/use_cases/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc(this.authUseCase) : super(const AuthState()) {
    on<LoginPressedButtonEvent>(_login);
  }

  FutureOr<void> _login(
      LoginPressedButtonEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStates: RequestStates.loading));
    final result = await authUseCase(event.params);
    result.fold(
      (l) => emit(
          state.copyWith(authStates: RequestStates.error, message: l.message)),
      (r) {
        AppKeys.userToken = r.token;
        AppConstants.userID = r.id;
        CacheHelper.saveData(key: "userToken", value: r.token);
        CacheHelper.saveData(key: "userID", value: r.id);
        emit(state.copyWith(authStates: RequestStates.loaded));
      },
    );
  }
}
