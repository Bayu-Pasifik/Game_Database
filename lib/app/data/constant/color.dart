import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color darkTheme = const Color(0xff01090E);
Color whiteTheme = const Color.fromARGB(255, 223, 237, 246);
Color buttonColor = const Color(0xff71D487);
Color darkTextColor = const Color.fromARGB(255, 250, 251, 252);
Color whiteThemeText = const Color.fromARGB(255, 34, 36, 38);
Color boxColor = const Color.fromARGB(255, 56, 58, 56);
Color whiteBox = const Color.fromARGB(255, 150, 195, 247);

ThemeData themeDark = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.amber,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(color: darkTextColor),
      bodyLarge: GoogleFonts.poppins(color: darkTextColor),
      bodyMedium: GoogleFonts.poppins(color: darkTextColor),
      bodySmall: GoogleFonts.poppins(color: darkTextColor),
      displayMedium: GoogleFonts.poppins(color: darkTextColor),
      displaySmall: GoogleFonts.poppins(color: darkTextColor),
      headlineLarge: GoogleFonts.poppins(color: darkTextColor),
      headlineMedium: GoogleFonts.poppins(color: darkTextColor),
      headlineSmall: GoogleFonts.poppins(color: darkTextColor),
      labelLarge: GoogleFonts.poppins(color: darkTextColor),
      labelMedium: GoogleFonts.poppins(color: darkTextColor),
      labelSmall: GoogleFonts.poppins(color: darkTextColor),
      titleLarge: GoogleFonts.poppins(color: darkTextColor),
      titleMedium: GoogleFonts.poppins(color: darkTextColor),
      titleSmall: GoogleFonts.poppins(color: darkTextColor),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: const Color(0XFF858597),
      indicatorColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: buttonColor,
      ),
    ),
    scaffoldBackgroundColor: darkTheme);

ThemeData themeWhite = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.amber,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(color: whiteThemeText),
      bodyLarge: GoogleFonts.poppins(color: whiteThemeText),
      bodyMedium: GoogleFonts.poppins(color: whiteThemeText),
      bodySmall: GoogleFonts.poppins(color: whiteThemeText),
      displayMedium: GoogleFonts.poppins(color: whiteThemeText),
      displaySmall: GoogleFonts.poppins(color: whiteThemeText),
      headlineLarge: GoogleFonts.poppins(color: whiteThemeText),
      headlineMedium: GoogleFonts.poppins(color: whiteThemeText),
      headlineSmall: GoogleFonts.poppins(color: whiteThemeText),
      labelLarge: GoogleFonts.poppins(color: whiteThemeText),
      labelMedium: GoogleFonts.poppins(color: whiteThemeText),
      labelSmall: GoogleFonts.poppins(color: whiteThemeText),
      titleLarge: GoogleFonts.poppins(color: whiteThemeText),
      titleMedium: GoogleFonts.poppins(color: whiteThemeText),
      titleSmall: GoogleFonts.poppins(color: whiteThemeText),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: const Color(0XFF858597),
      indicatorColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: whiteBox,
      ),
    ),
    scaffoldBackgroundColor: whiteTheme);
