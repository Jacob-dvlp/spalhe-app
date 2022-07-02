import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spalhe/theme/colors.dart';

ThemeData themeLight(context) => ThemeData(
      primaryColor: primary,
      primaryColorLight: Colors.white,
      primaryColorDark: ColorLight.textColor,
      scaffoldBackgroundColor: ColorLight.background,
      backgroundColor: ColorLight.white,
      colorScheme: ColorScheme.light(
        primary: primary,
        background: ColorLight.background,
        error: Colors.redAccent,
        onBackground: ColorLight.background,
        onError: Colors.redAccent,
        brightness: Brightness.light,
      ),
      cardColor: Colors.white,
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
      ),
      listTileTheme: ListTileTheme.of(context).copyWith(
        iconColor: Colors.black,
        tileColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: primary,
          elevation: 1,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: primary,
        ),
      ),
      hintColor: Colors.grey.withOpacity(0.4),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
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
    );
