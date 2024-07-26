import 'package:flutter/material.dart';
import 'package:lms_flutter/view/features/init_screens/vpn_checker_screen.dart';
import '../../../helpers/constants/app_images.dart';
import '../../../helpers/constants/app_sizes.dart';
import 'is_real_devices_screen.dart';

class TempSplashScreen extends StatefulWidget {
  final String? message;
  final bool isVpn;
  const TempSplashScreen({
    super.key,
    this.isVpn = false,
    this.message,
  });

  @override
  State<TempSplashScreen> createState() => _TempSplashScreenState();
}

class _TempSplashScreenState extends State<TempSplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        if (widget.isVpn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const VpnCheckerScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  IsRealDeviceScreen(message: widget.message!),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppSize.width(context),
        height: AppSize.height(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.splash,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
