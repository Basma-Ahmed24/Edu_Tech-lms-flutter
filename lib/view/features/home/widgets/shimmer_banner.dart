import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/constants/app_images.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../cources/widgets/shimmer_text_widget.dart';

class ShimmerOfferBannerWidget extends StatelessWidget {
  const ShimmerOfferBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        margin: EdgeInsets.only(
          left: 16.sp,
          right: 16.sp,
          bottom: 10.sp,
        ),
        padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
        height: AppSize.height(context) * .13,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerTextWidget(
                  width: 80.sp,
                  height: 6.sp,
                ),
                SizedBox(height: 10.sp),
                ShimmerTextWidget(
                  width: 50.sp,
                  height: 6.sp,
                ),
              ],
            ),
            Image.asset(
              "assets/images/Image.png",

            ),
          ],
        ),
      ),
    );
  }
}