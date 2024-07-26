import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/tr_extension.dart';

class GetUserYear {
  static String get(BuildContext context, String value) {
    var currentValue = '';
    if (value == 'first') {
      currentValue = 'high_school_first_grade'.tr(context);
    }
    if (value == 'second') {
      currentValue = 'high_school_second_grade'.tr(context);
    }
    if (value == 'third') {
      currentValue = 'high_school_third_grade'.tr(context);
    }
    return currentValue;
  }
}

class GetUserSpecialization {
  static String get(BuildContext context, String value) {
    var currentValue = '';
    if (value == 'math') {
      currentValue = 'math'.tr(context);
    }
    if (value == 'science') {
      currentValue = 'science'.tr(context);
    }
    if (value == 'literary') {
      currentValue = 'literary'.tr(context);
    }

    return currentValue.isEmpty ? value : currentValue;
  }
}

List<String> egyCitysList = [];

Future<String> getTheCityInEnglish(
    BuildContext context, String thevalue) async {
  var currentValue = '';
  final String response =
      await rootBundle.loadString('assets/egycitys/citys.json');
  var data = json.decode(response);
  for (var v in data) {
    if (v['governorate_name_ar'] == thevalue) {
      currentValue = v['governorate_name_en'];
    }
  }
  return currentValue;
}

Future<String> getTheCityInArabic(BuildContext context, String thevalue) async {
  var currentValue = '';
  final String response =
      await rootBundle.loadString('assets/egycitys/citys.json');
  var data = json.decode(response);
  for (var v in data) {
    if (v['governorate_name_en'] == thevalue) {
      currentValue = v['governorate_name_ar'];
    }
  }
  return currentValue;
}

class GetUserCity {
  static Future<String> get(BuildContext context, String value) async {
    var currentValue = await getTheCityInEnglish(context, value);
    return currentValue.isEmpty ? value : currentValue;
  }
}

class GetUserCityInArabic {
  static Future<String> get(BuildContext context, String value) async {
    var currentValue = await getTheCityInArabic(context, value);
    return currentValue.isEmpty ? value : currentValue;
  }
}
