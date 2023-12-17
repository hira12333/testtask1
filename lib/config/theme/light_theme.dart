import 'package:flutter/material.dart';
import 'package:test_task/constants/color.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kPrimaryColor,
  fontFamily: 'poppins',
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),
  splashColor: kSecondaryColor.withOpacity(0.10),
  highlightColor: kSecondaryColor.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kSecondaryColor.withOpacity(0.1),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kBlackColor,
  ),
);
