import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

class ValidationState {
  static String? emailChecker(String? value, BuildContext context) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    String? message;
    if (value!.isEmpty) {
      message = 'validate_email'.tr(context);
      return message;
    }
    if (!regExp.hasMatch(value)) {
      message = 'validate_email'.tr(context);
    }

    return message;
  }

  static String? validateName(String value, BuildContext context) {
    // var english = RegExp(r'[a-zA-Z]');

    String? message;
    if (value.isEmpty) {
      message = 'validate_name'.tr(context);
    }
    else {
      List<String> words = value.trim().split(' ');
      if (words.length != 3) {
        message = 'ادخل اسمك ثلاثي';
      }
    }

    return message;
  }

  static String? validatePhoneNumber(String? value, BuildContext context) {
    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
    RegExp regExp = RegExp(pattern);

    String? message;
    if (value!.isEmpty) {
      message = 'validate_phone'.tr(context);
      return message;
    }
    if (!regExp.hasMatch(value)) {
      message = 'validate_phone'.tr(context);
    }

    return message;
  }

  static String? validatePassword(String? value, BuildContext context) {
    String? message;
    if (value!.isEmpty) {
      message = 'validate_password'.tr(context);
    } else if (value.length < 8) {
      message = 'validate_password_too_short'.tr(context);
    }
    return message;
  }

  static String? confirmPassword(
    String? value,
    String? matchWith,
    String? mainMatchWith,
    BuildContext context,
  ) {
    String? message;
    if (value!.isEmpty) {
      message = 'validate_password'.tr(context);
    } else if (value.length < 8) {
      message = 'validate_password_too_short'.tr(context);
    } else if (mainMatchWith != matchWith) {
      message = 'not_matched'.tr(context);
    }
    return message;
  }
}
