import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/constants/app_colors.dart';

void showToast({
  required String message,
  Color? color,
  Color? textColor,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color ?? AppColors.white,
    textColor: textColor ?? AppColors.black,
    fontSize: 14,
  );
}
