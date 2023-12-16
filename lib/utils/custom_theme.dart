import 'package:flutter/material.dart';

export 'custom_theme.dart';

// Use Poppins for fontFamily
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: lightThemeColors(),
    primaryColor: lightThemeColors().primary,
    scaffoldBackgroundColor: lightThemeColors().background,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: textTheme().displayMedium?.copyWith(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
    ),
    cardTheme: CardTheme(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Color(0xffffffff),
      // surfaceTintColor: Color(0xffffffff),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: lightThemeColors().primary),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: textTheme().bodyMedium?.copyWith(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        backgroundColor: lightThemeColors().primaryContainer,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
      suffixIconColor: lightThemeColors().primary,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightThemeColors().primary),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightThemeColors().error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightThemeColors().primary),
      ),
      labelStyle: textTheme().bodySmall!.copyWith(
            color: lightThemeColors().onSurface,
          ),
      floatingLabelStyle: textTheme().bodySmall!.copyWith(
            color: lightThemeColors().primary,
          ),
      hintStyle: textTheme().bodySmall!,
    ),
    dialogTheme: DialogTheme(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actionsPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      elevation: 4,
      showCloseIcon: true,
      backgroundColor: lightThemeColors().primary,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    textTheme: textTheme(),
    tabBarTheme: TabBarTheme(
      labelColor: lightThemeColors().secondary,
      unselectedLabelColor: lightThemeColors().onSurfaceVariant,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.grey[300],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightThemeColors().primary,
    ),
    popupMenuTheme: PopupMenuThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[400],
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 4,
      constraints: BoxConstraints.expand(),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme().bodyMedium,
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
    tertiary: Color(0xff0083FF),
    error: Color(0xffcc0000),
    onError: Colors.white,
    background: Color(0xfff9f9f9),
    onBackground: Colors.black,
    surface: Color(0xfff2f2f2),
    onSurface: Color(0xff101014),
    onSurfaceVariant: Color(0xff38484F),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    // For large texts
    displayLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 56,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    // For medium texts
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
    ),
    //For subtitles
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.grey,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Colors.grey,
    ),
  );
}
