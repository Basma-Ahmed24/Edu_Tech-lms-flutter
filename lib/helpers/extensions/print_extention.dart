import 'package:flutter/material.dart';

extension PrintX on String? {
  get dePrint {
    debugPrint(this);
  }
}