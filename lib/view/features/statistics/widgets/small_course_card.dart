import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';

import '../../../widgets/custom_text.dart';

class SmallCourseCard extends StatelessWidget {
  final int index;

  const SmallCourseCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColorTheme.containerTheme(context),
            boxShadow: [
              BoxShadow(
                color: AppColorTheme.shadowTheme(context),
                spreadRadius: 1,
                blurRadius: 5,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.subMainAppColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomText(
                      text: '0$index',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'كورس الفيزياء',
                        fontSize: 12.sp,
                        color: AppColors.grayTextColor,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'امتحان علي الفيزيا الحديثه',
                            fontSize: 14.sp,
                          ),
                          const SizedBox(width: 5),
                          // CustomText(
                          //   text: '(00.00 / 17.10)',
                          //   fontSize: 11.sp,
                          //   color: AppColors.grayTextColor,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: const BoxDecoration(
              //     color: AppColors.subMainAppColor,
              //     shape: BoxShape.circle,
              //   ),
              //   child: Image.asset(AppImages.playBtn),
              // ),

              Column(
                children: [
                  CustomText(
                    text: 'grade'.tr(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: '$index/20',
                    color: index % 2 == 0 ? Colors.green : Colors.red,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
