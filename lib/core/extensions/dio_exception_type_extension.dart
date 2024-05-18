import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/response_code.dart';

extension DioExceptionTypee on DioException {
  bool get isNoInternetConnection => error is SocketException;

  bool get isNoContent => response?.statusCode == ResponseCode.NO_CONTENT;

  bool get isUnAuthorized => response?.statusCode == ResponseCode.UNAUTHORIZED;

  bool get isBadRequest => response?.statusCode == ResponseCode.BAD_REQUEST;

  bool get Unprocessable_Content =>
      response?.statusCode == ResponseCode.Unprocessable_Content;

  bool get isForbidden => response?.statusCode == ResponseCode.FORBIDDEN;

  bool get isInternalServerError =>
      response?.statusCode == ResponseCode.INTERNAL_SERVER_ERROR;

  bool get isNotFound => response?.statusCode == ResponseCode.NOT_FOUND;

  bool get isServerUnAvailable =>
      response?.statusCode == ResponseCode.SERVER_UNAVAILABLE;
}
