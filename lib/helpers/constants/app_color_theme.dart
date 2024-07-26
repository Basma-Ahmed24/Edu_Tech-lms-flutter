import 'package:flutter/material.dart';

import '../provider/cubits/save_it_cubit/save_it_cubit.dart';
import 'app_colors.dart';
import 'app_saved_key.dart';

class AppColorTheme {
  static Color bottomNavigationBarTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? AppColors.softBlack
        : Colors.grey.shade100;
  }

  static Color blackAndWhiteSwitchTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? Colors.white
        : Colors.black;
  }

  static Color blackAndWhiteTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? Colors.black
        : Colors.white;
  }

  static Color containerTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? const Color(0xff1B1B1B)
        : Colors.white;
  }

  static Color homeFilterAndSearchBgTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? const Color(0xff1B1B1B)
        : Colors.grey.shade200;
  }

  static Color shadowTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? Colors.white.withOpacity(0.1)
        : Colors.black.withOpacity(0.1);
  }

  static Color lightGreenTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? const Color(0xff1B1B1B)
        : AppColors.subMainAppColor;
  }

  static Color scaffoldTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? AppColors.scaffoldBlack
        : Colors.white;
  }

  static Color grayTextColorTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? Colors.grey.shade400
        : AppColors.grayTextColor;
  }

  static Color bestSellerBgColorTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? const Color(0xff017374)
        : AppColors.bestSellerBgColor;
  }

  static Color mainColorAndWhiteTextTheme(BuildContext context) {
    return SaveItCubit.get(context).getBool(AppSavedKey.isDarkMode)
        ? Colors.white
        : AppColors.mainAppColor;
  }
}
