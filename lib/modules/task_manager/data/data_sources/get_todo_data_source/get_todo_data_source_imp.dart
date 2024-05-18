import 'package:dio/dio.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/get_todo_parameters.dart';

import '../../../../../core/constants/apis_url.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/functions/functions.dart';
import '../../../../../core/services/dio_services.dart';
import '../../models/get_todo_model.dart';
import 'get_todo_data_source.dart';

class GetTodoDataSourceImp extends GetTodoDataSource {
  @override
  Future<GetTodoModel> getTodo(GetTodoParameters parameters) async {
    try {
      final response = await DioServices().get(
        url:
            "${ApiUrls.getTodos}?limit=${parameters.limit}&skip=${parameters.skip}",
      );
      logger.d(response.data);

      return GetTodoModel.fromJson(response.data);
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
