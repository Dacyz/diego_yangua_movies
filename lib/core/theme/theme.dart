import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
    buttonTheme: CustomTheme.buttonTheme,
    elevatedButtonTheme: CustomTheme.elevatedButtonTheme,
    outlinedButtonTheme: CustomTheme.outlinedButtonTheme,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    floatingActionButtonTheme: CustomTheme.floatingActionButtonTheme,
    inputDecorationTheme: CustomTheme.inputDecorationTheme,
  );

  static const floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: Decorations.kPrimaryColor,
    foregroundColor: Colors.white,
  );

  static const buttonTheme = ButtonThemeData(
    buttonColor: Colors.blueGrey,
    colorScheme: ColorScheme.dark(primary: Colors.blueGrey),
    textTheme: ButtonTextTheme.primary,
  );

  static const inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white),
    activeIndicatorBorder: BorderSide(color: Colors.white),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    labelStyle: TextStyle(color: Colors.white),
  );

  static const elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Decorations.kPrimaryColor),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(Colors.black12),
    ),
  );

  static const outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      shadowColor: WidgetStatePropertyAll(Colors.white),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(Decorations.kPrimaryColor),
    ),
  );
}
