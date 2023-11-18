import 'package:flutter/material.dart';

export 'custom_theme.dart';

// Use Poppins for fontFamily
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Roboto',
    colorScheme: lightThemeColors(),
    primaryColor: lightThemeColors().primary,
    appBarTheme: AppBarTheme(
      // iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardTheme(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: lightThemeColors().primary,
    ),
    primaryIconTheme: IconThemeData(
      color: lightThemeColors().primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: lightThemeColors().primary,
    ),
    dialogTheme: DialogTheme(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

ColorScheme lightThemeColors() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff52b2fa),
    primaryContainer: Color(0x2052b2fa),
    onPrimary: Colors.white,
    secondary: Color(0xff33A7FF),
    onSecondary: Colors.white,
    error: Color(0xffcc0000),
    onError: Colors.white,
    background: Color(0xfff9f9f9),
    onBackground: Colors.black,
    surface: Color(0xfff2f2f2),
    onSurface: Colors.black,
  );
}
