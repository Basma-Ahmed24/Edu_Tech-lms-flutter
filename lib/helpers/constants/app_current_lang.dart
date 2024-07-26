import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider/cubits/save_it_cubit/save_it_cubit.dart';

class AppCurrentLang {
  static bool isEn(BuildContext context) {
    return SaveItCubit.get(context).getLang() == 'en' ? true : false;
  }
}
