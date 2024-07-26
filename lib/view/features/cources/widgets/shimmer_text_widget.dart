import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerTextWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const ShimmerTextWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color ?? Colors.white,
      ),
      height: height ?? 8.sp,
      width: width,
    );
  }
}
