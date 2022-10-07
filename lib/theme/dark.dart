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
          foregroundColor: primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: primary,
          elevation: 1,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
        ),
      ),
      hintColor: Colors.white.withOpacity(0.4),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: Colors.white.withOpacity(0.6),
        floatingLabelStyle: TextStyle(color: Colors.white),
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
