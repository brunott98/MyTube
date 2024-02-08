import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.black;
  static const Color accentColor1 = Color(0xffFF0000);
  static const Color accentColor2 = Color(0xffFF2E2E);
  static const Color textColor = Colors.white;
  static const Color textShadowColor = Colors.black;
  static const Color appBarColor = Colors.black87;
}

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(

        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(

        ),
      ),
    );
  }
}
