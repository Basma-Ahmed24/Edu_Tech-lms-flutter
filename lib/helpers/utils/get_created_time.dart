import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

class CreatedTime {
  static String get(DateTime? createdAt, BuildContext context) {
    var currentTime = '';
    var diff = DateTime.now().difference(createdAt!);
    var days = DateTime.now().difference(createdAt).inDays;
    int diffYears = diff.inDays ~/ 365;
    int diffMonths = diff.inDays ~/ 30;
    int diffWeeks = diff.inDays ~/ 7;
    if (days <= 7) {
      var numb = days == 0 ? 1 : days;
      currentTime = '$numb ${"days".tr(context)}';
    }
    if (days >= 7) {
      currentTime = '$diffWeeks ${"weeks".tr(context)}';
    }
    if (days >= 30) {
      currentTime = '$diffMonths ${"month".tr(context)}';
    }
    if (days >= 365) {
      currentTime = '$diffYears ${"year".tr(context)}';
    }

    return currentTime;
  }
}
