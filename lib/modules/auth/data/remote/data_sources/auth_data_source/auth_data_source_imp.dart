import 'package:dio/dio.dart';
import 'package:taskmanager_app/modules/auth/domain/parameters/auth_parameters.dart';

import '../../../../../../core/constants/apis_url.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/functions/functions.dart';
import '../../../../../../core/services/dio_services.dart';
import '../../../model/auth_model.dart';
import 'auth_data_source.dart';

class AuthDataSourceImp extends AuthDataSource {
  @override
  Future<AuthModel> login(AuthParameters parameters) async {
    try {
      final response = await DioServices().post(
          url: ApiUrls.login,
          data: parameters.toJson(),
          headers: {'Content-Type': 'application/json'});
      logger.d(response.data);

      return AuthModel.fromJson(response.data);
    } on DioException catch (error) {
      logger.d(
          "==================== Dio Exception ====================== \n ${error.toString()} \n ${error.response?.data}");
      throw Functions.exceptionsType(error);
    } catch (error) {
      logger.d(
          "================== Exception ======================  \n ${error.toString()} \n ${error.runtimeType}");
      if (error is TypeError) {
        throw ParsingException(parsingMessage: error.toString());
      }
      rethrow;
    }
  }
}
