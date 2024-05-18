import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager_app/core/extensions/dio_exception_type_extension.dart';

import '../errors/error_message_model.dart';
import '../errors/exceptions.dart';

class Functions {
  static void navigatorPush({
    required BuildContext context,
    required Widget screenNameToNavigate,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Transform.translate(
              offset: Offset(0, animation.value), // Adjust as needed
              child: screenNameToNavigate,
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastLinearToSlowEaseIn;
          var offsetAnimation = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve))
              .animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static void navigatorPushAndRemove(
      BuildContext context, Widget screenNameToNavigate) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: screenNameToNavigate,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var offsetAnimation = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve))
              .animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  static Exception exceptionsType(DioException error) {
    if (error.isForbidden) {
      return const ForbiddenException();
    } else if (error.isBadRequest) {
      return const BadRequestException();
    } else if (error.isUnAuthorized) {
      return const UnAuthorizedException();
    } else if (error.isInternalServerError) {
      return const InternalServerErrorException();
    } else if (error.isNoInternetConnection) {
      return const NoInternetConnectionException();
    } else if (error.isNotFound) {
      return const NotFoundException();
    } else if (error.isNoContent) {
      return const NoContentException();
    } else if (error.response != null) {
      return ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(
          error.response?.data,
        ),
      );
    } else {
      return UnknownException();
    }
  }
}
