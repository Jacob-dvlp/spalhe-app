import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeDark(context) => ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.grey[900],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        brightness: Brightness.dark,
        elevation: 1,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actionsIconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      ),
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
      hintColor: Colors.white.withOpacity(0.3),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white.withOpacity(0.1),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      fixTextFieldOutlineLabel: true,
      primaryColor: Color(0xff009688),
      primaryColorLight: Colors.grey[900],
      primaryColorDark: Colors.white,
    );
