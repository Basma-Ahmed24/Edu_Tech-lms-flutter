import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';

Widget CourseContentDetails(
    {context,
      String? name,
      String? modulesCount,
      time,
      description,
      img}) {
  return Column(children: [
    // SizedBox(
    //   height: 10.sp,
    // ),
    // CustomText(
    //   text: "${"course_content".tr(context)}",
    //   fontSize: 18.sp,
    //   fontWeight: FontWeight.bold,
    // ),
    // SizedBox(
    //   height: 10.sp,
    // ),
    Container(
      height: AppSize.height(context) / 3.5,
      width: AppSize.width(context),
      decoration: BoxDecoration(
        // borderRadius:  BorderRadius.circular(20),
        // border: Border.all(
        //   color: Colors.white60,
        //   width: 2,
        // ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: Image.network(
          "https://mark2.faheemacademy.online${img}",
          fit: BoxFit.fill,
        ),
      ),
    ),

    Padding(padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: name!,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            isMultiLines: true,
          ),

        ],
      ),
    ),
    Padding(padding:  EdgeInsets.only(left: 10.sp,right: 10.sp),
        child: CustomText(
          text: description,
          fontSize: 12.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          isMultiLines: true,
        )
    ),

    Padding(padding: EdgeInsets.only(left: 10.sp,right: 10.sp),

      child: Column(children: [
        Row(children: [
          CustomText(
            text: " ${"modules".tr(context)}:  ",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            isMultiLines: true,
          ),
          CustomText(
            text: modulesCount!,
            fontSize: 12.sp,
          ),
        ]),
      ]),
    ),
  ]);
}
