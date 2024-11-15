import 'package:flutter/material.dart';

const Color customPrimaryColor = Color.fromARGB(237, 8, 67, 125);
const Color customSecondaryColor = Color(0xFF42A5F5);
const Color customAccentColor = Color(0xFF4F87DB);
const Color customBackground = Color(0xDFEDF9FF);
const Color customTextColor = Color(0xFF212121);
const Color customHintColor = Color(0xFF757575);
const Color customCardColor = Color(0xC0F5F8FC);

class AppTheme {
  final bool isDarkmode;

  AppTheme({
    this.isDarkmode = false,
  });

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        primaryColor: customPrimaryColor,
        scaffoldBackgroundColor: isDarkmode ? Colors.black : customBackground,
        colorScheme: ColorScheme(
          brightness: isDarkmode ? Brightness.dark : Brightness.light,
          primary: customPrimaryColor,
          onPrimary: Colors.white,
          secondary: customSecondaryColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: isDarkmode ? Colors.black : customBackground,
          onBackground: isDarkmode ? Colors.white : customTextColor,
          surface: isDarkmode ? Colors.grey.shade800 : Colors.white,
          onSurface: isDarkmode ? Colors.white : customTextColor,
        ),

        //* AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkmode ? Colors.black : customPrimaryColor,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),

        //* Filled Button Theme
        filledButtonTheme: FilledButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            backgroundColor: customPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),

        //* FloatingActionButton Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: customSecondaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),

        //* Card Theme
        cardColor: isDarkmode ? Colors.grey.shade800 : Colors.white,
        cardTheme: CardTheme(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
        ),

        //* Text Inputs
        inputDecorationTheme: _inputDecorations,

        //* Dropdown Menu Theme
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: _inputDecorations,
          textStyle: const TextStyle(color: customTextColor),
        ),

        //* Text Theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: customTextColor,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: customTextColor,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: customTextColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: customHintColor,
          ),
        ),
      );

  final _inputDecorations = InputDecorationTheme(
    fillColor: customBackground,
    filled: true,
    hintStyle: const TextStyle(color: customHintColor),
    labelStyle: const TextStyle(color: customTextColor),
    enabledBorder: buildBorderColor(customPrimaryColor),
    focusedBorder: buildBorderColor(customPrimaryColor),
    border: buildBorderColor(customAccentColor),
  );

  static OutlineInputBorder buildBorderColor(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(
        color: borderColor,
        width: 1.5,
      ),
    );
  }
}
