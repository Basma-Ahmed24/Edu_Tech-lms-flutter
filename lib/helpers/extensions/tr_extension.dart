import 'package:flutter/material.dart';

import '../utils/app_localization.dart';

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
