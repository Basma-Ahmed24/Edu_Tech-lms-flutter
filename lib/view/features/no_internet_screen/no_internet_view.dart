import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../helpers/constants/app_color_theme.dart';
import '../../../helpers/extensions/tr_extension.dart';
import '../../../helpers/constants/app_images.dart';
import '../../../helpers/constants/app_sizes.dart';
import '../../widgets/custom_text.dart';

class NoInternetScreen extends StatelessWidget {
  final Function callback;

  const NoInternetScreen({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorTheme.bottomNavigationBarTheme(context),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(AppImages.qrcode),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColorTheme.bottomNavigationBarTheme(context),
        notchMargin: 6,
        child: Container(
          padding: EdgeInsets.only(
            bottom: 5.sp,
            top: 5.sp,
            right: 20.w,
            left: 20.w,
          ),
          height: 52.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppSize.width(context) * .35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(AppImages.home,
                                color: AppColorTheme.blackAndWhiteSwitchTheme(
                                    context)),
                            CustomText(
                              text: 'home'.tr(context),
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.sp),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              AppImages.statistics,
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                            ),
                            CustomText(
                              text: 'statistics'.tr(context),
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: AppSize.width(context) * .35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              AppImages.subscriptions,
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                            ),
                            CustomText(
                              text: 'subscriptions'.tr(context),
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.sp),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              AppImages.profile,
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                            ),
                            CustomText(
                              text: 'account'.tr(context),
                              color: AppColorTheme.blackAndWhiteSwitchTheme(
                                  context),
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16.sp),
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.settings,
                      // ignore: deprecated_member_use
                      color: AppColorTheme.blackAndWhiteSwitchTheme(context),
                    ),
                    SvgPicture.asset(
                      AppImages.appLogo2,
                    ),
                    Container(
                      height: 26,
                      width: 26,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/character/c_1.png',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppImages.noSignalnoInternet,
                    height: AppSize.height(context) * .25,
                  ),
                  CustomText(
                    text: 'Please check your internet connection',
                    color: AppColorTheme.blackAndWhiteSwitchTheme(context),
                    fontSize: 12.sp,
                  ),
                  MaterialButton(
                    height: 20.sp,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomText(
                      text: 'Refresh',
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                    onPressed: () {
                      callback();
                    },
                  )
                ],
              ),
              SizedBox(
                height: AppSize.height(context) * .1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
