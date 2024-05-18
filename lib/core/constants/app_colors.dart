import 'package:flutter/material.dart';

class AppColors {
  // TODO : ADD YOUR COLORS HERE
  static const Color blue = Colors.blue;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color white = Colors.white;
  static const Color yellow = Colors.yellow;
  static const Color purple = Colors.purple;
  static const Color indigo = Colors.indigo;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  static const Color primary = Color(0xFF55aaff);
  static const Color secondary = Color(0xFF3b9dff);
  static const Color greyColor = Color(0xFF707070);
  static const Color greyAccent = Color(0xFFF5FAF5);
  static const Color grey1 = Color(0x99A9B2B9);
  static Color? lightGrey = Colors.grey[100];

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
