import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF5722); // Orange for buttons
  static const Color secondaryColor =
      Color(0xFFFFCDD2); // Light pink for welcome
  static const Color backgroundGradientStart = Color(0xFFFF8A65);
  static const Color backgroundGradientEnd = Color(0xFFFF7043);
  static const Color textColorLight = Color(0xFFFFFFFF);
  static const Color textColorDark = Color(0xFF000000);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: textColorDark),
        bodyLarge: TextStyle(fontSize: 16, color: textColorLight),
        bodyMedium: TextStyle(fontSize: 14, color: textColorDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(textColorLight),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: textColorDark),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
