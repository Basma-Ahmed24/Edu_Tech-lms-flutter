import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';

class AppLocalHelper {
  static List<Locale> supportedLocales() {
    return const [
      Locale('en'),
      Locale('ar'),
    ];
  }

  static List<LocalizationsDelegate> localizationsDelegates() {
    return const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  static Locale? Function(Locale?, Iterable<Locale>)? resolutionCallback() {
    return (deviceLang, supportedLang) {
      for (Locale local in supportedLang) {
        if (deviceLang != null &&
            local.languageCode == deviceLang.languageCode) {
          return deviceLang;
        }
      }

      return supportedLang.first;
    };
  }
}
