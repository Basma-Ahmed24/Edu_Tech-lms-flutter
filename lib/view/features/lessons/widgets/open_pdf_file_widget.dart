import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/constants/app_color_theme.dart';

class OpenPdfFile extends StatelessWidget {
  final void Function()? onTap;

  const OpenPdfFile({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: AppColorTheme.scaffoldTheme(context),
            boxShadow: [
              BoxShadow(
                color: AppColorTheme.shadowTheme(context),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColorTheme.bestSellerBgColorTheme(context),
            )),
        child: SizedBox(
          height: 18.sp,
          child: Row(
            children: [

              Icon(
                Icons.visibility,
                color: Theme.of(context).primaryColor,
                size: 12.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
