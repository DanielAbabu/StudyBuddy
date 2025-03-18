import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppConstants.primaryBlue,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(
      primary: AppConstants.lightBlue,
      secondary: AppConstants.secondaryBlue,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConstants.primaryBlue,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.primaryBlue,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28,
        fontWeight: FontWeight.bold, // Maps to Poppins-Bold.ttf
        color: AppConstants.primaryBlue,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppConstants.primaryBlue,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w600, // Maps to Poppins-SemiBold.ttf
        color: Color.fromARGB(255, 66, 66, 66),
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 66, 66, 66),
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 70, 70, 70),
      ),
      bodyLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        fontWeight: FontWeight.normal, // Maps to OpenSans-Regular.ttf
        color: Color.fromARGB(255, 66, 66, 66),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color.fromARGB(255, 122, 122, 122),
      ),
      labelLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        fontWeight: FontWeight.w700, // Maps to OpenSans-Bold.ttf
        color: Colors.white,
      ),
    ),
    fontFamily: 'Poppins', // Default font family
  );
}
