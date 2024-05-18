import 'package:dio/dio.dart';

import '../../../../../core/constants/apis_url.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/functions/functions.dart';
import '../../../../../core/services/dio_services.dart';
import '../../../domain/parameters/delete_todo_parameters.dart';
import '../../models/delete_todo_model.dart';
import 'delete_todo_data_source.dart';

class DeleteTodoDataSourceImp extends DeleteTodoDataSource {
  @override
  Future<DeleteTodoModel> deleteTodo(DeleteTodoParameters parameters) async {
    try {
      final response = await DioServices().deleteData(
        url: "${ApiUrls.deleteTodo}${parameters.todoID}",
      );
      logger.d(response.data);

      return DeleteTodoModel.fromJson(response.data);
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
