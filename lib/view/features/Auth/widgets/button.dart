import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/constants/app_sizes.dart';

final formkey = GlobalKey<FormState>();
Widget CustomButton(Function function, context, Widget child) => ElevatedButton(
      onPressed: () {
        function(context);
      },
      child: child,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        fixedSize: Size(AppSize.width(context) / 1.5, 49),
        backgroundColor: AppColors.mainAppColor,
      ),
    );
