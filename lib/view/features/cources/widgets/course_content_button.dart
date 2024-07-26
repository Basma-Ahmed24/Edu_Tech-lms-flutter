import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';

Widget CourseContentButton(
        {int? selectedContainerIndex,
        String? title,
        context,
        Function? function,
        int? value,double? height,double? width}) =>
    GestureDetector(
      onTap: () {
        function!();
      },
      child: Container(
        height: height,
        width: AppSize.width(context) / width,
        decoration: selectedContainerIndex != value?  BoxDecoration(
          border: Border.all(
            color: AppColors.mainAppColor,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            // selectedContainerIndex == value
            //     ?

          image:
        DecorationImage(image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),
            fit: BoxFit.fill, // Set the BoxFit.fill property
          ),
              // : AppColors.mainAppColor,
        ):
        BoxDecoration(
          border: Border.all(
            color: AppColors.mainAppColor,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          // selectedContainerIndex == value
          //     ? color: Colors.white

            color: Colors.white
          // : AppColors.mainAppColor,
        ),
        child: Center(
          child: CustomText(
            text: title!,
            color: selectedContainerIndex == value
                ? AppColors.mainAppColor
                : Colors.white,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
