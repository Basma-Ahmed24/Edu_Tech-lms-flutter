import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../helpers/constants/app_images.dart';
import '../../../helpers/constants/app_sizes.dart';
import '../../widgets/custom_text.dart';

class VpnCheckerScreen extends StatelessWidget {
  const VpnCheckerScreen({
    super.key,
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
              AppImages.vpnProtection,
              height: AppSize.height(context) * .25,
            ),
            SizedBox(height: 20.sp),
            const CustomText(
              text: 'You are connecting via a VPN',
              isMultiLines: true,
              textAlign: TextAlign.center,
              fontSize: 14,
            ),
            SizedBox(height: 10.sp),
            CustomText(
              text: "Close it to be able to use the app.",
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
