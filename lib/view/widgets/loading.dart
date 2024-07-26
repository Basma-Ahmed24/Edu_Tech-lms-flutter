import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoading {
  static loading(BuildContext context, {bool changeLoading = false}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: changeLoading
              ? CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )
              : CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
        );
      },
    );
  }
}
