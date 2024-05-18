import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';

import '../../../model/auth_model.dart';

abstract class AuthDataSource {
  Future<AuthModel> login(AuthParameters parameters);
}
