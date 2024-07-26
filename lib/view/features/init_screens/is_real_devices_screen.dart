import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../helpers/constants/app_images.dart';
import '../../../helpers/constants/app_sizes.dart';
import '../../widgets/custom_text.dart';

class IsRealDeviceScreen extends StatelessWidget {
  final String message;
  const IsRealDeviceScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppImages.phoneProtection,
              height: AppSize.height(context) * .5,
            ),
            CustomText(
              text: message,
              isMultiLines: true,
              textAlign: TextAlign.center,
              fontSize: 14.sp,
            ),
            SizedBox(height: 10.sp),
            CustomText(
              text: "to be able to use the app",
              isMultiLines: true,
              textAlign: TextAlign.center,
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
