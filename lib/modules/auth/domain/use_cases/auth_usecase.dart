import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entity/auth_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase extends BaseUseCase<AuthEntity, AuthParameters> {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthParameters parameters) async {
    return await authRepository.login(parameters);
  }
}
