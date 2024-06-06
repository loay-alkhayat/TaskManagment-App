import 'package:dio/dio.dart';
import 'package:taskmanager_app/modules/task_manager/domain/parameters/add_todo_parameters.dart';

import '../../../../../core/constants/apis_url.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/functions/functions.dart';
import '../../../../../core/services/dio_services.dart';
import '../../models/add_todo_model.dart';
import 'add_todo_data_source.dart';

class AddTodoDataSourceImp implements AddTodoDataSource {
  @override
  Future<AddTodoModel> addTodo(AddTodoParameters parameters) async {
    try {
      final response = await DioServices()
          .post(url: ApiUrls.createTodo, data: parameters.toJson());
      logger.d(response.data);

      return AddTodoModel.fromJson(response.data);
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
