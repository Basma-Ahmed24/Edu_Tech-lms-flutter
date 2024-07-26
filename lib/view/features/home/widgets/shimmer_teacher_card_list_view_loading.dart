import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/view/features/home/widgets/shimmer_teacher_small_card_widget.dart';

class ShimmerTeacherCardListViewLoading extends StatelessWidget {
  final int itemCount;
  final bool isNoMargin;

  const ShimmerTeacherCardListViewLoading({
    super.key,
    this.itemCount = 5,
    this.isNoMargin = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 12.sp),
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ShimmerTeacherSmallCardWidget(
          isNoMargin: isNoMargin,
        );
      },
    );
  }
}
