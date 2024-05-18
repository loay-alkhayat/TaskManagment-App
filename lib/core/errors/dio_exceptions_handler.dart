// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
// import 'package:mediclica/core/enums/data_source.dart';
// import 'package:mediclica/core/extensions/dio_exception_type_extension.dart';
//
// import 'error_message_model.dart';
// import 'exceptions.dart';
// import 'failures.dart';
//
// var logger = Logger();
//
// class DioExceptionHandler {
//
//   Failure _handleError(DioException error) {
//     switch (error) {
//       case error.isForbidden:
//         return DataSource.CONNECT_TIMEOUT.getFailure();
//       case DioExceptionType.sendTimeout:
//         return DataSource.SEND_TIMEOUT.getFailure();
//       case DioExceptionType.receiveTimeout:
//         return DataSource.RECIEVE_TIMEOUT.getFailure();
//       case DioExceptionType.badResponse:
//         if (error.response != null &&
//             error.response?.statusCode != null &&
//             error.response?.statusMessage != null) {
//           return Failure(error.response?.statusCode ?? 0,
//               error.response?.statusMessage ?? "");
//         } else {
//           return DataSource.DEFAULT.getFailure();
//         }
//       case DioExceptionType.cancel:
//         return DataSource.CANCEL.getFailure();
//       default:
//         return DataSource.DEFAULT.getFailure();
//     }
//   }
//   static  error(DioException error){
//     logger.e("=================== Dio Exception ======================== \n ${error.toString()} \n ${error.response?.data}");
//     if(error.response != null) {
//       throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(error.response?.data));
//     }
//     if(error.response == null){
//       throw const NoInternetConnectionException();
//     }
//   }
// }
