import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/statistics/widgets/statistics_tap_container.dart';

class StatisticsTwoTapContainer extends StatelessWidget {
  const StatisticsTwoTapContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
      height: 30.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatisticsTapContainer(
            title: 'exams'.tr(context),
            index: 1,
          ),
          SizedBox(width: 10.sp),
          StatisticsTapContainer(
            title: 'notifications'.tr(context),
            index: 2,
          ),
          SizedBox(width: 10.sp),
          StatisticsTapContainer(
            title: 'homework'.tr(context),
            index: 3,
          ),
        ],
      ),
    );
  }
}
