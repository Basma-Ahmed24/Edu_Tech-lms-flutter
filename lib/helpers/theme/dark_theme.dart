import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

ThemeData dark = ThemeData(
  primaryColor: AppColors.mainAppColor,
  scaffoldBackgroundColor: AppColors.scaffoldBlack,
  brightness: Brightness.dark,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    },
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.mainAppColor,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.white,
    onSurface: Colors.white,
  ),
);
