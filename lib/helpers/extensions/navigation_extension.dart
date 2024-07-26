import 'package:flutter/material.dart';

extension XGo on String {
  go(context, {Object? arguments}) {
    return Navigator.pushNamed(
      context,
      this,
      arguments: arguments,
    );
  }

  goAndReplace(context, {Object? arguments}) {
    return Navigator.pushReplacementNamed(
      context,
      this,
      arguments: arguments,
    );
  }

  goAndReplaceAll(context, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      this,
          (route) => false,
      arguments: arguments,
    );
  }

  void goAndReplaceIfNotCurrent(context, {Object? arguments}) {
    if (!isCurrent(context)) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        this,
            (route) => false,
        arguments: arguments,
      );
    }
  }

  bool isCurrent(context) {
    bool isCurrent = false;
    Navigator.of(context).popUntil((route) {
      if (route.settings.name == this) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
