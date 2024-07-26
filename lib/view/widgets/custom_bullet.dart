import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/constants/app_color_theme.dart';
import 'custom_text.dart';

class MyBullet extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? circleSized;
  final double? widthBetween;
  final int? maxLines;

  const MyBullet({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.circleSized,
    this.widthBetween,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: circleSized ?? 4.sp,
          width: circleSized ?? 4.sp,
          decoration: BoxDecoration(
            color: color ?? AppColorTheme.blackAndWhiteSwitchTheme(context),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: widthBetween ?? 10.sp),
        CustomText(
          text: text,
          color: color,
          fontSize: fontSize ?? 12.sp,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
