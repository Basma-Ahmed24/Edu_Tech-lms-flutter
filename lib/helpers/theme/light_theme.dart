import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

ThemeData light = ThemeData(
  primaryColor: AppColors.mainAppColor,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    },
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.mainAppColor,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.white,
  ).copyWith(background: Colors.white),
);
