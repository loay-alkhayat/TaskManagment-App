import 'package:dartz/dartz.dart';
import 'package:taskmanager_app/modules/auth/domain/entity/auth_entity.dart';
import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';

import '../../../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(AuthParameters parameters);
}
