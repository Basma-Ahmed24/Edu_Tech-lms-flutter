import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final double? width;
  final double? height;
  final double? padding;
  final Color? btnColor;
  final Color? textColor;
  final double? fontSize;
  final Color? borderColor;

  const CustomBtn({
    Key? key,
    this.width,
    this.onTap,
    this.height,
    this.padding,
    this.btnColor,
    this.fontSize,
    this.textColor,
    this.borderColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding ?? 0),
        alignment: Alignment.center,
        width: width,
        height: height ?? 45.sp,
        decoration: BoxDecoration(
          color: btnColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: CustomText(
          text: title,
          fontSize: fontSize,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
