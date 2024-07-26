import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/router/app_name_route.dart';

import '../../../../helpers/constants/app_current_lang.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../widgets/custom_text.dart';


class DrawerScreensAppBar extends StatelessWidget {
  final String title;

  const DrawerScreensAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
        BlocBuilder<SaveItCubit, SaveItState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                AppNameRoute.controllerScreen.goAndReplaceAll(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                textDirection: AppCurrentLang.isEn(context)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                size: 20.sp,
              ),
            );
          },
        ),
      ],
    );
  }
}
