import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spalhe/theme/colors.dart';

ThemeData themeLight(context) => ThemeData(
      primaryColor: primary,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      scaffoldBackgroundColor: ColorLight.background,
      cardColor: ColorDark.inverse,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: ColorLight.textColor,
        ),
        elevation: 1,
        titleTextStyle: TextStyle(
          color: ColorLight.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actionsIconTheme: IconTheme.of(context).copyWith(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      listTileTheme: ListTileTheme.of(context).copyWith(
        iconColor: Colors.black,
        tileColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: primary,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
        ),
      ),
      hintColor: Colors.grey.withOpacity(0.4),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        labelStyle: TextStyle(
          fontSize: 16,
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 2,
        unselectedItemColor: Colors.grey.shade400,
        selectedItemColor: Colors.grey.shade900,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      colorScheme: ColorScheme.light(
        primary: primary,
        background: ColorLight.background,
        error: Colors.redAccent,
        onBackground: ColorLight.background,
        onError: Colors.redAccent,
        brightness: Brightness.light,
      ).copyWith(background: ColorLight.background),
    );
