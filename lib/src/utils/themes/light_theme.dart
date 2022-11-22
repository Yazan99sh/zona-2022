import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLightTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}
