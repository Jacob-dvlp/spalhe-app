import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeLight(context) => ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        brightness: Brightness.light,
        elevation: 1,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.grey[800],
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actionsIconTheme: IconTheme.of(context).copyWith(
          color: Colors.black,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey[200],
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Color(0xff009688),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Color(0xff009688),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: Color(0xff009688),
        ),
      ),
      hintColor: Colors.grey.withOpacity(0.4),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
      primaryColor: Color(0xff009688),
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.grey[800],
    );
