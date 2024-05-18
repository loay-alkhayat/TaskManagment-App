import 'package:equatable/equatable.dart';
import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginPressedButtonEvent extends AuthEvent {
  final AuthParameters params;
  const LoginPressedButtonEvent({required this.params});
}
