import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';


import '../../../../helpers/constants/app_sizes.dart';
import '../widgets/custom_lang_row_card.dart';
import '../widgets/drawer_screens_app_bar.dart';

class ChangeLangView extends StatefulWidget {
  const ChangeLangView({super.key});

  @override
  State<ChangeLangView> createState() => _ChangeLangViewState();
}

class _ChangeLangViewState extends State<ChangeLangView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.sp),
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: Column(
            children: [
              DrawerScreensAppBar(title: 'language_appBar'.tr(context)),
              SizedBox(height: 10.sp),
              const Divider(thickness: 2),
              SizedBox(height: 20.sp),
              CustomLangRowCard(
                title: 'languageE'.tr(context),
                value: 'en',
              ),
              SizedBox(height: 10.sp),
              CustomLangRowCard(
                title: 'languageA'.tr(context),
                value: 'ar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
