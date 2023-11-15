import 'package:flutter/material.dart';

export 'custom_theme.dart';

// Use Poppins for fontFamily
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  cardTheme: CardTheme(
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);
