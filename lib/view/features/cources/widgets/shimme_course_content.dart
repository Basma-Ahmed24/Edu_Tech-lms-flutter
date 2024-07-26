import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/view/features/cources/widgets/shimmer_text_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';

class ShimmerCourseContent extends StatelessWidget {
  const ShimmerCourseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!video
            Container(
              width: AppSize.width(context),
              height: AppSize.height(context) * .25,
              color: Colors.white,
            ),
            SizedBox(height: 10.sp),
            //!lesson info

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .3,
                    ),
                    SizedBox(height: 5.sp),
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .2,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .3,
                    ),
                    SizedBox(height: 8.sp)
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            //!techer info

            Row(
              children: [
                const CircleAvatar(),
                SizedBox(width: 10.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .2,
                      height: 5.sp,
                    ),
                    SizedBox(height: 5.sp),
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .15,
                      height: 5.sp,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.sp),
            //!course details

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerTextWidget(
                  width: AppSize.width(context) * .45,
                ),
                SizedBox(height: 10.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .25,
                ),
                SizedBox(height: 10.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .2,
                ),
                SizedBox(height: 10.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .25,
                ),
                SizedBox(height: 10.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .2,
                ),
                SizedBox(height: 10.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .3,
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            //!line
            const ShimmerTextWidget(height: 2),
            SizedBox(height: 10.sp),
            //! title

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerTextWidget(
                  width: AppSize.width(context) * .25,
                  height: 30.sp,
                ),
                SizedBox(width: 5.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .25,
                  height: 30.sp,
                ),
                SizedBox(width: 5.sp),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .25,
                  height: 30.sp,
                ),
                // SizedBox(width: 5.sp),
                // ShimmerTextWidget(
                //   width: AppSize.width(context) * .2,
                //   height: 30.sp,
                // ),
              ],
            ),
            SizedBox(height: 12.sp),
            //! course lessons
            const LessonContainerCard(),
            SizedBox(height: 12.sp),
            const LessonContainerCard(),
            SizedBox(height: 12.sp),
            const LessonContainerCard(),
          ],
        ),
      ),
    );
  }
}

class LessonContainerCard extends StatelessWidget {
  final bool isNotCircle;

  const LessonContainerCard({
    super.key,
    this.isNotCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: AppSize.width(context),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40.sp,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const CustomText(text: ''),
                ),
                SizedBox(width: 8.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .2,
                    ),
                    SizedBox(height: 8.sp),
                    ShimmerTextWidget(
                      width: AppSize.width(context) * .15,
                      height: 5.sp,
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                ShimmerTextWidget(
                  width: AppSize.width(context) * .15,
                  height: 5.sp,
                ),
                SizedBox(width: 10.sp),
                isNotCircle ? Container() : const CircleAvatar(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
