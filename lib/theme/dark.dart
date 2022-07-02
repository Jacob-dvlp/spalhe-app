import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spalhe/theme/colors.dart';

ThemeData themeDark(context) => ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 1,
        actionsIconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: ColorDark.background,
      cardColor: Color.fromARGB(255, 19, 19, 19),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: primary,
          elevation: 1,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: primary,
        ),
      ),
      backgroundColor: Colors.black,
      hintColor: Colors.white.withOpacity(0.4),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      listTileTheme: ListTileTheme.of(context).copyWith(
        iconColor: Colors.white,
        tileColor: Colors.white.withOpacity(
          0.08,
        ),
      ),
      primaryColor: primary,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        selectedItemColor: primary,
        backgroundColor: Color.fromARGB(255, 18, 18, 18),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
