import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';

class CustomLinerWidget extends StatelessWidget {
  final String title;
  final double percentage;
  final Color color;

  const CustomLinerWidget({
    Key? key,
    required this.title,
    required this.percentage,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: CustomText(
                text: title,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10.sp),
          SizedBox(
            width: AppSize.width(context) * .12,
            child: CustomText(
              text: '%$percentage',
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 5.sp),
          SizedBox(
            width: 60.sp,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  value: percentage,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
