import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_app/core/enums/request_states.dart';
import 'package:taskmanager_app/core/errors/failures.dart';
import 'package:taskmanager_app/modules/auth/domain/entity/auth_entity.dart';
import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';
import 'package:taskmanager_app/modules/auth/domain/use_cases/auth_usecase.dart';
import 'package:taskmanager_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager_app/modules/auth/presentation/bloc/auth_event.dart';

class MockAuthEntity extends AuthEntity {
  @override
  final String token;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  const MockAuthEntity({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  }) : super(
          id: id,
          username: username,
          email: email,
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          image: image,
          token: token,
        );
}

class MockAuthUseCase extends Mock implements AuthUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockAuthUseCase mockAuthUseCase;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    authBloc = AuthBloc(mockAuthUseCase);
  });

  test('_login success', () async {
    // Arrange
    final params = AuthParameters(
      userName: 'test_user',
      password: 'test_password',
    );
    const expectedResponse = MockAuthEntity(
      token: "token",
      id: 123, // Replace this with the actual ID value
      email: "email",
      firstName: "",
      gender: "",
      image: "",
      lastName: "",
      username: "",
    );
    when(mockAuthUseCase(params))
        .thenAnswer((_) async => const Right(expectedResponse));

    // Act
    authBloc.add(LoginPressedButtonEvent(params: params));
    await untilCalled(
        mockAuthUseCase(params)); // Ensure the mockAuthUseCase is called

    // Assert
    expect(authBloc.state.authStates, equals(RequestStates.loaded));
    expect(authBloc.state.message, isNull);
  });

  test('_login failure', () async {
    // Arrange
    final params = AuthParameters(
      userName: 'test_user',
      password: 'test_password',
    );
    const expectedFailure = Failure('Something went wrong');
    when(mockAuthUseCase(params))
        .thenAnswer((_) async => const Left(expectedFailure));

    // Act
    authBloc.add(LoginPressedButtonEvent(params: params));
    await untilCalled(
        mockAuthUseCase(params)); // Ensure the mockAuthUseCase is called

    // Assert
    expect(authBloc.state.authStates, equals(RequestStates.error));
    expect(authBloc.state.message, equals(expectedFailure.toString()));
  });
}
