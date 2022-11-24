import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spalhe/theme/colors.dart';

ThemeData themeDark(context) => ThemeData(
      appBarTheme: AppBarTheme(
        color: ColorDark.cardColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 1,
        actionsIconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      scaffoldBackgroundColor: ColorDark.background,
      cardColor: ColorDark.cardColor,
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
      colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: primary,
      ),
      hintColor: Colors.white.withOpacity(0.4),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey.withOpacity(0.14),
        iconColor: Colors.white.withOpacity(0.6),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        labelStyle: TextStyle(
          fontSize: 16,
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
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
      primaryColorLight: ColorDark.cardColor,
      primaryColorDark: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20,
        unselectedItemColor: Colors.white.withOpacity(0.2),
        selectedItemColor: primary,
        backgroundColor: ColorDark.cardColor,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
