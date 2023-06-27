import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightMode = ThemeData(
  snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFFE8E8E8),
      contentTextStyle: TextStyle(color: Colors.black)),
  brightness: Brightness.light,
  primaryColor: Color(0xFF2196F3),
  cardColor: Color(0xFFEDEDED),
  highlightColor: Color(0xFFBBDEFB),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontSize: 15,
      letterSpacing: 0.5,
      fontStyle: GoogleFonts.montserrat().fontStyle,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFFE8E8E8),
  ),
);

final darkMode = ThemeData(
  snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF424242),
      contentTextStyle: TextStyle(color: Colors.white)),
  brightness: Brightness.dark,
  primaryColor: Color(0xFFBC85FD),
  cardColor: Color(0xFF575757),
  highlightColor: Color(0xFFBC85FD),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
        letterSpacing: 0.5,
        fontStyle: GoogleFonts.montserrat().fontStyle,
        fontSize: 15),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFF424242),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFBC85FD),
      ),
    ),
  ),
);
