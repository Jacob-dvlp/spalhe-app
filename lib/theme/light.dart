import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spalhe/theme/colors.dart';

ThemeData themeLight(context) => ThemeData.light().copyWith(
      primaryColor: ColorLight.primary,
      primaryColorLight: Colors.white,
      primaryColorDark: ColorLight.textColor,
      //
      scaffoldBackgroundColor: ColorLight.background,
      //
      colorScheme: ColorScheme.light(
        primary: ColorLight.primary,
        background: ColorLight.background,
        error: Colors.redAccent,
        onBackground: ColorLight.background,
        onError: Colors.redAccent,
        brightness: Brightness.light,
      ),
      //
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: ColorLight.textColor,
        ),
        elevation: 3,
        titleTextStyle: TextStyle(
          color: ColorLight.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actionsIconTheme: IconTheme.of(context).copyWith(
          color: Colors.black,
        ),
      ),
      //
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: ColorLight.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: ColorLight.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: ColorLight.primary,
        ),
      ),
      hintColor: Colors.grey.withOpacity(0.4),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorLight.primary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorLight.primary,
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
    );
