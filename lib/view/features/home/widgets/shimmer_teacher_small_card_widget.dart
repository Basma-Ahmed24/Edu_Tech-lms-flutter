import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/constants/app_sizes.dart';
import '../../cources/widgets/shimmer_text_widget.dart';

class ShimmerTeacherSmallCardWidget extends StatelessWidget {
  final bool isNoMargin;

  const ShimmerTeacherSmallCardWidget({
    Key? key,
    this.isNoMargin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        margin: isNoMargin
            ? const EdgeInsets.all(0)
            : EdgeInsets.only(left: 16.sp, right: 16.sp),
        height: AppSize.height(context) * .13,
        padding: EdgeInsets.symmetric(
          horizontal: 8.sp,
          vertical: 10.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppSize.width(context) * .29,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 100,
                    width: 120,
                  ),
                ),
                SizedBox(width: 10.sp),
                SizedBox(
                  width: AppSize.width(context) * .25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerTextWidget(),
                          SizedBox(height: 10.sp),
                          ShimmerTextWidget(width: 50.sp),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerTextWidget(),
                          SizedBox(height: 10.sp),
                          ShimmerTextWidget(width: 50.sp),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.sp),
            SizedBox(
              width: AppSize.width(context) * .25,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerTextWidget(),
                  ShimmerTextWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
