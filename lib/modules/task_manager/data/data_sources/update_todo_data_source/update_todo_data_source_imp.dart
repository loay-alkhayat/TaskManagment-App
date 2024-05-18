import 'package:dio/dio.dart';
import 'package:taskmanager_app/modules/task_manager/data/data_sources/update_todo_data_source/update_todo_data_source.dart';

import '../../../../../core/constants/apis_url.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/functions/functions.dart';
import '../../../../../core/services/dio_services.dart';
import '../../../domain/parameters/update_todo_parameters.dart';
import '../../models/update_todo_model.dart';

class UpdateTodoDataSourceImp extends UpdateTodoDataSource {
  @override
  Future<UpdateTodoModel> updateTodo(UpdateTodoParameters parameters) async {
    try {
      final response = await DioServices().put(
          url: "${ApiUrls.updateTodo}${parameters.todoID}",
          data: parameters.toJson());
      logger.d(response.data);

      return UpdateTodoModel.fromJson(response.data);
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
