import 'package:equatable/equatable.dart';
import 'package:taskmanager_app/modules/auth/domain/entity/auth_entity.dart';

import '../../../../core/enums/request_states.dart';

class AuthState extends Equatable {
  final RequestStates authStates;
  final String message;
  final AuthEntity? authEntity;

  const AuthState({
    this.message = "",
    this.authStates = RequestStates.initial,
    this.authEntity,
  });

  AuthState copyWith(
      {RequestStates? authStates, String? message, AuthEntity? authEntity}) {
    return AuthState(
        authStates: authStates ?? this.authStates,
        message: message ?? this.message,
        authEntity: authEntity ?? this.authEntity);
  }

  @override
  List<Object?> get props => [authStates, message, authEntity];
}
