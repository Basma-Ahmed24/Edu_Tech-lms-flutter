import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Color? color;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final bool isUserLine;
  final bool isMultiLines;

  const CustomText({
    Key? key,
    this.color,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.height,
    this.isUserLine = false,
    this.isMultiLines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: isMultiLines ? null : maxLines ?? 1,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        overflow: isMultiLines ? null : TextOverflow.ellipsis,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: isUserLine ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
