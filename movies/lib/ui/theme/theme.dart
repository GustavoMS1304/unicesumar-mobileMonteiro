import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const screenBackground = Color(0xFF111111);
const searchBarBackground = Color(0xFF1E1E1E);
const primaryButton = Color(0xFFD9D9D9);
const posterBorder = Color(0xFFB5A9A9);
const buttonGrey = Color(0xFF504F4F);

var roboto = GoogleFonts.roboto();

var largeTitle = roboto.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var heading1 = roboto.copyWith(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var heading2 = roboto.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var body1Regular = roboto.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body1Bold = roboto.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var body2Regular = roboto.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body2Bold = roboto.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var caption = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body3Regular = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body3Bold = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var verySmallText = roboto.copyWith(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

TextTheme buildTextTheme(Color textColor) {
  final base = GoogleFonts.roboto();
  return Typography.material2021().englishLike.copyWith(
        headlineLarge: base.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        headlineMedium: base.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        headlineSmall: base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        titleLarge: base.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleMedium: base.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleSmall: base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        bodyLarge: base.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        bodyMedium: base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        bodySmall: base.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        labelLarge: base.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        labelMedium: base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        labelSmall: base.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      );
}

ThemeData createDarkTheme() {
  final textTheme = buildTextTheme(Colors.white);
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: screenBackground,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.dark(
      background: screenBackground,
      surface: Color(0xFF1E1E1E),
      primary: Colors.white,
      onPrimary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: searchBarBackground,
      labelTextStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: Colors.white);
        }
        return const TextStyle(color: posterBorder);
      }),
      iconTheme: WidgetStateProperty.all<IconThemeData>(
        const IconThemeData(color: Colors.white),
      ),
      indicatorColor: posterBorder,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: searchBarBackground,
      selectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(color: Colors.black),
      showUnselectedLabels: true,
      unselectedItemColor: posterBorder,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: searchBarBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: posterBorder),
    ),
  );
}

ThemeData createLightTheme() {
  final textTheme = buildTextTheme(Colors.black);
  const lightSurface = Color(0xFFF2F2F2);
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.light(
      background: Colors.white,
      surface: lightSurface,
      primary: Colors.black,
      onPrimary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      labelTextStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: Colors.black);
        }
        return const TextStyle(color: Colors.grey);
      }),
      iconTheme: WidgetStateProperty.all<IconThemeData>(
        const IconThemeData(color: Colors.black),
      ),
      indicatorColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.grey),
    ),
  );
}

